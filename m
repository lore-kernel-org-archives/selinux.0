From: "Schaufler, Casey" <casey.schaufler@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "Hansen, Dave" <dave.hansen@intel.com>, "Dock,
 Deneen T" <deneen.t.dock@intel.com>, "kristen@linux.intel.com"
 <kristen@linux.intel.com>, "arjan@linux.intel.com" <arjan@linux.intel.com>
Date: Mon, 20 Aug 2018 16:59:42 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732143F80E@ORSMSX107.amr.corp.intel.com>
References: <20180817221624.10232-1-casey.schaufler@intel.com>
 <20180817221624.10232-6-casey.schaufler@intel.com>
 <6e70b7c7-d932-91c8-35d1-70bd6cef16a5@tycho.nsa.gov>
In-Reply-To: <6e70b7c7-d932-91c8-35d1-70bd6cef16a5@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: RE: [PATCH RFC v2 5/5] SELinux: Support SELinux determination of
 side-channel vulnerability
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Monday, August 20, 2018 9:03 AM
> To: Schaufler, Casey <casey.schaufler@intel.com>; kernel-
> hardening@lists.openwall.com; linux-kernel@vger.kernel.org; linux-security-
> module@vger.kernel.org; selinux@tycho.nsa.gov; Hansen, Dave
> <dave.hansen@intel.com>; Dock, Deneen T <deneen.t.dock@intel.com>;
> kristen@linux.intel.com; arjan@linux.intel.com
> Subject: Re: [PATCH RFC v2 5/5] SELinux: Support SELinux determination of
> side-channel vulnerability
> 
> On 08/17/2018 06:16 PM, Casey Schaufler wrote:
> > SELinux considers tasks to be side-channel safe if they
> > have PROCESS_SHARE access.
> 
> Now the description and the code no longer match.

You're right.

> >
> > Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> > ---
> >   security/selinux/hooks.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index a8bf324130f5..7fbd7d7ac1cb 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4219,6 +4219,14 @@ static void selinux_task_to_inode(struct
> task_struct *p,
> >   	spin_unlock(&isec->lock);
> >   }
> >
> > +static int selinux_task_safe_sidechannel(struct task_struct *p)
> > +{
> > +	struct av_decision avd;
> > +
> > +	return avc_has_perm_noaudit(&selinux_state, current_sid(),
> task_sid(p),
> > +				    SECCLASS_FILE, FILE__READ, 0, &avd);
> > +}
> 
> And my question from before still stands:  why do we need a new hook and
> new security module instead of just using ptrace_may_access()?

Locking. The SELinux check, for example, will lock up solid while trying
to generate an audit record. There is no good reason aside from coding
convenience to assume that the same restrictions will apply for side-channel
as apply to ptrace. I'm actually a touch surprised you're not suggesting a
separate SECCLASS or access mode for the SELinux hook.

> 
> > +
> >   /* Returns error only if unable to parse addresses */
> >   static int selinux_parse_skb_ipv4(struct sk_buff *skb,
> >   			struct common_audit_data *ad, u8 *proto)
> > @@ -7002,6 +7010,7 @@ static struct security_hook_list selinux_hooks[]
> __lsm_ro_after_init = {
> >   	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
> >   	LSM_HOOK_INIT(task_kill, selinux_task_kill),
> >   	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
> > +	LSM_HOOK_INIT(task_safe_sidechannel,
> selinux_task_safe_sidechannel),
> >
> >   	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
> >   	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
> >
