# Wikipedia Crawler - All Roads Lead to Philosophy

An interesting phenomenon of Wikipedia: go to any article, click on the first link in the main text that is not in parentheses, repeat. 
For most articles (sources say >94%), this process will eventually lead to Philosophy. 
The others end up in loops or dead ends.

Read more about it here: http://en.wikipedia.org/wiki/Wikipedia:Getting_to_Philosophy

## Command Line Usage

Provide any Wikipedia article URL as the first argument:

```sh
$ bin/wiki_crawler.rb http://en.wikipedia.org/wiki/Recursion
```

Output will show the trail to Philosphy:

```sh
-------------
We found philosophy in 6 hops
-------------
0. Recursion (http://en.wikipedia.org/wiki/Recursion)
1. Self-similarity (http://en.wikipedia.org/wiki/Self-similarity)
2. Mathematics (http://en.wikipedia.org/wiki/Mathematics)
3. Quantity (http://en.wikipedia.org/wiki/Quantity)
4. Property (philosophy) (http://en.wikipedia.org/wiki/Property_(philosophy))
5. Modern philosophy (http://en.wikipedia.org/wiki/Modern_philosophy)
6. Philosophy (http://en.wikipedia.org/wiki/Philosophy)
```

Try anything you want!

```sh
$ bin/wiki_crawler.rb http://en.wikipedia.org/wiki/Jim_Thorpe
$ bin/wiki_crawler.rb http://en.wikipedia.org/wiki/New_Hampshire
$ bin/wiki_crawler.rb http://en.wikipedia.org/wiki/Clay_Buchholz
```


