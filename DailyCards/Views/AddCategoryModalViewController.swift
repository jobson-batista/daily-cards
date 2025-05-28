//
//  CreateCategoryViewController.swift
//  DailyCards
//
//  Created by Jobson on 27/05/25.
//

import UIKit

class AddCategoryModalViewController: UIViewController, ViewProtocol, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let sfSymbols = ["folder", "star", "heart", "book", "bookmark", "chart.bar"]
    var selectedSymbolName = ""
    
    var onSaveCategory: (() -> Void)? // Callback para avisar a HomeVC
    
    public lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    public lazy var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    public lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome"
        label.textColor = .textPrimary
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    public lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Descrição"
        label.textColor = .textPrimary
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    public lazy var iconLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ícone"
        label.textColor = .textPrimary
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    public lazy var nameTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        textField.layer.cornerRadius = 5
        textField.textColor = .textPrimary
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .white
        let paddingText = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingText
        textField.leftViewMode = .always
        textField.delegate = self
        return textField
    }()
    
    public lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 5
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        textView.delegate = self
        return textView
    }()
    
    public lazy var symbolTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    public lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        symbolTextField.inputView = pickerView
        return pickerView
    }()
    
    public lazy var selectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroud
        
        setupNavigationItem()
        setupHierarchy()
        setupConstraints()
        setupDismissKeyboardOnTap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        nameTextField.becomeFirstResponder() // adiciona o foco quando a view controller é carregada
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100),
            
        ])
    }
    
    func setupHierarchy() {
        contentStack.addArrangedSubview(nameLabel)
        contentStack.addArrangedSubview(nameTextField)
        contentStack.addArrangedSubview(descriptionLabel)
        contentStack.addArrangedSubview(descriptionTextView)
        contentStack.addArrangedSubview(iconLabel)
        contentStack.addArrangedSubview(pickerView)

        scrollView.addSubview(contentStack)
        view.addSubview(scrollView)
    }
    
    func setupNavigationItem() {
        self.navigationItem.title = "Adicionar Categoria"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }
    
    func setupDismissKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func save() {
        let newCategory = Category(name: self.nameTextField.text ?? "", cards: [], description: self.descriptionTextView.text, imageSystemName: self.selectedSymbolName)
        
        if (isValidFields()) {
            let categoryModelView = CategoryModelView.shared
            categoryModelView.addCategory(category: newCategory)
            onSaveCategory?() // Notificar HomeVC
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func cancel() {
        Log.info("\(self.nameTextField.text ?? "None") cancelou!")
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            descriptionTextView.becomeFirstResponder()
        } else if textField == descriptionTextView {
            textField.resignFirstResponder() // oculta o teclado
        }
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sfSymbols.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .buttonPrimary
        
        if let image = UIImage(systemName: sfSymbols[row]) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "folder")
        }
        
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedSymbolName = sfSymbols[row]
        symbolTextField.text = self.selectedSymbolName
        selectedImageView.image = UIImage(systemName: self.selectedSymbolName)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let maxLength = 30
        let currentString = (textView.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: text)

        return newString.count <= maxLength
    }
    
    private func alert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func isValidFields() -> Bool {
        if (nameTextField.text == nil || nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            Log.error("O campo Nome não pode ser vazio!")
            alert("Atenção", "O campo Nome não pode ser vazio!")
            return false
        } else if (descriptionTextView.text == nil || descriptionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            Log.error("O campo Descrição não pode ser vazio!")
            alert("Atenção", "O campo Descrição não pode ser vazio!")
            return false
        } else if (selectedSymbolName.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            Log.error("O campo Symbol Name não pode ser vazio!")
            alert("Atenção", "Selecione um ícone válido!")
            return false
        }
        return true
    }
}
