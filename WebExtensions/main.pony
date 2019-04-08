use "buffered"
use "files"

class PingReceiver is InputNotify
  var _env: Env
  var _first: Bool = true
  var _total_size: USize = 0
  var _piled_size: USize = 0
  let _file_name: String = "wext.log"
  new iso create(env: Env) =>
    _env = env

  // TODO: use chunk specification for Stdin
  fun ref apply(data: Array[U8] iso) =>
    let reader = Reader
    reader.append(consume data)
    try
      if _first then
        _total_size = reader.u32_le()?.usize()
        _piled_size = 0
        _first = false
      else
        let message_size = reader.size()
        let planned_size = _total_size - _piled_size
        let log_prefix = "total " + _total_size.string() + " "
        var wk_size = message_size
        var discarded_size: USize = 0
        if wk_size > planned_size then
          discarded_size = wk_size - planned_size
          wk_size = planned_size
        end
        let message = reader.block(wk_size)?
        log(log_prefix + String.from_array(consume message))
        if discarded_size > 0 then
          log("discarded: " + discarded_size.string())
        end
        _piled_size = _piled_size + wk_size
        if _piled_size >= _total_size then
          log("end")
          _first = true
          send_response()
        end
      end
    end

  fun ref send_response() =>
    try
      let writer = Writer
      // all 'A' as valid js data. maybe 9999... is enough as js infinity number.
      let long_array: Array[U8] iso = recover iso Array[U8].init(0x41, (4 * 1024) - 4) end
      long_array.update(0, 0x22)?
      long_array.update(long_array.size() - 1, 0x22)?
      // header
      writer.u32_le(long_array.size().u32())
      _env.out.writev(writer.done())
      // message
      let wk_array: Array[U8] val = consume long_array
      writer.write(wk_array)
      _env.out.writev(writer.done())
      // header(4) + message = 4KiB.
      // extra 'write' (I hope 00 to be meaningless) is necessary for flush.
      // without extra 'write', click twice the icon on browser toolbar, then flush happens.
      let extra: Array[U8] val = [0x0]
      _env.out.write(extra)
    end
    /*
     > lets send 2019/4/9-1:29:27 https://www.google.co.jp/ background.js:11:15
     > from pony: 4090 AAAAA...
     */

    // let message = "\"hello\""
    // writer.u32_le(message.size().u32())
    // _env.out.writev(writer.done())
    // writer.write(message)
    // _env.out.writev(writer.done())

    // writer.u32_le(message.size().u32())
    // _env.out.writev(writer.done())
    // writer.write(message)
    // _env.out.writev(writer.done())

    // writer.u32_le(message.size().u32() + 2)
    // _env.out.writev(writer.done())
    // writer.write(message)
    // _env.out.writev(writer.done())

    // writer.u32_le(message.size().u32())
    // writer.write(message)
    // _env.out.writev(writer.done())

    // writer.u32_le(message.size().u32() + 2)
    // writer.write(message)
    // _env.out.writev(writer.done())
    // not flushed?
    log("write")

  fun ref dispose() =>
    log("dispose")

  fun log(text: (String val | Array[U8 val] val)) =>
    try
      let path = FilePath(_env.root as AmbientAuth, _file_name)?
      match CreateFile(path)
      | let file: File =>
        if file.errno() is FileOK then
          file.seek_end(0)
          file.print(text)
        end
        file.dispose()
      end
    end

actor Main
  new create(env: Env) =>
    //Set notifier to input-stream, that makes shift to 'waiting'.
    //Access to 'Stdin' actor is limited to some env.
    // env.input: InputStream
    // Stdin is InputStream
    //   apply(InputNotify)
    env.input(PingReceiver(env))

// vim:expandtab ff=dos fenc=utf-8 sw=2
