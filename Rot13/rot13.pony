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
    var first: ISize = 0
    var last: ISize = 0
    var range: String = ""
    try
      match which(moji)
      | Upper =>
        first = 0x41
        last = 0x5A
        range = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let before = (moji.at_offset(0)?).isize() // P -> 80
        // dont know how to convert codepoint <-> string
        let after: ISize = (13 + (before - first)) %% 26
        range.substring(after, after + 1)
      | Lower => moji
        first = 0x61
        last = 0x7A
        range = "abcdefghijklmnopqrstuvwxyz"
        let before = (moji.at_offset(0)?).isize()
        let after: ISize = (13 + (before - first)) %% 26
        range.substring(after, after + 1)
      | Other => moji
      end
    else
      moji
    end

// vim:expandtab ff=dos fenc=utf-8 sw=2
