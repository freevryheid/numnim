import
  linalg

var
  A: Matrix[3, 3,float32] =
    [[ -0.5'f32,  -1.0'f32,  -2.0'f32],
     [ 999.0'f32, -2.0'f32,  3.0'f32],
     [-1.0'f32,  3.0'f32,  1.0'f32]]
  b: Matrix[1, 3, float32] =
    [[ 4.0'f32, -6.0'f32,  7.0'f32]]
  x: Matrix[1, 3, float32]

x = solve(A, b)

for i in 1..3:
  echo x[1][i]
