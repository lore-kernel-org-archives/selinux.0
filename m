Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA05006
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 01:46:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBK6k3I27991
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 06:46:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gBK6k1f27987 for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 06:46:02 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Paul Krumviede <pwk@acm.org>, selinux@tycho.nsa.gov
Subject: Re: [ISN] Music file flaws could threaten traders
Date: Fri, 20 Dec 2002 07:45:48 +0100
References: <200212192307.20386.russell@coker.com.au> <18223383.1040308887@localhost>
In-Reply-To: <18223383.1040308887@localhost>
MIME-Version: 1.0
Message-Id: <200212200745.48173.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 19 Dec 2002 23:41, Paul Krumviede wrote:
> <russell@coker.com.au> wrote:
> > This type of thing could affect Linux in the same way as it affects
> > Windows.
>
> i'm not so sure. the bugtraq posting about the windows XP bug
> indicated that it could be exploited even without downloading
> a file to the user's computer. if using explorer, the file had to be
> on the local machine, but didn't need to be "played" to allow
> an exploit. i don't think that either case is relevant to selinux
> (but would like to know if i'm wrong).

KDE supports creating "thumbnail" pictures to represent different types of 
files on the desktop and could also be vulnerable to "list a directory and 
have some code executed" type bugs.

The problem with KDE is that everything seems to be run from one process that 
just forks off copies of itself and mmap's executables (thus avoiding 
automatic domain transitions).

I think that this is relevant to people who are writing SE Linux policy.  It 
does not affect Linux, yet, AFAIK...  But sometimes it's best to lock down 
things that look dangerous rather than waiting for proof that they are 
dangerous (you never get absolute proof that anything is safe).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
