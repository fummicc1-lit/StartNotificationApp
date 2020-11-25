//
//  ViewController.swift
//  StartNotificationApp
//
//  Created by Fumiya Tanaka on 2020/11/25.
//

import UIKit
import UserNotifications

class TimeIntervalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 通知の許可をリクエストする
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { (_, _) in
        }
    }

    @IBAction func addNotification() {
        // 通知のトリガー
        // 10秒後に通知を鳴らす
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        // 通知の内容（タイトル・バッジ・サウンドなど）
        let content = UNMutableNotificationContent()
        content.title = "通知テスト"
        content.badge = 1
        // トリガー・内容をまとめてリクエストクラスを生成する
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // リクエストを通知センターの追加する
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            print(error)
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "通知を登録しました", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
}

