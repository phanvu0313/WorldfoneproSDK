<img src="https://cdn1.vieclam24h.vn/tvn/images/old_employer_avatar/images/64ec34c45d193e9d85c5250fbb08313f_5c739ef38a82d_1551081203.png" alt="drawing" width="500" />

# WorldfoneproSDK

-   23/12/2024

## **Cài đặt**

### **Sử dụng CocoaPods (đang cập nhật)**

### **Tích hợp thủ công**

1. Thêm file `WorldfoneproSDK.framework` vào project của bạn.
2. Trong **Build Phases**, thêm `WorldfoneproSDK.framework` vào mục **Link Binary With Libraries**.
3. Đảm bảo SDK đã được thêm vào mục **Embedded Frameworks**:
    - Mở project của bạn trong Xcode.
    - Chọn mục **General** của target chính.
    - Kéo `WorldfoneproSDK.framework` vào danh sách **Frameworks, Libraries, and Embedded Content**.
    - Đảm bảo chọn **Embed & Sign** cho framework.
4. **Kiểm tra quyền trong file `Info.plist`:**

    Để đảm bảo SDK hoạt động, bạn cần thêm quyền sau vào file `Info.plist`:

    ```xml
    <key>NSCameraUsageDescription</key>
    <string>Ứng dụng cần quyền sử dụng camera.</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>Ứng dụng cần quyền sử dụng microphone.</string>
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
    ```

---

## **Hướng dẫn sử dụng**

### **Với UIKit**

1. Import SDK:

    ```swift
    import WorldfoneproSDK
    ```

2. Khởi tạo và thêm `WorldfoneProCall` vào view:

```swift
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let userInfo: [String: Any] = [
            "name": "John Doe",
            "phone": "123456789",
            "email": "john.doe@example.com",
            "action": "call",
            "addOn": ["key": "value"]
        ]

        let sdk = WorldfoneProCall
        (secretKey: "your_secret_key", env: "uat", userInfo: userInfo)
        { message in
            switch message {
            case "hangup":
                print("Event: Hangup received")
            case "mutevideo":
                print("Event: Mute video received")
            case "facingmode":
                print("Event: Switch camera received")
            case "muteaudio":
                print("Event: Mute audio received")
            case "endcall":
                print("Event: End call received")
            default:
                print("Unknown event received: \(message)")
            }
        }

        sdk.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sdk)

        NSLayoutConstraint.activate([
            sdk.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sdk.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sdk.topAnchor.constraint(equalTo: view.topAnchor),
            sdk.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
```

### **Với SwiftUI**

1. Import SDK:

    ```swift
    import WorldfoneproSDK
    ```

2. Sử dụng `WorldfoneProCallView` trong SwiftUI:

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        let userInfo: [String: Any] = [
            "name": "John Doe",
            "phone": "123456789",
            "email": "john.doe@example.com",
            "action": "call",
            "addOn": ["key": "value"]
        ]

        WorldfoneProCallView(
            secretKey: "your_secret_key",
            env: "uat", // hoặc "prod"
            userInfo: userInfo
        ) { message in
            switch message {
            case "hangup":
                print("Event: Hangup received")
            case "mutevideo":
                print("Event: Mute video received")
            case "facingmode":
                print("Event: Switch camera received")
            case "muteaudio":
                print("Event: Mute audio received")
            case "endcall":
                print("Event: End call received")
            default:
                print("Unknown event received: \(message)")
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
```

---

## **Tham số khởi tạo**

### **WorldfoneProCall (UIKit)**

-   **`secretKey`** _(String)_: Key bí mật để xác thực.
-   **`env`** _(String)_: Môi trường SDK đang chạy (`"uat"` hoặc `"prod"`).
-   **`userInfo`** _([String: Any])_: Thông tin người dùng.
-   **`onMessage`** _(Closure)_: Hàm callback được gọi khi nhận thông điệp từ server. Các sự kiện bao gồm:
    -   **`hangup`**: End the call.
    -   **`mutevideo`**: Mute the video.
    -   **`facingmode`**: Switch the camera.
    -   **`muteaudio`**: Mute the audio.
    -   **`endcall`**: The call has ended.

### **WorldfoneProCallView (SwiftUI)**

Tương tự như `WorldfoneProCall`, nhưng được đóng gói để sử dụng trong SwiftUI.

---

## **Yêu cầu hệ thống**

-   iOS 13.0 trở lên.
-   Swift 5.0 trở lên.

## Tác giả

-   Southtelecom
