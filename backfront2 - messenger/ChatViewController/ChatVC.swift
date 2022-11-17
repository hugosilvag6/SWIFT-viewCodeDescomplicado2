//
//  ChatVC.swift
//  backfront2 - messenger
//
//  Created by Hugo Silva on 16/11/22.
//

import UIKit
import Firebase

class ChatVC: UIViewController {
   
   var listaMensagens: [Message] = []
   var idUsuarioLogado: String?
   var contato: Contact?
   var mensagemListener: ListenerRegistration?
   var auth: Auth?
   var db: Firestore?
   var nomeContato: String?
   var nomeUsuarioLogado: String?
   
   var screen: ChatScreen?
   
   override func loadView() {
      self.screen = ChatScreen()
      self.view = screen
   }
   override func viewDidLoad() {
      super.viewDidLoad()
      self.configDataFirebase()
      self.configChatView()
   }
   override func viewWillAppear(_ animated: Bool) {
      self.addListenerRecuperarMensagens()
   }
   override func viewDidDisappear(_ animated: Bool) {
      // removemos sempre que a view some, pra não ficar criando vários listeners
      self.mensagemListener?.remove()
   }
   
   @objc func tappedBackButton() {
      self.navigationController?.popToRootViewController(animated: true)
   }
}

extension ChatVC {
   private func configDataFirebase() {
      self.auth = Auth.auth()
      self.db = Firestore.firestore()
      if let id = self.auth?.currentUser?.uid {
         self.idUsuarioLogado = id
         self.recuperarDadosUsuarioLogado()
      }
      if let nome = self.contato?.nome {
         self.nomeContato = nome
      }
   }
   private func recuperarDadosUsuarioLogado() {
      let usuarios = self.db?.collection("usuarios").document(self.idUsuarioLogado ?? "")
      usuarios?.getDocument { snapshot, error in
         if let error {
            print(error.localizedDescription)
         } else if let snapshot {
            let dados = Contact(dicionario: snapshot.data() ?? [:])
            self.nomeUsuarioLogado = dados.nome ?? ""
         }
      }
   }
   private func configChatView () {
      self.screen?.configNavView(controller: self)
      self.screen?.configTableView(delegate: self, dataSource: self)
      self.screen?.delegate(delegate: self)
   }
   func addListenerRecuperarMensagens() {
      if let idDestinatario = self.contato?.id {
         self.mensagemListener = db?.collection("mensagens").document(self.idUsuarioLogado ?? "").collection(idDestinatario).order(by: "data", descending: true).addSnapshotListener({ snapshot, error in
            // limpar mensagens
            self.listaMensagens.removeAll()
            // recuperar os dados
            if let snapshot {
               for document in snapshot.documents {
                  let dados = document.data()
                  self.listaMensagens.append(Message(dicionario: dados))
               }
               self.screen?.reloadTableView()
            }
         })
      }
   }
}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return listaMensagens.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let indice = indexPath.row
      let dados = self.listaMensagens[indice]
      let idUsuario = dados.idUsuario ?? ""
      if self.idUsuarioLogado != idUsuario {
         let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier, for: indexPath) as? IncomingTextMessageTableViewCell
         cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
         cell?.setupCell(message: dados)
         cell?.selectionStyle = .none
         return cell ?? UITableViewCell()
      } else {
         let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextMessageTableViewCell.identifier, for: indexPath) as? OutgoingTextMessageTableViewCell
         cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
         cell?.setupCell(message: dados)
         cell?.selectionStyle = .none
         return cell ?? UITableViewCell()
      }
   }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      let desc = self.listaMensagens[indexPath.row].texto ?? ""
      let font = UIFont(name: CustomFont.poppinsSemiBold, size: 14) ?? UIFont()
      // estima altura de acordo com a fonte
      let estimatedHeight = desc.heightWithConstrainedWidth(width: 220, font: font)
      return CGFloat(65 + estimatedHeight)
   }
}

extension ChatVC: ChatViewScreenProtocol {
   func actionPushMessage() {
      let message = self.screen?.inputMessageTextField.text ?? ""
      if let idUsuarioDestinatario = self.contato?.id {
         let mensagem: [String:Any] = [
            "idUsuario": self.idUsuarioLogado ?? "",
            "texto": message,
            "data": FieldValue.serverTimestamp()
         ]
         // mensagem para remetente
         self.salvarMensagem(idRemetente: self.idUsuarioLogado ?? "", idDestinatario: idUsuarioDestinatario, mensagem: mensagem)
         // mensagem para destinatario
         self.salvarMensagem(idRemetente: idUsuarioDestinatario, idDestinatario: self.idUsuarioLogado ?? "", mensagem: mensagem)
         
         // salvar conversa para remetente(dados de quem recebe)
         var conversa: [String:Any] = ["ultimaMensagem":message]
         conversa["idRemetente"] = idUsuarioLogado ?? ""
         conversa["idDestinatario"] = idUsuarioDestinatario
         conversa["nomeUsuario"] = self.nomeContato ?? ""
         self.salvarConversa(idRemetente: idUsuarioLogado ?? "", idDestinatario: idUsuarioDestinatario, conversa: conversa)
         // salvar conversa para destinatario(dados de quem envia)
         conversa["idRemetente"] = idUsuarioDestinatario
         conversa["idDestinatario"] = idUsuarioLogado ?? ""
         conversa["nomeUsuario"] = self.nomeUsuarioLogado ?? ""
         self.salvarConversa(idRemetente: idUsuarioDestinatario, idDestinatario: idUsuarioLogado ?? "", conversa: conversa)
      }
   }
   private func salvarMensagem(idRemetente: String, idDestinatario: String, mensagem: [String: Any]) {
      self.db?.collection("mensagens").document(idRemetente).collection(idDestinatario).addDocument(data: mensagem)
      // limpar a caixa de texto
      self.screen?.inputMessageTextField.text = ""
   }
   private func salvarConversa(idRemetente: String, idDestinatario: String, conversa: [String:Any]) {
      self.db?.collection("conversas").document(idRemetente).collection("ultimas_conversas").document(idDestinatario).setData(conversa)
   }
}
