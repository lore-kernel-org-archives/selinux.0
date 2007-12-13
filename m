Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBDFuES7029450
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 10:56:14 -0500
Received: from g1t0028.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBDFuA0d015849
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 15:56:10 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Network flow controls and subj/obj ordering
Date: Thu, 13 Dec 2007 10:45:57 -0500
Cc: selinux@tycho.nsa.gov
References: <200712111202.20074.paul.moore@hp.com> <200712121518.15454.paul.moore@hp.com> <1197555128.12626.205.camel@gorn.columbia.tresys.com>
In-Reply-To: <1197555128.12626.205.camel@gorn.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712131045.57681.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 13 December 2007 9:12:08 am Christopher J. PeBenito wrote:
> On Wed, 2007-12-12 at 15:18 -0500, Paul Moore wrote:
> > Assuming labeled networking is enabled, a forwarded packet would
> > hit four checks:
> >
> >  # inbound checks
> >  allow netif_t peer_t:peer ingress;
> >  allow netnode_t peer_t:peer ingress;
> >  # outbound checks
> >  allow netif_t peer_t:peer egress;
> >  allow netnode_t peer_t:peer egress;
>
> This helps.  But this seems to be for the old networking, how does it
> work with the secmark stuff?

It doesn't work with the SECMARK stuff, or rather it works in parallel 
with the SECMARK stuff.  We've debated integrating the peer labeling 
protocols (labeled IPsec, NetLabel) with the SECMARK mechanism many 
times but in the end we always end up deciding it doesn't make sense.

The reason for the network interface, "netif_t", and node, "netnode_t", 
labels is that we want to be able to apply access controls to peer 
labeled network traffic based on the remote host and/or interface.  
Currently we have no way of doing this.

Hopefully this is starting to get a bit more clear now ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
