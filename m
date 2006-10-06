Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96LHaSU009965
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 17:17:36 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96LGxru013039
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 21:17:00 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFD1E@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        "'Joshua Brindle'"
	 <jbrindle@tresys.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Fri, 6 Oct 2006 17:17:26 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
> Venkat Yekkirala wrote:
> > Joshua Brindle wrote:
> > > I grabbed Erics new kernel builds and installed them and got some
> > > interesting denials. I started with no secmark rules 
> > whatsoever on the
> > > machine.
> > > 
> > 
> > Taking a fresh look again...
> > 
> > 1. What policy (with what patches) were you using when you 
> > saw these errors?
> > 
> > 2. What is the avahi daemon doing in the below? The reason I 
> > ask is that
> >    if the packet originated on the local machine itself and 
> > some how flowed back in,
> >    we would obviously see the avahi_t context as the target 
> > since that's what the
> >    packet was carrying.
> > 
> 
> Seeing that avahi is sending to a multicast address, it seems like
> it's receiving a copy of the message, THAT HAS THE avahi_t originating
> domain still tied to it. I am going to send a patch out shortly that
> will nullout this tie-up to the originating domain in postroute_last.
> This *should* take care of denials 2 &3 below. They will still appear,
> but with network_t (or unlabeled_t in Joshua's case since he seems to
> have his netmsg initsid context set to unlabeled_t:s0 as also 
> the unlabeled
> initsid) in the target.
BTW, Joshua probably knows that the machine needs to be rebooted for
any initsid changes to take effect.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
