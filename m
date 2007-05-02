Subject: Re: [RFC] Ability to allow unknown class and permissions -v4
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>
In-Reply-To: <1178130337.3897.14.camel@dhcp59-235.rdu.redhat.com>
References: <1178130337.3897.14.camel@dhcp59-235.rdu.redhat.com>
Content-Type: text/plain
Date: Wed, 02 May 2007 15:34:19 -0400
Message-Id: <1178134459.3443.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-02 at 14:25 -0400, Eric Paris wrote:
> I need 4+ RFC's for a small patch, I'm sure everyone is tired of this
> darn thing.  But this is a possibly a finished kernel patch (against
> linus git as of today) to allow a policy flag to specify how the kernel
> should handle a policy which does not cover all of the potential kernel
> checks.  The three options are
> 
> 0 - allow the policy to load but deny all checks (applies to old policy)
> 1 - reject the policy.  load return with EINVAL
> 2 - allow the policy to load and allow all unknown checks
> 
> Note that since the flags in old policy are all zero (outside of the MLS
> flag) running an old policy on a new kernel means there will be no
> behavioral change from how things are today.  I'm still fighting with
> userspace and should have those patches out soon, but as of this moment
> I've been testing by using a hex editor on the policy.21 by hand,
> changing the flags, and then rebooting.  (If I use any userspace tools
> like load_policy it is blanking the flags on me)  All three options seem
> to be working as expected.  But I do need a lot more testing especially
> to make sure everything works when i switch between the options on
> reloads.  
> 
> -Eric
> 
> ---
> 
>  security/selinux/ss/policydb.c |    4 ++
>  security/selinux/ss/policydb.h |   13 +++++++
>  security/selinux/ss/services.c |   79 ++++++++++++++++++++++++++++++++++------
>  3 files changed, 85 insertions(+), 11 deletions(-)

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 40660ff..17c293c 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -322,6 +316,40 @@ static int context_struct_compute_av(struct context *scontext,
>  	avd->seqno = latest_granting;
>  
>  	/*
> +	 * Check if the class in question is a kernel class and if it
> +	 * is defined in policy.  If yes to both it will pad the allow
> +	 * for undefined perms if appropriate.
> +	 */
> +	if (unlikely(!tclass))
> +		goto inval_class;
> +	if (unlikely(tclass > policydb.p_classes.nprim)) {
> +		if (tclass > kdefs->cts_len || (policydb.handle_unknown == DENY_UNKNOWN))
> +			goto inval_class;
> +		/* 
> +		 * kernel class not in policy, but we
> +		 * allow unknown, so let everything through
> +		 */
> +		if (kdefs->class_to_string[tclass - 1]) {
> +			avd->allowed = 0xffffffff;
> +			return 0;
> +		}

Do you need to special case this vs. just filling in
policydb.undefined_perms[] with ~0UL when the kernel class is not in
policy and using it always?  With some rearrangement of the code to
avoid duplication?
Especially since you allocate the array to the number of kernel classes.

> +		/* 
> +		 * this is a 'hole' in policy where a userspace
> +		 * class exists
> +		 */
> +		goto inval_class;
> +	}
> +	if (tclass < kdefs->cts_len && (policydb.handle_unknown == ALLOW_UNKNOWN))
> +		/* 
> +		 * kernel class, defined in policy, allow unknown.
> +		 * might have undefined permissions, so default 
> +		 * those perms to allow
> +		 */
> +		avd->allowed = policydb.undefined_perms[tclass - 1];
> +
> +	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> +
> +	/*
>  	 * If a specific type enforcement rule was defined for
>  	 * this permission check, then use it.
>  	 */
> @@ -387,6 +415,10 @@ static int context_struct_compute_av(struct context *scontext,
>  	}
>  
>  	return 0;
> +
> +inval_class:
> +	printk(KERN_ERR "security_compute_av:  unrecognized class %d\n", tclass);
> +	return -EINVAL;
>  }
>  
>  static int security_validtrans_handle_fail(struct context *ocontext,
> @@ -1054,6 +1086,13 @@ static int validate_classes(struct policydb *p)
>  	const char *def_class, *def_perm, *pol_class;
>  	struct symtab *perms;
>  
> +	if (p->handle_unknown == ALLOW_UNKNOWN) {
> +		u32 num_classes = kdefs->cts_len;
> +		p->undefined_perms = kcalloc(num_classes, sizeof(u32), GFP_KERNEL);
> +		if (!p->undefined_perms)
> +			return -ENOMEM;
> +	}
> +
>  	for (i = 1; i < kdefs->cts_len; i++) {
>  		def_class = kdefs->class_to_string[i];
>  		if (!def_class)
> @@ -1062,6 +1101,8 @@ static int validate_classes(struct policydb *p)
>  			printk(KERN_INFO
>  			       "security:  class %s not defined in policy\n",
>  			       def_class);
> +			if (p->handle_unknown == REJECT_UNKNOWN)
> +				return -EINVAL;

e.g. set  p->undefined_perms[i-1] = ~0UL; here.

>  			continue;
>  		}
>  		pol_class = p->p_class_val_to_name[i-1];
> @@ -1087,14 +1128,22 @@ static int validate_classes(struct policydb *p)
>  			printk(KERN_INFO
>  			       "security:  permission %s in class %s not defined in policy\n",
>  			       def_perm, pol_class);
> +			if (p->handle_unknown == ALLOW_UNKNOWN)
> +				p->undefined_perms[class_val-1] |= perm_val;
> +			else if (p->handle_unknown == REJECT_UNKNOWN)
> +				return -EINVAL;
>  			continue;
>  		}
>  		perdatum = hashtab_search(perms->table, def_perm);
>  		if (perdatum == NULL) {
> -			printk(KERN_ERR
> +			printk(KERN_INFO
>  			       "security:  permission %s in class %s not found in policy\n",
>  			       def_perm, pol_class);
> -			return -EINVAL;
> +			if (p->handle_unknown == ALLOW_UNKNOWN)
> +				p->undefined_perms[class_val-1] |= perm_val;
> +			else if (p->handle_unknown == REJECT_UNKNOWN)
> +				return -EINVAL;
> +			continue;

I think this likely has to stay fatal, and may reflect a problem with
the tristate flag idea.  Here we have a case where the permission value
was defined in the policy but the string name was not, suggesting a
disruption in the access vector definitions (e.g. re-use of the
permission bit?  removal or addition of earlier permissions causing
displacement?).

>  		}
>  		pol_val = 1 << (perdatum->value - 1);
>  		if (pol_val != perm_val) {
> @@ -1130,14 +1179,22 @@ static int validate_classes(struct policydb *p)
>  				printk(KERN_INFO
>  				       "security:  permission %s in class %s not defined in policy\n",
>  				       def_perm, pol_class);
> +				if (p->handle_unknown == ALLOW_UNKNOWN)
> +					p->undefined_perms[class_val-1] |= (1 << j);
> +				else if (p->handle_unknown == REJECT_UNKNOWN)
> +					return -EINVAL;
>  				continue;
>  			}
>  			perdatum = hashtab_search(perms->table, def_perm);
>  			if (perdatum == NULL) {
> -				printk(KERN_ERR
> +				printk(KERN_INFO
>  				       "security:  permission %s in class %s not found in policy\n",
>  				       def_perm, pol_class);
> -				return -EINVAL;
> +				if (p->handle_unknown == ALLOW_UNKNOWN)
> +					p->undefined_perms[class_val-1] |= (1 << j);
> +				else if (p->handle_unknown == REJECT_UNKNOWN)
> +					return -EINVAL;
> +				continue;

Ditto.

>  			}
>  			if (perdatum->value != j + 1) {
>  				printk(KERN_ERR
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
