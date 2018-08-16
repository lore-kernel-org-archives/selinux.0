To: Casey Schaufler <casey.schaufler@intel.com>,
 kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 SMACK-discuss@lists.01.org, dave.hansen@intel.com,
 deneen.t.dock@intel.com, kristen@linux.intel.com, arjan@linux.intel.com
References: <20180815235355.14908-1-casey.schaufler@intel.com>
 <20180815235355.14908-6-casey.schaufler@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0b383282-1369-79e9-d111-f03e2897660e@tycho.nsa.gov>
Date: Thu, 16 Aug 2018 10:12:58 -0400
MIME-Version: 1.0
In-Reply-To: <20180815235355.14908-6-casey.schaufler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH RFC 5/5] SELinux: Support SELinux determination of
 side-channel vulnerability
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/15/2018 07:53 PM, Casey Schaufler wrote:
> SELinux considers tasks to be side-channel safe if they
> have PROCESS_SHARE access.
> 
> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> ---
>   security/selinux/hooks.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a8bf324130f5..7fbd7d7ac1cb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4219,6 +4219,14 @@ static void selinux_task_to_inode(struct task_struct *p,
>   	spin_unlock(&isec->lock);
>   }
>   
> +static int selinux_task_safe_sidechannel(struct task_struct *p)
> +{
> +	struct av_decision avd;
> +
> +	return avc_has_perm_noaudit(&selinux_state, current_sid(), task_sid(p),
> +				    SECCLASS_PROCESS, PROCESS__SHARE, 0, &avd);
> +}

If you are going to apply this kind of check, is there a reason you 
wouldn't just use the ptrace checking logic?  Just call 
ptrace_may_access() with PTRACE_MODE_READ and dispense with having a 
separate hook altogether.  Then you get uids/gids, caps, dumpable, and 
security module checking for free.

Regardless, I don't think share permission is the right answer here; it 
has very different semantics and security implications, and is almost 
never allowed in Android policy (just one instance for kernel->init 
transition).

> +
>   /* Returns error only if unable to parse addresses */
>   static int selinux_parse_skb_ipv4(struct sk_buff *skb,
>   			struct common_audit_data *ad, u8 *proto)
> @@ -7002,6 +7010,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
>   	LSM_HOOK_INIT(task_kill, selinux_task_kill),
>   	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
> +	LSM_HOOK_INIT(task_safe_sidechannel, selinux_task_safe_sidechannel),
>   
>   	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
>   	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
> 
