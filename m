To: Casey Schaufler <casey.schaufler@intel.com>,
 kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 dave.hansen@intel.com, deneen.t.dock@intel.com,
 kristen@linux.intel.com, arjan@linux.intel.com
References: <20180817221624.10232-1-casey.schaufler@intel.com>
 <20180817221624.10232-6-casey.schaufler@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6e70b7c7-d932-91c8-35d1-70bd6cef16a5@tycho.nsa.gov>
Date: Mon, 20 Aug 2018 12:02:53 -0400
MIME-Version: 1.0
In-Reply-To: <20180817221624.10232-6-casey.schaufler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH RFC v2 5/5] SELinux: Support SELinux determination of
 side-channel vulnerability
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/17/2018 06:16 PM, Casey Schaufler wrote:
> SELinux considers tasks to be side-channel safe if they
> have PROCESS_SHARE access.

Now the description and the code no longer match.

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
> +				    SECCLASS_FILE, FILE__READ, 0, &avd);
> +}

And my question from before still stands:  why do we need a new hook and 
new security module instead of just using ptrace_may_access()?

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
