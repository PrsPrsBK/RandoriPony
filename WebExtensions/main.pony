class SomeHandler is AppropriateNotify
  new create() =>

  fun ref necessary_func_impl() =>

actor Main
  new create(env: Env) =>
    //Pseudo Names. Waiting class is not Readline Class.
    let term = TermOrSo(WaitingStdinClass(SomeHandler, SomeStdout), SomeStdin)
    let notifiee = object iso
      let _term = term
      fun ref necessary_func() => _term.necessary_func_impl()
    end
    //Set notifier to input-strream, that makes shift to 'waiting'.
    SomeStdin.input_wait(consume notifiee)

// vim:expandtab ff=dos fenc=utf-8 sw=2
