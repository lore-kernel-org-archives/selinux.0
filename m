Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1N6MHRb015558
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 01:22:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1N6KhlK013800
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 06:20:43 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i1N6KgOX013797
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 06:20:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: trelane@digitasaru.net
Subject: Re: identity
Date: Mon, 23 Feb 2004 17:22:11 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200402231535.26738.russell@coker.com.au> <20040223060220.GC9438@digitasaru.net>
In-Reply-To: <20040223060220.GC9438@digitasaru.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402231722.11587.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 23 Feb 2004 17:02, Joseph Pingenot <trelane@digitasaru.net> wrote:
> Sounds like a good idea.  One question:
> Could you also record a signature of the data?  This would help distinguish
>        processes who aren't supposed to be letting users on the system
>        (since they'd not have a valid signature).  That'd potentially
>        be able to plug a standard usage of rooted systems: leave open a
>        port to the outside world to log in from.

That wouldn't work.

If a regular user shell process running as user_u:user_r:user_t can access the 
network then it can also launch other shells.  There is no way of stopping 
this.

How do you distinguish a copy of bash launched as a shell for an interactive 
session from an interpreter for a shell script?

How do you distinguish programs such as "script" from a wrapper for a UDP 
based terminal system?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
