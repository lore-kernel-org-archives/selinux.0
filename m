Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA3HdYBU028750
 for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2016 13:39:34 -0400
Subject: Re: [PATCH] libsepol/cil: Exit with an error for an unknown map
 permission
To: selinux@tycho.nsa.gov
References: <1478103573-19175-1-git-send-email-jwcart2@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <c1572829-de3b-7902-ad4a-baf8cb3c7b89@tycho.nsa.gov>
Date: Thu, 3 Nov 2016 13:39:17 -0400
MIME-Version: 1.0
In-Reply-To: <1478103573-19175-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/02/2016 12:19 PM, James Carter wrote:
> Nicholas Iooss discovered that using an unknown permission with a
> map class will cause a segfault.
>
> CIL will only give a warning when it fails to resolve an unknown
> permission to support the use of policy module packages that use
> permissions that don't exit on the current system. When resolving
> the unknown map class permission an empty list is used to represent
> the unknown permission. When it is evaluated later the list is
> assumed to be a permission and a segfault occurs.
>
> There is no reason to allow unknown class map permissions because
> the class maps and permissions are defined by the policy.
>
> Exit with an error when failing to resolve a class map permission.
>
> Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

Applied.

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index ec547d3..7fe4a74 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -106,7 +106,7 @@ static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key,
>  	return name;
>  }
>
> -static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab, struct cil_list *perm_strs, struct cil_list **perm_datums)
> +static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab, struct cil_list *perm_strs, struct cil_list **perm_datums, enum cil_flavor class_flavor)
>  {
>  	int rc = SEPOL_ERR;
>  	struct cil_list_item *curr;
> @@ -116,7 +116,7 @@ static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab,
>  	cil_list_for_each(curr, perm_strs) {
>  		if (curr->flavor == CIL_LIST) {
>  			struct cil_list *sub_list;
> -			rc = __cil_resolve_perms(class_symtab, common_symtab, curr->data, &sub_list);
> +			rc = __cil_resolve_perms(class_symtab, common_symtab, curr->data, &sub_list, class_flavor);
>  			if (rc != SEPOL_OK) {
>  				cil_log(CIL_ERR, "Failed to resolve permission list\n");
>  				goto exit;
> @@ -132,6 +132,10 @@ static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab,
>  			}
>  			if (rc != SEPOL_OK) {
>  				struct cil_list *empty_list;
> +				if (class_flavor == CIL_MAP_CLASS) {
> +					cil_log(CIL_ERR, "Failed to resolve permission %s for map class\n", (char*)curr->data);
> +					goto exit;
> +				}
>  				cil_log(CIL_WARN, "Failed to resolve permission %s\n", (char*)curr->data);
>  				/* Use an empty list to represent unknown perm */
>  				cil_list_init(&empty_list, perm_strs->flavor);
> @@ -170,7 +174,7 @@ int cil_resolve_classperms(struct cil_tree_node *current, struct cil_classperms
>
>  	cp->class = class;
>
> -	rc = __cil_resolve_perms(&class->perms, common_symtab, cp->perm_strs, &cp->perms);
> +	rc = __cil_resolve_perms(&class->perms, common_symtab, cp->perm_strs, &cp->perms, FLAVOR(datum));
>  	if (rc != SEPOL_OK) {
>  		goto exit;
>  	}
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
