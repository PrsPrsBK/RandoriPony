primitive Lower
primitive Upper
primitive Other
type MojiClass is (Lower|Upper|Other)

primitive Rot13
  fun which(moji: String): MojiClass =>
    Lower

  fun convert(moji: String): String =>
    match which(moji)
    | Lower => "Upper"
    | Upper => "Lower"
    | Other => moji
    end

// vim:expandtab ff=dos fenc=utf-8 sw=2
