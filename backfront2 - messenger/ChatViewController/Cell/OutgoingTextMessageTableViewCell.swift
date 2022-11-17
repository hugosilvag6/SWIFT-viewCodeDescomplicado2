//
//  OutgoingTextMessageTableViewCell.swift
//  backfront2 - messenger
//
//  Created by Hugo Silva on 17/11/22.
//

import UIKit

class OutgoingTextMessageTableViewCell: UITableViewCell {
   
   static let identifier = "OutgoingTextMessageTableViewCell"
   
   lazy var myMessage: UIView = {
      let bv = UIView()
      bv.translatesAutoresizingMaskIntoConstraints = false
      bv.backgroundColor = CustomColor.appPurple
      bv.layer.cornerRadius = 20
      bv.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
      return bv
   }()
   
   lazy var messageTextLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.numberOfLines = 0
      label.textColor = .white
      label.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
      return label
   }()
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      self.addViews()
      self.addConstraints()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}

extension OutgoingTextMessageTableViewCell {
   public func setupCell(message: Message?) {
      self.messageTextLabel.text = message?.texto
   }
}

extension OutgoingTextMessageTableViewCell {
   func addViews() {
      self.addSubview(self.myMessage)
      self.myMessage.addSubview(self.messageTextLabel)
      self.isSelected = false
   }
   func addConstraints () {
      NSLayoutConstraint.activate([
         self.myMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
         self.myMessage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
         self.myMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
         
         self.messageTextLabel.leadingAnchor.constraint(equalTo: self.myMessage.leadingAnchor, constant: 15),
         self.messageTextLabel.topAnchor.constraint(equalTo: self.myMessage.topAnchor, constant: 15),
         self.messageTextLabel.bottomAnchor.constraint(equalTo: self.myMessage.bottomAnchor, constant: -15),
         self.messageTextLabel.trailingAnchor.constraint(equalTo: self.myMessage.trailingAnchor, constant: -15)
      ])
   }
}

