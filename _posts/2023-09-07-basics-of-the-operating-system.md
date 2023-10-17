---
layout: post
use_math: false
title:  "The basics of the operating system"
date:   2023-09-07 08:06:59 +0100
categories: technology systems os
excerpt: "The operating system seems like a giant cloud of software. Well, maybe it is. What if I say
it's a standard library? What does it do exactly? Let's talk about pieces of the operating system"
---

This is a series of me going over "Operating systems: 3 easy pieces" lecture notes. You can check 
the introduction out [here](https://pages.cs.wisc.edu/~remzi/Classes/537/Spring2018/Book/).

The operating system has been a fascinating piece of software however seems to be just to big to unravel. Well, I'm
quite interested in it. If we look at the computer itself, one of the closest components to the hardware after we jump through a few heaps is 
the operating system itself. Hence, understanding the operating system *building one* is one of the feats we have to achieve. 

Why build?
>Confucianist quote of "...I do and I understand" :). 

The three pieces of the operating system are 
- Virtualization
- Concurrency
- Persistence

## Virtualization
Ever wondered how the computer is able to run many programs at the same time without so much of a "hey, you using my memory bruh.."? The fact that 
computer can even create multiple processes & threads for same program makes it more bewildering. How a program can use the RAM like it's the 
only program running in the system. The key to this ability is **Virtualization**. 
How does this work?
The operating system takes a physical resource like the processor or memory and transforms into a more powerful, virtual form of itself. Hence, the operating system can be seen as a __virtual machine__.

The OS also provides an API for programs to call to perform acts on the computer like running a program, fetching data, etc.
Hence, it provides a standard library.

Also as the OS manages sharing of memory, data, cpu, etc, it can also be seen as a resource manager.

With this logic, the operating system is in charge of the resources of the computer. However, it creates a virtual abstraction on this resources.
This way, the computer can have multiple virtual RAMs. 

> the operating system’s early names were supervisor, master control program

The operating system performs it’s illusion of having multiple CPUs.

The operating system uses policies to decide which program to run in cases of conflicts where many programs want to run at a time.

With virtualization, each process access it’s own private virtual address space which the OS somehow maps to the physical memory. Note, this requires ensuring the address space randomization is disabled. [Address space layout randomization](https://www.ibm.com/docs/en/zos/2.4.0?topic=overview-address-space-layout-randomization).

### Side note: Multithreading

Threads are not same as processes as they are not independent from each other so they share resources like open files and signals. They have their own program counters, stack space and register set like processes. 
They are faster than processes as their creation is faster, context switching is easier, threads can communicate between each other easily and can be easily terminated.  
Context switching is basically the change from one task to another by the computer without making conflicts. This gives the user the impression of multitasking.



## Concurrency
This other function of the operating system is concurrency where it juggles different processes and threads at the same time.  
Concurrency brings a lot of interesting problems. An example where a global counter is incremented in different threads can lead to multiple errors. Check out the code below and run with an argument like 10. The output should be 20 which is because we are running two threads to increment the global counter independently.  
[My Example of using multiple threads](https://github.com/xpanvictor/os_learning/blob/master/learning_c/concurrency/main.c)  
However, on testing with an argument like 200000, the output gets interesting. This is due to the fact that instructions are run one after the other; reading, incrementing and writing back



## Persistence
Another feature of the operating system is Persistence. This is how data gets stored by the operating system. The OS doesn’t create virtual abstractions for the file system unlike other components like memory and CPU. This is because in most cases, several programs share and work on same file.

A device driver is a program on the operating system that knows how to deal with a device in the computer.

One major functionality of the Operating System is protection. This is mostly done by isolation of processes. The OS does this to protect programs from each other and also from itself.

The OS must also run non stop hence providing its function of reliability. Mobility is as well another function as its run on even smaller devices.


### A short history on the operating system.
Note: According to three easy pieces with a little bit of extra checks

History of OS, earlier, the OS was just a standard library providing a set of useful functionalities like FS, etc. The decision of what program to run next on those old mainframe computers was up to people called operators. This is because computers run one program at a time then. This system is called batch processing. [BH00]

Later on, protection came forth. The OS should be in charge of how files are accessed, how operations are run. This brought about the system call, (Atlas computing system [K+61,L78]). With system calls, control is transferred to the OS and programs are ran in a user mode with less privileges. 

Multiprogramming came as a result of the emergence of minicomputers. 

All these led to the development of the UNIX operating system by Ken Thompson and Dennis Ritchie at bell labs. This OS was influenced by many other projects like multics at MIT.
