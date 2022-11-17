//
//  ChatNavigationView.swift
//  backfront2 - messenger
//
//  Created by Hugo Silva on 16/11/22.
//

import UIKit

class ChatNavigationView: UIView {
   
   var controller: ChatVC? {
      didSet {
         self.backButton.addTarget(controller, action: #selector(ChatVC.tappedBackButton), for: .touchUpInside)
      }
   }
   
   lazy var navBackgroundView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .white
      view.layer.cornerRadius = 35
      view.layer.maskedCorners = [.layerMaxXMaxYCorner]
      view.layer.shadowColor = UIColor(white: 0, alpha: 0.05).cgColor
      view.layer.shadowOffset = CGSize(width: 0, height: 10)
      view.layer.shadowOpacity = 1
      view.layer.shadowRadius = 10
      return view
   }()
   
   lazy var navBar: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .clear
      return view
   }()
   
   lazy var searchBar: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = CustomColor.appLight
      view.clipsToBounds = true
      view.layer.cornerRadius = 20
      return view
   }()
   
   lazy var searchLabel: UILabel = {
      let lb = UILabel()
      lb.translatesAutoresizingMaskIntoConstraints = false
      lb.text = "Digite aqui"
      lb.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
      lb.textColor = .lightGray
      return lb
   }()
   
   lazy var searchButton: UIButton = {
      let bt = UIButton()
      bt.translatesAutoresizingMaskIntoConstraints = false
      bt.setImage(UIImage(named: "search"), for: .normal)
      return bt
   }()
   
   lazy var backButton: UIButton = {
      let bt = UIButton()
      bt.translatesAutoresizingMaskIntoConstraints = false
      bt.setImage(UIImage(named: "back"), for: .normal)
      return bt
   }()
   
   lazy var customImage: UIImageView = {
      let img = UIImageView()
      img.translatesAutoresizingMaskIntoConstraints = false
      img.contentMode = .scaleAspectFill
      img.clipsToBounds = true
      img.layer.cornerRadius = 26
      img.image = UIImage(named: "imagem-perfil")
      return img
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

extension ChatNavigationView {
   func addViews () {
      self.addSubview(navBackgroundView)
      self.navBackgroundView.addSubview(self.navBar)
      self.navBar.addSubview(self.backButton)
      self.navBar.addSubview(self.customImage)
      self.navBar.addSubview(self.searchBar)
      self.searchBar.addSubview(self.searchLabel)
      self.searchBar.addSubview(self.searchButton)
   }
   func addConstraints () {
      NSLayoutConstraint.activate([
         navBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         navBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         navBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         navBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
         
         navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
         navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         navBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         
         backButton.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor, constant: 30),
         backButton.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
         backButton.heightAnchor.constraint(equalToConstant: 30),
         backButton.widthAnchor.constraint(equalToConstant: 30),
         
         customImage.leadingAnchor.constraint(equalTo: self.backButton.trailingAnchor, constant: 20),
         customImage.heightAnchor.constraint(equalToConstant: 55),
         customImage.widthAnchor.constraint(equalToConstant: 55),
         customImage.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
         
         searchBar.leadingAnchor.constraint(equalTo: self.customImage.trailingAnchor, constant: 20),
         searchBar.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
         searchBar.trailingAnchor.constraint(equalTo: self.navBar.trailingAnchor, constant: -20),
         searchBar.heightAnchor.constraint(equalToConstant: 55),
         
         searchLabel.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor, constant: 25),
         searchLabel.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
         
         searchButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -20),
         searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
         searchButton.heightAnchor.constraint(equalToConstant: 20),
         searchButton.widthAnchor.constraint(equalToConstant: 20)
      ])
   }
}
