Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1DM2HLF018530
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 17:02:17 -0500
Received: from g1t0029.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1DM2FAu010410
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 22:02:16 GMT
From: Paul Moore <paul.moore@hp.com>
To: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: [refpolicy] [PATCH] refpolicy: Add missing network related MLSconstraints
Date: Fri, 13 Feb 2009 17:02:10 -0500
Cc: chanson@TrustedCS.com, refpolicy@oss.tresys.com, selinux@tycho.nsa.gov
References: <20090212211531.619341973@hp.com> <200902131544.42460.paul.moore@hp.com> <4995E83B.1040003@sun.com>
In-Reply-To: <4995E83B.1040003@sun.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902131702.10467.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 13 February 2009 04:38:03 pm Glenn Faden wrote:
> Paul Moore wrote:
> > On Friday 13 February 2009 02:36:17 pm chanson@trustedcs.com wrote:
> >> Traditionally network objects in a MLS system are not usually subject to
> >> the usual privilege overrides. I would propose something like the below:
> >>
> >> mlsconstrain { netif } { egress ingress }
> >> 	((( l1 dom l2 ) and ( l1 domby h2 )) or
> >> 	 ( t1 == mlsnetflow ));
> >> mlsconstrain { node } { recvfrom sendto }
> >> 	((( l1 dom l2 ) and ( l1 domby h2 )) or
> >> 	 ( t1 == mlsnetflow ));
> >> mlsconstrain { packet } { forward_in forward_out }
> >> 	((( l1 dom l2 ) and ( l1 domby h2 )) or
> >> 	 ( t1 == mlsnetflow ));
> >>
> >> "mlsnetflow" would be a new attribute useful for special cases like
> >> unlabeled_t or kernel_t.
> >
> > Why were network objects not subject to privilege overrides in
> > legacy/traditional MLS systems?
> >
> > I ask because I think we are best off keeping the MLS constraints as
> > consistent as possible.  If there is a sound reason for avoiding policy
> > overrides for just the network controls than perhaps we should consider
> > "fixing" the rest of the constraints and not just the new ones.
>
> I can provide a bit of history about some legacy systems. In Trusted
> Solaris 8 there was a privilege, net_mac_read, that allowed a server to
> accept connections from clients with labels it didn't dominate. In order
> to reply, the server either needed to set the socket label to match the
> incoming client's label, or assert the privilege net_reply_equal. There
> was no corresponding net_mac_write privilege, because privilege programs
> were expected to use the network API to set their socket labels
> appropriately.

Thanks, that is good to know.

> In Solaris Trusted Extensions, neither the net_mac_read, net_mac_write,
> nor net_repy_equal privileges are implemented. It was viewed as a
> weakness in Trusted Solaris that MAC could be overridden by privilege.
> Instead, the administrator (who configures the system network policy)
> can enumerate multilevel network ports, and appropriately privileged
> services can bind to them.

I assume by multilevel network ports you are talking about port 
polyinstantiation and not a single (in every sense of the word) port that 
allows a range of labels?

If we assume polyports then I agree that it makes perfect sense to try and 
work around the MLS constraints.  I wonder about some privileged apps but I 
would need to think about that some more.

> Since MLS constraints are relatively new to UNIX, there isn't a
> compatibility requirement that the superuser should be able to override
> it. So don't provide any more rope than you need to.

Well, the MLS constraints aren't all that new to SELinux and several already 
exist in the networking space (the patch above didn't create any new ones, 
just used the existing constraints).  As I understand it, the SELinux 
constraints are also quite different from the TSOL/TX privileges; I'll concede 
that they are both rope, but I think the lengths are quite different ;)

Perhaps I'm missing something but I'm pretty sure that without any form of 
polyports (I highly doubt we will see these anytime soon) we are going to 
need/want network MLS constraint overrides.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
