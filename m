Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5U3RhrT023387
	for <selinux@tycho.nsa.gov>; Tue, 29 Jun 2004 23:27:43 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5U3RfAg007967
	for <selinux@tycho.nsa.gov>; Wed, 30 Jun 2004 03:27:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: policy help
Date: Wed, 30 Jun 2004 13:27:35 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040630022848.GA4737@yggdrasil.localdomain>
In-Reply-To: <20040630022848.GA4737@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406301327.35935.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 Jun 2004 12:28, Greg Norris <haphazard@kc.rr.com> wrote:
> Basically, dnsmasq is acting as the DNS and DHCP server for my local
> network, and needs to be able to take on all comers.  To that end I'm
> using the following entries, in an attempt to allow UDP connectivity to
> anywhere.
>
>    allow dnsmasq_t netif_type:netif { udp_send udp_recv };
>    allow dnsmasq_t node_type:node { udp_send udp_recv };

Use can_network(dnsmasq_t) for this and more.

It my be easiest to just derive your work from the dhcpd.te file.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
