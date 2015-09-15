Subject: Re: [PATCH v2] libsepol/cil: improve recursion detection
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
References: <1442333155-8215-1-git-send-email-slawrence@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <55F84CF5.1030007@tycho.nsa.gov>
Date: Tue, 15 Sep 2015 12:53:09 -0400
MIME-Version: 1.0
In-Reply-To: <1442333155-8215-1-git-send-email-slawrence@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/15/2015 12:05 PM, Steve Lawrence wrote:
> Add support for detecting recursive blockinherits, and print a trace of
> the detected loop. Output will look something like this upon detection:
>
>    Recursive blockinherit found:
>      test.cil:42: block a
>      test.cil:43: blockinherit b
>      test.cil:36: block b
>      test.cil:37: blockinherit c
>      test.cil:39: block c
>      test.cil:40: blockinherit a
>
> Additionally, improve support for detecting recursive macros/calls. Due
> to the way calls are copied, the existing code only detected recursion
> with call depth of three or more. Smaller depths, like
>
>    (macro m ()
>      (call m))
>
> were not detected and caused a segfault. The callstack that was used for
> this was not sufficient, so that is removed and replaced with a method
> similar to the block recursion detection. A similar trace is also
> displayed for recursive macros/calls.
>
> Also, cleanup sidorder, classorder, catorder, sensorder, and in lists at
> the end of resolve, fixing a potential memory leak if errors occur
> during resolve.
>
> Signed-off-by: Steve Lawrence <slawrence@tresys.com>

Looks good. Applied.

Thanks,
Jim

> ---
>
> Changes since v2:
> - Move the recursive print loops into separate functions to make for
>    more clear code
> - Change the recursive print loops to terminate on a known node rather
>    than looping until the node is NULL
>
>   libsepol/cil/src/cil_resolve_ast.c | 199 ++++++++++++++++++++++++++++++-------
>   1 file changed, 161 insertions(+), 38 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 0df5c63..e332cbd 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -52,7 +52,6 @@ struct cil_args_resolve {
>   	enum cil_pass pass;
>   	uint32_t *changed;
>   	char *last_resolved_name;
> -	struct cil_tree_node *callstack;
>   	struct cil_tree_node *optstack;
>   	struct cil_tree_node *boolif;
>   	struct cil_tree_node *macro;
> @@ -2210,6 +2209,73 @@ exit:
>   	return rc;
>   }
>
> +void cil_print_recursive_blockinherit(struct cil_tree_node *bi_node, struct cil_tree_node *terminating_node)
> +{
> +	struct cil_list *trace = NULL;
> +	struct cil_list_item *item = NULL;
> +	struct cil_tree_node *curr = NULL;
> +
> +	cil_list_init(&trace, CIL_NODE);
> +
> +	for (curr = bi_node; curr != terminating_node; curr = curr->parent) {
> +		if (curr->flavor == CIL_BLOCK) {
> +			cil_list_prepend(trace, CIL_NODE, curr);
> +		} else {
> +			if (curr != bi_node) {
> +				cil_list_prepend(trace, CIL_NODE, NODE(((struct cil_blockinherit *)curr->data)->block));
> +			}
> +			cil_list_prepend(trace, CIL_NODE, curr);
> +		}
> +	}
> +	cil_list_prepend(trace, CIL_NODE, terminating_node);
> +
> +	cil_list_for_each(item, trace) {
> +		curr = item->data;
> +		cil_log(CIL_ERR, "  %s:%d: ", curr->path, curr->line);
> +
> +		if (curr->flavor == CIL_BLOCK) {
> +			cil_log(CIL_ERR, "block %s\n", DATUM(curr->data)->name);
> +		} else {
> +			cil_log(CIL_ERR, "blockinherit %s\n", ((struct cil_blockinherit *)curr->data)->block_str);
> +		}
> +	}
> +
> +	cil_list_destroy(&trace, CIL_FALSE);
> +}
> +
> +int cil_check_recursive_blockinherit(struct cil_tree_node *bi_node)
> +{
> +	struct cil_tree_node *curr = NULL;
> +	struct cil_blockinherit *bi = NULL;
> +	struct cil_block *block = NULL;
> +	int rc = SEPOL_ERR;
> +
> +	bi = bi_node->data;
> +
> +	for (curr = bi_node->parent; curr != NULL; curr = curr->parent) {
> +		if (curr->flavor != CIL_BLOCK) {
> +			continue;
> +		}
> +
> +		block = curr->data;
> +
> +		if (block != bi->block) {
> +			continue;
> +		}
> +
> +		cil_log(CIL_ERR, "Recursive blockinherit found:\n");
> +		cil_print_recursive_blockinherit(bi_node, curr);
> +
> +		rc = SEPOL_ERR;
> +		goto exit;
> +	}
> +
> +	rc = SEPOL_OK;
> +
> +exit:
> +	return rc;
> +}
> +
>   int cil_resolve_blockinherit_copy(struct cil_tree_node *current, void *extra_args)
>   {
>   	struct cil_block *block = current->data;
> @@ -2233,6 +2299,11 @@ int cil_resolve_blockinherit_copy(struct cil_tree_node *current, void *extra_arg
>   	}
>
>   	cil_list_for_each(item, block->bi_nodes) {
> +		rc = cil_check_recursive_blockinherit(item->data);
> +		if (rc != SEPOL_OK) {
> +			goto exit;
> +		}
> +
>   		rc = cil_copy_ast(db, current, item->data);
>   		if (rc != SEPOL_OK) {
>   			cil_log(CIL_ERR, "Failed to copy block contents into blockinherit\n");
> @@ -2500,6 +2571,80 @@ exit:
>   	return rc;
>   }
>
> +void cil_print_recursive_call(struct cil_tree_node *call_node, struct cil_tree_node *terminating_node)
> +{
> +	struct cil_list *trace = NULL;
> +	struct cil_list_item * item = NULL;
> +	struct cil_tree_node *curr = NULL;
> +
> +	cil_list_init(&trace, CIL_NODE);
> +
> +	for (curr = call_node; curr != terminating_node; curr = curr->parent) {
> +		if (curr->flavor == CIL_CALL) {
> +			if (curr != call_node) {
> +				cil_list_prepend(trace, CIL_NODE, NODE(((struct cil_call *)curr->data)->macro));
> +			}
> +			cil_list_prepend(trace, CIL_NODE, curr);
> +		}
> +	}
> +
> +	if (terminating_node->flavor == CIL_MACRO) {
> +		cil_list_prepend(trace, CIL_NODE, terminating_node);
> +	} else {
> +		cil_list_prepend(trace, CIL_NODE, NODE(((struct cil_call *)terminating_node->data)->macro));
> +	}
> +
> +	cil_list_for_each(item, trace) {
> +		curr = item->data;
> +		cil_log(CIL_ERR, "  %s:%d: ", curr->path, curr->line);
> +
> +		if (curr->flavor == CIL_MACRO) {
> +			cil_log(CIL_ERR, "macro %s\n", DATUM(curr->data)->name);
> +		} else {
> +			cil_log(CIL_ERR, "call %s\n", ((struct cil_call *)curr->data)->macro_str);
> +		}
> +	}
> +
> +	cil_list_destroy(&trace, CIL_FALSE);
> +}
> +
> +int cil_check_recursive_call(struct cil_tree_node *call_node, struct cil_tree_node *macro_node)
> +{
> +	struct cil_tree_node *curr = NULL;
> +	struct cil_call * call = NULL;
> +	int rc = SEPOL_ERR;
> +
> +	for (curr = call_node; curr != NULL; curr = curr->parent) {
> +		if (curr->flavor == CIL_CALL) {
> +			if (curr == call_node) {
> +				continue;
> +			}
> +
> +			call = curr->data;
> +			if (call->macro != macro_node->data) {
> +				continue;
> +			}
> +		} else if (curr->flavor == CIL_MACRO) {
> +			if (curr != macro_node) {
> +				rc = SEPOL_OK;
> +				goto exit;
> +			}
> +		} else {
> +			continue;
> +		}
> +
> +		cil_log(CIL_ERR, "Recursive macro call found:\n");
> +		cil_print_recursive_call(call_node, curr);
> +
> +		rc = SEPOL_ERR;
> +		goto exit;
> +	}
> +
> +	rc = SEPOL_OK;
> +exit:
> +	return rc;
> +}
> +
>   int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
>   {
>   	struct cil_call *new_call = current->data;
> @@ -2736,6 +2881,12 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
>
>   	if (new_call->copied == 0) {
>   		new_call->copied = 1;
> +
> +		rc = cil_check_recursive_call(current, macro_node);
> +		if (rc != SEPOL_OK) {
> +			goto exit;
> +		}
> +
>   		rc = cil_copy_ast(db, macro_node, current);
>   		if (rc != SEPOL_OK) {
>   			cil_log(CIL_ERR, "Failed to copy macro, rc: %d\n", rc);
> @@ -3509,7 +3660,6 @@ int __cil_resolve_ast_first_child_helper(struct cil_tree_node *current, void *ex
>   {
>   	int rc = SEPOL_ERR;
>   	struct cil_args_resolve *args = extra_args;
> -	struct cil_tree_node *callstack = NULL;
>   	struct cil_tree_node *optstack = NULL;
>   	struct cil_tree_node *parent = NULL;
>   	struct cil_tree_node *blockstack = NULL;
> @@ -3519,36 +3669,18 @@ int __cil_resolve_ast_first_child_helper(struct cil_tree_node *current, void *ex
>   		goto exit;
>   	}
>
> -	callstack = args->callstack;
>   	optstack = args->optstack;
>   	parent = current->parent;
>   	blockstack = args->blockstack;
>
> -	if (parent->flavor == CIL_CALL || parent->flavor == CIL_OPTIONAL || parent->flavor == CIL_BLOCK) {
> +	if (parent->flavor == CIL_OPTIONAL || parent->flavor == CIL_BLOCK) {
>   		/* push this node onto a stack */
>   		cil_tree_node_init(&new);
>
>   		new->data = parent->data;
>   		new->flavor = parent->flavor;
>
> -		if (parent->flavor == CIL_CALL) {
> -			if (callstack != NULL) {
> -				struct cil_tree_node *curr = NULL;
> -				struct cil_call *new_call = new->data;
> -				for (curr = callstack->cl_head; curr != NULL;
> -					curr = curr->cl_head) {
> -					struct cil_call *curr_call = curr->data;
> -					if (curr_call->macro == new_call->macro) {
> -						cil_log(CIL_ERR, "Recursive macro call found\n");
> -						rc = SEPOL_ERR;
> -						goto exit;
> -					}
> -				}
> -				callstack->parent = new;
> -				new->cl_head = callstack;
> -			}
> -			args->callstack = new;
> -		} else if (parent->flavor == CIL_OPTIONAL) {
> +		if (parent->flavor == CIL_OPTIONAL) {
>   			if (optstack != NULL) {
>   				optstack->parent = new;
>   				new->cl_head = optstack;
> @@ -3587,15 +3719,7 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
>
>   	parent = current->parent;
>
> -	if (parent->flavor == CIL_CALL) {
> -		/* pop off the stack */
> -		struct cil_tree_node *callstack = args->callstack;
> -		args->callstack = callstack->cl_head;
> -		if (callstack->cl_head) {
> -			callstack->cl_head->parent = NULL;
> -		}
> -		free(callstack);
> -	} else if (parent->flavor == CIL_MACRO) {
> +	if (parent->flavor == CIL_MACRO) {
>   		args->macro = NULL;
>   	} else if (parent->flavor == CIL_OPTIONAL) {
>   		struct cil_tree_node *optstack;
> @@ -3645,7 +3769,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>   	extra_args.pass = pass;
>   	extra_args.changed = &changed;
>   	extra_args.last_resolved_name = NULL;
> -	extra_args.callstack = NULL;
>   	extra_args.optstack = NULL;
>   	extra_args.boolif= NULL;
>   	extra_args.macro = NULL;
> @@ -3737,12 +3860,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>
>   		/* reset the arguments */
>   		changed = 0;
> -		while (extra_args.callstack != NULL) {
> -			struct cil_tree_node *curr = extra_args.callstack;
> -			struct cil_tree_node *next = curr->cl_head;
> -			free(curr);
> -			extra_args.callstack = next;
> -		}
>   		while (extra_args.optstack != NULL) {
>   			struct cil_tree_node *curr = extra_args.optstack;
>   			struct cil_tree_node *next = curr->cl_head;
> @@ -3764,6 +3881,12 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>
>   	rc = SEPOL_OK;
>   exit:
> +	__cil_ordered_lists_destroy(&extra_args.sidorder_lists);
> +	__cil_ordered_lists_destroy(&extra_args.classorder_lists);
> +	__cil_ordered_lists_destroy(&extra_args.catorder_lists);
> +	__cil_ordered_lists_destroy(&extra_args.sensitivityorder_lists);
> +	cil_list_destroy(&extra_args.in_list, CIL_FALSE);
> +
>   	return rc;
>   }
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
