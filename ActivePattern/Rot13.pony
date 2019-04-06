/*
  **Not Nice**
  F#'s ActivePattern
  https://docs.microsoft.com/ja-jp/dotnet/fsharp/language-reference/active-patterns
  such as ...

  let (|Lower|Upper|Other|) (x: int) =
    if 0x41 <= x && x <= 0x5A then
      Lower x
    else if 0x61 <= x && x <= 0x7A then
      Upper x
    else
      Other

*/

primitive Upper
primitive Lower
primitive Other
type LetterCase is (Upper|Lower|Other)

primitive Rot13
  fun apply(rune: U32): LetterCase =>
    if in_range(Upper, rune) then
      Upper
    elseif in_range(Lower, rune) then
      Lower
    else
      Other
    end

  fun in_range(case: LetterCase, rune: U32): Bool =>
    if (first(case) <= rune) and (rune <= (25 + first(case))) then true else false end

  fun first(case: LetterCase): U32 =>
    match case
    | Upper => 0x41
    | Lower => 0x61
    | Other => 0 // dummy...
    end

  fun rotate(case: LetterCase, origRune: U32): U32 =>
    first(case) + ((13 + (origRune - first(case))) %% 26)

  fun convert(origText: String): String =>
    var result: String = ""
    for rune in origText.runes() do
      result = result.add(String.from_utf32(
        match Rot13(rune)
        | Upper => Rot13.rotate(Upper, rune)
        | Lower => Rot13.rotate(Lower, rune)
        | Other => rune
        end
      ))
    end
    result

  fun apply_b(rune: U32): (LetterCase, U32) =>
    if in_range(Upper, rune) then
      (Upper, rotate(Upper, rune))
    elseif in_range(Lower, rune) then
      (Lower, rotate(Lower, rune))
    else
      (Other, rune)
    end

  fun convert_b(origText: String): String =>
    var result: String = ""
    for rune in origText.runes() do
      result = result.add(String.from_utf32(Rot13.apply_b(rune)._2))
    end
    result

// vim:expandtab ff=dos fenc=utf-8 sw=2
