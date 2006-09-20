Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8KD2b1e012473
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 09:02:37 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8KD1bNK020645
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 13:01:38 GMT
Message-ID: <36282A1733C57546BE392885C061859201573104@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: RE: ipsec, netlabels, secmark- How about a little usability?
Date: Wed, 20 Sep 2006 09:02:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > So, what happens if an externally labeled packet (e.g.: 
> Labeled IPSec)
> > comes in thru the above entry point? First of all, a check 
> is made to
> > see if a packet so labeled using IPSec (unlabeled if no IPSec) can
> > "flow in" thru the "entry point". If it can, and if there's an
> > IPSec label on the packet, a transition sid is computed between the
> > "entry point" label and the IPSec label and the packet will 
> be marked
> > with this transition sid. The transition label will either 
> be the IPSec
> > label (default) or any other label as defined by SELinux 
> policy transition
> > rules.
> >
> >   
> What if there are 2 external labels (ipsec and cipso) ?

A "cipso label" will be constructed using the transition label,
determined in the above process, or in it's absence (i.e., no labeled IPSec)
the "entry point" label, as the base sid. A check is made to see
if a packet with this "cipso label" can "flow in" thru
the transition label (or the "entry point" label if no labeled IPSec)
and if it can, then the packet is marked with this cipso label.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
