Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h986ofWt017220
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 02:50:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h986od7f010337
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 06:50:40 GMT
Date: Wed, 8 Oct 2003 06:41:49 +0000
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [selinux] init
Message-ID: <20031008064149.GA22314@bunuel.tii.matav.hu>
References: <200310080111.50210.russell@coker.com.au> <1065558422.7696.106.camel@kusturica> <200310081424.19249.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <200310081424.19249.russell@coker.com.au>
From: mag@bunuel.tii.matav.hu (Magosányi Árpád)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A levelezõm azt hiszi, hogy Russell Coker a következõeket írta:
> On Wed, 8 Oct 2003 06:27, Magosányi Árpád wrote:
> > I would vote for 5 being
> > < 5) if policy isn't loaded and we don't have [some indication that we
> > do not insist on selinux], halt the system with an appropriate message.
> >
> > The indication could be that there is no selinux support in the kernel,
> > or some boot option.
> 
> Currently we have been working towards making a SE Linux system be usable if 
> booted with a non-SE kernel.  We could have a compile option to do what you 

This is the very reason I proposed checking selinux support in the kernel.
What you have proposed is a fail-open solution. The theoretically
correct solution would be fail-safe. A good compromise would be to
assume if theadministrator boots a non-se kernel or gives a special
boot option, then she knows what she does.

> request, but I doubt that we want it on by default.  We certainly don't want 
> it in RPMs that we ship!

Fortunately I have no RPM based systems, I am just interested in upstream.

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
