Subject: Re: [PATCH] libsepol/cil: fix blockinherit copying segfault and add
 macro restrictions
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
References: <1441892723-24321-1-git-send-email-slawrence@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <55F190A3.3080107@tycho.nsa.gov>
Date: Thu, 10 Sep 2015 10:16:03 -0400
MIME-Version: 1.0
In-Reply-To: <1441892723-24321-1-git-send-email-slawrence@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/10/2015 09:45 AM, Steve Lawrence wrote:
> When we copy a blockinherit statement, we perform actions that assume
> the blockinherit statement was already resolved. However, this isn't the
> case if the statement was copied from a tunableif or an in-statement,
> since those are resolve before blockinherits and blocks.  So when
> copying a blockinherit that hasn't been resolved, ignore the code that
> associates blocks with the blockinherit; that will all be handled when
> the copied blockinherit is actually resolved later.
>
> Additionally, restrict block, blockabstract, and blockinherit statements
> from appearing in macros. These statements are all resolved before
> macros due to ordering issues, so they must not appear inside macros.
> Note that in addition to doing the checks in build_ast, they are also
> done in resolve_ast. This is because an in-statement could copy a block
> statement into a macro, which we would not know about until after the
> in-statement was resolved.
>
> Signed-off-by: Steve Lawrence <slawrence@tresys.com>

Thanks. Applied.

Jim

> ---
>   libsepol/cil/src/cil_build_ast.c   | 27 +++++++--------------------
>   libsepol/cil/src/cil_copy_ast.c    |  9 ++++++++-
>   libsepol/cil/src/cil_resolve_ast.c | 12 ++++++++++++
>   3 files changed, 27 insertions(+), 21 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index e1e7dce..32ebee1 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -5750,27 +5750,14 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
>   	}
>
>   	if (macro != NULL) {
> -		if (parse_current->data == CIL_KEY_MACRO) {
> +		if (parse_current->data == CIL_KEY_MACRO ||
> +			parse_current->data == CIL_KEY_TUNABLE ||
> +			parse_current->data == CIL_KEY_IN ||
> +			parse_current->data == CIL_KEY_BLOCK ||
> +			parse_current->data == CIL_KEY_BLOCKINHERIT ||
> +			parse_current->data == CIL_KEY_BLOCKABSTRACT) {
>   			rc = SEPOL_ERR;
> -			cil_log(CIL_ERR, "Found macro at line %d of %s\n",
> -				parse_current->line, parse_current->path);
> -			cil_log(CIL_ERR, "Macros cannot be defined within macro statement\n");
> -			goto exit;
> -		}
> -
> -		if (parse_current->data == CIL_KEY_TUNABLE) {
> -			rc = SEPOL_ERR;
> -			cil_log(CIL_ERR, "Found tunable at line %d of %s\n",
> -				parse_current->line, parse_current->path);
> -			cil_log(CIL_ERR, "Tunables cannot be defined within macro statement\n");
> -			goto exit;
> -		}
> -
> -		if (parse_current->data == CIL_KEY_IN) {
> -			rc = SEPOL_ERR;
> -			cil_log(CIL_ERR, "Found in at line %d of %s\n",
> -				parse_current->line, parse_current->path);
> -			cil_log(CIL_ERR, "in-statements cannot be defined within macro statement\n");
> +			cil_log(CIL_ERR, "%s is not allowed in macros (%s:%d)\n", (char *)parse_current->data, parse_current->path, parse_current->line);
>   			goto exit;
>   		}
>   	}
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> index c611dbc..d488870 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -1972,7 +1972,14 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
>
>   		if (new->flavor == CIL_BLOCKINHERIT) {
>   			blockinherit = new->data;
> -			cil_list_append(blockinherit->block->bi_nodes, CIL_NODE, new);
> +			// if a blockinherit statement is copied before blockinherit are
> +			// resolved (like in an in-statement), the block will not have been
> +			// resolved yet, so there's nothing to append yet. This is fine,
> +			// the copied blockinherit statement will be handled later, as if
> +			// it wasn't in an in-statement
> +			if (blockinherit->block != NULL) {
> +				cil_list_append(blockinherit->block->bi_nodes, CIL_NODE, new);
> +			}
>   		}
>
>   		if (parent->cl_head == NULL) {
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 0dfa732..5ff4534 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -3318,6 +3318,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, __attribute__((unu
>   	struct cil_tree_node *optstack = args->optstack;
>   	struct cil_tree_node *boolif = args->boolif;
>   	struct cil_tree_node *blockstack = args->blockstack;
> +	struct cil_tree_node *macro = args->macro;
>
>   	if (node == NULL) {
>   		goto exit;
> @@ -3340,6 +3341,17 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, __attribute__((unu
>   		}
>   	}
>
> +	if (macro != NULL) {
> +		if (node->flavor == CIL_BLOCKINHERIT ||
> +			node->flavor == CIL_BLOCK ||
> +			node->flavor == CIL_BLOCKABSTRACT ||
> +			node->flavor == CIL_MACRO) {
> +			cil_log(CIL_ERR, "%s statement is not allowed in macros (%s:%d)\n", cil_node_to_string(node), node->path, node->line);
> +			rc = SEPOL_ERR;
> +			goto exit;
> +		}
> +	}
> +
>   	if (boolif != NULL) {
>   		if (!(node->flavor == CIL_CONDBLOCK ||
>   			node->flavor == CIL_AVRULE ||
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
