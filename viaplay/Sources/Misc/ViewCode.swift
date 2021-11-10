
protocol ViewCode {
  func setupViewHierarhcy()
  func setupConstraints()
  func setupAdditionalConfigurations()
  func setupView()
}

extension ViewCode {
  func setupView() {
    setupViewHierarhcy()
    setupConstraints()
    setupAdditionalConfigurations()
  }
}
