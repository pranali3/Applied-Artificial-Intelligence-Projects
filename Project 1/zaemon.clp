;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Eye Diseases Diagnosing Expert System
;; Computer Science Department
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Patient template
(clear)
(reset)

(deftemplate Patient
(multislot name)
(slot age)
(slot sex))

;;Symptoms template

(deftemplate Symptoms
(slot blurredVision)
(slot HazyVision)
(slot DoubleVision)
(slot EyeIrritation)
(slot ExcessiveBlinking)
(slot ExcessiveDryness)
(slot retina-disturbance)
(slot distortion-of-straight-lines)
(slot protuding-eyes)
(slot excessive-dryness)
(slot opaqueLens)
(slot misalignedEyes)
(slot WavyVision)
(slot changes-viewing-colors)
(slot clouds-across-field-of-vision)
(slot headache)
(slot nausea)
(slot vomiting)
(slot cone-shaped-cornea)
(slot poor-vision-in-one-eye)
(slot blurredVision)
(slot NightBlindness)
(slot increased-pressure-in-eyes)
(slot EyeFloaters)
(slot EyeInflammation)
(slot difficult-to-distinguish-colors)
(slot increase-in-eye-floaters)
(slot sudden-decrease-in-vision)
(slot Involuntary-eye-movement))

;;Disease template

(deftemplate Disease
(slot disease))

;;Rules


(defrule EyelidTwitching ;1
(Patient (name ?first ?last)(age ?age)(sex ?sex))
(Symptoms (EyeIrritation yes))(Symptoms (ExcessiveBlinking yes))(Symptoms(Involuntary-eye-movement yes))

=>  (printout t ?first " "?last " has Eyelid Twitching." crlf )
    (assert(Disease (disease EyelidTwitching))))

(defrule AMD ;2
(Patient (name ?first ?last)(age ?age)(sex ?sex))(test(> ?age 60))
(Symptoms (retina-disturbance yes))
(Symptoms(distortion-of-straight-lines yes))(Symptoms (blurredVision yes))
=> (printout t ?first " "?last " has Age-related Macular Degeneration." crlf )
(assert (Disease (disease AMD))))

(defrule BulgingEyes ;3
(Patient (name ?first ?last)(age ?age)(sex ?sex))
(Symptoms (protuding-eyes yes))(Symptoms (ExcessiveDryness yes))

=>  (printout t ?first " "?last " has Bulging Eyes." crlf )
    (assert(Disease (disease BulgingEyes))))
;;facts



(defrule Cataracts ;4
(Patient (name ?first ?last)(age ?age)(sex ?sex))(test (> ?age 65))
(Symptoms (blurredVision yes))
(Symptoms(DoubleVision yes))(Symptoms (opaqueLens yes))

=>  (printout t ?first " "?last " has Cataracts." crlf )
    (assert(Disease (disease Cataracts))))
	
(defrule CrossedEyes ;5
(Patient (name ?first ?last)(age ?age)(sex ?sex))
(Symptoms (misalignedEyes yes))

=>  (printout t ?first " "?last " has Crossed Eyes(Strabismus)." crlf )
    (assert(Disease (disease CrossedEyes))))

(defrule DME ;6
(Patient (name ?first ?last)(age ?age)(sex ?sex))(test(> ?age 60))
(Symptoms (WavyVision yes))
(Symptoms(blurredVision yes))(Symptoms (changes-viewing-colors yes))

=>  (printout t ?first " "?last " has Diabetic Macular Edema." crlf )
    (assert(Disease (disease DME))))
	
(defrule EyeFloaters ;7
(Patient (name ?first ?last)(age ?age)(sex ?sex))
(Symptoms (clouds-across-field-of-vision yes))

=>  (printout t ?first " "?last " has Eye Floaters." crlf )
    (assert(Disease (disease EyeFloaters))))
	
(defrule Glaucoma ;8
(Patient (name ?first ?last)(age ?age)(sex ?sex))(test(> ?age 65))
(Symptoms (blurredVision yes))(Symptoms (headache yes))(Symptoms(nausea yes))(Symptoms(vomiting yes))

=>  (printout t ?first " "?last " has Glaucoma." crlf )
    (assert(Disease (disease Glaucoma))))

(defrule Keratoconus ;9
(Patient (name ?first ?last)(age ?age)(sex ?sex))
(Symptoms (cone-shaped-cornea yes))

=>  (printout t ?first " "?last " has Keratoconus." crlf )
    (assert(Disease (disease Keratoconus))))
	
(defrule LazyEye ;10
(Patient (name ?first ?last)(age ?age)(sex ?sex))
(Symptoms (poor-vision-in-one-eye yes))

=>  (printout t ?first " "?last " has Lazy Eye." crlf )
    (assert(Disease (disease LazyEye))))
	
(defrule LowVision ;11
(Patient (name ?first ?last)(age ?age)(sex ?sex))(test(> ?age 70))
(Symptoms (blurredVision yes))(Symptoms(HazyVision yes))(Symptoms(NightBlindness yes))

=>  (printout t ?first " "?last " has Low Vision." crlf )
    (assert(Disease (disease LowVision))))

(defrule OH ;12
(Patient (name ?first ?last)(age ?age)(sex ?sex))
(Symptoms (increased-pressure-in-eyes yes))

=>  (printout t ?first " "?last " has Ocular Hypertension." crlf )
    (assert(Disease (disease OH))))
	
(defrule CMV ;13
(Patient (name ?first ?last)(age ?age)(sex ?sex))
(Symptoms (EyeFloaters yes))(Symptoms (blurredVision yes))

=>  (printout t ?first " "?last " has CMV Retinitis." crlf )
    (assert(Disease (disease CMV))))
	
(defrule Uveitis ;14
(Patient (name ?first ?last)(age ?age)(sex ?sex))
(Symptoms (EyeFloaters yes)) (Symptoms(EyeInflammation yes))

=>  (printout t ?first " "?last " has Uveitis." crlf )
    (assert(Disease (disease Uveitis))))

(defrule ColorBlindness ;15
(Patient (name ?first ?last)(age ?age)(sex ?sex))
(Symptoms (difficult-to-distinguish-colors yes))

=>  (printout t ?first " "?last " has Color Blindness." crlf )
    (assert(Disease (disease ColorBlindness))))
	
(defrule RetinalDetachment ;16
(Patient (name ?first ?last)(age ?age)(sex ?sex))
(Symptoms (increase-in-eye-floaters yes))(Symptoms (sudden-decrease-in-vision yes))

=>  (printout t ?first " "?last " has Retinal Detachment." crlf )
    (assert(Disease (disease RetinalDetachment))))

(defrule EF ;17
(Disease (disease EyeFloaters))(Symptoms (blurredVision yes))

=>  (printout t ?first " "?last " has CMV Retinitis." crlf ))

;;Treatment

(defrule CMV1 ;18
(Disease (disease CMV))

=>  (printout t "Treatment for CMV: Medication (oral, injected or intravenous) or Laser Surgery." crlf ))

(defrule AMD1 ;19
(Disease (disease AMD))

=>  (printout t "Treatment for AMD: Currently no treatment. Use Magnifiers." crlf ))

(defrule BulgingEyes1 ;20
(Disease (disease BulgingEyes))

=>  (printout t "Treatment for Bulging Eyes: Use eye-drops for lubrication and consult an eye professional." crlf ))

(defrule Cataracts1 ;21
(Disease (disease Cataracts))

=>  (printout t "Treatment for Cataracts: Cataract Surgery." crlf ))


(defrule CE1 ;22
(Disease (disease CrossedEyes))

=>  (printout t "Treatment for Crossed Eyes: Eyeglasses or contact lenses or 
        Medication (eye drops) or Surgery or Patching or covering the better-seeing eye. " crlf ))

(defrule DME1 ;23
(Disease (disease DME))

=>  (printout t "Treatment for DME: Medication (eye drops) or Laser Surgery. " crlf ))

(defrule EF1 ;24
(Disease (disease EyeFloaters))

=>  (printout t "Treatment for Eye Floaters: Consult an eye professional. " crlf ))

(defrule G1 ;25
(Disease (disease Glaucoma))

=>  (printout t "Treatment for Glaucoma: Prescription eye drops or Glaucoma Surgery. " crlf ))

(defrule K1 ;26
(Disease (disease Keratoconus))

=>  (printout t "Treatment for Keratoconus: Contact lenses or Eyeglasses or Eye Surgery. " crlf ))

(defrule LE ;27
(Disease (disease LazyEye))

=>  (printout t "Treatment for LazyEye: Patching or covering the strong eye; 
        or contact lenses or eyeglasses; or eye surgery. " crlf ))

(defrule LV ;28
(Disease (disease LowVision))

=>  (printout t "Treatment for Low Vision: Use tinted eyewear or magnifiers." crlf ))

(defrule OH1 ;29
(Disease (disease OH))

=>  (printout t "Treatment for Ocular Hypertension: Medication (eye drops)." crlf ))

(defrule RT ;30
(Disease (disease RetinalDetachment))

=>  (printout t "Treatment for Retinal Detachment: Laser surgery." crlf ))

(defrule ET ;31
(Disease (disease EyelidTwitching))

=>  (printout t "Treatment for Eyelid Twitching: Facial injections or Surgery." crlf ))

(defrule Uv ;32
(Disease (disease Uveitis))

=>  (printout t "Treatment for Uveitis: Prescription eye drops in combination with anti-inflammatory medications
        or Surgery." crlf ))

(defrule CB1 ;33
(Disease (disease ColorBlindness))

=>  (printout t "Treatment for Color Blindness: There is no known cure for color blindness. 
        Contact lenses and glasses are available with filters to help color deficiencies, if needed." crlf ))

(deffacts cases (Patient(name Melisa Brown)(age 22)(sex female) )
(Symptoms (blurredVision yes)(EyeFloaters yes)(EyeInflammation yes)))





(reset)
(run)

