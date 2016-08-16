From: "Roberts, William C" <william.c.roberts@intel.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>, "jwcart2@tycho.nsa.gov"
 <jwcart2@tycho.nsa.gov>, "seandroid-list@tycho.nsa.gov"
 <seandroid-list@tycho.nsa.gov>, "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>
Subject: RE: [PATCH v4 7/7] libsepol: fix overflow and 0 length allocations
Date: Tue, 16 Aug 2016 17:45:16 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5601284AA3@ORSMSX103.amr.corp.intel.com>
References: <1471368517-20552-1-git-send-email-william.c.roberts@intel.com>
 <1471368517-20552-8-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1471368517-20552-8-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Roberts, William C
> Sent: Tuesday, August 16, 2016 10:29 AM
> To: selinux@tycho.nsa.gov; jwcart2@tycho.nsa.gov; seandroid-
> list@tycho.nsa.gov; sds@tycho.nsa.gov
> Cc: Roberts, William C <william.c.roberts@intel.com>
> Subject: [PATCH v4 7/7] libsepol: fix overflow and 0 length allocations
> 
> From: William Roberts <william.c.roberts@intel.com>
> 
> Throughout libsepol, values taken from sepolicy are used in places where length
> == 0 or length == <saturated> matter, find and fix these.
> 
> Also, correct any type mismatches noticed along the way.
> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libsepol/src/conditional.c    |  3 +-
>  libsepol/src/context.c        | 16 +++++++---
>  libsepol/src/context_record.c | 72 +++++++++++++++++++++++++++++----------
> ----
>  libsepol/src/module.c         | 13 ++++++++
>  libsepol/src/module_to_cil.c  |  4 ++-
>  libsepol/src/policydb.c       | 52 +++++++++++++++++++++++++++++--
>  libsepol/src/private.h        |  3 ++
>  7 files changed, 130 insertions(+), 33 deletions(-)
> 
> diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c index
> ea47cdd..8680eb2 100644
> --- a/libsepol/src/conditional.c
> +++ b/libsepol/src/conditional.c
> @@ -589,7 +589,8 @@ int cond_read_bool(policydb_t * p,
>  		goto err;
> 
>  	len = le32_to_cpu(buf[2]);
> -
> +	if (zero_or_saturated(len))
> +		goto err;
>  	key = malloc(len + 1);
>  	if (!key)
>  		goto err;
> diff --git a/libsepol/src/context.c b/libsepol/src/context.c index 420ee16..a88937f
> 100644
> --- a/libsepol/src/context.c
> +++ b/libsepol/src/context.c
> @@ -10,6 +10,7 @@
>  #include "context.h"
>  #include "handle.h"
>  #include "mls.h"
> +#include "private.h"
> 
>  /* ----- Compatibility ---- */
>  int policydb_context_isvalid(const policydb_t * p, const context_struct_t * c)
> @@ -297,10 +298,18 @@ int context_from_string(sepol_handle_t * handle,
>  	char *con_cpy = NULL;
>  	sepol_context_t *ctx_record = NULL;
> 
> +	if (zero_or_saturated(con_str_len)) {
> +		ERR(handle, "Invalid context length");
> +		goto err;
> +	}
> +
>  	/* sepol_context_from_string expects a NULL-terminated string */
>  	con_cpy = malloc(con_str_len + 1);
> -	if (!con_cpy)
> -		goto omem;
> +	if (!con_cpy) {
> +		ERR(handle, "out of memory");
> +		goto err;
> +	}
> +
>  	memcpy(con_cpy, con_str, con_str_len);
>  	con_cpy[con_str_len] = '\0';
> 
> @@ -315,9 +324,6 @@ int context_from_string(sepol_handle_t * handle,
>  	sepol_context_free(ctx_record);
>  	return STATUS_SUCCESS;
> 
> -      omem:
> -	ERR(handle, "out of memory");
> -
>        err:
>  	ERR(handle, "could not create context structure");
>  	free(con_cpy);
> diff --git a/libsepol/src/context_record.c b/libsepol/src/context_record.c index
> ac2884a..0a8bbf6 100644
> --- a/libsepol/src/context_record.c
> +++ b/libsepol/src/context_record.c
> @@ -5,6 +5,7 @@
> 
>  #include "context_internal.h"
>  #include "debug.h"
> +#include "private.h"
> 
>  struct sepol_context {
> 
> @@ -279,44 +280,69 @@ int sepol_context_from_string(sepol_handle_t *
> handle,
> 
>  hidden_def(sepol_context_from_string)
> 
> +static inline int safe_sum(size_t *sum, const size_t augends[], const
> +size_t cnt) {
> +
> +	size_t a, i;
> +
> +	*sum = 0;
> +	for(i=0; i < cnt; i++) {
> +		/* sum should not be smaller than the addend */
> +		a = augends[i];
> +		*sum += a;
> +		if (*sum < a) {
> +			return i;

Damn it...this does not work when index 0 is the bad one... I'll wait till
Tomorrow and aggregate responses again.

> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  int sepol_context_to_string(sepol_handle_t * handle,
>  			    const sepol_context_t * con, char **str_ptr)  {
> 
>  	int rc;
> -	const int user_sz = strlen(con->user);
> -	const int role_sz = strlen(con->role);
> -	const int type_sz = strlen(con->type);
> -	const int mls_sz = (con->mls) ? strlen(con->mls) : 0;
> -	const int total_sz = user_sz + role_sz + type_sz +
> -	    mls_sz + ((con->mls) ? 3 : 2);
> -
> -	char *str = (char *)malloc(total_sz + 1);
> -	if (!str)
> -		goto omem;
> +	char *str = NULL;
> +	size_t total_sz, err;
> +	const size_t sizes[] = {
> +			strlen(con->user),                 /* user length */
> +			strlen(con->role),                 /* role length */
> +			strlen(con->type),                 /* type length */
> +			(con->mls) ? strlen(con->mls) : 0, /* mls length */
> +			((con->mls) ? 3 : 2) + 1           /* mls has extra ":" also null
> byte */
> +	};
> +
> +	err = safe_sum(&total_sz, sizes, ARRAY_SIZE(sizes));
> +	if (err) {
> +		ERR(handle, "invalid size, overflow at position: %zu", err);
> +		goto err;
> +	}
> 
> +	str = (char *)malloc(total_sz);
> +	if (!str) {
> +		ERR(handle, "out of memory");
> +		goto err;
> +	}
>  	if (con->mls) {
> -		rc = snprintf(str, total_sz + 1, "%s:%s:%s:%s",
> +		rc = snprintf(str, total_sz, "%s:%s:%s:%s",
>  			      con->user, con->role, con->type, con->mls);
> -		if (rc < 0 || (rc >= total_sz + 1)) {
> -			ERR(handle, "print error");
> -			goto err;
> -		}
>  	} else {
> -		rc = snprintf(str, total_sz + 1, "%s:%s:%s",
> +		rc = snprintf(str, total_sz, "%s:%s:%s",
>  			      con->user, con->role, con->type);
> -		if (rc < 0 || (rc >= total_sz + 1)) {
> -			ERR(handle, "print error");
> -			goto err;
> -		}
> +	}
> +
> +	/*
> +	 * rc is >= 0 on the size_t cast and is safe to promote
> +	 * to an unsigned value.
> +	 */
> +	if (rc < 0 || (size_t)rc >= total_sz) {
> +		ERR(handle, "print error");
> +		goto err;
>  	}
> 
>  	*str_ptr = str;
>  	return STATUS_SUCCESS;
> 
> -      omem:
> -	ERR(handle, "out of memory");
> -
>        err:
>  	ERR(handle, "could not convert context to string");
>  	free(str);
> diff --git a/libsepol/src/module.c b/libsepol/src/module.c index 1665ede..f25df95
> 100644
> --- a/libsepol/src/module.c
> +++ b/libsepol/src/module.c
> @@ -30,6 +30,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <limits.h>
> +#include <inttypes.h>
> 
>  #define SEPOL_PACKAGE_SECTION_FC 0xf97cff90  #define
> SEPOL_PACKAGE_SECTION_SEUSER 0x97cff91 @@ -793,6 +794,12 @@ int
> sepol_module_package_info(struct sepol_policy_file *spf, int *type,
>  				goto cleanup;
>  			}
>  			len = le32_to_cpu(buf[0]);
> +			if (zero_or_saturated(len)) {
> +				ERR(file->handle,
> +				    "invalid module name length: 0x%"PRIx32,
> +				    len);
> +				goto cleanup;
> +			}
>  			*name = malloc(len + 1);
>  			if (!*name) {
>  				ERR(file->handle, "out of memory"); @@ -814,6
> +821,12 @@ int sepol_module_package_info(struct sepol_policy_file *spf, int
> *type,
>  				goto cleanup;
>  			}
>  			len = le32_to_cpu(buf[0]);
> +			if (zero_or_saturated(len)) {
> +				ERR(file->handle,
> +				    "invalid module version length: 0x%"PRIx32,
> +				    len);
> +				goto cleanup;
> +			}
>  			*version = malloc(len + 1);
>  			if (!*version) {
>  				ERR(file->handle, "out of memory"); diff --git
> a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c index
> 36f3b7d..fc65019 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -47,6 +47,8 @@
>  #include <sepol/policydb/services.h>
>  #include <sepol/policydb/util.h>
> 
> +#include "private.h"
> +
>  #ifdef __GNUC__
>  #  define UNUSED(x) UNUSED_ ## x __attribute__((__unused__))  #else @@ -
> 124,7 +126,7 @@ static int get_line(char **start, char *end, char **line)
> 
>  	for (len = 0; p < end && *p != '\n' && *p != '\0'; p++, len++);
> 
> -	if (len == 0) {
> +	if (zero_or_saturated(len)) {
>  		rc = 0;
>  		goto exit;
>  	}
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c index
> 60761b7..c225ac6 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1911,6 +1911,9 @@ static int perm_read(policydb_t * p
>  		goto bad;
> 
>  	len = le32_to_cpu(buf[0]);
> +	if (zero_or_saturated(len))
> +		goto bad;
> +
>  	perdatum->s.value = le32_to_cpu(buf[1]);
> 
>  	key = malloc(len + 1);
> @@ -1949,6 +1952,9 @@ static int common_read(policydb_t * p, hashtab_t h,
> struct policy_file *fp)
>  		goto bad;
> 
>  	len = le32_to_cpu(buf[0]);
> +	if (zero_or_saturated(len))
> +		goto bad;
> +
>  	comdatum->s.value = le32_to_cpu(buf[1]);
> 
>  	if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE)) @@ -
> 2092,7 +2098,11 @@ static int class_read(policydb_t * p, hashtab_t h, struct
> policy_file *fp)
>  		goto bad;
> 
>  	len = le32_to_cpu(buf[0]);
> +	if (zero_or_saturated(len))
> +		goto bad;
>  	len2 = le32_to_cpu(buf[1]);
> +	if (is_saturated(len2))
> +		goto bad;
>  	cladatum->s.value = le32_to_cpu(buf[2]);
> 
>  	if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE)) @@ -
> 2199,6 +2209,9 @@ static int role_read(policydb_t * p, hashtab_t h, struct
> policy_file *fp)
>  		goto bad;
> 
>  	len = le32_to_cpu(buf[0]);
> +	if (zero_or_saturated(len))
> +		goto bad;
> +
>  	role->s.value = le32_to_cpu(buf[1]);
>  	if (policydb_has_boundary_feature(p))
>  		role->bounds = le32_to_cpu(buf[2]);
> @@ -2287,6 +2300,9 @@ static int type_read(policydb_t * p, hashtab_t h, struct
> policy_file *fp)
>  		goto bad;
> 
>  	len = le32_to_cpu(buf[pos]);
> +	if (zero_or_saturated(len))
> +		goto bad;
> +
>  	typdatum->s.value = le32_to_cpu(buf[++pos]);
>  	if (policydb_has_boundary_feature(p)) {
>  		uint32_t properties;
> @@ -2447,6 +2463,8 @@ int filename_trans_read(filename_trans_t **t, struct
> policy_file *fp)
>  		if (rc < 0)
>  			return -1;
>  		len = le32_to_cpu(buf[0]);
> +		if (zero_or_saturated(len))
> +			return -1;
> 
>  		name = calloc(len + 1, sizeof(*name));
>  		if (!name)
> @@ -2556,6 +2574,9 @@ static int ocontext_read_xen(struct
> policydb_compat_info *info,
>  				if (rc < 0)
>  					return -1;
>  				len = le32_to_cpu(buf[0]);
> +				if (zero_or_saturated(len))
> +					return -1;
> +
>  				c->u.name = malloc(len + 1);
>  				if (!c->u.name)
>  					return -1;
> @@ -2618,6 +2639,8 @@ static int ocontext_read_selinux(struct
> policydb_compat_info *info,
>  				if (rc < 0)
>  					return -1;
>  				len = le32_to_cpu(buf[0]);
> +				if (zero_or_saturated(len))
> +					return -1;
>  				c->u.name = malloc(len + 1);
>  				if (!c->u.name)
>  					return -1;
> @@ -2659,6 +2682,8 @@ static int ocontext_read_selinux(struct
> policydb_compat_info *info,
>  					return -1;
>  				c->v.behavior = le32_to_cpu(buf[0]);
>  				len = le32_to_cpu(buf[1]);
> +				if (zero_or_saturated(len))
> +					return -1;
>  				c->u.name = malloc(len + 1);
>  				if (!c->u.name)
>  					return -1;
> @@ -2719,7 +2744,7 @@ static int genfs_read(policydb_t * p, struct policy_file
> *fp)
>  	uint32_t buf[1];
>  	size_t nel, nel2, len, len2;
>  	genfs_t *genfs_p, *newgenfs, *genfs;
> -	unsigned int i, j;
> +	size_t i, j;
>  	ocontext_t *l, *c, *newc = NULL;
>  	int rc;
> 
> @@ -2733,6 +2758,8 @@ static int genfs_read(policydb_t * p, struct policy_file
> *fp)
>  		if (rc < 0)
>  			goto bad;
>  		len = le32_to_cpu(buf[0]);
> +		if (zero_or_saturated(len))
> +			goto bad;
>  		newgenfs = calloc(1, sizeof(genfs_t));
>  		if (!newgenfs)
>  			goto bad;
> @@ -2778,6 +2805,8 @@ static int genfs_read(policydb_t * p, struct policy_file
> *fp)
>  			if (rc < 0)
>  				goto bad;
>  			len = le32_to_cpu(buf[0]);
> +			if (zero_or_saturated(len))
> +				goto bad;
>  			newc->u.name = malloc(len + 1);
>  			if (!newc->u.name) {
>  				goto bad;
> @@ -2877,6 +2906,9 @@ static int user_read(policydb_t * p, hashtab_t h, struct
> policy_file *fp)
>  		goto bad;
> 
>  	len = le32_to_cpu(buf[0]);
> +	if (zero_or_saturated(len))
> +		goto bad;
> +
>  	usrdatum->s.value = le32_to_cpu(buf[1]);
>  	if (policydb_has_boundary_feature(p))
>  		usrdatum->bounds = le32_to_cpu(buf[2]); @@ -2960,6 +2992,9
> @@ static int sens_read(policydb_t * p
>  		goto bad;
> 
>  	len = le32_to_cpu(buf[0]);
> +	if (zero_or_saturated(len))
> +		goto bad;
> +
>  	levdatum->isalias = le32_to_cpu(buf[1]);
> 
>  	key = malloc(len + 1);
> @@ -3003,6 +3038,9 @@ static int cat_read(policydb_t * p
>  		goto bad;
> 
>  	len = le32_to_cpu(buf[0]);
> +	if(zero_or_saturated(len))
> +		goto bad;
> +
>  	catdatum->s.value = le32_to_cpu(buf[1]);
>  	catdatum->isalias = le32_to_cpu(buf[2]);
> 
> @@ -3339,6 +3377,8 @@ static int
> filename_trans_rule_read(filename_trans_rule_t ** r, struct policy_fi
>  			return -1;
> 
>  		len = le32_to_cpu(buf[0]);
> +		if (zero_or_saturated(len))
> +			return -1;
> 
>  		ftr->name = malloc(len + 1);
>  		if (!ftr->name)
> @@ -3580,6 +3620,8 @@ static int scope_read(policydb_t * p, int symnum, struct
> policy_file *fp)
>  	if (rc < 0)
>  		goto cleanup;
>  	key_len = le32_to_cpu(buf[0]);
> +	if (zero_or_saturated(key_len))
> +		goto cleanup;
>  	key = malloc(key_len + 1);
>  	if (!key)
>  		goto cleanup;
> @@ -3664,8 +3706,8 @@ int policydb_read(policydb_t * p, struct policy_file *fp,
> unsigned verbose)
>  	}
> 
>  	len = buf[1];
> -	if (len > POLICYDB_STRING_MAX_LENGTH) {
> -		ERR(fp->handle, "policydb string length too long ");
> +	if (len == 0 || len > POLICYDB_STRING_MAX_LENGTH) {
> +		ERR(fp->handle, "policydb string length %s ", len ? "too long" :
> +"zero");
>  		return POLICYDB_ERROR;
>  	}
> 
> @@ -3798,6 +3840,8 @@ int policydb_read(policydb_t * p, struct policy_file *fp,
> unsigned verbose)
>  			goto bad;
>  		}
>  		len = le32_to_cpu(buf[0]);
> +		if (zero_or_saturated(len))
> +			goto bad;
>  		if ((p->name = malloc(len + 1)) == NULL) {
>  			goto bad;
>  		}
> @@ -3809,6 +3853,8 @@ int policydb_read(policydb_t * p, struct policy_file *fp,
> unsigned verbose)
>  			goto bad;
>  		}
>  		len = le32_to_cpu(buf[0]);
> +		if (zero_or_saturated(len))
> +			goto bad;
>  		if ((p->version = malloc(len + 1)) == NULL) {
>  			goto bad;
>  		}
> diff --git a/libsepol/src/private.h b/libsepol/src/private.h index 9c700c9..0beb4d4
> 100644
> --- a/libsepol/src/private.h
> +++ b/libsepol/src/private.h
> @@ -45,6 +45,9 @@
> 
>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
> 
> +#define is_saturated(x) (x == (typeof(x))-1) #define
> +zero_or_saturated(x) ((x == 0) || is_saturated(x))
> +
>  /* Policy compatibility information. */  struct policydb_compat_info {
>  	unsigned int type;
> --
> 1.9.1
