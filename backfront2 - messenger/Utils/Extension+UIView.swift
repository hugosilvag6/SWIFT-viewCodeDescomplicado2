//
//  UIView.swift
//  backfront2 - messenger
//
//  Created by Hugo Silva on 15/11/22.
//

import UIKit

extension UIView {
   func pin(to superView: UIView) {
      self.translatesAutoresizingMaskIntoConstraints = false
      self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
      self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
      self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
      self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
   }
}
