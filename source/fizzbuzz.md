<link href="markdown.css" rel="stylesheet"></link>

[Feedback](index.html)

FizzBuzz
=======
Problem:

> Write a program that prints the numbers from 1 to 100. But for multiples of three print "Fizz" instead of the number and for the multiples of five print "Buzz". For numbers which are multiples of both three and five print "FizzBuzz".

Your solution
-------------
    
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
it isn't the most elegant, but that's ok. I took the liberty to simplify your code,

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
Eventually, I'd like you to be programming in Python, so I'll also provide the solution in Python so you can begin to pick up the language,

    """
    Write a program that prints the numbers from 1 to 100. But for multiples of three print 'Fizz' instead of the number and for the multiples of five print 'Buzz'. For numbers which are multiples of both three and five print 'FizzBuzz'.
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
