Subject: Re: [PATCH] libsepol/cil: Warn instead of fail if permission is not
 resolve
To: James Carter <jwcart2@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
References: <1469716754-11698-1-git-send-email-jwcart2@tycho.nsa.gov>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <6c6ecfa8-982a-fc82-8836-fb09eb0d89e7@tresys.com>
Date: Thu, 28 Jul 2016 11:56:20 -0400
MIME-Version: 1.0
In-Reply-To: <1469716754-11698-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/28/2016 10:39 AM, James Carter wrote:
> If a policy module package has been created with a policy that contains
> a permission and then is used on a system without that permission CIL
> will fail with an error when it cannot resolve the permission.

An error seems like the correct behavior to me. Similarly, if a module
that references a type/macro/block/etc. is installed on a system without
that type/macro/block/etc., then I would expect an error and the policy
needs to be modified to work on that system.

One potential way to fix this is to wrap the rule using the permission
in an optional or tunable if it is possible that some other system will
not have that permission defined, similar to how this issue is solved
with types/etc.

- Steve

> This will prevent the installation on policy and the user will not
> know that the policy has not been installed.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  libsepol/cil/src/cil_resolve_ast.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 70e4462..8348d57 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -131,10 +131,10 @@ static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab,
>  				}
>  			}
>  			if (rc != SEPOL_OK) {
> -				cil_log(CIL_ERR, "Failed to resolve permission %s\n", (char*)curr->data);
> -				goto exit;
> +				cil_log(CIL_WARN, "Failed to resolve permission %s\n", (char*)curr->data);
> +			} else {
> +				cil_list_append(*perm_datums, CIL_DATUM, perm_datum);
>  			}
> -			cil_list_append(*perm_datums, CIL_DATUM, perm_datum);
>  		} else {
>  			cil_list_append(*perm_datums, curr->flavor, curr->data);
>  		}
> @@ -3660,7 +3660,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
>  			rc = SEPOL_OK;
>  		}
>  
> -		cil_tree_log(node, lvl, "Failed to resolve '%s' in %s statement", args->last_resolved_name, cil_node_to_string(node));
> +		cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
>  		goto exit;
>  	}
>  
> 
