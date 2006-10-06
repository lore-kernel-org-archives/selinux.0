Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96EO3Xp026499
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 10:24:03 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96ENP03019972
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 14:23:26 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFBE5@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov
Subject: RE: Denials from newest kernel
Date: Fri, 6 Oct 2006 10:23:46 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Joshua Brindle [mailto:jbrindle@tresys.com]
> Sent: Friday, October 06, 2006 8:56 AM
> To: Venkat Yekkirala
> Cc: selinux@tycho.nsa.gov
> Subject: RE: Denials from newest kernel
> 
> 
> On Fri, 2006-10-06 at 09:45 -0400, Venkat Yekkirala wrote:
> > > -----Original Message-----
> > > From: Joshua Brindle [mailto:jbrindle@tresys.com]
> > > Sent: Friday, October 06, 2006 8:32 AM
> > > To: selinux@tycho.nsa.gov; Venkat Yekkirala
> > > Subject: Denials from newest kernel
> > > 
> > > 
> > > I grabbed Erics new kernel builds and installed them and got some
> > > interesting denials. I started with no secmark rules 
> whatsoever on the
> > > machine.
> > > 
> > > avc:  denied  { flow_out } for  pid=1815 comm="avahi-daemon" 
> > > saddr=10.1.13.105 daddr=224.0.0.22 netif=eth0 
> > > scontext=system_u:object_r:unlabeled_t:s0 
> > > tcontext=system_u:object_r:unlabeled_t:s0 tclass=packet
> > > 
> > > the target seems reasonable (unlabeled_t since there are 
> no secmark
> > > rules) but the target should have been network_t (the unlabeled
> > > association) right?
> > 
> > Actually, the source should have read avahi_t and the 
> target network_t.
> > 
> > network_t refers to the "network cloud" so to speak.
> > 
> > IOW, "can a packet from domain avahi_t flow_out to the network?".
> > 
> 
> I was under the impression that the flow_out permissions referred to a
> packet object (you are claiming that the association label will be the
> target, this is object class confusion) flowing out an 
> association so it
> should be allow network_t unlabeled_t (or 
> avahi_server_packet_t if I had
> secmark on : packet { flow_out }
> 
> If this is intentionally referring to the association as the 
> target then
> the permissions need to be moved to the association object class

I would have to refer you to the following discussion we had on how
secpoint err secmark is intended to be used thru to deciding not to
mess with the naming.
http://marc.theaimsgroup.com/?l=selinux&m=115928609916717&w=2

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
