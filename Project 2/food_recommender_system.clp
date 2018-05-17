(clear)
(reset)
(import nrc.fuzzy.*)
(import nrc.fuzzy.jess.*)

; These are the global fuzzy variables
(defglobal ?*meal* = (new nrc.fuzzy.FuzzyVariable "meal" 0.0 10.0 "Type of Meal"))
(defglobal ?*proteins* = (new nrc.fuzzy.FuzzyVariable "proteins" 0.0 300 "Grams"))
(defglobal ?*carbs* = (new nrc.fuzzy.FuzzyVariable "carbs" 0.0 600 "Grams"))
(defglobal ?*fats* = (new nrc.fuzzy.FuzzyVariable "fats" 0.0 200 "Grams"))

(defglobal ?*proteinsveg* = (new nrc.fuzzy.FuzzyVariable "suggestion1" 1.0 5.0 ""))
(defglobal ?*proteinsnonveg* = (new nrc.fuzzy.FuzzyVariable "suggestion2" 1.0 5.0 ""))

(defglobal ?*carbsveg* = (new nrc.fuzzy.FuzzyVariable "suggestion3" 1.0 5.0 ""))
(defglobal ?*carbsnonveg* = (new nrc.fuzzy.FuzzyVariable "suggestion4" 1.0 5.0 ""))

(defglobal ?*fatsveg* = (new nrc.fuzzy.FuzzyVariable "suggestion5" 1.0 5.0 ""))
(defglobal ?*fatsnonveg* = (new nrc.fuzzy.FuzzyVariable "suggestion6" 1.0 5.0 ""))

(defglobal ?*lowallveg* = (new nrc.fuzzy.FuzzyVariable "suggestion7" 1.0 5.0 ""))
(defglobal ?*highallveg* = (new nrc.fuzzy.FuzzyVariable "suggestion8" 1.0 5.0 ""))

(defglobal ?*lowallnonveg* = (new nrc.fuzzy.FuzzyVariable "suggestion9" 1.0 5.0 ""))
(defglobal ?*highallnonveg* = (new nrc.fuzzy.FuzzyVariable "suggestion10" 1.0 5.0 ""))


; This is the initial rule that initializes the different possibilities of each
; fuzzy variable

(defrule initFuzzy
    =>
    (load-package nrc.fuzzy.jess.FuzzyFunctions) 
    (?*meal* addTerm "veg" (create$ 0.0 5.0) (create$ 1.0 0.0) 2)
    (?*meal* addTerm "nonveg" (create$ 5.0 10.0) (create$ 0.0 1.0) 2)
    (?*proteins* addTerm "low" (create$ 0.0 100.0) (create$ 1.0 0.0) 2)
    (?*proteins* addTerm "high" (create$ 100.0 300.0) (create$ 0.0 1.0) 2)
    (?*carbs* addTerm "less" (create$ 0.0 300) (create$ 1.0 0.0) 2)
    (?*carbs* addTerm "more" (create$ 300 600) (create$ 0.0 1.0) 2)
    (?*fats* addTerm "less" (create$ 0.0 80) (create$ 1.0 0.0) 2)
    (?*fats* addTerm "more" (create$ 80 200) (create$ 0.0 1.0) 2)
    
    (?*carbsveg* addTerm "lowcarb" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*carbsveg* addTerm "highcarb" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    (?*carbsnonveg* addTerm "lowcarb" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*carbsnonveg* addTerm "highcarb" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    (?*proteinsveg* addTerm "lowprotein" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*proteinsveg* addTerm "highprotein" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    (?*proteinsnonveg* addTerm "lowprotein" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*proteinsnonveg* addTerm "highprotein" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    
    (?*fatsveg* addTerm "lowfat" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*fatsveg* addTerm "highfat" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    (?*fatsnonveg* addTerm "lowfat" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*fatsnonveg* addTerm "highfat" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    
    (?*lowallveg* addTerm "lowall" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*highallveg* addTerm "highall" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    (?*lowallnonveg* addTerm "lowall" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*highallnonveg* addTerm "highall" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    (assert (initDone))
    )

; Once the fuzzy variables are initialized, the user is prompted for input using this rule
; Then based on user input, this rule creates necessary facts for recommendation

(defrule acceptVal
    (initDone)
    =>
    (printout t "Please enter your name: ")
    (bind ?name (readline))
    (printout t crlf )
    (printout t "Hello, " ?name "." crlf)
    (printout t "Welcome to the Fuzzy Recipe Recommender System." crlf)
    (printout t "Please answer the following questions and we will tell you what you can eat." crlf)
   (printout t "What would you like to have?( veg or nonveg):" crlf)
	(bind ?ml (readline))
    (printout t "Do you want to have a high protein meal or a low protein meal?( low, medium or high):" crlf)
    (bind ?pt (readline))
    (printout t "Do you want to have a less carbohydrates or more carbohydrates in your diet?( less, medium or more):" crlf)
    (bind ?cb (readline))
    (printout t "How much fats do you want to consume in your meal?( less, medium or more):" crlf)
    (bind ?ft (readline))
	(assert (meal (new nrc.fuzzy.FuzzyValue ?*meal* ?ml)))
    (assert (proteins (new nrc.fuzzy.FuzzyValue ?*proteins* ?pt)))
    (assert (carbs (new nrc.fuzzy.FuzzyValue ?*carbs* ?cb)))
    (assert (fats (new nrc.fuzzy.FuzzyValue ?*fats* ?ft))))

; Each rule tackles one particular combination of proteins, Carbohydrates, fats and type of meal.
; Proteins has 3 possibilities, carbohydrates has 3 possibilities, fats has 3 possibilities and type of meal has 2 possibilities.
; This gives to a total of 54 rules to cover all combinations of the above three
; The following 24 rules are for the same.

; Rule 1
(defrule V_L_L_L
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "less"))
    (fats ?b&:(fuzzy-match ?b "less"))
    =>
    (assert (suggestion7 (new nrc.fuzzy.FuzzyValue ?*lowallmeal* "lowall")))
    )

; Rule 2
(defrule V_H_L_L
   (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "less"))
    (fats ?b&:(fuzzy-match ?b "less"))
    =>
    (assert (suggestion1 (new nrc.fuzzy.FuzzyValue ?*proteinsveg* "highprotein")))
    )

; Rule 3
(defrule V_L_H_L
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "more"))
    (fats ?b&:(fuzzy-match ?b "less"))
    =>
    (assert (suggestion3 (new nrc.fuzzy.FuzzyValue ?*carbsveg* "highcarb")))
    )

; Rule 4
(defrule V_L_L_H
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "less"))
    (fats ?b&:(fuzzy-match ?b "more"))
    =>
    (assert (suggestion5 (new nrc.fuzzy.FuzzyValue ?*fatsveg* "highfat")))
    )

; Rule 5
(defrule V_H_H_L
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "more"))
    (fats ?b&:(fuzzy-match ?b "less"))
    =>
    (assert (suggestion5 (new nrc.fuzzy.FuzzyValue ?*fatsveg* "lowfat")))
    )

; Rule 6
(defrule V_H_L_H
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "less"))
    (fats ?b&:(fuzzy-match ?b "more"))
    =>
    (assert (suggestion3 (new nrc.fuzzy.FuzzyValue ?*carbsveg* "lowcarb")))
    )

; Rule 7
(defrule V_L_H_H
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "more"))
    (fats ?b&:(fuzzy-match ?b "more"))
    =>
    (assert (suggestion1 (new nrc.fuzzy.FuzzyValue ?*proteinsveg* "lowprotein")))
    )

; Rule 8
(defrule V_H_H_H
    (meal ?f&:(fuzzy-match ?f "veg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "more"))
    (fats ?b&:(fuzzy-match ?b "more"))
    =>
    (assert (suggestion8 (new nrc.fuzzy.FuzzyValue ?*highallveg* "highall")))
    )

; Rule 9
(defrule N_L_L_L
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "less"))
    (fats ?b&:(fuzzy-match ?b "less"))
    =>
    (assert (suggestion9 (new nrc.fuzzy.FuzzyValue ?*lowallnonveg* "lowall")))
    )

; Rule 10
(defrule N_H_L_L
   (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "less"))
    (fats ?b&:(fuzzy-match ?b "less"))
    =>
    (assert (suggestion2 (new nrc.fuzzy.FuzzyValue ?*proteinsnonveg* "highprotein")))
    )

; Rule 11
(defrule N_L_H_L
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "more"))
    (fats ?b&:(fuzzy-match ?b "less"))
    =>
    (assert (suggestion4 (new nrc.fuzzy.FuzzyValue ?*carbsnonveg* "highcarb")))
    )

; Rule 12
(defrule N_L_L_H
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "less"))
    (fats ?b&:(fuzzy-match ?b "more"))
    =>
    (assert (suggestion6 (new nrc.fuzzy.FuzzyValue ?*fatsnonveg* "highfat")))
    )

; Rule 13
(defrule N_H_H_L
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "more"))
    (fats ?b&:(fuzzy-match ?b "less"))
    =>
    (assert (suggestion6 (new nrc.fuzzy.FuzzyValue ?*fatsnonveg* "lowfat")))
    )

; Rule 14
(defrule N_H_L_H
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "less"))
    (fats ?b&:(fuzzy-match ?b "more"))
    =>
    (assert (suggestion4 (new nrc.fuzzy.FuzzyValue ?*carbsnonveg* "lowcarb")))
    )

; Rule 15
(defrule N_L_H_H
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "low"))
    (carbs ?a&:(fuzzy-match ?a "more"))
    (fats ?b&:(fuzzy-match ?b "more"))
    =>
    (assert (suggestion2 (new nrc.fuzzy.FuzzyValue ?*proteinsnonveg* "lowprotein")))
    )

; Rule 16
(defrule N_H_H_H
    (meal ?f&:(fuzzy-match ?f "nonveg"))
    (proteins ?c&:(fuzzy-match ?c "high"))
    (carbs ?a&:(fuzzy-match ?a "more"))
    (fats ?b&:(fuzzy-match ?b "more"))
    =>
    (assert (suggestion10 (new nrc.fuzzy.FuzzyValue ?*highallnonveg* "highall")))
    )

;Matching Rules for starter

(defrule Recom1
    (suggestion7 ?i&:(fuzzy-match ?i "lowall"))
    =>
    (printout t "You can cook Broccoli curry." crlf))

(defrule Recom2
    (suggestion1 ?i&:(fuzzy-match ?i "highprotein"))
    =>
    (printout t "You can cook: 1. Cashew Noodles with Broccoli and Tofu. Follow this link for the recipe: " )
	(printout t "https://www.eatthis.com/protein-vegetarian-meals/" crlf)
	(printout t "			   2. Grain-Free Apple Walnut Pancakes. Follow this link for the recipe: " crlf)
	(printout t "https://www.eatthis.com/protein-vegetarian-meals/" crlf)
	(printout t "		       3. Avocado and Heirloom Tomato Toast with Balsamic Drizzle. Follow this link for the recipe: " crlf)
	(printout t "https://www.eatthis.com/protein-vegetarian-meals/" crlf))

(defrule Recom3
    (suggestion3 ?j&:(fuzzy-match ?j "highcarb"))
    =>
   (printout t "You can cook Fiesta Lime & Black Bean Rice." crlf))
    
(defrule Recom4
    (suggestion5 ?k&:(fuzzy-match ?k "highfat"))
    =>
    (printout t "You can cook Low-carb Falafel with Tahini sauce." crlf))

(defrule Recom5
    (suggestion5 ?ll&:(fuzzy-match ?ll "lowfat"))
    =>
    (printout t "You can cook Butternut Squash Pizzas with Rosemary." crlf))

(defrule Recom6
    (suggestion3 ?ll&:(fuzzy-match ?ll "lowcarb"))
    => (printout t "You can cook Grilled Ginger Cauliflower With Tahini Sauce." crlf))
    
(defrule Recom7
    (suggestion1 ?ll&:(fuzzy-match ?ll "lowprotein"))
    =>
     (printout t "You can cook Vegetarian Tourtiere." crlf))

(defrule Recom8
    (suggestion8 ?i&:(fuzzy-match ?i "highall"))
    =>
     (printout t "You can cook wok stir fry with rice, vegetables and tofu." crlf))

(defrule Recom9
    (suggestion9 ?i&:(fuzzy-match ?i "lowall"))
    =>
    (printout t "You can cook kebabs, using small pieces of meat and more vegetables." crlf))

(defrule Recom10
    (suggestion2 ?i&:(fuzzy-match ?i "highprotein"))
    =>
    (printout t "You can cook Thai-turkey wraps." crlf))

(defrule Recom11
    (suggestion4 ?j&:(fuzzy-match ?j "highcarb"))
    =>
   (printout t "You can cook Quinoa with sweet-potatoes." crlf))
    
(defrule Recom12
    (suggestion6 ?k&:(fuzzy-match ?k "highfat"))
    =>
    (printout t "You can cook grilled lamb with steamed broccoli and spinach." crlf))

(defrule Recom13
    (suggestion6 ?ll&:(fuzzy-match ?ll "lowfat"))
    =>
    (printout t "You can cook shrimp with Tahini sauce." crlf))

(defrule Recom14
    (suggestion4 ?ll&:(fuzzy-match ?ll "lowcarb"))
    => (printout t "You can cook lean poultry with lots of vegetables." crlf))
    
(defrule Recom15
    (suggestion2 ?ll&:(fuzzy-match ?ll "lowprotein"))
    =>
     (printout t "You can cook crisp vegetables and small strips of meat." crlf))

(defrule Recom16
    (suggestion10 ?i&:(fuzzy-match ?i "highall"))
    =>
     (printout t "You can cook  brown rice and skinless chicken breast." crlf))

(run)