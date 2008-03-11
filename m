Subject: Re: [PATCH-v3] SELinux: introduce permissive types
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>, jmorris@namei.org,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1205188557.5297.66.camel@localhost.localdomain>
References: <1205188557.5297.66.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 11:18:04 -0400
Message-Id: <1205248684.23866.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-10 at 18:35 -0400, Eric Paris wrote:
> Introduce the concept of a permissive type.  A new ebitmap is introduced
> to the policy database which indicates if a given type has the
> permissive bit set or not.  This bit is tested for the scontext of any
> denial.  The bit is meaningless on types which only appear as the target
> of a decision and never the source.  A domain running with a permissive
> type will be allowed to perform any action similarly to when the system
> is globally set permissive.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> ---
> 
> - Threw out all of the atomic stuff.  Either the sid is going to get
> mapped to unlabeled or to the right context in the new policydb and will
> be the new type number and all will be well.  As usual I was just making
> things harder on myself.

Technically, the following could still happen:
- policy has domain marked as permissive and does not allow an access,
- the AVC determines that the access is denied and is following the
permissive code path but has not yet taken the policy rdlock,
- policy is reloaded with domain marked as non-permissive with access
allowed,
- security_permissive_sid is called and takes the policy rdlock,
- the domain is found to be non-permissive,
- the AVC denies the access.

Particularly if we do something like:
- insert policy module that just makes a domain permissive,
- run for a while collecting audit messages,
- generate new policy module from audit messages,
- replace the permissive policy module with the one that contains the
allows.

Don't know if you are concerned about the above, but it could create
mysterious breakage.

> - moved !requested into its own handling

Separate patch, put it first, and I think BUG_ON is cleaner there.

> - dropped unlikely() around the permissive sid, because really, if we
> get a denial and we are selinux_enforcing its actually not all that
> unlikely that we might not have a permissive domain.  Just let the
> compiler do its thing.

Ok.

> - dropped the test for the existence of node.  avc_update_node might
> return -ENOENT, but really who cares?  We are on a slow code path here
> so it seems to be needless complexity.  Isn't this code nice and clear
> now?  I can add it in, but its just a slight perf win and not much
> else..

Seems fine - we will rarely not have a node (requires that there not
already be a node for the key, and that the allocation of a new node
fail), and it is harmless to proceed.
> 
>  security/selinux/Kconfig            |    2 +-
>  security/selinux/avc.c              |   18 +++++++++++++-----
>  security/selinux/include/security.h |    5 ++++-
>  security/selinux/ss/policydb.c      |   11 +++++++++++
>  security/selinux/ss/policydb.h      |    2 ++
>  security/selinux/ss/services.c      |   21 +++++++++++++++++++++
>  6 files changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 2b517d6..a436d1c 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -145,7 +145,7 @@ config SECURITY_SELINUX_POLICYDB_VERSION_MAX
>  config SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
>  	int "NSA SELinux maximum supported policy format version value"
>  	depends on SECURITY_SELINUX_POLICYDB_VERSION_MAX
> -	range 15 22
> +	range 15 23
>  	default 19
>  	help
>  	  This option sets the value for the maximum policy format version
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 187964e..8d78b88 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -890,13 +890,21 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  
>  	denied = requested & ~(p_ae->avd.allowed);
>  
> -	if (!requested || denied) {
> -		if (selinux_enforcing || (flags & AVC_STRICT))
> +	if (unlikely(!requested)) {
> +		printk(KERN_ERR "%s: found !requested, fix me\n", __func__);

Likely want SELinux somewhere in that message for clarity.

> +		WARN_ON(1);
> +		if (selinux_enforcing)
>  			rc = -EACCES;

Simpler as a BUG_ON, and correct.

> +	}
> +
> +	if (denied) {
> +		if (flags & AVC_STRICT)
> +			rc = -EACCES;
> +		else if (!selinux_enforcing || security_permissive_sid(ssid))
> +			avc_update_node(AVC_CALLBACK_GRANT, requested, ssid,
> +					tsid, tclass);
>  		else
> -			if (node)
> -				avc_update_node(AVC_CALLBACK_GRANT,requested,
> -						ssid,tsid,tclass);
> +			rc = -EACCES;
>  	}
>  
>  	rcu_read_unlock();
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index f7d2f03..fde8690 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -26,13 +26,14 @@
>  #define POLICYDB_VERSION_AVTAB		20
>  #define POLICYDB_VERSION_RANGETRANS	21
>  #define POLICYDB_VERSION_POLCAP		22
> +#define POLICYDB_VERSION_PERMISSIVE	23
>  
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
>  #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
>  #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
>  #else
> -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_POLCAP
> +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PERMISSIVE
>  #endif
>  
>  #define CONTEXT_MNT	0x01
> @@ -67,6 +68,8 @@ struct av_decision {
>  	u32 seqno;
>  };
>  
> +int security_permissive_sid(u32 sid);
> +
>  int security_compute_av(u32 ssid, u32 tsid,
>  	u16 tclass, u32 requested,
>  	struct av_decision *avd);
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index bd7d6a0..84dbab9 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -111,6 +111,11 @@ static struct policydb_compat_info policydb_compat[] = {
>  		.version	= POLICYDB_VERSION_POLCAP,
>  		.sym_num	= SYM_NUM,
>  		.ocon_num	= OCON_NUM,
> +	},
> +	{
> +		.version	= POLICYDB_VERSION_PERMISSIVE,
> +		.sym_num	= SYM_NUM,
> +		.ocon_num	= OCON_NUM,
>  	}
>  };
>  
> @@ -194,6 +199,7 @@ static int policydb_init(struct policydb *p)
>  		goto out_free_symtab;
>  
>  	ebitmap_init(&p->policycaps);
> +	ebitmap_init(&p->permissive_map);
>  
>  out:
>  	return rc;
> @@ -687,6 +693,7 @@ void policydb_destroy(struct policydb *p)
>  	kfree(p->type_attr_map);
>  	kfree(p->undefined_perms);
>  	ebitmap_destroy(&p->policycaps);
> +	ebitmap_destroy(&p->permissive_map);
>  
>  	return;
>  }
> @@ -1570,6 +1577,10 @@ int policydb_read(struct policydb *p, void *fp)
>  	    ebitmap_read(&p->policycaps, fp) != 0)
>  		goto bad;
>  
> +	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE &&
> +	    ebitmap_read(&p->permissive_map, fp) != 0)
> +		goto bad;
> +
>  	info = policydb_lookup_compat(p->policyvers);
>  	if (!info) {
>  		printk(KERN_ERR "security:  unable to find policy compat info "
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index c4ce996..ba593a3 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -243,6 +243,8 @@ struct policydb {
>  
>  	struct ebitmap policycaps;
>  
> +	struct ebitmap permissive_map;
> +
>  	unsigned int policyvers;
>  
>  	unsigned int reject_unknown : 1;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index f374186..f5d1dcc 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -416,6 +416,27 @@ inval_class:
>  	return -EINVAL;
>  }
>  
> +/*
> + * Given a sid find if the type has the permissive flag set
> + */
> +int security_permissive_sid(u32 sid)
> +{
> +	struct context *context;
> +	u32 type;
> +	int rc;
> +
> +	POLICY_RDLOCK;
> +
> +	context = sidtab_search(&sidtab, sid);
> +	BUG_ON(!context);
> +
> +	type = context->type;
> +	rc = ebitmap_get_bit(&policydb.permissive_map, type);

Maybe a comment then to note that we are intentionally not using (type -
1) here due to possibly global use of that bit - otherwise it is a
confusing inconsistency with other ebitmap_get_bit calls.

> +
> +	POLICY_RDUNLOCK;
> +	return rc;
> +}
> +
>  static int security_validtrans_handle_fail(struct context *ocontext,
>                                             struct context *ncontext,
>                                             struct context *tcontext,
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
