Message-ID: <5321AFD7.4010100@tycho.nsa.gov>
Date: Thu, 13 Mar 2014 09:17:11 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v1] selinux: add transitions for kernel keys
References: <20140312215305.9695.86521.stgit@localhost>
In-Reply-To: <20140312215305.9695.86521.stgit@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mgrepl@redhat.com, eparis@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/12/2014 05:53 PM, Paul Moore wrote:
> Unfortunately, experience has shown that transitions are necessary for
> keys stored in the kernel's keyring; inheriting labels from the
> creating process has shown to result in keys with unpredictable labels
> as the different kernel keyring users race to create new keys.  While
> setkeycreatecon() does exist to allow applications to set the security
> label of newly created keys, it is impractical to modify all keyring
> users to use the SELinux API.  As with several other kernel resources,
> a policy driven transition is the most practical solution.
> 
> This patch adds the necessary transition call and protects it via the
> newly created "keytrans" policy capability.  The policy capability is
> necessary to ensure compatibility with existing policies as the default
> transition behavior is to inherit the target's type information which
> is not the current, or desired, behavior.  For similar reasons, the
> uninitialized behavior of security_compute_sid() has been updated such
> that key objects inherit the subject's label.
> 
> As one might expect, this patch does require an updated userspace to
> create a policy to use this new functionality.  Userspace changes
> would require the addition of the new "keytrans" policy capability and
> most likely a change to the way type transitions are applied to the
> key object class, see below:
> 
>   default_type key source;
> 
> ... this would ensure that newly created keys would inherit the type
> information of the calling process in case a type transition was not
> explicitly defined in policy.  This leads to the SELinux type
> transition statement for the key object class, see below:
> 
>   type_transition <domain> kernel_t:key <new_key_type>
> 
> ... in the case of the key object class, the target type is always the
> kernel's security label, which in the case of the Reference Policy is
> "kernel_t".
> 
> Signed-off-by: XXX
> ---
>  security/selinux/hooks.c            |   21 ++++++++++++++-------
>  security/selinux/include/security.h |    2 ++
>  security/selinux/ss/services.c      |    4 ++++
>  3 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 57b0b49..3ea05b6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5682,18 +5682,25 @@ static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
>  static int selinux_key_alloc(struct key *k, const struct cred *cred,
>  			     unsigned long flags)
>  {
> -	const struct task_security_struct *tsec;
> +	int rc;
> +	const struct task_security_struct *tsec = current_security();
>  	struct key_security_struct *ksec;
> +	u32 sid;
> +
> +	if (tsec->keycreate_sid)
> +		sid = tsec->keycreate_sid;
> +	else if (selinux_policycap_keytrans) {
> +		rc = security_transition_sid(tsec->sid, SECINITSID_KERNEL,
> +					     SECCLASS_KEY, NULL, &sid);

Wouldn't it be more general and help avoid the need for a separate
policy capability and avoid special casing keys, to pass both the
cred->security->sid and the current->security->sid to
security_transition_sid()?

Then you just arrange the sid argument order so that the current default
behavior will be in effect in the absence of any type_transition or
default_type rules?

Also, isn't the use of current_security() here rather than the provided
cred a divergence from the keyring model for DAC, and what implications
exist there?  Why isn't this a problem for their DAC model if it is a
problem for SELinux?

> +		if (rc)
> +			return rc;
> +	} else
> +		sid = tsec->sid;
>  
>  	ksec = kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
>  	if (!ksec)
>  		return -ENOMEM;
> -
> -	tsec = cred->security;
> -	if (tsec->keycreate_sid)
> -		ksec->sid = tsec->keycreate_sid;
> -	else
> -		ksec->sid = tsec->sid;
> +	ksec->sid = sid;
>  
>  	k->security = ksec;
>  	return 0;
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index fe341ae..8460217 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -71,6 +71,7 @@ enum {
>  	POLICYDB_CAPABILITY_OPENPERM,
>  	POLICYDB_CAPABILITY_REDHAT1,
>  	POLICYDB_CAPABILITY_ALWAYSNETWORK,
> +	POLICYDB_CAPABILITY_KEYTRANS,
>  	__POLICYDB_CAPABILITY_MAX
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> @@ -78,6 +79,7 @@ enum {
>  extern int selinux_policycap_netpeer;
>  extern int selinux_policycap_openperm;
>  extern int selinux_policycap_alwaysnetwork;
> +extern int selinux_policycap_keytrans;
>  
>  /*
>   * type_datum properties
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index d106733..4f57007 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -73,6 +73,7 @@
>  int selinux_policycap_netpeer;
>  int selinux_policycap_openperm;
>  int selinux_policycap_alwaysnetwork;
> +int selinux_policycap_keytrans;
>  
>  static DEFINE_RWLOCK(policy_rwlock);
>  
> @@ -1404,6 +1405,7 @@ static int security_compute_sid(u32 ssid,
>  
>  	if (!ss_initialized) {
>  		switch (orig_tclass) {
> +		case SECCLASS_KEY:
>  		case SECCLASS_PROCESS: /* kernel value */
>  			*out_sid = ssid;
>  			break;
> @@ -1815,6 +1817,8 @@ static void security_load_policycaps(void)
>  						  POLICYDB_CAPABILITY_OPENPERM);
>  	selinux_policycap_alwaysnetwork = ebitmap_get_bit(&policydb.policycaps,
>  						  POLICYDB_CAPABILITY_ALWAYSNETWORK);
> +	selinux_policycap_keytrans = ebitmap_get_bit(&policydb.policycaps,
> +						  POLICYDB_CAPABILITY_KEYTRANS);
>  }
>  
>  static int security_preserve_bools(struct policydb *p);
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
> 
