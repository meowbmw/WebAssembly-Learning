(module
    (func $abs (param $n i32) (result i32)
        (local.get $n)
        (i32.const 0)
        (i32.ge_s)
        (if (result i32) 
             (then (local.get $n))
        (else
            (i32.mul (local.get $n) (i32.const -1)))
        )
    )
    (export "abs" (func $abs))
)