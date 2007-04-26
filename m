Subject: Re: [RFC] Ability to allow undefined permissions and classes -v3
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, csellers@tresys.com
In-Reply-To: <1177537171.4221.25.camel@dhcp59-235.rdu.redhat.com>
References: <1177537171.4221.25.camel@dhcp59-235.rdu.redhat.com>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 09:00:02 -0400
Message-Id: <1177592402.24282.310.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-25 at 17:39 -0400, Eric Paris wrote:
> After many months this RFC is back again!  Still has the selinuxfs
> boolean to turn it on and off that will get changed to a policy option
> when the actual functionality seems reasonable to everyone.  The only
> change between -v2 and -v3 is in context_struct_compute_av().  In wake
> of the last discussion I had to make the class checking more stringent
> so I wouldn't be allowing userspace classes.  Previously the decision
> for an 'unknown class' was anything larger than the last defined in
> policy.  Now it should be a bit more kernel specific and should check
> 
> less than policy
> greater than policy but less than number of kernel classes
> greater than policy and greater than number of kernel classes
> 
> less than policy means it is defined in policy and so just deal with the
> permissions.  greater than both means its invalid.  So the case in the
> middle is interesting if the request is actually 'hole' in the kernel
> defs because of the removal of userspace classes.  So that check makes
> it a little more complex.  Until the userspace class definitions
> actually turn to NULL in kernel this isn't 'perfect' and might mistake a
> userspace class for a kernel class but that should only temporarily
> (until the classes are actually gone which will likely be the case when
> this patch is applied) affect selinuxfs answers.

You can assume the userspace classes to be removed for your patch, as
the removal patch has been submitted upstream.

> I think what this means though is that I don't need a special call from
> selinuxfs to answer access questions.  If the request from selinuxfs is
> asking about kernel permissions it will get exactly the answer the
> kernel would have made.  If the check is about userspace permissions it
> will answer as best the policy knows but the 'allow unknown' stuff won't
> change that answer since it only mucks with things defined by the kdefs.
> 
> I do have a question if my method of storing an array of size
> kdefs->cts_len is going to work going forward.  How is the policy going
> to grow?  Will we have gaps of potentially hundreds of classes and then
> add a new kernel class?  If so I will have a large waste in my array.
> Its already the case that this proposed array is wasting space for all
> of the userspace classes as it stands.

With the userspace class/perm discovery support (in progress by Chris,
and libselinux already provides the interfaces for looking them up from
string), we should be able to easily relocate userspace classes in the
future to allow insertion of kernel classes before any further userspace
classes.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 1e52356..03728fa 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -59,6 +59,7 @@
>  
>  extern void selnl_notify_policyload(u32 seqno);
>  unsigned int policydb_loaded_version;
> +int selinux_allow_unknown = 0;

Just to note, this will become a policydb flag rather than a global when
you turn this behavior into a policy config option.  And a tristate,
right?  reject-policy-at-load, accept-policy-but-deny-unknown,
accept-policy-and-allow-unknown

> @@ -323,6 +318,39 @@ static int context_struct_compute_av(struct context *scontext,
>  	avd->seqno = latest_granting;
>  
>  	/*
> +	 * Check if the class in question is a kernel class and if it
> +	 * is defined in policy.  If yes to both it will pad the allow
> +	 * for undefined perms if appropriete.

Spelling.

> +	 */
> +	if (unlikely(!tclass)) {
> +		printk(KERN_ERR "security_compute_av:  unrecognized class 0");
> +		return -EINVAL;
> +	}
> +	if (unlikely(tclass > policydb.p_classes.nprim)) {
> +		if (tclass > kdefs->cts_len || !selinux_allow_unknown) {
> +			printk(KERN_ERR "security_compute_av:  unrecognized ",
> +				"class %d\n", tclass);
> +			return -EINVAL;
> +		} else {

As the if clause always returns, no need for explicit else, just fall
through.

> +			/* 
> +			 * kernel class not in policy, but we
> +			 * allow uknown, so let everything through

Spelling.

> +			 */
> +			avd->allowed = 0xffffffff;
> +			return 0;
> +		}
> +	} else

As both clauses of the if clause always return, no need for explicit
else, just fall through.

> @@ -1079,14 +1114,18 @@ static int validate_classes(struct policydb *p)
>  			printk(KERN_INFO
>  			       "security:  permission %s in class %s not defined in policy\n",
>  			       def_perm, pol_class);
> +			if (selinux_allow_unknown)
> +				p->undefined_perms[class_val-1] |= perm_val;
>  			continue;
>  		}
>  		perdatum = hashtab_search(perms->table, def_perm);
>  		if (perdatum == NULL) {
> -			printk(KERN_ERR
> +			printk(KERN_INFO
>  			       "security:  permission %s in class %s not found in policy\n",
>  			       def_perm, pol_class);
> -			return -EINVAL;
> +			if (selinux_allow_unknown)
> +				p->undefined_perms[class_val-1] |= perm_val;

In the reject-policy case, you'd want to still return -EINVAL here and
reject policy at load time.

> +			continue;
>  		}
>  		pol_val = 1 << (perdatum->value - 1);
>  		if (pol_val != perm_val) {
> @@ -1122,14 +1161,18 @@ static int validate_classes(struct policydb *p)
>  				printk(KERN_INFO
>  				       "security:  permission %s in class %s not defined in policy\n",
>  				       def_perm, pol_class);
> +				if (selinux_allow_unknown)
> +					p->undefined_perms[class_val-1] |= (1 << j);
>  				continue;
>  			}
>  			perdatum = hashtab_search(perms->table, def_perm);
>  			if (perdatum == NULL) {
> -				printk(KERN_ERR
> +				printk(KERN_INFO
>  				       "security:  permission %s in class %s not found in policy\n",
>  				       def_perm, pol_class);
> -				return -EINVAL;
> +				if (selinux_allow_unknown)
> +					p->undefined_perms[class_val-1] |= (1 << j);

Ditto.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
