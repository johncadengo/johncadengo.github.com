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
    
My revisions
------------

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
	
Commentary
----------
