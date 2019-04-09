use "debug"

primitive SternBrocot
  fun get_ratio(target: F64, epsilon: F64 = 0.001): (U64, U64) =>
    var nth: U64 = 1
    var left: (U64, U64, F64) = (0, 1, 0.0)
    var center: (U64, U64, F64) = (1, 2, 0.5)
    var right: (U64, U64, F64) = (1, 1, 1.0)
    var enough = false
    var answer: (U64, U64) = (1, 1)
    repeat
      Debug.out(nth.string() + " " + left._1.string() + "/" + left._2.string() + " " + center._1.string() + "/" + center._2.string() + " " + right._1.string() + "/" + right._2.string())
      if epsilon >= (target - left._3) then
        answer = (left._1, left._2)
        enough = true
      elseif epsilon >= (target - center._3).abs() then
        answer = (center._1, center._2)
        enough = true
      elseif epsilon >= (right._3 - target) then
        answer = (right._1, right._2)
        enough = true
      else
        answer = (center._1, center._2)
      end
      if enough == false then
        if (left._3 <= target) and (target <= center._3) then
          right = center
          center = ((left._1 + center._1), (left._2 + center._2), 
            ((left._1 + center._1).f64() / (left._2 + center._2).f64()) )
        else
          left = center
          center = ((right._1 + center._1), (right._2 + center._2), 
            ((right._1 + center._1).f64() / (right._2 + center._2).f64()) )
        end
        nth = 1 + nth
      end
    until (nth > 256) or enough end
    Debug.out(nth.string() + " " + enough.string())
    answer

// vim:expandtab ff=dos fenc=utf-8 sw=2
