Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1HG4f7d030396
 for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2017 11:04:41 -0500
Subject: Re: [PATCH] libsepol/cil: Destroy cil_tree_node stacks when finished
 resolving AST
To: selinux@tycho.nsa.gov
References: <1486570662-26345-1-git-send-email-jwcart2@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <d8db0538-ac93-590f-85f2-dadbc80b4e52@tycho.nsa.gov>
Date: Fri, 17 Feb 2017 11:05:05 -0500
MIME-Version: 1.0
In-Reply-To: <1486570662-26345-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/08/2017 11:17 AM, James Carter wrote:
> CIL uses separate cil_tree_node stacks for optionals and blocks to
> check for statements not allowed in optionals or blocks and to know
> which optional to disable when necessary. But these stacks were not
> being destroyed when exiting cil_resolve_ast(). This is not a problem
> normally because the stacks will be empty, but this is not the case
> when exiting with an error.
>
> Destroy both tree node stacks when exiting to ensure that they are
> empty.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

This has been applied.

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 7fe4a74..6628dc4 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -3778,6 +3778,16 @@ exit:
>  	return rc;
>  }
>
> +static void cil_destroy_tree_node_stack(struct cil_tree_node *curr)
> +{
> +	struct cil_tree_node *next;
> +	while (curr != NULL) {
> +		next = curr->cl_head;
> +		free(curr);
> +		curr = next;
> +	}
> +}
> +
>  int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>  {
>  	int rc = SEPOL_ERR;
> @@ -3904,16 +3914,12 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>  		/* reset the arguments */
>  		changed = 0;
>  		while (extra_args.optstack != NULL) {
> -			struct cil_tree_node *curr = extra_args.optstack;
> -			struct cil_tree_node *next = curr->cl_head;
> -			free(curr);
> -			extra_args.optstack = next;
> +			cil_destroy_tree_node_stack(extra_args.optstack);
> +			extra_args.optstack = NULL;
>  		}
>  		while (extra_args.blockstack!= NULL) {
> -			struct cil_tree_node *curr = extra_args.blockstack;
> -			struct cil_tree_node *next = curr->cl_head;
> -			free(curr);
> -			extra_args.blockstack= next;
> +			cil_destroy_tree_node_stack(extra_args.blockstack);
> +			extra_args.blockstack = NULL;
>  		}
>  	}
>
> @@ -3924,6 +3930,8 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>
>  	rc = SEPOL_OK;
>  exit:
> +	cil_destroy_tree_node_stack(extra_args.optstack);
> +	cil_destroy_tree_node_stack(extra_args.blockstack);
>  	__cil_ordered_lists_destroy(&extra_args.sidorder_lists);
>  	__cil_ordered_lists_destroy(&extra_args.classorder_lists);
>  	__cil_ordered_lists_destroy(&extra_args.catorder_lists);
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
