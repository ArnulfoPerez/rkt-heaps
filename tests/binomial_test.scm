(load "test-manager/load.scm")
(load "../binomial.scm")

(in-test-group
  binomial-heap
  (define-test (isheap)
    "Checking isheap? works fine"
    (assert-true (areheaps? (list (makeheap 1))))
    (assert-false (areheaps? (list (cons 1 0)))))
  
  (define-test (findmin)
    "Checking findmin"
    (assert-= 0 (findmin (cons 3 4)))
    (assert-= 1 (findmin (makeheap 1))))
  
  (define-test (meld)
    "Checking meld for not valid heaps"
    (assert-true (null? (meld (makeheap 1) (cons 1 2)))))
  
  (define-test (root-index)
               "Checking root index gives the correct index for root value in the vector"
               (assert-equal 0 (root-index 0)))
  
  (define-test (empty-slot)
               "Checking empty slot in the vector"
               (assert-true (empty-slot? (make-vector 1 -1) 0))
               (assert-false (empty-slot? (vector '1 '2 '3) 1))
               (assert-true (empty-slot? (vector '1 '2 '3 '-1) 2)))
  
  (define-test (value-at)
               "Checking for correct value extraction from the vector"
               (assert-equal 2 (value-at (vector '1 '2 '3) 1))))

(run-registered-tests)
