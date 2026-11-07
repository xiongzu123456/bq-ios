import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    static let startURL = "https://app-f1egsv9peoe9.miaoda.online/home"

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaPlaybackRequiresUserAction = false

        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(webView)

        if let url = URL(string: Self.startURL) {
            webView.load(URLRequest(url: url))
        }
    }

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url,
           url.scheme == "tel" || url.scheme == "mailto" {
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
}
