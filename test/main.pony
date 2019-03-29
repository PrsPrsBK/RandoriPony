use "ponytest"
use "package:../Collatz"

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)
  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestCollatz)

class iso _TestCollatz is UnitTest
  fun name(): String => "Next Number in Collatz Sequence"
  fun apply(h: TestHelper) =>
    h.assert_eq[U64](3, Collatz[U64].next_one(6))
    h.assert_eq[U64](34, Collatz[U64].next_one(11))
