(define (domain chibi-casa)
        (:requirements :strips :fluents :adl :equality :durative-actions)
	(:functions 
		(battery-amount ?chibi) 
		(inventory-space ?chibi) 
		(recharge-rate ?chibi)
        	(battery-capacity) 
		(item-capacity) 
		(litter-in-room ?x)
		(plants-garden ?x)
	)

        (:predicates 
		(In ?x) 
		(haveutensil) 
		(havedropper) 
		(havefood) 
		(havebrush) 
		(clean ?x) 
		(bin-in ?x)
		(kitchen ?x)		
		(garden ?x) 
		(livingroom ?x) 
		(family-hungry) 
		(fish-hungry)
	)


(:durative-action move
        :parameters 
            (?chibi ?x ?y)
        
        :duration 
            (= ?duration 3)
        
        :condition
	        (and 
	            (at start (In ?x)) 
	            (at start (not (In ?y)))
		    (at start (>= (battery-amount ?chibi) 3)) 
	        )
	            
        :effect
	        (and 
	            (at start (not (In ?y))) 
	            (at start (decrease (battery-amount ?chibi) 3))
		    (at end (In ?y))
		    (at end (not (In ?x)))
		)
)

(:durative-action clean
        :parameters (?x ?chibi)
	:duration 
            (= ?duration 5)
        :condition (and 
			(at start (In ?x))  
			(at start (not(clean ?x)))
			(at start (>= (battery-amount ?chibi) 5))
			)
        :effect (and
		(at start (In ?x)) 
		(at start (havebrush))
		(at start (decrease (battery-amount ?chibi) 5))
		(at end (clean ?x))
		(at end (not(havebrush)))
		)
)

(:durative-action pick-litter
        :parameters (?x ?chibi)
	:duration 
	    (= ?duration (* (litter-in-room ?x) 2))
        :condition (and 
			(at start (In ?x)) 
			(at start (> (litter-in-room ?x) 0))
			(at start (> (inventory-space ?chibi) (litter-in-room ?x)))
			(at start (>= (battery-amount ?chibi) (* (litter-in-room ?x) 2)))
			)
        :effect (and 
		   (at start (decrease (inventory-space ?chibi) (litter-in-room ?x)))
		   (at start (decrease (battery-amount ?chibi) (* (litter-in-room ?x) 2))) 
		   (at end (decrease (litter-in-room ?x) (litter-in-room ?x))) 
		)
)


(:durative-action dispose-litter
        :parameters (?x ?chibi)
        :duration
	    (= ?duration 3)
	:condition (and 
			(at start (In ?x)) 
			(at start (bin-in ?x)) 
			(at start (< (inventory-space ?chibi) 10))
			)
        :effect (at start (increase (inventory-space ?chibi) (item-capacity)))
)


(:durative-action cook
        :parameters (?x ?chibi)
	:duration 
            (= ?duration 6) 
        :condition (and 
			(at start (In ?x)) 
			(at start (kitchen ?x) )
			(at start (family-hungry))
			(at start (>= (battery-amount ?chibi) 6))
			)
        :effect (and
		   (at start (haveutensil))
		   (at start (decrease (battery-amount ?chibi) 6))
		   (at end (not (family-hungry)))
		   (at end (not (haveutensil)))
		)
)


(:durative-action feed-fish
        :parameters (?x ?chibi)
	:duration 
            (= ?duration 2)
        :condition (and 
			(at start (In ?x)) 
			(at start (livingroom ?x) )
			(at start (fish-hungry))
			(at start (>= (battery-amount ?chibi) 2))
			)
        :effect (and
		(at start (havefood))
		(at start (decrease (battery-amount ?chibi) 2))
		(at end (not (fish-hungry)))
		(at end (not (havefood)))
		)
)

(:durative-action water-plants
        :parameters (?x ?chibi)
	:duration 
            (= ?duration (plants-garden ?x))
        :condition (and 
			(at start (In ?x)) 
			(at start (garden ?x))
			(at start (> (plants-garden ?x) 0))
			(at start (>= (battery-amount ?chibi) (plants-garden ?x)))
			)
        :effect (and
		   (at start (havedropper))
		   (at start (decrease (battery-amount ?chibi) (plants-garden ?x)))
		   (at end (decrease (plants-garden ?x) (plants-garden ?x)))
		   (at end (not(havedropper)))
		)
)

(:durative-action charge-batery
        :parameters (?x ?chibi)
	:duration 
            (= ?duration 
                (/ (- (battery-capacity) (battery-amount ?chibi)) (recharge-rate ?chibi)))
        :condition (and 
			(at start (In ?x))
			(at start (<= (battery-amount ?chibi) 8)) 
			)
        :effect (and
		   (at end 
	            (increase (battery-amount ?chibi) 
	                (* ?duration (recharge-rate ?chibi))))
		)
)

)
