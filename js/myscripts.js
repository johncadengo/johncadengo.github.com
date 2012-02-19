// Stolen from StackOverflow. Find all </code><pre><code> 
// elements on the page and add the "prettyprint" style. If at least one 
// prettyprint element was found, call the Google Prettify prettyPrint() API.
//http://sstatic.net/so/js/master.js?v=6523
function styleCode() 
{
    if (typeof disableStyleCode != "undefined") 
    {
        return;
    }

    var a = false;

    $("pre code").parent().each(function() 
    {
        if (!$(this).hasClass("prettyprint")) 
        {
            $(this).addClass("prettyprint");
            a = true
        }
    });
    
    if (a) { prettyPrint() } 
}

// Google analytics
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-17839863-6']);
_gaq.push(['_trackPageview']);

(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();