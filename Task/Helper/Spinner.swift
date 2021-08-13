//
//  Spinner.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import Foundation
import ZKProgressHUD
import UIKit

// MARK: - Spinner Class that class have ZKProgressHUD for shown to user until reading file was finish
final class Spinner {
    // MARK: - show spinner method
    public static func start() {
        ZKProgressHUD.setCornerRadius(5.0)
        ZKProgressHUD.dismiss(10)
        ZKProgressHUD.setBackgroundColor(.white)
        ZKProgressHUD.setForegroundColor(.systemBlue)
        ZKProgressHUD.show()
    }
    // MARK: - stop spinner method
    public static func stop() {
        ZKProgressHUD.dismiss()
    }
    
}
