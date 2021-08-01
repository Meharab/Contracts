pub contract Hello {
  pub fun sayHi(to name: String) {
    log("Hi, ".concat(name))
  }
}
