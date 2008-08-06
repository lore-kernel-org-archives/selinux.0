Message-ID: <4899775C.8040000@ak.jp.nec.com>
Date: Wed, 06 Aug 2008 19:05:16 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] Thread/Child-Domain Assignment (rev.2)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com>	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>	 <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com>	 <4897EB5A.1040404@ak.jp.nec.com> <1217940793.2994.52.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1217940793.2994.52.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for your reviewing.

Stephen Smalley wrote:
> On Tue, 2008-08-05 at 14:55 +0900, KaiGai Kohei wrote:
>> [1/3] thread-context-kernel.2.patch
>>   It allows a multithreaded process to assign an individual
>>   "more bounded" security context, and it also enables to
>>   handle binary policy format version 24 in kernel space.
>>
>> Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
>> --
>>  security/selinux/avc.c              |    2 +-
>>  security/selinux/hooks.c            |   12 +-
>>  security/selinux/include/security.h |    6 +-
>>  security/selinux/ss/policydb.c      |  244 +++++++++++++++++++++++++--
>>  security/selinux/ss/policydb.h      |    4 +
>>  security/selinux/ss/services.c      |  324 +++++++++++++++++++++++++++++++----
>>  6 files changed, 541 insertions(+), 51 deletions(-)
> 
> 
>> @@ -1176,8 +1198,8 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
>>  {
>>  	char *key = NULL;
>>  	struct role_datum *role;
>> -	int rc;
>> -	__le32 buf[2];
>> +	int rc, to_read = 2;
>> +	__le32 buf[3];
>>  	u32 len;
>>
>>  	role = kzalloc(sizeof(*role), GFP_KERNEL);
>> @@ -1186,12 +1208,17 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
>>  		goto out;
>>  	}
>>
>> +	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
>> +		to_read = 3;
>> +
>>  	rc = next_entry(buf, fp, sizeof buf);
> 
> Doesn't this also need to be changed to pass sizeof(buf[0]) * to_read
> rather than sizeof buf?
> Did you try loading an old policy on your new kernel?

It was a bug, fixed at revision 3.

>>  	if (rc < 0)
>>  		goto bad;
>>
>>  	len = le32_to_cpu(buf[0]);
>>  	role->value = le32_to_cpu(buf[1]);
>> +	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
>> +		role->bounds = le32_to_cpu(buf[2]);
>>
>>  	key = kmalloc(len + 1, GFP_KERNEL);
>>  	if (!key) {
> 
>> @@ -1465,6 +1502,181 @@ static int (*read_f[SYM_NUM]) (struct policydb *p, struct hashtab *h, void *fp)
>>  	cat_read,
>>  };
>>
>> +static int user_bounds_sanity_check(void *key, void *datum, void *datap)
>> +{
>> +	struct user_datum *upper, *user;
>> +	struct policydb *p = datap;
>> +	int rc, depth = 0;
>> +
>> +	upper = user = datum;
>> +	while (upper->bounds) {
>> +		struct ebitmap_node *node;
>> +		unsigned long bit;
>> +
>> +		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
>> +			printk(KERN_ERR
>> +			       "SELinux: user %s: too deep bounds\n",
>> +			       (char *) key);
>> +			return -EINVAL;
>> +		}
>> +
>> +		upper = p->user_val_to_struct[upper->bounds - 1];
>> +		if (!upper) {
>> +			printk(KERN_ERR
>> +			       "SELinux: user %s: broken boundary\n",
>> +			       (char *) key);
>> +			return -EINVAL;
>> +		}
>> +		/* drop bounded bit from user->roles */
>> +retry:
>> +		ebitmap_for_each_positive_bit(&user->roles, node, bit) {
>> +			if (ebitmap_get_bit(&upper->roles, bit))
>> +				continue;
>> +
>> +			audit_log(current->audit_context, GFP_KERNEL,
>> +				  AUDIT_SELINUX_ERR,
>> +				  "boundary violation: "
>> +				  "user=%s role=%s bounds=%s",
>> +				  p->p_user_val_to_name[user->value - 1],
>> +				  p->p_role_val_to_name[bit],
>> +				  p->p_user_val_to_name[upper->value - 1]);
>> +
>> +			rc = ebitmap_set_bit(&user->roles, bit, 0);
>> +			if (rc)
>> +				return rc;
>> +			goto retry;
> 
> I would just return an error and abort the policy load on any boundary
> violations detected at load time rather than mutating the policy.

OK, XXXX_bounds_sanity_check() are reworked to return an error and
to abort the policy load.

- snip -

>> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
>> index 4253370..320fa23 100644
>> --- a/security/selinux/ss/policydb.h
>> +++ b/security/selinux/ss/policydb.h
>> @@ -61,6 +61,7 @@ struct class_datum {
>> @@ -81,12 +82,14 @@ struct role_allow {
>>  /* Type attributes */
>>  struct type_datum {
>>  	u32 value;		/* internal type value */
>> +	u32 bounds;		/* boundary of type */
>>  	unsigned char primary;	/* primary name? */
>>  };
> 
> An aside:  Possibly we should add the attribute flag at the same time
> and leave the type attributes in the type symtab in the kernel policy,
> as previously discussed.  Then the kernel policy won't be lacking any
> information needed for analysis.  Just need to make sure that
> context_to_sid doesn't accept attributes in the type field.

I updated the libsepol to deliver attribute entries into kernel space,
and kernel type_datum got a new member to show it is an attribute.
In the policy format, if bounds field of type equals 0xffffffff means
this entry is an attribute.
However, it might be an ad-hoc usage. An alternatice way to deliver
this information is to utilize the "primary" field of type to put
various kind of flags, because it consume 32bit width to represent
1bit information, and rest of 31bit is free.

This reworking also enables to fill up the hole of type_val_to_struct
array, so we don't need to allocate it with kzalloc(). I reverted it
to kmalloc() from kzalloc().
(In the previous revision, we can find NULL for attributes.)

>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> index dcc2e1c..a584c1d 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
> <snip>
>> +static int cexpr_type_names_eval(struct ebitmap *names, u16 type_value)
>> +{
>> +	struct type_datum *type
>> +		= policydb.type_val_to_struct[type_value - 1];
>> +	int bit;
>> +
>> +	while (1) {
> 
> You were using while (true) in the prior functions.  We should be
> consistent one way or the other.

Oops, I left it as integer value unawares.
However, cexpr_XXXX_names_eval() were reverted on the next revision. :-)

>> +		bit = ebitmap_get_bit(names, type->value - 1);
>> +		if (!bit) {
>> +			if (type->value != type_value)
>> +				audit_log(current->audit_context,
>> +					  GFP_ATOMIC, AUDIT_SELINUX_ERR,
>> +					  "boundary violation: "
>> +					  "type=%s bounded=%s",
>> +					  policydb.p_type_val_to_name[type_value - 1],
>> +					  policydb.p_type_val_to_name[type->value - 1]);
>> +			break;
>> +		}
>> +		if (!type->bounds)
>> +			break;
>> +		type = policydb.type_val_to_struct[type->bounds - 1];
>> +	}
> 
> I don't think we ought to be doing this checking here, if at all.
> Either we vet the constraints for internal consistency at load time, or
> we view the bounds as purely a limit on the TE rules and not necessarily
> on the constraints.

I think the boundary rules also should be applied on the constraints.
For example, we can assume a case when a bounded type can have "mcssetcats"
attribute, even if its bounds type does not have the attribute.
It seems to me a bit strange behavior.

I reverted it and put a code to check boundary consistency at the policy
load time. (constraint_bounds_sanity_check())

>> @@ -547,6 +644,167 @@ out:
>>  	return rc;
>>  }
>>
>> +extern void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av);
> 
> Move to avc.h, please.

OK, moved.

>> +
>> +/*
>> + * security_boundary_permission - drops violated permissions
>> + * on boundary constraint.
>> + */
>> +static void security_bounded_permission(u16 source_type,
>> +					u16 target_type,
>> +					u16 tclass,
>> +					struct av_decision *avd)
>> +{
>> +	struct type_datum *source
>> +		= policydb.type_val_to_struct[source_type - 1];
>> +	struct type_datum *target
>> +		= policydb.type_val_to_struct[target_type - 1];
>> +	struct av_decision lo_avd;
>> +	u32 masked = 0;
>> +
>> +	if (source->bounds) {
>> +		memset(&lo_avd, 0, sizeof(lo_avd));
>> +
>> +		type_attribute_compute_av(source->bounds,
>> +					  target_type,
>> +					  tclass,
>> +					  AVTAB_ALLOWED,
>> +					  &lo_avd);
>> +
>> +		security_bounded_permission(source->bounds,
>> +					    target_type,
>> +					    tclass, &lo_avd);
> 
> Since you always call type_attribute_compute_av and
> security_bounded_permission together, you might as well collapse them or
> wrap them with a single interface, right?  Less chance then of the
> (stype, ttype, tclass) arguments being inconsistent.

I moved the boundary checks into type_attribute_compute_av().


>> +
>> +/*
>> + * security_bounded_transition - check whether the given
>> + * transition is directed to bounded, or not.
>> + * It returns 0, if @newsid is bounded by @oldsid. Otherwise,
>> + * 1 or any other error code can be returned.
> 
> Seems somewhat confusing in its return code conventions.
> Either return a simple bool (true/false) or return 0 on success and
> -errno on failure.  

OK, it was reworked to return 0 (success) or negative error code.

>> + *
>> + * @oldsid : current security identifier
>> + * @newsid : destinated security identifier
>> + */
>> +int security_bounded_transition(u32 old_sid, u32 new_sid)
>> +{
>> +	struct context *old_context, *new_context;
>> +	struct type_datum *type;
>> +	int index;
>> +	int rc = -EINVAL;
>> +
>> +	read_lock(&policy_rwlock);
>> +
>> +	old_context = sidtab_search(&sidtab, old_sid);
>> +	if (!old_context) {
>> +		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
>> +		       __func__, old_sid);
>> +		goto out;
>> +	}
>> +
>> +	new_context = sidtab_search(&sidtab, new_sid);
>> +	if (!new_context) {
>> +		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
>> +		       __func__, new_sid);
>> +		goto out;
>> +	}
>> +
>> +	/* type/domain unchaned */
>> +	if (old_context->type == new_context->type) {
>> +		rc = 0;
>> +		goto out;
>> +	}
>> +
>> +	index = new_context->type;
>> +	while (true) {
>> +		type = policydb.type_val_to_struct[index - 1];
>> +		if (!type) {
>> +			printk(KERN_ERR "SELinux: broken type boundary.\n");
>> +			rc = -EINVAL;
>> +			break;
>> +		}
> 
> Are these legitimate runtime conditions or signs of kernel BUGs?
> val_to_struct arrays ought to be without holes unless I'm forgetting
> something.

There was no guarantee the bounds does not indicate the hole of
type_val_to_struct array due to attributes.
However, delivering attribute into kernelspace kills the hole.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
