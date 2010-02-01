Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org
In-Reply-To: <201001312243.o0VMh9qn023003@vivaldi39.register.it>
References: <201001312243.o0VMh9qn023003@vivaldi39.register.it>
Content-Type: text/plain
Date: Mon, 01 Feb 2010 10:28:51 -0500
Message-Id: <1265038131.12435.139.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2010-01-31 at 23:43 +0100, Guido Trentalancia wrote:
> Dear Stephen,
> 
> I have created the patch for allowing runtime switch between different policy types, according to your advice and previous discussions on this mailing list. The patch obsoletes the small piece of documentation that I wrote a few days ago to help new users cope with the limitation.
> 
> I would be very grateful if you could review the patch so that, as soon as it is reviewed, it can be posted to the kernel mailing list. I have done some basic testing and it works on one of my systems, although sometimes I get the following side-effect:
> 
> /dev/pts/0 changed labels.
> Unable to restore tty label...
> 
> which however doesn't affect the system. I am not sure where that comes from (perhaps bash)...

pam_selinux and openssh set the tty label on session open and restore it
upon session close.  But if it changes in the interim, they won't
restore it.  Switching MLS status will appear to change the tty label
because of the addition or removal of the MLS suffix.  I guess we'll
have to think about how/whether the userspace logic should change.

> Regards,
> 
> Guido Trentalancia
> 
> Author: Guido Trentalancia <guido@trentalancia.com>
> Date:   Sun Jan 31 22:10:22 2010 +0100
> 
>     Allow runtime switching between different policy types (e.g. from a MLS/MCS
>     policy to a non-MLS/non-MCS policy or viceversa).
> 
>     Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> 
> diff -pruN security-testing-2.6/security/selinux/Makefile security-testing-2.6-new/security/selinux/Makefile
> --- security-testing-2.6/security/selinux/Makefile	2010-01-29 01:06:42.132070393 +0100
> +++ security-testing-2.6-new/security/selinux/Makefile	2010-01-29 02:13:42.497044862 +0100
> @@ -18,7 +18,7 @@ selinux-$(CONFIG_SECURITY_NETWORK_XFRM) 
>  
>  selinux-$(CONFIG_NETLABEL) += netlabel.o
>  
> -EXTRA_CFLAGS += -Isecurity/selinux -Isecurity/selinux/include
> +EXTRA_CFLAGS += -Isecurity/selinux -Isecurity/selinux/ss -Isecurity/selinux/include
>  
>  $(obj)/avc.o: $(obj)/flask.h

We don't want to do this.  The ss/ subdirectory contains the "security
server", which is the policy engine.  It should only interact with the
rest of SELinux through a well-defined interface to preserve the
encapsulation of the security policy.  The ss/ header files are private
to it.  Instead, define interfaces as needed in include/security.h and
use them.

> diff -pruN security-testing-2.6/security/selinux/selinuxfs.c security-testing-2.6-new/security/selinux/selinuxfs.c
> --- security-testing-2.6/security/selinux/selinuxfs.c	2010-01-29 02:02:47.738046835 +0100
> +++ security-testing-2.6-new/security/selinux/selinuxfs.c	2010-01-31 23:17:44.494329730 +0100
> @@ -38,6 +38,10 @@
>  #include "security.h"
>  #include "objsec.h"
>  #include "conditional.h"
> +#include "services.h"
> +#include "policydb.h"
> +
> +extern struct policydb policydb;

Avoid adding extern declarations to .c files - they are discouraged.
The current code isn't pristine in this regard, but let's not make it
worse.

>  
>  /* Policy capability filenames */
>  static char *policycap_names[] = {
> @@ -282,7 +286,8 @@ static ssize_t sel_read_mls(struct file 
>  	char tmpbuf[TMPBUFLEN];
>  	ssize_t length;
>  
> -	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", selinux_mls_enabled);
> +	length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
> +		policydb.selinux_mls_enabled);
>  	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
>  }

The correct way to do this would be to add a security_mls_enabled()
function to ss/services.c, with a function prototype in
include/security.h, and call that function.  Internally that function
can then read policydb.selinux_mls_enabled.

I'd also suggest just naming the field mls_enabled or mls, as you no
longer need the selinux_ prefix once it is a struct member rather than a
global variable.

> diff -pruN security-testing-2.6/security/selinux/ss/context.c security-testing-2.6-new/security/selinux/ss/context.c
> --- security-testing-2.6/security/selinux/ss/context.c	1970-01-01 01:00:00.000000000 +0100
> +++ security-testing-2.6-new/security/selinux/ss/context.c	2010-01-31 21:39:01.293500739 +0100
> @@ -0,0 +1,131 @@
> +/*
> + * Security context auxiliary functions
> + *
> + * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
> + */
> +
> +#include "context.h"
> +#include "ebitmap.h"
> +#include "mls_types.h"
> +#include "security.h"
> +#include "policydb.h"
> +
> +inline void mls_context_init(struct context *c)
> +{
> +	memset(&c->range, 0, sizeof(c->range));
> +}

I wouldn't take these functions to their own .c file, and if you do so,
then "inline" no longer makes sense.  But why did you do so?  It will
add overhead to make them out-of-line with no obvious benefit.

> +inline void mls_context_destroy(struct policydb *p, struct context *c)
> +{
> +	if (!p->selinux_mls_enabled)
> +		return;

This seems inconsistent with the other functions - here you pass the
policydb as an argument rather than just using the active policydb.
If that were truly necessary, I'd argue for passing the policydb to all
of the functions for consistency.  But I think in fact that we can drop
this !mls_enabled check altogether, given that the context is fully
initialized by context_init() and thus the ebitmap_destroy() calls
should be safe regardless of whether or not MLS is enabled.

> +	ebitmap_destroy(&c->range.level[0].cat);
> +	ebitmap_destroy(&c->range.level[1].cat);
> +	mls_context_init(c);
> +}
> +

> diff -pruN security-testing-2.6/security/selinux/ss/mls.h security-testing-2.6-new/security/selinux/ss/mls.h
> --- security-testing-2.6/security/selinux/ss/mls.h	2010-01-29 01:06:42.168051431 +0100
> +++ security-testing-2.6-new/security/selinux/ss/mls.h	2010-01-31 21:50:17.923330980 +0100
> @@ -24,6 +24,8 @@
>  #include "context.h"
>  #include "policydb.h"
>  
> +extern struct policydb policydb;
> +
>  int mls_compute_context_len(struct context *context);
>  void mls_sid_to_context(struct context *context, char **scontext);
>  int mls_context_isvalid(struct policydb *p, struct context *c);
> @@ -39,6 +41,8 @@ int mls_context_to_sid(struct policydb *
>  
>  int mls_from_string(char *str, struct context *context, gfp_t gfp_mask);
>  
> +inline int mls_range_set(struct context *context, struct mls_range *range);

Doesn't make sense to make it inline if it isn't defined here, and if it
were, it would need to be static inline.

> +
>  int mls_convert_context(struct policydb *oldp,
>  			struct policydb *newp,
>  			struct context *context);
> diff -pruN security-testing-2.6/security/selinux/ss/mls_types.c security-testing-2.6-new/security/selinux/ss/mls_types.c
> --- security-testing-2.6/security/selinux/ss/mls_types.c	1970-01-01 01:00:00.000000000 +0100
> +++ security-testing-2.6-new/security/selinux/ss/mls_types.c	2010-01-29 02:36:49.528045041 +0100
> @@ -0,0 +1,27 @@
> +/*
> + * Auxiliary functions for the multi-level security (MLS) policy.
> + *
> + * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
> + */
> +
> +#include "mls_types.h"
> +#include "policydb.h"
> +
> +inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
> +{
> +	if (!policydb.selinux_mls_enabled)
> +		return 1;
> +
> +	return ((l1->sens == l2->sens) &&
> +		ebitmap_cmp(&l1->cat, &l2->cat));
> +}
> +
> +inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
> +{
> +	if (!policydb.selinux_mls_enabled)
> +		return 1;
> +
> +	return ((l1->sens >= l2->sens) &&
> +		ebitmap_contains(&l1->cat, &l2->cat));
> +}
> +

Same deal - don't take these to their own .c file without justification.

> diff -pruN security-testing-2.6/security/selinux/ss/policydb.c security-testing-2.6-new/security/selinux/ss/policydb.c
> --- security-testing-2.6/security/selinux/ss/policydb.c	2010-01-29 02:02:47.740046077 +0100
> +++ security-testing-2.6-new/security/selinux/ss/policydb.c	2010-01-31 21:41:44.306327882 +0100
> @@ -656,10 +654,10 @@ static int range_tr_destroy(void *key, v
>  	return 0;
>  }
>  
> -static void ocontext_destroy(struct ocontext *c, int i)
> +static void ocontext_destroy(struct policydb *p, struct ocontext *c, int i)
>  {
> -	context_destroy(&c->context[0]);
> -	context_destroy(&c->context[1]);
> +	context_destroy(p, &c->context[0]);
> +	context_destroy(p, &c->context[1]);

I think we can avoid the need for passing the policydb here, as
mentioned above for mls_context_destroy.

> @@ -1787,12 +1785,7 @@ int policydb_read(struct policydb *p, vo
>  	}
>  
>  	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
> -		if (ss_initialized && !selinux_mls_enabled) {
> -			printk(KERN_ERR "SELinux: Cannot switch between non-MLS"
> -				" and MLS policiesn");
> -			goto bad;
> -		}
> -		selinux_mls_enabled = 1;
> +		p->selinux_mls_enabled = 1;
>  		config |= POLICYDB_CONFIG_MLS;

It looks like this "config" variable might be a leftover of older logic
and can be removed altogether?

> diff -pruN security-testing-2.6/security/selinux/ss/policydb.h security-testing-2.6-new/security/selinux/ss/policydb.h
> --- security-testing-2.6/security/selinux/ss/policydb.h	2010-01-29 02:02:47.740046077 +0100
> +++ security-testing-2.6-new/security/selinux/ss/policydb.h	2010-01-29 02:33:01.393045934 +0100
> @@ -185,6 +185,8 @@ struct genfs {
>  
>  /* The policy database */
>  struct policydb {
> +	int selinux_mls_enabled;

Just call it mls or mls_enabled.

> +
>  	/* symbol tables */
>  	struct symtab symtab[SYM_NUM];
>  #define p_commons symtab[SYM_COMMONS]
> diff -pruN security-testing-2.6/security/selinux/ss/services.c security-testing-2.6-new/security/selinux/ss/services.c
> --- security-testing-2.6/security/selinux/ss/services.c	2010-01-29 02:02:47.742042805 +0100
> +++ security-testing-2.6-new/security/selinux/ss/services.c	2010-01-31 23:28:26.440336638 +0100
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
> @@ -1145,7 +1149,7 @@ static int string_to_context_struct(stru
>  	rc = 0;
>  out:
>  	if (rc)
> -		context_destroy(ctx);
> +		context_destroy(pol, ctx);

Unnecessary I think, as before.

>  	return rc;
>  }
>  

> @@ -1547,6 +1551,8 @@ static int convert_context(u32 key,
>  {
>  	struct convert_context_args *args;
>  	struct context oldc;
> +	struct ocontext *oc;
> +	struct mls_range *range;
>  	struct role_datum *role;
>  	struct type_datum *typdatum;
>  	struct user_datum *usrdatum;
> @@ -1614,9 +1620,29 @@ static int convert_context(u32 key,
>  		goto bad;
>  	c->type = typdatum->value;
>  
> -	rc = mls_convert_context(args->oldp, args->newp, c);
> -	if (rc)
> -		goto bad;
> +	/* Convert the MLS/MCS fields or deal with policy type switch */
> +	if (args->oldp->selinux_mls_enabled
> +	    && args->newp->selinux_mls_enabled) {
> +		rc = mls_convert_context(args->oldp, args->newp, c);
> +		if (rc)
> +			goto bad;
> +	} else if (args->oldp->selinux_mls_enabled
> +		   && !args->newp->selinux_mls_enabled)
> +	/* Switching between MLS/MCS and non-MLS/non-MCS policy: */
> +	/* free any storage used by the MLS fields in the        */
> +	/* context for all existing entries in the sidtab.       */
> +		mls_context_destroy(args->oldp, c);
> +	else if (!args->oldp->selinux_mls_enabled
> +		 && args->newp->selinux_mls_enabled) {
> +	/* Switching between non-MLS/non-MCS and MLS/MCS policy:  */
> +	/* ensure that the MLS fields of the context for all      */
> +	/* existing entries in the sidtab are filled in with a    */
> +	/* suitable default value, likely taken from one of the   */
> +	/* initial SIDs.                                          */
> +		oc = args->newp->ocontexts[OCON_ISID];
> +		range = &oc->context[0].range;
> +		mls_range_set(c, range);

This could fail due to ENOMEM, so check and handle errors.
Comment style is wrong also, see CodingStyle and use checkpatch.pl.


> @@ -1712,6 +1738,15 @@ int security_load_policy(void *data, siz
>  	if (policydb_read(&newpolicydb, fp))
>  		return -EINVAL;
>  
> +	/* If switching between different policy types, log it */
> +	if (policydb.selinux_mls_enabled && newpolicydb.selinux_mls_enabled)
> +		printk(KERN_INFO "SELinux: Switching between MLS/MCS"
> +			" and standard policy...n");

Is that supposed to be "\n" aka newline rather than just "n"?

> +	else if (!policydb.selinux_mls_enabled
> +	  && newpolicydb.selinux_mls_enabled)
> +		printk(KERN_INFO "SELinux: Switching between standard"
> +			" and MLS/MCS policy...n");

Ditto.

> +
>  	if (sidtab_init(&newsidtab)) {
>  		policydb_destroy(&newpolicydb);
>  		return -ENOMEM;
> @@ -1741,8 +1776,12 @@ int security_load_policy(void *data, siz
>  	args.oldp = &policydb;
>  	args.newp = &newpolicydb;
>  	rc = sidtab_map(&newsidtab, convert_context, &args);
> -	if (rc)
> +	if (rc) {
> +		printk(KERN_ERR "SELinux:  unable to convert the internal"
> +			" representation of contexts in the new SID"
> +			" tablen");

Ditto.


> diff -pruN security-testing-2.6/security/selinux/ss/services.h security-testing-2.6-new/security/selinux/ss/services.h
> --- security-testing-2.6/security/selinux/ss/services.h	2010-01-29 01:06:42.174044406 +0100
> +++ security-testing-2.6-new/security/selinux/ss/services.h	2010-01-31 23:24:36.677347711 +0100
> @@ -3,6 +3,7 @@
>   *
>   * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
>   */
> +
>  #ifndef _SS_SERVICES_H_
>  #define _SS_SERVICES_H_
>  
> @@ -11,5 +12,51 @@
>  
>  extern struct policydb policydb;
>  
> +int security_bounded_transition(u32 old_sid, u32 new_sid);
> +void security_compute_av(u32 ssid, u32 tsid, u16 orig_tclass,
> +			 struct av_decision *avd);
> +void security_compute_av_user(u32 ssid, u32 tsid, u16 tclass,
> +			      struct av_decision *avd);
> +const char *security_get_initial_sid_context(u32 sid);
> +int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len);
> +int security_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len);
> +int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid);
> +int security_context_to_sid_default(const char *scontext, u32 scontext_len,
> +				    u32 *sid, u32 def_sid, gfp_t gfp_flags);
> +int security_context_to_sid_force(const char *scontext, u32 scontext_len,
> +				  u32 *sid);
> +int security_transition_sid(u32 ssid, u32 tsid, u16 tclass, u32 *out_sid);
> +int security_transition_sid_user(u32 ssid, u32 tsid, u16 tclass, u32 *out_sid);
> +int security_member_sid(u32 ssid, u32 tsid, u16 tclass, u32 *out_sid);
> +int security_change_sid(u32 ssid, u32 tsid, u16 tclass, u32 *out_sid);
> +int security_load_policy(void *data, size_t len);
> +int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
> +int security_netif_sid(char *name, u32 *if_sid);
> +int security_node_sid(u16 domain, void *addrp, u32 addrlen, u32 *out_sid);
> +int security_get_user_sids(u32 fromsid, char *username, u32 **sids, u32 *nel);
> +int security_genfs_sid(const char *fstype, char *path, u16 orig_sclass,
> +		       u32 *sid);
> +int security_fs_use(const char *fstype, unsigned int *behavior, u32 *sid);
> +int security_get_bools(int *len, char ***names, int **values);
> +int security_set_bools(int len, int *values);
> +int security_get_bool_value(int bool);
> +int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
> +int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type, u32 xfrm_sid,
> +				 u32 *peer_sid);
> +int security_get_classes(char ***classes, int *nclasses);
> +int security_get_permissions(char *class, char ***perms, int *nperms);
> +int security_get_reject_unknown(void);
> +int security_get_allow_unknown(void);
> +int security_policycap_supported(unsigned int req_cap);
> +void selinux_audit_rule_free(void *vrule);
> +int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule);
> +int selinux_audit_rule_known(struct audit_krule *rule);
> +int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
> +			     struct audit_context *actx);
> +int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
> +				   u32 *sid);
> +int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr);
> +
> +
>  #endif	/* _SS_SERVICES_H_ */

No, you don't want to move these here.  This is private to ss/.
 
> diff -pruN security-testing-2.6/security/selinux/ss/sidtab.c security-testing-2.6-new/security/selinux/ss/sidtab.c
> --- security-testing-2.6/security/selinux/ss/sidtab.c	2010-01-29 01:06:42.174044406 +0100
> +++ security-testing-2.6-new/security/selinux/ss/sidtab.c	2010-01-31 21:42:55.649896349 +0100
> @@ -232,7 +232,7 @@ void sidtab_hash_eval(struct sidtab *h, 
>  	       max_chain_len);
>  }
>  
> -void sidtab_destroy(struct sidtab *s)
> +void sidtab_destroy(struct policydb *p, struct sidtab *s)

As before, I think we can avoid this by just making
mls_context_destroy() unconditional.  Should be harmless, just like
free(NULL).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
