primitive Collatz[A: (Integer[A] val & Unsigned) = USize]
  fun next_one(head: A): A =>
    CollatzIterator[A](head).next()

class CollatzIterator[A: (Integer[A] val & Unsigned) = USize] is Iterator[A]
  """
  6, 3, 10, 5, 16, 8, 4, 2, 1
  11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1
  """
  var _head: A = 1

  new create(head: A) =>
    _head = head

  fun ref head_is(head: A) =>
    _head = head

  fun has_next(): Bool => _head != 1

  fun ref next(): A =>
    _head = match (_head % 2)
      | 0 => _head / 2
      else
        ((3 * _head) + 1)
      end
    _head

actor Main
  new create(env: Env) =>
    let iterator = CollatzIterator[U64](11)
    for num in iterator do
      env.out.print(num.string())
    end

// vim:expandtab ff=dos fenc=utf-8 sw=2
