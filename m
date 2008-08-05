Subject: Re: [PATCH 1/3] Thread/Child-Domain Assignment (rev.2)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
In-Reply-To: <4897EB5A.1040404@ak.jp.nec.com>
References: <487C7698.60503@ak.jp.nec.com>
	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>
	 <487D5A3D.6090801@ak.jp.nec.com>
	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>
	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>
	 <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com>
	 <4897EB5A.1040404@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 08:53:13 -0400
Message-Id: <1217940793.2994.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-08-05 at 14:55 +0900, KaiGai Kohei wrote:
> [1/3] thread-context-kernel.2.patch
>   It allows a multithreaded process to assign an individual
>   "more bounded" security context, and it also enables to
>   handle binary policy format version 24 in kernel space.
> 
> Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
> --
>  security/selinux/avc.c              |    2 +-
>  security/selinux/hooks.c            |   12 +-
>  security/selinux/include/security.h |    6 +-
>  security/selinux/ss/policydb.c      |  244 +++++++++++++++++++++++++--
>  security/selinux/ss/policydb.h      |    4 +
>  security/selinux/ss/services.c      |  324 +++++++++++++++++++++++++++++++----
>  6 files changed, 541 insertions(+), 51 deletions(-)


> @@ -1176,8 +1198,8 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
>  {
>  	char *key = NULL;
>  	struct role_datum *role;
> -	int rc;
> -	__le32 buf[2];
> +	int rc, to_read = 2;
> +	__le32 buf[3];
>  	u32 len;
> 
>  	role = kzalloc(sizeof(*role), GFP_KERNEL);
> @@ -1186,12 +1208,17 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
>  		goto out;
>  	}
> 
> +	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
> +		to_read = 3;
> +
>  	rc = next_entry(buf, fp, sizeof buf);

Doesn't this also need to be changed to pass sizeof(buf[0]) * to_read
rather than sizeof buf?
Did you try loading an old policy on your new kernel?

>  	if (rc < 0)
>  		goto bad;
> 
>  	len = le32_to_cpu(buf[0]);
>  	role->value = le32_to_cpu(buf[1]);
> +	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
> +		role->bounds = le32_to_cpu(buf[2]);
> 
>  	key = kmalloc(len + 1, GFP_KERNEL);
>  	if (!key) {

> @@ -1465,6 +1502,181 @@ static int (*read_f[SYM_NUM]) (struct policydb *p, struct hashtab *h, void *fp)
>  	cat_read,
>  };
> 
> +static int user_bounds_sanity_check(void *key, void *datum, void *datap)
> +{
> +	struct user_datum *upper, *user;
> +	struct policydb *p = datap;
> +	int rc, depth = 0;
> +
> +	upper = user = datum;
> +	while (upper->bounds) {
> +		struct ebitmap_node *node;
> +		unsigned long bit;
> +
> +		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
> +			printk(KERN_ERR
> +			       "SELinux: user %s: too deep bounds\n",
> +			       (char *) key);
> +			return -EINVAL;
> +		}
> +
> +		upper = p->user_val_to_struct[upper->bounds - 1];
> +		if (!upper) {
> +			printk(KERN_ERR
> +			       "SELinux: user %s: broken boundary\n",
> +			       (char *) key);
> +			return -EINVAL;
> +		}
> +		/* drop bounded bit from user->roles */
> +retry:
> +		ebitmap_for_each_positive_bit(&user->roles, node, bit) {
> +			if (ebitmap_get_bit(&upper->roles, bit))
> +				continue;
> +
> +			audit_log(current->audit_context, GFP_KERNEL,
> +				  AUDIT_SELINUX_ERR,
> +				  "boundary violation: "
> +				  "user=%s role=%s bounds=%s",
> +				  p->p_user_val_to_name[user->value - 1],
> +				  p->p_role_val_to_name[bit],
> +				  p->p_user_val_to_name[upper->value - 1]);
> +
> +			rc = ebitmap_set_bit(&user->roles, bit, 0);
> +			if (rc)
> +				return rc;
> +			goto retry;

I would just return an error and abort the policy load on any boundary
violations detected at load time rather than mutating the policy.

> +		}
> +	}
> +	return 0;
> +}
> +
> +static int role_bounds_sanity_check(void *key, void *datum, void *poldbp)
> +{
> +	struct role_datum *upper, *role;
> +	struct policydb *p = poldbp;
> +	int rc, depth = 0;
> +
> +	upper = role = datum;
> +	while (upper->bounds) {
> +		struct ebitmap_node *node;
> +		unsigned long bit;
> +
> +		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
> +			printk(KERN_ERR
> +			       "SELinux: role %s: too deep bounds\n",
> +			       (char *) key);
> +			return -EINVAL;
> +		}
> +
> +		upper = p->role_val_to_struct[upper->bounds - 1];
> +		if (!upper) {
> +			printk(KERN_ERR
> +			       "SELinux: role %s: broken boundary\n",
> +			       (char *) key);
> +			return -EINVAL;
> +		}
> +		/* drop bounded bit from user->roles */
> +retry:
> +		ebitmap_for_each_positive_bit(&role->types, node, bit) {
> +			if (ebitmap_get_bit(&upper->types, bit))
> +				continue;
> +
> +			audit_log(current->audit_context, GFP_KERNEL,
> +				  AUDIT_SELINUX_ERR,
> +				  "boundary violation: "
> +				  "role=%s type=%s bounds=%s",
> +				  p->p_role_val_to_name[role->value - 1],
> +				  p->p_type_val_to_name[bit],
> +				  p->p_role_val_to_name[upper->value - 1]);
> +
> +			rc = ebitmap_set_bit(&role->types, bit, 0);
> +			if (rc)
> +				return rc;
> +			goto retry;

Ditto.

> +		}
> +	}
> +	return 0;
> +}
> +
> +static int type_bounds_sanity_check(void *key, void *datum, void *poldbp)
> +{
> +	struct type_datum *upper, *type;
> +	struct policydb *p = poldbp;
> +	int rc, depth = 0;
> +
> +	upper = type = datum;
> +	while (upper->bounds) {
> +		struct ebitmap *type_attrs, *upper_attrs;
> +		struct ebitmap_node *node;
> +		unsigned long bit;
> +
> +		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
> +			printk(KERN_ERR
> +			       "SELinux: type %s: too deep boundary\n",
> +			       (char *) key);
> +			return -EINVAL;
> +		}
> +
> +		upper = p->type_val_to_struct[upper->bounds - 1];
> +		if (!upper) {
> +			printk(KERN_ERR
> +			       "SELinux: type %s: broken boundary\n",
> +			       (char *) key);
> +			return -EINVAL;
> +		}
> +		/* drop bounded bit from type_attr_map */
> +retry:
> +		type_attrs = &p->type_attr_map[type->value - 1];
> +		upper_attrs = &p->type_attr_map[upper->value - 1];
> +		ebitmap_for_each_positive_bit(type_attrs, node, bit) {
> +			if (type->value == bit + 1)
> +				continue;
> +
> +			if (ebitmap_get_bit(upper_attrs, bit))
> +				continue;
> +
> +			audit_log(current->audit_context, GFP_KERNEL,
> +				  AUDIT_SELINUX_ERR,
> +				  "boundary violation: "
> +				  "type=%s attribute=%lu bounds=%s",
> +				  p->p_type_val_to_name[type->value - 1],
> +				  bit + 1,
> +				  p->p_type_val_to_name[upper->value - 1]);
> +
> +			rc = ebitmap_set_bit(type_attrs, bit, 0);
> +			if (rc)
> +				return rc;
> +			goto retry;

And again.

> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 4253370..320fa23 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -61,6 +61,7 @@ struct class_datum {
> @@ -81,12 +82,14 @@ struct role_allow {
>  /* Type attributes */
>  struct type_datum {
>  	u32 value;		/* internal type value */
> +	u32 bounds;		/* boundary of type */
>  	unsigned char primary;	/* primary name? */
>  };

An aside:  Possibly we should add the attribute flag at the same time
and leave the type attributes in the type symtab in the kernel policy,
as previously discussed.  Then the kernel policy won't be lacking any
information needed for analysis.  Just need to make sure that
context_to_sid doesn't accept attributes in the type field.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index dcc2e1c..a584c1d 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
<snip>
> +static int cexpr_type_names_eval(struct ebitmap *names, u16 type_value)
> +{
> +	struct type_datum *type
> +		= policydb.type_val_to_struct[type_value - 1];
> +	int bit;
> +
> +	while (1) {

You were using while (true) in the prior functions.  We should be
consistent one way or the other.

> +		bit = ebitmap_get_bit(names, type->value - 1);
> +		if (!bit) {
> +			if (type->value != type_value)
> +				audit_log(current->audit_context,
> +					  GFP_ATOMIC, AUDIT_SELINUX_ERR,
> +					  "boundary violation: "
> +					  "type=%s bounded=%s",
> +					  policydb.p_type_val_to_name[type_value - 1],
> +					  policydb.p_type_val_to_name[type->value - 1]);
> +			break;
> +		}
> +		if (!type->bounds)
> +			break;
> +		type = policydb.type_val_to_struct[type->bounds - 1];
> +	}

I don't think we ought to be doing this checking here, if at all.
Either we vet the constraints for internal consistency at load time, or
we view the bounds as purely a limit on the TE rules and not necessarily
on the constraints.

> @@ -547,6 +644,167 @@ out:
>  	return rc;
>  }
> 
> +extern void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av);

Move to avc.h, please.

> +
> +/*
> + * security_boundary_permission - drops violated permissions
> + * on boundary constraint.
> + */
> +static void security_bounded_permission(u16 source_type,
> +					u16 target_type,
> +					u16 tclass,
> +					struct av_decision *avd)
> +{
> +	struct type_datum *source
> +		= policydb.type_val_to_struct[source_type - 1];
> +	struct type_datum *target
> +		= policydb.type_val_to_struct[target_type - 1];
> +	struct av_decision lo_avd;
> +	u32 masked = 0;
> +
> +	if (source->bounds) {
> +		memset(&lo_avd, 0, sizeof(lo_avd));
> +
> +		type_attribute_compute_av(source->bounds,
> +					  target_type,
> +					  tclass,
> +					  AVTAB_ALLOWED,
> +					  &lo_avd);
> +
> +		security_bounded_permission(source->bounds,
> +					    target_type,
> +					    tclass, &lo_avd);

Since you always call type_attribute_compute_av and
security_bounded_permission together, you might as well collapse them or
wrap them with a single interface, right?  Less chance then of the
(stype, ttype, tclass) arguments being inconsistent.

> +
> +/*
> + * security_bounded_transition - check whether the given
> + * transition is directed to bounded, or not.
> + * It returns 0, if @newsid is bounded by @oldsid. Otherwise,
> + * 1 or any other error code can be returned.

Seems somewhat confusing in its return code conventions.
Either return a simple bool (true/false) or return 0 on success and
-errno on failure.  

> + *
> + * @oldsid : current security identifier
> + * @newsid : destinated security identifier
> + */
> +int security_bounded_transition(u32 old_sid, u32 new_sid)
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
> +	/* type/domain unchaned */
> +	if (old_context->type == new_context->type) {
> +		rc = 0;
> +		goto out;
> +	}
> +
> +	index = new_context->type;
> +	while (true) {
> +		type = policydb.type_val_to_struct[index - 1];
> +		if (!type) {
> +			printk(KERN_ERR "SELinux: broken type boundary.\n");
> +			rc = -EINVAL;
> +			break;
> +		}

Are these legitimate runtime conditions or signs of kernel BUGs?
val_to_struct arrays ought to be without holes unless I'm forgetting
something.

> +
> +		/* not bounded anymore */
> +		if (!type->bounds) {
> +			rc = 1;
> +			break;
> +		}
> +
> +		/* @newsid is bounded by @oldsid */
> +		if (type->bounds == old_context->type) {
> +			rc = 0;
> +			break;
> +		}
> +		index = type->bounds;
> +	}
> +out:
> +	read_unlock(&policy_rwlock);
> +
> +	return rc;
> +}
> +
> +
>  /**
>   * security_compute_av - Compute access vector decisions.
>   * @ssid: source security identifier
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
