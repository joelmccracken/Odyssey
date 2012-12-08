Ruby Macros
===========

A system for adding syntactic rewriting (macros) to Ruby. 


Introduction
------------

This project is still in an exploratory stage. Check it out for neat
code, but nothing else, really. 

Philosophy
----------

The goal of this project is to provide lisp-style macros to Ruby. That
way, there really is nothing that Lisp has that Ruby doesn't. 

The side goal is to discover how Ruby might do macros better than
Lisp, with its increased expressiveness. 

Overview
--------
Project consists of a few components

1 - a converter which will take whatever "parsed" representation that
some various source provides (such as ruby_parser, melbourne) 

2 - a rich library of AST objects which provide a convenient method to
manipulate 

3 - code which allows these AST objects to be converted back into ruby
code, and then evaluated

Initially, the only plan is to support "compile-time" macros. The
solution ParseTree uses to acquire the AST would allow for some
run-time macros, but even that has its limitations (only MRI,
limitations on what types of ASTs are available). In any case, I
imagine that compile-time macros would suffice for whatever users
would need.

Description of Operation
------------------------

The rewriter works like this:

First, a file is parsed. From it, relevant macro definitions are
extracted.

Once we have macro definitions, they are applied to the remaining
syntax. Finally, 







DSL Sketching
-------------

    defmacro :my_macro do 
       rewrite %q{"Hellooooo!"}
    end
    
    my_macro 

when run, would be rewritten to: 

    "Hellooooo!"



Tasks
-----
* come up with a better name
* write better "overview" of project goals
* just finish this
* A jQuery-like ast interface might make sense, considering how
  complicated the Ruby AST is.



