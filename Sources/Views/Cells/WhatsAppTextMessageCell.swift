//
//  WhatsAppTextMessageCell.swift
//  InputBarAccessoryView
//
//  Created by Jalal Awqati on 4/30/20.
//

import UIKit

/// A subclass of `MessageContentCell` used to display text messages.
open class WhatsAppTextMessageCell: MessageContentCell {

    // MARK: - Properties

    /// The `MessageCellDelegate` for the cell.
    open override weak var delegate: MessageCellDelegate? {
        didSet {
            messageLabel.delegate = delegate
        }
    }

    /// The label used to display the message's text.
    open var messageLabel = MessageLabel()
    
    ///The label used to display the message's time
    open var messageTimeLabel = MessageLabel()

    // MARK: - Methods

    open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? MessagesCollectionViewLayoutAttributes {
            messageLabel.textInsets = attributes.messageLabelInsets
            messageLabel.messageLabelFont = attributes.messageLabelFont
            messageLabel.frame = messageContainerView.bounds
            messageLabel.frame.size.height /= 2
            //messageLabel.backgroundColor = .systemPink
            
            messageTimeLabel.textInsets.right = attributes.messageLabelInsets.right + 4
            messageTimeLabel.textInsets.bottom = 0
            messageTimeLabel.textInsets.top = 5
            messageTimeLabel.font = UIFont.systemFont(ofSize: 12)
            //messageTimeLabel.backgroundColor = .cyan
            
            messageTimeLabel.frame = CGRect(x: 0, y: messageLabel.frame.size.height, width: messageLabel.frame.size.width, height: 20)
            messageTimeLabel.text = "17:25"
            messageTimeLabel.textAlignment = .right
        }
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.attributedText = nil
        messageLabel.text = nil
        messageTimeLabel.text = nil
    }

    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(messageLabel)
        messageContainerView.addSubview(messageTimeLabel)
    }

    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)

        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }

        let enabledDetectors = displayDelegate.enabledDetectors(for: message, at: indexPath, in: messagesCollectionView)

        messageLabel.configure {
            messageLabel.enabledDetectors = enabledDetectors
            for detector in enabledDetectors {
                let attributes = displayDelegate.detectorAttributes(for: detector, and: message, at: indexPath)
                messageLabel.setAttributes(attributes, detector: detector)
            }
            
            switch message.kind {
            case .custom(let object):
                if let text = object as? String {
                    let textColor = displayDelegate.textColor(for: message, at: indexPath, in: messagesCollectionView)
                    messageLabel.text = text
                    messageLabel.textColor = textColor
                    
                    if let font = messageLabel.messageLabelFont {
                        messageLabel.font = font
                    }
                }
            default:
                break
            }
        }
    }
    
    /// Used to handle the cell's contentView's tap gesture.
    /// Return false when the contentView does not need to handle the gesture.
    open override func cellContentView(canHandle touchPoint: CGPoint) -> Bool {
        return messageLabel.handleGesture(touchPoint)
    }

}

