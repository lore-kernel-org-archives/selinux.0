Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA04699
	for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2003 03:57:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0A8vTI22595
	for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2003 08:57:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0A8vRf22591 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2003 08:57:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>, selinux@tycho.nsa.gov
Subject: Re: 2.4.20 stability issues
Date: Fri, 10 Jan 2003 09:57:07 +0100
References: <20030110002718.GA922@snoopy.apana.org.au>
In-Reply-To: <20030110002718.GA922@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301100957.07668.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Jan 2003 01:27, Brian May wrote:
> It only happens after an uptime of several hours (if not days; it
> also depends if you count time in suspend mode or not), on my laptop
> computer.

rjc@lyta:/tmp$ uname -a
Linux lyta 2.4.20-se-r #1 Mon Dec 16 19:48:46 CET 2002 i686 unknown unknown 
GNU/Linux
rjc@lyta:/tmp$ uptime
 09:52:14 up 4 days,  9:11,  1 user,  load average: 0.88, 1.33, 0.90
rjc@lyta:/tmp$

I have included a ReiserFS patch for performance that probably does not impact 
this.

Let me know if you'd like a copy of the kernel deb that I use for testing and 
I'll scp it to snoopy.  I don't use FreeSWAN and I have it compiled to 
auto-mount devfs, but apart from that it should work for you (it's the same 
configuration we use for ns).

> I had no problems with 2.4.19, but as of 2.4.20 I seem to have
> encountered some weird stability issues that I cannot put my finger on.
[]
> So far this has only ever happened with 2.4.19, not 2.4.20. Weird.

???

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
