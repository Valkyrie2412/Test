//
//  CKRoomMemberAvatarCell.swift
//  Riot
//
//  Created by Hiếu Nguyễn on 1/22/19.
//  Copyright © 2019 matrix.org. All rights reserved.
//

import UIKit

class CKRoomMemberAvatarCell: CKRoomMemberBaseCell {

    // MARK: - OUTLET

    @IBOutlet weak var avaImage: MXKImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    // MARK: - OVERRIDE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        statusView.layer.cornerRadius = self.statusView.bounds.width / 2
        statusView.layer.borderWidth = 1
        statusView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - PUBLIC
    public func setAvatarImageUrl(urlString: String, previewImage: UIImage?)  {
        avaImage.enableInMemoryCache = true
        avaImage.setImageURL(
            urlString, withType: nil,
            andImageOrientation: UIImageOrientation.up,
            previewImage: previewImage)
    }
    
   public func settingStatus(online: Bool)  {
        if online == true {
            statusView.backgroundColor = CKColor.Misc.primaryGreenColor
        } else {
            statusView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }

}
