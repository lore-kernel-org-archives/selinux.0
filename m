Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QDGFrT027231
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 09:16:15 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QDFC76013572
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 13:15:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joe Nall <joe@nall.com>
Subject: Re: Remove unrestricted_admin
Date: Sun, 26 Sep 2004 23:16:11 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <200409211526.37810.russell@coker.com.au> <1096052356.9895.25.camel@selinux> <9A993228-0F47-11D9-80EA-000A95EED7F6@nall.com>
In-Reply-To: <9A993228-0F47-11D9-80EA-000A95EED7F6@nall.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409262316.11071.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 26 Sep 2004 09:06, Joe Nall <joe@nall.com> wrote:
> > Yes these are reasons; however, this is supposed to be the strict
> > policy, and these are not compelling enough to loosen the policy this
> > way, in my opinion.
>
> dd has other options (seek, skip, count) that allow arbitrary editing of
> a raw disk. If you can dd (or write in general) the root raw disk
> partition,
> you can do anything.

If you can put SE Linux in permissive mode (as sysadm_t can) then as far as SE 
Linux is concerned you can do anything.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
