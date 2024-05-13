//
//  GoogleSignIn.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import GoogleSignIn

class GoogleSignIn {
    
    class func signIn(from viewController: UIViewController? = UIApplication.getTopViewController(), _ completion: @escaping (Result<GIDGoogleUser, Error>) -> Void) {
        guard let viewController else {
            completion(.failure(GoogleSignInError.vcNotFound))
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let signInResult else {
                completion(.failure(GoogleSignInError.resultNotFound))
                return
            }
            
            completion(.success(signInResult.user))
        }
    }
    
    class func isCurrentUser() -> Bool {
        if GIDSignIn.sharedInstance.currentUser != nil {
            return true
        }
        return false
    }
    
    class func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
    
}

enum GoogleSignInError: String, Error {
    case resultNotFound = "Sign-in result is nil"
    case vcNotFound = "ViewController not found"
}

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
}
