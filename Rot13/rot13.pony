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
    | Upper => rotate(moji)
    | Lower => moji.upper()
    | Other => moji
    end

  fun rotate(moji: String): String =>
    let first: ISize = 0x41
    let last: ISize = 0x5A
    try
      let x = (moji.at_offset(0)?).isize() // P -> 80
      // dont know how to convert codepoint <-> string
      let after: ISize = (13 + (x - first)) % 26
      "ABCDEFGHIJKLMNOPQRSTUVWXYZ".substring(after, after + 1)
    else
      moji
    end

// vim:expandtab ff=dos fenc=utf-8 sw=2
