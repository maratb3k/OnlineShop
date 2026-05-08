//
//  AppCoordinator.swift
//  Turmys App
//
//  Created by Assem Maratbek on 30.03.2026.
//

import UIKit
import Combine

final class AppCoordinator: Coordinator {

    // MARK: - Properties
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let authService = AuthService()

    private weak var homeNavigationController: UINavigationController?
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    private init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
        self.navigationController = UINavigationController()
    }

    static func start(windowScene: UIWindowScene) -> AppCoordinator {
        let coordinator = AppCoordinator(windowScene: windowScene)
        coordinator.start()
        return coordinator
    }

    // MARK: - Coordinator
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        authService.authStateDidChangePublisher
            .first()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let self else { return }
                if !UserDefaults.standard.hasSeenOnboarding {
                    self.showOnboarding()
                } else if let user = user {
                    self.fetchProfileAndRoute(user: user)
                } else {
                    self.showLogin()
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Auth State
    private func fetchProfileAndRoute(user: AuthUser) {
        authService.fetchUserProfile(uid: user.uid)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure = completion {
                        self?.routeByRole()
                    }
                },
                receiveValue: { [weak self] profile in
                    UserDefaults.standard.userRole = profile.role
                    UserDefaults.standard.customerName = "\(profile.firstName) \(profile.lastName)"
                    self?.routeByRole()
                }
            )
            .store(in: &cancellables)
    }

    private func routeByRole() {
        switch UserDefaults.standard.userRole {
        case .customer:    showCustomerHome()
        case .contractor:  showContractorHome()
        case .none:        showLogin()
        }
    }

    // MARK: - Home Screens
    private func showCustomerHome() {
        let homeVC = CustomerHomeViewController(viewModel: CustomerHomeViewModel())
        homeVC.onAddTaskTap = { [weak self] in self?.showCreateTask() }
        homeVC.onTaskTap    = { [weak self] task in self?.showTaskDetails(task: task) }
        homeVC.onLogout     = { [weak self] in self?.handleLogout() }
        homeVC.tabBarItem   = UITabBarItem(title: "Задачи", image: UIImage(systemName: "list.bullet"), tag: 0)

        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNavigationController = homeNav
        navigationController.setViewControllers([makeTabBar(homeNav: homeNav)], animated: true)
    }

    private func showContractorHome() {
        let homeVC = ContractorHomeViewController(viewModel: ContractorHomeViewModel())
        homeVC.onTaskTap = { [weak self] task in self?.showTaskDetails(task: task) }
        homeVC.onLogout  = { [weak self] in self?.handleLogout() }
        homeVC.tabBarItem = UITabBarItem(title: "Задачи", image: UIImage(systemName: "briefcase"), tag: 0)

        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNavigationController = homeNav
        navigationController.setViewControllers([makeTabBar(homeNav: homeNav)], animated: true)
    }

    private func makeTabBar(homeNav: UINavigationController) -> UITabBarController {
        let profileVC = ProfileViewController(viewModel: ProfileViewModel())
        profileVC.onLogout    = { [weak self] in self?.handleLogout() }
        profileVC.tabBarItem  = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 1)
        let profileNav = UINavigationController(rootViewController: profileVC)

        let tabBar = UITabBarController()
        tabBar.viewControllers = [homeNav, profileNav]
        tabBar.tabBar.tintColor = .turmysTerracotta
        return tabBar
    }

    // MARK: - Task Screens
    private func showCreateTask() {
        let vc = CreateTaskViewController(viewModel: CreateTaskViewModel())
        vc.onTaskCreated = { [weak self] in
            self?.homeNavigationController?.popViewController(animated: true)
        }
        homeNavigationController?.pushViewController(vc, animated: true)
    }

    private func showTaskDetails(task: TaskModel) {
        let vc = TaskDetailsViewController(viewModel: TaskDetailsViewModel(task: task))
        homeNavigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Auth Flow
    private func showLogin() {
        let vc = LoginViewController(viewModel: LoginViewModel())
        vc.onLoginSuccess = { [weak self] user in self?.fetchProfileAndRoute(user: user) }
        vc.onSignUpTap    = { [weak self] in self?.showSignUp() }
        navigationController.setViewControllers([vc], animated: true)
    }

    private func showSignUp() {
        let vc = SignUpViewController(viewModel: SignUpViewModel())
        vc.onSignUpSuccess = { [weak self] in self?.routeByRole() }
        navigationController.pushViewController(vc, animated: true)
    }

    private func showOnboarding() {
        let vc = OnboardingViewController()
        vc.onContinue = { [weak self] in
            UserDefaults.standard.hasSeenOnboarding = true
            self?.showLogin()
        }
        navigationController.pushViewController(vc, animated: true)
    }

    // MARK: - Logout
    private func handleLogout() {
        try? authService.logout()
        UserDefaults.standard.userRole = nil
        showLogin()
    }
}
