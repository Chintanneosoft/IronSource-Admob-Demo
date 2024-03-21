//
//  SearchController.swift
//  Flickr-Search
//
//  Created by Anand Nimje on 04/07/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import UIKit

class ImageSearchController: UIViewController, AlertMessage {
    
    fileprivate let downloadQueue = DispatchQueue(label: "Images cache", qos: DispatchQoS.background)
    @IBOutlet weak var searchBar: UISearchBar!
//    {
//        didSet{
//            searchBar.becomeFirstResponder()
//        }
//    }
    @IBOutlet weak var collectionResult: UICollectionView!
    @IBOutlet weak var labelLoading: UILabel!
    fileprivate var searchPhotos = [Photo]()
    fileprivate let router = Router()
    fileprivate var pageCount = 0
    fileprivate let imageProvider = ImageProvider()
    var delegate: BackgroundsViewDelegate?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = "Nature"
        fetchSearchImages()
    }
    
    //MARK: - Request search text
    func fetchSearchImages(){
        pageCount+=1   //Count increment here
        
        router.requestFor(text: searchBar.text ?? "", with: pageCount.description, decode: { json -> Photos? in
            guard let flickerResult = json as? Photos else { return  nil }
            return flickerResult
        }) { [unowned self] result in
            DispatchQueue.main.async {
                self.labelLoading.text = ""
                switch result{
                case .success(let value):
                    self.updateSearchResult(with: value.photos.photo)
                case .failure(let error):
                    print(error.debugDescription)
                    guard self.router.requestCancelStatus == false else { return }
                    self.showAlertWithError((error?.localizedDescription) ?? "Please check your Internet connection or try again.", completionHandler: {[unowned self] status in
                        guard status else { return }
                        self.fetchSearchImages()
                    })
                }
            }
        }
    }
    
    //MARK: - Handle response result
    func updateSearchResult(with photo: [Photo]){
        DispatchQueue.main.async { [unowned self] in
            let newItems = photo
            
            // update data source
            self.searchPhotos.append(contentsOf: newItems)
            
            //Reloading Collection view Data
            self.collectionResult.reloadData()
        }
    }
}

//MARK: - SearchBar Delegate
extension ImageSearchController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        
        //Reset old data first befor new search Results
        resetValuesForNewSearch()
        
        guard let text = searchBar.text?.removeSpace,
            text.count != 0  else {
                labelLoading.text = "Please type keyword to search result."
                return
        }
        
        //Requesting here new keyword
        fetchSearchImages()
        
        labelLoading.text = "Searching Images..."
    }
    
    //MARK: - Clearing here old data search results with current running tasks
    func resetValuesForNewSearch(){
        pageCount = 0
        router.cancelTask()
        searchPhotos.removeAll()
        collectionResult.reloadData()
    }
}

//MARK: - Collection View DataSource
extension ImageSearchController: UICollectionViewDataSource, RequestImages{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return searchPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickerPhotoCell", for: indexPath) as! FlickerPhotoCell
        guard searchPhotos.count != 0 else {
            return cell
        }
        let model = searchPhotos[indexPath.row]
        guard let mediaUrl = model.getImagePath() else {
            return cell
        }
        let image = imageProvider.cache.object(forKey: mediaUrl as NSURL)
        cell.imageResult.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.imageResult.image = image
        if image == nil {
            imageProvider.requestImage(from :mediaUrl, completion: { (image) -> Void in
                let indexPath_ = collectionView.indexPath(for: cell)
                if indexPath == indexPath_ {
                    cell.imageResult.image = image
                }
            })
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FlickerPhotoCell

        if let image = cell.imageResult.image{
            delegate?.backgroundSelected(image)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ImageSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width;
        var itemWidth = collectionWidth / 3 - 1;
        
        if(UIDevice.current.userInterfaceIdiom == .pad) {
            itemWidth = collectionWidth / 4 - 1;
        }
        return CGSize(width: itemWidth, height: itemWidth);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

//MARK: - Scrollview Delegate
extension ImageSearchController: UIScrollViewDelegate {
    
    //MARK :- Getting user scroll down event here
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionResult{
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height)){
                
                //Start locading new data from here
                fetchSearchImages()
            }
        }
    }
}
