;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname traffic-light) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define RED 0)
(define GREEN 1)
(define YELLOW 2)

; An S-TrafficLight is one of:
; – RED
; – GREEN
; – YELLOW

(define RED-BULB (circle 10 "outline" "red"))
(define YELLOW-BULB (circle 10 "outline" "yellow"))
(define GREEN-BULB (circle 10 "outline" "green"))

(define RED-LIGHT (circle 10 "solid" "red"))
(define YELLOW-LIGHT (circle 10 "solid" "yellow"))
(define GREEN-LIGHT (circle 10 "solid" "green"))

(define LIGHTS (beside RED-BULB YELLOW-BULB GREEN-BULB))

(define RED-ON (beside RED-LIGHT YELLOW-BULB GREEN-BULB))
(define YELLOW-ON (beside RED-BULB YELLOW-LIGHT GREEN-BULB))
(define GREEN-ON (beside RED-BULB YELLOW-BULB GREEN-LIGHT))



; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next-symbolic RED) GREEN)
(check-expect (tl-next-symbolic GREEN) YELLOW)
(check-expect (tl-next-symbolic YELLOW) RED)
(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))

 
; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render GREEN) GREEN-ON)
(check-expect (tl-render YELLOW) YELLOW-ON)
(check-expect (tl-render RED) RED-ON)
(define (tl-render current-state)
  (cond
    [(= RED current-state) RED-ON]
    [(= GREEN current-state) GREEN-ON]
    [(= YELLOW current-state) YELLOW-ON]))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next-symbolic 1]))