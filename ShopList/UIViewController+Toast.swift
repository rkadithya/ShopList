//
//  Extensions.swift
//  ShopList
//
//  Created by RK Adithya on 30/05/25.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message: String, duration: Double = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.alpha = 0.0
        toastLabel.numberOfLines = 0

        let textSize = toastLabel.intrinsicContentSize
        let labelWidth = min(self.view.frame.width - 40, textSize.width + 20)
        let labelHeight = textSize.height + 20

        toastLabel.frame = CGRect(
            x: (self.view.frame.width - labelWidth) / 2,
            y: self.view.frame.height - labelHeight - 80,
            width: labelWidth,
            height: labelHeight
        )
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true

        self.view.addSubview(toastLabel)

        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}
