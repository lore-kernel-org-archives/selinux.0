To: Daniel Cashman <dcashman@android.com>, selinux@tycho.nsa.gov
Cc: dcashman@google.com
References: <20170829163205.11085-1-dcashman@android.com>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <d54e9176-5837-3574-0ea6-14df898120d0@tycho.nsa.gov>
Date: Thu, 31 Aug 2017 14:56:19 -0400
MIME-Version: 1.0
In-Reply-To: <20170829163205.11085-1-dcashman@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2] libsepol: cil: Add ability to redeclare
 types[attributes]
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/29/2017 12:32 PM, Daniel Cashman wrote:
> From: Dan Cashman <dcashman@android.com>
> 
> Modify cil_gen_node() to check to see if the cil_db supports multiple
> declarations, and if so, to check whether or not the
> repeated symbol is eligible to share the existing, already-stored datum. The
> only types considered so far are CIL_TYPE and CIL_TYPEATTRIBUTE, both of
> which intall empty datums during AST building, so they automatically return
> true.
> 
> Test: Build policy with multilpe type and attribute declarations, and
> without. Policies are binary-identical.
> 
> Signed-off-by: Dan Cashman <dcashman@android.com>

I applied this with one small change. We have just been adding new functions 
into the LIBSEPOL_1.1 symbol map and that is what I did to your function instead 
of creating a LIBSEPOL_1.2 symbol map.

Thanks,
Jim

> ---
>   libsepol/cil/include/cil/cil.h   |  1 +
>   libsepol/cil/src/cil.c           |  5 +++++
>   libsepol/cil/src/cil_build_ast.c | 48 ++++++++++++++++++++++++++++++++++------
>   libsepol/cil/src/cil_internal.h  |  1 +
>   libsepol/src/libsepol.map.in     |  5 +++++
>   secilc/secilc.c                  |  9 +++++++-
>   6 files changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
> index 86117f24..f8cfc3be 100644
> --- a/libsepol/cil/include/cil/cil.h
> +++ b/libsepol/cil/include/cil/cil.h
> @@ -50,6 +50,7 @@ extern int cil_userprefixes_to_string(cil_db_t *db, char **out, size_t *size);
>   extern int cil_selinuxusers_to_string(cil_db_t *db, char **out, size_t *size);
>   extern int cil_filecons_to_string(cil_db_t *db, char **out, size_t *size);
>   extern void cil_set_disable_dontaudit(cil_db_t *db, int disable_dontaudit);
> +extern void cil_set_multiple_decls(cil_db_t *db, int multiple_decls);
>   extern void cil_set_disable_neverallow(cil_db_t *db, int disable_neverallow);
>   extern void cil_set_preserve_tunables(cil_db_t *db, int preserve_tunables);
>   extern int cil_set_handle_unknown(cil_db_t *db, int handle_unknown);
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index c02a41a5..3fe68af8 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -1691,6 +1691,11 @@ void cil_set_mls(struct cil_db *db, int mls)
>   	db->mls = mls;
>   }
>   
> +void cil_set_multiple_decls(struct cil_db *db, int multiple_decls)
> +{
> +	db->multiple_decls = multiple_decls;
> +}
> +
>   void cil_set_target_platform(struct cil_db *db, int target_platform)
>   {
>   	db->target_platform = target_platform;
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 04492e52..9fc8ab87 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -82,10 +82,33 @@ exit:
>   	return rc;
>   }
>   
> +/*
> + * Determine whether or not multiple declarations of the same key can share a
> + * datum, given the new datum and the one already present in a given symtab.
> + */
> +int cil_is_datum_multiple_decl(__attribute__((unused)) struct cil_symtab_datum *cur,
> +                               __attribute__((unused)) struct cil_symtab_datum *old,
> +                               enum cil_flavor f)
> +{
> +	int rc = CIL_FALSE;
> +
> +	switch (f) {
> +	case CIL_TYPE:
> +	case CIL_TYPEATTRIBUTE:
> +		/* type and typeattribute statements insert empty datums, ret true */
> +		rc = CIL_TRUE;
> +		break;
> +	default:
> +		break;
> +	}
> +	return rc;
> +}
> +
>   int cil_gen_node(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *ast_node, struct cil_symtab_datum *datum, hashtab_key_t key, enum cil_sym_index sflavor, enum cil_flavor nflavor)
>   {
>   	int rc = SEPOL_ERR;
>   	symtab_t *symtab = NULL;
> +	struct cil_symtab_datum *prev;
>   
>   	rc = __cil_verify_name((const char*)key);
>   	if (rc != SEPOL_OK) {
> @@ -103,15 +126,26 @@ int cil_gen_node(__attribute__((unused)) struct cil_db *db, struct cil_tree_node
>   	if (symtab != NULL) {
>   		rc = cil_symtab_insert(symtab, (hashtab_key_t)key, datum, ast_node);
>   		if (rc == SEPOL_EEXIST) {
> -			cil_log(CIL_ERR, "Re-declaration of %s %s\n",
> -				cil_node_to_string(ast_node), key);
> -			if (cil_symtab_get_datum(symtab, key, &datum) == SEPOL_OK) {
> -				if (sflavor == CIL_SYM_BLOCKS) {
> -					struct cil_tree_node *node = datum->nodes->head->data;
> -					cil_tree_log(node, CIL_ERR, "Previous declaration");
> +			if (!db->multiple_decls ||
> +			    cil_symtab_get_datum(symtab, (hashtab_key_t)key, &prev) != SEPOL_OK ||
> +			    !cil_is_datum_multiple_decl(datum, prev, nflavor)) {
> +
> +				/* multiple_decls not ok, ret error */
> +				cil_log(CIL_ERR, "Re-declaration of %s %s\n",
> +					cil_node_to_string(ast_node), key);
> +				if (cil_symtab_get_datum(symtab, key, &datum) == SEPOL_OK) {
> +					if (sflavor == CIL_SYM_BLOCKS) {
> +						struct cil_tree_node *node = datum->nodes->head->data;
> +						cil_tree_log(node, CIL_ERR, "Previous declaration");
> +					}
>   				}
> +				goto exit;
>   			}
> -			goto exit;
> +			/* multiple_decls is enabled and works for this datum type, add node */
> +			cil_list_append(prev->nodes, CIL_NODE, ast_node);
> +			ast_node->data = prev;
> +			cil_symtab_datum_destroy(datum);
> +			free(datum);
>   		}
>   	}
>   
> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
> index 6d6a7d90..136a0049 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -316,6 +316,7 @@ struct cil_db {
>   	int preserve_tunables;
>   	int handle_unknown;
>   	int mls;
> +	int multiple_decls;
>   	int target_platform;
>   	int policy_version;
>   };
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index dd1fec21..aace91a2 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -56,3 +56,8 @@ LIBSEPOL_1.1 {
>   	sepol_kernel_policydb_to_cil;
>   	sepol_kernel_policydb_to_conf;
>   } LIBSEPOL_1.0;
> +
> +LIBSEPOL_1.2 {
> +  global:
> +	cil_set_multiple_decls;
> +} LIBSEPOL_1.1;
> diff --git a/secilc/secilc.c b/secilc/secilc.c
> index f2232e72..0be6975b 100644
> --- a/secilc/secilc.c
> +++ b/secilc/secilc.c
> @@ -63,6 +63,7 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
>   	printf("                                 statement if present in the policy\n");
>   	printf("  -D, --disable-dontaudit        do not add dontaudit rules to the binary policy\n");
>   	printf("  -P, --preserve-tunables        treat tunables as booleans\n");
> +	printf("  -m, --multiple-decls           allow some statements to be re-declared\n");
>   	printf("  -N, --disable-neverallow       do not check neverallow rules\n");
>   	printf("  -G, --expand-generated         Expand and remove auto-generated attributes\n");
>   	printf("  -X, --expand-size <SIZE>       Expand type attributes with fewer than <SIZE>\n");
> @@ -89,6 +90,7 @@ int main(int argc, char *argv[])
>   	int target = SEPOL_TARGET_SELINUX;
>   	int mls = -1;
>   	int disable_dontaudit = 0;
> +	int multiple_decls = 0;
>   	int disable_neverallow = 0;
>   	int preserve_tunables = 0;
>   	int handle_unknown = -1;
> @@ -108,6 +110,7 @@ int main(int argc, char *argv[])
>   		{"policyversion", required_argument, 0, 'c'},
>   		{"handle-unknown", required_argument, 0, 'U'},
>   		{"disable-dontaudit", no_argument, 0, 'D'},
> +		{"multiple-decls", no_argument, 0, 'm'},
>   		{"disable-neverallow", no_argument, 0, 'N'},
>   		{"preserve-tunables", no_argument, 0, 'P'},
>   		{"output", required_argument, 0, 'o'},
> @@ -119,7 +122,7 @@ int main(int argc, char *argv[])
>   	int i;
>   
>   	while (1) {
> -		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDNc:GX:", long_opts, &opt_index);
> +		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNc:GX:", long_opts, &opt_index);
>   		if (opt_char == -1) {
>   			break;
>   		}
> @@ -175,6 +178,9 @@ int main(int argc, char *argv[])
>   			case 'D':
>   				disable_dontaudit = 1;
>   				break;
> +			case 'm':
> +				multiple_decls = 1;
> +				break;
>   			case 'N':
>   				disable_neverallow = 1;
>   				break;
> @@ -223,6 +229,7 @@ int main(int argc, char *argv[])
>   
>   	cil_db_init(&db);
>   	cil_set_disable_dontaudit(db, disable_dontaudit);
> +	cil_set_multiple_decls(db, multiple_decls);
>   	cil_set_disable_neverallow(db, disable_neverallow);
>   	cil_set_preserve_tunables(db, preserve_tunables);
>   	if (handle_unknown != -1) {
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
