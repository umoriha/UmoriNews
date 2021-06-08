//
//  SafariView.swift
//  UmoriNewsAPP
//
//  Created by umoriha on 2021/06/01.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    var url: URL
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context)  {
        
    }
}

