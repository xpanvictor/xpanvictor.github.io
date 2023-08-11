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
Multivibrators are circuits that can maintain a simple two-state system. So basically, they can exist in two state. The stability of this state varies.
Hence, the types of multivibrators:
1. Astable multivibrators: These are multivibrators that don't have any stable state. The states change periodically.
2. Monostable multivibrators: Also know as one shot. These have one state that is stable and another that isn't. A pulse can be sent to make it switch to the unstable state.  
From there, it'll return to the stable state after a period of time. An application point is for a ciruit that triggers an action after a period of time from another event.
3. Bistable multivibrators: These have two states that are stable. A pulse has to be sent to swith it's current state. An example is the flip flop. This is 
because it can be made to flip from one state to the other. Another example is a latch. 

*I still have to research on the inner workings of the multivibrators and their circuit connection.*

With this, we have a circuit that can help us hold a state.

## Back to flip flops
Hence, a flip flop is able to manage storage of a single bit using a circuit structure
Such chip should have operation as:
`out(t+1) = in(t)`      
Hence the pins of such chip are:
1. Of course the input pin, `in`
2. The pin used to change it's current state, `set`
2. The output pin, `out`
3. The time feed pin, `t`
5. An optional [my pov] reset pin `reset`

# How?   
In the binary system which our classical computers operate in, the smallest form of data is a bit. It's a `0 or 1`. This can be engineered to an hardware with an
agreed value of low voltage for 0 and high voltage for 1. Basically, we are feeding our bistable multivibrator with a low/high voltage and it keeps it.
Using the pin structure;
1. The chip receives an `HIGH` through the `set` pin indicating we want to set a new state.
2. The value to be set is also sent to the `in` pin.
3. Of course, this occurs in the current time cycle which is fed to the `t` pin.
4. The chip can be queried and will always return the state that was set in the previous time cycle, until it's set again where it returns the new value in the next cycle.   
```js
out(t+1) = in(t) 
// out state of next cycle is the in state of previous cycle.
``` 
With this procedure, the DFF can store a bit of data. What's the point of such device. Well, a giant file is just a combination of characters, a character is just a bunch of
agreed codes of integers, e.g. `65 for A`. An integer itself is just a combination of BITS, i.e Binary digITS. 

Combine bits into registers, e.g. a 16 bits register. Combine registers into RAMs and you're already building a memory device. 

In conclusion, the terms hardware and software are intertwined. Computers are not so complex, they're beautiful devices we've engineered and at the core operate very simply.
I'll be writing later explaining what the time cycle is, how it affects a computer and how it gloriously defines the cpu's clock speed we check when we want to make a purchase
of a new computer.


