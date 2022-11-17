//
//  NavView.swift
//  backfront2 - messenger
//
//  Created by Hugo Silva on 15/11/22.
//

import UIKit

enum TypeConversationOrContact {
   case conversation, contact
}
protocol NavViewProtocol: AnyObject {
   func typeScreenMessage(type: TypeConversationOrContact)
}

class NavView: UIView {
   
   weak private var delegate: NavViewProtocol?
   
   lazy var navBackgroundView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .white
      view.layer.cornerRadius = 35
      view.layer.maskedCorners = [.layerMaxXMaxYCorner]
      view.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
      view.layer.shadowOffset = CGSize(width: 0, height: 5)
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
   
   lazy var stackView: UIStackView = {
      let st = UIStackView()
      st.translatesAutoresizingMaskIntoConstraints = false
      st.distribution = .fillEqually
      st.axis = .horizontal
      st.spacing = 10
      return st
   }()
   
   lazy var conversationButton: UIButton = {
      let bt = UIButton()
      bt.translatesAutoresizingMaskIntoConstraints = false
      // rendering mode always template permite manipular a imagem pra trocar, por exemplo, a cor
      bt.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysTemplate), for: .normal)
      bt.tintColor = .black
      bt.addTarget(self, action: #selector(tappedConversationButton), for: .touchUpInside)
      return bt
   }()
   
   lazy var contactButton: UIButton = {
      let bt = UIButton()
      bt.translatesAutoresizingMaskIntoConstraints = false
      bt.setImage(UIImage(named: "group")?.withRenderingMode(.alwaysTemplate), for: .normal)
      bt.tintColor = .black
      bt.addTarget(self, action: #selector(tappedContactButton), for: .touchUpInside)
      return bt
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

extension NavView {
   @objc func tappedConversationButton() {
      self.delegate?.typeScreenMessage(type: .conversation)
      self.conversationButton.tintColor = .systemPink
      self.contactButton.tintColor = .black
   }
   @objc func tappedContactButton() {
      self.delegate?.typeScreenMessage(type: .contact)
      self.contactButton.tintColor = .systemPink
      self.conversationButton.tintColor = .black
   }
}

extension NavView {
   func delegate(delegate: NavViewProtocol?) {
      self.delegate = delegate
   }
}

extension NavView {
   func addViews() {
      self.addSubview(navBackgroundView)
      self.navBackgroundView.addSubview(self.navBar)
      self.navBar.addSubview(self.searchBar)
      self.navBar.addSubview(self.stackView)
      self.searchBar.addSubview(self.searchLabel)
      self.searchBar.addSubview(self.searchButton)
      self.stackView.addArrangedSubview(self.conversationButton)
      self.stackView.addArrangedSubview(self.contactButton)
   }
   func addConstraints() {
      NSLayoutConstraint.activate([
         navBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         navBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         navBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         navBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
         
         navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
         navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         navBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         
         searchBar.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor, constant: 30),
         searchBar.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
         searchBar.trailingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: -20),
         searchBar.heightAnchor.constraint(equalToConstant: 55),
         
         stackView.trailingAnchor.constraint(equalTo: self.navBar.trailingAnchor, constant: -30),
         stackView.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
         stackView.widthAnchor.constraint(equalToConstant: 100),
         stackView.heightAnchor.constraint(equalToConstant: 30),
         
         searchLabel.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor, constant: 25),
         searchLabel.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
         
         searchButton.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor, constant: -20),
         searchButton.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
         searchButton.widthAnchor.constraint(equalToConstant: 20),
         searchButton.heightAnchor.constraint(equalToConstant: 20)
      ])
   }
}
