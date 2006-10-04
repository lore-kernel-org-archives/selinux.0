Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94FM4Go018144
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 11:22:04 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94FLSCa017613
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 15:21:29 GMT
Subject: RE: [redhat-lspp] Labeled networking at the end of the day Oct 2,
	2006
From: Eric Paris <eparis@redhat.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <36282A1733C57546BE392885C0618592015CF867@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015CF867@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 11:23:30 -0400
Message-Id: <1159975410.10614.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-04 at 11:03 -0400, Venkat Yekkirala wrote:
> > > 1) Patch 7/9 from the reconciliation thread should be cleaned up to
> > > better use BUG_ON()
> > > 2) Patch 2/9 should drop polsec from the hook interface in 
> > > security_ops
> > 
> > These minor things as well as any optimizations can again go 
> > in between
> > beta2 and GA.
> 
> Missed "?" at the end. Meant to ask/suggest, not to tell :) 

Since they aren't functionality or bug fix but rather code fix/clean-up,
likely not until RHEL6.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
