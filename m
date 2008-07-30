Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6UG53wN008067
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2008 12:05:03 -0400
Received: from sender-03.it.helsinki.fi (jazzdrum.ncsc.mil [144.51.5.7])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6UG4w5J003903
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2008 16:05:03 GMT
Date: Wed, 30 Jul 2008 19:04:09 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: Paul Moore <paul.moore@hp.com>
cc: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming
In-Reply-To: <200807301122.06990.paul.moore@hp.com>
Message-ID: <Pine.LNX.4.64L.0807301827040.19703@ruuvi.it.helsinki.fi>
References: <Pine.LNX.4.64L.0807210043160.7451@ruuvi.it.helsinki.fi>
 <200807210938.31144.paul.moore@hp.com> <200807301248.04810.russell@coker.com.au>
 <200807301122.06990.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

On Wed, 30 Jul 2008, Paul Moore wrote:

> On Tuesday 29 July 2008 10:47:59 pm Russell Coker wrote:

> >
> > But using idx, index, or even names such as "count" which refer to
> > the meaning of the program might be more efficient overall.  I've
> > posted some more thoughts on this issue at the above URL.
>
> FWIW, you hit on my own selfish reasons for using "idx" instead of "i":
> easier searching (my XEmacs config highlights search terms in red) and
> greater "understandability".

I wish to express my disagreement, but please do not take this as a
request to alter the earlier patch rejection; I have no problem with it.

When using local variables as loop indexes or something equally
elementary, I always prefer "i" to "idx", "index" or "count". My rationale
is the following:

1) The existing convention; I've seen C-code like:

  for (i = 0; i < MAX; i++)

so many times that the "i" has almost become a part of the language
syntax in my brain. I'd guess many C-programmers feel the same way.

Granted, the "this is how it's always been" is a weak argument to
support anything, but personally, I gain no more insight from the
longer forms, so I prefer the more terse "i".

2) Related to the first; the existing code base. If I see 999, 99, or even
   9 functions in the same program/module consistenly using "int i", I
   will under no circumstance use "idx" in my additional function, but
   insist that all the functions use the same variable naming scheme.

   If, for some reason, the dominant variable naming for a particular code
   base happens to be "idx", "index", or "count", then I will adapt to
   that style.

   Further, I always to try extend the adaptation principle to the
   positioning of braces, whitespace, etc. so that all the code looks
   as if written by one person (I mean style-wise).

3) As Russell says in his blog: "Of course for some uses (such as a loop
   counter) there is little benefit in using grep." Yes. I also fail to
   see the drawbacks of using "FILE *f" inside a single function. Granted,
   if the functions are 3000-line monsters (yeah, unfortunately those do
   exist), you might have to use a more descriptive naming, but for the
   saner lengths, I am not so sure. For monster functions, refactoring
   it to smaller chunnks is usually the correct solution anyway, not
   changing "FILE *f" to "FILE *configFile".

4) Related to the particular case I addressed in my original message,
   the Linux Kernel Documentation/CodingStyle says:

  "LOCAL variable names should be short, and to the point.  If you have
  some random integer loop counter, it should probably be called "i".
  Calling it "loop_counter" is non-productive, if there is no chance of it
  being mis-understood.  Similarly, "tmp" can be just about any type of
  variable that is used to hold a temporary value."

Best regards,
vmk
-- 
************************************************************************
               Tietotekniikkaosasto / Helsingin yliopisto
                 IT Department / University of Helsinki
************************************************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
