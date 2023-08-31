---
layout: post
use_math: true
title:  "Reviewing the Rust language"
date:   2023-08-03 11:13:59 +0100
categories: technology systems language
excerpt: "A series documenting key components of the rust programming language. I read the book
a while ago but was busy with some other things, this is documenting a summary as I review"
---

I read the rust book a while ago but couldn't progress building amazing concepts with it due to work
and school. I still love and admire the style and approach the language brings with it.  
This is a series documenting my journey going over the rust book and some projects I did.
Below is the content list
1. [Introduction](#introduction){: .active}


# Introduction
Rust is a systems programming language with key features and interestingly new concepts. It boasts
new methods that achieve great feats unlike the tools we have before.
While learning, I have an habit of documenting key points and snippets per chapter. The repository to which I'll
refer individual chapters to is [here](https://github.com/xpanvictor/rusty).

## Basic type system 
Rust has a strictly typed system which follows some of the basic CPP data types like uint and int, char, bool. It also ships
with the standard library which includes the String type as an advance type. Obviously, as a `collection` of chars. Collection is another
concept in rust which we will discuss later. 
All variables in rust are immutable by default which can be made mutable explicitly with the exception of the const type.

```rust
let num = 5; // implicit typing of i32 and immutable
let mut num: u32 = 6; // explicitly typing an unsigned integer  the mutable num
const HIDDEN: i32 = -12 // this is a constant, preference of all uppercase to denote not changing data type.
```

## Concept of ownership
This is a concept that rust developers have to first make their peace with. It's the way rust handles the stack vs heap debate. 
Language design requires picking a system which has it's tradeoff. Languages like C makes it up to the user to clean up after using memory. 
This can be cumbersome but gives developers control. CPP gives developers this chance as well giving them the ability to clean up after consuming memory.
Languages like python, nodejs however use a garbage collector, (an internal process that runs over clearing heap data no longer in use) to help the developers 
not have to worry about issues like running out of memory, accessing invalid memory, deleting an empty memory slot, etc.
Rust however, does this right from the point of programming not leaving issues to runtime. Rust ensures memory is used properly while developing. This is done
with it's concept of ownership. With this case, js developers will most likely take it as scope on steroids. However, it's a lot more than that. It can be a pain 
to new rustaceans. It ensures that memory get's cleaned up when they leave their scope. Also, data stored on the heap have a lot of restrictions. I should differentiate now.
Stack and heap are ways our data are stored. The stack can be likened to the dish collector in the kitchen. Plates are lined on top of each other. Each plate has a definite size
so we can easily access a certain plate by using size calculation. Also, we can use the LIFO (last in first out) to easily access data on the stack. The stack is indeed beautiful.
The limitation however, data stored on the stack must be of known size before hand. This is not always the case as in much cases, we don't know the size of data during development.
E.g. user input of their name can only be calculated at run time. Hence, we need another form of storage. This is where we use the heap. See the heap as some form of roughly kept
room of space with a banner of the title or address of itself. So when we put data on the heap, we don't know much about the size but we can store the address on the stack.
If we need to access it later on, we just need to check the stack, find the address (pointer) and go pick up the luggage from the heap. This is where a lot of issues happen.
We will be discussing more on the stack vs heap later on. However, this heap needs a major way of management. For rust, heap data isn't duplicated but moved when passed to another
variable unless copied explicitly. This is a concept js developers will understand as the shallow vs deep copy. Example in rust
```rust
let name = String::new("Xpan");
let copied_name = name; // the name has been moved into copied_name
println!("{copied_name}"); // println! is a macro which is used to print out to the standard output.
// note, the name variable can't be accessed again as it's data has been moved into copied_name. We say ownership has been passed.
```
There's so much more to discuss over ownership here but this is just a brief summary of everything. Check out the [ownership](https://github.com/xpanvictor/rusty/tree/master/ownership)
for more on ownership in my repo.

