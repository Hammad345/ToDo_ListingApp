//
//  Extentions.swift
//  To-DoListApp
//
//  Created by Amaan Gillani on 14/08/2023.
//

import UIKit

extension AddEditViewController {
    /// [Alert is created by this method optionally.]
     func presentAlert(
        title: String?,
        message: String?,
        alertStyle: UIAlertController.Style = .alert,
        cancelButtonTitle: String?,
        defaultButtonTitle: String? = nil,
        defaultButtonHandler: ((UIAlertAction) -> Void)? = nil
    ) {
        /// [Alert is created.]
        alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: alertStyle
        )
        /// [Cancel button action is created in alertController.]
        let cancelButton = UIAlertAction(
            title: cancelButtonTitle,
            style: .destructive
        )
        alertController.addAction(cancelButton)
        /// [Default button action is created by optional in alertController.]
        if let defaultButtonTitle {
            let defaultButton = UIAlertAction(
                title: defaultButtonTitle,
                style: .default,
                handler: defaultButtonHandler
            )
            alertController.addAction(defaultButton)
        }
        present(alertController, animated: true)
    }

}
