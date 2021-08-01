import Hello from "./smart-contract/d3hello.cdc"

pub fun main(name: String): String {
  return Hello.sayHi(to: name)
}
