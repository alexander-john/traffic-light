;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname traffic-light) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

; Physical constants
(define RADIUS 30)
(define RATE 2)

; TrafficLight -> Image
; big-bang obtains the image of the current
; state of the traffic light by evaluating (render tl)
(check-expect (render "red") (circle RADIUS "solid" "red"))
(define (render cs)
  (circle RADIUS "solid" cs))

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (next "red") "green")
(check-expect (next "green") "yellow")
(check-expect (next "yellow") "red")
(define (next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; TrafficLight -> TrafficLight
; launches the program from some initial state
(define (main cs)
  (big-bang cs
    [on-tick next RATE]
    [to-draw render]))
