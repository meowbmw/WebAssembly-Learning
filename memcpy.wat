(module
    (memory (import "js" "mem") 1)
    (func $memcpy (param $src i32) (param $dst i32) (param $length i32)
    (local $i i32)
    (local.set $i (i32.const 0))
    (block
        (loop
            (br_if 1 (i32.ge_u (local.get $i) (local.get $length)))
            (i32.store
            (i32.add (local.get $dst) (local.get $i))
            (i32.load (i32.add (local.get $src) (local.get $i)))
            )
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            br 0
        )
    )
    )
    (export "memcpy" (func $memcpy))
)