(define (problem P1)
(:domain mundobloques)
(:objects A B C)
(:init (clear C)(clear B)(clear A)(ontable A)(ontable B)(ontable C)(handempty))
(:goal (and(on B C)(on A B))))
