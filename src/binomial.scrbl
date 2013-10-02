#lang scribble/manual

@(require scribble/eval (for-label "binomial.rkt"))

@title{Binomial heaps}

@defmodule[binomial #:use-sources ("binomial.rkt")]

Binomial Heaps

@(define the-eval (make-base-eval))
@(the-eval '(require "binomial.rkt"))

A @deftech{Binomial heap} is a data structure for maintaining a collection of elements, such that new elements can be added and the element of minimum value extracted efficiently. This implmentation is purely functional hence @defterm{immutable}. @deftech{Binomial heap} allow only numbers to be stored in them.

@hyperlink["https://github.com/ajauhri/rkt-heaps/blob/master/src/binomial_helper.rkt" "heap-lazy?"] is just a check if the given argument complies with the binomial heap structure adopted in this implementation. @deftech{Binomial heaps} have not implemented using @racket[struct]. All values of the heap are stored in a vector which is pointed by @racket[car] of a pair. The @racket[cdr] is the count/size of the heap. This pair is embedded within another pair's @racket[car]. The @racket[cdr] of the outer pair stores the min value of the heap.

@defproc[(makeheap [val number?]) heap-lazy?]{

Returns a newly allocated heap with only one element @racket[val].
@examples[#:eval the-eval
	(define h (makeheap 1))
	h]}

@defproc[(findmin [h heap-lazy?]) number?]{
	
Returns a minimum value in the heap @racket[h].
@examples[#:eval the-eval
	(define h (meld (makeheap 1) (makeheap 2)))
	(findmin h)]}

@defproc[(insert [h heap-lazy?]
		 [val number?]) heap-lazy?]{

Returns a newly allocated heap which is a copy of @racket[h] along with @racket[val].
@examples[#:eval the-eval
	(define h (makeheap 1))
	(insert h 2)]}

@defproc[(deletemin [h heap?]) heap?]{

Returns a newly allocated heap with the min value of the given heap @racket[h] removed.
@examples[#:eval the-eval
	(define h (makeheap 1))
	(deletemin h)]}

@defproc[(meld [h1 heap-lazy?]
	       [h2 heap-lazy?]) heap?]{

Returns a newly allocated heap by coupling @racket[h1] and @racket[h2].
@examples[#:eval the-eval 
	(define h (meld (makeheap 1) (makeheap 2)))
	h]}

@defproc[(count [h heap-lazy?]) exact-nonnegative-integer?]{

Returns the count of the elements in the heap @racket[h]}
