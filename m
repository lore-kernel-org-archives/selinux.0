Subject: Re: [PATCH] libsepol: add user to hierarchy checker
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200710051752.l95Hq8EA028040@cadmus.columbia.tresys.com>
References: <200710051752.l95Hq8EA028040@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 16:27:21 -0400
Message-Id: <1192134441.608.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-10-05 at 13:52 -0400, Todd C. Miller wrote:
> Stephen Smalley wrote:
> 
> > Why not use ebitmap_contains()?
> 
> I was basically just cloning check_role_hierarchy_callback() so I just
> followed what it did.  Using ebitmap_contains() is more intuitive and
> is probably faster to boot.
> 
> Below is an updated patch that uses ebitmap_contains() for both
> check_role_hierarchy_callback() and check_user_hierarchy_callback().

Thanks, merged.

> 
> Index: hierarchy.c
> ===================================================================
> --- hierarchy.c	(revision 2628)
> +++ hierarchy.c	(working copy)
> @@ -323,7 +323,6 @@
>  	char *parent;
>  	hierarchy_args_t *a;
>  	role_datum_t *r, *rp;
> -	ebitmap_t eb;
>  
>  	a = (hierarchy_args_t *) args;
>  	r = (role_datum_t *) d;
> @@ -346,25 +345,63 @@
>  		return 0;
>  	}
>  
> -	if (ebitmap_or(&eb, &r->types.types, &rp->types.types)) {
> -		/* Memory error */
> -		free(parent);
> -		return -1;
> -	}
> -
> -	if (!ebitmap_cmp(&eb, &rp->types.types)) {
> +	if (!ebitmap_contains(&rp->types.types, &r->types.types)) {
>  		/* This is a violation of the hiearchal constraint, return error condition */
>  		ERR(a->handle, "Role hierarchy violation, %s exceeds %s",
>  		    a->p->p_role_val_to_name[r->s.value - 1], parent);
>  		a->numerr++;
>  	}
>  
> -	ebitmap_destroy(&eb);
>  	free(parent);
>  
>  	return 0;
>  }
>  
> +/* The user hierarchy is defined as: a child user cannot have a role that
> + * its parent doesn't have.  This function should be called with hashtab_map,
> + * it will return 0 on success, 1 on constraint violation and -1 on error.
> + */
> +static int check_user_hierarchy_callback(hashtab_key_t k
> +					 __attribute__ ((unused)),
> +					 hashtab_datum_t d, void *args)
> +{
> +	char *parent;
> +	hierarchy_args_t *a;
> +	user_datum_t *u, *up;
> +
> +	a = (hierarchy_args_t *) args;
> +	u = (user_datum_t *) d;
> +
> +	if (find_parent(a->p->p_user_val_to_name[u->s.value - 1], &parent))
> +		return -1;
> +
> +	if (!parent) {
> +		/* This user has no parent */
> +		return 0;
> +	}
> +
> +	up = hashtab_search(a->p->p_users.table, parent);
> +	if (!up) {
> +		/* Orphan user */
> +		ERR(a->handle, "user %s doesn't exist, %s is an orphan",
> +		    parent, a->p->p_user_val_to_name[u->s.value - 1]);
> +		free(parent);
> +		a->numerr++;
> +		return 0;
> +	}
> +
> +	if (!ebitmap_contains(&up->roles.roles, &u->roles.roles)) {
> +		/* hierarchical constraint violation, return error */
> +		ERR(a->handle, "User hierarchy violation, %s exceeds %s",
> +		    a->p->p_user_val_to_name[u->s.value - 1], parent);
> +		a->numerr++;
> +	}
> +
> +	free(parent);
> +
> +	return 0;
> +}
> +
>  int hierarchy_check_constraints(sepol_handle_t * handle, policydb_t * p)
>  {
>  	hierarchy_args_t args;
> @@ -395,6 +432,9 @@
>  	if (hashtab_map(p->p_roles.table, check_role_hierarchy_callback, &args))
>  		goto bad;
>  
> +	if (hashtab_map(p->p_users.table, check_user_hierarchy_callback, &args))
> +		goto bad;
> +
>  	if (args.numerr) {
>  		ERR(handle, "%d total errors found during hierarchy check",
>  		    args.numerr);
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
