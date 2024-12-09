(module
    (memory (import "js" "mem") 1)
    (func $partition (param $arr i32) (param $low i32) (param $high i32) (result i32)
        (local $pivot i32)
        (local $i i32)
        (local $j i32)
        (local $temp i32)
        (local.set $pivot (i32.load (i32.add (local.get $arr)  (i32.mul (local.get $high) (i32.const 4)))))
        (local.set $i (i32.sub (local.get $low) (i32.const 1)))
        (local.set $j (local.get $low))
        (block
            (loop
                (br_if 1 (i32.gt_u (local.get $j) (i32.sub (local.get $high) (i32.const 1)))) ;; break if j>high-1
                (if (i32.lt_s (i32.load (i32.add (local.get $arr) (i32.mul (local.get $j) (i32.const 4)))) (local.get $pivot))
                    (then 
                        (local.set $i (i32.add (local.get $i) (i32.const 1))) ;; i=i+1
                        (local.set $temp (i32.load (i32.add (local.get $arr) (i32.mul (local.get $i) (i32.const 4)))))
                        ;; temp=arr[i]
                        (i32.store (i32.add (local.get $arr) (i32.mul (local.get $i) (i32.const 4))) 
                            (i32.load (i32.add (local.get $arr) (i32.mul (local.get $j) (i32.const 4))))
                        )
                        ;; arr[i]=arr[j]
                        (i32.store (i32.add (local.get $arr) (i32.mul (local.get $j) (i32.const 4))) (local.get $temp))
                        ;; arr[j]=temp
                    )
                )
                (local.set $j (i32.add (local.get $j) (i32.const 1))) ;; j=j+1
                (br 0)
            )
        )
        
        (local.set $temp (i32.load (i32.add (local.get $arr) (i32.mul (i32.add (local.get $i) (i32.const 1)) (i32.const 4))))) ;;temp=arr[i+1]
        (i32.store (i32.add (local.get $arr) (i32.mul (i32.add (local.get $i) (i32.const 1)) (i32.const 4))) 
            (i32.load (i32.add (local.get $arr) (i32.mul (local.get $high) (i32.const 4)) ))
        ) ;; arr[i+1]=arr[high]
        (i32.store (i32.add (local.get $arr) (i32.mul (local.get $high) (i32.const 4))) (local.get $temp))
        ;; arr[high]=temp
        (i32.add (local.get $i) (i32.const 1))
    )
    (func $quicksort (param $arr i32) (param $low i32) (param $high i32)
        (local $pi i32)
        (if (i32.lt_s (local.get $low) (local.get $high))
            (then 
                (local.set $pi (call $partition (local.get $arr) (local.get $low) (local.get $high)))
                (call $quicksort (local.get $arr) (local.get $low) (i32.sub (local.get $pi) (i32.const 1)))
                (call $quicksort (local.get $arr) (i32.add (local.get $pi) (i32.const 1)) (local.get $high))
            )
        )
    )
    (export "quicksort" (func $quicksort))
)
