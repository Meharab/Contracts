import Hello from "./d3hello.cdc"

transaction {

  let name: String

  prepare(account: AuthAccount) {
    self.name = account.address.toString()
  }

  execute {
    Hello.sayHi(to: self.name)
  }
}
