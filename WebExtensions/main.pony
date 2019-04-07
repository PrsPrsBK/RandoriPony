use "files"

class PingReceiver is InputNotify
  var _env: Env
  var _first: Bool = true
  var _size: U32 = 0
  let file_name = "wext.log"
  new iso create(env: Env) =>
    _env = env

  fun ref apply(data: Array[U8] iso) =>
    try
      let path = FilePath(_env.root as AmbientAuth, file_name)?
      match CreateFile(path)
      | let file: File =>
        if file.errno() is FileOK then
          file.seek_end(0)
          file.write(consume data)
        else
          _env.out.print("noo")
        end
        file.dispose()
      end
    else
      _env.err.print("Error opening file '" + file_name + "'")
    end
    // _env.out.print("apply" + String.from_array(consume data))
    let size: Array[U8] val = [5; 0; 0; 0]
    _env.out.write(size)
    _env.out.write("hello")

  fun ref dispose() =>
    _env.out.print("dispose")

actor Main
  new create(env: Env) =>
    //Set notifier to input-stream, that makes shift to 'waiting'.
    //Access to 'Stdin' actor is limited to some env.
    // env.input: InputStream
    // Stdin is InputStream
    //   apply(InputNotify)
    env.input(PingReceiver(env))

// vim:expandtab ff=dos fenc=utf-8 sw=2
