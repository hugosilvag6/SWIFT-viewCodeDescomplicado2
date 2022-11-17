//
//  LoginScreen.swift
//  backfront1
//
//  Created by Hugo Silva on 14/11/22.
//

import UIKit

protocol LoginScreenProtocol: AnyObject {
   func actionLoginButton()
   func actionRegisterButton()
}

class LoginScreen: UIView {
   
   weak var delegate: LoginScreenProtocol?
   
   // o lazy só é executado/criado/lido quando o chamamos. Se não chamarmos ou até o momento em que chamarmos, ele não existe.
   lazy var loginLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textColor = .white
      label.font = .boldSystemFont(ofSize: 40)
      label.text = "Login"
      return label
   }()
   
   lazy var logoAppImageView: UIImageView = {
      let img = UIImageView()
      img.translatesAutoresizingMaskIntoConstraints = false
      img.image = UIImage(named: "logo")
      img.tintColor = .green
      img.contentMode = .scaleAspectFit
      return img
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
      tf.textColor = .darkGray
      tf.text = "hugo@gmail.com"
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
      tf.textColor = .darkGray
      tf.text = "123456"
      return tf
   }()
   
   lazy var loginButton: UIButton = {
      let button = UIButton()
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitle("Logar", for: .normal)
      button.titleLabel?.font = .systemFont(ofSize: 18)
      button.setTitleColor(.lightGray, for: .normal)
      button.clipsToBounds = true // permite arrendondar
      button.layer.cornerRadius = 7.5
      button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1)
      button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
      button.isEnabled = false
      return button
   }()
   
   lazy var registerButton: UIButton = {
      let button = UIButton()
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitle("Não tem conta? Cadastre-se", for: .normal)
      button.titleLabel?.font = .systemFont(ofSize: 18)
      button.setTitleColor(.white, for: .normal)
      button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
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

extension LoginScreen {
   // os delegates de Textfield delegam para a VC o controle sobre métodos como shouldReturn, didEndEditing e didBeginEditing
   public func textfieldDelegate (delegate: UITextFieldDelegate) {
      self.emailTextfield.delegate = delegate
      self.passwordTextfield.delegate = delegate
   }
   // Os delegates de botão delegam as ações para a VC
   func buttonsDelegate(delegate: LoginScreenProtocol?) {
      self.delegate = delegate
   }
}

extension LoginScreen {
   // as ações estão na vc, como viewModel.action
   @objc private func tappedLoginButton () {
      self.delegate?.actionLoginButton()
   }
   @objc private func tappedRegisterButton () {
      self.delegate?.actionRegisterButton()
   }
}

extension LoginScreen {
   // aqui a validação ocorre desativando o botão. Poderia ser transferida para a VC no próprio botão, usando algo como um uiState pra apresentar um alerta
   public func textfieldValidation () {
      let email = self.emailTextfield.text ?? ""
      let password = self.passwordTextfield.text ?? ""
      
      if email.isEmpty || password.isEmpty {
         self.loginButton.setTitleColor(.lightGray, for: .normal)
         self.loginButton.isEnabled = false
      } else {
         self.loginButton.setTitleColor(.white, for: .normal)
         self.loginButton.isEnabled = true
      }
   }
}

extension LoginScreen {
   private func addViews () {
      self.addSubview(loginLabel)
      self.addSubview(logoAppImageView)
      self.addSubview(emailTextfield)
      self.addSubview(passwordTextfield)
      self.addSubview(loginButton)
      self.addSubview(registerButton)
   }
   private func addConstraints () {
      NSLayoutConstraint.activate([
         loginLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
         loginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

         logoAppImageView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
         logoAppImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
         logoAppImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
         logoAppImageView.heightAnchor.constraint(equalToConstant: 200),

         emailTextfield.topAnchor.constraint(equalTo: logoAppImageView.bottomAnchor, constant: 20),
         emailTextfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
         emailTextfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
         emailTextfield.heightAnchor.constraint(equalToConstant: 45),

         passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 20),
         passwordTextfield.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
         passwordTextfield.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
         passwordTextfield.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor),

         loginButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 20),
         loginButton.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
         loginButton.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
         loginButton.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor),

         registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
         registerButton.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
         registerButton.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
         registerButton.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor),
      ])
   }
   private func setBackground () {
      self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1)
   }
}
