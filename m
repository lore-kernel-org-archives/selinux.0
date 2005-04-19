Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3J1CU7C018181
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2005 21:12:30 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3J15Acd027045
	for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2005 01:05:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [POLICY/PATCH] IA-64 Boot Partition
Date: Tue, 19 Apr 2005 11:07:56 +1000
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
   "SELinux-ML(NSA)" <selinux@tycho.nsa.gov>
References: <4260B74B.3000002@kaigai.gr.jp> <1113827271.28051.39.camel@moss-spartans.epoch.ncsc.mil> <4263E641.9010100@kaigai.gr.jp>
In-Reply-To: <4263E641.9010100@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Message-Id: <200504191108.00367.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 19 April 2005 02:54, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> In Japan, Secure-OS such as SELinux is hoped for embedded computing field,
> because applying the latest security patch for those application is not
> as easy as one for our desktop PC.
> So, I wonder who did evaluate the behavior on ARM/MIPS archtecture.

I was one of the people who got SE Linux to work on an iPaQ.  I own two iPaQ's 
and plan to get them going again as soon as JFFS2 supports XATTRs.

I have no immediate plans to get any more machines other than x86.  In 
Australia P3-800 class machines are really cheap, such machines provide all 
the computer power I generally need so I don't have any plans to purchase 
anything better.

I have access to some other platforms in the Red Hat test lab, but nothing I 
can actually have on my desk.

We really need to get some people seriously using SE Linux on non-x86 
platforms for their regular computer use to get everything tested out.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
