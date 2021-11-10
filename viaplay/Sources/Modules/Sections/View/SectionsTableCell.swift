import UIKit

extension Sections {
  
  final class TableCell: UITableViewCell {
    private let shadowView = ShadowView()
    private let baseView = UIView()
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupView()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func configure(section: ViaplaySection) {
      titleLabel.text = section.title
    }
  }
}

extension Sections.TableCell: ViewCode {
  
  func setupViewHierarhcy() {
    baseView.addSubview(titleLabel)
    [shadowView, baseView]
      .forEach(contentView.addSubview)
  }
  
  func setupConstraints() {
    [shadowView, baseView]
      .forEach { view in
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
          view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
          view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
          view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
      }
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 16),
      titleLabel.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: 16),
      titleLabel.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: -16),
      titleLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -16)
    ])
  }
  
  func setupAdditionalConfigurations() {
    selectionStyle = .none
    
    baseView.backgroundColor = .systemBackground
    baseView.layer.cornerRadius = 10
    baseView.layer.masksToBounds = true
    
    titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
  }
}
