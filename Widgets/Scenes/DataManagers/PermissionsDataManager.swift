//
//  PermissionsDataManager.swift
//  Template_Onboarding
//
//  Created by Pedro Muñoz Cabrera on 08/03/2021.
//

import Permission

public typealias VoidClosure = () -> Void
public typealias UIImageClosure = (UIImage) -> Void
public typealias BoolClosure = (Bool) -> Void

public class PermissionsDataManager {
    
    static let shared = PermissionsDataManager()

    public init() { }

    public func requestPermission(_ permissionType: PermissionType,
                                  completion: @escaping (PermissionType.Status) -> Void) {
        permissionType.permissionValue.request { status in
            completion(status.permissionTypeStatus)
        }
    }

    public func verifyPermission(_ permissionType: PermissionType) -> PermissionType.Status {
        return permissionType.permissionValue.status.permissionTypeStatus
    }
    
    public func requestNotificationsPermission(granted: VoidClosure? = nil, denied: VoidClosure? = nil, passed: VoidClosure? = nil) {
        requestPermission(.notifications, completion: { status in
            if status == .authorized {
                UIApplication.shared.registerForRemoteNotifications()
                granted?()
            } else {
                denied?()
            }
            
            passed?()
        })
    }
}

private extension PermissionType {

    var permissionValue: Permission {
        switch self {
        case .notifications:
            return .notifications
        }
    }
}

private extension PermissionStatus {

    var permissionTypeStatus: PermissionType.Status {
        switch self {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .notDetermined
        default:
            return .denied
        }
    }
}

public enum PermissionType {
    case notifications

    public enum Status {
        case authorized
        case notDetermined
        case denied
    }
}
