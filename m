Subject: Re: [PATCH 1/3] Thread/Child-Domain Assignment (rev.4)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
In-Reply-To: <48A3E0E8.4000902@ak.jp.nec.com>
References: <487C7698.60503@ak.jp.nec.com>
	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>
	 <487D5A3D.6090801@ak.jp.nec.com>
	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>
	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>
	 <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com>
	 <4897EB5A.1040404@ak.jp.nec.com>
	 <1217940793.2994.52.camel@moss-spartans.epoch.ncsc.mil>
	 <48997937.8050105@ak.jp.nec.com>  <48A3E0E8.4000902@ak.jp.nec.com>
Content-Type: text/plain
Date: Fri, 15 Aug 2008 14:13:20 -0400
Message-Id: <1218824000.29535.315.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-08-14 at 16:38 +0900, KaiGai Kohei wrote:
> The following patch is the revised one for the kernel.
> 
> Joshua suggested it is not necessary to bound type attributes
> based on boundary relationship, and I also agreed this opinion.
> The related code is dropped in this patch, and several code
> cleanup contained.
> 
> This change makes it unnecessary to deliver text represented
> attributes into kernelspace, but related codes are still remained
> for ...
> 
> | Stephen Smalley wrote:
> | An aside:  Possibly we should add the attribute flag at the same time
> | and leave the type attributes in the type symtab in the kernel policy,
> | as previously discussed.  Then the kernel policy won't be lacking any
> | information needed for analysis.  Just need to make sure that
> | context_to_sid doesn't accept attributes in the type field.
> 
> Stephen, could you point out the previous discussion?

Keeping the type attribute names in the types symtab in the kernel
policy allows tools like audit2why and apol to extract the original
attribute names and display them.  I originally shed them because the
kernel didn't need to use that information and we don't want attribute
names to be used in security contexts, but it costs us little to save
them and check for them, and it benefits the tools.

> Thanks,
> 
> [1/3] thread-context-kernel.4.patch
>   It allows a multithreaded process to assign an individual
>   "more bounded" security context, and it also enables to
>   handle binary policy format version 24 in kernel space.
> 
> Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
> --
>  security/selinux/avc.c              |    2 +-
>  security/selinux/hooks.c            |   11 +-
>  security/selinux/include/avc.h      |    4 +
>  security/selinux/include/security.h |   16 ++-
>  security/selinux/ss/policydb.c      |  298 +++++++++++++++++++++++++++++++++--
>  security/selinux/ss/policydb.h      |    5 +
>  security/selinux/ss/services.c      |  227 +++++++++++++++++++++++----
>  7 files changed, 515 insertions(+), 48 deletions(-)

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index bc1c3ae..0201227 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5180,9 +5180,14 @@ static int selinux_setprocattr(struct task_struct *p,
> 
>  		if (sid == 0)
>  			return -EINVAL;
> -
> -		/* Only allow single threaded processes to change context */
> -		if (atomic_read(&p->mm->mm_users) != 1) {
> +		/*
> +		 * SELinux allows to change context in the following case only.
> +		 *  - Single threaded processes.
> +		 *  - Multi threaded processes intend to change its context into
> +		 *    more restricted domain (defined by TYPEBOUNDS statement).
> +		 */
> +		if (atomic_read(&p->mm->mm_users) != 1
> +		    && security_bounded_transition(tsec->sid, sid) != 0) {

Alternatively you could defer the security_bounded_transition() check
until the if (t->mm == mm && t != p) block.  The mm_users check is a
merely a quick check to see whether we need to probe further to
determine whether or not there are any other threads sharing the mm.

>  			struct task_struct *g, *t;
>  			struct mm_struct *mm = p->mm;
>  			read_lock(&tasklist_lock);

> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ad30ac4..3773eb6 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -27,13 +27,14 @@
>  #define POLICYDB_VERSION_RANGETRANS	21
>  #define POLICYDB_VERSION_POLCAP		22
>  #define POLICYDB_VERSION_PERMISSIVE	23
> +#define POLICYDB_VERSION_BOUNDARY	24
> 
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
>  #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
>  #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
>  #else
> -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PERMISSIVE
> +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_BOUNDARY
>  #endif
> 
>  #define CONTEXT_MNT	0x01
> @@ -62,6 +63,17 @@ enum {
>  extern int selinux_policycap_netpeer;
>  extern int selinux_policycap_openperm;
> 
> +/* boundary related definitions */
> +#define POLICYDB_BOUNDS_MAXDEPTH	4
> +#define POLICYDB_BOUNDS_ATTRIBUTE_FLAG	0xffffffff
> +/*
> + * NOTE: When "bounds" field equals POLICYDB_BOUNDS_ATTRIBUTE_FLAG,
> + * it means this entry is attribute, not a normal type.
> + * Boundary feature also requires to deliver attribute info into
> + * kernel space, because it has to notice boundary violation related
> + * to type/attribute relationships.
> + */

It seems a bit ugly to overload the bounds field for this purpose vs.
encoding it into the primary field as you suggest elsewhere.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 84f8cc7..f134322 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
<snip>
> +static int constraint_bounds_sanity_check(struct policydb *p,
> +					  struct constraint_expr *cexpr)
> +{
> +	struct user_datum *user;
> +	struct role_datum *role;
> +	struct type_datum *type;
> +	struct ebitmap_node *node;
> +	unsigned long bit;
> +
> +	/* no need to check boundary constraint */
> +	if (cexpr->expr_type != CEXPR_NAMES)
> +		return 0;
> +
> +	ebitmap_for_each_positive_bit(&cexpr->names, node, bit) {
> +		if (cexpr->attr & CEXPR_USER) {
> +			if (bit >= p->p_users.nprim)
> +				goto broken_ebitmap;
> +
> +			user = p->user_val_to_struct[bit];
> +			if (user->bounds &&
> +			    !ebitmap_get_bit(&cexpr->names, user->bounds - 1)) {
> +				printk(KERN_ERR
> +				       "SELinux: boundary violated cexpr:"
> +				       " CEXPR_NAMES: user:%s bounds:%s\n",
> +				       p->p_user_val_to_name[user->value - 1],
> +				       p->p_user_val_to_name[user->bounds - 1]);
> +				return -EINVAL;
> +			}

What if cexpr->op is CEXPR_NEQ, e.g. the clause was something like
(u1 != untrusteduser)?  Or the entire clause is negated?  I'm not sure
you want to apply these bounds checks on constraints at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
