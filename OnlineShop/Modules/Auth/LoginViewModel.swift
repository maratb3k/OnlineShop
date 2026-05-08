//
//  LoginViewModel.swift
//  Turmys App
//
//  Created by Yerkezhan Zheneessova on 10.04.2025.
//

import Foundation
import Combine

class LoginViewModel {

    // MARK: - Input
    @Published var email: String?
    @Published var password: String?

    // MARK: - Output
    @Published private(set) var isReadyToSignIn: Bool = false

    // MARK: - Private
    private let authService = AuthService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscriptions()
    }

    private func setupSubscriptions() {
        $email.combineLatest($password)
            .map { email, password in
                email != nil && password != nil
            }
            .removeDuplicates()
            .assign(to: \.isReadyToSignIn, on: self)
            .store(in: &cancellables)
    }

    func signIn() -> AnyPublisher<AuthUser, Error> {
        guard let email = email, let password = password else {
            let error = NSError(
                domain: "com.turmysapp.auth",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "Invalid email or password. Please try again."]
            )
            return Fail(error: error).eraseToAnyPublisher()
        }
        return authService.signIn(email: email, password: password)
    }
}
