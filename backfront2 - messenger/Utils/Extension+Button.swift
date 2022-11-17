//
//  Extension+Button.swift
//  backfront2 - messenger
//
//  Created by Hugo Silva on 15/11/22.
//

import UIKit

extension UIButton {
   func touchAnimation(s: UIButton) {
      UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
         s.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
      }, completion: { finish in UIButton.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
         s.transform = .identity
      })
      })
   }
}
