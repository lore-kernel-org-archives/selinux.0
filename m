Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8NFDAsJ012973
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 11:13:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8NFBLd0002053
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 15:11:21 GMT
Received: from sisko.scot.redhat.com (82-41-8-61.cable.ubr02.edin.blueyonder.co.uk [82.41.8.61])
	by jazzswing.ncsc.mil  with ESMTP id h8NFBLVY002050
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 15:11:21 GMT
Subject: Re: setfiles performance patch
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200309231522.25749.russell@coker.com.au>
References: <200309231522.25749.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1064329967.3869.15.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 23 Sep 2003 16:12:48 +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Tue, 2003-09-23 at 06:22, Russell Coker wrote:
> I have attached a patch for setfiles (from the new SE Linux) to improve the 
> performance.  
...
> So I have reduced the CPU use by a factor of 4, which (in this instance) 
> increases the overall speed by a factor of 3.

Very nice. :-)

> The next thing I am thinking of is the possibility of having it fork off 
> another two processes for disk IO.  Then one process could do all disk reads 
> while another could do all disk writes.

Well, unless you're using fsync() after each operation, the writes
should be asynchronous anyway.  But for reads, a separate reader may
well improve things a lot.

One really easy way to do that is to have a separate task which simply
pulls stuff into the kernel cache.  You don't actually have to have
two-way communications between the readahead task and the relabelling
task: rather, just let the readahead task stat(2) the files in question
so that the inodes are pulled into cache.  The parent relabelling task
can then work without modifications.  

That's much simpler than delegating the read to the child process
entirely and passing the info back to the parent when needed, and should
be as fast.  Even if the parent ends up stat()ing the file again, the
dcache will mean that this is fast; and you avoid the overhead and
complexity of adding a new communication channel between the readahead
and relabelling tasks.

If the relabeller walks the tree in a predictable order, then there may
be no need to have _any_ communication between the relabel and readahead
tasks.  That may need some tweaking, though: if you let the readahead
get _too_ far ahead of the relabelling, then there's a chance that the
readahead information gets chucked out of cache before the relabeller
gets to it.  But it's really easy to add a simple form of throttling
there: for example, just have the readahead task write a char to a pipe
each time it reads something, and have the relabeller read a char when
it is finished with an entry; that means the readahead won't get more
than a pipe's width (4096 bytes by default) ahead.

Cheers,
 Stephen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
