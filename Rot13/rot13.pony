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

// vim:expandtab ff=dos fenc=utf-8 sw=2
