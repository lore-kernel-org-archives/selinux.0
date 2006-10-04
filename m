Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94HwIXq025379
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 13:58:18 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94HvfUx010486
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 17:57:42 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CF8EB@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Eric Paris
	 <eparis@redhat.com>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
Subject: RE: [redhat-lspp] Labeled networking at the end of the day Oct 2,
	 2006
Date: Wed, 4 Oct 2006 13:57:58 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Non-kernel code issues which must be resolved/explained
> > 1) I also haven't heard any response to method's inquiry about the
> > meaning of some unlabeled_t denials namely
> > 
> > audit(1159877238.937:35): avc:  denied  { polmatch } for  
> > scontext=system_u:object_r:unlabeled_t:s0 
> > tcontext=root:system_r:unconfined_t:s0-s0:c0.c255 tclass=association
> 
> The patch I posted last night should take care of this as well.
>
I misread the target in the above denial to be unlabeled_t. But I
see it's unconfined_t. Currently looking at Joshua's post in this regard.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
