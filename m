Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v51H4o02008852
 for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2017 13:04:50 -0400
Subject: Re: [PATCH 1/2] libsepol: Clean up scope handling
To: selinux@tycho.nsa.gov
References: <20170530191304.29886-1-jwcart2@tycho.nsa.gov>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <3791f257-fa1a-d90f-0351-76f7b5513b18@tycho.nsa.gov>
Date: Thu, 1 Jun 2017 13:05:45 -0400
MIME-Version: 1.0
In-Reply-To: <20170530191304.29886-1-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/30/2017 03:13 PM, James Carter wrote:
> Currently, when checking if an identifier is enabled, each scope in
> the decl_ids list is checked. This means that if any block that
> requires the identifier is enabled, then the identifier will be treated
> as being declared.
> 
> Now, declarations will be kept at the end of the decl_ids list and
> when checking if an identifier is enabled, only the last scope will
> be checked (Except for roles and users which allow multiple declarations,
> they will have to keep the old behavior.)
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

Both of these have been applied.

Jim

> ---
>   libsepol/src/avrule_block.c | 24 ++++++++++++++++++++----
>   libsepol/src/policydb.c     | 13 +++++++++++++
>   2 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
> index 224e999..e1f460e 100644
> --- a/libsepol/src/avrule_block.c
> +++ b/libsepol/src/avrule_block.c
> @@ -156,20 +156,36 @@ int is_id_enabled(char *id, policydb_t * p, int symbol_table)
>   {
>   	scope_datum_t *scope =
>   	    (scope_datum_t *) hashtab_search(p->scope[symbol_table].table, id);
> -	uint32_t i;
> +	avrule_decl_t *decl;
> +	uint32_t len = scope->decl_ids_len;
> +
>   	if (scope == NULL) {
>   		return 0;
>   	}
>   	if (scope->scope != SCOPE_DECL) {
>   		return 0;
>   	}
> -	for (i = 0; i < scope->decl_ids_len; i++) {
> -		avrule_decl_t *decl =
> -		    p->decl_val_to_struct[scope->decl_ids[i] - 1];
> +
> +	if (len < 1) {
> +		return 0;
> +	}
> +
> +	if (symbol_table == SYM_ROLES || symbol_table == SYM_USERS) {
> +		uint32_t i;
> +		for (i = 0; i < len; i++) {
> +			avrule_decl_t *decl =
> +				p->decl_val_to_struct[scope->decl_ids[i] - 1];
> +			if (decl != NULL && decl->enabled) {
> +				return 1;
> +			}
> +		}
> +	} else {
> +		decl = p->decl_val_to_struct[scope->decl_ids[len-1] - 1];
>   		if (decl != NULL && decl->enabled) {
>   			return 1;
>   		}
>   	}
> +
>   	return 0;
>   }
>   
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index b153095..ff4fc4e 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1698,6 +1698,19 @@ int symtab_insert(policydb_t * pol, uint32_t sym,
>   		return -ENOMEM;
>   	}
>   
> +	if (scope_datum->scope == SCOPE_DECL && scope == SCOPE_REQ) {
> +		/* Need to keep the decl at the end of the list */
> +		uint32_t len, tmp;
> +		len = scope_datum->decl_ids_len;
> +		if (len < 2) {
> +			/* This should be impossible here */
> +			return -1;
> +		}
> +		tmp = scope_datum->decl_ids[len-2];
> +		scope_datum->decl_ids[len-2] = scope_datum->decl_ids[len-1];
> +		scope_datum->decl_ids[len-1] = tmp;
> +	}
> +
>   	return retval;
>   }
>   
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
