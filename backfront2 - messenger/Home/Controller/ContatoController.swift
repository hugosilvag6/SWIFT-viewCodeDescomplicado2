//
//  ContatoController.swift
//  backfront2 - messenger
//
//  Created by Hugo Silva on 16/11/22.
//

import UIKit
import Firebase

protocol ContatoProtocol: AnyObject {
   func alertStateError(titulo: String, message: String)
   func successContato()
}

class ContatoController {
   
   weak var delegate: ContatoProtocol?
   
   public func delegate (delegate: ContatoProtocol) {
      self.delegate = delegate
   }
   
   func addContact (email: String, emailUsuarioLogado: String, idUsuario: String) {
      if email == emailUsuarioLogado {
         self.delegate?.alertStateError(titulo: "Erro", message: "Você adicionou seu próprio email.")
      }
      let firestore = Firestore.firestore()
      firestore.collection("usuarios").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
         // conta total de retorno
         if let totalItens = snapshot?.count {
            if totalItens == 0 {
               self.delegate?.alertStateError(titulo: "Erro", message: "Usuário não cadastrado.")
               return
            }
         }
         // salvar contato
         if let snapshot {
            for document in snapshot.documents {
               let dados = document.data()
               self.salvarContato(dados: dados, idUsuario: idUsuario)
            }
         }
      }
   }
   
   func salvarContato(dados: [String:Any], idUsuario: String) {
      let contact = Contact(dicionario: dados)
      let firestore = Firestore.firestore()
      firestore.collection("usuarios").document(idUsuario).collection("contatos").document(contact.id ?? "").setData(dados) { error in
         if error == nil {
            self.delegate?.successContato()
         }
      }
   }
}
