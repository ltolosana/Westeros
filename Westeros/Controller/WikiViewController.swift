//
//  WikiViewController.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 18/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import UIKit
import WebKit

final class WikiViewController: UIViewController {

    // MARK: - Oultlets
    @IBOutlet private weak var webView: WKWebView!
 
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // MARK: - Properties
    private let model: House
    
    // MARK: - Initialization
    init( model: House) {
        // Primero limpio lo mio
        self.model = model
        
        // Luego llamos a super.init
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARk: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Asignar delegados
        webView.navigationDelegate = self
        
        syncModelWithView()
    }

}

extension WikiViewController {
    private func syncModelWithView() {
        title = model.name // LA propiedad title esta definida en UIViewController (o en su padre)
        
        // Mostramos y arrancamos el loading view
        loadingView.isHidden = false
        loadingView.startAnimating()
        
        // Cargar la url
        let request = URLRequest(url: model.wikiURL)
        webView.load(request)
    }

}

extension WikiViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Detenemos el loadingView
        loadingView.stopAnimating()
        
        // Lo ocultamos
        loadingView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let type = navigationAction.navigationType
        switch type {
        case .linkActivated, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}
