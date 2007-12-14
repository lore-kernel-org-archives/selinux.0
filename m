Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBEJajjO010914
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 14:36:45 -0500
Received: from g5t0009.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBEJaj9j028730
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 19:36:45 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Network flow controls and subj/obj ordering
Date: Fri, 14 Dec 2007 14:36:36 -0500
Cc: selinux@tycho.nsa.gov
References: <200712111202.20074.paul.moore@hp.com> <200712131045.57681.paul.moore@hp.com> <1197660312.12626.227.camel@gorn>
In-Reply-To: <1197660312.12626.227.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712141436.37142.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 14 December 2007 2:25:12 pm Christopher J. PeBenito wrote:
> On Thu, 2007-12-13 at 10:45 -0500, Paul Moore wrote:
> > On Thursday 13 December 2007 9:12:08 am Christopher J. PeBenito wrote:
> > > On Wed, 2007-12-12 at 15:18 -0500, Paul Moore wrote:
> > > > Assuming labeled networking is enabled, a forwarded packet would
> > > > hit four checks:
> > > >
> > > >  # inbound checks
> > > >  allow netif_t peer_t:peer ingress;
> > > >  allow netnode_t peer_t:peer ingress;
> > > >  # outbound checks
> > > >  allow netif_t peer_t:peer egress;
> > > >  allow netnode_t peer_t:peer egress;
> > >
> > > This helps.  But this seems to be for the old networking, how does it
> > > work with the secmark stuff?
> >
> > It doesn't work with the SECMARK stuff, or rather it works in parallel
> > with the SECMARK stuff.  We've debated integrating the peer labeling
> > protocols (labeled IPsec, NetLabel) with the SECMARK mechanism many
> > times but in the end we always end up deciding it doesn't make sense.
>
> So, with compat_net off, you'd still need the above policy, not the
> packet type against the peer type?

The compat_net setting has no effect on the peer object class permissions.  
The only thing that will cause the any of the access controls above (the ones 
I listed) to go into affect is the netpeer policy capability bit/flag.

> ... not this: 
>
> allow ssh_client_packet_t peer_t:peer egress;

There should never be a check between the iptables/secmark 
label, "ssh_client_packet_t", and the network peer label, "peer_t".  Ever.  
Well, unless I screwed up the code somewhere ;)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
