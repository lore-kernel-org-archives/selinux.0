Subject: Re: [PATCH] libsepol: add user to hierarchy checker
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200709242044.l8OKijdq013008@tex.courtesan.com>
References: <200709242044.l8OKijdq013008@tex.courtesan.com>
Content-Type: text/plain
Date: Fri, 05 Oct 2007 09:32:27 -0400
Message-Id: <1191591147.891.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-09-24 at 16:44 -0400, Todd C. Miller wrote:
> This adds user support to the hierarchy checker for completeness.  A user
> may not have more roles than its parent.  It is basically identical to the
> role hierarchy support except that we constrain roles instead of types.
> 
> Signed-Off-By: Todd C. Miller <tmiller@tresys.com>
> 
>  hierarchy.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> Index: libsepol/src/hierarchy.c
> ===================================================================
> --- libsepol/src/hierarchy.c	(revision 2585)
> +++ libsepol/src/hierarchy.c	(working copy)
> @@ -365,6 +365,59 @@
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
> +	ebitmap_t eb;
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
> +	if (ebitmap_or(&eb, &u->roles.roles, &up->roles.roles)) {
> +		/* Memory error */
> +		free(parent);
> +		return -1;
> +	}
> +
> +	if (!ebitmap_cmp(&eb, &up->roles.roles)) {
> +		/* hierarchical constraint violation, return error */
> +		ERR(a->handle, "User hierarchy violation, %s exceeds %s",
> +		    a->p->p_user_val_to_name[u->s.value - 1], parent);
> +		a->numerr++;
> +	}

Why not use ebitmap_contains()?

> +
> +	ebitmap_destroy(&eb);
> +	free(parent);
> +
> +	return 0;
> +}
> +
>  int hierarchy_check_constraints(sepol_handle_t * handle, policydb_t * p)
>  {
>  	hierarchy_args_t args;
> @@ -395,6 +448,9 @@
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
