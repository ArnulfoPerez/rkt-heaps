;;; Book-keeper of the functions to be implemented 
;; makeheap(i) 
;; isheap? 
;; findmin(h) 
;; insert(h,i) -> meld(h,makeheap(i)) 
;; deletemin(h) 
;; meld(h,h') 

;;; Description: Returns a new heap containing only element
;; Commentary:
;; - the heap is structured in a pair with `car` pointing to a vector and `cdr` pointing to the index of the smallest root of a binomial tree in the heap.
(define (makeheap i)
  (cons (make-vector 1 i) 0))

;;; Description: Returns the min element in the heap
;; Commentary: 
;; - vector-ref is takes constant time - www.eecs.berkeley.edu/~bh/ssch23/vectors.html 
;; - if actual argument is not a heap, function returns 0
(define (findmin h)
  (if (checkheap? h)
    (vector-ref (car h) (cdr h))
    0))

;;; Description: Predicate based on the structural formation of binomial heap
(define (areheaps? h)
  (for-all? h checkheap?))

(define (checkheap? h)
  (and (vector? (car h)) (< (cdr h) (vector-length (car h)))))

;;; Description: Returns a heap which a combination of the two heaps provided as arguments to the method. 
;; todo: find the resultant min. element of the combined heap
(define (meld h1 h2)
  (if (areheaps? (list h1 h2))
    (let ((v1_range (vector-length (car h1))) (v2_range (vector-length (car h2))))

     ;; Description: Takes vectors only as input arguments and returns the resultant heap/vector. The combination is done with the following rules:
     ;; - if both heaps have h_i's, then the resultant heap will get one b_(i+1). 
     ;; - if more than 2 h_i's, then as before two will combine to form b_(i+1) and any one will stay as h_i
     ;; - if neither heaps have a h_i, then the resultant shall also not have one unless not carried forward from h_(i-1)
     ;; - if either one of the heaps have h_i, then it is also the h_i for the combined heap
     (define (combine v1 v2 i)
       (cond ((and (< v1_range (rootindex i)) (< v2_range (rootindex i))) #())
             ((< v1_range (rootindex i)) (subvector v2 (rootindex i) (vector-length v2)))
             ((< v2_range (rootindex i)) (subvector v1 (rootindex i) (vector-length v1)))
             ((and (not (emptyslot? v1 i)) (not (emptyslot? v2 i)))
              (let ((result (make-vector (expt 2 i) -1))) 
               (cond ((<= (valueat v1 i) (valueat v2 i))
                      (vector-append result 
                                     (subvector v1 (rootindex i) (rootindex (+ i 1))) 
                                     (subvector v2 (rootindex i) (rootindex (+ i 1)))
                                     (combine v1 v2 (+ i 1))))
                     ((> (valueat v1 i) (valueat v2 i))
                      (vector-append result 
                                     (subvector v2 (rootindex i) (rootindex (+ i 1)))
                                     (subvector v1 (rootindex i) (rootindex (+ i 1)))
                                     (combine v1 v2 (+ i 1)))))))
             ((and (empty-slot? v1 i) (empty-slot? v2 i))
              (vector-append (make-vector (expt 2 i) -1)
                             (combine v1 v2 (+ i 1))))
             ((or (empty-slot? v1 i) (empty-slot? v2 i))
              (cond ((empty-slot? v1 i) 
                     (vector-append (subvector v2 (rootindex i) (rootindex (+ i 1))) 
                                    (combine v1 v2 (+ i 1))))
                    ((empty-slot? v2 i)
                     (vector-append (subvector v1 (rootindex i) (rootindex (+ i 1)))
                                    (combine v1 v2 (+ i 1))))))))
     (cons (combine (car h1) (car h2) 0) 0)) 
    '()))

;;; Description: Returns the vector index of the root of a tree in the heap
(define (rootindex i)
  (- (expt 2 i) 1))

;;; Description: Returns whether the root of a tree in the heap is vacant or not
(define (emptyslot? vec i)
  (eq? (valueat vec i) -1))

;;; Description: Returns the root element of a tree in the heap
(define (valueat vec i)
  (vector-ref vec (rootindex i)))
