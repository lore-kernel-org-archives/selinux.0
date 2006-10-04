Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94F43wp017349
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 11:04:03 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94F3RCa014860
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 15:03:28 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CF867@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Eric Paris
	 <eparis@redhat.com>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
Subject: RE: [redhat-lspp] Labeled networking at the end of the day Oct 2,
	 2006
Date: Wed, 4 Oct 2006 11:03:31 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > 1) Patch 7/9 from the reconciliation thread should be cleaned up to
> > better use BUG_ON()
> > 2) Patch 2/9 should drop polsec from the hook interface in 
> > security_ops
> 
> These minor things as well as any optimizations can again go 
> in between
> beta2 and GA.

Missed "?" at the end. Meant to ask/suggest, not to tell :) 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
