Subject: Re: [PATCH] LSM: Reorder security_capset to do access checks properly
To: Casey Schaufler <casey@schaufler-ca.com>,
 LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>
References: <0243a591-a6e1-8827-3f03-884c3ad331d0@schaufler-ca.com>
Cc: LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <439266f9-6431-4c59-db2e-7eb48d49aaf8@tycho.nsa.gov>
Date: Wed, 1 Jun 2016 16:06:53 -0400
MIME-Version: 1.0
In-Reply-To: <0243a591-a6e1-8827-3f03-884c3ad331d0@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/01/2016 03:27 PM, Casey Schaufler wrote:
> Subject: [PATCH] LSM: Reorder security_capset to do access checks properly
> 
> The security module hooks that check whether a process should
> be able to set a new capset are currently called after the new
> values are set in cap_capset(). This change reverses the order.
> The capability module no longer adds cap_capset to the module list.
> Instead, it is invoked directly by the LSM infrastructure.
> This isn't an approach that generalizes well.

Is this change necessary?  The fact that cap_capset() modifies new
before the other hooks are called does no harm, because if any hook
returns an error, then the caller returns that error and never commits
the new cred.  It is actually possibly beneficial for the other security
hooks to be called after cap_capset() so that they can adjust the new
values if desired (e.g. to reduce them) before they are finally committed.

> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/commoncap.c |  2 +-
>  security/security.c  | 24 ++++++++++++++++++++++--
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 48071ed..f5bce18 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1073,7 +1073,7 @@ struct security_hook_list capability_hooks[] = {
>  	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, cap_ptrace_traceme),
>  	LSM_HOOK_INIT(capget, cap_capget),
> -	LSM_HOOK_INIT(capset, cap_capset),
> +	/* Carefull! Do not include cap_capset! */
>  	LSM_HOOK_INIT(bprm_set_creds, cap_bprm_set_creds),
>  	LSM_HOOK_INIT(bprm_secureexec, cap_bprm_secureexec),
>  	LSM_HOOK_INIT(inode_need_killpriv, cap_inode_need_killpriv),
> diff --git a/security/security.c b/security/security.c
> index 92cd1d8..1610be8 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -177,8 +177,28 @@ int security_capset(struct cred *new, const struct cred *old,
>  		    const kernel_cap_t *inheritable,
>  		    const kernel_cap_t *permitted)
>  {
> -	return call_int_hook(capset, 0, new, old,
> -				effective, inheritable, permitted);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	/*
> +	 * Special case handling because the "new" capabilities
> +	 * should not be set until it has been determined that
> +	 * all modules approve of the change. Passing NULL pointers
> +	 * to all modules except the capabilty module as it is
> +	 * expected that only the capability modules needs the
> +	 * result pointers.
> +	 *
> +	 * cap_capset() must not be in the capability module hook list!
> +	 */
> +	list_for_each_entry(hp, &security_hook_heads.capset, list) {
> +		rc = hp->hook.capset(new, old, NULL, NULL, NULL);
> +		if (rc != 0)
> +			return rc;
> +	}
> +	/*
> +	 * Call cap_capset now to update the new capset.
> +	 */
> +	return cap_capset(new, old, effective, inheritable, permitted);
>  }
>  
>  int security_capable(const struct cred *cred, struct user_namespace *ns,
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
