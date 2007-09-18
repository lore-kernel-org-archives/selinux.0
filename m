Subject: Re: [PATCH -v2] kernel: selinux: policy selectable handling of
	unknown classes and perms
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, Steve G <linux_4ever@yahoo.com>
In-Reply-To: <1189695931.3391.46.camel@localhost.localdomain>
References: <1189695931.3391.46.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Sep 2007 12:28:55 -0400
Message-Id: <1190132935.14037.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-13 at 11:05 -0400, Eric Paris wrote:
> Allow policy to select, in much the same way as it selects MLS support,
> how the kernel should handle access decisions which contain either
> unknown classes or unknown permissions in known classes.  The three
> choices are
> 
> 0 - Deny unknown security access. (default)
> 2 - reject loading policy if it does not contain all definitions
> 4 - allow unknown security access
> 
> The policy's choice is exported (with a value of 0,2,4) to userspace
> through /selinuxfs/handle_unknown 

Eamon, does this userspace interface work for you to use in the
userspace AVC?  Do you want the integer value like this or would you
prefer the "reject", "deny", or "allow" string that is displayed by the
kernel in its log message at load policy time?

> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> ---
> 
> To test I added a new class and with two permissions into the kernel.  I
> then changed security_mmap_file to make use of these new classes and
> permissions because i knew how to easily manipulate that from usersapce
> from the mmap_zero patch.  Basically
> 
> if (addr == 0)
>    check permission for 'test_class'/'test_perm2'
>    printk(success/fail)
> if (addr < mmap_min_addr)
>    check permission for 'test_class'/'test_perm1'
>    printk(success/fail)
> 
> I wrote a simple program in userspace which called mmap with MAP_FIXED
> at 0 and 4096 so I would be able to exercise everything I needed.
> 
> I then tested with policy having no classes or perms defined and with a
> policy which had the class but only one of the 2 perms defined.  In all
> cases I got the expected behavior.  
> 
> REJECT refused to load the policy because of either the missing class
> and the missing perm
> 
> DENY/default refused to let me mmap anything at a low address when
> neither was defined.  Adding policy to allow  test_class/test_perm1
> meant I could mmap the page a 4096 but still denied the mmap 0.
> 
> ALLOW allowed the mmap at both 0 and 4096 with any policy.
> 
>  security/selinux/include/security.h |    2 +
>  security/selinux/selinuxfs.c        |   20 ++++++++
>  security/selinux/ss/policydb.c      |    8 +++
>  security/selinux/ss/policydb.h      |   10 ++++
>  security/selinux/ss/services.c      |   84 +++++++++++++++++++++++++++++++----
>  5 files changed, 115 insertions(+), 9 deletions(-)
> 
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 83bdd4d..99b3e24 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -90,6 +90,8 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
>  
>  int security_get_classes(char ***classes, int *nclasses);
>  int security_get_permissions(char *class, char ***perms, int *nperms);
> +int security_get_handle_unknown(void);
> +char *security_get_handle_unknown_txt(void);
>  
>  #define SECURITY_FS_USE_XATTR		1 /* use xattr */
>  #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index c9e92da..f7d1bfa 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -103,6 +103,7 @@ enum sel_inos {
>  	SEL_MEMBER,	/* compute polyinstantiation membership decision */
>  	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
>  	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
> +	SEL_HANDLE_UNKNOWN, /* export unknown handling to userspace */
>  	SEL_INO_NEXT,	/* The next inode number to use */
>  };
>  
> @@ -177,6 +178,21 @@ static const struct file_operations sel_enforce_ops = {
>  	.write		= sel_write_enforce,
>  };
>  
> +static ssize_t sel_read_handle_unknown(struct file *filp, char __user *buf,
> +					size_t count, loff_t *ppos)
> +{
> +	char tmpbuf[TMPBUFLEN];
> +	ssize_t length;
> +	int handle_unknown = security_get_handle_unknown();
> +
> +	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", handle_unknown);
> +	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
> +}
> +
> +static const struct file_operations sel_handle_unknown_ops = {
> +	.read		= sel_read_handle_unknown,
> +};
> +
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  static ssize_t sel_write_disable(struct file * file, const char __user * buf,
>  				 size_t count, loff_t *ppos)
> @@ -296,6 +312,9 @@ static ssize_t sel_write_load(struct file * file, const char __user * buf,
>  	if (length)
>  		goto out;
>  
> +	printk(KERN_INFO "Policy loaded with handle_unknown=%s\n",
> +	       security_get_handle_unknown_txt());

I think this should have some well-defined prefix on it, like "SELinux:"
or something, to make it easy to identify.  Steve Grubb might have an
opinion on whether it should use printk or have its own audit message or
be added to the load policy audit message.
  
> +
>  	ret = sel_make_bools();
>  	if (ret) {
>  		length = ret;
> @@ -1575,6 +1594,7 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
>  		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
>  		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
>  		[SEL_COMPAT_NET] = {"compat_net", &sel_compat_net_ops, S_IRUGO|S_IWUSR},
> +		[SEL_HANDLE_UNKNOWN] = {"handle_unknown", &sel_handle_unknown_ops, S_IRUGO|S_IWUSR},
>  		/* last one */ {""}
>  	};
>  	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
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
> index 6100fc0..4e18271 100644
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
> +	printk(KERN_ERR "%s:  unrecognized class %d\n", __FUNCTION__, tclass);
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
> @@ -2102,6 +2149,25 @@ err:
>  	return rc;
>  }
>  
> +int security_get_handle_unknown(void)
> +{
> +	return policydb.handle_unknown;
> +}
> +
> +char *security_get_handle_unknown_txt(void)
> +{
> +	switch (policydb.handle_unknown) {
> +	case ALLOW_UNKNOWN:
> +		return "allow";
> +	case REJECT_UNKNOWN:
> +		return "reject";
> +	case DENY_UNKNOWN:
> +		return "deny";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}
> +
>  struct selinux_audit_rule {
>  	u32 au_seqno;
>  	struct context au_ctxt;
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
