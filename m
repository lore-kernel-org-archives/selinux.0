Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1O13pRb020689
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 20:03:51 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1O13oQQ001157
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 01:03:50 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i1O13mP0001061 for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 01:03:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <jbrindle@snu.edu>
Subject: Re: identity
Date: Tue, 24 Feb 2004 12:02:25 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200402231535.26738.russell@coker.com.au> <20040223144726.GD9438@digitasaru.net> <403A34DD.6000108@snu.edu>
In-Reply-To: <403A34DD.6000108@snu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402241202.25048.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Feb 2004 04:14, Joshua Brindle <jbrindle@snu.edu> wrote:
> I've looked at the selinux code for implementing something like this
> without reaching outside of selinux/lsm and I just don't see any way for
> it to be done since the sid is created in selinux and used to resolve to
> a string context (including identity). It would have been ideal to have
> an identity struct that arbitrary data could be added to but this isn't
> done in selinux.

The SID is initially created by a login program, which can easily be changed 
to add more data if the kernel is happy to deal with it.

The fact that it's not supported in SE Linux yet does not mean that it can't 
be added in the future.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
