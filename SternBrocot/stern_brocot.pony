use "debug"

class Ratio
  var fst: U64
  var snd: U64
  var calc: F64
  new create(f: U64, s: U64) =>
    fst = f
    snd = s
    calc = f.f64() / s.f64()

  fun diff(some: F64): F64 => some - calc

  fun get_calc(): F64 => calc

  fun get_pair(): (U64, U64) => (fst, snd)

  fun mediant(some: Ratio): Ratio =>
    Ratio(fst + some.fst, snd + some.snd)

  fun string(): String => fst.string() + "/" + snd.string()

primitive SternBrocot
  fun get_ratio(target: F64, epsilon: F64 = 0.001): Ratio =>
    var nth: U64 = 1
    var left: Ratio = Ratio(0, 1)
    var center: Ratio = Ratio(1, 2)
    var right: Ratio = Ratio(1, 1)
    var enough = false
    var answer: Ratio = Ratio(1, 1)
    repeat
      Debug.out(nth.string() + " " + left.string() + " " + center.string() + " " + right.string())
      if epsilon >= left.diff(target) then
        answer = left
        enough = true
      elseif epsilon >= center.diff(target).abs() then
        answer = center
        enough = true
      elseif epsilon >= right.diff(target).abs() then
        answer = right
        enough = true
      else
        answer = center //no reason
      end
      if enough == false then
        if target <= center.get_calc() then
          right = center
          center = center.mediant(left)
        else
          left = center
          center = center.mediant(right)
        end
        nth = 1 + nth
      end
    until (nth > 256) or enough end
    Debug.out(nth.string() + " " + enough.string())
    answer

// vim:expandtab ff=dos fenc=utf-8 sw=2
