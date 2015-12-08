(define (domain chibi-casa)
        (:requirements :strips :fluents :adl :equality :typing)
	(:functions 
		(battery-amount ?chibi) 
		(inventory-space ?chibi) 
		(recharge-rate ?chibi)
        	(battery-capacity ?chibi) 
		(item-capacity ?chibi) 
		(litter-in-room ?x)
		(plants-garden ?x)
		(total-cost ?chibi)
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


(:action move
        :parameters 
            (?chibi ?x ?y)
        :precondition
	        (and 
	            (In ?x)
	            (not (In ?y))
		    (>= (battery-amount ?chibi) 3) 
	        )
	            
        :effect
	        (and 
	            (not (In ?y)) 
	            (decrease (battery-amount ?chibi) 3)
		    (In ?y)
		    (not (In ?x))
		    (increase (total-cost ?chibi) 3)
		)
)

(:action clean
        :parameters (?x ?chibi)
        :precondition (and 
			(In ?x)  
			(not(clean ?x))
			(>= (battery-amount ?chibi) 5)
			)
        :effect (and
		(In ?x) 
		(decrease (battery-amount ?chibi) 5)
		(clean ?x)
		(increase (total-cost ?chibi) 5)
		)
)

(:action pick-litter
        :parameters (?x ?chibi)
        :precondition (and 
			(In ?x) 
			(> (litter-in-room ?x) 0)
			(> (inventory-space ?chibi) (litter-in-room ?x))
			(>= (battery-amount ?chibi) (* (litter-in-room ?x) 2))
			)
        :effect (and 
		   (decrease (inventory-space ?chibi) (litter-in-room ?x))
		   (decrease (battery-amount ?chibi) (* (litter-in-room ?x) 2)) 
		   (decrease (litter-in-room ?x) (litter-in-room ?x)) 
		   (increase (total-cost ?chibi) (* (litter-in-room ?x) 2))
		)
)


(:action dispose-litter
        :parameters (?x ?chibi)
        :precondition (and 
			(In ?x)
			(bin-in ?x) 
			(< (inventory-space ?chibi) 10)
			)
        :effect (and
		    (increase (inventory-space ?chibi) (item-capacity ?chibi))
		    (increase (total-cost ?chibi) 3)
		)
)


(:action cook
        :parameters (?x ?chibi) 
        :precondition (and 
			(In ?x)
			(kitchen ?x)
			(family-hungry)
			(>= (battery-amount ?chibi) 6)
			)
        :effect (and
		   (decrease (battery-amount ?chibi) 6)
		   (not (family-hungry))
		   (increase (total-cost ?chibi) 6)
		  )
)


(:action feed-fish
        :parameters (?x ?chibi)
        :precondition (and 
			(In ?x)
			(livingroom ?x)
			(fish-hungry)
			(>= (battery-amount ?chibi) 2)
			)
        :effect (and
		(decrease (battery-amount ?chibi) 2)
		(not (fish-hungry))
		(increase (total-cost ?chibi) 2)
		)
)

(:action water-plants
        :parameters (?x ?chibi)
        :precondition (and 
			(In ?x) 
			(garden ?x)
			(> (plants-garden ?x) 0)
			(>= (battery-amount ?chibi) (plants-garden ?x))
			)
        :effect (and
	           (increase (total-cost ?chibi) (plants-garden ?x))
		   (decrease (battery-amount ?chibi) (plants-garden ?x))
		   (decrease (plants-garden ?x) (plants-garden ?x))
		)
)

(:action charge-batery
        :parameters (?x ?chibi)
        :precondition (and 
			(In ?x)
			(<= (battery-amount ?chibi) 8) 
			)
        :effect (and
		   (increase (battery-amount ?chibi) 
	                (* (/ (- (battery-capacity ?chibi) (battery-amount ?chibi)) (recharge-rate ?chibi)) (recharge-rate ?chibi)))
		  (increase (total-cost ?chibi)
			 (/ (- (battery-capacity ?chibi) (battery-amount ?chibi)) (recharge-rate ?chibi)))

		)
)

)
