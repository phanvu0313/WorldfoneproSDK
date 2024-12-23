import UIKit
import WebKit

public class WorldfoneProCall: UIView {
    private var webView: WKWebView!
    private var secretKey: String
    private var env: String
    private var userInfo: [String: Any]
    private var onMessage: ((String) -> Void)?

    public init(secretKey: String, env: String, userInfo: [String: Any], onMessage: @escaping (String) -> Void) {
        self.secretKey = secretKey
        self.env = env
        self.userInfo = userInfo
        self.onMessage = onMessage
        super.init(frame: .zero)
        setupWebView()
        loadWebView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(webView)

        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func loadWebView() {
        let headers = generateHeaders()
        guard let url = URL(string: env == "uat" ?
            "https://worldfonepro-center-uat.worldfone.cloud/mobilecallwebview" :
            "https://worldfonepro-center.worldfone.cloud/mobilecallwebview") else { return }
        
        var request = URLRequest(url: url)
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        webView.load(request)
    }

    private func generateHeaders() -> [String: String] {
        func base64Encode(_ value: String?) -> String {
            guard let value = value else { return "" }
            return Data(value.utf8).base64EncodedString()
        }

        var headers: [String: String] = [
            "Secret-Key": secretKey,
            "x-name": base64Encode(userInfo["name"] as? String),
            "x-phone": base64Encode(userInfo["phone"] as? String),
            "x-email": base64Encode(userInfo["email"] as? String),
            "x-action": userInfo["action"] as? String ?? "",
            "x-encode": "base64",
            "x-data-addon": base64Encode(
                (try? JSONSerialization.data(withJSONObject: userInfo["addOn"] ?? [:], options: [])
                    .map { String(format: "%c", $0) }
                    .joined()) ?? ""
            )
        ]
        #if os(iOS)
        headers["x-device"] = "ios"
        #endif
        return headers
    }
}

// MARK: - WKNavigationDelegate
extension WorldfoneProCall: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView finished loading")
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, url.scheme == "callback", let message = url.host {
            onMessage?(message)
        }
        decisionHandler(.allow)
    }
}
