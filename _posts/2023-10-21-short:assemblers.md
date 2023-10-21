---
layout: post
use_math: false
title:  "Short: What's an assembler and how???"
date:   2023-10-17 21:06:59 +0100
categories: technology cs 
excerpt: "Ability to use symbols before their definition makes the assembly code writer's life easier and
the assembler developer's harder."
---

So checking out how assemblers work, realized that it's quite weird. How can a program convert symbolic program to binary code 
if itself is a binary code. How did man pull this off?

First question we tackle here is quite small, however worth it. In assembly, you can use symbolic labels (goto instructions) before
defining the symbols themselves. A brief example written in a weird (just formed) assembly language is thus:
```asm
goto positionX
// Some weird actions. note this is a comment
[positionX]
```

From the above, we realize the assembly code made a form of jump to some address labelled by `positionX`.  
However, the positionX was not yet defined, hence that address is not known. How can the assembler
(the program that converts an assembly code to the binary code) know what address to put there.

Firstly, how does the symbol labelling work. The label is just a way to make developing easier, so when you say
`x = 2`, the computer doesn't care about *x* at all. This just means, store 2 at some address in the memory.
That address shouldn't be the developer's problem. Imagine having to write something like this:
```
let @2345612 = 4;
log(@2345612);
@2345612 + 2;
log(@2345611);
```
That's even a bit, imagine having several variables like that and having to manage all of them.  
This is where we realize we can just use symbols just like in maths when writing our program and let another program handle
binding our symbols to their addresses. This program is what we call the **assembler**. 

Now back to the question we're handling here, we get that the assembler binds an address to variables. 
However, how can it allow the use of an address that hasn't been defined yet. 

Well, the common solution to this is called the two pass assembler. The two way assembler reads the assembly code twice, start => end.

In the first pass, it doesn't generate any code but only initializes a symbol table. The symbol table is basically a table that lists all
symbols used in the code and their corresponding address. Something like
```
| symbol    | address |   
 _________    ________
|     x     | 2345612 |   
| positionX | 2454569 |   
```
During this process, it takes note of each line and ignores the comments lines and the symbol definition lines. To generate labels for instruction address, it
just notes the current instruction lines number (after parse ignoring the comments and what nots), then adds one to it. So something like
```
53. // This is a comment at line 53
54. [positionX]
55. goto positionX
```
The assembler here generates the table below as the comment is ignored so the line using positionX is 53 now. The address will be the address of the next instruction
which is `53 + 1 = 54`. 
Joke: Noticed we just made an infinite loop, take that to your 2gb pc doing nothing.
```
| symbol    | address |   
 _________    ________ 
| positionX | 54 |   
```

In the second pass, the assembler translates the code to binary code. It translates the assembly code to it's corresponding binary code using the symbol table.
When it comes across a symbol that isn't in the symbol table, it binds it to the next free spot in the *address space*, then adds the entry to the symbol table.
Oh, beautiful assembler.

This is a short overview of what an assembler is & does. 
>> I noticed the error at the log(@2345611), this is to show how easy it is to make errors if we don't have symbol labelling.   
>> Arigato



