Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8SGY4Mn019819
 for <selinux@tycho.nsa.gov>; Fri, 28 Sep 2018 12:34:05 -0400
Date: Sat, 29 Sep 2018 02:33:20 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Jann Horn <jannh@google.com>
cc: Casey Schaufler <casey.schaufler@intel.com>,
 Casey Schaufler <casey@schaufler-ca.com>, kristen@linux.intel.com,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 deneen.t.dock@intel.com, kernel list <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 selinux@tycho.nsa.gov, Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <CAG48ez3Jnao-5z3O8s=RdoAx8=b68C_1pfKNKJSm+6R_HyU_fg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1809290233130.15725@namei.org>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-6-casey.schaufler@intel.com>
 <alpine.LRH.2.21.1809280744560.8410@namei.org>
 <025d4742-5947-545e-f603-502a0c5ee03f@schaufler-ca.com>
 <alpine.LRH.2.21.1809280846280.8410@namei.org>
 <99FC4B6EFCEFD44486C35F4C281DC67321463CE3@ORSMSX107.amr.corp.intel.com>
 <alpine.LRH.2.21.1809280936290.13517@namei.org>
 <CAG48ez3Jnao-5z3O8s=RdoAx8=b68C_1pfKNKJSm+6R_HyU_fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH v5 5/5] sidechannel: Linux Security Module for sidechannel
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 28 Sep 2018, Jann Horn wrote:

> > so with this hard-coded logic, you are saying this case is
> > 'safe' in a sidechannel context.
> >
> > Which hints at the deeper issue that containers are a userland
> > abstraction.  Protection of containers needs to be defined by userland
> > policy.
> 
> Or just compare mount namespaces additionally/instead. I think that
> containers will always use those, because AFAIK nobody uses chroot()
> for containers, given that the kernel makes absolutely no security
> guarantees about chroot().

We can't define this in the kernel. It has no concept of containers.

People utilize some combination of namespaces and cgroups and call them 
containers, but we can't make assumptions from the kernel on what any of 
this means from a security point of view, and hard-code kernel policy 
based on those assumptions.

This is violating the principal of separating mechanism and policy, and 
also imposing semantics across the kernel/user boundary. The latter 
creates an ABI which we can then never break.


-- 
James Morris
<jmorris@namei.org>
