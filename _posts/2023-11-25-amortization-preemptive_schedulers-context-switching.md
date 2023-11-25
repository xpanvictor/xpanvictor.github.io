---
layout: post
use_math: false
title:  "Amortization, Preemptive scheduling and how context switching works"
date:   2023-11-25 21:06:59 +0100
categories: technology systems os
excerpt: "The beauty of the operating system is that it manages the computer almost perfectly, how it runs multiple events together, controls the operating of individual components is based on these little concepts"
---


Considered what it takes for an operating system to function and control the workings of a computer. From playing music while reading a nice

pdf at the same time, asking it to fetch a file on some row in the hard disk while downloading another file using a new browser or file downloader which

runs some other operations. What about the running a VM, using a virtual OS on your own OS. How does it manage something that manages another manager. 

To be honest, the workings of the operating system can be a bit daunting at times but all we can do is shout at windows for not being a good door.

The first problem we'll consider is how can the OS decide what to run first. I mean, from a low level POV, if the OS receives the request of 3 operations to run and they each take say 50ms to run. The easiest way to run them is using **FIFO**, (first in first out) algorithm. This way, the OS is being fair and serves the first customer. 

However, this introduces a problem known as the <u>CONVOY</u> effect. A common world example is where the attendant answers everyone based on arrival, with this, people trying to pick up just a cup of coffee will have to wait for those trying to shop for the holidays simple because the coffee maker took a bit of time. Basically, the CONVOY effect makes low resource consumer queue behind huge resource consumers.

Some metrics are used to measure this such as the <u>turnaround time T(t)</u> which basically checks the time period behind arrival and completion of a task, that won't be much discussion here.

A beautiful way of solving this effect is by using another algorithm rather that FIFO, this is known as the **Shortest Job First**, (SJF). This algorithm ensures that the job that will take the least time to complete will run first. However, what if the short job arrives after the long running job which started running already?

This brings us to the interesting concept of **Preemptive scheduling and Context switching**. An introduction to these topics can be found [here](https://xpanvictor.github.io/technology/systems/os/2023/10/17/limited-direct-execution.html). However, using the power of the timer interrupts, the OS can confirm when a new job enters while another is running. At this point, it can decide the state of the new job to be READY or even start running it if it deems it worthy. This is basically what Preemptive scheduling is. This is because a previously running process was decided to be preempted and the state/context of the process can be stored for the context to be switched to that of the new one.

This better approach is known **Shortest Time To Complete First, (STCF) or **Preemptive SJF**. The Turnaround Time for PSJF is definitely better than that of the SJF. 

However, other issues are to be studied. Using another metric known as the <u>Response Time</u>, these algorithms are not so effective. It takes longer time for a job to be even scheduled using them. Hence, another algorithm pops up. This is the **Round Robin**, (RR). With this, the OS runs all process using a time slice or scheduling quantum. Say an OS can decide to run a job for every 10ms. With this, it runs each job for 10ms, goes to next and does same and others then returns to first one if not exhausted or another unattended job. This mechanism ensures that every job gets at least attention quickly. 

Using Response Time to measure this is indeed very effective, however, with the common Turnaround Time, this approach is very bad. That isn't all though. The round robin will work very well if the time slice is small. Say it's running another job every 10ms, then every 10ms, a response is given. However, the concept of RR ensures that processes are switched every time slice. With this, the context switch occurs every time slice. More than this is done as processes consume more resources to be flushed before a new process can take over. This creates the dilemma of time for context switching. Say the OS spends 1ms for a context switch, then if scheduling quantum is 10ms, 10% of the time is taken just switching context. 

This brings us to the concept of **Amortization**. Since we know the lower the time slice, the higher the time wasted on switching contexts. Hence, we amortize by ensuring our time slice is higher to reduce waste. Say we change the time slice to 100ms, now only 1% of time is spent on context switching.

This ensures that by increasing the time for response, we reduce the total time spent on jobs. This is because even though the round robin saves response time, in the overall, it costs more. This is the power of summation, when we finally sum up all time spent on other activities. 

Consider opportunity cost, an economics concept which states basically that a choice is cost of not picking the other options. Here, we can have a mesh of algorithms and can do amazing things like overlapping of processes due to certain activities. We may talk more about those later. 

Ciao.