Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6JFqbKu008103
	for <selinux@tycho.nsa.gov>; Wed, 19 Jul 2006 11:52:38 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6JFqaRt015617
	for <selinux@tycho.nsa.gov>; Wed, 19 Jul 2006 15:52:36 GMT
Message-ID: <36282A1733C57546BE392885C0618592013E7627@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle
	 <jbrindle@tresys.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List
	 <selinux@tycho.nsa.gov>
Subject: RE: [PATCH 4/6] netfilter integration: add netfilter contexts	sor
	ting
Date: Wed, 19 Jul 2006 11:52:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > Again, netfilter contexts seems like an ambiguous name. 
> Secmark rules
> > > seems more accurate to me.
> > > 
> > 
> > you can put any netfilter rule in, if in the future there 
> is something 
> > other than secmark that affects selinux those rules can 
> also go into 
> > this section.
> > 
> 
> And when those rules arrive integration work will be required 
> and code /
> format changes will likely result, nullifying any potential win from
> calling it netfilter now. So, it seems like false generality to me.
> Secmark more correctly describes the current and, as of now, only use
> for this section.
> 
> Karl

One other thing that may need to be kept in mind here is that in the
new design (see
http://marc.theaimsgroup.com/?l=linux-netdev&m=115136637800361&w=2)
"secmark" serves primarily as a flow control point (both inbound
and outbound) and secondarily as a labeling mechanism for inbound packets in
the absence of an explicit label coming in with the packets. So, we are
dealing
with contexts on these "gates" or "flow control points". We could either
look at
"secmark" as marking these "gates" or come up with a more intuitive name.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
