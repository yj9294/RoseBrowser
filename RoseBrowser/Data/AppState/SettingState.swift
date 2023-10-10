//
//  SettingState.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/24.
//

import Foundation

extension AppState {
    struct Setting {
        
        enum Index: String {
            case new, share, copy, rate , terms, privacy
            
            var title: String {
                switch self {
                case .new, .share, .copy:
                    return self.rawValue.capitalized
                case .rate:
                    return "Rate us"
                case .terms:
                    return "Terms of User"
                case .privacy:
                    return "Privacy Policy"
                }
            }
        }
        
        enum WebPageIndex {
            case privacy, terms
            var title: String {
                if self == .privacy {
                    return "Privacy Policy"
                } else {
                    return "Terms of Users"
                }
            }
            var body: String {
                if self == .privacy {
                    return """
(We or Us) provides this Privacy Policy to help you understand how we collect, use and disclose information, including what you may provide to us or that we obtain from our products and services. We treat your privacy very seriously. Your privacy is important to us.

Information Collection and Use

- Personal information is data that can be used to uniquely identify or contact a single person.

- We DO NOT collect, store or use any personal information while you visit, download or upgrade our application or our products, excepting the personal information that you submit to us when you send an error report.

- Only for the following purposes that we may use personal information submitted by you: help us develop, deliver, and improve our products and services and supply higher quality service; manage online surveys and other activities you've participated in.

- In the following circumstances, we may disclose your personal information according to your wish or regulations by law:

(1) Your prior permission

(2) By the applicable law within or outside your country of residence, legal process, litigation requests

(3) By requests from public and governmental authorities

(4) To protect our legal rights and interests.

How we share information

We may engage third party companies and individuals for the following reasons:

Promote our services;

Provide services on our behalf;

Perform services related to the service;

Help us analyze how to make our service better.

Update

We may update Privacy Policy from time to time. When we change the policy in a material way, a notice will be posted on our website along with the updated Privacy Policy.

Contact us

If you have any questions or concerns about our Privacy Policy or data processing, please contact us:

goujincheng123456789@outlook.com


Terms of use

Please read these usage terms in detail.

Use of the application

1. You agree that we will use your information for the purposes required by laws and regulations.

2. You acknowledge that you may not use our App for illegal purposes.

3. You agree that we may discontinue providing our products and services at any time without prior notice.

4. By agreeing to download or install our software, you accept our Privacy Policy.

Update

We may update Privacy Policy from time to time. When we change the policy in a material way, a notice will be posted on our website along with the updated Privacy Policy.

Contact us

If you have any questions or concerns about our Privacy Policy or data processing, please contact us:

goujincheng123456789@outlook.com
"""
                } else {
                    return """
Please read these usage terms in detail.
Use of the application
1. You agree that we will use your information for the purposes required by laws and regulations.
2. You acknowledge that you may not use our App for illegal purposes.
3. You agree that we may discontinue providing our products and services at any time without prior notice.
4. By agreeing to download or install our software, you accept our Privacy Policy.
Update
We may update Privacy Policy from time to time. When we change the policy in a material way, a notice will be posted on our website along with the updated Privacy Policy.
Contact us
If you have any questions or concerns about our Privacy Policy or data processing, please contact us:
goujincheng123456789@outlook.com
"""
                }
            }
        }
    }
}
