---
layout: post
use_math: false
title:  "Implementing a bittorrent client with rust pt 2"
date:   2024-04-11 12:06:59 +0100
categories: technology software
excerpt: "The parser has been implemented, next, structure of the client"
---

## Torrent specification
This is a series on building a bittorrent client with rust. This is the
second part and the first part can be read [here](https://xpanvictor.github.io/technology/software/2024/01/20/implementing-bittorrent-protocol-rust.html).
The bittorrent specification used can be found [here](https://www.bittorrent.org/beps/bep_0003.html). This is the bep 3
specification.

This part is basically talking about the structure of our torrent data. We'll be looking
at the best ways to structure data for the torrent features we will implement.
Let's start with breaking down a typical torrent file. We will be using a 
test torrent from [Academic Torrents](https://academictorrents.com/details/d984f67af9917b214cd8b6048ab5624c7df6a07a).


```Generic
d
8:announce41:https://academictorrents.com/announce.php
13:announce-list
l
l41:https://academictorrents.com/announce.phpe
l46:https://ipv6.academictorrents.com/announce.phpe
l42:udp://tracker.opentrackr.org:1337/announcee
l44:udp://tracker.openbittorrent.com:80/announcee
e
e
10:created by25:Transmission/2.92 (14714)
13:creation datei1495908054e8:encoding5:UTF-8
4:info
d
5:files
l
d
6:lengthi17614527e
4:path
l6:images35:LOC_Main_Reading_Room_Highsmith.jpge
d
6:lengthi1682177e4:pathl6:images22:melk-abbey-library.jpg
e
d
6:lengthi20e4:pathl6:README
e
e4:name11:test_folder
12:piece lengthi32768e6:pieces11780:!<placeholder for blob>
e
```

I prettified the text to use new lines with gemini, so we can easily read this,
remember bencode isn't human-readable. 
Checking the bittorrent specification provided above, we can see the `announce` field
in our bencode. This field is the tracker we need to initiate ourselves as a peer in the
swarm for the distributed file sharing purpose.    
We will use the description used in the metainfo files to structure our torrent.
```Rust
struct TorrentMetadata {
    announce: string,
    info: TorrentInfo
}
```
Now we have a basic breakdown, let's structure the other data into the info field.
Note, we have an announce-list field, we will discuss that later. For now, let's build the
torrent info struct.
```Rust
struct TorrentInfo {
    length: i64
    piece_length: i32, // most peice lengths are 256 - 512 (kb)
    name: String, // an opionated name for us to use to save the file and dir location
    pieces: String, // this blob contains the sha1 hashes of each piece
    files: Option<>;
}
enum TorrentFilesType {
    length(usize),
    file(Vec<FileType>)
}
struct FileType {
    length: usize,
    path: Vec<String>
}
```
Note the decomposition I had to implement. Especially with the file type, I had
to do that to support downloading folders and not just single files. Recall in the 
spec that 
> There is also a key length or a key files, but not both or neither. 
> If length is present then the download represents a single file, otherwise it 
> represents a set of files which go in a directory structure.



