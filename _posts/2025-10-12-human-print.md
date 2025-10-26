---
layout: post
use_math: true
title: Human print
date: 2025-10-12 12:22:59 +0100
categories: ai economics lifestyle
excerpt: You're a story to another
status: wip
---
[wip]
Life, a series of events enveloped in the sequence of time with characters interacting and making individual stories with each other. It's obvious why we like games, movies and others. It's a way to see beyond just individual stories and see how they cascade through a series in an aimed endgame timeline. 

Unlike reality however, the stories don't end. There's no direct hero and we're all just stories to each other. To some, I'm good, to some evil and to others just a neutral story. We're the protagonist in our own stories. Such a bummer, not so interesting right?

I've spent the past few days reviewing the kind of story I am to the people in my corner. Honestly, why are we even characters in a lot of stories? I'm not paid to act all these roles. Well, that's point of existence, for you to act. 

So to the main point, why am I this persona in this story? This is mostly on the character development. How are you made into this form for this story. Not just your entire 'life' but for each story you act in. It's not like you had time to read scripts for all events happening to you and how you react right? So how?

The fundamental element is a `feedback loop`. Start an entity defined with a private property called `perspective`. This property is so innate, the entity may not even have enough of it to know it. This property is what will be constantly updated in the feedback process based on entity's encounters. 
```
update_perspective:
	perspective = perception(perspective, event_result_pair)
```
Note the presence of a `perception` function. This is just a stripped down version of a different system. This will be realised soon.

The entity may be born with a blank perspective. They however update it throughout `existence`. Now, arise another important property. One that's considered most important but is just a reflection of perspective, `goal`. Goal is not a single slot but a *set function* of different `ideals`. Hence, goal can be derived from perspective and the ideal. It's deterministic although can be hindered from realisation by the fact that perspective is innate and not so obvious even to the owned entity. 
```
goals += for each ideal:
	goal = generate_goal(perspective, ideal)
```
Ideals are representative of everything. Anything not innate (not personal perspective) can be represented as ideal. To that, even the perspective of other entities is just an ideal to the entity concerned. Even a personal goal is an ideal. Hence making `generate_goal` naturally recursive and extensible. Little wonder humans enjoy `planning`. This is also the infinite goals theory until existence ends. 

Now goal is an important building block for the system at large. With goal, the entity knows which action or `response` to take to every event.