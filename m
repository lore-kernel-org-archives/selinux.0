Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA12377
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 11:02:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA25723
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 15:01:15 GMT
Received: from ivanova.coker.com.au (ivanova.coker.com.au [203.36.46.209])
	by jazzswing.ncsc.mil  with ESMTP id PAA25711
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 15:01:07 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Justin R. Smith" <jsmith@mcs.drexel.edu>, selinux@tycho.nsa.gov
Subject: Re: A notion
Date: Tue, 2 Oct 2001 14:05:24 +0200
References: <1002012173.1248.12.camel@vorpal>
In-Reply-To: <1002012173.1248.12.camel@vorpal>
MIME-Version: 1.0
Message-Id: <20011002150141.6EF1337D96B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Oct 2001 10:42, Justin R. Smith wrote:
> It occurred to me that custom versions of software can be more secure
> than standard versions because various exploits (like stack smashing,
> etc.) require precise knowledge of certain sizes and distances in RAM
> (for instance, the distance from the end of a buffer to the return
> point...).
>
> Isn't it possible to develop a "randomizing C compiler" that randomly
> varies these distances every time it compiles a program? No two compiles
> of the same source code would be exactly the same (but they would
> execute the same way).

I have a better idea.  Use such a compiler for testing your code.  If the 
program you are testing doesn't behave the same way in different compiles (a 
large proportion of programs won't because they are buggy) then you debug it!

Many times I have seen companies ship code compiled in debugging mode because 
optimising mode of the compiler resulting in SEGV's.  Naturally they assumed 
it was a bug in the compiler not a bug in their code.  :(

As someone else mentioned there are a number of options for trying to make it 
more difficult to smash stacks, including a kernel patch from Solar Designer.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
