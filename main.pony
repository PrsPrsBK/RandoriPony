use "term"
use "debug"
use "promises"
use "Collatz"

class Handler is ReadlineNotify
  let _commands: Array[String] = _commands.create()
  var _i: U64 = 0

  new create() =>
    _commands.push("quit")
    _commands.push("happy")
    _commands.push("hello")

  fun ref apply(line: String, prompt: Promise[String]) =>
    if line == "quit" then
      prompt.reject()
    else
      _i = _i + 1
      prompt(_i.string() + " > ")
    end
    _update_commands(line)

  fun ref _update_commands(line: String) =>
    for command in _commands.values() do
      if command.at(line, 0) then
        return
      end
    end

    _commands.push(line)

  fun ref tab(line: String): Seq[String] box =>
    let r = Array[String]

    for command in _commands.values() do
      if command.at(line, 0) then
        r.push(command)
      end
    end

    r

actor Repl
  new create(env: Env) =>
    env.out.print("Use 'quit' to exit.")

    // Building a delegate manually
    let term = ANSITerm(Readline(recover Handler end, env.out), env.input)
    term.prompt("0 > ")

    let notify = object iso
      let term: ANSITerm = term
      fun ref apply(data: Array[U8] iso) => term(consume data)
      fun ref dispose() => term.dispose()
    end

    env.input(consume notify)

actor Main
  let env: Env
  new create(env': Env) =>
    env = env'
    command(try env.args(1)? else "" end, env.args.slice(2))

  fun _print_usage() =>
    env.out.printv(
      [ "Usage: RandoriPony TASK [...]"
        ""
        "    Select a task."
        ""
        "Tasks:"
        "    help    - Print this message"
        "    repl    - REPL but do very little thing"
        "    collatz - Collatz Sequence"
        ""
      ]
    )

  fun command(task: String, rest: Array[String] box) =>
    match task
    | "repl" =>
      Repl(env)
    | "collatz" =>
      let iterator = CollatzIterator[U64](11)
      for num in iterator do
        env.out.print(num.string())
      end
    else
      _print_usage()
    end

// vim:expandtab ff=dos fenc=utf-8 sw=2

