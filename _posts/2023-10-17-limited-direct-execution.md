---
layout: post
use_math: false
title:  "Limited direct execution: How does the OS run programs"
date:   2023-10-17 21:06:59 +0100
categories: technology systems os
excerpt: "Several issues lie with how the Operating system runs programs. We need a very efficient system
yet ability to control the programs, security is of course important. Let's review the beautiful art of running programs."
---

After reviewing the generality of the operating system [here](https://xpanvictor.github.io/technology/systems/os/2023/09/07/basics-of-the-operating-system.html),
we can check out some pieces talked about on the operating system.  
From that article, we reviewed the fact that the OS is in charge of virtualization and also concurrency. 
This obviously means the OS is a big program that runs other processes in very special ways.  

Limited direct execution means the operating system gives direct access of the CPU to the processes but in a controlled way. How this control
works is what we'll be talking about here.

How does it do this? Can the CPU run multiple programs? If not, how can the OS still be involved when the CPU is busy with another program?
Doesn't this make security offered by the OS a fallacy?  
Well, we'll answer the questions together soon and you'll get the wow, so easy feeling at the end. 

Short answer: the hardware is involved :)


# Wait, what are processes really?
Basically, it's a running program. When we run a program through several means like double clicking an executable or running it from the terminal
or those who can skim programs using their minds, we create a process on the computer. A process stores the program instructions (the binary code) in memory,
initiates a program counter &#40;this tells the computer the current instruction to execute on the computer&#41; , initiates a memory stack and kernel stack \(basically registers 
that store data\) then line by line runs the instruction incrementing and jumping across the instructions as directed by the program. 

However, the operating system is in charge of creating the processes as well. The OS creates an entry called the Process Control Block (PCB) or 
process descriptor in it's process list. This descriptor has several flags like those that serve as stack addresses, field that shows the state of the process eg Zombie state
(the state of a process that has ended but has not been cleared from memory; clean up is done at this point).  
After these data have been initialized, the OS initiates requirements for the process like I/O tasks and co. Afterwards, it locates the main routine and jumps to it.  
At this point, the OS transfers control of the CPU to the running program.

# Waiiit, doesn't the OS lose control of the CPU here?
Simple answer again, yes. The OS actually loses control of the CPU when it runs programs. In fact, the OS is basically not active on the CPU. That's counter intuitive
but maybe I exaggerated a bit (get it, a bit).  
If you can remember from the article shared above, the OS runs multiple processes with a context switching approach.
This process, sorry I used process again, is called **time sharing** the resources of the computer. Basically, the OS runs one program, pauses, runs another, pauses... you 
get the gist. This provides the illusion of running several programs at once.  
Even human beings do this, we feel we do a lot at once. While typing this article, I pause, pick a piece of snacks and eat, pause type this line, 
wait this line, and yes this line. This way, I say, I'm typing and eating at the same time. This is basically what multitasking is.

With the time sharing approach, the Operating System can run multiple programs at once. However, if it gives control of the CPU to the running program, how does it 
decide to run another process? Aside the issue of functionality, what about the security of the system. If the program gains control of the system, can't it basically perform
any action it wants like access an unauthorized file, etc?

# The savior, oh the Hardware is in the party too?
Starting with, let's resolve the issue of how the Operating System runs another program when there's a process in charge of the CPU. I won't bore you with so much details, 
the fact is the hardware does this. This is by the integration of a **timer interrupt** in the hardware.
This is like a clock that runs for a few milliseconds and interrupts the currently running process. This restores the control of the CPU to the master program (Operating System).  
At this point, the Operating System can decide to continue running the process, run a different one or even sip a cup of coffee, well one of those isn't true.  

So if that resolves the issue, how about the issue with security? Well, I'm tempted to use another subtopic, I know it's not necessary but really, I can't resist it 
making another dumb sub title

# Hey, who left the door open?
If a process controls the CPU, even with a timer interrupt mechanism, this still can't protect the OS, the process can still perform privileged acts. However, this will
make us describe the different modes the computer operates in. When the Operating System passes the control of the CPU to the running process, it also changes a flag to 
indicate `USER MODE`. Operations are limited at this point. 

The Operating system runs programs directly in the kernel is a restricted mode called the user mode. With this, the programs can perform instructions that are not privileged. However, to perform those activities like writing to a file, using the network, etc. they need to enter trap which allows system calls.  
In this trap, the programs registers are saved to the kernel stack. Then the `KERNEL MODE` is entered. Here, the trap handler is called to handle the syscall that brought about the trap.  
After the OS handles the trap call, it returns control to the hardware which restores the register from the kernel stack. Afterwards, the hardware returns to user mode and continues running the program (using the program counter). 

The OS uses a return-from-trap instruction after the trap handler runs to indicate the switching back to user mode. The trap table(contains addr of trap handlers) is initiated at boot time.

To buttress the `TRAP` instruction. To perform those privileged tasks, the process traps into the Operating System using some form of interrupt. A trap from the definition, is 
basically leaving control to the trap handler from the OS. When we boot out computer, the Operating System initiates the address of `syscall` handler and the hardware notes this.  
Also, the OS also initiates the trap table which contains the address of instrutions to handle several trap actions. With this, when the process traps say so access the file, the Interrupt kicks the hardware which figures out where the trap handler is located and passes control of the CPU to it. It also is in charge of storing
enough state of the running process say to the kernel stack. This enables smooth transitioning so the process can continue running from where it stopped before the syscall.  
After the OS is done performing the action for the syscall, it returns control to the hardware which restores the states from the kernel stack to the memory stack. Afterwards,
the hardware passes control to the process and things continue.  
Hence, we can see the importance of **interrupts**. We also realize that the security is based on the fact that only the Operating System has access to the routines that handle those privileged operations. The cooperation between the hardware and operating system is what protects the computer.

The approach to running a program earlier was the cooperative approach where the OS trusts the program to run and pass control back to the OS using traps when it's done. This
was used in the Macintosh operating system, M11. However, the program can maliciously decide not to or enter an infinite loop from bad code and prevent the OS. With the
uncooperative approach, the timer interrupt is used to return control to the OS at intervals at which it can decide to continue the process or do other things.

This decision of either continuing or switching to another process is done by the **Scheduler.** To perform this switch, a ************context switch************ is done. This basically is storing the currently running process’ registers, PC and kernel stack pointer and restoring the registers and PC of the new process to run. Hence, **switching** from the *context* of the current process to the ***********context*********** of the about to run one. Afterwards, return-from-trap is executed and the new process becomes the currently running process.

There are two register stores that occur in this context switch. 

1. Implicit storage of registers to kernel stack by the hardware from the timer interrupt.
2. Explicit storage of kernel registers into memory by the OS during the switch.

The scheduler, context switch and trap, return-from-trap will be further discussed later.  
However, you can see the operating system works very simply at the base.

