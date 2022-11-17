//
//  RegisterScreen.swift
//  backfront1
//
//  Created by Hugo Silva on 14/11/22.
//

import UIKit

protocol RegisterScreenProtocol: AnyObject {
   func actionBackButton()
   func actionRegisterButton()
}

class RegisterScreen: UIView {
   
   weak var delegate: RegisterScreenProtocol?
   
   lazy var backButton: UIButton = {
      let button = UIButton()
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setImage(UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
      button.tintColor = .black
      button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
      return button
   }()
   
   lazy var addUserImage: UIImageView = {
      let img = UIImageView()
      img.translatesAutoresizingMaskIntoConstraints = false
      img.image = UIImage(named: "usuario")
      img.contentMode = .scaleAspectFit
      return img
   }()
   
   lazy var nameTextfield: UITextField = {
      let tf = UITextField()
      tf.translatesAutoresizingMaskIntoConstraints = false
      tf.autocorrectionType = .no
      tf.backgroundColor = .white
      tf.borderStyle = .roundedRect
      tf.keyboardType = .default
      tf.placeholder = "Digite seu nome"
      tf.autocapitalizationType = .none
      tf.font = .systemFont(ofSize: 14)
      tf.textColor = .darkGray
      return tf
   }()
   
   lazy var emailTextfield: UITextField = {
      let tf = UITextField()
      tf.translatesAutoresizingMaskIntoConstraints = false
      tf.autocorrectionType = .no
      tf.backgroundColor = .white
      tf.borderStyle = .roundedRect
      tf.keyboardType = .emailAddress
      tf.placeholder = "Digite seu email"
      tf.autocapitalizationType = .none
      tf.font = .systemFont(ofSize: 14)
      tf.textColor = .darkGray
      return tf
   }()
   
   lazy var passwordTextfield: UITextField = {
      let tf = UITextField()
      tf.translatesAutoresizingMaskIntoConstraints = false
      tf.autocorrectionType = .no
      tf.backgroundColor = .white
      tf.borderStyle = .roundedRect
      tf.keyboardType = .default
      tf.placeholder = "Digite sua senha"
      tf.isSecureTextEntry = true
      tf.font = .systemFont(ofSize: 14)
      tf.textColor = .darkGray
      return tf
   }()
   
   lazy var registerButton: UIButton = {
      let button = UIButton()
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitle("Cadastrar", for: .normal)
      button.setTitleColor(.lightGray, for: .normal)
      button.clipsToBounds = true // permite arrendondar
      button.layer.cornerRadius = 7.5
      button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1)
      button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
      button.isEnabled = false
      return button
   }()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      self.setBackground()
      self.addViews()
      self.addConstraints()
   }
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

extension RegisterScreen {
   private func setBackground () {
      self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1)
   }
}

extension RegisterScreen {
   public func textfieldDelegate (delegate: UITextFieldDelegate) {
      self.emailTextfield.delegate = delegate
      self.passwordTextfield.delegate = delegate
      self.nameTextfield.delegate = delegate
   }
   func buttonDelegate (delegate: RegisterScreenProtocol?) {
      self.delegate = delegate
   }
}

extension RegisterScreen {
   @objc private func tappedBackButton () {
      self.delegate?.actionBackButton()
   }
   @objc private func tappedRegisterButton () {
      self.delegate?.actionRegisterButton()
   }
}

extension RegisterScreen {
   private func addConstraints () {
      NSLayoutConstraint.activate([
         addUserImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
         addUserImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         addUserImage.widthAnchor.constraint(equalToConstant: 150),
         addUserImage.heightAnchor.constraint(equalToConstant: 150),

         backButton.topAnchor.constraint(equalTo: self.addUserImage.topAnchor),
         backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
         
         nameTextfield.topAnchor.constraint(equalTo: self.addUserImage.bottomAnchor, constant: 10),
         nameTextfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
         nameTextfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
         nameTextfield.heightAnchor.constraint(equalToConstant: 45),
         
         emailTextfield.topAnchor.constraint(equalTo: self.nameTextfield.bottomAnchor, constant: 20),
         emailTextfield.leadingAnchor.constraint(equalTo: nameTextfield.leadingAnchor),
         emailTextfield.trailingAnchor.constraint(equalTo: nameTextfield.trailingAnchor),
         emailTextfield.heightAnchor.constraint(equalTo: nameTextfield.heightAnchor),

         passwordTextfield.topAnchor.constraint(equalTo: self.emailTextfield.bottomAnchor, constant: 20),
         passwordTextfield.leadingAnchor.constraint(equalTo: nameTextfield.leadingAnchor),
         passwordTextfield.trailingAnchor.constraint(equalTo: nameTextfield.trailingAnchor),
         passwordTextfield.heightAnchor.constraint(equalTo: nameTextfield.heightAnchor),

         registerButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 15),
         registerButton.leadingAnchor.constraint(equalTo: nameTextfield.leadingAnchor),
         registerButton.trailingAnchor.constraint(equalTo: nameTextfield.trailingAnchor),
         registerButton.heightAnchor.constraint(equalTo: nameTextfield.heightAnchor)

      ])
   }
   private func addViews () {
      self.addSubview(backButton)
      self.addSubview(addUserImage)
      self.addSubview(nameTextfield)
      self.addSubview(emailTextfield)
      self.addSubview(passwordTextfield)
      self.addSubview(registerButton)
   }
}

extension RegisterScreen {
   public func textfieldValidation () {
      let name = self.nameTextfield.text ?? ""
      let email = self.emailTextfield.text ?? ""
      let password = self.passwordTextfield.text ?? ""
      
      if email.isEmpty || password.isEmpty || name.isEmpty {
         self.registerButton.setTitleColor(.lightGray, for: .normal)
         self.registerButton.isEnabled = false
      } else {
         self.registerButton.setTitleColor(.white, for: .normal)
         self.registerButton.isEnabled = true
      }
   }
}
