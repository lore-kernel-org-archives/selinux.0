Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB66MfRb009679
	for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 01:22:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB66MeRV025624
	for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 06:22:40 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hB66Mbta025621 for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 06:22:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: nagray@austin.rr.com
Subject: Re: ssh policy
Date: Sat, 6 Dec 2003 17:22:15 +1100
References: <1070587102.27071.159.camel@hawaii.efficax.net> <200312051307.48320.russell@coker.com.au> <1070651210.27071.290.camel@hawaii.efficax.net>
In-Reply-To: <1070651210.27071.290.camel@hawaii.efficax.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312061722.15059.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 6 Dec 2003 06:06, Nick <nagray@austin.rr.com> wrote:
> > I don't get it either.  Usually sshd runs fine with that blocked, but
> > sometimes it doesn't work correctly.  In my latest policy I have enabled
> > that access, but it needs more review.
>
> I took a look at the source for sshd. While the daemon is waiting for
> connections it regenerates it's server key every hour. This is done
> through a SIGALRM. I am trying to figure out why this would cause
> intermittent failures on the daemon if it wasn't allowed.
>
> I guess it really doesn't matter, it should be allowed. As the resident
> expert on policies, can you tell me if we can restrict the signals down
> to a type? I will look later.

Strange.  In any case this has to be enabled for running as a daemon.

For the moment I will deny sshd_t access to send signals to itself when 
running from inetd.

> I just found out I don't need X at all, so for now this solves any
> problem I have with that.

In that case it's best to disable X forwarding on both client and server.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
