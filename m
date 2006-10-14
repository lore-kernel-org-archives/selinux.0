Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9EKwe7m014049
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 16:58:40 -0400
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9EKvKS0025996
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 20:57:20 GMT
Date: Sat, 14 Oct 2006 16:58:37 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: "'Paul Moore'" <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: RE: Denials from newest kernel
In-Reply-To: <001a01c6efc9$f2699af0$cc0a010a@tcssec.com>
Message-ID: <Pine.LNX.4.64.0610141645190.18416@d.namei>
References: <001a01c6efc9$f2699af0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 14 Oct 2006, Venkat Yekkirala wrote:

> > > Can you specify what we are exactly loosing, if any, in the process?
> >
> > In one work, "understandability"
> 
> First of all, the "understandability" problem we have been having has
> to do with the following:
> 
> 1. Naming: we just refuse to change the naming for some inexplicable reason.

We are not renaming the SECMARK and CONNSECMARK kernel modules, which are 
already upstream, as well as the userland iptables code, and the existing 
packet labeling policy constructs.  Secmark works fine for normal users 
who are using internal labeling.

Also, ss I've said before, 'secpoint' is an abstraction which IMHO does 
not increase understandability in the common case.  'secmark' is the 
security analog of 'mark' (i.e. the MARK and CONNMARK modules), and it is 
very simply understandable as "adding security marks to packets".  Thus, 
the packet class is also appropriate, as packets are real kernel objects 
which you can literally set a security marking on.

I think this idea of modifying secmarks when external labeling enabled is 
not the right solution.

1. If you want to use the skb to carry external labeling information, then 
you can do this internally by splitting the secmark field and assigning 
limits to the number of network labels to be used.

2. If you want to introduce policy to mediate flow between external and 
internal labeling, do so, but don't change the internal label.

It's not clear to me that you actually need (1) or (2).

It's much simpler to just have two orthogonal labeling schemes.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
