Subject: Re: [PATCH 4/6] libsepol: expand.c resource leaks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: serue@us.ibm.com
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050822161037.GD4191@sergelap.austin.ibm.com>
References: <20050822161037.GD4191@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 09:16:49 -0400
Message-Id: <1124803009.7874.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-22 at 11:10 -0500, serue@us.ibm.com wrote:
> This patch fixes two resource leaks found by Coverity:
> 
> 	1. constrant_node_clone: new_con is not freed on error.  There
> 	is no case where we goto out_of_mem after new_con has been
> 	appended to *dst, so I believe this patch is safe.
> 
> 	2. copy_neverallow: avrule is not freed on error path.
> 
> thanks,
> -serge
> 
> Index: src/expand.c
> ===================================================================
> --- src.orig/expand.c
> +++ src/expand.c
> @@ -254,7 +254,7 @@ static int common_copy_callback(hashtab_
>  
>  static int constraint_node_clone(constraint_node_t **dst, constraint_node_t *src, expand_state_t *state)
>  {
> -        constraint_node_t *new_con, *last_new_con = NULL;
> +        constraint_node_t *new_con = NULL, *last_new_con = NULL;
>          constraint_expr_t *new_expr = NULL;
>          *dst = NULL;
>          while (src != NULL) {
> @@ -313,6 +313,8 @@ static int constraint_node_clone(constra
>          return 0;
>   out_of_mem:
>          write_error(state, "Out of memory!");
> +	if (new_con)
> +		free(new_con);
>          constraint_expr_destroy(new_expr);
>          return -1;
>  }
> @@ -1660,17 +1662,17 @@ static int copy_neverallow (policydb_t *
>          avrule->flags = source_rule->flags;
>  
>  	if (ebitmap_cpy(&avrule->stypes.types, &stypes))
> -		return -1;
> +		goto err;
>  
>  	if (ebitmap_cpy(&avrule->ttypes.types, &ttypes))
> -		return -1;
> +		goto err;
>  
>  	cur_perm = source_rule->perms;
>  	tail_perm = NULL;
>  	while (cur_perm) {
>  		new_perm = (class_perm_node_t*)malloc(sizeof(class_perm_node_t));
>  		if (!new_perm)
> -			return -1;
> +			goto err;
>  		class_perm_node_init(new_perm);
>  		new_perm->class = cur_perm->class;
>  		assert(new_perm->class);
> @@ -1700,6 +1702,17 @@ static int copy_neverallow (policydb_t *
>  	ebitmap_destroy(&ttypes);
>  
>  	return 0;
> +
> +err:
> +	ebitmap_destroy(&avrule->stypes.types);
> +	ebitmap_destroy(&avrule->ttypes.types);
> +	cur_perm = avrule->perms;
> +	while (cur_perm) {
> +		tail_perm = cur_perm->next;
> +		free(cur_perm);
> +		cur_perm = tail_perm;
> +	}
> +	free(avrule);
>  }

Hmm...I also added:
	ebitmap_destroy(&stypes);
        ebitmap_destroy(&ttypes);
	return -1;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
