Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA01286
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 14:40:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA26492
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 19:38:35 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA26486 for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 19:38:33 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: expect
Date: Mon, 2 Dec 2002 20:40:26 +0100
References: <200211292002.PAA23890@moss-shockers.ncsc.mil> <200212021558.27661.russell@coker.com.au> <20021202183420.A16247@lemuria.org>
In-Reply-To: <20021202183420.A16247@lemuria.org>
MIME-Version: 1.0
Message-Id: <200212022040.26257.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[having a session with the right context to run daemons rather than 
start-stop-daemon for each one]
> I like this idea a lot. It would make a real-life admin job much, much
> easier. It's not just that sometimes you have several daemons to
> (re)start, it is during development that you easily restart a given
> service a couple dozen times. I know I considered the password request
> a nuisance after the 5th or so time.

Good point.  When doing development you tend to have a dozen x-terms open at 
once anyway, so reserving one for starting and stopping daemons should be OK.

Although this is when having labelled X windows would be good.

> > I believe that this isn't as good as my solution with expect, and it
> > isn't something that can be done in a hurry either.
>
> Actually, it may turn out to be a better solution, mostly because
> expect is no longer required (and a couple of the recent postings here have
> shown just why that may be a good thing).

The only real problem we have with expect IMHO is the problem I discovered 
where some daemons don't start because the parent exits too fast.  I expect 
that I'll solve that soon though.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
