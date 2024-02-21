---
layout: post
use_math: false
title:  "Implementing a bittorrent client with rust"
date:   2024-01-20 12:06:59 +0100
categories: technology software
excerpt: "While thinking bout common necessities, I remembered I once fantasized building
a bittorrent client while I was learning blockchains, I guess it's time to delve"
---

How lovely torrenting works, the network system by which information can be passed amongst peers. This has 
enabled a widely used p2p (peer to peer) infrastructure for data sharing. This makes the deep end of the 
internet more interesting. I got interested in this technology while I was learning about 
the blockchain and the p2p system of communication. With this, I decided to implement one with rust.

This post will describe the technology, how it's build and will serve as a documentation
for the project. The source code can be found [here](https://github.com/xpanvictor/xtorrent-rs).  
Note, this project takes re-inventing the wheels seriously since the point is to
understand the system, hence, functionalities that could easily be gotten from a library
will be rebuilt.

Structure of the project will be   
1. [Introduction](#Introduction)
2. [Bencode Parser](#Bencode-parser)


# Introduction
The technology of bittorrent bases its operations on the ability to allow downloaders
serve as uploaders of the same file they are downloading or have downloaded. This is called
seeding by peers in a swarm. This is obviously the distributed file sharing.  
The entire file to be downloaded is broken into small chunks known as pieces each having
the same size. This can be breaking a 1mb file into 1000 1kb pieces or another chunk size.
Each piece is encrypted using a hash and can be verified from the torrent descriptor. 

# Bencode parser
The bencode parser works by consuming each character and translating into an enum struct
I call BenStruct using the [bencode specification](https://en.wikipedia.org/wiki/Bencode). 
It simply uses
delimiters to break store strings, integers, lists, dictionaries all in a linear format.
Hence, bencode is a good way of storing complex data structures in a linear memory storage.

## Spec summary for Bencode
1. ### Integers
    These start with 'i' and end with 'e'. The number can be negative. Examples are
    ```Rust
   i32e // decoded to 32
   i0e // decodes to 0
   i-56e // decodes to -56
   ```
   I call them the Int variant in the BenStruct enum.
2. ### Bytes
    These follow the format of a length followed by a colon ":" and then the bytes, eg
    ```Rust
   4:spam // decodes to "spam"
   ```
   I call them the Byte variant in the BenStruct enum. Note, these are not necessarily 
    ascii bytes hence bencode isn't considered human-readable and should not be treated as
   text files.
3. ### Lists
   Starting with a delimiter of 'l' and ending with 'e', it can contain other data types.
   It has no restriction on the data type of the children.
   ```Rust
      li32e4:spami-56ee // decoded to [32, "spam", -56]
   ```
4. ### Dictionaries or Structs
   The last standard data type. This is used to represent a key pair data structure. 
   Following the format of starting with 'd' and ending with 'e'. The keys are immediately followed
   by the value. The keys must be byte strings and must be sorted by lexicographical order.
   ```Rust
      d3:bar4:spam3:fooi45ee // decoded to {"bar": "spam", "foo": 45}
   ```
   
The algorithm used will be explained shortly after my exams :)
