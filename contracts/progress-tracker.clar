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

;; Creates a new academic profile for a student
;; Parameters capture essential academic information
(define-public (create-academic-profile 
    (full-name (string-ascii 100))
    (semester-count uint)
    (credits-earned uint)
    (study-hours uint)
    (academic-objective (string-ascii 100))
    (enrolled-courses (list 10 (string-ascii 100))))
    (let
        (
            (student-id tx-sender)
            (existing-record (map-get? student-records student-id))
        )
        ;; Verify the student doesn't already have a profile
        (if (is-none existing-record)
            (begin
                ;; Data validation for academic profile
                (if (or (is-eq full-name "")
                        (< semester-count u1)
                        (> semester-count u12)
                        (< credits-earned u0) 
                        (> credits-earned u200) 
                        (< study-hours u1) 
                        (> study-hours u100) 
                        (is-eq academic-objective "")
                        (is-eq (len enrolled-courses) u0))
                    (err ERR-INVALID-SEMESTER-COUNT)
                    (begin
                        ;; Store the new academic profile
                        (map-set student-records student-id
                            {
                                full-name: full-name,
                                semester-count: semester-count,
                                credits-earned: credits-earned,
                                study-hours: study-hours,
                                academic-objective: academic-objective,
                                enrolled-courses: enrolled-courses
                            }
                        )
                        (ok "Academic profile successfully created.")
                    )
                )
            )
            (err ERR-RECORD-ALREADY-EXISTS)
        )
    )
)

;; Updates an existing academic profile with new information
;; Allows students to track their progress over time
(define-public (modify-academic-profile
    (full-name (string-ascii 100))
    (semester-count uint)
    (credits-earned uint)
    (study-hours uint)
    (academic-objective (string-ascii 100))
    (enrolled-courses (list 10 (string-ascii 100))))
    (let
        (
            (student-id tx-sender)
            (existing-record (map-get? student-records student-id))
        )
        ;; Ensure the student profile exists before modification
        (if (is-some existing-record)
            (begin
                ;; Validate updated academic information
                (if (or (is-eq full-name "")
                        (< semester-count u1)
                        (> semester-count u12)
                        (< credits-earned u0) 
                        (> credits-earned u200) 
                        (< study-hours u1) 
                        (> study-hours u100) 
                        (is-eq academic-objective "")
                        (is-eq (len enrolled-courses) u0))
                    (err ERR-INVALID-SEMESTER-COUNT)
                    (begin
                        ;; Update the existing academic profile
                        (map-set student-records student-id
                            {
                                full-name: full-name,
                                semester-count: semester-count,
                                credits-earned: credits-earned,
                                study-hours: study-hours,
                                academic-objective: academic-objective,
                                enrolled-courses: enrolled-courses
                            }
                        )
                        (ok "Academic profile successfully updated.")
                    )
                )
            )
            (err ERR-RECORD-NOT-FOUND)
        )
    )
)

;; Retrieves a student's complete academic profile
;; Used for transcript requests and academic advising
(define-read-only (retrieve-academic-profile (student-id principal))
    (match (map-get? student-records student-id)
        profile (ok profile)
        ERR-RECORD-NOT-FOUND
    )
)

;; Fetches only the course enrollment information for a student
;; Useful for departmental course planning and administration
(define-read-only (retrieve-student-courses (student-id principal))
    (match (map-get? student-records student-id)
        profile (ok (get enrolled-courses profile))
        ERR-RECORD-NOT-FOUND
    )
)

;; Retrieves a student's academic objective
;; Used by academic advisors for career guidance
(define-read-only (retrieve-student-objective (student-id principal))
    (match (map-get? student-records student-id)
        profile (ok (get academic-objective profile))
        ERR-RECORD-NOT-FOUND
    )
)

;; Helper function to calculate estimated graduation date
;; Based on current semester and typical program length
(define-read-only (calculate-graduation-estimate (student-id principal))
    (match (map-get? student-records student-id)
        profile (let ((remaining-semesters (- u8 (get semester-count profile))))
                  (ok remaining-semesters))
        ERR-RECORD-NOT-FOUND
    )
)

