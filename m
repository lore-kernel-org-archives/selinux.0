Subject: Re: Network flow controls and subj/obj ordering
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
In-Reply-To: <1197660650.31325.169.camel@moss-spartans.epoch.ncsc.mil>
References: <200712111202.20074.paul.moore@hp.com>
	 <200712121518.15454.paul.moore@hp.com>
	 <1197555128.12626.205.camel@gorn.columbia.tresys.com>
	 <200712131045.57681.paul.moore@hp.com>  <1197660312.12626.227.camel@gorn>
	 <1197660650.31325.169.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 14 Dec 2007 14:36:21 -0500
Message-Id: <1197660981.12626.231.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-12-14 at 14:30 -0500, Stephen Smalley wrote:
> On Fri, 2007-12-14 at 14:25 -0500, Christopher J. PeBenito wrote:
> > On Thu, 2007-12-13 at 10:45 -0500, Paul Moore wrote:
> > > On Thursday 13 December 2007 9:12:08 am Christopher J. PeBenito wrote:
> > > > On Wed, 2007-12-12 at 15:18 -0500, Paul Moore wrote:
> > > > > Assuming labeled networking is enabled, a forwarded packet would
> > > > > hit four checks:
> > > > >
> > > > >  # inbound checks
> > > > >  allow netif_t peer_t:peer ingress;
> > > > >  allow netnode_t peer_t:peer ingress;
> > > > >  # outbound checks
> > > > >  allow netif_t peer_t:peer egress;
> > > > >  allow netnode_t peer_t:peer egress;
> > > >
> > > > This helps.  But this seems to be for the old networking, how does it
> > > > work with the secmark stuff?
> > > 
> > > It doesn't work with the SECMARK stuff, or rather it works in parallel 
> > > with the SECMARK stuff.  We've debated integrating the peer labeling 
> > > protocols (labeled IPsec, NetLabel) with the SECMARK mechanism many 
> > > times but in the end we always end up deciding it doesn't make sense.
> > 
> > So, with compat_net off, you'd still need the above policy, not the
> > packet type against the peer type?, e.g., not this:
> > 
> > allow ssh_client_packet_t peer_t:peer egress;
> 
> Correct, not that.  secmark remains a separate and orthogonal mechanism,
> with permission checks against the packet class (not the peer class),
> and the secmark label is only ever used for its checks.

The thing that confuses me is that I thought secmark was supposed to
replace netif/node for IP traffic.  So using the node/netif labels just
seems wrong to me.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
