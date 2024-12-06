(module
    (func $sum (param $n i32) (result i32)
        (local $i i32)
        (local $result i32)
        (local.set $i (i32.const 0))
        (local.set $result (i32.const 0))
        loop $myloop
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (local.set $result (i32.add (local.get $i) (local.get $result)))
            (local.get $i)
            (local.get $n)
            (i32.lt_s)
            br_if $myloop
        end
        (local.get $result)
    )
    (export "sum" (func $sum))
)