(define (domain casa)
	(:requirements :strips :fluents :adl)
	(:predicates (In ?x) (switchon ?x)(boxin ?b ?x) (ontop))

(:action go
	:parameters (?x ?y)
	:precondition (and (In ?x) (not(ontop)) (not(In ?y)) (switchon ?x) )
	:effect (and (not(In ?x)) (In ?y) )
)

(:action push
	:parameters (?x ?y ?b)
	:precondition (and (In ?x) (boxin ?b ?x) (not(boxin ?b ?y)) (not(ontop)) (not(In ?y)))
	:effect (and (not(In ?x)) (In ?y) (boxin ?b ?y) (not(boxin ?b ?x)) )
)

(:action climbon
	:parameters (?b ?x)
	:precondition (and (In ?x) (boxin ?b ?x) (not(ontop)) )
	:effect (ontop)
)

(:action climboff
        :parameters (?b ?x)
        :precondition (and (In ?x) (boxin ?b ?x) (ontop) )
        :effect (not(ontop))
)

	
(:action turnon
	:parameters (?x)
	:precondition (and (In ?x) (ontop) (not(switchon ?x)))
	:effect (switchon ?x)
)
)
