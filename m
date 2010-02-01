Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org
In-Reply-To: <201002012149.o11LnOVX005278@vivaldi39.register.it>
References: <201002012149.o11LnOVX005278@vivaldi39.register.it>
Content-Type: text/plain
Date: Mon, 01 Feb 2010 17:09:23 -0500
Message-Id: <1265062163.12435.339.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-02-01 at 22:49 +0100, Guido Trentalancia wrote:
> Stephen,
> 
> yes you are right. There is no need to include policydb.h from security.h.
> 
> Please have a further look at the attached revised patch, while I do some testing of the resulting compiled kernel. I hope I did not miss any amendment.
> 
> If it is fine and nobody else has comments or suggestions to make, then we should probably post it to the kernel mailing list with your Acked-by or Reviewed-by line.
> 
> Best regards,
> 
> Guido
> 
> Author: Guido Trentalancia <guido@trentalancia.com>
> Date:   Mon Feb 01 22:34:16 2010 +0100
> 
>     Allow runtime switching between different policy types (e.g. from a MLS/MCS
>     policy to a non-MLS/non-MCS policy or viceversa).
> 
>     Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> 
> diff -pruN security-testing-2.6/security/selinux/include/security.h security-testing-2.6-new/security/selinux/include/security.h
> --- security-testing-2.6/security/selinux/include/security.h	2010-01-29 02:02:47.737045258 +0100
> +++ security-testing-2.6-new/security/selinux/include/security.h	2010-02-01 22:06:38.053225052 +0100
> @@ -57,7 +57,7 @@
>  struct netlbl_lsm_secattr;
>  
>  extern int selinux_enabled;
> -extern int selinux_mls_enabled;
> +extern struct policydb policydb;

Oops.

> diff -pruN security-testing-2.6/security/selinux/ss/constraint.h security-testing-2.6-new/security/selinux/ss/constraint.h
> --- security-testing-2.6/security/selinux/ss/constraint.h	2010-01-29 01:06:42.160060332 +0100
> +++ security-testing-2.6-new/security/selinux/ss/constraint.h	2010-02-01 20:50:19.860227025 +0100
> @@ -12,6 +12,7 @@
>   *
>   * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
>   */
> +
>  #ifndef _SS_CONSTRAINT_H_
>  #define _SS_CONSTRAINT_H_

Avoid extraneous whitespace changes.

> diff -pruN security-testing-2.6/security/selinux/ss/context.h security-testing-2.6-new/security/selinux/ss/context.h
> --- security-testing-2.6/security/selinux/ss/context.h	2010-01-29 01:06:42.160060332 +0100
> +++ security-testing-2.6-new/security/selinux/ss/context.h	2010-02-01 22:22:33.090234587 +0100
> @@ -12,6 +12,7 @@
>   *
>   * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
>   */
> +
>  #ifndef _SS_CONTEXT_H_
>  #define _SS_CONTEXT_H_
>  

Ditto.


> diff -pruN security-testing-2.6/security/selinux/ss/mls.h security-testing-2.6-new/security/selinux/ss/mls.h
> --- security-testing-2.6/security/selinux/ss/mls.h	2010-01-29 01:06:42.168051431 +0100
> +++ security-testing-2.6-new/security/selinux/ss/mls.h	2010-02-01 18:57:42.693221952 +0100
> @@ -24,6 +24,8 @@
>  #include "context.h"
>  #include "policydb.h"
>  
> +extern struct policydb policydb;

This shouldn't be needed.  Whatever needs the extern decl can #include
"services.h".

> @@ -1614,9 +1630,48 @@ static int convert_context(u32 key,
>  		goto bad;
>  	c->type = typdatum->value;
>  
> -	rc = mls_convert_context(args->oldp, args->newp, c);
> -	if (rc)
> -		goto bad;
> +	/* Convert the MLS/MCS fields if dealing with MLS/MCS policies */
> +	if (args->oldp->mls_enabled
> +	    && args->newp->mls_enabled) {
> +		rc = mls_convert_context(args->oldp, args->newp, c);
> +		if (rc)
> +			goto bad;
> +	}
> +
> +	/*
> +	 * Switching between MLS/MCS and non-MLS/non-MCS policy:
> +	 * free any storage used by the MLS fields in the
> +	 * context for all existing entries in the sidtab.
> +	 */
> +	if (args->oldp->mls_enabled && !args->newp->mls_enabled)
> +		mls_context_destroy(c);
> +
> +	/*
> +	 * Switching between non-MLS/non-MCS and MLS/MCS policy:
> +	 * ensure that the MLS fields of the context for all
> +	 * existing entries in the sidtab are filled in with a
> +	 * suitable default value, likely taken from one of the
> +	 * initial SIDs.
> +	 */
> +	if (!args->oldp->mls_enabled && args->newp->mls_enabled) {
> +		oc = args->newp->ocontexts[OCON_ISID];
> +		while (oc && oc->sid[0] != SECINITSID_UNLABELED)
> +			oc = oc->next;

Just in case, I'd test if (!oc) and bail with an error.

> +		range = &oc->context[0].range;
> +		rc = mls_range_set(c, range);
> +		if (rc) {
> +			if (context_struct_to_string(&oldc, &s, &len))
> +				return -ENOMEM;
> +			context_destroy(&oldc);
> +			context_destroy(c);
> +			c->str = s;
> +			c->len = len;
> +			printk(KERN_ERR "SELinux:  Failed to set"
> +				" the MLS/MCS range for context"
> +				" %sn", c->str);
> +			goto out;

goto bad ?

> +		}
> +	}
>  
>  	/* Check the validity of the new context. */
>  	if (!policydb_context_isvalid(args->newp, c)) {

> diff -pruN security-testing-2.6/security/selinux/ss/services.h security-testing-2.6-new/security/selinux/ss/services.h
> --- security-testing-2.6/security/selinux/ss/services.h	2010-01-29 01:06:42.174044406 +0100
> +++ security-testing-2.6-new/security/selinux/ss/services.h	2010-02-01 18:26:32.682234915 +0100
> @@ -3,6 +3,7 @@
>   *
>   * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
>   */
> +
>  #ifndef _SS_SERVICES_H_
>  #define _SS_SERVICES_H_

Whitespace change.

> diff -pruN security-testing-2.6/security/selinux/ss/sidtab.h security-testing-2.6-new/security/selinux/ss/sidtab.h
> --- security-testing-2.6/security/selinux/ss/sidtab.h	2010-01-29 01:06:42.175047659 +0100
> +++ security-testing-2.6-new/security/selinux/ss/sidtab.h	2010-02-01 20:38:09.350520786 +0100
> @@ -51,4 +51,3 @@ void sidtab_shutdown(struct sidtab *s);
>  
>  #endif	/* _SS_SIDTAB_H_ */
>  
> -

Whitespace change.

> diff -pruN security-testing-2.6/security/selinux/ss/symtab.h security-testing-2.6-new/security/selinux/ss/symtab.h
> --- security-testing-2.6/security/selinux/ss/symtab.h	2010-01-29 01:06:42.176055661 +0100
> +++ security-testing-2.6-new/security/selinux/ss/symtab.h	2010-02-01 20:50:54.661232717 +0100
> @@ -6,6 +6,7 @@
>   *
>   * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
>   */
> +
>  #ifndef _SS_SYMTAB_H_
>  #define _SS_SYMTAB_H_

Ditto.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
