Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1ALoEKt005712
	for <selinux@tycho.nsa.gov>; Wed, 10 Feb 2010 16:50:15 -0500
Received: from g1t0028.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1ALo2Ps014164
	for <selinux@tycho.nsa.gov>; Wed, 10 Feb 2010 21:50:02 GMT
From: Paul Moore <paul.moore@hp.com>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Subject: Re: MLS and network
Date: Wed, 10 Feb 2010 16:50:11 -0500
Cc: selinux@tycho.nsa.gov
References: <20100204174901.GL1750@myhost.felk.cvut.cz> <201002081011.53221.paul.moore@hp.com> <20100210062729.GW1750@myhost.felk.cvut.cz>
In-Reply-To: <20100210062729.GW1750@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201002101650.11790.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 10 February 2010 01:27:29 am Michal Svoboda wrote:
> Paul Moore wrote:
> > Well, keep in mind that once you label the interface via semanage, on
> > subsequent reboots it takes effect before the network is brought up
> > (it happens during policy load) so you don't really have to worry
> > about any race conditions.  However, you do make a good point about
> > interface naming, but I would suspect that anyone who is interested in
> > running the strict/MLS SELinux policy is also tightly controlling
> > physical access to the machine and binding interface
> > names/configuration to the physical MAC address which means problems
> > caused by new or mis-named interfaces are not a real concern.
> 
> There are also software interfaces like tunnels and taps, and god knows
> what else (you can even run a ppp interface over a ssh session).

Yes, but I don't understand how those are relevant to network interface 
labeling as discussed in my response to you (above).

> At some point it might just be that they are all pinned down and tightly
> controlled, but why have to do all this *just because* the default is
> systemhigh and not *in addition to* a sane systemlow default?

Controlling access to an application and controlling access to the network 
are two different access decisions in SELinux.

> Isn't a longish list of semanaged interfaces just a more volatile version
> of a low default?

I imagine it depends on your perspective.  It doesn't bother me but it is 
apparent that bothers you a great amount.

> > So let me get this straight ... you are very concerned about what
> > information leaves your system over what physical network, but you
> > don't care at all about the information coming into your system?  That
> > seems odd to me.  The SELinux network access controls are dynamic and
> > assume that those who wish to use them want to enforce access controls
> > on traffic both leaving and entering the system.
> 
> If you just want to protect confidential data in your box then strictly
> speaking yes! egress traffic is everything you need to worry about (at
> least network-wise).

To be honest with my perspective: I suspect that the number of people 
interested in an "egress only" SELinux network access control solution are 
extremely rare, so much so that I think it might be hurtful to the rest of 
the users to change things just for this one particular use case.

> Second, I'm not quite sure if I understand why defining a *fallback*
> label is necessary to turn on the whole infrastructure. I think that
> the fallback label is not that much necessary in most situations.

Okay, I'm not going to try and convince you either way, we both seem to be 
quite comfortable with our opinions.  However, just for the record you can 
active the SELinux labeled networking access controls via the following:

 * Peer Labels
   + Configure a CIPSO DOI definition via NetLabel
   + Configure a static/fallback label mapping via NetLabel
   + Configure a labeled IPsec SPD entry via labeled IPsec

 * Secmark Labels
   + Configure a iptables/netfilter rule with a SECMARK target

> If I wanted to implement a MLS network then my first shot would be to
> designate a separate interface for s1 traffic. Thus my eth1 would have
> s1 and I wouldn't need a fallback label there.

If you wanted incoming traffic to be labeled as "s1" and you weren't using a 
labeling protocol, e.g. CIPSO or labeled IPsec, you would.

> If I wanted to use single interface for multiple levels, I could use the
> CIPSO stuff to mark packets at the sender and yet again I would do
> without fallback labels at the receiver. (I would assume unmarked
> packets as invalid.)

However you would have to configure a CIPSO DOI on the SELinux system which 
would activate the network peer label access controls as stated above.

> Only if I wanted to use a single interface for both unmarked and marked
> traffic I would need to define a fallback label.

Not really, you only need the fallback peer label if you are receiving 
traffic from unlabeled hosts and you want to treat the traffic as peer 
labeled, e.g. talking to Windows hosts.

> > This next point may sound minor, but trust me it is important: the
> > per- packet labels provided by secmark do not represent the same
> > security attributes as the per-packet labels provided by NetLabel (or
> > labeled IPsec for that matter).  The secmark labels represent the IP
> > attributes of the packet, e.g. IP addresses, while the NetLabel and
> > labeled IPsec labels, called network peer labels, represent the
> > security attributes of the sender, e.g. apache_t.
> 
> That's true only when the sender already fills in the netlabel info. My
> point was that netlabel fallback labels can be only configured per IP
> address, but secmark has the whole netfilter infrastructure behind it,
> thus could provide more fine-grained fallback labeling.

You are completely ignoring the fact that the network peer and secmark 
labels are handled differently, i.e. different access controls, by SELinux.  
The fallback peer labels are not designed as a substitute or alternate for 
the secmark labels (the opposite also applies); fallback labels are designed 
as a way to apply network peer label access controls to communications with 
unlabeled hosts.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
