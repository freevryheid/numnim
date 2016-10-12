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

proc zeros*(M: int; N: int = 0 ; O: typedesc): Matrix[M, N, O] =
  ## matrix of zeros
  when N == 0:
    N = M
  for i in 1..M:
    for j in 1..N:
      when not (O is Complex):
        result[i][j] = cast[O](0)
      else:
        when (O is complex32):
          result[i][j] = (re:0.0'f32, im:0.0'f32)
        else:
          result[i][j] = (re:0.0'f64, im:0.0'f64)

# proc ones*(M, N=M: static[int]; O: typedesc): Matrix[M, N, O] =
#   ## matrix of ones
#   for i in 1..M:
#     for j in 1..N:
#       when not (O is Complex):
#         when (O is float32):
#           result[i][j] = cast[O](1'f32)
#         elif (O is float64):
#           result[i][j] = cast[O](1'f64)
#         else:
#           result[i][j] = cast[O](1)
#       else:
#         when (O is complex32):
#           result[i][j] = (re:1.0'f32, im:0.0'f32)
#         else:
#           result[i][j] = (re:1.0'f64, im:0.0'f64)

#proc eye*(M, N=M: static[int]; P=0: int; O: typedesc): Matrix[M, N, O] =
#  ## matrix with ones on the diagonal and zeros elsewhere


proc T*[M, N: static[int]; O](m: Matrix[M, N, O]): Matrix[N, M, O] =
  ## transpose matrix
  for i in 1..N:
    for j in 1..M:
      result[i][j] = m[j][i]

when isMainModule:

  let a = zeros(5, int)
  echo $a
