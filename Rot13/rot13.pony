primitive UpperSpec
  fun first(): ISize => 0x41
  fun last(): ISize => 0x5A
  fun whole(): String => "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  fun isAlpha(): Bool => true

primitive LowerSpec
  fun first(): ISize => 0x61
  fun last(): ISize => 0x7A
  fun whole(): String => "abcdefghijklmnopqrstuvwxyz"
  fun isAlpha(): Bool => true

primitive Other
  // dummies are necessary
  fun first(): ISize => 0
  fun last(): ISize => 0
  fun whole(): String => ""
  fun isAlpha(): Bool => false

class Moji
  let _moji: String
  let _moji_case: (UpperSpec|LowerSpec|Other)
  new create(moji: String) =>
    _moji = moji
    if UpperSpec.whole().contains(moji) then
      _moji_case = UpperSpec
    elseif LowerSpec.whole().contains(moji) then
      _moji_case = LowerSpec
    else
      _moji_case = Other
    end

  fun rotate(): String =>
    if _moji_case.isAlpha() then
      try
        let before = (_moji.at_offset(0)?).isize()
        let after: ISize = (13 + (before - _moji_case.first())) %% 26
        // dont know how to convert codepoint <-> string
        _moji_case.whole().substring(after, after + 1)
      else
        _moji
      end
    else
      _moji
    end

primitive Rot13
  fun convert(moji: String): String =>
    Moji(moji).rotate()

// vim:expandtab ff=dos fenc=utf-8 sw=2
