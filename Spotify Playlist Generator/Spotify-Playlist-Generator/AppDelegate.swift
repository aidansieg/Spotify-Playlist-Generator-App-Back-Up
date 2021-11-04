import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SPTSessionManagerDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {

    var window: UIWindow?
    lazy var rootViewController = ViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        rootViewController.sessionManager.application(app, open: url, options: options)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if (rootViewController.appRemote.isConnected) {
            rootViewController.appRemote.disconnect()
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if let _ = rootViewController.appRemote.connectionParameters.accessToken {
            rootViewController.appRemote.connect()
        }
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
      print("connected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
      print("disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
      print("failed")
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
      print("player state changed")
    }
    
//    lazy var appRemote: SPTAppRemote = {
//      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
//      appRemote.connectionParameters.accessToken = self.accessToken
//      appRemote.delegate = self
//      return appRemote
//    }()

    
    // might be able to delete everything below
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
      print("success", session)
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
      print("fail", error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
      print("renewed", session)
    }
    
//    let SpotifyClientID = "605bd946887e45a9ac5e2f29683d02fd"
//    let SpotifyRedirectURL = URL(string: "SpotifyPlaylistGenerator://")!
//
//    lazy var configuration = SPTConfiguration(
//      clientID: SpotifyClientID,
//      redirectURL: SpotifyRedirectURL
//    )
}

