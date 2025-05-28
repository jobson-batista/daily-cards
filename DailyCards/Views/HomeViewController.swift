//
//  HomeViewController.swift
//  DailyCards
//
//  Created by Jobson on 25/05/25.
//

import UIKit

class HomeViewController: UIViewController, ViewProtocol, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
  
    public var coordinator: AppCoordinator?
    private var cardModelView: CardModelView = CardModelView.shared
    private var categoryModelView: CategoryModelView = CategoryModelView.shared
    private var categories: [Category] = []
    private var categoriesFiltred: [Category] = []
    
    public lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }()
    
    public lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .backgroud
        tableView.separatorStyle = .none
        return tableView
    }()
    
    public lazy var createCategoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.backgroundColor = .buttonPrimary
        button.tintColor = .textPrimary
        button.setTitle("Criar Categoria", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.info("Rodando... \(String(describing: type(of: self)))")
        view.backgroundColor = .backgroud
        updateData()
        
        
        setupNavigationItem()
        setupHierarchy()
        setupConstraints()
        setupTableView()
        setupKeyboardObservers()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            createCategoryButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    func setupHierarchy() {
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(createCategoryButton)
        
        view.addSubview(stackView)
    }
    
    func setupNavigationItem() {
        self.navigationItem.title = "Categorias de Estudo"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Buscar categoria"
        searchController.isActive = true
        self.navigationItem.searchController = searchController
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesFiltred.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UITableViewCell()
        }

        let category = categoriesFiltred[indexPath.row]
        
        cell.label.text = category.name
        cell.labelDescription.text = category.description
        cell.image.image = UIImage(systemName: category.imageSystemName)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            Log.error("Erro ao buscar categoria.")
            return
        }
        
        if !text.isEmpty {
            self.categoriesFiltred = categories.filter({ category in
                category.name.localizedCaseInsensitiveContains(text) ||
                category.description.localizedCaseInsensitiveContains(text)
            })
        } else {
            self.categoriesFiltred = self.categories
        }
        tableView.reloadData()
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupDismissKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func updateData() {
        categories = categoryModelView.fetchData()
        categoriesFiltred = categories
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            tableView.contentInset.bottom = keyboardFrame.height + 10
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        tableView.contentInset.bottom = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func addCategory() {
        let addCategoryModal = AddCategoryModalViewController()
        addCategoryModal.modalPresentationStyle = .automatic
        addCategoryModal.modalTransitionStyle = .coverVertical
        let newNavController = UINavigationController(rootViewController: addCategoryModal)
        addCategoryModal.onSaveCategory = { [weak self] in
            self?.updateData()
            self?.tableView.reloadData()
        }
        
        present(newNavController, animated: true, completion: nil)
        tableView.reloadData()
    }

}
