Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA04933
	for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2003 04:24:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA01541
	for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2003 09:22:02 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id JAA01536
	for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2003 09:21:54 GMT
Date: Fri, 10 Jan 2003 20:24:25 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: 2.4.20 stability issues
Message-ID: <20030110092425.GD9359@snoopy.apana.org.au>
References: <20030110002718.GA922@snoopy.apana.org.au> <200301100957.07668.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200301100957.07668.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jan 10, 2003 at 09:57:07AM +0100, Russell Coker wrote:
> rjc@lyta:/tmp$ uname -a
> Linux lyta 2.4.20-se-r #1 Mon Dec 16 19:48:46 CET 2002 i686 unknown unknown 
> GNU/Linux
> rjc@lyta:/tmp$ uptime
>  09:52:14 up 4 days,  9:11,  1 user,  load average: 0.88, 1.33, 0.90
> rjc@lyta:/tmp$

Interesting; maybe it is one of my patches.

(it has happened before, a bug for instance in the ACL patch would crash
the computer even when just fscking the filesystem).

Although 4 days may not be long enough to reproduce the bug, not
sure on this.

It was also sometime last year that my Thinkpad totally died (after
random crashes), and needed a new motherboard, I am keeping my fingers
crossed that it isn't the same problem.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
