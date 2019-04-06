class PingReceiver is InputNotify
  var _env: Env
  new iso create(env: Env) =>
    _env = env

  fun ref apply(data: Array[U8] iso) =>
    _env.out.print("apply" + String.from_array(consume data))

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
