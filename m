Subject: Re: [PATCH 5/5] checkpolicy: free id where it was leaked
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161226211832.7165-1-nicolas.iooss@m4x.org>
 <20161226211832.7165-5-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <e17587e2-853a-2a5f-b70a-35199ab0d827@tycho.nsa.gov>
Date: Fri, 6 Jan 2017 14:29:00 -0500
MIME-Version: 1.0
In-Reply-To: <20161226211832.7165-5-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/26/2016 04:18 PM, Nicolas Iooss wrote:
> Several functions in policy_define.c do not free id after handling it.
> Add the missing free(id) statements.
>
> The places where free(id) was missing were found both with gcc Address
> Sanitizer and manual code inspection.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,

> ---
>  checkpolicy/policy_define.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 780e325af65d..19f3a5631465 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1232,6 +1232,7 @@ int define_typealias(void)
>  		free(id);
>  		return -1;
>  	}
> +	free(id);
>  	return add_aliases_to_type(t);
>  }
>
> @@ -1263,6 +1264,7 @@ int define_typeattribute(void)
>  		free(id);
>  		return -1;
>  	}
> +	free(id);
>
>  	while ((id = queue_remove(id_queue))) {
>  		if (!is_id_in_scope(SYM_TYPES, id)) {
> @@ -1459,25 +1461,25 @@ static int set_types(type_set_t * set, char *id, int *add, char starallowed)
>  	type_datum_t *t;
>
>  	if (strcmp(id, "*") == 0) {
> +		free(id);
>  		if (!starallowed) {
>  			yyerror("* not allowed in this type of rule");
>  			return -1;
>  		}
>  		/* set TYPE_STAR flag */
>  		set->flags = TYPE_STAR;
> -		free(id);
>  		*add = 1;
>  		return 0;
>  	}
>
>  	if (strcmp(id, "~") == 0) {
> +		free(id);
>  		if (!starallowed) {
>  			yyerror("~ not allowed in this type of rule");
>  			return -1;
>  		}
>  		/* complement the set */
>  		set->flags = TYPE_COMP;
> -		free(id);
>  		*add = 1;
>  		return 0;
>  	}
> @@ -1570,8 +1572,10 @@ int define_compute_type_helper(int which, avrule_t ** rule)
>  						(hashtab_key_t) id);
>  	if (!datum || datum->flavor == TYPE_ATTRIB) {
>  		yyerror2("unknown type %s", id);
> +		free(id);
>  		goto bad;
>  	}
> +	free(id);
>
>  	ebitmap_for_each_bit(&tclasses, node, i) {
>  		if (ebitmap_node_get_bit(node, i)) {
> @@ -2008,6 +2012,7 @@ int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
>  		    (class_perm_node_t *) malloc(sizeof(class_perm_node_t));
>  		if (!cur_perms) {
>  			yyerror("out of memory");
> +			free(id);
>  			ret = -1;
>  			goto out;
>  		}
> @@ -2043,6 +2048,7 @@ int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
>  		}
>  	}
>
> +	free(id);
>  	ebitmap_destroy(&tclasses);
>
>  	avrule->perms = perms;
> @@ -2389,11 +2395,12 @@ int define_te_avtab_extended_perms(int which)
>
>  	id = queue_remove(id_queue);
>  	if (strcmp(id,"ioctl") == 0) {
> +		free(id);
>  		if (define_te_avtab_ioctl(avrule_template))
>  			return -1;
> -		free(id);
>  	} else {
>  		yyerror("only ioctl extended permissions are supported");
> +		free(id);
>  		return -1;
>  	}
>  	return 0;
> @@ -3090,13 +3097,16 @@ int define_role_trans(int class_specified)
>  	role = hashtab_search(policydbp->p_roles.table, id);
>  	if (!role) {
>  		yyerror2("unknown role %s used in transition definition", id);
> +		free(id);
>  		goto bad;
>  	}
>
>  	if (role->flavor != ROLE_ROLE) {
>  		yyerror2("the new role %s must be a regular role", id);
> +		free(id);
>  		goto bad;
>  	}
> +	free(id);
>
>  	/* This ebitmap business is just to ensure that there are not conflicting role_trans rules */
>  	if (role_set_expand(&roles, &e_roles, policydbp, NULL, NULL))
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
