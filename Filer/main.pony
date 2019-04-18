use "debug"
use "files"
use "promises"
use "signals"
use "term"
use "path:./"
use "lib:winterm"
use @get_col[USize]()

/*
 * NEXT: use ANSITerm. clear, list up items
 * NEXT: wait input. quit by 'q'
 * NEXT: wait input. up/down by 'k/j'
 * NEXT: get terminal size. maybe FFI
 */
class OpHandler is InputNotify
  var env: Env

  new iso create(_env: Env) =>
    env = _env

  fun ref apply(data: Array[U8] iso) =>
    let input = String.from_array(consume data)
    // Debug.out(input)
    if input == "q" then
      env.out.write(ANSI.clear())
      // somehow slow
      SignalRaise(Sig.quit())
    elseif input == "j" then
      env.out.write(ANSI.down(1))
    elseif input == "k" then
      env.out.write(ANSI.up(1))
    end


actor Main
  new create(env: Env) =>
    /*
     * draw part
     */
    env.out.write(ANSI.clear())
    try
      let col: USize = @get_col()
      let col_pos: U32 = (col / 3).u32()
      var cur_col: U32 = 0

      env.out.write(ANSI.right(col_pos))
      env.out.print(col.string())
      cur_col = 1 + cur_col
      let path = FilePath(env.root as AmbientAuth, ".")?
      let dir = Directory(path)?
      for item in dir.entries()?.values() do
        env.out.write(ANSI.right(col_pos))
        env.out.print(item)
        cur_col = 1 + cur_col
      end
      env.out.write(ANSI.right(col_pos))
      env.out.write(ANSI.up(cur_col))
      // env.out.write(ANSI.cursor(col_pos, 1))
    end

    /*
     * become interactive part
     */
    let handler = OpHandler(env)
    env.input(consume handler)

// vim:expandtab ff=dos fenc=utf-8 sw=2
