Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6PDkGY4022205
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 09:46:16 -0400
Received: from py-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6PDkFn9022374
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 13:46:15 GMT
Received: by py-out-1112.google.com with SMTP id a78so8909250pyh.32
        for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 06:46:15 -0700 (PDT)
Subject: Re: [PATCH 1/3] Thread/Child-Domain Assignment
From: Stephen Smalley <stephen.smalley@gmail.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org, paul.moore@hp.com,
        jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <4889CF30.2060306@ak.jp.nec.com>
References: <487C7698.60503@ak.jp.nec.com>
	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>
	 <487D5A3D.6090801@ak.jp.nec.com>
	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>
	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>
	 <4889CC5F.3030500@ak.jp.nec.com>  <4889CF30.2060306@ak.jp.nec.com>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 09:44:11 -0400
Message-Id: <1216993463.11948.22.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-07-25 at 22:03 +0900, KaiGai Kohei wrote:
> [1/3] thread-context-kernel.1.patch
>   This patch enables to assign a thread a "weaker" hierarchical domain,
>   only if the destinated domain is a child of the current domain.
>   Hierachy relationships are defined in the policy version 24.
>   This patch also enables to read the new version of policy.

If you are going to take type hierarchy support into the kernel, then it
seems like it should be completely taken into the kernel, i.e. the
hierarchy checking should be applied by the kernel rather than by the
toolchain.  That is what the Flask security server did for its
extensible policy mechanism.

And I think both the neverallow checking and the type hierarchy checking
needs to move away from needing to do a full expansion in order to
check; it is just too expensive these days.

> 
> 
> Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
> ----
>  security/selinux/hooks.c            |   11 +++++-
>  security/selinux/include/security.h |    5 ++-
>  security/selinux/ss/policydb.c      |   75 ++++++++++++++++++++++++++++++++--
>  security/selinux/ss/policydb.h      |    2 +
>  security/selinux/ss/services.c      |   60 ++++++++++++++++++++++++++++
>  5 files changed, 146 insertions(+), 7 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index bc1c3ae..d4c1c5c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5181,7 +5181,12 @@ static int selinux_setprocattr(struct task_struct *p,
>  		if (sid == 0)
>  			return -EINVAL;
> 
> -		/* Only allow single threaded processes to change context */
> +		/*
> +		 * SELinux allows to change context in the following case only.
> +		 *  - Single threaded processes.
> +		 *  - Multi threaded processes intend to change its context into
> +		 *    lower or same domain in hierarchy relationship.
> +		 */
>  		if (atomic_read(&p->mm->mm_users) != 1) {
>  			struct task_struct *g, *t;
>  			struct mm_struct *mm = p->mm;
> @@ -5189,11 +5194,15 @@ static int selinux_setprocattr(struct task_struct *p,
>  			do_each_thread(g, t) {
>  				if (t->mm == mm && t != p) {
>  					read_unlock(&tasklist_lock);
> +
> +					if (!security_check_hierarchy(tsec->sid, sid))
> +						goto hierarchy_ok;
>  					return -EPERM;
>  				}
>  			} while_each_thread(g, t);
>  			read_unlock(&tasklist_lock);
>  		}
> +hierarchy_ok:
> 
>  		/* Check permissions for the transition. */
>  		error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ad30ac4..97fa9bb 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -27,13 +27,14 @@
>  #define POLICYDB_VERSION_RANGETRANS	21
>  #define POLICYDB_VERSION_POLCAP		22
>  #define POLICYDB_VERSION_PERMISSIVE	23
> +#define POLICYDB_VERSION_HIERARCHY	24
> 
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
>  #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
>  #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
>  #else
> -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PERMISSIVE
> +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_HIERARCHY
>  #endif
> 
>  #define CONTEXT_MNT	0x01
> @@ -118,6 +119,8 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
>  				 u32 xfrm_sid,
>  				 u32 *peer_sid);
> 
> +int security_check_hierarchy(u32 old_sid, u32 new_sid);
> +
>  int security_get_classes(char ***classes, int *nclasses);
>  int security_get_permissions(char *class, char ***perms, int *nperms);
>  int security_get_reject_unknown(void);
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 84f8cc7..e388f7a 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -116,7 +116,12 @@ static struct policydb_compat_info policydb_compat[] = {
>  		.version	= POLICYDB_VERSION_PERMISSIVE,
>  		.sym_num	= SYM_NUM,
>  		.ocon_num	= OCON_NUM,
> -	}
> +	},
> +	{
> +		.version	= POLICYDB_VERSION_HIERARCHY,
> +		.sym_num	= SYM_NUM,
> +		.ocon_num	= OCON_NUM,
> +	},
>  };
> 
>  static struct policydb_compat_info *policydb_lookup_compat(int version)
> @@ -270,9 +275,12 @@ static int type_index(void *key, void *datum, void *datap)
>  	p = datap;
> 
>  	if (typdatum->primary) {
> -		if (!typdatum->value || typdatum->value > p->p_types.nprim)
> +		if (!typdatum->value
> +		    || typdatum->value > p->p_types.nprim
> +		    || typdatum->parent > p->p_types.nprim)
>  			return -EINVAL;
>  		p->p_type_val_to_name[typdatum->value - 1] = key;
> +		p->type_val_to_struct[typdatum->value - 1] = typdatum;
>  	}
> 
>  	return 0;
> @@ -397,6 +405,46 @@ static void symtab_hash_eval(struct symtab *s)
>  }
>  #endif
> 
> +static int type_hierarchy_sanity_checks(struct policydb *p)
> +{
> +	struct type_datum *type;
> +	struct ebitmap e;
> +	int rc = 0, i;
> +
> +	if (p->policyvers < POLICYDB_VERSION_HIERARCHY)
> +		return 0;
> +
> +	for (i = 0; i < p->p_types.nprim; i++) {
> +		type = p->type_val_to_struct[i];
> +
> +		if (!type || !type->parent)
> +			continue;
> +
> +		ebitmap_init(&e);
> +		while (type) {
> +			if (ebitmap_get_bit(&e, type->value - 1)) {
> +				printk(KERN_ERR "Hierarchy type looped at %s\n",
> +				       p->p_type_val_to_name[type->value - 1]);
> +				rc = -EINVAL;
> +				break;
> +			}
> +
> +			rc = ebitmap_set_bit(&e, type->value - 1, 1);
> +			if (rc)
> +				break;
> +
> +			if (!type->parent)
> +				break;
> +
> +			type = p->type_val_to_struct[type->parent - 1];
> +		}
> +		ebitmap_destroy(&e);
> +		if (rc)
> +			return rc;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Define the other val_to_name and val_to_struct arrays
>   * in a policy database structure.
> @@ -438,6 +486,14 @@ static int policydb_index_others(struct policydb *p)
>  		goto out;
>  	}
> 
> +	p->type_val_to_struct =
> +		kzalloc(p->p_types.nprim * sizeof(*(p->type_val_to_struct)),
> +			GFP_KERNEL);
> +	if (!p->type_val_to_struct) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
>  	if (cond_init_bool_indexes(p)) {
>  		rc = -ENOMEM;
>  		goto out;
> @@ -455,6 +511,7 @@ static int policydb_index_others(struct policydb *p)
>  			goto out;
>  	}
> 
> +	rc = type_hierarchy_sanity_checks(p);
>  out:
>  	return rc;
>  }
> @@ -625,6 +682,7 @@ void policydb_destroy(struct policydb *p)
>  	kfree(p->class_val_to_struct);
>  	kfree(p->role_val_to_struct);
>  	kfree(p->user_val_to_struct);
> +	kfree(p->type_val_to_struct);
> 
>  	avtab_destroy(&p->te_avtab);
> 
> @@ -1236,8 +1294,8 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
>  {
>  	char *key = NULL;
>  	struct type_datum *typdatum;
> -	int rc;
> -	__le32 buf[3];
> +	int to_read, rc;
> +	__le32 buf[4];
>  	u32 len;
> 
>  	typdatum = kzalloc(sizeof(*typdatum), GFP_KERNEL);
> @@ -1246,13 +1304,20 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
>  		return rc;
>  	}
> 
> -	rc = next_entry(buf, fp, sizeof buf);
> +	if (p->policyvers < POLICYDB_VERSION_HIERARCHY)
> +		to_read = sizeof(u32) * 3;
> +	else
> +		to_read = sizeof(u32) * 4;
> +
> +	rc = next_entry(buf, fp, to_read);
>  	if (rc < 0)
>  		goto bad;
> 
>  	len = le32_to_cpu(buf[0]);
>  	typdatum->value = le32_to_cpu(buf[1]);
>  	typdatum->primary = le32_to_cpu(buf[2]);
> +	if (p->policyvers >= POLICYDB_VERSION_HIERARCHY)
> +		typdatum->parent = le32_to_cpu(buf[3]);
> 
>  	key = kmalloc(len + 1, GFP_KERNEL);
>  	if (!key) {
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 4253370..f3484d4 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -81,6 +81,7 @@ struct role_allow {
>  /* Type attributes */
>  struct type_datum {
>  	u32 value;		/* internal type value */
> +	u32 parent;		/* parent type, if hierarchy related */
>  	unsigned char primary;	/* primary name? */
>  };
> 
> @@ -209,6 +210,7 @@ struct policydb {
>  	struct class_datum **class_val_to_struct;
>  	struct role_datum **role_val_to_struct;
>  	struct user_datum **user_val_to_struct;
> +	struct type_datum **type_val_to_struct;
> 
>  	/* type enforcement access vectors and transitions */
>  	struct avtab te_avtab;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index dcc2e1c..3ecd793 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2160,6 +2160,66 @@ out_slowpath:
>  	return rc;
>  }
> 
> +/*
> + * security_check_hierarchy
> + *
> + * It returns 0, if @old_sid is same or upper type of @new_sid in hierarchy
> + * relationship directly/indirectly. 1 means @old_sid is not a child type
> + * of @new_sid, and negative returns are error.
> + */
> +int security_check_hierarchy(u32 old_sid, u32 new_sid)
> +{
> +	struct context *old_context, *new_context;
> +	struct type_datum *type;
> +	int index;
> +	int rc = -EINVAL;
> +
> +	read_lock(&policy_rwlock);
> +
> +	old_context = sidtab_search(&sidtab, old_sid);
> +	if (!old_context) {
> +		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
> +		       __func__, old_sid);
> +		goto out;
> +	}
> +
> +	new_context = sidtab_search(&sidtab, new_sid);
> +	if (!new_context) {
> +		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
> +		       __func__, new_sid);
> +		goto out;
> +	}
> +
> +	/* domain unchanged */
> +	if (old_context->type == new_context->type) {
> +		rc = 0;
> +		goto out;
> +	}
> +
> +	/* check domain hierarchy */
> +	index = new_context->type;
> +	while (true) {
> +		type = policydb.type_val_to_struct[index - 1];
> +		if (!type)
> +			break;
> +
> +		/* No hierarchy relationship */
> +		if (type->parent == 0) {
> +			rc = 1;
> +			break;
> +		}
> +		if (type->parent == old_context->type) {
> +			rc = 0;
> +			break;
> +		}
> +		index = type->parent;
> +	}
> +out:
> +	read_unlock(&policy_rwlock);
> +
> +	return rc;
> +}
> +
>  static int get_classes_callback(void *k, void *d, void *args)
>  {
>  	struct class_datum *datum = d;
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
