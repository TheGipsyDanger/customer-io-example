//
//  MyAppPushNotificationsHandler.swift
//  customerioexample
//
//  Created by Renan Henrique Da Fonte Costa on 05/08/24.
//

import Foundation
import CioMessagingPushAPN
import UserNotifications
import CioTracking

@objc
public class MyAppPushNotificationsHandler : NSObject {

  public override init() {}
  
  @objc(initializeCioSdk)
  public func initializeCioSdk() {
    //TODO: implementar uma biblioteca para ler o ambiente do app.config que está sendo executado e atualizar as variáveis aqui por meio das variáveis de ambiente
    CustomerIO.initialize(siteId: "3c8dfe0a9837af0a23de", apiKey: "781ff11e6b2d83e1f305", region: Region.US, configure: nil)
  }

//  // Skip this function if you don't want to request push permissions on launch.
//  // Use `customerio-reactnative` version `>= 2.2.0` to display native push permission prompt from your JS code.
//  // Scroll down to `Prompt users to opt-into push notifications` section
//  @objc(registerPushNotification:)
//  public func registerPushNotification(withNotificationDelegate notificationDelegate: UNUserNotificationCenterDelegate) {
//
//    let center  = UNUserNotificationCenter.current()
//    center.delegate = notificationDelegate
//    center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
//      if error == nil{
//        DispatchQueue.main.async {
//          UIApplication.shared.registerForRemoteNotifications()
//        }
//      }
//    }
//  }

  @objc(application:deviceToken:)
  public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    MessagingPush.shared.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }

  @objc(application:error:)
  public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    MessagingPush.shared.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
  }

  @objc(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)
  public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let handled = MessagingPush.shared.userNotificationCenter(center, didReceive: response,
  withCompletionHandler: completionHandler)

    // If the Customer.io SDK does not handle the push, it's up to you to handle it and call the
    // completion handler. If the SDK did handle it, it called the completion handler for you.
    if !handled {
      completionHandler()
    }
  }
}
