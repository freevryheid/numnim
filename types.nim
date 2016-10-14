## types.nim
## Matrix type definitions and basic function
## M Rows
## N Columns
## O (oh blood:) Type

## basic types
type
  Matrix*[M, N: static[int]; O] = array[1..M, array[1..N, O]]
  Complex*[O] = tuple[re, im: O]
  complex32* = Complex[float32]
  complex64* = Complex[float64]

## floating pointer
template
  fp*[M, N: static[int]; O](m: Matrix[M, N, O]): ptr O = cast[ptr T](m[1].unsafeAddr)

proc
  `$`*[M, N: static[int]; O](m: Matrix[M, N, O]): string =
  ## matrix string echo
  result = ""
  for i in 1..M:
    result.add " [ "
    for j in 1..N:
      result.add $m[i][j] & " "
    result.add "]\n"

proc
  `$`*[O](a: openArray[O]): string =
  ## array string echo
  result = " [ "
  for i in low(a)..high(a):
    result.add $a[i] & " "
  result.add "]\n"

proc
  fatten*[O](a: openArray[O]; M, N: static[int]): Matrix[M, N, O] =
  ## matrix from array
  var k = low(a)
  for i in 1..M:
    for j in 1..N:
      result[i][j] = a[k]
      inc k

proc
  flatten*[M, N: static[int]; O](m: Matrix[M, N, O]): array[1..M*N,O] =
  ## convert matrix to array
  var k = 1
  for i in 1..M:
    for j in 1..N:
      result[k] = m[i][j]
      inc k

iterator
  flat*[M, N: static[int]; O](m: var Matrix[M, N, O]): O =
  discard flatten(m)
  for i in 1..high(m):
    yield i

proc
  zeros*(M, N: static[int]; O: typedesc): Matrix[M, N, O] =
  ## any matrix of zeros
  for i in 1..M:
    for j in 1..N:
      when not (O is Complex):
        result[i][j] = cast[O](0)
      else:
        when (O is complex32):
          result[i][j] = (re:0.0'f32, im:0.0'f32)
        else:
          result[i][j] = (re:0.0'f64, im:0.0'f64)

proc
  zero*(M: static[int]; O: typedesc): Matrix[M, M, O] =
  ## square matric of zeros
  zeros(M, M, O)

proc
  ones*(M, N: static[int]; O: typedesc): Matrix[M, N, O] =
  ## matrix of ones
  for i in 1..M:
    for j in 1..N:
      when not (O is Complex):
        when (O is float32):
          result[i][j] = cast[O](1'f32)
        elif (O is float64):
          result[i][j] = cast[O](1'f64)
        else:
          result[i][j] = cast[O](1)
      else:
        when (O is complex32):
          result[i][j] = (re:1.0'f32, im:0.0'f32)
        else:
          result[i][j] = (re:1.0'f64, im:0.0'f64)

proc
  one*(M: static[int]; O: typedesc): Matrix[M, M, O] =
  ## square matric of ones
  ones(M,M,O)

# proc
#   eyes*(M, N: static[int]; O: typedesc; P: int = 0): Matrix[M, N, O] =
#   ## any matrix with ones on the diagonal and zeros elsewhere
#   var i: int
#   result = zeros(M, N, O)
#   if P > N:
#     return
#   if P >= 0:
#     i = P
#   else:
#     i = -P * N


  # for i in 1..M:
  #   for j in 1..N:
  #     if (i == j) and (i + P <= M) and (j + P <= N):
  #       when not (O is Complex):
  #         when (O is float32):
  #           result[i+P][j+P] = cast[O](1'f32)
  #         elif (O is float64):
  #           result[i+P][j+P] = cast[O](1'f64)
  #         else:
  #           result[i+P][j+P] = cast[O](1)
  #       else:
  #         when (O is complex32):
  #           result[i+P][j+P] = (re:1.0'f32, im:0.0'f32)
  #         else:
  #           result[i+P][j+P] = (re:1.0'f64, im:0.0'f64)

# proc
#   eye*(M: static[int]; O: typedesc; P: int = 0): Matrix[M, M, O] =
#   ## square matrix with ones on the diagonal and zeros elsewhere
#   eyes(M, M, O, P)


# if M is None:
#         M = N
#     m = zeros((N, M), dtype=dtype)
#     if k >= M:
#         return m
#     if k >= 0:
#         i = k
#     else:
#         i = (-k) * M
#     m[:M-k].flat[i::M+1] = 1
#     return m

#m[:M-k].flat[i::M+1] = 1

proc
  T*[M, N: static[int]; O](m: Matrix[M, N, O]): Matrix[N, M, O] =
  ## transpose matrix
  for i in 1..N:
    for j in 1..M:
      result[i][j] = m[j][i]

proc
  `[]`*[M, N: static[int]; O](m: Matrix[M, N, O]; i, j: int): O = 
  m[i][j]

proc
  `[]=`*[M, N: static[int]; O](m: var Matrix[M, N, O]; i, j: int; val: O) = 
  m[i][j] = val

iterator
  pairs*[T](s: Slice[T]): tuple[key: int, val: T] {.inline.} =
  var i = 0
  for x in s.a .. s.b:
    yield (i, x)
    inc i

template
  toArray[T](slice: Slice[T]): untyped =
  ## ordinal type only 
  var result: array[slice.b-slice.a+1, slice.T] # TODO: more generic def of width
  for i, x in pairs(slice):
    result[i] = x
  result

proc
  reshape*[M, N: static[int]; O](m: Matrix[M, N, O]; P,Q: static[int]): Matrix[P, Q, O] =
  ## reshape matrix  
  let a = flatten(m)
  fatten(a, P, Q)




when isMainModule:

  var a = (1..12).toArray  
  var b = fatten(a, 2, 6)

  for i in b.flat:
    echo i
 
