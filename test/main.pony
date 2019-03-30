use "ponytest"
use "package:../Collatz"
use "package:../Rot13"

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)
  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestCollatz)
    test(_TestRot13)

class iso _TestCollatz is UnitTest
  fun name(): String => "Next Number in Collatz Sequence"
  fun apply(h: TestHelper) =>
    h.assert_eq[U64](3, Collatz[U64].next_one(6))
    h.assert_eq[U64](34, Collatz[U64].next_one(11))

class iso _TestRot13 is UnitTest
  fun name(): String => "Rot13"
  fun apply(h: TestHelper) =>
    // h.assert_eq[MojiClass](Lower, Rot13.which("p"))
    h.assert_eq[String]("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", Rot13.convert("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))
