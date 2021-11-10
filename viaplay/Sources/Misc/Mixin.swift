
class Mixin<Base> {
  
  private let constructor: () -> Base
  
  var base: Base {
    constructor()
  }
  
  init(constructor: @escaping () -> Base) {
    self.constructor = constructor
  }
  
  init(base: Base) {
    constructor = { base }
  }
}
