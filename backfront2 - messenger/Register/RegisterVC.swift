//
//  RegisterVC.swift
//  backfront1
//
//  Created by Hugo Silva on 14/11/22.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
   
   var registerScreen: RegisterScreen?
   var auth: Auth?
   var firestore: Firestore?
   var alert: Alert?
   
   override func loadView() {
      self.registerScreen = RegisterScreen()
      self.view = self.registerScreen
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.registerScreen?.textfieldDelegate(delegate: self)
      self.registerScreen?.buttonDelegate(delegate: self)
      self.auth = Auth.auth()
      self.firestore = Firestore.firestore()
      self.alert = Alert(controller: self)
   }
}

extension RegisterVC: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
   }
   func textFieldDidEndEditing(_ textField: UITextField) {
      self.registerScreen?.textfieldValidation()
   }
}

extension RegisterVC: RegisterScreenProtocol {
   func actionBackButton() {
      self.navigationController?.popViewController(animated: true)
   }
   
   func actionRegisterButton() {
      let name = self.registerScreen?.nameTextfield.text ?? ""
      let email = self.registerScreen?.emailTextfield.text ?? ""
      let password = self.registerScreen?.passwordTextfield.text ?? ""
      self.auth?.createUser(withEmail: email, password: password, completion: { result, error in
         if let error {
            self.alert?.getAlert(title: "Erro", msg: error.localizedDescription)
         } else {
            // Salvar dados no firebase
            if let id = result?.user.uid {
               self.firestore?.collection("usuarios").document(id).setData([
                  "nome": name,
                  "email": email,
                  "id": id
               ])
            }
            
            self.alert?.getAlert(title: "Sucesso", msg: "Usuário cadastrado com sucesso.", completion: {
               let navVC = UINavigationController(rootViewController: HomeVC())
               navVC.modalPresentationStyle = .fullScreen
               self.present(navVC, animated: true, completion: nil)
            })
         }
      })
   }
}
