Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9GDFilp018707
	for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2006 09:15:44 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9GDEN0e007315
	for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2006 13:14:23 GMT
Subject: RE: Denials from newest kernel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vyekkirala@TrustedCS.com
Cc: "'James Morris'" <jmorris@namei.org>, "'Paul Moore'" <paul.moore@hp.com>,
        selinux@tycho.nsa.gov,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <001c01c6efe4$a9d6b3c0$cc0a010a@tcssec.com>
References: <001c01c6efe4$a9d6b3c0$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 09:16:30 -0400
Message-Id: <1161004590.5980.186.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-10-14 at 18:01 -0500, Venkat Yekkirala wrote:
> > > First of all, the "understandability" problem we have been
> > having has
> > > to do with the following:
> > >
> > > 1. Naming: we just refuse to change the naming for some
> > inexplicable reason.
> >
> > We are not renaming the SECMARK and CONNSECMARK kernel
> > modules, which are
> > already upstream, as well as the userland iptables code, and
> > the existing
> > packet labeling policy constructs.  Secmark works fine for
> > normal users
> > who are using internal labeling.
> 
> Ok. This is where we have a disconnect (I thought we understood this
> implicitly a long time back, but since we haven't I will say this):
> 
> Secmark DOES NOT work fine for normal users who are using internal
> labeling for the reason that it's scope is very narrow (socket Vs. packet)
> with no controls for forwarded traffic. Now you may argue that that's what
> it was designed for, but the fact still remains: it's NOT a comprehensive
> (still talking internal labeling only) solution to the problem of packet
> flow control on a modern "security-enhanced" OS. This everyone needs to
> first
> understand.

I strongly disagree with this.  It is a replacement for the
port/node/netif basic networking controls.  Its vastly superior because
it provides the expressiveness of netfilter so you can have combinations
of ports, nodes, and netifs (and other netfilter things if you want).

I can see how the flow controls can do something for the forwarding
case, but in my opinion doesn't do anything for the regular input and
output cases.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
