---
layout: post
use_math: true
title:  "How do flip flops work"
date:   2023-08-05 18:19:59 +0100
categories: engineering electronics
excerpt: "Flip flops generally are fascinating elements. Memory chips are built from them, from the bits to registers.
Let's explore what and how these chips work."
---

### Introduction
Computers as complex as they may seem are very simple at the core. Basically performing calculations using 
electrical signals. I won't be going over that here but the point is everything done on a computer comes from the
combination of chips. These chips take input(s) and return output(s). Example is the NOT gate which takes a signal
and returns the inverted form. This is in form of binary code. Truth table of    
```
| in | out |   
 ___  _____
| 0  |  1  |   
| 1  |  0  |   
```

These chips are categorized largely into the logic with which they work. The __Combinational__ and the __Sequential__ logic.   
Combinational chips are the chips that basically perform an action on the input returning the result. They don't care about sequence which
I'm coming to. Examples are the and, not, nor, xor, mux gates, etc.   


Sequential logic however involves the progression of time. Chips using this logic are also called time-dependent chips.
These chips have to somehow factor in the concept of time into electronics. Of course, we don't have to make this the regular time, instead
we achieve this using a master clock that feeds all these sequential chips with current time. This is know as cycles. These cycles represent
the progression of time. This doesn't bring the *granularity* of time but instead makes it that each cycle marks time shift and everything between
is just constant.   
From this, we realize storage is just keeping a state till we want to change it. Meaning, keeping a state across different cycles until we want to 
change it. Hence, we need chips that can keep record of time and return the state we set to it some cycles before.

## So what are flip flops?
From the previous introduction, we realize memory chips are just sequential chips that can keep a state stored till we change it.
How do we achieve such functionalities in electronics. We can't just put something and it remains there. Electrons don't remain in a circuit, they move right?
This is where we have to define what flip flops are.   
Flip flops are circuits that have 2 stable states and hold information. Hence, they are Bistable Multivibrators. Ooops, what are those, let's go over them.

# Multivibrators, do they really vibrate?
...Pending

## Back to flip flops
Such chip should have operation as:
`out(t+1) = in(t)`      
Hence the pins of such chip are:
1. Of course the input pin, in
2. The output pin, out
3. The time feed pin, t

