import Hello from "./smart-contract/d2hello.cdc"

pub fun main() {
  let name = "FastFloward"
  Hello.sayHi(to: name)
}