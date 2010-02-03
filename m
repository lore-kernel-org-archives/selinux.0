Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>
In-Reply-To: <1265211620.3013.2.camel@tesla.lan>
References: <1265211620.3013.2.camel@tesla.lan>
Content-Type: text/plain
Date: Wed, 03 Feb 2010 10:53:48 -0500
Message-Id: <1265212428.12805.4.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-02-03 at 16:40 +0100, Guido Trentalancia wrote:
> Author: Guido Trentalancia <guido@trentalancia.com>
> Date:   Mon Feb 02 23:11:07 2010 +0100
> 
>     Allow runtime switching between different policy types (e.g. from a MLS/MCS
>     policy to a non-MLS/non-MCS policy or viceversa).
> 
>     Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> 
> ---
> 
>  security/selinux/include/security.h |    3 -
>  security/selinux/selinuxfs.c        |    3 -
>  security/selinux/ss/context.h       |   12 -----
>  security/selinux/ss/mls.c           |   26 +++++-----
>  security/selinux/ss/mls.h           |    2 
>  security/selinux/ss/mls_types.h     |    7 --
>  security/selinux/ss/policydb.c      |   24 +---------
>  security/selinux/ss/policydb.h      |    4 +
>  security/selinux/ss/services.c      |   62 +++++++++++++++++++++++---
>  9 files changed, 84 insertions(+), 59 deletions(-)
> 
> diff -pruN security-testing-2.6/security/selinux/include/security.h security-testing-2.6-new/security/selinux/include/security.h
> --- security-testing-2.6/security/selinux/include/security.h	2010-01-29 02:02:47.737045258 +0100
> +++ security-testing-2.6-new/security/selinux/include/security.h	2010-02-01 23:12:28.898233272 +0100
> @@ -57,7 +57,6 @@
>  struct netlbl_lsm_secattr;
>  
>  extern int selinux_enabled;
> -extern int selinux_mls_enabled;
>  
>  /* Policy capabilities */
>  enum {
> @@ -80,6 +79,8 @@ extern int selinux_policycap_openperm;
>  /* limitation of boundary depth  */
>  #define POLICYDB_BOUNDS_MAXDEPTH	4
>  
> +int security_mls_enabled(void);
> +
>  int security_load_policy(void *data, size_t len);
>  
>  int security_policycap_supported(unsigned int req_cap);
> diff -pruN security-testing-2.6/security/selinux/selinuxfs.c security-testing-2.6-new/security/selinux/selinuxfs.c
> --- security-testing-2.6/security/selinux/selinuxfs.c	2010-01-29 02:02:47.738046835 +0100
> +++ security-testing-2.6-new/security/selinux/selinuxfs.c	2010-02-01 22:06:21.709234039 +0100
> @@ -282,7 +282,8 @@ static ssize_t sel_read_mls(struct file 
>  	char tmpbuf[TMPBUFLEN];
>  	ssize_t length;
>  
> -	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", selinux_mls_enabled);
> +	length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
> +			   security_mls_enabled());
>  	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
>  }
>  
> diff -pruN security-testing-2.6/security/selinux/ss/context.h security-testing-2.6-new/security/selinux/ss/context.h
> --- security-testing-2.6/security/selinux/ss/context.h	2010-01-29 01:06:42.160060332 +0100
> +++ security-testing-2.6-new/security/selinux/ss/context.h	2010-02-02 21:49:41.210011207 +0100
> @@ -41,9 +41,6 @@ static inline int mls_context_cpy(struct
>  {
>  	int rc;
>  
> -	if (!selinux_mls_enabled)
> -		return 0;
> -
>  	dst->range.level[0].sens = src->range.level[0].sens;
>  	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
>  	if (rc)
> @@ -64,9 +61,6 @@ static inline int mls_context_cpy_low(st
>  {
>  	int rc;
>  
> -	if (!selinux_mls_enabled)
> -		return 0;
> -
>  	dst->range.level[0].sens = src->range.level[0].sens;
>  	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
>  	if (rc)
> @@ -82,9 +76,6 @@ out:
>  
>  static inline int mls_context_cmp(struct context *c1, struct context *c2)
>  {
> -	if (!selinux_mls_enabled)
> -		return 1;
> -
>  	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
>  		ebitmap_cmp(&c1->range.level[0].cat, &c2->range.level[0].cat) &&
>  		(c1->range.level[1].sens == c2->range.level[1].sens) &&
> @@ -93,9 +84,6 @@ static inline int mls_context_cmp(struct
>  
>  static inline void mls_context_destroy(struct context *c)
>  {
> -	if (!selinux_mls_enabled)
> -		return;
> -
>  	ebitmap_destroy(&c->range.level[0].cat);
>  	ebitmap_destroy(&c->range.level[1].cat);
>  	mls_context_init(c);
> diff -pruN security-testing-2.6/security/selinux/ss/mls.c security-testing-2.6-new/security/selinux/ss/mls.c
> --- security-testing-2.6/security/selinux/ss/mls.c	2010-01-29 02:02:47.739046177 +0100
> +++ security-testing-2.6-new/security/selinux/ss/mls.c	2010-02-01 22:15:48.062233721 +0100
> @@ -39,7 +39,7 @@ int mls_compute_context_len(struct conte
>  	struct ebitmap *e;
>  	struct ebitmap_node *node;
>  
> -	if (!selinux_mls_enabled)
> +	if (!policydb.mls_enabled)
>  		return 0;
>  
>  	len = 1; /* for the beginning ":" */
> @@ -93,7 +93,7 @@ void mls_sid_to_context(struct context *
>  	struct ebitmap *e;
>  	struct ebitmap_node *node;
>  
> -	if (!selinux_mls_enabled)
> +	if (!policydb.mls_enabled)
>  		return;
>  
>  	scontextp = *scontext;
> @@ -200,7 +200,7 @@ int mls_context_isvalid(struct policydb 
>  {
>  	struct user_datum *usrdatum;
>  
> -	if (!selinux_mls_enabled)
> +	if (!p->mls_enabled)
>  		return 1;
>  
>  	if (!mls_range_isvalid(p, &c->range))
> @@ -253,7 +253,7 @@ int mls_context_to_sid(struct policydb *
>  	struct cat_datum *catdatum, *rngdatum;
>  	int l, rc = -EINVAL;
>  
> -	if (!selinux_mls_enabled) {
> +	if (!pol->mls_enabled) {
>  		if (def_sid != SECSID_NULL && oldc)
>  			*scontext += strlen(*scontext)+1;
>  		return 0;
> @@ -387,7 +387,7 @@ int mls_from_string(char *str, struct co
>  	char *tmpstr, *freestr;
>  	int rc;
>  
> -	if (!selinux_mls_enabled)
> +	if (!policydb.mls_enabled)
>  		return -EINVAL;
>  
>  	/* we need freestr because mls_context_to_sid will change
> @@ -407,7 +407,7 @@ int mls_from_string(char *str, struct co
>  /*
>   * Copies the MLS range `range' into `context'.
>   */
> -static inline int mls_range_set(struct context *context,
> +int mls_range_set(struct context *context,
>  				struct mls_range *range)
>  {
>  	int l, rc = 0;
> @@ -427,7 +427,7 @@ static inline int mls_range_set(struct c
>  int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
>  			 struct context *usercon)
>  {
> -	if (selinux_mls_enabled) {
> +	if (policydb.mls_enabled) {
>  		struct mls_level *fromcon_sen = &(fromcon->range.level[0]);
>  		struct mls_level *fromcon_clr = &(fromcon->range.level[1]);
>  		struct mls_level *user_low = &(user->range.level[0]);
> @@ -477,7 +477,7 @@ int mls_convert_context(struct policydb 
>  	struct ebitmap_node *node;
>  	int l, i;
>  
> -	if (!selinux_mls_enabled)
> +	if (!policydb.mls_enabled)
>  		return 0;
>  
>  	for (l = 0; l < 2; l++) {
> @@ -516,7 +516,7 @@ int mls_compute_sid(struct context *scon
>  	struct range_trans rtr;
>  	struct mls_range *r;
>  
> -	if (!selinux_mls_enabled)
> +	if (!policydb.mls_enabled)
>  		return 0;
>  
>  	switch (specified) {
> @@ -559,7 +559,7 @@ int mls_compute_sid(struct context *scon
>  void mls_export_netlbl_lvl(struct context *context,
>  			   struct netlbl_lsm_secattr *secattr)
>  {
> -	if (!selinux_mls_enabled)
> +	if (!policydb.mls_enabled)
>  		return;
>  
>  	secattr->attr.mls.lvl = context->range.level[0].sens - 1;
> @@ -579,7 +579,7 @@ void mls_export_netlbl_lvl(struct contex
>  void mls_import_netlbl_lvl(struct context *context,
>  			   struct netlbl_lsm_secattr *secattr)
>  {
> -	if (!selinux_mls_enabled)
> +	if (!policydb.mls_enabled)
>  		return;
>  
>  	context->range.level[0].sens = secattr->attr.mls.lvl + 1;
> @@ -601,7 +601,7 @@ int mls_export_netlbl_cat(struct context
>  {
>  	int rc;
>  
> -	if (!selinux_mls_enabled)
> +	if (!policydb.mls_enabled)
>  		return 0;
>  
>  	rc = ebitmap_netlbl_export(&context->range.level[0].cat,
> @@ -629,7 +629,7 @@ int mls_import_netlbl_cat(struct context
>  {
>  	int rc;
>  
> -	if (!selinux_mls_enabled)
> +	if (!policydb.mls_enabled)
>  		return 0;
>  
>  	rc = ebitmap_netlbl_import(&context->range.level[0].cat,
> diff -pruN security-testing-2.6/security/selinux/ss/mls.h security-testing-2.6-new/security/selinux/ss/mls.h
> --- security-testing-2.6/security/selinux/ss/mls.h	2010-01-29 01:06:42.168051431 +0100
> +++ security-testing-2.6-new/security/selinux/ss/mls.h	2010-02-01 23:17:31.025223083 +0100
> @@ -39,6 +39,8 @@ int mls_context_to_sid(struct policydb *
>  
>  int mls_from_string(char *str, struct context *context, gfp_t gfp_mask);
>  
> +int mls_range_set(struct context *context, struct mls_range *range);
> +
>  int mls_convert_context(struct policydb *oldp,
>  			struct policydb *newp,
>  			struct context *context);
> diff -pruN security-testing-2.6/security/selinux/ss/mls_types.h security-testing-2.6-new/security/selinux/ss/mls_types.h
> --- security-testing-2.6/security/selinux/ss/mls_types.h	2010-01-29 01:06:42.168051431 +0100
> +++ security-testing-2.6-new/security/selinux/ss/mls_types.h	2010-02-02 21:49:54.108993602 +0100
> @@ -15,6 +15,7 @@
>  #define _SS_MLS_TYPES_H_
>  
>  #include "security.h"
> +#include "ebitmap.h"
>  
>  struct mls_level {
>  	u32 sens;		/* sensitivity */
> @@ -27,18 +28,12 @@ struct mls_range {
>  
>  static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
>  {
> -	if (!selinux_mls_enabled)
> -		return 1;
> -
>  	return ((l1->sens == l2->sens) &&
>  		ebitmap_cmp(&l1->cat, &l2->cat));
>  }
>  
>  static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
>  {
> -	if (!selinux_mls_enabled)
> -		return 1;
> -
>  	return ((l1->sens >= l2->sens) &&
>  		ebitmap_contains(&l1->cat, &l2->cat));
>  }
> diff -pruN security-testing-2.6/security/selinux/ss/policydb.c security-testing-2.6-new/security/selinux/ss/policydb.c
> --- security-testing-2.6/security/selinux/ss/policydb.c	2010-01-29 02:02:47.740046077 +0100
> +++ security-testing-2.6-new/security/selinux/ss/policydb.c	2010-02-01 22:12:18.601226073 +0100
> @@ -52,8 +52,6 @@ static char *symtab_name[SYM_NUM] = {
>  };
>  #endif
>  
> -int selinux_mls_enabled;
> -
>  static unsigned int symtab_sizes[SYM_NUM] = {
>  	2,
>  	32,
> @@ -455,7 +453,7 @@ static int policydb_index_others(struct 
>  
>  	printk(KERN_DEBUG "SELinux:  %d users, %d roles, %d types, %d bools",
>  	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
> -	if (selinux_mls_enabled)
> +	if (p->mls_enabled)
>  		printk(", %d sens, %d cats", p->p_levels.nprim,
>  		       p->p_cats.nprim);
>  	printk("\n");
> @@ -1717,14 +1715,12 @@ int policydb_read(struct policydb *p, vo
>  	int i, j, rc;
>  	__le32 buf[4];
>  	u32 nodebuf[8];
> -	u32 len, len2, config, nprim, nel, nel2;
> +	u32 len, len2, nprim, nel, nel2;
>  	char *policydb_str;
>  	struct policydb_compat_info *info;
>  	struct range_trans *rt;
>  	struct mls_range *r;
>  
> -	config = 0;
> -
>  	rc = policydb_init(p);
>  	if (rc)
>  		goto out;
> @@ -1772,7 +1768,7 @@ int policydb_read(struct policydb *p, vo
>  	kfree(policydb_str);
>  	policydb_str = NULL;
>  
> -	/* Read the version, config, and table sizes. */
> +	/* Read the version and table sizes. */
>  	rc = next_entry(buf, fp, sizeof(u32)*4);
>  	if (rc < 0)
>  		goto bad;
> @@ -1787,13 +1783,7 @@ int policydb_read(struct policydb *p, vo
>  	}
>  
>  	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
> -		if (ss_initialized && !selinux_mls_enabled) {
> -			printk(KERN_ERR "SELinux: Cannot switch between non-MLS"
> -				" and MLS policies\n");
> -			goto bad;
> -		}
> -		selinux_mls_enabled = 1;
> -		config |= POLICYDB_CONFIG_MLS;
> +		p->mls_enabled = 1;
>  
>  		if (p->policyvers < POLICYDB_VERSION_MLS) {
>  			printk(KERN_ERR "SELinux: security policydb version %d "
> @@ -1801,12 +1791,6 @@ int policydb_read(struct policydb *p, vo
>  				p->policyvers);
>  			goto bad;
>  		}
> -	} else {
> -		if (ss_initialized && selinux_mls_enabled) {
> -			printk(KERN_ERR "SELinux: Cannot switch between MLS and"
> -				" non-MLS policies\n");
> -			goto bad;
> -		}
>  	}
>  	p->reject_unknown = !!(le32_to_cpu(buf[1]) & REJECT_UNKNOWN);
>  	p->allow_unknown = !!(le32_to_cpu(buf[1]) & ALLOW_UNKNOWN);
> diff -pruN security-testing-2.6/security/selinux/ss/policydb.h security-testing-2.6-new/security/selinux/ss/policydb.h
> --- security-testing-2.6/security/selinux/ss/policydb.h	2010-01-29 02:02:47.740046077 +0100
> +++ security-testing-2.6-new/security/selinux/ss/policydb.h	2010-02-01 20:47:08.352232380 +0100
> @@ -27,6 +27,8 @@
>  #include "symtab.h"
>  #include "avtab.h"
>  #include "sidtab.h"
> +#include "ebitmap.h"
> +#include "mls_types.h"
>  #include "context.h"
>  #include "constraint.h"
>  
> @@ -185,6 +187,8 @@ struct genfs {
>  
>  /* The policy database */
>  struct policydb {
> +	int mls_enabled;
> +
>  	/* symbol tables */
>  	struct symtab symtab[SYM_NUM];
>  #define p_commons symtab[SYM_COMMONS]
> diff -pruN security-testing-2.6/security/selinux/ss/services.c security-testing-2.6-new/security/selinux/ss/services.c
> --- security-testing-2.6/security/selinux/ss/services.c	2010-01-29 02:02:47.742042805 +0100
> +++ security-testing-2.6-new/security/selinux/ss/services.c	2010-02-02 23:48:07.637994777 +0100
> @@ -26,6 +26,10 @@
>   *
>   *  Added support for bounds domain and audit messaged on masked permissions
>   *
> + * Updated: Guido Trentalancia <guido@trentalancia.com>
> + *
> + *  Added support for runtime switching of the policy type
> + *
>   * Copyright (C) 2008, 2009 NEC Corporation
>   * Copyright (C) 2006, 2007 Hewlett-Packard Development Company, L.P.
>   * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
> @@ -232,6 +236,10 @@ static void map_decision(u16 tclass, str
>  	}
>  }
>  
> +int security_mls_enabled(void)
> +{
> +	return policydb.mls_enabled;
> +}
>  
>  /*
>   * Return the boolean value of a constraint expression
> @@ -1547,6 +1555,8 @@ static int convert_context(u32 key,
>  {
>  	struct convert_context_args *args;
>  	struct context oldc;
> +	struct ocontext *oc;
> +	struct mls_range *range;
>  	struct role_datum *role;
>  	struct type_datum *typdatum;
>  	struct user_datum *usrdatum;
> @@ -1614,9 +1624,39 @@ static int convert_context(u32 key,
>  		goto bad;
>  	c->type = typdatum->value;
>  
> -	rc = mls_convert_context(args->oldp, args->newp, c);
> -	if (rc)
> -		goto bad;
> +	/* Convert the MLS fields if dealing with MLS policies */
> +	if (args->oldp->mls_enabled && args->newp->mls_enabled) {
> +		rc = mls_convert_context(args->oldp, args->newp, c);
> +		if (rc)
> +			goto bad;
> +	} else if (args->oldp->mls_enabled && !args->newp->mls_enabled) {
> +		/*
> +		 * Switching between MLS and non-MLS policy:
> +		 * free any storage used by the MLS fields in the
> +		 * context for all existing entries in the sidtab.
> +		 */
> +		mls_context_destroy(c);
> +	} else if (!args->oldp->mls_enabled && args->newp->mls_enabled) {
> +		/*
> +		 * Switching between non-MLS and MLS policy:
> +		 * ensure that the MLS fields of the context for all
> +		 * existing entries in the sidtab are filled in with a
> +		 * suitable default value, likely taken from one of the
> +		 * initial SIDs.
> +		 */
> +		oc = args->newp->ocontexts[OCON_ISID];
> +		while (oc && oc->sid[0] != SECINITSID_UNLABELED)
> +			oc = oc->next;
> +		if (!oc) {
> +			printk(KERN_ERR "SELinux:  unable to look up"
> +				" the initial SIDs list\n");
> +			goto bad;
> +		}
> +		range = &oc->context[0].range;
> +		rc = mls_range_set(c, range);
> +		if (rc)
> +			goto bad;
> +	}
>  
>  	/* Check the validity of the new context. */
>  	if (!policydb_context_isvalid(args->newp, c)) {
> @@ -1712,6 +1752,12 @@ int security_load_policy(void *data, siz
>  	if (policydb_read(&newpolicydb, fp))
>  		return -EINVAL;
>  
> +	/* If switching between different policy types, log MLS status */
> +	if (policydb.mls_enabled && !newpolicydb.mls_enabled)
> +		printk(KERN_INFO "SELinux: Disabling MLS support...\n");
> +	else if (!policydb.mls_enabled && newpolicydb.mls_enabled)
> +		printk(KERN_INFO "SELinux: Enabling MLS support...\n");
> +
>  	if (sidtab_init(&newsidtab)) {
>  		policydb_destroy(&newpolicydb);
>  		return -ENOMEM;
> @@ -1741,8 +1787,12 @@ int security_load_policy(void *data, siz
>  	args.oldp = &policydb;
>  	args.newp = &newpolicydb;
>  	rc = sidtab_map(&newsidtab, convert_context, &args);
> -	if (rc)
> +	if (rc) {
> +		printk(KERN_ERR "SELinux:  unable to convert the internal"
> +			" representation of contexts in the new SID"
> +			" table\n");
>  		goto err;
> +	}
>  
>  	/* Save the old policydb and SID table to free later. */
>  	memcpy(&oldpolicydb, &policydb, sizeof policydb);
> @@ -2338,7 +2388,7 @@ int security_sid_mls_copy(u32 sid, u32 m
>  	u32 len;
>  	int rc = 0;
>  
> -	if (!ss_initialized || !selinux_mls_enabled) {
> +	if (!ss_initialized || !policydb.mls_enabled) {
>  		*new_sid = sid;
>  		goto out;
>  	}
> @@ -2439,7 +2489,7 @@ int security_net_peersid_resolve(u32 nlb
>  	/* we don't need to check ss_initialized here since the only way both
>  	 * nlbl_sid and xfrm_sid are not equal to SECSID_NULL would be if the
>  	 * security server was initialized and ss_initialized was true */
> -	if (!selinux_mls_enabled) {
> +	if (!policydb.mls_enabled) {
>  		*peer_sid = SECSID_NULL;
>  		return 0;
>  	}
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
