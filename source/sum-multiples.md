<!doctype html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link href="markdown.css" type="text/css" rel="stylesheet"></link>
    <link href="prettify.css" type="text/css" rel="stylesheet"></link>
    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/google-code-prettify/prettify.js"></script>
    <script type="text/javascript" src="https://d3eoax9i5htok0.cloudfront.net/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
    <script type="text/javascript" src="js/myscripts.js"></script>
    <title>Thousand Note - The Sum of Multiples</title>
</head>

<body onload="styleCode()">

[Thousandnote](index.html)

The Sum of Multiples
====================
Problem:

> If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
> 
> Find the sum of all the multiples of 3 or 5 below 1000.

Your solution
-------------
In Java,
    
    public static void runthenumbers(){
        int sum=0;
        for (int x=1;x<1000;x++){
            if(x%3==0 || x%5==0){
                sum+=x;
            }        }        out.println(sum);
    }    
    
Correct!

Two solutions in Python
-----------------------
I offer two solutions in Python to illustrate different ways of solving this problem.
The first solution is iterative. It is similar to yours and you are already familiar with this way of thinking.
The second solution is a [list comprehension](http://docs.python.org/tutorial/datastructures.html#list-comprehensions),
which comes more from the [functional programming](http://en.wikipedia.org/wiki/Functional_programming) paradigm.

    """
    If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
    
    Find the sum of all the multiples of 3 or 5 below 1000.    
    """
    
    def forLoops():
        t = 0
        for i in range(1,1000):
            if i % 3 == 0 or i % 5 == 0:
                t += i
        
        return t
    
    def listComp():
        return sum([i for i in range(1,1000) if i % 3 == 0 or i % 5 == 0])
       
    def test():
        """
        Makes sure that they get the same answer: 233168
        
        """
        a1 = forLoops()
        a2 = listComp()
        assert a1 == a2
        return "True"
       
    if __name__ == '__main__':
        print __doc__
        print "Test successful:", test()
   
List comprehensions are used often in Python and can be a very powerful construct.
   
My feedback
-----------
Both your solution and my two solutions are pretty inefficient. They are brute force
solutions to a potentially elegant problem. 

First of all, we iterate over every number from 1 to 1000, when it is obvious 
that most numbers, including 1 and 2, aren't multiples of 3 or 5. 

And second, as we learned with the [FizzBuzz](http://thousandnote.com/fizzbuzz.html) problem,
we can actually figure out exactly how many numbers are multiples of 3 and 5 with math. And
from there, a clever solution becomes much simpler!

Elegance with math
------------------
Remember how I explained how we can count the number of multiples of two numbers 
with the inclusion-exclusion principle? Let's apply some of that here.

    Let |A| be the set of multiples of 3 below 1000
    Let |B| be the set of multiples of 5 below 1000
    
Then,

    |A| = Floor(999/3) = 333
    |B| = Floor(999/5) = 199
    |A intersect B| = Floor(999/15) = 66

But how do you get the sum from this information? With a little help from 
[arithmetic progressions](http://en.wikipedia.org/wiki/Arithmetic_progression),

![Arithmetic Progression](http://upload.wikimedia.org/wikipedia/en/math/a/f/e/afe20f89d7bfdbd0a191168d80eb8077.png "Arithmetic Progression")

Where <i>a</i><sub>1</sub> is the initial term and <i>a</i><sub>n</sub> the nth. We come up with the formula, and the solution,

    3*333*(1+333)/2 + 5*199*(1+199)/2 - 15*66*(1+66)/2 = 233168
