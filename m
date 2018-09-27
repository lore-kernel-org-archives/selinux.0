From: "Schaufler, Casey" <casey.schaufler@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "Hansen, Dave" <dave.hansen@intel.com>, "Dock,
 Deneen T" <deneen.t.dock@intel.com>, "kristen@linux.intel.com"
 <kristen@linux.intel.com>, "arjan@linux.intel.com" <arjan@linux.intel.com>,
 Paul Moore <paul@paul-moore.com>, "Schaufler, Casey"
 <casey.schaufler@intel.com>
Date: Thu, 27 Sep 2018 16:23:27 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC673214631B5@ORSMSX107.amr.corp.intel.com>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-4-casey.schaufler@intel.com>
 <6e21f471-ff88-c57c-8892-e0bb626bea12@tycho.nsa.gov>
In-Reply-To: <6e21f471-ff88-c57c-8892-e0bb626bea12@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: RE: [PATCH v5 3/5] SELinux: Prepare for PTRACE_MODE_SCHED
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Thursday, September 27, 2018 8:50 AM
> To: Schaufler, Casey <casey.schaufler@intel.com>; kernel-
> hardening@lists.openwall.com; linux-kernel@vger.kernel.org; linux-security-
> module@vger.kernel.org; selinux@tycho.nsa.gov; Hansen, Dave
> <dave.hansen@intel.com>; Dock, Deneen T <deneen.t.dock@intel.com>;
> kristen@linux.intel.com; arjan@linux.intel.com; Paul Moore <paul@paul-
> moore.com>
> Subject: Re: [PATCH v5 3/5] SELinux: Prepare for PTRACE_MODE_SCHED
> 
> On 09/26/2018 04:34 PM, Casey Schaufler wrote:
> > From: Casey Schaufler <casey@schaufler-ca.com>
> >
> > A ptrace access check with mode PTRACE_MODE_SCHED gets called
> > from process switching code. This precludes the use of audit or avc,
> > as the locking is incompatible. The only available check that
> > can be made without using avc is a comparison of the secids.
> > This is not very satisfactory as it will indicate possible
> > vulnerabilies much too aggressively.
> Can you document (in the patch description and/or in the inline
> documentation in lsm_hooks.h) what locks can be safely used when this
> hook is called with PTRACE_MODE_SCHED?  rcu_read_lock() seemingly must
> be safe since it is being called by task_sid() below. Are any other
> locking primitives safe?

Peter Zijlstra <peterz@infradead.org> had this comment on
locking in the SELinux ptrace path. 

 	avc_has_perm_noaudit()
	  security_compute_av()
	    read_lock(&state->ss->policy_rwlock);
	  avc_insert()
	    spin_lock_irqsave();
	  avc_denied()
	    avc_update_node()
	      spin_lock_irqsave();

under the scheduler's raw_spinlock_t, which are invalid lock nestings.

I don't know that it would be impossible to address these issues,
but as many people have noted over the years I am not now
nor have ever been an expert on locking.

> 
> Does the PTRACE_MODE_SCHED check have to occur while holding the
> scheduler lock, or could it be performed before taking the lock?

My understanding is that the lock is required.

 
> Can you cite the commit or patch posting (e.g. from lore or patchwork)
> that defines PTRACE_MODE_SCHED and its usage as part of the patch
> description for context?  Is this based on the v7 patchset, e.g.
> https://lore.kernel.org/lkml/nycvar.YFH.7.76.1809251437340.15880@cbobk.fhf
> r.pm/

Yes, that's the one. Sorry, I should have identified that.

> 
> >
> > Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> > ---
> >   security/selinux/hooks.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index ad9a9b8e9979..160239791007 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2267,6 +2267,8 @@ static int selinux_ptrace_access_check(struct
> task_struct *child,
> >   	u32 sid = current_sid();
> >   	u32 csid = task_sid(child);
> >
> > +	if (mode & PTRACE_MODE_SCHED)
> > +		return sid == csid ? 0 : -EACCES;
> IIUC, this logic is essentially the same as the uid-based check,
> including the fact that even a "privileged" process is not given any
> special handling since they always return false from ptrace_has_cap()
> for PTRACE_MODE_SCHED. If they are ok with applying IBPB whenever uids
> differ, then doing so whenever sids/contexts differ does not seem like
> an onerous thing.
> 
> 
> >   	if (mode & PTRACE_MODE_READ)
> >   		return avc_has_perm(&selinux_state,
> >   				    sid, csid, SECCLASS_FILE, FILE__READ,
> NULL);
> >
