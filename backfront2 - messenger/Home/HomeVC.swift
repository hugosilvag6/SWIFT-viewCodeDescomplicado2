//
//  HomeVC.swift
//  backfront2 - messenger
//
//  Created by Hugo Silva on 15/11/22.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
   
   var screen: HomeScreen?
   var auth: Auth?
   var db: Firestore?
   var idUsuarioLogado: String?
   var emailUsuarioLogado: String?
   var alert: Alert?
   var screenContact: Bool?
   var contato: ContatoController?
   var listContact: [Contact] = []
   var listaConversas: [Conversation] = []
   var conversasListener: ListenerRegistration?
   
   override func loadView() {
      self.screen = HomeScreen()
      self.view = self.screen
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.navigationController?.navigationBar.isHidden = true
      self.view.backgroundColor = CustomColor.appLight
      self.configHomeView()
      self.configCollectionView()
      self.configAlert()
      self.configIdentifierFirebase()
      self.configContato()
      self.addListenerRecuperarConversa()
   }
}

extension HomeVC {
   private func configHomeView () {
      self.screen?.navView.delegate(delegate: self)
   }
   private func configCollectionView () {
      self.screen?.collectionViewDelegate(delegate: self, dataSource: self)
   }
   private func configAlert () {
      self.alert = Alert(controller: self)
   }
   private func configIdentifierFirebase() {
      self.auth = Auth.auth()
      self.db = Firestore.firestore()
      if let currentUser = auth?.currentUser {
         self.idUsuarioLogado = currentUser.uid
         self.emailUsuarioLogado = currentUser.email
      }
   }
   private func configContato() {
      self.contato = ContatoController()
      self.contato?.delegate(delegate: self)
   }
}

extension HomeVC {
   func getContato() {
      self.listContact.removeAll()
      self.db?.collection("usuarios").document(self.idUsuarioLogado ?? "").collection("contatos").getDocuments { snapshot, error in
         if let error {
            print("error getContato: \(error.localizedDescription)")
         } else if let snapshot {
            for document in snapshot.documents {
               let dadosContato = document.data()
               self.listContact.append(Contact(dicionario: dadosContato))
            }
            self.screen?.reloadCollectionView()
         }
      }
   }
   func addListenerRecuperarConversa() {
      if let idUsuarioLogado = auth?.currentUser?.uid {
         self.conversasListener = db?.collection("conversas").document(idUsuarioLogado).collection("ultimas_conversas").addSnapshotListener({ snapshot, error in
            if let error {
               print("Erro addListenerRecuperarConversa: \(error.localizedDescription)")
            } else if let snapshot {
               self.listaConversas.removeAll()
               for document in snapshot.documents {
                  let dados = document.data()
                  self.listaConversas.append(Conversation(dicionario: dados))
               }
               self.screen?.reloadCollectionView()
            }
         })
      }
   }
}

extension HomeVC: NavViewProtocol {
   func typeScreenMessage(type: TypeConversationOrContact) {
      switch type {
      case .contact:
         self.screenContact = true
         self.getContato()
         self.conversasListener?.remove() // REMOVER LISTENER SE NAO FOR CONVERSAS
      case .conversation:
         self.screenContact = false
         self.addListenerRecuperarConversa()
         self.screen?.reloadCollectionView()
      }
   }
}

extension HomeVC: ContatoProtocol {
   func alertStateError(titulo: String, message: String) {
      self.alert?.getAlert(title: titulo, msg: message)
   }
   func successContato() {
      self.alert?.getAlert(title: "Ebaaaa", msg: "Usuário cadastrado com sucesso!") {
         self.getContato()
      }
   }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      if self.screenContact ?? false {
         return self.listContact.count + 1
      } else {
         return self.listaConversas.count
      }
   }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if self.screenContact ?? false {
         if indexPath.row == self.listContact.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastMessageCollectionViewCell.identifier, for: indexPath)
            return cell
         } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
            cell?.setupViewContact(contact: self.listContact[indexPath.row])
            return cell ?? UICollectionViewCell()
         }
      } else {
         // cell de conversas
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
         cell?.setupViewConversation(conversation: self.listaConversas[indexPath.row])
         return cell ?? UICollectionViewCell()
      }
   }
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      if self.screenContact ?? false {
         if indexPath.row == self.listContact.count {
            self.alert?.addContact(completion: { value in
               self.contato?.addContact(email: value, emailUsuarioLogado: self.emailUsuarioLogado ?? "", idUsuario: self.idUsuarioLogado ?? "")
            })
         } else {
            let vc = ChatVC()
            vc.contato = self.listContact[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
         }
      } else {
         let vc = ChatVC()
         let dados = self.listaConversas[indexPath.row]
         let contato = Contact(id: dados.idDestinatario ?? "", nome: dados.nome ?? "")
         vc.contato = contato
         self.navigationController?.pushViewController(vc, animated: true)
      }
   }
   // precisa do delegateflowlayout pra isso
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: collectionView.frame.width, height: 100)
   }
}
