Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB4BdeIi013441
	for <selinux@tycho.nsa.gov>; Sat, 4 Dec 2004 06:39:41 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB4BdeXI000717
	for <selinux@tycho.nsa.gov>; Sat, 4 Dec 2004 11:39:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: tridge@samba.org
Subject: Re: dynamic context transitions
Date: Sat, 4 Dec 2004 22:39:27 +1100
Cc: crh@samba.org, tng-technical@samba-tng.org, Simo Sorce <idra@samba.org>,
   Andrew Bartlett <abartlet@samba.org>,
   Multiple recipients of list SAMBA-TECHNICAL <samba-technical@samba.org>,
   "SE-Linux" <selinux@tycho.nsa.gov>
References: <20041101203524.GJ9643@lkcl.net> <20041203211212.GA5243@lkcl.net> <16817.7759.874421.597181@samba.org>
In-Reply-To: <16817.7759.874421.597181@samba.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412042239.35150.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for this great explanation, I've quoted it all to the SE Linux list for 
the benefit of all readers as the samba-technical list archive doesn't seem 
to have a copy of it yet.

One thing I noticed when benchmarking in 1999 was that POSIX thread creation 
and destruction was hugely faster on Solaris (2.6) than on Linux (2.2.x).  
It's difficult to accurately compare SPARC and Intel machines so the exact 
numbers aren't relevant, but the performance difference was enough that I was 
quite certain that it was not an issue of CPU performance but of OS and libc 
optimisation.  At that time I noticed that Linux threads created with clone() 
were slightly faster than POSIX threads on Solaris, the difference was small 
enough that it might have been related to CPU performance but large enough 
that it probably was due to OS/libc performance.

Given that benchmark result I was surprised to see you say that threads are 
slow as hell on Solaris.  I guess that you are referring to the libc locking 
issue.

Another problem with threads that should be considered is the issue of 
debugging.  Thread capable debuggers are not common and most debuggers don't 
do it well.  The only debugger I have ever used which did everything I wanted 
when debugging multi-threaded programs was IPMD on OS/2...

It's only recently that we have got the feature of multi-threaded core dumps, 
before that feature arrived the core dump contained the stack of the main 
thread (which in most multi-threaded programs was the least likely thread to 
be the cause of the core dump and therefore the core dumps were almost always 
worthless).

Probably threads are best restricted to languages such as Java and Ada where 
you don't have core dumps.

On Saturday 04 December 2004 13:17, tridge@samba.org wrote:
>  > I've been asking about this in different places.  I've heard theories,
>  > mostly.  This is happening in Linux (dunno if it's been tested
>  > elsewhere) and one theory is that the forked process speeds are good
>  > because Linux basically does a really good job with those.  Meanwhile,
>  > thread speed is bad because the multiple threads are all within a single
>  > process and the single process gets only it's own share of processor
>  > time.
>
> Processes are faster than threads on all OSes that I have tested on
> (that includes Solaris, IRIX, AIX and Linux). The difference is most
> dramatic on the "traditional" unixes where threads _really_ suck
> badly, despite all the hype. On Linux with the latest 2.6 and glibc
> threads have almost caught up with processes, but still lag behind by
> a little.
>
> I've often heard people say things like "threads are fast on solaris"
> or "threads are fast on AIX". It's not true. They are slow as hell on
> both.
>
> now some explanation as to _why_ this is the case.
>
> On all modern unixes threads and processes are basically the same
> thing. The principle difference is that in threads memory is shared by
> default, and you have to do extra work to set it up as non-shared,
> whereas with processes memory is not shared by default and you have to
> do extra work to make it shared. Both systems have the same
> fundamental capabilities, its just the defaults that change.
>
> Now to the interesting bit. Because memory is shared by default, the C
> library has to assume that memory that it is working with is shared if
> you are using threads. That means it must add lock/unlock pairs around
> lots of internal code. If you don't use threads then the C library
> assumes that the programmer is smart enough to put locks on their own
> shared memory if they need them.
>
> Put another way, with processes you are using the hardware memory
> protection tables to do all the hard work, and that is essentially
> free. With threads the C library has to do all that work itself, and
> that is _slow_.
>
> With the latest glibc and kernel this problem has been reduced on
> Linux by some really smart locking techniques. It is an impressive
> piece of work, and means that for Linux threads now suck less than
> they do on other platforms, but they are still not faster than
> processes.
>
> So why do some people bother with threads? It's is for convenience. It
> makes some types of programming easier, but it does _not_ make it
> faster. The "threads are fast" meme is a complete fallacy, much like
> the common meme of CPUs running faster for in-kernel code.
>
> What is true is that on almost all platforms _creating_ a thread is
> cheaper than creating a process. That can matter for some applications
> where the work to be done take a very few cycles (like spawn-thread,
> add two numbers, then kill thread). Thread benchmarks tend to be in
> this category. File servers are not.
>
> For a file server you generally want your unit of processing to last
> for seconds to hours or days. In that case the few nano-seconds saved
> in the thread creation is not relevant.
>
> The other big thing that is bad about threads is that the designers of
> the thread APIs (like pthreads) did not consider file servers to be
> important, so they completely screwed up on several aspects of the
> API, so that the convenience of using threads is totally lost. A good
> example is the way threads interact with byte range locks. It is
> impossible for one thread to "lock" a byte range such that another
> thread can see the lock.
>
> Most of these API deficiencies could be fixed by making
> pthread_create() have an option on Linux to not pass CLONE_FILES or
> CLONE_FS to the clone() system call. If that was done then threads
> would start being a lot more palatable for file servers.
>
> Cheers, Tridge

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
