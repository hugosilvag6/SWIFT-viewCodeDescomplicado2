//
//  LastMessageCollectionViewCell.swift
//  backfront2 - messenger
//
//  Created by Hugo Silva on 16/11/22.
//

import UIKit

class LastMessageCollectionViewCell: UICollectionViewCell {
   
   static let identifier = "LastMessageCollectionViewCell"
   
   lazy var imageView: UIImageView = {
      let img = UIImageView()
      img.translatesAutoresizingMaskIntoConstraints = false
      img.contentMode = .scaleAspectFit
      img.clipsToBounds = false
      img.image = UIImage(systemName: "person.badge.plus")
      return img
   }()
   
   lazy var userName: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.text = "Adicionar novo contato"
      label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
      label.textColor = .darkGray
      label.numberOfLines = 2
      return label
   }()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      self.addViews()
      self.addConstraints()
   }
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

extension LastMessageCollectionViewCell {
   private func addViews () {
      self.addSubview(imageView)
      self.addSubview(userName)
   }
   private func addConstraints () {
      NSLayoutConstraint.activate([
         self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
         self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         self.imageView.widthAnchor.constraint(equalToConstant: 55),
         self.imageView.heightAnchor.constraint(equalToConstant: 55),
         
         self.userName.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 15),
         self.userName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         self.userName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
      ])
   }
}
