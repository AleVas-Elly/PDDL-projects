(define (domain localization)

	(:requirements
		:typing
		:durative-actions
		:numeric-fluents
		:negative-preconditions
		:action-costs
		:conditional-effects
		:equality
		:fluents )


	(:types 	robot region 
	)

	(:predicates
		(robot_in ?v - robot ?r - region) ;a robot is in a certain region.
		(visited ?r - region )			         ; a robot has visited a certain region
		(path ?from ?to - region)		  ; tracks the path of the robot
	      
	)

	(:functions 
		(act-cost)								;actual cost of the path performed by the robot
		(triggered ?from ?to - region)	     ; 
		(dummy)
		(drive)
	)

	(:durative-action goto_region
		:parameters (?v - robot ?from ?to - region)
		:duration (= ?duration 100)
		:condition (and (at start (robot_in ?v ?from)) (at start (< (drive) 1)))
	        :effect (and (at start (not (robot_in ?v ?from))) (at end (visited ?to))
                     (at end (robot_in ?v ?to)) (at end (path ?from ?to))
                     (at end (increase (drive) 1))
                )
	)


	(:durative-action compute_cost
        	:parameters (?v - robot ?from ?to - region)
        	:duration (= ?duration 0.001)
        	:condition (and (at start (path ?from ?to)) (at start (> (drive) 0)))
        	:effect (and (at start (increase (triggered ?from ?to) 1))
                     (at end (not (path ?from ?to)))
                     (at end (assign (triggered ?from ?to) 0))
                     (at end (increase (act-cost) (dummy)))
                     (at end (assign (drive) 0))
                )
 	)
	
)

