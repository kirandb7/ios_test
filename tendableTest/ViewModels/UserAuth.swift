import Combine
import SwiftUI
import Security

class UserAuth: ObservableObject {
    @Published var email: String = Constant.Common().empty
    @Published var password: String = Constant.Common().empty
    @Published var formIsValid = false
    @Published var isLogged: Bool = false
    
    var cancellable: AnyCancellable?
    private var lastActivity: Date = Date()
    private let inactivityTimeout: TimeInterval = 120 * 60 // 120 minutes
    private var publishers = Set<AnyCancellable>()
    
    init() {
        isLogged = false
        isSignupFormValidPublisher
              .receive(on: RunLoop.main)
              .assign(to: \.formIsValid, on: self)
              .store(in: &publishers)
    }

    func signIn(email: String, password: String) {
        // Here you should add the logic to validate the user credentials
        
        let loginRequest = LoginRequest(email: email, password: password)
        let service = AuthService(networkRequest: NativeRequestable(), environment: .development)
        cancellable = service.login(request: loginRequest).sink { (completion) in
            switch completion {
            case .failure(let error):
                debugPrint("error = \(error.localizedDescription)")
            case .finished:break
            }
        } receiveValue: { (response) in
            debugPrint("response = \(response)")
            DispatchQueue.main.async {
                self.isLogged = true
            }
        }
    }

    func signOut() {
        isLogged = false
        // Add logic to remove credentials from keychain
    }

    func handleUserActivity() {
        let now = Date()
        if now.timeIntervalSince(lastActivity) > inactivityTimeout {
            signOut()
        } else {
            lastActivity = now
        }
    }
    
    // Keychain functions
    private func storePassword(password: String, account: String) -> Bool {
       return false
    }

    private func retrievePassword() -> String? {
        return "false"
    }
}

private extension UserAuth {
    var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
          .map { email in
              let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
              return emailPredicate.evaluate(with: email)
          }
          .eraseToAnyPublisher()
      }
      
      var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
          .map { password in
              return password.count >= 8
          }
          .eraseToAnyPublisher()
      }
      
      var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
          isUserEmailValidPublisher,
          isPasswordValidPublisher
          )
          .map {isEmailValid, isPasswordValid in
              return isEmailValid && isPasswordValid
          }
          .eraseToAnyPublisher()
      }
}

