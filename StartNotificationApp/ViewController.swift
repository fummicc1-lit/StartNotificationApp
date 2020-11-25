//
//  ViewController.swift
//  StartNotificationApp
//
//  Created by Fumiya Tanaka on 2020/11/25.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { (_, _) in
        }
    }

    @IBAction func addNotification() {
        // 選択した日付
        let date = datePicker.date
        // カレンダークラス
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        // 通知のトリガー
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        // 通知の内容（タイトル・バッジ・サウンドなど）
        let content = UNMutableNotificationContent()
        content.title = "通知テスト"
        content.badge = 1
        // トリガー・内容をまとめてリクエストクラスを生成する
        let request = UNNotificationRequest(identifier: "\(date)", content: content, trigger: trigger)
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

