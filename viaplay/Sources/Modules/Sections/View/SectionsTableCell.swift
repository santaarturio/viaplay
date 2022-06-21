import UIKit

extension Sections {
  
  final class TableCell: UITableViewCell {
    private let shadowView = ShadowView()
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
    shadowView.addSubview(titleLabel)
    contentView.addSubview(shadowView)
  }
  
  func setupConstraints() {
    shadowView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      shadowView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
      shadowView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
      shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 16),
      titleLabel.leftAnchor.constraint(equalTo: shadowView.leftAnchor, constant: 16),
      titleLabel.rightAnchor.constraint(equalTo: shadowView.rightAnchor, constant: -16),
      titleLabel.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -16)
    ])
  }
  
  func setupAdditionalConfigurations() {
    selectionStyle = .none
    shadowView.backgroundColor = .systemBackground
    titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
  }
}
