<link href="markdown.css" type="text/css" rel="stylesheet"></link>
<link href="prettify.css" type="text/css" rel="stylesheet"></link>
<script type="text/javascript" src="js/google-code-prettify/prettify.js"></script>
<script type="text/javascript" src="js/myscripts.js"></script>
<script type="text/javascript">
$(function() {
    styleCode();
});
</script>


[Thousandnote](index.html)

FizzBuzz
========
Problem:

> Write a program that prints the numbers from 1 to 100. But for multiples of three print "Fizz" instead of the number and for the multiples of five print "Buzz". For numbers which are multiples of both three and five print "FizzBuzz".

Your solution
-------------
In Java,
    
    public static void runthenumbers() throws IOException{
        String divisable;
        boolean mod;
    
        for(int x=1; x<=100;x++)
        {
            divisable="";
            mod=false;
            
            if (x%3==0){
                divisable="Fizz";
                mod=true;
            }
            
            if(x%5==0){
                divisable=divisable + "Buzz";
                mod=true;
            }
            
            if(mod==true){
                out.println(divisable);
            }
            
            else if (mod==false){
                out.println(x);
            }
    }
    
Good job! Your code works well. It gets the job done.

My feedback
-----------
I know that you came up with the most straightforward solution, and
it isn't the most elegant, but that's ok. I took the liberty to simplify your code a little bit,

    public static void runthenumbers() throws IOException{
		String txt;
		for(int x=1; x<=100;x++)
		{
			txt="";
			
			if (x%3==0){
				txt="Fizz";
			}
			
			if(x%5==0){
				txt=txt + "Buzz";
			}
			
			if(x%3!=0 && x%5!=0){
     			txt=Integer.toString(x);
			}
			
			out.println(txt);
		}
	}

There is no real need for you to have a separate boolean to determine if you are going to print out the string `divisible` or the integer `i` in the for loop. You can handle that with a single conditional: `if(x%3!=0 && x%5!=0)`.

A Python Solution
-----------------
Eventually, I'd like you to start programming in Python, so I'll also provide the solution in Python so you can begin to pick up the language,

    """
    Fizzbuzz.py
    
    Write a program that prints the numbers from 1 to 100. But for multiples of three 
    print 'Fizz' instead of the number and for the multiples of five print 'Buzz'. 
    For numbers which are multiples of both three and five print 'FizzBuzz'.
    """
    def fizzbuzz():
        # Inclusion-exclusion principle:
        # |A union B| = |A| + |B| - |A intersect B|
        out = []
        for i in range(1,16):
            tmp = ''
            if i % 3 == 0:
                tmp += 'Fizz'
            if i % 5 == 0:
                tmp += 'Buzz'
            if i % 3 != 0 and i % 5 != 0:
                tmp = i
            out.append(tmp)
        return out
    
    def test():
       """
       Make sure we get the output we intend.
       """
       wanted = [1,2,'Fizz',4,'Buzz','Fizz',7,8,'Fizz','Buzz',11,'Fizz',13,14,'FizzBuzz']
       got = fizzbuzz()
       assert wanted == got
       return "True"
       
    if __name__ == '__main__':
       print __doc__
       print "Test successful:", test()

Here I've only solved the problem up to `15` but it holds generally up to `100` and beyond.

This is a general framework for you to follow in creating Python programs with a `__main__`. It isn't necessary to include `__main__` in Python, but because you are coming from Java it might be a little more familiar to you. I will explain more in the coming weeks.

Obligatory [XKCD](http://xkcd.com/353/): ![XKCD Python](http://imgs.xkcd.com/comics/python.png "XKCD Python")

Some fun with math
------------------
I studied Math-Computer Science in undergrad, and so I like to play with the math behind the code. The comment in my Python solution, about the [Inclusion-exclusion principle](http://en.wikipedia.org/wiki/Inclusion&#45;exclusion_principle),

    |A union B| = |A| + |B| - |A intersect B|
    
is just a reminder to me of how to understand the [sets](http://en.wikipedia.org/wiki/Set_&#40;mathematics&#41;) involved. The notation `|A|` means `the number of elements in the set A`. So in our case, we can calculate the # of Fizzes, Buzzes, and Fizzbuzzes as follows,

    Let A be the set of multiples of 3
    Let B be the set of multiples of 5
    
Then,

    (A intersect B) is the set of multiples divisible by 3 and 5

And,

    (A union B) is the set of multiples divisible by either 3 or 5
    
So,

    |A| = Floor(100 / 3) = 33
    |B| = Floor(100 / 5) = 20
    |A intersect B| = Floor(100 / 15) = 6
    
The key here is to observe that numbers divisible by both `3` *and* `5` are divisible by their least common multiple `15`. And so, we can conclude,

    |A union B| = 33 + 20 - 6 = 47
    
This may prove useful in understanding, if not solving, the next problem I will assign.