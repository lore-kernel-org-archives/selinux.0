Message-ID: <5412F29B.2030401@tycho.nsa.gov>
Date: Fri, 12 Sep 2014 09:18:19 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libsepol/cil: fix compilation with -Wformat-security
References: <1410469510-5089-1-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410469510-5089-1-git-send-email-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks for the patch. I've applied it.

Jim

On 09/11/2014 05:05 PM, Nicolas Iooss wrote:
> Once a printf format attribute is added to cil_log, compiling with gcc
> -Wformat -Wformat-security -Werror fails with two kind of errors:
>
> * format '%s' expects argument of type 'char *', but argument 3 has type 'void *'
> * format '%n' expects argument of type 'int *', but argument 4 has type 'uint32_t'
>
> The second one is quite surprising and it seems %n has been used instead
> of %u several times in cil_resolve_ast.c.
>
> Fix these printf-format-check errors.
> ---
>   libsepol/cil/include/cil/cil.h     |  4 ++++
>   libsepol/cil/src/cil_build_ast.c   |  9 +++++----
>   libsepol/cil/src/cil_log.h         |  4 +---
>   libsepol/cil/src/cil_resolve_ast.c | 12 ++++++------
>   libsepol/cil/src/cil_verify.c      | 10 +++++-----
>   5 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
> index 00047a48cbea..902ca3e87b01 100644
> --- a/libsepol/cil/include/cil/cil.h
> +++ b/libsepol/cil/include/cil/cil.h
> @@ -58,6 +58,10 @@ enum cil_log_level {
>   };
>   extern void cil_set_log_level(enum cil_log_level lvl);
>   extern void cil_set_log_handler(void (*handler)(int lvl, char *msg));
> +
> +#ifdef __GNUC__
> +__attribute__ ((format(printf, 2, 3)))
> +#endif
>   extern void cil_log(enum cil_log_level lvl, const char *msg, ...);
>
>   extern void cil_set_malloc_error_handler(void (*handler)(void));
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 945b0a8bf306..3a38559b7c0d 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -2271,7 +2271,7 @@ static int __cil_fill_expr(struct cil_tree_node *current, enum cil_flavor flavor
>   	if (current->cl_head == NULL) {
>   		enum cil_flavor op = __cil_get_expr_operator_flavor(current->data);
>   		if (op != CIL_NONE) {
> -			cil_log(CIL_ERR,"Operator (%s) not in an expression\n", current->data);
> +			cil_log(CIL_ERR, "Operator (%s) not in an expression\n", (char*)current->data);
>   			goto exit;
>   		}
>   		cil_list_append(expr, CIL_STRING, current->data);
> @@ -2378,7 +2378,7 @@ static int __cil_fill_constraint_leaf_expr(struct cil_tree_node *current, enum c
>   		leaf_expr_flavor = CIL_LEVEL;
>   		break;
>   	default:
> -		cil_log(CIL_ERR,"Invalid left operand (%s)\n",current->next->data);
> +		cil_log(CIL_ERR, "Invalid left operand (%s)\n", (char*)current->next->data);
>   		goto exit;
>   	}
>
> @@ -2705,7 +2705,7 @@ int cil_gen_condblock(struct cil_db *db, struct cil_tree_node *parse_current, st
>
>   exit:
>   	cil_log(CIL_ERR, "Bad %s condition declaration at line %d of %s\n",
> -		parse_current->data, parse_current->line, parse_current->path);
> +		(char*)parse_current->data, parse_current->line, parse_current->path);
>   	cil_destroy_condblock(cb);
>   	return rc;
>   }
> @@ -2765,7 +2765,8 @@ int cil_gen_alias(struct cil_db *db, struct cil_tree_node *parse_current, struct
>   	return SEPOL_OK;
>
>   exit:
> -	cil_log(CIL_ERR, "Bad %s declaration at line %d of %s\n", parse_current->data, parse_current->line, parse_current->path);
> +	cil_log(CIL_ERR, "Bad %s declaration at line %d of %s\n",
> +		(char*)parse_current->data, parse_current->line, parse_current->path);
>   	cil_destroy_alias(alias);
>   	cil_clear_node(ast_node);
>   	return rc;
> diff --git a/libsepol/cil/src/cil_log.h b/libsepol/cil/src/cil_log.h
> index 46646c5b329b..9c2ff2e83ebc 100644
> --- a/libsepol/cil/src/cil_log.h
> +++ b/libsepol/cil/src/cil_log.h
> @@ -34,8 +34,6 @@
>
>   #define MAX_LOG_SIZE 512
>
> -
> -
> -void cil_log(enum cil_log_level lvl, const char *msg, ...);
> +__attribute__ ((format(printf, 2, 3))) void cil_log(enum cil_log_level lvl, const char *msg, ...);
>
>   #endif // CIL_LOG_H_
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 3b79e90f478b..a36b23808581 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -128,7 +128,7 @@ static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab,
>   				}
>   			}
>   			if (rc != SEPOL_OK) {
> -				cil_log(CIL_ERR, "Failed to resolve permission %s\n", curr->data);
> +				cil_log(CIL_ERR, "Failed to resolve permission %s\n", (char*)curr->data);
>   				goto exit;
>   			}
>   			cil_list_append(*perm_datums, CIL_DATUM, perm_datum);
> @@ -2210,7 +2210,7 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
>
>   		if (user->bounds != NULL) {
>   			struct cil_tree_node *node = user->bounds->datum.nodes->head->data;
> -			cil_log(CIL_ERR, "User %s already bound by parent at line %n of %s\n", bounds->child_str, node->line, node->path);
> +			cil_log(CIL_ERR, "User %s already bound by parent at line %u of %s\n", bounds->child_str, node->line, node->path);
>   			rc = SEPOL_ERR;
>   			goto exit;
>   		}
> @@ -2223,7 +2223,7 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
>
>   		if (role->bounds != NULL) {
>   			struct cil_tree_node *node = role->bounds->datum.nodes->head->data;
> -			cil_log(CIL_ERR, "Role %s already bound by parent at line %n of %s\n", bounds->child_str, node->line, node->path);
> +			cil_log(CIL_ERR, "Role %s already bound by parent at line %u of %s\n", bounds->child_str, node->line, node->path);
>   			rc = SEPOL_ERR;
>   			goto exit;
>   		}
> @@ -2237,8 +2237,8 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
>
>   		if (type->bounds != NULL) {
>   			node = ((struct cil_symtab_datum *)type->bounds)->nodes->head->data;
> -			cil_log(CIL_ERR, "Type %s already bound by parent at line %n of %s\n", bounds->child_str, node->line, node->path);
> -			cil_log(CIL_ERR, "Now being bound to parent %s at line %n of %s\n", bounds->parent_str, current->line, current->path);
> +			cil_log(CIL_ERR, "Type %s already bound by parent at line %u of %s\n", bounds->child_str, node->line, node->path);
> +			cil_log(CIL_ERR, "Now being bound to parent %s at line %u of %s\n", bounds->parent_str, current->line, current->path);
>   			rc = SEPOL_ERR;
>   			goto exit;
>   		}
> @@ -2267,7 +2267,7 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
>   	return SEPOL_OK;
>
>   exit:
> -	cil_log(CIL_ERR, "Bad bounds statement at line %n of %s\n", current->line, current->path);
> +	cil_log(CIL_ERR, "Bad bounds statement at line %u of %s\n", current->line, current->path);
>   	return rc;
>   }
>
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 995496c5e757..a1576e761f1f 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -166,13 +166,13 @@ int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, en
>   	case CIL_EQ:
>   	case CIL_NEQ:
>   		if (expr_flavor != CIL_BOOL && expr_flavor != CIL_TUNABLE ) {
> -			cil_log(CIL_ERR,"Invalid operator (%s) for set expression\n", current->data);
> +			cil_log(CIL_ERR,"Invalid operator (%s) for set expression\n", (char*)current->data);
>   			goto exit;
>   		}
>   		break;
>   	case CIL_ALL:
>   		if (expr_flavor == CIL_BOOL || expr_flavor == CIL_TUNABLE) {
> -			cil_log(CIL_ERR,"Invalid operator (%s) for boolean or tunable expression\n", current->data);
> +			cil_log(CIL_ERR,"Invalid operator (%s) for boolean or tunable expression\n", (char*)current->data);
>   			goto exit;
>   		}
>   		syntax[1] = CIL_SYN_END;
> @@ -180,7 +180,7 @@ int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, en
>   		break;
>   	case CIL_RANGE:
>   		if (expr_flavor != CIL_CAT) {
> -			cil_log(CIL_ERR,"Operator (%s) only valid for catset expression\n", current->data);
> +			cil_log(CIL_ERR,"Operator (%s) only valid for catset expression\n", (char*)current->data);
>   			goto exit;
>   		}
>   		syntax[1] = CIL_SYN_STRING;
> @@ -192,7 +192,7 @@ int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, en
>   		syntax_len = 2;
>   		break;
>   	default:
> -		cil_log(CIL_ERR,"Unexpected value (%s) for expression operator\n", current->data);
> +		cil_log(CIL_ERR,"Unexpected value (%s) for expression operator\n", (char*)current->data);
>   		goto exit;
>   	}
>
> @@ -298,7 +298,7 @@ int cil_verify_constraint_expr_syntax(struct cil_tree_node *current, enum cil_fl
>   		syntax[2] = CIL_SYN_STRING;
>   		break;
>   	default:
> -		cil_log(CIL_ERR,"Invalid operator (%s) for constraint expression\n",current->data);
> +		cil_log(CIL_ERR, "Invalid operator (%s) for constraint expression\n", (char*)current->data);
>   		goto exit;
>   	}
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
