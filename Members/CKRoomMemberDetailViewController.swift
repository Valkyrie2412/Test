//
//  CKRoomMemberDetailViewController.swift
//  Riot
//
//  Created by Hiếu Nguyễn on 1/22/19.
//  Copyright © 2019 matrix.org. All rights reserved.
//

import UIKit

class CKRoomMemberDetailViewController: MXKViewController {
    
    // MARK: - OUTLET
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - ENUM
    
    private enum Section: Int {
        case avatar  = 0
        case action  = 1
        case detail  = 2
        
        static var count: Int { return 3}
    }
    
    // MARK: - CLASS
    
    class func instance() -> CKRoomMemberDetailViewController {
        let instance = CKRoomMemberDetailViewController(nibName: self.nibName, bundle: nil)
        return instance
    }
    
    class func instanceForNavigationController(completion: ((_ instance: CKRoomMemberDetailViewController) -> Void)?) -> UINavigationController {
        let vc = self.instance()
        completion?(vc)
        return UINavigationController.init(rootViewController: vc)
    }
    
    // MARK: - PROPERTY
    
    /**
     MX Room
     */
    public var mxRoom: MXRoom!
    
    private var request: MXHTTPOperation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.finalizeLoadView()
    }
    deinit {
        if request != nil {
            request.cancel()
            request = nil
        }
    }
    
    // MARK: - PRIVATE
    
    private func finalizeLoadView() {
        
        // register cells
        self.tableView.register(CKRoomMemberAvatarCell.nib, forCellReuseIdentifier: CKRoomMemberAvatarCell.identifier)
        self.tableView.register(CKRoomMemberActionCell.nib, forCellReuseIdentifier: CKRoomMemberActionCell.identifier)
        self.tableView.register(CKRoomMemberInfoCell.nib, forCellReuseIdentifier: CKRoomMemberInfoCell.identifier)
        self.tableView.allowsSelection = false
        
        // Setup back button item
        let backItemButton = UIBarButtonItem.init(image: UIImage(named: "ic_room_member_arrow"), style: .plain, target: self, action: #selector(clickedOnBackButton(_:)))
        
        // assign back button
        self.navigationItem.leftBarButtonItem = backItemButton
    }
    
    private func cellForAvatarMember(atIndexPath indexPath: IndexPath) -> CKRoomMemberAvatarCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CKRoomMemberAvatarCell.identifier, for: indexPath) as? CKRoomMemberAvatarCell {
            
            if let contact = MXKContactManager.shared()?.matrixContacts[indexPath.row] as? MXKContact {
                
                // display name
                cell.nameLabel.text = contact.displayName
                
                // avatar
                if let avtURL = self.mainSession.matrixRestClient.url(ofContent: contact.matrixAvatarURL) {
                    cell.setAvatarImageUrl(urlString: avtURL, previewImage: nil)
                } else {
                    cell.avaImage.image = AvatarGenerator.generateAvatar(forText: contact.displayName)
                }
            
                // status
                let session = AppDelegate.the()?.mxSessions.first as? MXSession
                if let myUser = session?.myUser {
                    switch myUser.presence {
                    case MXPresenceOnline:
                        cell.settingStatus(online: true)
                    default:
                        cell.settingStatus(online: false)
                    }
                }
            }
            return cell
        }
        return CKRoomMemberAvatarCell()
    }
    
    private func cellForAction(atIndexPath indexPath: IndexPath) -> CKRoomMemberActionCell {
        
        // dequeue cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CKRoomMemberActionCell.identifier,
            for: indexPath) as? CKRoomMemberActionCell
        
        return cell!
    }
    
    private func cellForInfoMember(atIndexPath indexPath: IndexPath) -> CKRoomMemberInfoCell {
        
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: CKRoomMemberInfoCell.identifier,
            for: indexPath) as? CKRoomMemberInfoCell {
            
            if let contact = MXKContactManager.shared()?.matrixContacts[indexPath.row] as? MXKContact {
                
                // Title
                cell.titleLabel.font = CKAppTheme.mainLightAppFont(size: 15)
                cell.titleLabel.textColor = #colorLiteral(red: 0.4352941176, green: 0.431372549, blue: 0.4509803922, alpha: 1)
                cell.titleLabel.text = "Display name"
                
                // display name
                cell.contentLabel.text = contact.displayName
            }
            return cell
        }
        return CKRoomMemberInfoCell()
    }
    
    // MARK: - ACTION
    
    @objc func clickedOnBackButton(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func titleForHeader(atSection section: Int) -> String {
        guard let section = Section(rawValue: section) else { return ""}
        
        switch section {
        case .avatar:
            return ""
        case .action:
            return ""
        case .detail:
            return ""
        }
    }
}

// MARK: - UITableViewDelegate

extension CKRoomMemberDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Section(rawValue: indexPath.section) else { return 0}
        switch section {
        case .avatar:
            return 300
            
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
}

// MARK: - UITableViewDataSource

extension CKRoomMemberDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // sure to work
        guard let section = Section(rawValue: section) else { return 0 }
        
        // number rows in case
        switch section {
        case .avatar: return 1
        case .action: return 1
        case .detail: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // sure to work
        guard let section = Section(rawValue: indexPath.section) else { return CKRoomMemberBaseCell() }
        
        switch section {
        case .avatar:
            
            // room member avatar cell
            return cellForAvatarMember(atIndexPath: indexPath)
        case .action:
            
            // room member action cell
            return cellForAction(atIndexPath: indexPath)
        case .detail:
            
            // room member info cell
            return cellForInfoMember(atIndexPath: indexPath)
        }
    }
    
}

