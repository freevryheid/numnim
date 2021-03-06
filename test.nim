# import
#   types, linalg

# var
#   A: Matrix[5, 5, float32] = [
#     [ 6.80'f32, -6.05'f32, -0.45'f32,  8.32'f32, -9.67'f32],
#     [-2.11'f32, -3.30'f32,  2.58'f32,  2.71'f32, -5.14'f32],
#     [ 5.66'f32,  5.36'f32, -2.70'f32,  4.35'f32, -7.26'f32],
#     [ 5.97'f32, -4.44'f32,  0.27'f32, -7.17'f32,  6.08'f32],
#     [ 8.23'f32,  1.08'f32,  9.04'f32,  2.14'f32, -6.87'f32]
#   ]

#   B: Matrix[3, 5, float32] = [
#     [  4.02'f32, -1.56'f32,  9.81'f32],
#     [  6.19'f32,  4.00'f32, -4.09'f32],
#     [ -8.22'f32, -8.67'f32, -4.57'f32],
#     [ -7.57'f32,  1.75'f32, -8.61'f32],
#     [ -3.03'f32,  2.86'f32,  8.99'f32]
#   ]

#   x: Matrix[1, 3, float32]

# x = solve(A, b)

# for i in 1..3:
#   echo x[1][i]

type
  Matrix[Rows, Cols: static[int]; E] = concept M
    M.T is T
    Rows == M.M
    Cols == M.N
    m[range[0..(R - 1)], range[0..(C - 1)]] is T
    
proc foo(m: Matrix) =
  echo Matrix.M, m.N
  let x = Matrix.E()

var
  A: Matrix[3, 3, int]

