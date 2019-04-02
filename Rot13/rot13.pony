// last() is not necessary, 
// but remains for later trial to do Range or Span like things [first...last]
primitive UpperCase
  fun first(): U32 => 0x41
  fun last(): U32 => 0x5A

primitive LowerCase
  fun first(): U32 => 0x61
  fun last(): U32 => 0x7A

primitive Rot13
  fun convert(origText: String): String =>
    var result: String = ""
    // NEXT: use Sequence or yield or so
    for rune in origText.runes() do
      // failed to use String.push_utf32()
      // result.push_utf32(rotate(rune))
      result = result.add(String.from_utf32(rotate(rune)))
    end
    result

  fun rotate(orig: U32): U32 =>
    if (UpperCase.first() <= orig) and (orig <= UpperCase.last()) then
      UpperCase.first() + ((13 + (orig - UpperCase.first())) %% 26)
    elseif (LowerCase.first() <= orig) and (orig <= LowerCase.last()) then
      LowerCase.first() + ((13 + (orig - LowerCase.first())) %% 26)
    else
      orig
    end

primitive Upper
primitive Lower
primitive Other
type CasePat is (Upper|Lower|Other)
primitive Rot13PatA
  fun apply(some: U32): (CasePat, U32) =>
    if inRange(Upper, some) then
      (Upper, rotate(Upper, some))
    elseif inRange(Lower, some) then
      (Lower, rotate(Lower, some))
    else
      (Other, some)
    end

  fun inRange(case: CasePat, some: U32): Bool =>
    if (first(case) <= some) and (some <= (25 + first(case))) then true else false end

  fun first(some: CasePat): U32 =>
    match some
    | Upper => 0x41
    | Lower => 0x61
    | Other => 0
    end

  fun rotate(case: CasePat, orig: U32): U32 =>
    first(case) + ((13 + (orig - first(case))) %% 26)

primitive Rot13PatB
  fun apply(some: U32): CasePat =>
    if inRange(Upper, some) then
      Upper
    elseif inRange(Lower, some) then
      Lower
    else
      Other
    end

  fun inRange(case: CasePat, some: U32): Bool =>
    if (first(case) <= some) and (some <= (25 + first(case))) then true else false end

  fun first(some: CasePat): U32 =>
    match some
    | Upper => 0x41
    | Lower => 0x61
    | Other => 0
    end

  fun rotate(case: CasePat, orig: U32): U32 =>
    first(case) + ((13 + (orig - first(case))) %% 26)

primitive PatAdapt
  fun convertA(origText: String): String =>
    var result: String = ""
    for rune in origText.runes() do
      result = result.add(String.from_utf32(Rot13PatA(rune)._2))
    end
    result

  fun convertB(origText: String): String =>
    var result: String = ""
    for rune in origText.runes() do
      result = result.add(String.from_utf32(
        match Rot13PatB(rune)
        | Upper => Rot13PatB.rotate(Upper, rune)
        | Lower => Rot13PatB.rotate(Lower, rune)
        | Other => rune
        end
      ))
    end
    result

// vim:expandtab ff=dos fenc=utf-8 sw=2
