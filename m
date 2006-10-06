Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96K5rdh007482
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 16:05:53 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96K55ru004885
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 20:05:08 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFCFF@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: RE: Denials from newest kernel
Date: Fri, 6 Oct 2006 16:05:05 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> I grabbed Erics new kernel builds and installed them and got some
> interesting denials. I started with no secmark rules whatsoever on the
> machine.
> 

Taking a fresh look again...

1. What policy (with what patches) were you using when you saw these errors?

2. What is the avahi daemon doing in the below? The reason I ask is that
   if the packet originated on the local machine itself and some how flowed
back in,
   we would obviously see the avahi_t context as the target since that's
what the
   packet was carrying.

> avc:  denied  { flow_out } for  pid=1815 comm="avahi-daemon" 
> saddr=10.1.13.105 daddr=224.0.0.22 netif=eth0 
> scontext=system_u:object_r:unlabeled_t:s0 
> tcontext=system_u:object_r:unlabeled_t:s0 tclass=packet
> 
> the target seems reasonable (unlabeled_t since there are no secmark
> rules) but the target should have been network_t (the unlabeled
> association) right?
> 
> avc:  denied  { flow_in } for  pid=1815 comm="avahi-daemon" 
> scontext=system_u:object_r:unlabeled_t:s0 
> tcontext=system_u:system_r:avahi_t:s0 tclass=packet
> 
> don't understand this one at all, source should be network_t 
> (i thought)
> and target should be a packet object (and there aren't any). Why is it
> getting the domain context?
> 
> avc:  denied  { recv } for  pid=1815 comm="avahi-daemon" 
> src=5353 dest=5353 netif=eth0 
> scontext=system_u:system_r:avahi_t:s0 
> tcontext=system_u:system_r:avahi_t:s0 tclass=packet
> 
> So the source here seems correct but the target is avahi_t again..
> 
> 
> I'm going to load up some secmark rules as soon as I get an iptables
> build that lets me (wonder why rawhides doesn't come with SECMARK :\ )
> and try this again.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
