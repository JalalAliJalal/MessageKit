//
//  WhatsAppCell.swift
//  ChatExample
//
//  Created by Jalal Awqati on 4/29/20.
//  Copyright © 2020 MessageKit. All rights reserved.
//

import UIKit
import MessageKit

open class WhatsAppCell: MessageContentCell {
    let lblTime = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    open override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubview(lblTime)
        lblTime.textAlignment = .right
        lblTime.font = UIFont.systemFont(ofSize: 12)
        lblTime.text = "17:25"
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        lblTime.frame = CGRect(x: 0, y: contentView.bounds.size.height - 20, width: contentView.bounds.size.width, height: 20)
    }
}
