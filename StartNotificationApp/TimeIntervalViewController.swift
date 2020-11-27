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
        //(通知を送るにはユーザーの許可が必要)
        //通知の許可をユーザーに求める
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { (_, _) in
        }
    }

    //「通知を登録」ボタンと関連付けしている（TouchUpInside）
    @IBAction func addNotification() {
        // 通知のトリガー
        // 10秒後に通知を鳴らす
        let trigger: UNTimeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        // 通知の内容（タイトル・バッジ・サウンドなど）
        let content: UNMutableNotificationContent = UNMutableNotificationContent()
        content.title = "通知テスト"
        content.badge = 1
        // トリガー・内容をまとめてリクエストクラスを生成する
        let request: UNNotificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // リクエストを通知センターの追加する
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error: Error?) in
            print(error)
            // 通知の追加に関して、エラーが発生したかをif文で確認する
            if error == nil {
                //DispatchQueue.main.asyncは気にしないでも大丈夫
                DispatchQueue.main.async {
                    //アラートを表示する
                    let alert = UIAlertController(title: "通知を登録しました", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                print("エラーが発生")
            }
        })
    }
}

