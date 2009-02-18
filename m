Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1ILHucP011462
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2009 16:17:56 -0500
Received: from manicmethod.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1ILHs9O001411
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2009 21:17:55 GMT
Message-ID: <499C7AE5.7070805@manicmethod.com>
Date: Wed, 18 Feb 2009 16:17:25 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Caleb Case <ccase@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] aliases for the boundry format
References: <E1LWzNR-0001Qe-4E@shiva.hsd1.md.comcast.net.>
In-Reply-To: <E1LWzNR-0001Qe-4E@shiva.hsd1.md.comcast.net.>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Caleb Case wrote:
> The boundry format mapped the primary field to a boolean in the
> properties bitmap. This is appropriate for the kernel policy, but in
> modular policy the primary field may be an integer that indicates the
> primary type that is being aliased. In this case, the primary value cannot
> be assumed to be boolean.
> 
> This patch creates a new module format that writes out the primary value
> as was done before the boundry format.
> 
> Signed-off-by: Caleb Case <ccase@tresys.com>
> 
> ---
>  
>  checkpolicy/module_compiler.c              |    2 +-
>  checkpolicy/policy_define.c                |   13 +++++++-
>  libsepol/include/sepol/policydb/policydb.h |   19 +++++-----
>  libsepol/src/policydb.c                    |   50 +++++++++++++++++++++------
>  libsepol/src/write.c                       |    5 +++
>  5 files changed, 67 insertions(+), 22 deletions(-)
> 
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
> index 36d20be..d6ebd78 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -136,7 +136,7 @@ int declare_symbol(uint32_t symbol_type,
>  	}
>  	retval = symtab_insert(policydbp, symbol_type, key, datum,
>  			       SCOPE_DECL, decl->decl_id, dest_value);
> -	if (retval == 1) {
> +	if (retval == 1 && dest_value) {
>  		symtab_datum_t *s =
>  		    (symtab_datum_t *) hashtab_search(policydbp->
>  						      symtab[symbol_type].table,
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 25b06c1..17b84ce 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1015,8 +1015,19 @@ static int add_aliases_to_type(type_datum_t * type)
>  				yyerror("could not declare alias here");
>  				goto cleanup;
>  			}
> -		case 0:
> +		case 0:	 	break;
>  		case 1:{
> +				/* ret == 1 means the alias was required and therefore already
> +				 * has a value. Set it up as an alias with a different primary. */
> +				type_datum_destroy(aliasdatum);
> +				free(aliasdatum);
> +
> +				aliasdatum = hashtab_search(policydbp->symtab[SYM_TYPES].table, id);
> +				assert(aliasdatum);
> +
> +				aliasdatum->primary = type->s.value;
> +				aliasdatum->flavor = TYPE_ALIAS;
> +
>  				break;
>  			}
>  		default:{
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
> index eede389..0105cf4 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -614,17 +614,18 @@ extern int policydb_write(struct policydb *p, struct policy_file *pf);
>  #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_BOUNDARY
>  
>  /* Module versions and specific changes*/
> -#define MOD_POLICYDB_VERSION_BASE	   4
> -#define MOD_POLICYDB_VERSION_VALIDATETRANS 5
> -#define MOD_POLICYDB_VERSION_MLS	   5
> -#define MOD_POLICYDB_VERSION_RANGETRANS	   6
> -#define MOD_POLICYDB_VERSION_MLS_USERS	   6
> -#define MOD_POLICYDB_VERSION_POLCAP	   7
> -#define MOD_POLICYDB_VERSION_PERMISSIVE	   8
> -#define MOD_POLICYDB_VERSION_BOUNDARY      9
> +#define MOD_POLICYDB_VERSION_BASE		4
> +#define MOD_POLICYDB_VERSION_VALIDATETRANS	5
> +#define MOD_POLICYDB_VERSION_MLS		5
> +#define MOD_POLICYDB_VERSION_RANGETRANS 	6
> +#define MOD_POLICYDB_VERSION_MLS_USERS		6
> +#define MOD_POLICYDB_VERSION_POLCAP		7
> +#define MOD_POLICYDB_VERSION_PERMISSIVE		8
> +#define MOD_POLICYDB_VERSION_BOUNDARY		9
> +#define MOD_POLICYDB_VERSION_BOUNDARY_ALIAS	10
>  
>  #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
> -#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_BOUNDARY
> +#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_BOUNDARY_ALIAS
>  
>  #define POLICYDB_CONFIG_MLS    1
>  
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index d623343..85ddefc 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -153,6 +153,12 @@ static struct policydb_compat_info policydb_compat[] = {
>  	 .ocon_num = OCON_NODE6 + 1,
>  	},
>  	{
> +	 .type = POLICY_BASE,
> +	 .version = MOD_POLICYDB_VERSION_BOUNDARY_ALIAS,
> +	 .sym_num = SYM_NUM,
> +	 .ocon_num = OCON_NODE6 + 1,
> +	},
> +	{
>  	 .type = POLICY_MOD,
>  	 .version = MOD_POLICYDB_VERSION_BASE,
>  	 .sym_num = SYM_NUM,
> @@ -188,6 +194,12 @@ static struct policydb_compat_info policydb_compat[] = {
>  	 .sym_num = SYM_NUM,
>  	 .ocon_num = 0
>  	},
> +	{
> +	 .type = POLICY_MOD,
> +	 .version = MOD_POLICYDB_VERSION_BOUNDARY_ALIAS,
> +	 .sym_num = SYM_NUM,
> +	 .ocon_num = 0
> +	},
>  };
>  
>  #if 0
> @@ -1942,13 +1954,19 @@ static int type_read(policydb_t * p
>  	uint32_t buf[5];
>  	size_t len;
>  	int rc, to_read;
> +	int pos = 0;
>  
>  	typdatum = calloc(1, sizeof(type_datum_t));
>  	if (!typdatum)
>  		return -1;
>  
> -	if (policydb_has_boundary_feature(p))
> -		to_read = 4;
> +	if (policydb_has_boundary_feature(p)) {
> +		if (p->policy_type != POLICY_KERN
> +		    && p->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY_ALIAS)
> +			to_read = 5;
> +		else
> +			to_read = 4;
> +	}
>  	else if (p->policy_type == POLICY_KERN)
>  		to_read = 3;
>  	else if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
> @@ -1960,13 +1978,23 @@ static int type_read(policydb_t * p
>  	if (rc < 0)
>  		goto bad;
>  
> -	len = le32_to_cpu(buf[0]);
> -	typdatum->s.value = le32_to_cpu(buf[1]);
> +	len = le32_to_cpu(buf[pos]);
> +	typdatum->s.value = le32_to_cpu(buf[++pos]);
>  	if (policydb_has_boundary_feature(p)) {
> -		uint32_t properties = le32_to_cpu(buf[2]);
> +		uint32_t properties;
> +
> +		if (p->policy_type != POLICY_KERN
> +		    && p->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY_ALIAS) {
> +			typdatum->primary = le32_to_cpu(buf[++pos]);
> +			properties = le32_to_cpu(buf[++pos]);
> +		}
> +		else {
> +			properties = le32_to_cpu(buf[++pos]);
> +
> +			if (properties & TYPEDATUM_PROPERTY_PRIMARY)
> +				typdatum->primary = 1;
> +		}
>  
> -		if (properties & TYPEDATUM_PROPERTY_PRIMARY)
> -			typdatum->primary = 1;
>  		if (properties & TYPEDATUM_PROPERTY_ATTRIBUTE)
>  			typdatum->flavor = TYPE_ATTRIB;
>  		if (properties & TYPEDATUM_PROPERTY_ALIAS
> @@ -1976,13 +2004,13 @@ static int type_read(policydb_t * p
>  		    && p->policy_type != POLICY_KERN)
>  			typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
>  
> -		typdatum->bounds = le32_to_cpu(buf[3]);
> +		typdatum->bounds = le32_to_cpu(buf[++pos]);
>  	} else {
> -		typdatum->primary = le32_to_cpu(buf[2]);
> +		typdatum->primary = le32_to_cpu(buf[++pos]);
>  		if (p->policy_type != POLICY_KERN) {
> -			typdatum->flavor = le32_to_cpu(buf[3]);
> +			typdatum->flavor = le32_to_cpu(buf[++pos]);
>  			if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
> -				typdatum->flags = le32_to_cpu(buf[4]);
> +				typdatum->flags = le32_to_cpu(buf[++pos]);
>  		}
>  	}
>  
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index bffadcf..66b35ec 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -970,6 +970,11 @@ static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
>  	if (policydb_has_boundary_feature(p)) {
>  		uint32_t properties = 0;
>  
> +		if (p->policy_type != POLICY_KERN
> +		    && p->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY_ALIAS) {
> +			buf[items++] = cpu_to_le32(typdatum->primary);
> +		}
> +
>  		if (typdatum->primary)
>  			properties |= TYPEDATUM_PROPERTY_PRIMARY;
>  
> 
> --

Merged in libsepol 2.0.35 and checkpolicy 2.0.19

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
