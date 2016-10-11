import
  lapack

type
  Matrix*[M,N: static[int]; T] = array[1..M, array[1..N, T]]

template
  fp[M,N,T](m: Matrix[M,N,T]): ptr T = cast[ptr T](m[1].unsafeAddr)

proc
  solve*[M,N,T](A: Matrix[M,M,T]; b: Matrix[N,M,T]): Matrix[N,M,T] =
  var
    ipvt: array[M, cint]
    ipvt_ptr = cast[ptr cint](ipvt.addr)
    info: cint
    m: cint = cast[cint](M)
    n: cint = cast[cint](N)
    mptr = m.addr
    nptr = n.addr
    iptr = info.addr

  gesv(mptr, nptr, A.fp, mptr, ipvt_ptr, b.fp, mptr, iptr)

  if info == 0:
    result = b
  elif info < 0:
    echo "the", -info, "-th argument had an illegal value"
  else:
    echo "U(", info, ",", info, ") is exactly zero; The factorization has been completed, but the factor U is exactly singular, so the solution could not be computed."


