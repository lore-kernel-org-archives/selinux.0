Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1DNHapi029840
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 18:17:36 -0500
Received: from g5t0008.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1DNHZAu022868
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 23:17:35 GMT
From: Paul Moore <paul.moore@hp.com>
To: chanson@TrustedCS.com
Subject: Re: [refpolicy] [PATCH] refpolicy: Add missing network related MLSconstraints
Date: Fri, 13 Feb 2009 18:17:29 -0500
Cc: Glenn.Faden@sun.com, refpolicy@oss.tresys.com, selinux@tycho.nsa.gov
References: <20090212211531.619341973@hp.com> <200902131702.10467.paul.moore@hp.com> <170D6ABBBA770349AA49582A86FCED15BA0238@HAVOC.tcs-sec.com>
In-Reply-To: <170D6ABBBA770349AA49582A86FCED15BA0238@HAVOC.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902131817.29764.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 13 February 2009 05:17:13 pm chanson@trustedcs.com wrote:
> You are correct, we want to keep the existing overrides, but not provide
> anymore overrides. The network interface / node checking rope should be
> very short. The few exceptions of unlabeled_t or kernel_t. kernel_t was
> necessary for nfs awhile back (may not be necessary now), probably
> iSCSI, or basically things where the kernel is generating the packet
> instead of a process and not assuming other credentials.

Well, I suppose we can take the minimalistic, aka "short rope", approach right 
now since the ingress/egress controls are still new and not really integrated 
into policy in the form of templates.  As we continue to develop the policy 
and we find a need for them we can always [re-]add them.  Unless anyone chimes 
in over the weekend or next Monday I'll respin a patch next week.

Just out of curiosity, are you guys using any of the new stuff or are you 
still using your own special kernel with the rejected network controls?  I ask 
because I would be curious about any feedback you might have on the new bits 
in mainline.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
