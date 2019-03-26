//
//  CKRoomMemberActionCell.swift
//  Riot
//
//  Created by Hiếu Nguyễn on 1/22/19.
//  Copyright © 2019 matrix.org. All rights reserved.
//

import UIKit

class CKRoomMemberActionCell: CKRoomMemberBaseCell {

    // MARK: - OUTLET
    
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var customButton: UIButton!
    
    
    // MARK: - PROPERTY
    
    /**
     MessageHandler
     */
    internal var MessageHandler: (() -> Void)?
    
    /**
     CallHandler
     */
    internal var CallHandler: (() -> Void)?
    
    /**
     CustomHandler
     */
    internal var CustomHandler: (() -> Void)?
    
    // MARK: - OVERRIDE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.messageButton.addTarget(self, action: #selector(onClickedMessageButton(_:)), for: .touchUpInside)
        self.callButton.addTarget(self, action: #selector(onClickedCallButton(_:)), for: .touchUpInside)
        self.customButton.addTarget(self, action: #selector(onClickedCustomButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - ACTION
    
    @objc func onClickedMessageButton(_ sender: Any) {
        MessageHandler?()
    }
    
    @objc func onClickedCallButton(_ sender: Any) {
        CallHandler?()
    }
    
    @objc func onClickedCustomButton(_ sender: Any) {
        CustomHandler?()
    }
    
    

    
}
