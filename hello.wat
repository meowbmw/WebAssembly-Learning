(module
  (func $add (param $lhs i32) (param $rhs i32) (result i32)
    local.get $lhs
    local.get $rhs
    i32.add)
  (export "add" (func $add))
  (func $factorial (param $n i32) (result i32)
    (local $result i32)
    ;; if (n == 0) return 1
    (if (result i32)
      (i32.eq (local.get $n) (i32.const 0))
      (then (i32.const 1))
      (else
        ;; result = n * factorial(n - 1)
        (local.set $result
          (i32.mul
            (local.get $n)
            (call $factorial
              (i32.sub (local.get $n) (i32.const 1)))))
        (local.get $result)
      )
    )
  )
  (export "factorial" (func $factorial))
)