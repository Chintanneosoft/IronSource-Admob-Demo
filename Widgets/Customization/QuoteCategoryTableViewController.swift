import UIKit
import CoreData

protocol QuoteCategoryTableDelegate {
    func quotesSelectionUpdate(_ quotes: [[String:String]])
}

class QuoteCategoryTableViewController: BottomPopupViewController,UITableViewDelegate,UITableViewDataSource,BottomPopupDelegate {

    var quoteCategoryList = [String]()
    var quoteAutherList = [String]()

    @IBOutlet var tableView : UITableView? = nil
    @IBOutlet var topicBtn : UIButton? = nil
    @IBOutlet var autherBtn : UIButton? = nil

    var delegate:QuoteCategoryTableDelegate?
    var selectedQuotes:[[String:String]] = []
    let context = CoreDataStorage.mainQueueContext()
    var widget: WidgetCollection?

    override func viewDidLoad() {
        super.viewDidLoad()

        let quotesString = widget?.quotes ?? ""
        selectedQuotes = quotesString.array() as! [[String:String]]
        
//        topicBtn?.tintColor = UIColor.white
//        autherBtn?.tintColor = UIColor.white
        
        let selectedCheckbox = UIImage(named: "selected_checkbox")
//        selectedCheckbox = selectedCheckbox?.withRenderingMode(.alwaysOriginal)
//        selectedCheckbox = selectedCheckbox?.withTint(.white)
        
        let checkbox = UIImage(named: "checkbox")
//        checkbox = checkbox?.withRenderingMode(.alwaysTemplate)
//        checkbox = checkbox?.withTint(.white)
        
        topicBtn?.setImage(checkbox, for: .normal)
        topicBtn?.setImage(selectedCheckbox, for: .selected)

        autherBtn?.setImage(checkbox, for: .normal)
        autherBtn?.setImage(selectedCheckbox, for: .selected)
        
        let isAnyOptionSelected = UserDefaults.standard.bool(forKey: "isAnyOptionSelected")
        
        if isAnyOptionSelected == true{
            let optionSelected = UserDefaults.standard.string(forKey: "optionSelected")
            
            if optionSelected == "topics"{
                quoteTopicsSelected()
            }
            else{
                quoteAutherSelected()
            }
        }
        else{
            quoteTopicsSelected()
        }
        
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "LabelCell")
    }

    @IBAction func topicsBtnTapped(){
        quoteTopicsSelected()
    }
    
    func quoteTopicsSelected() {
        topicBtn?.isSelected = true
        autherBtn?.isSelected = false
        if let quotesDefaultlist = UserDefaults.standard.object(forKey: "quoteCategoryList") as? [String]{
            quoteCategoryList = quotesDefaultlist
        }
        else{
            quoteCategoryList = ["ABILITY","ACHIEVEMENT","ADVERTISING","ADVICE","AMBITION","ANIMALS","APPEARANCE","ARGUMENT","ARMY","BIBLE","BIOGRAPHY","BODY","BOREDOM","CHARITY","CHRISTIANS","CHURCHES","CITIES","CIVILIZATION","COLLEGES","COMMITMENT","COMMON SENSE","COMMUNICATION","COMMUNISM","COMPETITION","COMPLAINTS","CONCENTRATION","CONFIDENCE","CONFLICT","CONSCIENCE","CONTENTMENT","CONTROL","CONVERSATION","COOPERATION","CREATIVITY","CRIMINALS","CULTURE","DANGER","DEBT","DECISIONS","DEMOCRACY","DESTINY","DIFFICULTIES","DISCIPLINE","DOCTORS","DOUBT","DRESS","DRUGS","DUTY","ECONOMY","EFFORT","ELECTIONS","ENEMIES","ENJOYMENT","ENTHUSIASM","EQUALITY","EVIL","EXPECTATION","FACES","FACTS","FAMILY","FASHION","FATE","FAULTS","FEMINISM","FICTION","FOCUS","FOOD","FOOLISHNESS","FOOLS","FORGIVENESS","FUTURE","GOODNESS","GOSSIP","GRATITUDE","GREATNESS","GROWTH","HABIT","HATRED","HEALTH","HEART","HEAVEN","HEROES","HISTORY","HOLLYWOOD","HOME","HONESTY","HONOR","HOPE","HUMILITY","HUMOR","IDEALS","IGNORANCE","INDIVIDUALITY","INFLUENCE","INTEGRITY","INTELLECTUALS","INTELLIGENCE","JESUS CHRIST","JOURNALISTS","JOY","JUDGMENT","JUSTICE","KINDNESS","LAUGHTER","LIBERTY","LIES","LISTENING","LONELINESS","LOSING","LUCK","LYING","MANAGEMENT","MANNERS","MEDIA","MEDICINE","MENS","MODERN","MODESTY","MORALITY","MOTHERS","MOTIVATION","NATIONS","NATURE","OBSTACLES","OPTIMISM","ORIGINALITY","PAIN","PARENTS","PASSION","PAST","PATIENCE","PATRIOTISM","PERFECTION","PERSUASION","PLANNING","PLEASURE","POSSIBILITIES","POTENTIAL","PRAISE","PRAYER","PREJUDICE","PRESENT","PRIDE","PROBLEMS","PROCRASTINATION","PROGRESS","PUNISHMENT","QUALITY","QUESTIONS","QUOTATIONS","REALITY","REASON","RELATIONSHIPS","RELIGION","REPUTATION","RESPECTABILITY","RESPONSIBILITY","REVOLUTIONS","RICHES","SECRETS","SELF-ESTEEM","SELF-KNOWLEDGE","SELF-LOVE","SEX","SILENCE","SIMPLICITY","SIN","SMILE","SOCIETY","SOLITUDE","SORROW","SOUL","SPEECH","SPIRITUALITY","SUFFERING","TALENT","TASTE","TAXES","TEACHERS","TEAM","TELEVISION","THEATER","TRUST","UNDERSTANDING","VALUE","VICTORY","VIRTUE","VISION","WAR","WEALTH","WIL","WINNING","WIVES","WORLD","WORRY"];
            
            let defaults = UserDefaults(suiteName: Constants.appGroupId)

            defaults?.set(quoteCategoryList, forKey: "quoteCategoryList")
            defaults?.synchronize()
        }
        tableView?.reloadData()
    }
    
    @IBAction func autherBtnTapped(){
        quoteAutherSelected()
    }
    
    func quoteAutherSelected() {
        autherBtn?.isSelected = true
        topicBtn?.isSelected = false
        if let autherlist = UserDefaults.standard.object(forKey: "quoteAutherList") as? [String]{
            quoteAutherList = autherlist
        }
        else{
            quoteAutherList = ["FRANCIS BACON","AMBROSE BIERCE","LORD GEORGE BYRON","THOMAS CARLYLE","GILBERT K. CHESTERTON","WINSTON CHURCHILL","MARCUS TULLIUS CICERO","BENJAMIN DISRAELI","ALBERT EINSTEIN","GEORGE ELIOT","RALPH WALDO EMERSON","BENJAMIN FRANKLIN","JOHANN WOLFGANG VON GOETHE","WILLIAM HAZLITT","OLIVER WENDELL HOLMES","ALDOUS HUXLEY","SAMUEL JOHNSON","ABRAHAM LINCOLN","HENRY LOUIS MENCKEN","FRIEDRICH NIETZSCHE","GEORGE ORWELL","ALEXANDER POPE","FRANCOIS DE LA ROCHEFOUCAULD","JOHN RUSKIN","SENECA","WILLIAM SHAKESPEARE","GEORGE BERNARD SHAW","HENRY DAVID THOREAU","MARK TWAIN","OSCAR WILDE"]
            
            let defaults = UserDefaults(suiteName: Constants.appGroupId)

            defaults?.set(quoteAutherList, forKey: "quoteAutherList")
            defaults?.synchronize()
        }
        
        tableView?.reloadData()
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if topicBtn?.isSelected == true{
            return quoteCategoryList.count
        }
        return quoteAutherList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)

        if topicBtn?.isSelected == true{
            let category = quoteCategoryList[indexPath.row]
            cell.textLabel?.text = category
            cell.accessoryType = .none

            if selectedQuotes.contains(where: {$0["type"] == "category" && $0["value"]  == category}) == true{
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }
        }
        else{
            let auther = quoteAutherList[indexPath.row]
            cell.textLabel?.text = auther
            
            if selectedQuotes.contains(where: {$0["type"]  == "auther" && $0["value"]   == auther}) == true{
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if topicBtn?.isSelected == true{
            let category = quoteCategoryList[indexPath.row]
            let data = ["type" : "category" , "value" : category]
            
            if selectedQuotes.contains(data) == true{
                selectedQuotes.removeAll(where: {$0["type"]  == "category" && $0["value"]  == category})
            }
            else{
                selectedQuotes.append(data)
            }
        }
        else{
            let auther = quoteAutherList[indexPath.row]
            let data = ["type" : "auther" , "value" : auther]
            
            if selectedQuotes.contains(data) == true{
                selectedQuotes.removeAll(where: {$0["type"]  == "auther" && $0["value"]  == auther})
            }
            else{
                selectedQuotes.append(data)
            }
        }
        
        tableView.reloadData()
    }

    @IBAction func settingBtnClicked(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let makeStyleView = storyboard.instantiateViewController(withIdentifier: "ManagePurchaseViewController") as? ManagePurchaseViewController
        dismissMe()
    }
    
    @IBAction func doneBtnClicked(){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let makeStyleView = storyboard.instantiateViewController(withIdentifier: "MakeStyleViewController") as? MakeStyleViewController
//        self.navigationController?.pushViewController(makeStyleView!, animated: true)

        let jsonString = selectedQuotes.json()
        widget?.quotes = jsonString
//        let defaults = UserDefaults(suiteName: Constants.appGroupId)
//
//        defaults?.set(selectedQuotes, forKey: "selectedQuotes")
//        defaults?.synchronize()
        
        dismissMe()
        
        delegate?.quotesSelectionUpdate(selectedQuotes)
    }
}
