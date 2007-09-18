Subject: Re: [PATCH] libsepol: support the handle_unknown config flag
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1185983548.3673.21.camel@localhost.localdomain>
References: <1185983548.3673.21.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Sep 2007 15:41:52 -0400
Message-Id: <1190144512.14037.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 11:52 -0400, Eric Paris wrote:
> Update the policydb definition to contain a handle_unknown flag.  Change
> libsepol to copy the handle_unknown config flag from the base policy to
> the final binary policy.  Also makes libsepol properly read and write
> the flag which dealing with policy modules.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Thanks, merged as of libsepol 2.0.10.
> 
> diff -Naupr libsepol-2.0.4/include/sepol/policydb/policydb.h libsepol-2.0.4.new/include/sepol/policydb/policydb.h
> --- libsepol-2.0.4/include/sepol/policydb/policydb.h	2007-06-21 05:17:02.000000000 -0400
> +++ libsepol-2.0.4.new/include/sepol/policydb/policydb.h	2007-07-31 16:14:13.000000000 -0400
> @@ -469,6 +469,8 @@ typedef struct policydb {
>  	ebitmap_t *attr_type_map;	/* not saved in the binary policy */
>  
>  	unsigned policyvers;
> +
> +	unsigned handle_unknown;
>  } policydb_t;
>  
>  struct sepol_policydb {
> @@ -599,6 +601,13 @@ extern int policydb_write(struct policyd
>  
>  #define POLICYDB_CONFIG_MLS    1
>  
> +/* the config flags related to unknown classes/perms are bits 2 and 3 */
> +#define DENY_UNKNOWN	0x00000000
> +#define REJECT_UNKNOWN	0x00000002
> +#define ALLOW_UNKNOWN 	0x00000004
> +
> +#define POLICYDB_CONFIG_UNKNOWN_MASK	(DENY_UNKNOWN | REJECT_UNKNOWN | ALLOW_UNKNOWN)
> +
>  #define OBJECT_R "object_r"
>  #define OBJECT_R_VAL 1
>  
> diff -Naupr libsepol-2.0.4/src/expand.c libsepol-2.0.4.new/src/expand.c
> --- libsepol-2.0.4/src/expand.c	2007-06-21 05:17:01.000000000 -0400
> +++ libsepol-2.0.4.new/src/expand.c	2007-07-27 18:32:39.000000000 -0400
> @@ -2248,6 +2248,7 @@ int expand_module(sepol_handle_t * handl
>  
>  	/* Copy mls state from base to out */
>  	out->mls = base->mls;
> +	out->handle_unknown = base->handle_unknown;
>  
>  	if ((state.typemap =
>  	     (uint32_t *) calloc(state.base->p_types.nprim,
> diff -Naupr libsepol-2.0.4/src/policydb.c libsepol-2.0.4.new/src/policydb.c
> --- libsepol-2.0.4/src/policydb.c	2007-06-21 05:17:01.000000000 -0400
> +++ libsepol-2.0.4.new/src/policydb.c	2007-07-31 16:17:53.000000000 -0400
> @@ -3057,6 +3057,8 @@ int policydb_read(policydb_t * p, struct
>  		p->mls = 0;
>  	}
>  
> +	p->handle_unknown = buf[bufindex] & POLICYDB_CONFIG_UNKNOWN_MASK;
> +
>  	bufindex++;
>  
>  	info = policydb_lookup_compat(r_policyvers, policy_type);
> diff -Naupr libsepol-2.0.4/src/write.c libsepol-2.0.4.new/src/write.c
> --- libsepol-2.0.4/src/write.c	2007-06-21 05:17:01.000000000 -0400
> +++ libsepol-2.0.4.new/src/write.c	2007-07-31 16:18:49.000000000 -0400
> @@ -1534,6 +1534,8 @@ int policydb_write(policydb_t * p, struc
>  	if (p->mls)
>  		config |= POLICYDB_CONFIG_MLS;
>  
> +	config |= (POLICYDB_CONFIG_UNKNOWN_MASK & p->handle_unknown);
> +
>  	/* Write the magic number and string identifiers. */
>  	items = 0;
>  	if (p->policy_type == POLICY_KERN) {
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
