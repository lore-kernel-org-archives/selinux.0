Subject: Re: [PATCH] kernel: selinux: policy selectable handling of unknown
	classes and perms
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1185983352.3673.16.camel@localhost.localdomain>
References: <1185983352.3673.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 15:19:17 -0400
Message-Id: <1186687157.6916.675.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 11:49 -0400, Eric Paris wrote:
> Allow policy to select, in much the same way as it selects MLS support,
> how the kernel should handle access decisions which contain either
> unknown classes or unknown permissions in unknown classes.  The three
> choices are (from a kernel perspective)
> 
> 0 - Deny unknown security access. (default)
> 2 - reject loading policy if it does not contain all definitions
> 4 - allow unknown security access
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Anyone else want to speak up for or against this patch?

> ---
> 
> Biggest change between this patch and the last on list is that I changed
> handle_unknown to not be needlessly bit shifted.  I also dropped a check
> in context_struct_computeav which was redundant.
> 
>  security/selinux/ss/policydb.c |    8 +++++
>  security/selinux/ss/policydb.h |   10 ++++++
>  security/selinux/ss/services.c |   65 ++++++++++++++++++++++++++++++++++-----
>  3 files changed, 74 insertions(+), 9 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index f05f97a..588dcfd 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -677,6 +677,8 @@ void policydb_destroy(struct policydb *p)
>  	}
>  	kfree(p->type_attr_map);
>  
> +	kfree(p->undefined_perms);
> +
>  	return;
>  }
>  
> @@ -1530,6 +1532,12 @@ int policydb_read(struct policydb *p, void *fp)
>  			goto bad;
>  		}
>  	}
> +	p->handle_unknown = le32_to_cpu(buf[1]) & POLICYDB_CONFIG_UNKNOWN_MASK;
> +
> +	if (p->handle_unknown > ALLOW_UNKNOWN) {
> +		printk(KERN_ERR "selinux: invalid options for handle_unknown\n");
> +		goto bad;
> +	}
>  
>  	info = policydb_lookup_compat(p->policyvers);
>  	if (!info) {
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 8319d5f..f84e856 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -242,6 +242,9 @@ struct policydb {
>  	struct ebitmap *type_attr_map;
>  
>  	unsigned int policyvers;
> +
> +	int handle_unknown;
> +	u32 *undefined_perms;
>  };
>  
>  extern void policydb_destroy(struct policydb *p);
> @@ -253,6 +256,13 @@ extern int policydb_read(struct policydb *p, void *fp);
>  
>  #define POLICYDB_CONFIG_MLS    1
>  
> +/* the config flags related to unknown classes/perms are bits 2 and 3 */
> +#define DENY_UNKNOWN	0x00000000
> +#define REJECT_UNKNOWN	0x00000002
> +#define ALLOW_UNKNOWN	0x00000004
> +
> +#define POLICYDB_CONFIG_UNKNOWN_MASK 	(DENY_UNKNOWN | REJECT_UNKNOWN | ALLOW_UNKNOWN)
> +
>  #define OBJECT_R "object_r"
>  #define OBJECT_R_VAL 1
>  
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 0ae032f..d3f3a43 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -292,6 +292,7 @@ static int context_struct_compute_av(struct context *scontext,
>  	struct class_datum *tclass_datum;
>  	struct ebitmap *sattr, *tattr;
>  	struct ebitmap_node *snode, *tnode;
> +	const struct selinux_class_perm *kdefs = &selinux_class_perm;
>  	unsigned int i, j;
>  
>  	/*
> @@ -305,13 +306,6 @@ static int context_struct_compute_av(struct context *scontext,
>  		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
>  			tclass = SECCLASS_NETLINK_SOCKET;
>  
> -	if (!tclass || tclass > policydb.p_classes.nprim) {
> -		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> -		       tclass);
> -		return -EINVAL;
> -	}
> -	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> -
>  	/*
>  	 * Initialize the access vectors to the default values.
>  	 */
> @@ -322,6 +316,36 @@ static int context_struct_compute_av(struct context *scontext,
>  	avd->seqno = latest_granting;
>  
>  	/*
> +	 * Check for all the invalid cases.
> +	 * - tclass 0
> +	 * - tclass > policy and > kernel
> +	 * - tclass > policy but is a userspace class
> +	 * - tclass > policy but we do not allow unknowns
> +	 */
> +	if (unlikely(!tclass))
> +		goto inval_class;
> +	if (unlikely(tclass > policydb.p_classes.nprim))
> +		if (tclass > kdefs->cts_len || 
> +		    !kdefs->class_to_string[tclass - 1] ||
> +		    policydb.handle_unknown != ALLOW_UNKNOWN)
> +			goto inval_class;
> +
> +	/* 
> +	 * Kernel class and we ALLOW_UNKNOWN so pad the allow decision 
> +	 * the pad will be all 1 for unknown classes.
> +	 */
> +	if (tclass <= kdefs->cts_len && (policydb.handle_unknown == ALLOW_UNKNOWN))
> +		avd->allowed = policydb.undefined_perms[tclass - 1];
> +
> +	/*
> +	 * Not in policy. Since decision is completed (all 1 or all 0) return.
> +	 */
> +	if (unlikely(tclass > policydb.p_classes.nprim))
> +		return 0;
> +
> +	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> +
> +	/*
>  	 * If a specific type enforcement rule was defined for
>  	 * this permission check, then use it.
>  	 */
> @@ -387,6 +411,10 @@ static int context_struct_compute_av(struct context *scontext,
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
> @@ -1054,6 +1082,13 @@ static int validate_classes(struct policydb *p)
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
> @@ -1062,6 +1097,10 @@ static int validate_classes(struct policydb *p)
>  			printk(KERN_INFO
>  			       "security:  class %s not defined in policy\n",
>  			       def_class);
> +			if (p->handle_unknown == ALLOW_UNKNOWN)
> +				p->undefined_perms[i-1] = ~0U;
> +			if (p->handle_unknown == REJECT_UNKNOWN)
> +				return -EINVAL;
>  			continue;
>  		}
>  		pol_class = p->p_class_val_to_name[i-1];
> @@ -1087,12 +1126,16 @@ static int validate_classes(struct policydb *p)
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
>  			printk(KERN_ERR
> -			       "security:  permission %s in class %s not found in policy\n",
> +			       "security:  permission %s in class %s not found in policy, bad policy\n",
>  			       def_perm, pol_class);
>  			return -EINVAL;
>  		}
> @@ -1130,12 +1173,16 @@ static int validate_classes(struct policydb *p)
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
>  				printk(KERN_ERR
> -				       "security:  permission %s in class %s not found in policy\n",
> +				       "security:  permission %s in class %s not found in policy, bad policy\n",
>  				       def_perm, pol_class);
>  				return -EINVAL;
>  			}
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
