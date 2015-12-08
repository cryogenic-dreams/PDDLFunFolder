(define (domain mer)
	(:requirements :strips :fluents :adl)
	(:predicates (In ?x ?y) (cameraon) (drillon))
	(:functions
        (battery-amount ?rover)
        (recharge-rate ?rover)
        (battery-capacity)
	(speed ?rover)
	(start-x ?rover)
	(end-x ?rover)
	(start-y ?rover)
	(end-y ?rover)
	(In-x ?rover)
	(In-y ?rover)
    	)
) 

(:durative-action move
	:parameters (?rover)
	:duration (= ?duration (* (+ ( - ?end-x ?start-x) (- ?end-y ?start-y)) speed ?rover))
	:condition (and (at start(= (start-x ?rover) (In-x ?rover))) (at start(= (start-y ?rover) (In-y ?rover)))  (at end(= (end-x ?rover) (In-x ?rover))) (at end(= (end-y ?rover) (In-y ?rover))))
	:effect (and
		(at start (decrease (battery-amount ?rover) ?duration)) 
		(at start(= (start-x ?rover) (In-x ?rover))) 
		(at start(= (start-y ?rover) (In-y ?rover)))  
		(at end(= (end-x ?rover) (In-x ?rover))) 
		(at end(= (end-y ?rover) (In-y ?rover))))
)

(:durative-action take-picture
	:parameters (?rover)
	:duration(= ?duration (* (speed ?rover) 10)
	:condition (and (at start (>= (battery-amount ?rover) ?duration))
		(at start(= (start-x ?rover) (In-x ?rover))) 
		(at start(= (start-y ?rover) (In-y ?rover))))
	:effect (and 
		(at start (decrease (battery-amount ?rover) ?duration))
		(at start(cameraon))
		(at end (not (cameraon))))
)

(:durative-action drill
        :parameters (?rover)
        :duration(= ?duration (* (speed ?rover) 20)
        :condition (and (at start (>= (battery-amount ?rover) ?duration))
                (at start(= (start-x ?rover) (In-x ?rover))) 
                (at start(= (start-y ?rover) (In-y ?rover))))
        :effect (and 
                (at start (decrease (battery-amount ?rover) ?duration))
                (at start(drillon))
                (at end (not (drillon))))
)


(:durative-action communicate
        :parameters (?rover)
        :duration(= ?duration (* (speed ?rover) 30)
        :condition (and (at start (>= (battery-amount ?rover) ?duration))
                (at start(= (start-x ?rover) (In-x ?rover))) 
                (at start(= (start-y ?rover) (In-y ?rover))))
        :effect (and 
                (at start (decrease (battery-amount ?rover) ?duration)))
)

(:durative-action take-picture
        :parameters (?rover)
        :duration(= ?duration (* (speed ?rover) 2)
        :condition (and (at start (>= (battery-amount ?rover) ?duration))
                (and (at start(= (start-x ?rover) (In-x ?rover))) 
                (at start(= (start-y ?rover) (In-y ?rover)))
        :effect (and 
                (at start (decrease (battery-amount ?rover) ?duration))
                (at start(cameraon))
                (at end (not (cameraon))))
)

(:durative-action recharge
        :parameters (?rover)
        :duration 
            (= ?duration 
                (/ (battery-amount ?rover) (recharge-rate ?rover)))
        
        :condition
	        (and 
	            (at start (< (battery-amount ?rover) 3)))
     
        :effect
	        (at end 
	            (increase (battery-amount ?rover) 
	                (* ?duration (recharge-rate ?rover))))
	)

)
