(define (problem P2)
(:domain casa)
(:objects R1 R2 B1 B2)
(:init (In R1) (boxin B1 R1))
(:goal  (and(switchon R2) (switchon R1))))
