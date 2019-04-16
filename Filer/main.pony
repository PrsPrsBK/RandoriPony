use "files"
use "path:./"
use "lib:winterm"
use @get_col[ISize]()

/*
 * NEXT: use ANSITerm. clear, list up items
 * NEXT: wait input. quit by 'q'
 * NEXT: wait input. up/down by 'k/j'
 * NEXT: get terminal size. maybe FFI
 */
actor Main
  new create(env: Env) =>
    try
      let col: ISize = @get_col()
      env.out.print(col.string())
      let path = FilePath(env.root as AmbientAuth, ".")?
      let dir = Directory(path)?
      for item in dir.entries()?.values() do
        env.out.print(item)
      end
    end

// vim:expandtab ff=dos fenc=utf-8 sw=2
