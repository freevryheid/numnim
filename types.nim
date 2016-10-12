## types.nim
## Matrix type definitions and basic function
## M Rows
## N Columns
## O (oh blood:) Type

type
  Matrix*[M, N: static[int]; O] = array[1..M, array[1..N, O]]
  Complex*[O] = tuple[re, im: O]
  complex32* = Complex[float32]
  complex64* = Complex[float64]

template
  fp*[M, N: static[int]; O](m: Matrix[M, N, O]): ptr O = cast[ptr T](m[1].unsafeAddr)

proc `$`*[M, N: static[int]; O](m: Matrix[M, N, O]): string =
  ## print matrix
  result = ""
  for i in 1..M:
    result.add " [ "
    for j in 1..N:
      result.add $m[i][j] & " "
    result.add "]\n"

proc zeros*(M, N: static[int], O: typedesc): Matrix[M, N, O] =
  ## matrix of zeros
  for i in 1..M:
    for j in 1..N:
      result[i][j] = cast[O](0)

proc ones*(M, N: static[int], O: typedesc): Matrix[M, N, O] =
  ## matrix of ones
  for i in 1..M:
    for j in 1..N:
        result[i][j] = cast[O](1.0)

proc T*[M, N: static[int]; O](m: Matrix[M, N, O]): Matrix[N, M, O] =
  ## transpose matrix
  for i in 1..N:
    for j in 1..M:
      result[i][j] = m[j][i]

when isMainModule:

  let a = ones(5, 5, complex64)
  echo $a