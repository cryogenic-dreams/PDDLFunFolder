(define (domain mundobloques)
(:requirements :strips :equality)
(:predicates (holding ?x)(clear ?x)(handempty)(ontable ?x)(on ?x ?y))

(:action pick-up
	 :parameters (?x)
	 :precondition (and (clear ?x) (ontable ?x) (handempty))
	 :effect (and (not(clear ?x)) (not(ontable ?x)) (not(handempty)) (holding ?x)))

(:action put-down
	:parameters (?x)
	:precondition (holding ?x)
	:effect (and (not(holding ?x)) (clear ?x) (ontable ?x) (handempty)))

(:action stack
	 :parameters (?x ?y)
	 :precondition (and(holding ?x) (clear ?y))
	 :effect (and (not(holding ?x)) (not(clear ?y)) (clear ?x) (handempty) (on ?x ?y)))

(:action un-stack
	 :parameters (?x ?y)
	 :precondition (and(on ?x ?y) (clear ?x) (handempty))
	 :effect (and (holding ?x) (clear ?y) (not (on ?x ?y)) (not (handempty)) (not(clear ?x)))))
