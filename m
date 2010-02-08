Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o18FBumG020681
	for <selinux@tycho.nsa.gov>; Mon, 8 Feb 2010 10:11:56 -0500
Received: from g4t0017.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o18FC4MY017069
	for <selinux@tycho.nsa.gov>; Mon, 8 Feb 2010 15:12:04 GMT
From: Paul Moore <paul.moore@hp.com>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Subject: Re: MLS and network
Date: Mon, 8 Feb 2010 10:11:53 -0500
Cc: selinux@tycho.nsa.gov
References: <20100204174901.GL1750@myhost.felk.cvut.cz> <201002051547.27944.paul.moore@hp.com> <20100207181016.GS1750@myhost.felk.cvut.cz>
In-Reply-To: <20100207181016.GS1750@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201002081011.53221.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 07 February 2010 01:10:16 pm Michal Svoboda wrote:
> Paul Moore wrote:
> > The default setting is part of the SELinux policy using an "initial
> > SID" and isn't something you probably want to modify.  I would
> > recommend using semanage to set the interfaces individually.
> 
> I don't think this is such a good idea. The rule should be "what's not
> allowed, is denied". Now all interfaces that the user sticks in get
> implicitly s0-s15 and, perhaps even worse, since they have to be
> reconfigured from userspace, there would be a slight delay until that
> happens, even if done by udev-launched script. Moreover, interfaces can
> be labeled anyhow, so pre-semanaging eth0 through say eth99 is only a
> partial solution, let alone clumsy.

Well, keep in mind that once you label the interface via semanage, on 
subsequent reboots it takes effect before the network is brought up (it 
happens during policy load) so you don't really have to worry about any race 
conditions.  However, you do make a good point about interface naming, but I 
would suspect that anyone who is interested in running the strict/MLS 
SELinux policy is also tightly controlling physical access to the machine 
and binding interface names/configuration to the physical MAC address which 
means problems caused by new or mis-named interfaces are not a real concern.

> > Dynamic permission checks.  If you don't have any type of labeled
> > networking configuration present the permission checks are disabled
> > inside the kernel.  It may seem odd right now, but trust me, this is a
> > very good thing.
> 
> I agree, this is odd and brutally contra-intuitive. We're speaking about
> egress checks (due to BLP) but we need to configure ingress labeling?
> (And even of a fallthrough kind?) What's the reasoning behind this?

So let me get this straight ... you are very concerned about what 
information leaves your system over what physical network, but you don't 
care at all about the information coming into your system?  That seems odd 
to me.  The SELinux network access controls are dynamic and assume that 
those who wish to use them want to enforce access controls on traffic both 
leaving and entering the system.

> There's one more question, if I may. It appears to me that secmark and
> netlabel, when confronted with normal (ie. non-CIPSO, etc) traffic,
> provide redundant ways to label ingress packets. (Netlabel has fewer
> options but it too operates on a per-packet basis.) Is this so, and if,
> are there plans for unification?

This next point may sound minor, but trust me it is important: the per-
packet labels provided by secmark do not represent the same security 
attributes as the per-packet labels provided by NetLabel (or labeled IPsec 
for that matter).  The secmark labels represent the IP attributes of the 
packet, e.g. IP addresses, while the NetLabel and labeled IPsec labels, 
called network peer labels, represent the security attributes of the sender, 
e.g. apache_t.  Because these two different types of labels represent 
different packet attributes they will not be unified.  There was a _lot_ of 
discussion about this several years ago (search for "secid reconciliation" 
or similar) and the general consensus at the end was that unification would 
be a mistake.  However, we have unified/reconciled the different peer label 
controls (NetLabel and Labeled IPsec) over the years and I think that has 
worked our fairly well, at least I'm happy with it anyway :)

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
