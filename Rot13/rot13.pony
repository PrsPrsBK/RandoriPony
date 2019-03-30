class Upper
  let first: ISize = 0x41
  let last: ISize = 0x5A
  let whole: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  fun eq(moji: String): Bool => whole.contains(moji)

class Lower
  let first: ISize = 0x61
  let last: ISize = 0x7A
  let whole: String = "abcdefghijklmnopqrstuvwxyz"
  fun eq(moji: String): Bool => whole.contains(moji)

primitive Rot13
  fun convert(moji: String): String =>
    try
      match moji
      | Upper =>
        let before = (moji.at_offset(0)?).isize() // P -> 80
        let after: ISize = (13 + (before - Upper.first)) %% 26
        // dont know how to convert codepoint <-> string
        Upper.whole.substring(after, after + 1)
      | Lower => moji
        let before = (moji.at_offset(0)?).isize()
        let after: ISize = (13 + (before - Lower.first)) %% 26
        Lower.whole.substring(after, after + 1)
      else
        moji
      end
    else
      moji
    end

// vim:expandtab ff=dos fenc=utf-8 sw=2
