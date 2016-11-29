Subject: Re: [PATCH 2/2 v2] libsepol: detect duplicated symbol IDs
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161128213444.6738-1-nicolas.iooss@m4x.org>
 <20161128213444.6738-2-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9e7b37e4-5456-ac0a-8169-4a4921d5eb11@tycho.nsa.gov>
Date: Tue, 29 Nov 2016 08:58:55 -0500
MIME-Version: 1.0
In-Reply-To: <20161128213444.6738-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/28/2016 04:34 PM, Nicolas Iooss wrote:
> A valid policy would not have two symbols (classes, roles, users...)
> sharing the same unique identifier. Make policydb_read() rejects such
> policy files.
> 
> When ..._val_to_name translation tables were allocated with malloc(),
> change to calloc() in order to initialize the tables with NULLs.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied both.

> ---
>  libsepol/src/conditional.c |  3 +++
>  libsepol/src/policydb.c    | 27 ++++++++++++++++++++++-----
>  2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> index e1bc961b2b52..2883aeb6fab0 100644
> --- a/libsepol/src/conditional.c
> +++ b/libsepol/src/conditional.c
> @@ -551,6 +551,9 @@ int cond_index_bool(hashtab_key_t key, hashtab_datum_t datum, void *datap)
>  	if (!booldatum->s.value || booldatum->s.value > p->p_bools.nprim)
>  		return -EINVAL;
>  
> +	if (p->p_bool_val_to_name[booldatum->s.value - 1] != NULL)
> +		return -EINVAL;
> +
>  	p->p_bool_val_to_name[booldatum->s.value - 1] = key;
>  	p->bool_val_to_struct[booldatum->s.value - 1] = booldatum;
>  
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 26cdd9b13516..ed4bdc8c821e 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -932,6 +932,8 @@ static int common_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
>  	p = (policydb_t *) datap;
>  	if (!comdatum->s.value || comdatum->s.value > p->p_commons.nprim)
>  		return -EINVAL;
> +	if (p->p_common_val_to_name[comdatum->s.value - 1] != NULL)
> +		return -EINVAL;
>  	p->p_common_val_to_name[comdatum->s.value - 1] = (char *)key;
>  
>  	return 0;
> @@ -946,6 +948,8 @@ static int class_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
>  	p = (policydb_t *) datap;
>  	if (!cladatum->s.value || cladatum->s.value > p->p_classes.nprim)
>  		return -EINVAL;
> +	if (p->p_class_val_to_name[cladatum->s.value - 1] != NULL)
> +		return -EINVAL;
>  	p->p_class_val_to_name[cladatum->s.value - 1] = (char *)key;
>  	p->class_val_to_struct[cladatum->s.value - 1] = cladatum;
>  
> @@ -961,6 +965,8 @@ static int role_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
>  	p = (policydb_t *) datap;
>  	if (!role->s.value || role->s.value > p->p_roles.nprim)
>  		return -EINVAL;
> +	if (p->p_role_val_to_name[role->s.value - 1] != NULL)
> +		return -EINVAL;
>  	p->p_role_val_to_name[role->s.value - 1] = (char *)key;
>  	p->role_val_to_struct[role->s.value - 1] = role;
>  
> @@ -978,6 +984,8 @@ static int type_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
>  	if (typdatum->primary) {
>  		if (!typdatum->s.value || typdatum->s.value > p->p_types.nprim)
>  			return -EINVAL;
> +		if (p->p_type_val_to_name[typdatum->s.value - 1] != NULL)
> +			return -EINVAL;
>  		p->p_type_val_to_name[typdatum->s.value - 1] = (char *)key;
>  		p->type_val_to_struct[typdatum->s.value - 1] = typdatum;
>  	}
> @@ -995,7 +1003,8 @@ static int user_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
>  
>  	if (!usrdatum->s.value || usrdatum->s.value > p->p_users.nprim)
>  		return -EINVAL;
> -
> +	if (p->p_user_val_to_name[usrdatum->s.value - 1] != NULL)
> +		return -EINVAL;
>  	p->p_user_val_to_name[usrdatum->s.value - 1] = (char *)key;
>  	p->user_val_to_struct[usrdatum->s.value - 1] = usrdatum;
>  
> @@ -1014,6 +1023,8 @@ static int sens_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
>  		if (!levdatum->level->sens ||
>  		    levdatum->level->sens > p->p_levels.nprim)
>  			return -EINVAL;
> +		if (p->p_sens_val_to_name[levdatum->level->sens - 1] != NULL)
> +			return -EINVAL;
>  		p->p_sens_val_to_name[levdatum->level->sens - 1] = (char *)key;
>  	}
>  
> @@ -1031,6 +1042,8 @@ static int cat_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
>  	if (!catdatum->isalias) {
>  		if (!catdatum->s.value || catdatum->s.value > p->p_cats.nprim)
>  			return -EINVAL;
> +		if (p->p_cat_val_to_name[catdatum->s.value - 1] != NULL)
> +			return -EINVAL;
>  		p->p_cat_val_to_name[catdatum->s.value - 1] = (char *)key;
>  	}
>  
> @@ -1051,7 +1064,7 @@ int policydb_index_classes(policydb_t * p)
>  {
>  	free(p->p_common_val_to_name);
>  	p->p_common_val_to_name = (char **)
> -	    malloc(p->p_commons.nprim * sizeof(char *));
> +	    calloc(p->p_commons.nprim, sizeof(char *));
>  	if (!p->p_common_val_to_name)
>  		return -1;
>  
> @@ -1060,13 +1073,13 @@ int policydb_index_classes(policydb_t * p)
>  
>  	free(p->class_val_to_struct);
>  	p->class_val_to_struct = (class_datum_t **)
> -	    malloc(p->p_classes.nprim * sizeof(class_datum_t *));
> +	    calloc(p->p_classes.nprim, sizeof(class_datum_t *));
>  	if (!p->class_val_to_struct)
>  		return -1;
>  
>  	free(p->p_class_val_to_name);
>  	p->p_class_val_to_name = (char **)
> -	    malloc(p->p_classes.nprim * sizeof(char *));
> +	    calloc(p->p_classes.nprim, sizeof(char *));
>  	if (!p->p_class_val_to_name)
>  		return -1;
>  
> @@ -1082,7 +1095,7 @@ int policydb_index_bools(policydb_t * p)
>  	if (cond_init_bool_indexes(p) == -1)
>  		return -1;
>  	p->p_bool_val_to_name = (char **)
> -	    malloc(p->p_bools.nprim * sizeof(char *));
> +	    calloc(p->p_bools.nprim, sizeof(char *));
>  	if (!p->p_bool_val_to_name)
>  		return -1;
>  	if (hashtab_map(p->p_bools.table, cond_index_bool, p))
> @@ -1118,6 +1131,10 @@ int policydb_index_decls(sepol_handle_t * handle, policydb_t * p)
>  				ERR(handle, "invalid decl ID %u", decl->decl_id);
>  				return -1;
>  			}
> +			if (p->decl_val_to_struct[decl->decl_id - 1] != NULL) {
> +				ERR(handle, "duplicated decl ID %u", decl->decl_id);
> +				return -1;
> +			}
>  			p->decl_val_to_struct[decl->decl_id - 1] = decl;
>  		}
>  	}
> 
