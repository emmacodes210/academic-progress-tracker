;; Academic Progress Tracker Smart Contract
;; This contract enables students to register, update, and retrieve their academic profiles.
;; It stores educational information such as courses, goals, and academic metrics.

;; Main data storage for student academic records
(define-map student-records
    principal
    {
        full-name: (string-ascii 100),
        semester-count: uint,
        credits-earned: uint,           ;; Track academic progress with credits
        study-hours: uint,              ;; Weekly study hours commitment
        academic-objective: (string-ascii 100),  ;; Career or educational goal
        enrolled-courses: (list 10 (string-ascii 100))  ;; Current semester courses
    }
)

;; System error codes for academic record operations
(define-constant ERR-RECORD-NOT-FOUND (err u404))
(define-constant ERR-RECORD-ALREADY-EXISTS (err u409))
(define-constant ERR-INVALID-SEMESTER-COUNT (err u400))
(define-constant ERR-INVALID-FULL-NAME (err u401))
(define-constant ERR-INVALID-CREDITS (err u402))
(define-constant ERR-INVALID-STUDY-HOURS (err u403))
(define-constant ERR-INVALID-OBJECTIVE (err u404))
(define-constant ERR-INVALID-COURSES (err u405))
