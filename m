Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0BBXgRb008225
	for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2004 06:33:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0BBWaxr018313
	for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2004 11:32:36 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i0BBWYYc018207
	for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2004 11:32:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Park Lee <parklee_2004@yahoo.com.cn>
Subject: Re: Questions about install SELinux in Fedora Core
Date: Sun, 11 Jan 2004 22:31:54 +1100
Cc: selinux@tycho.nsa.gov
References: <20040111024703.62855.qmail@web15208.mail.bjs.yahoo.com>
In-Reply-To: <20040111024703.62855.qmail@web15208.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200401112231.54137.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 11 Jan 2004 13:47, Park Lee <parklee_2004@yahoo.com.cn> wrote:
> You say that:
> >Better to get 2.6.1.
>
> But there is only the 2.6.0-test11 kernel with SELinux patch applied could
> be down from www.nsa.gov/selinux.

2.6.0 and 2.6.1 run fine without any patches.

> >quota-tools doesn't matter unless you are using quotas, are >you using
> > quotas? For xfsprogs, last I heard XFS support for SE Linux wasn't >quite
> > ready. So unless something has changed you have to use Ext3, and
> > >therefore the version of xfsprogs does not matter.
> >Red Hat uses a different procps to everyone else. Don't worry >about it.
>
> Then do you mean that I can ignore the above problems and install the 2.6
> kernel with SELinux patch applied in the Fedora Core(2.4.22-1.2115.nptl )
> successfully.

Use Arjan's 2.6 kernel package, or compile your own 2.6.1 kernel.  Don't worry 
about those problems.

> And if I download the newest version of xfsprogs,quota-tools and procps.
> Could I install them in the Fedora Core(2.4.22-1.2115.nptl ) and do not
> cause other problems.

Procps 3.1.15 will also work fine, but it's a different thing to the Red Hat 
procps.

XFS isn't something I've had a need to learn about, and quota-tools isn't 
something I've used recently.  I don't know what the issues of upgrading them 
may be.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
