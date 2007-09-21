Subject: Re: [PATCH -v2] kernel: selinux: policy selectable
	handling	of	unknown classes and perms
From: Eric Paris <eparis@redhat.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        jmorris@namei.org, Steve G <linux_4ever@yahoo.com>
In-Reply-To: <46F31D05.9020108@tycho.nsa.gov>
References: <1189695931.3391.46.camel@localhost.localdomain>
	 <1190132935.14037.8.camel@moss-spartans.epoch.ncsc.mil>
	 <46F03EC1.3010900@tycho.nsa.gov>
	 <1190315935.3451.112.camel@localhost.localdomain>
	 <46F31D05.9020108@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 21 Sep 2007 09:17:37 -0400
Message-Id: <1190380657.3451.123.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-20 at 21:23 -0400, Eamon Walsh wrote:
> Eric Paris wrote:
> > On Tue, 2007-09-18 at 17:10 -0400, Eamon Walsh wrote:
> >   
> >> Numeric values are fine, but the tristate is a little cumbersome. Would
> >> it be possible to split this into two boolean files, one reporting 
> >> zero/one for "don't reject/reject" and one reporting zero/one for 
> >> "allow/deny"?
> >>     
> >
> > Is this really necessary?  Are you really trying to say you don't want
> > to know about reject and if I put it in another file you can just ignore
> > it?  I'm fine with that if userspace just plain doesn't care about it,
> > I'll just make one allow/deny boolean.  I don't want to create another
> > selinuxfs file if it is going to be useless.  If 2 files are actually
> > useful and needed I'm willing to do that too, or maybe one file which
> > outputs 2 boolean flags.
> >
> > cat unknown
> > 0 0
> >   
> 
> The issue is not whether or not the values will be consumed.  It's about 
> avoiding the enum,
> list of #defines, or flag values that will be necessary to represent the 
> tristate.
> 
> Here's a patch that applies on top of your patch.  It splits up the 
> policyrep field into two
> cleanly separated bits.  Does the files too.  Should be fully 
> compatible, although I didn't
> have time to compile test.  Please apply.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

it looks good to me on review, i'll drop it in and compile.  Still need
to fix the printk to have a SELinux prefix, which of course will
probably conflict with yours.  I'll shouldn't have any trouble merging
and resend today.

-Eric
> ---
> 
>  include/security.h |    4 ++--
>  selinuxfs.c        |   13 +++++++++----
>  ss/policydb.c      |    8 ++------
>  ss/policydb.h      |    6 ++----
>  ss/services.c      |   43 +++++++++++++++++--------------------------
>  5 files changed, 32 insertions(+), 42 deletions(-)
> 
> 
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 99b3e24..39337af 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -90,8 +90,8 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
>  
>  int security_get_classes(char ***classes, int *nclasses);
>  int security_get_permissions(char *class, char ***perms, int *nperms);
> -int security_get_handle_unknown(void);
> -char *security_get_handle_unknown_txt(void);
> +int security_get_reject_unknown(void);
> +int security_get_allow_unknown(void);
>  
>  #define SECURITY_FS_USE_XATTR		1 /* use xattr */
>  #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f7d1bfa..ac9e79b 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -103,7 +103,8 @@ enum sel_inos {
>  	SEL_MEMBER,	/* compute polyinstantiation membership decision */
>  	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
>  	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
> -	SEL_HANDLE_UNKNOWN, /* export unknown handling to userspace */
> +	SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
> +	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
>  	SEL_INO_NEXT,	/* The next inode number to use */
>  };
>  
> @@ -183,7 +184,9 @@ static ssize_t sel_read_handle_unknown(struct file *filp, char __user *buf,
>  {
>  	char tmpbuf[TMPBUFLEN];
>  	ssize_t length;
> -	int handle_unknown = security_get_handle_unknown();
> +	ino_t ino = filep->f_path.dentry->d_inode->i_ino;
> +	int handle_unknown = (ino == SEL_REJECT_UNKNOWN) ?
> +		security_get_reject_unknown() : !security_get_allow_unknown();
>  
>  	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", handle_unknown);
>  	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
> @@ -313,7 +316,8 @@ static ssize_t sel_write_load(struct file * file, const char __user * buf,
>  		goto out;
>  
>  	printk(KERN_INFO "Policy loaded with handle_unknown=%s\n",
> -	       security_get_handle_unknown_txt());
> +	       security_get_reject_unknown() ? "reject" :
> +	       (security_get_allow_unknown() ? "allow" : "deny"));
>  
>  	ret = sel_make_bools();
>  	if (ret) {
> @@ -1594,7 +1598,8 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
>  		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
>  		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
>  		[SEL_COMPAT_NET] = {"compat_net", &sel_compat_net_ops, S_IRUGO|S_IWUSR},
> -		[SEL_HANDLE_UNKNOWN] = {"handle_unknown", &sel_handle_unknown_ops, S_IRUGO|S_IWUSR},
> +		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO|S_IWUSR},
> +		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO|S_IWUSR},
>  		/* last one */ {""}
>  	};
>  	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 588dcfd..70d5baa 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1532,12 +1532,8 @@ int policydb_read(struct policydb *p, void *fp)
>  			goto bad;
>  		}
>  	}
> -	p->handle_unknown = le32_to_cpu(buf[1]) & POLICYDB_CONFIG_UNKNOWN_MASK;
> -
> -	if (p->handle_unknown > ALLOW_UNKNOWN) {
> -		printk(KERN_ERR "selinux: invalid options for handle_unknown\n");
> -		goto bad;
> -	}
> +	p->reject_unknown = !!(le32_to_cpu(buf[1]) & REJECT_UNKNOWN);
> +	p->allow_unknown = !!(le32_to_cpu(buf[1]) & ALLOW_UNKNOWN);
>  
>  	info = policydb_lookup_compat(p->policyvers);
>  	if (!info) {
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index f84e856..844d310 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -243,7 +243,8 @@ struct policydb {
>  
>  	unsigned int policyvers;
>  
> -	int handle_unknown;
> +	unsigned int reject_unknown : 1;
> +	unsigned int allow_unknown : 1;
>  	u32 *undefined_perms;
>  };
>  
> @@ -257,12 +258,9 @@ extern int policydb_read(struct policydb *p, void *fp);
>  #define POLICYDB_CONFIG_MLS    1
>  
>  /* the config flags related to unknown classes/perms are bits 2 and 3 */
> -#define DENY_UNKNOWN	0x00000000
>  #define REJECT_UNKNOWN	0x00000002
>  #define ALLOW_UNKNOWN	0x00000004
>  
> -#define POLICYDB_CONFIG_UNKNOWN_MASK 	(DENY_UNKNOWN | REJECT_UNKNOWN | ALLOW_UNKNOWN)
> -
>  #define OBJECT_R "object_r"
>  #define OBJECT_R_VAL 1
>  
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 4e18271..4af5be9 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -327,14 +327,14 @@ static int context_struct_compute_av(struct context *scontext,
>  	if (unlikely(tclass > policydb.p_classes.nprim))
>  		if (tclass > kdefs->cts_len || 
>  		    !kdefs->class_to_string[tclass - 1] ||
> -		    policydb.handle_unknown != ALLOW_UNKNOWN)
> +		    !policydb.allow_unknown)
>  			goto inval_class;
>  
>  	/* 
> -	 * Kernel class and we ALLOW_UNKNOWN so pad the allow decision 
> +	 * Kernel class and we allow unknown so pad the allow decision 
>  	 * the pad will be all 1 for unknown classes.
>  	 */
> -	if (tclass <= kdefs->cts_len && (policydb.handle_unknown == ALLOW_UNKNOWN))
> +	if (tclass <= kdefs->cts_len && policydb.allow_unknown)
>  		avd->allowed = policydb.undefined_perms[tclass - 1];
>  
>  	/*
> @@ -1082,7 +1082,7 @@ static int validate_classes(struct policydb *p)
>  	const char *def_class, *def_perm, *pol_class;
>  	struct symtab *perms;
>  
> -	if (p->handle_unknown == ALLOW_UNKNOWN) {
> +	if (p->allow_unknown) {
>  		u32 num_classes = kdefs->cts_len;
>  		p->undefined_perms = kcalloc(num_classes, sizeof(u32), GFP_KERNEL);
>  		if (!p->undefined_perms)
> @@ -1097,10 +1097,10 @@ static int validate_classes(struct policydb *p)
>  			printk(KERN_INFO
>  			       "security:  class %s not defined in policy\n",
>  			       def_class);
> -			if (p->handle_unknown == ALLOW_UNKNOWN)
> -				p->undefined_perms[i-1] = ~0U;
> -			if (p->handle_unknown == REJECT_UNKNOWN)
> +			if (p->reject_unknown)
>  				return -EINVAL;
> +			if (p->allow_unknown)
> +				p->undefined_perms[i-1] = ~0U;
>  			continue;
>  		}
>  		pol_class = p->p_class_val_to_name[i-1];
> @@ -1126,10 +1126,10 @@ static int validate_classes(struct policydb *p)
>  			printk(KERN_INFO
>  			       "security:  permission %s in class %s not defined in policy\n",
>  			       def_perm, pol_class);
> -			if (p->handle_unknown == ALLOW_UNKNOWN)
> -				p->undefined_perms[class_val-1] |= perm_val;
> -			else if (p->handle_unknown == REJECT_UNKNOWN)
> +			if (p->reject_unknown)
>  				return -EINVAL;
> +			if (p->allow_unknown)
> +				p->undefined_perms[class_val-1] |= perm_val;
>  			continue;
>  		}
>  		perdatum = hashtab_search(perms->table, def_perm);
> @@ -1173,10 +1173,10 @@ static int validate_classes(struct policydb *p)
>  				printk(KERN_INFO
>  				       "security:  permission %s in class %s not defined in policy\n",
>  				       def_perm, pol_class);
> -				if (p->handle_unknown == ALLOW_UNKNOWN)
> -					p->undefined_perms[class_val-1] |= (1 << j);
> -				else if (p->handle_unknown == REJECT_UNKNOWN)
> +				if (p->reject_unknown)
>  					return -EINVAL;
> +				if (p->allow_unknown)
> +					p->undefined_perms[class_val-1] |= (1 << j);
>  				continue;
>  			}
>  			perdatum = hashtab_search(perms->table, def_perm);
> @@ -2149,23 +2149,14 @@ err:
>  	return rc;
>  }
>  
> -int security_get_handle_unknown(void)
> +int security_get_reject_unknown(void)
>  {
> -	return policydb.handle_unknown;
> +	return policydb.reject_unknown;
>  }
>  
> -char *security_get_handle_unknown_txt(void)
> +int security_get_allow_unknown(void)
>  {
> -	switch (policydb.handle_unknown) {
> -	case ALLOW_UNKNOWN:
> -		return "allow";
> -	case REJECT_UNKNOWN:
> -		return "reject";
> -	case DENY_UNKNOWN:
> -		return "deny";
> -	default:
> -		return "UNKNOWN";
> -	}
> +	return policydb.allow_unknown;
>  }
>  
>  struct selinux_audit_rule {
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
