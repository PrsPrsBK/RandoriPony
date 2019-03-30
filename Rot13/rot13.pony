primitive Upper
primitive Lower
primitive Other
type MojiClass is (Upper|Lower|Other)

// works only for single char strings.
// and not yet 'rot'. just Lower <-> Upper.
primitive Rot13
  fun which(moji: String): MojiClass =>
    try
      // let x = moji.utf32(0)
      let x = moji.at_offset(0)?
      if (0x41 <= x) and (x <= 0x5A) then
        Upper
      elseif (0x61 <= x) and (x <= 0x7A) then
        Lower
      else
        Other
      end
    else
      Other
    end

  fun convert(moji: String): String =>
    match which(moji)
    | Upper => moji.lower()
    | Lower => moji.upper()
    | Other => moji
    end

// vim:expandtab ff=dos fenc=utf-8 sw=2
