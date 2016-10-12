import
  types, lapack

proc
  solve*[M,N,T](A: Matrix[M,M,T]; b: Matrix[N,M,T]): Matrix[N,M,T] =
  var
    ipvt: array[M, int]
    ipvt_ptr = cast[ptr int](ipvt.addr)
    info: cint
    m: int = M
    n: int = N
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


