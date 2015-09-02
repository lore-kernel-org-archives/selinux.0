Subject: Re: [PATCH v2 2/3] libsepol/cil: add ioctl whitelist support
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
References: <1441025637-18267-1-git-send-email-slawrence@tresys.com>
 <1441025637-18267-3-git-send-email-slawrence@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <55E74DA6.2090504@tycho.nsa.gov>
Date: Wed, 2 Sep 2015 15:27:34 -0400
MIME-Version: 1.0
In-Reply-To: <1441025637-18267-3-git-send-email-slawrence@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ok. I finished reviewing. Just a couple of minor things listed below.

On 08/31/2015 08:53 AM, Steve Lawrence wrote:
> Add three new extended avrule statements with the following syntax:
>
>    (allowx source_type target_type permissionx)
>    (auditallowx source_type target_type permissionx)
>    (dontauditx source_type target_type permissionx)
>
> source_type - type, typeattribute, or typealias
> target_type - type, typeattribute, typealias, or "self" keyword
> permissionx - named or anonymous permissionx statement, which has the syntax:
>
>    (permissionx name (kind object expression))
>
> name - unique identifier of the permissionx statement
> kind - must be "ioctl"; could be extended in the future
> object - class or classmap
> expression - standard CIL expression containing hexadecimal values,
>    prefixed with '0x', and the expression keywords 'or', 'xor', 'and',
>    'not', 'range', or 'all'. Values must be between 0x0000 and 0xFFFF.
>    Values may also be provided in decimal, or in octal if starting with '0'.
>
> For example:
>
>   (allowx src_t tgt_t (ioctl cls (0x1111 0x1222 0x1333)))
>   (allowx src_t tgt_t (ioctl cls (range 0x1400 0x14FF)))
>   (allowx src_t tgt_t (ioctl cls (and (range 0x1600 0x19FF) (not (range 0x1750 0x175F)))))
>
>   (permissionx ioctl_nodebug (ioctl cls (not (range 0x2010 0x2013))))
>   (allowx src_t tgt_t ioctl_nodebug)
>
> Signed-off-by: Steve Lawrence <slawrence@tresys.com>
> ---
>   libsepol/cil/src/cil.c             |  63 ++++++-
>   libsepol/cil/src/cil_binary.c      | 360 ++++++++++++++++++++++++++++++++++++-
>   libsepol/cil/src/cil_build_ast.c   | 175 ++++++++++++++++++
>   libsepol/cil/src/cil_build_ast.h   |   4 +
>   libsepol/cil/src/cil_copy_ast.c    |  59 ++++++
>   libsepol/cil/src/cil_flavor.h      |   2 +
>   libsepol/cil/src/cil_internal.h    |  28 +++
>   libsepol/cil/src/cil_post.c        | 144 +++++++++++++--
>   libsepol/cil/src/cil_resolve_ast.c |  79 ++++++++
>   libsepol/cil/src/cil_verify.c      |   4 +-
>   10 files changed, 898 insertions(+), 20 deletions(-)
>

...

> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 92c3e09..655a04a 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c

In __cil_get_expr_operator_flavor(), the comment for the range operator needs to 
be updated to reflect that range is used for both categories and permissionxes.

...

> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index e68a2da..b1ccc73 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -320,6 +320,79 @@ exit:
>   	return rc;
>   }
>
> +int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_permissionx *permx, void *extra_args)
> +{
> +	struct cil_symtab_datum *obj_datum = NULL;
> +	int rc = SEPOL_ERR;
> +
> +	rc = cil_resolve_name(current, permx->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
> +	if (rc != SEPOL_OK) {
> +		goto exit;
> +	}
> +	permx->obj = (struct cil_class*)obj_datum;
> +
> +	return SEPOL_OK;
> +
> +exit:
> +	return rc;
> +}
> +
> +int cil_resolve_avrulex(struct cil_tree_node *current, void *extra_args)
> +{
> +	struct cil_args_resolve *args = extra_args;
> +	struct cil_db *db = NULL;
> +
> +	struct cil_avrulex *rule = current->data;
> +	struct cil_symtab_datum *src_datum = NULL;
> +	struct cil_symtab_datum *tgt_datum = NULL;
> +	struct cil_symtab_datum *permx_datum = NULL;
> +	int rc = SEPOL_ERR;
> +
> +	if (args != NULL) {
> +		db = args->db;
> +	}
> +
> +	rc = cil_resolve_name(current, rule->src_str, CIL_SYM_TYPES, args, &src_datum);
> +	if (rc != SEPOL_OK) {
> +		goto exit;
> +	}
> +	rule->src = src_datum;
> +	if (rule->rule_kind != CIL_AVRULE_NEVERALLOW) {
> +		cil_type_used(src_datum);
> +	}
> +

There is no neverallow equivalent for avrulex, so this check is not necessary.

> +	if (rule->tgt_str == CIL_KEY_SELF) {
> +		rule->tgt = db->selftype;
> +	} else {
> +		rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, args, &tgt_datum);
> +		if (rc != SEPOL_OK) {
> +			goto exit;
> +		}
> +		rule->tgt = tgt_datum;
> +		if (rule->rule_kind != CIL_AVRULE_NEVERALLOW) {
> +			cil_type_used(tgt_datum);
> +		}
> +	}
> +

Same here.

> +	if (rule->permx_str != NULL) {
> +		rc = cil_resolve_name(current, rule->permx_str, CIL_SYM_PERMX, args, &permx_datum);
> +		if (rc != SEPOL_OK) {
> +			goto exit;
> +		}
> +		rule->permx = (struct cil_permissionx*)permx_datum;
> +	} else {
> +		rc = cil_resolve_permissionx(current, rule->permx, extra_args);
> +		if (rc != SEPOL_OK) {
> +			goto exit;
> +		}
> +	}
> +
> +	return SEPOL_OK;
> +
> +exit:
> +	return rc;
> +}
> +
>   int cil_resolve_type_rule(struct cil_tree_node *current, void *extra_args)
>   {
>   	struct cil_type_rule *rule = current->data;


Everything else looks good to me.

Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
