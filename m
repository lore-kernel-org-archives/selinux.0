Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i610HArT002134
	for <selinux@tycho.nsa.gov>; Wed, 30 Jun 2004 20:17:10 -0400 (EDT)
Received: from ms-smtp-01.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i610H8WY011928
	for <selinux@tycho.nsa.gov>; Thu, 1 Jul 2004 00:17:08 GMT
Date: Wed, 30 Jun 2004 19:16:53 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy help
Message-ID: <20040701001653.GA8858@yggdrasil.localdomain>
References: <20040630022848.GA4737@yggdrasil.localdomain> <200406301327.35935.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406301327.35935.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 30, 2004 at 01:27:35PM +1000, Russell Coker wrote:
> >    allow dnsmasq_t netif_type:netif { udp_send udp_recv };
> >    allow dnsmasq_t node_type:node { udp_send udp_recv };
> 
> Use can_network(dnsmasq_t) for this and more.

Thanx.  I switched to that approach, and everything seems to be working
as intended now.  I was avoiding can_network originally, because I was
trying to strictly limit network permissions... dnsmasq doesn't use
TCP, for example, so I didn't want to allow it.  I might revisit this
later (after working through some unrelated policies), although I'm not
at all sure it's worth the effort in this case. ;-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
