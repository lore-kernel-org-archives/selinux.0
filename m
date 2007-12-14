Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBEJPkQM009029
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 14:25:46 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id lBEJPf0k013232
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 19:25:41 GMT
Subject: Re: Network flow controls and subj/obj ordering
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200712131045.57681.paul.moore@hp.com>
References: <200712111202.20074.paul.moore@hp.com>
	 <200712121518.15454.paul.moore@hp.com>
	 <1197555128.12626.205.camel@gorn.columbia.tresys.com>
	 <200712131045.57681.paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 14 Dec 2007 14:25:12 -0500
Message-Id: <1197660312.12626.227.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-12-13 at 10:45 -0500, Paul Moore wrote:
> On Thursday 13 December 2007 9:12:08 am Christopher J. PeBenito wrote:
> > On Wed, 2007-12-12 at 15:18 -0500, Paul Moore wrote:
> > > Assuming labeled networking is enabled, a forwarded packet would
> > > hit four checks:
> > >
> > >  # inbound checks
> > >  allow netif_t peer_t:peer ingress;
> > >  allow netnode_t peer_t:peer ingress;
> > >  # outbound checks
> > >  allow netif_t peer_t:peer egress;
> > >  allow netnode_t peer_t:peer egress;
> >
> > This helps.  But this seems to be for the old networking, how does it
> > work with the secmark stuff?
> 
> It doesn't work with the SECMARK stuff, or rather it works in parallel 
> with the SECMARK stuff.  We've debated integrating the peer labeling 
> protocols (labeled IPsec, NetLabel) with the SECMARK mechanism many 
> times but in the end we always end up deciding it doesn't make sense.

So, with compat_net off, you'd still need the above policy, not the
packet type against the peer type?, e.g., not this:

allow ssh_client_packet_t peer_t:peer egress;

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
