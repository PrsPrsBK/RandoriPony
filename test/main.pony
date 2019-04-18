use "ponytest"
use "package:../Collatz"
use "package:../Rot13"
use "package:../SternBrocot"

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)
  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestCollatz)
    test(_TestRot13)
    test(_TestFarey)

class iso _TestCollatz is UnitTest
  fun name(): String => "Next Number in Collatz Sequence"
  fun apply(h: TestHelper) =>
    h.assert_eq[U64](3, Collatz[U64].next_one(6))
    h.assert_eq[U64](34, Collatz[U64].next_one(11))

class iso _TestRot13 is UnitTest
  fun name(): String => "Rot13"
  fun apply(h: TestHelper) =>
    h.assert_eq[String]("nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM", Rot13.convert("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))
    h.assert_eq[String]("12345nopqrstuvwxyzポニーabcdefghijklm67890", Rot13.convert("12345abcdefghijklmポニーnopqrstuvwxyz67890"))

class iso _TestFarey is UnitTest
  fun name(): String => "Get ratio by walk on Stern-Brocot Tree"
  fun apply(h: TestHelper) =>
    var wk_ratio = SternBrocot.get_ratio(0.5)
    h.assert_eq[U64](1, wk_ratio.fst)
    h.assert_eq[U64](2, wk_ratio.snd)
    wk_ratio = SternBrocot.get_ratio(0.2777)
    // I choiced 5/18 at F_10(after loop nth = 9), and equal 0.27777...
    h.assert_eq[U64](5, wk_ratio.fst)
    h.assert_eq[U64](18, wk_ratio.snd)
    // Pi. I expected 16/113. without epsilon, 9/64. with epsilon 0.0001, 15/106.
    wk_ratio = SternBrocot.get_ratio(0.1415926535, 0.00005)
    h.assert_eq[U64](16, wk_ratio.fst)
    h.assert_eq[U64](113, wk_ratio.snd)

// vim:expandtab ff=dos fenc=utf-8 sw=2
