//
//  UICategoryCell.swift
//  DailyCards
//
//  Created by Jobson on 25/05/25.
//

import UIKit

class CategoryCell: UITableViewCell,  ViewProtocol {

    static let identifier = "cellCategories"
    
    public lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.semanticContentAttribute = .forceLeftToRight
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 10
        return stack
    }()
    
    public lazy var stackLabels = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fill
        stack.alignment = .firstBaseline
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 5
        return stack
    }()
    
    public lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .buttonPrimary
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .backgroud
        
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            stack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            image.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setupHierarchy() {
        stack.addArrangedSubview(image)
        
        stackLabels.addArrangedSubview(label)
        stackLabels.addArrangedSubview(labelDescription)
        
        stack.addArrangedSubview(stackLabels)
        
        contentView.addSubview(stack)
    }
}
