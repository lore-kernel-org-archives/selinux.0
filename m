Message-ID: <5587FC29.60704@tresys.com>
Date: Mon, 22 Jun 2015 08:14:33 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: James Carter <jwcart2@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 07/10 v3] libsepol/cil: Track number of classes and number
 of types and attributes.
References: <1434737956-17932-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1434737956-17932-8-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1434737956-17932-8-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/19/2015 02:19 PM, James Carter wrote:
> These values are stored in the CIL db so they can be used to
> determine how much memory is needed for mapping libsepol values
> to CIL data.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

Acked-by: Steve Lawrence <slawrence@tresys.com>

> ---
>  libsepol/cil/src/cil.c          |  3 +-
>  libsepol/cil/src/cil_binary.c   | 73 +++++++++++++++++++++++++++++++++--------
>  libsepol/cil/src/cil_binary.h   |  4 +--
>  libsepol/cil/src/cil_internal.h |  2 ++
>  libsepol/cil/src/cil_post.c     | 26 +++++++++++----
>  5 files changed, 85 insertions(+), 23 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 5c53bf3..be070de 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -257,7 +257,8 @@ void cil_db_init(struct cil_db **db)
>  	cil_type_init(&(*db)->selftype);
>  	(*db)->selftype->datum.name = CIL_KEY_SELF;
>  	(*db)->selftype->datum.fqn = CIL_KEY_SELF;
> -
> +	(*db)->num_types_and_attrs = 0;
> +	(*db)->num_classes = 0;
>  	(*db)->num_types = 0;
>  	(*db)->num_roles = 0;
>  	(*db)->num_cats = 0;
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index fd5983a..066184a 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -55,6 +55,7 @@
>  #define FILENAME_TRANS_TABLE_SIZE 1 << 16
>  #define RANGE_TRANS_TABLE_SIZE 1 << 13
>  #define ROLE_TRANS_TABLE_SIZE 1 << 10
> +#define PERMS_PER_CLASS 32
>  
>  struct cil_args_binary {
>  	const struct cil_db *db;
> @@ -64,6 +65,7 @@ struct cil_args_binary {
>  	hashtab_t filename_trans_table;
>  	hashtab_t range_trans_table;
>  	hashtab_t role_trans_table;
> +	void **type_value_to_cil;
>  };
>  
>  struct cil_args_booleanif {
> @@ -303,7 +305,7 @@ exit:
>  	return rc;
>  }
>  
> -int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_db *db)
> +int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
>  {
>  	int rc = SEPOL_ERR;
>  	struct cil_list_item *curr_class;
> @@ -312,8 +314,8 @@ int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_db *db)
>  		struct cil_class *cil_class = curr_class->data;
>  		uint32_t value = 0;
>  		char *key = NULL;
> -		struct cil_tree_node *node = cil_class->datum.nodes->head->data;
> -		struct cil_tree_node *cil_perm = node->cl_head;
> +		int class_index;
> +		struct cil_tree_node *curr;
>  		common_datum_t *sepol_common = NULL;
>  		class_datum_t *sepol_class = cil_malloc(sizeof(*sepol_class));
>  		memset(sepol_class, 0, sizeof(class_datum_t));
> @@ -326,6 +328,8 @@ int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_db *db)
>  			goto exit;
>  		}
>  		sepol_class->s.value = value;
> +		class_index = value;
> +		class_value_to_cil[class_index] = cil_class;
>  
>  		rc = symtab_init(&sepol_class->permissions, PERM_SYMTAB_SIZE);
>  		if (rc != SEPOL_OK) {
> @@ -333,6 +337,7 @@ int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_db *db)
>  		}
>  
>  		if (cil_class->common != NULL) {
> +			int i;
>  			struct cil_class *cil_common = cil_class->common;
>  
>  			key = cil_class->common->datum.fqn;
> @@ -346,14 +351,19 @@ int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_db *db)
>  			sepol_class->comdatum = sepol_common;
>  			sepol_class->comkey = cil_strdup(key);
>  			sepol_class->permissions.nprim += sepol_common->permissions.nprim;
> +
> +			for (curr = NODE(cil_class->common)->cl_head, i = 1; curr; curr = curr->next, i++) {
> +				struct cil_perm *cil_perm = curr->data;
> +				perm_value_to_cil[class_index][i] = cil_perm;
> +			}
>  		}
>  
> -		while (cil_perm != NULL) {
> -			struct cil_perm *curr_perm = cil_perm->data;
> +		for (curr = NODE(cil_class)->cl_head; curr; curr = curr->next) {
> +			struct cil_perm *cil_perm = curr->data;
>  			perm_datum_t *sepol_perm = cil_malloc(sizeof(*sepol_perm));
>  			memset(sepol_perm, 0, sizeof(perm_datum_t));
>  
> -			key = cil_strdup(curr_perm->datum.fqn);
> +			key = cil_strdup(cil_perm->datum.fqn);
>  			rc = hashtab_insert(sepol_class->permissions.table, key, sepol_perm);
>  			if (rc != SEPOL_OK) {
>  				free(sepol_perm);
> @@ -362,7 +372,7 @@ int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_db *db)
>  			}
>  			sepol_perm->s.value = sepol_class->permissions.nprim + 1;
>  			sepol_class->permissions.nprim++;
> -			cil_perm = cil_perm->next;
> +			perm_value_to_cil[class_index][sepol_perm->s.value] = cil_perm;
>  		}
>  	}
>  
> @@ -463,7 +473,7 @@ exit:
>  	return rc;
>  }
>  
> -int cil_type_to_policydb(policydb_t *pdb, struct cil_type *cil_type)
> +int cil_type_to_policydb(policydb_t *pdb, struct cil_type *cil_type, void *type_value_to_cil[])
>  {
>  	int rc = SEPOL_ERR;
>  	uint32_t value = 0;
> @@ -481,6 +491,8 @@ int cil_type_to_policydb(policydb_t *pdb, struct cil_type *cil_type)
>  	sepol_type->s.value = value;
>  	sepol_type->primary = 1;
>  
> +	type_value_to_cil[value] = cil_type;
> +
>  	return SEPOL_OK;
>  
>  exit:
> @@ -564,7 +576,7 @@ exit:
>  
>  }
>  
> -int cil_typeattribute_to_policydb(policydb_t *pdb, struct cil_typeattribute *cil_attr)
> +int cil_typeattribute_to_policydb(policydb_t *pdb, struct cil_typeattribute *cil_attr, void *type_value_to_cil[])
>  {
>  	int rc = SEPOL_ERR;
>  	uint32_t value = 0;
> @@ -588,6 +600,8 @@ int cil_typeattribute_to_policydb(policydb_t *pdb, struct cil_typeattribute *cil
>  	sepol_attr->s.value = value;
>  	sepol_attr->primary = 1;
>  
> +	type_value_to_cil[value] = cil_attr;
> +
>  	return SEPOL_OK;
>  
>  exit:
> @@ -2998,12 +3012,15 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
>  	hashtab_t filename_trans_table;
>  	hashtab_t range_trans_table;
>  	hashtab_t role_trans_table;
> +	void **type_value_to_cil;
> +
>  	db = args->db;
>  	pdb = args->pdb;
>  	pass = args->pass;
>  	filename_trans_table = args->filename_trans_table;
>  	range_trans_table = args->range_trans_table;
>  	role_trans_table = args->role_trans_table;
> +	type_value_to_cil = args->type_value_to_cil;
>  
>  	if (node->flavor >= CIL_MIN_DECLARATIVE) {
>  		if (node != DATUM(node->data)->nodes->head->data) {
> @@ -3018,10 +3035,10 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
>  			rc = cil_role_to_policydb(pdb, node->data);
>  			break;
>  		case CIL_TYPE:
> -			rc = cil_type_to_policydb(pdb, node->data);
> +			rc = cil_type_to_policydb(pdb, node->data, type_value_to_cil);
>  			break;
>  		case CIL_TYPEATTRIBUTE:
> -			rc = cil_typeattribute_to_policydb(pdb, node->data);
> +			rc = cil_typeattribute_to_policydb(pdb, node->data, type_value_to_cil);
>  			break;
>  		case CIL_POLICYCAP:
>  			rc = cil_policycap_to_policydb(pdb, node->data);
> @@ -3483,7 +3500,7 @@ exit:
>  }
>  
>  
> -int __cil_policydb_init(policydb_t *pdb, const struct cil_db *db)
> +int __cil_policydb_init(policydb_t *pdb, const struct cil_db *db, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
>  {
>  	int rc = SEPOL_ERR;
>  
> @@ -3493,7 +3510,7 @@ int __cil_policydb_init(policydb_t *pdb, const struct cil_db *db)
>  	pdb->handle_unknown = db->handle_unknown;
>  	pdb->mls = db->mls;
>  
> -	rc = cil_classorder_to_policydb(pdb, db);
> +	rc = cil_classorder_to_policydb(pdb, db, class_value_to_cil, perm_value_to_cil);
>  	if (rc != SEPOL_OK) {
>  		goto exit;
>  	}
> @@ -3898,6 +3915,9 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
>  	hashtab_t filename_trans_table = NULL;
>  	hashtab_t range_trans_table = NULL;
>  	hashtab_t role_trans_table = NULL;
> +	void **type_value_to_cil = NULL;
> +	struct cil_class **class_value_to_cil = NULL;
> +	struct cil_perm ***perm_value_to_cil = NULL;
>  
>  	if (db == NULL || policydb == NULL) {
>  		if (db == NULL) {
> @@ -3908,7 +3928,23 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
>  		return SEPOL_ERR;
>  	}
>  
> -	rc = __cil_policydb_init(pdb, db);
> +	/* libsepol values start at 1. Just allocate extra memory rather than
> +	 * subtract 1 from the sepol value.
> +	 */
> +	type_value_to_cil = calloc(db->num_types_and_attrs+1, sizeof(*type_value_to_cil));
> +	if (!type_value_to_cil) goto exit;
> +
> +	class_value_to_cil = calloc(db->num_classes+1, sizeof(*class_value_to_cil));
> +	if (!class_value_to_cil) goto exit;
> +
> +	perm_value_to_cil = calloc(db->num_classes+1, sizeof(*perm_value_to_cil));
> +	if (!perm_value_to_cil) goto exit;
> +	for (i=1; i < db->num_classes+1; i++) {
> +		perm_value_to_cil[i] = calloc(PERMS_PER_CLASS+1, sizeof(*perm_value_to_cil[i]));
> +		if (!perm_value_to_cil[i]) goto exit;
> +	}
> +
> +	rc = __cil_policydb_init(pdb, db, class_value_to_cil, perm_value_to_cil);
>  	if (rc != SEPOL_OK) {
>  		cil_log(CIL_ERR,"Problem in policydb_init\n");
>  		goto exit;
> @@ -3940,6 +3976,8 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
>  	extra_args.filename_trans_table = filename_trans_table;
>  	extra_args.range_trans_table = range_trans_table;
>  	extra_args.role_trans_table = role_trans_table;
> +	extra_args.type_value_to_cil = type_value_to_cil;
> +
>  	for (i = 1; i <= 3; i++) {
>  		extra_args.pass = i;
>  
> @@ -3992,6 +4030,13 @@ exit:
>  	hashtab_destroy(filename_trans_table);
>  	hashtab_destroy(range_trans_table);
>  	hashtab_destroy(role_trans_table);
> +	free(type_value_to_cil);
> +	free(class_value_to_cil);
> +	/* Range is because libsepol values start at 1. */
> +	for (i=1; i < db->num_classes+1; i++) {
> +		free(perm_value_to_cil[i]);
> +	}
> +	free(perm_value_to_cil);
>  	cil_list_destroy(&neverallows, CIL_FALSE);
>  
>  	return rc;
> diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.h
> index 72c0f95..33b43f9 100644
> --- a/libsepol/cil/src/cil_binary.h
> +++ b/libsepol/cil/src/cil_binary.h
> @@ -112,7 +112,7 @@ int cil_roletype_to_policydb(policydb_t *pdb, const struct cil_db *db, struct ci
>   *
>   * @return SEPOL_OK upon success or an error otherwise.
>   */
> -int cil_type_to_policydb(policydb_t *pdb, struct cil_type *cil_type);
> +int cil_type_to_policydb(policydb_t *pdb, struct cil_type *cil_type, void *type_value_to_cil[]);
>  
>  /**
>   * Insert cil typealias structure into sepol policydb.
> @@ -144,7 +144,7 @@ int cil_typepermissive_to_policydb(policydb_t *pdb, struct cil_typepermissive *c
>   *
>   * @return SEPOL_OK upon success or an error otherwise.
>   */
> -int cil_typeattribute_to_policydb(policydb_t *pdb, struct cil_typeattribute *cil_attr);
> +int cil_typeattribute_to_policydb(policydb_t *pdb, struct cil_typeattribute *cil_attr, void *type_value_to_cil[]);
>  
>  /**
>   * Insert cil attribute structure into sepol type->attribute bitmap.
> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
> index a43d111..abe52de 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -279,6 +279,8 @@ struct cil_db {
>  	struct cil_list *userprefixes;
>  	struct cil_list *selinuxusers;
>  	struct cil_list *names;
> +	int num_types_and_attrs;
> +	int num_classes;
>  	int num_cats;
>  	int num_types;
>  	int num_roles;
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index f91727f..e69b5a4 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -339,23 +339,37 @@ static int __cil_post_db_count_helper(struct cil_tree_node *node, uint32_t *fini
>  	case CIL_MACRO:
>  		*finished = CIL_TREE_SKIP_HEAD;
>  		break;
> +	case CIL_CLASS: {
> +		struct cil_class *class = node->data;
> +		if (class->datum.nodes->head->data == node) {
> +			// Multiple nodes can point to the same datum. Only count once.
> +			db->num_classes++;
> +		}
> +		break;
> +	}
>  	case CIL_TYPE: {
>  		struct cil_type *type = node->data;
>  		if (type->datum.nodes->head->data == node) {
> -			// multiple AST nodes can point to the same cil_type data (like if
> -			// copied from a macro). This check ensures we only count the
> -			// duplicates once
> +			// Multiple nodes can point to the same datum. Only count once.
>  			type->value = db->num_types;
>  			db->num_types++;
> +			db->num_types_and_attrs++;
>  		}
>  		break;
>  	}
> +	case CIL_TYPEATTRIBUTE: {
> +		struct cil_typeattribute *attr = node->data;
> +		if (attr->datum.nodes->head->data == node) {
> +			// Multiple nodes can point to the same datum. Only count once.
> +			db->num_types_and_attrs++;
> +		}
> +		break;
> +	}
> +
>  	case CIL_ROLE: {
>  		struct cil_role *role = node->data;
>  		if (role->datum.nodes->head->data == node) {
> -			// multiple AST nodes can point to the same cil_role data (like if
> -			// copied from a macro). This check ensures we only count the
> -			// duplicates once
> +			// Multiple nodes can point to the same datum. Only count once.
>  			role->value = db->num_roles;
>  			db->num_roles++;
>  		}
> 
