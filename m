Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OCWcHa000158
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 08:32:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6OCWQDW019105
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 12:32:26 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h6OCWQeN019102 for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 12:32:26 GMT
Date: Thu, 24 Jul 2003 13:32:20 +0100
From: Dale Amon <amon@vnl.com>
To: Dale Amon <amon@vnl.com>, Lukasz Luzar <lluzar@tigeraudits.com>,
   "Carsten P. Gehrke" <Carsten@rollinghorse.com>, selinux@tycho.nsa.gov
Subject: Re: Linuxfromscratch.org
Message-ID: <20030724123220.GB25756@vnl.com>
References: <5.1.1.6.2.20030723080629.0a198680@Shire> <Pine.LNX.4.44.0307232139200.9324-100000@chaos.tigeraudits.com> <20030724002949.GI4900@vnl.com> <20030724063949.GC16983@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030724063949.GC16983@snoopy.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 24, 2003 at 04:39:49PM +1000, Brian May wrote:
> > login.c
> >   main () { printf ("Hello World\n"); }
> > 
> > and the hand decompile the binary to see if there
> > is anything unexpected present.
> 
> Does this proove anything though?
> 
> A trojon horse in the compiler could be clever enough not to insert
> any back doors on such simple code...

There are some safe assumptions we can make:

	* The trojan is not arbitrarily complex as
	  it must have compiled into the size of
	  the early gcc.

	* It is not arbitrarily specific or else
	  it would only have worked on the earliest
	  login.c and thus we can escape it simply
	  by changing the login.c code.

So it is either simple minded or there are certain
features in a login.c that all C programmers will
recreate even if starting from a blank emacs windows
and no knowledge of the original login.c other than
a minimal functional requirement doc.

So get 100 junior programmers to write one hundred 
login.c's from scratch and see what they have in 
common. 

But I'll short circuit it. If I were coding this
in C back in 1977, I'd have done a string compare
on Username: and Password:. 

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
