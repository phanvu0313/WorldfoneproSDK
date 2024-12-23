import SwiftUI
import WebKit

public struct WorldfoneProCallView: UIViewRepresentable {
    public var secretKey: String
    public var env: String
    public var userInfo: [String: Any]
    public var onMessage: ((String) -> Void)

    // Khởi tạo WorldfoneProCallView với các tham số
    public init(secretKey: String, env: String, userInfo: [String: Any], onMessage: @escaping (String) -> Void) {
        self.secretKey = secretKey
        self.env = env
        self.userInfo = userInfo
        self.onMessage = onMessage
    }

    // Tạo UIView (WorldfoneProCall) trong SwiftUI
    public func makeUIView(context: Context) -> WorldfoneProCall {
        let sdk = WorldfoneProCall(secretKey: secretKey, env: env, userInfo: userInfo, onMessage: onMessage)
        return sdk
    }

    // Cập nhật UIView khi có thay đổi
    public func updateUIView(_ uiView: WorldfoneProCall, context: Context) {
        // Cập nhật SDK nếu cần thiết
    }
}
