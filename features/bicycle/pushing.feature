@routing @bicycle @pushing
Feature: Bike - Accessability of different way types

	Background:
		Given the profile "bicycle"
        Given the shortcuts
		 | key  | value     |
		 | bike | 49s ~20%  |
		 | foot | 121s ~20% |

	Scenario: Bike - Pushing bikes on pedestrian-only ways
	 	Then routability should be
		 | highway    | oneway | forw | backw |
		 | (nil)      |        |      |       |
		 | cycleway   |        | bike | bike  |
		 | primary    |        | bike | bike  |
		 | pedestrian |        | foot | foot  |
		 | footway    |        | foot | foot  |
		 | primary    | yes    | bike | foot  |

 	Scenario: Bike - Pushing bikes against normal oneways
 	 	Then routability should be
 		 | highway    | oneway | forw | backw |
 		 | (nil)      |        |      |       |
 		 | primary    | yes    | bike | foot  |
 		 | pedestrian | yes    | foot | foot  |

  	Scenario: Bike - Pushing bikes against reverse oneways
  	 	Then routability should be
  		 | highway    | oneway | forw | backw |
  		 | (nil)      |        |      |       |
  		 | primary    | -1     | foot | bike  |
  		 | pedestrian | -1     | foot | foot  |

 	@square	
 	Scenario: Bike - Push bikes on pedestrian areas
 		Given the node map
 		 | x |   |
 		 | a | b |
 		 | d | c |

 		And the ways
 		 | nodes | area | highway    |
 		 | xa    |      | primary    |
 		 | abcda | yes  | pedestrian |

 		When I route I should get
 		 | from | to | route |
 		 | a    | b  | abcda |
 		 | a    | d  | abcda |
 		 | b    | c  | abcda |
 		 | c    | b  | abcda |
 		 | c    | d  | abcda |
 		 | d    | c  | abcda |
 		 | d    | a  | abcda |
 		 | a    | d  | abcda |

 	Scenario: Bike - Pushing bikes on ways with foot=yes
 	 	Then routability should be
 		 | highway  | foot | bothw |
 		 | motorway |      |       |
 		 | motorway | yes  | foot  |
 		 | runway   |      |       |
 		 | runway   | yes  | foot  |
    
    @todo
  	Scenario: Bike - Pushing bikes on ways with foot=yes in one direction
  	 	Then routability should be
  		 | highway  | foot:forward | foot:backward | forw | backw |
  		 | motorway |              |               |      |       |
  		 | motorway | yes          |               | foot |       |
  		 | motorway |              | yes           |      | foot  |

    @construction
 	Scenario: Bike - Don't allow routing on ways still under construction 
 	 	Then routability should be
 		 | highway      | foot | bicycle | bothw |
 		 | primary      |      |         | x     |
 		 | construction |      |         |       |
 		 | construction | yes  |         |       |
 		 | construction |      | yes     |       |
        
    @roundabout
  	Scenario: Bike - Don't push bikes against oneway flow on roundabouts
  	 	Then routability should be
  		 | junction   | forw | backw |
  		 | roundabout | x    |       |
