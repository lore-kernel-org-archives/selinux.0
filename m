Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA05277
	for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2003 06:04:36 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0AB4aI26475
	for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2003 11:04:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0AB4Yf26470 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2003 11:04:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: 2.4.20 stability issues
Date: Fri, 10 Jan 2003 12:04:22 +0100
Cc: selinux@tycho.nsa.gov
References: <20030110002718.GA922@snoopy.apana.org.au> <200301100957.07668.russell@coker.com.au> <20030110092425.GD9359@snoopy.apana.org.au>
In-Reply-To: <20030110092425.GD9359@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301101204.22678.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Jan 2003 10:24, Brian May wrote:
> Interesting; maybe it is one of my patches.
>
> (it has happened before, a bug for instance in the ACL patch would crash
> the computer even when just fscking the filesystem).
>
> Although 4 days may not be long enough to reproduce the bug, not
> sure on this.

I also have another machine that is running the same kernel but is not running 
flawlessly (however it is running a known-buggy kernel module which has 
caused the same problem in previous kernels as are occuring in the latest 
one).

I am running a Desktop test machine (a SE play machine on the LAN at work) 
which has 23 days of uptime on light load with the same kernel.

Also I have some live production servers running the same LSM patch but with 
the OpenWall option selected.  They are mail servers with 250,000 accounts 
per server for a total of 1M accounts across four servers.  Apart from some 
disk-IO performance issues they are running perfectly.

> It was also sometime last year that my Thinkpad totally died (after
> random crashes), and needed a new motherboard, I am keeping my fingers
> crossed that it isn't the same problem.

Maybe that's the issue.

Why don't you put that kernel on snoopy?  The only thing that stopped me 
putting all the latest kernels on ivanova was being on a different continent 
to it...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
