(define (domain mars)
	(:requirements :strips :fluents :equality :adl)
	(:functions (battery-amount ?mer)
        )
	(:predicates (In ?x) (cameraon) (picture ?x))

(:action go 
	:parameters (?x ?y ?mer)
	:precondition (and (In ?x) (not (= ?x ?y)) (> (battery-amount ?mer) 5) (not(cameraon)))
	:effect (and (In ?y) (not(In ?x)) (decrease (battery-amount ?mer) 5))
)

(:action takepicture
	:parameters (?x ?mer)
	:precondition (and(In ?x) (cameraon) (> (battery-amount ?mer) 2))
	:effect (and(not(cameraon)) (decrease (battery-amount ?mer) 2) (picture ?x))
)

(:action display-camera
	:parameters ()
	:precondition (not(cameraon))
	:effect (cameraon)
)

(:action recharge
	:parameters (?mer) 
	:precondition  (<= (battery-amount ?mer) 7) 
			
	:effect (increase (battery-amount ?mer) 20)
)

)
