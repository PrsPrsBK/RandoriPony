use "files"
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
actor Main
  new create(env: Env) =>
    env.out.write(ANSI.clear())
    try
      let col: USize = @get_col()
      // let col_pos: U32 = (if (col % 2) == 0 then col / 2 else (col + 1) / 2 end).u32()
      let col_pos: U32 = (col / 3).u32()

      env.out.write(ANSI.right(col_pos))
      env.out.print(col.string())
      let path = FilePath(env.root as AmbientAuth, ".")?
      let dir = Directory(path)?
      for item in dir.entries()?.values() do
        env.out.write(ANSI.right(col_pos))
        env.out.print(item)
      end
    end

// vim:expandtab ff=dos fenc=utf-8 sw=2
