//
//  ViewController.swift
//  backfront1
//
//  Created by Hugo Silva on 14/11/22.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
   
   var auth: Auth?
   var loginScreen: LoginScreen?
   var alert: Alert?
   
   // responsável por criação de view, ou, no nosso caso, referenciando uma view em outra
   override func loadView() {
      self.loginScreen = LoginScreen()
      self.view = self.loginScreen
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.loginScreen?.textfieldDelegate(delegate: self)
      self.loginScreen?.buttonsDelegate(delegate: self)
      self.auth = Auth.auth()
      self.alert = Alert(controller: self)
   }
   
   override func viewWillAppear(_ animated: Bool) {
      self.navigationController?.setNavigationBarHidden(true, animated: false)
   }
   
}

extension LoginVC: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      print(#function)
      textField.resignFirstResponder()
      return true
   }
   func textFieldDidEndEditing(_ textField: UITextField) {
      print(#function)
      self.loginScreen?.textfieldValidation()
   }
   func textFieldDidBeginEditing(_ textField: UITextField) {
      print(#function)
   }
}

extension LoginVC: LoginScreenProtocol {
   func actionLoginButton() {
      let email = self.loginScreen?.emailTextfield.text ?? ""
      let password = self.loginScreen?.passwordTextfield.text ?? ""
      self.auth?.signIn(withEmail: email, password: password, completion: { result, error in
         if let error {
            self.alert?.getAlert(title: "Erro", msg: error.localizedDescription)
         } else {
            let navVC = UINavigationController(rootViewController: HomeVC())
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true, completion: nil)
         }
      })
   }
   
   func actionRegisterButton() {
      // como estamos trabalhando com navigation Controller, podemos fazer dessa forma
      self.navigationController?.pushViewController(RegisterVC(), animated: true)
   }
}
