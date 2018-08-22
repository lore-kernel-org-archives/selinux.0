Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7MHn5kE025395
 for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2018 13:49:05 -0400
From: "Schaufler, Casey" <casey.schaufler@intel.com>
To: Jann Horn <jannh@google.com>
CC: Kernel Hardening <kernel-hardening@lists.openwall.com>, kernel list
 <linux-kernel@vger.kernel.org>, linux-security-module
 <linux-security-module@vger.kernel.org>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "Hansen, Dave" <dave.hansen@intel.com>, "Dock,
 Deneen T" <deneen.t.dock@intel.com>, "kristen@linux.intel.com"
 <kristen@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>
Date: Wed, 22 Aug 2018 17:48:02 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC673214407ED@ORSMSX107.amr.corp.intel.com>
References: <20180821000444.7004-1-casey.schaufler@intel.com>
 <20180821000444.7004-4-casey.schaufler@intel.com>
 <CAG48ez1D-DPBP8ACA1W5=XZLNKUeVj7ZOGUG8uJ2nL1xOSR_9Q@mail.gmail.com>
 <99FC4B6EFCEFD44486C35F4C281DC673214402D3@ORSMSX107.amr.corp.intel.com>
 <CAG48ez3bh5cFgZ5ZY63pszTV+KX+KC4utRCm7E8en+uF5w6vKw@mail.gmail.com>
 <99FC4B6EFCEFD44486C35F4C281DC67321440770@ORSMSX107.amr.corp.intel.com>
 <CAG48ez3OkpcrC34LJTWAvH4ZvREW7jDVkeMBZrLQe6cRSEBheg@mail.gmail.com>
In-Reply-To: <CAG48ez3OkpcrC34LJTWAvH4ZvREW7jDVkeMBZrLQe6cRSEBheg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: RE: [PATCH v3 3/5] LSM: Security module checking for side-channel
 dangers
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> -----Original Message-----
> From: Jann Horn [mailto:jannh@google.com]
> Sent: Wednesday, August 22, 2018 10:04 AM
> To: Schaufler, Casey <casey.schaufler@intel.com>
> Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>; kernel list
> <linux-kernel@vger.kernel.org>; linux-security-module <linux-security-
> module@vger.kernel.org>; selinux@tycho.nsa.gov; Hansen, Dave
> <dave.hansen@intel.com>; Dock, Deneen T <deneen.t.dock@intel.com>;
> kristen@linux.intel.com; Arjan van de Ven <arjan@linux.intel.com>
> Subject: Re: [PATCH v3 3/5] LSM: Security module checking for side-channel
> dangers
> 
> [SNIP]

> > Yes, but in a different namespace. Hence the namespace check.
> >
> > What I hear you saying is that you don't want the capability check
> > to be independent of the namespace check.
> 
> The capability check doesn't always require a namespace match, and I
> don't care about non-user namespaces here, but I would prefer it if
> A->B with A having some capabilities required A's user namespace to be
> ancestor-or-self of B's user namespace. But alternatively:

Looking at ancestor relations starts to get us pretty close to the
point where the cost of checking will overwhelm the savings. This
is something we have to be very careful of.

> > This conflicts with the
> > strong desire expressed to me when I started this that the configuration
> > should be flexible. I can beef up the description of the various options.
> > Would that address the issue?
> 
> It seems to me that it would make sense to express this as something
> like a Kconfig dependency.

I thought about that. It could be the best choice. I will investigate
further.

> But I guess if you document that the
> combination of CONFIG_USER_NS=y,
> CONFIG_SECURITY_SIDECHANNEL_NAMESPACES=n and
> SECURITY_SIDECHANNEL_CAPABILITIES=y is nonsensical, that works too. I
> just don't see why you'd want to provide such a footgun?

Point.

> Configurability is nice, but if we know that one of the possible
> configurations doesn't make sense, it seems like a good idea to just
> not allow the system to be configured that way.

Another point.

> You say that you were asked to make the configuration flexible. Did
> whoever told you that actually want the ability to compare raw
> capability sets on a system with CONFIG_USER_NS=y, and understand what
> semantics that has (and doesn't have)? Or was their intent more along
> the lines of "we want to flush if the new task has higher privileges,
> capability-wise, than the old task; but we don't explicitly care about
> namespaces"?

Without going into too much detail, it's a matter of people who
understand chips and performance better than they understand
security or the user experience.
