Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4CCPXT9006023
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 08:25:33 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4CCPV6C029972
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 12:25:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Steve G <linux_4ever@yahoo.com>
Subject: Re: avcs when setting a watch
Date: Fri, 12 May 2006 22:25:14 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20060510200300.51127.qmail@web51514.mail.yahoo.com>
In-Reply-To: <20060510200300.51127.qmail@web51514.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605122225.18004.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 11 May 2006 06:03, Steve G <linux_4ever@yahoo.com> wrote:
> Should the policy be adjusted to let auditctl search anywhere (even though
> its not guilty) or should the kernel itself be unconfined?

It would probably be ideal if this operation could be performed in kernel 
context.

But if that is difficult or ugly in some way then allowing auditctl_t to 
{getattr search} to all directory types and getattr to all file types will be 
fine.  auditctl_t is a fairly trusted domain anyway, any concerns that we 
might have in regard to it would be in regard to integrity not 
confidentiality.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
