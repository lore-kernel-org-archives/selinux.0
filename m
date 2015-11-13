Subject: Re: [PATCH] secilc: Add support for unordered classes
To: ykhodorkovskiy@tresys.com, selinux@tycho.nsa.gov
References: <1447171100-3581-1-git-send-email-ykhodorkovskiy@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <5645FF4A.9040808@tycho.nsa.gov>
Date: Fri, 13 Nov 2015 10:18:34 -0500
MIME-Version: 1.0
In-Reply-To: <1447171100-3581-1-git-send-email-ykhodorkovskiy@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/10/2015 10:58 AM, ykhodorkovskiy@tresys.com wrote:
> From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
>
> Resolves https://github.com/SELinuxProject/cil/issues/3
>
> An 'unordered' keyword provides the ability to append classes to the current
> list of ordered classes. This allows users to not need knowledge of existing
> classes when creating a class and fixes dependencies on classes when removing a
> module. This enables userspace object managers with custom objects to be
> modularized.
>
> If a class is declared in both an unordered and ordered statement, then the
> ordered statement will supercede the unordered declaration.
>
> Example usage:
>
>      ; Appends new_class to the existing list of classes
>      (class new_class ())
>      (classorder (unordered new_class))
>
> Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>

Applied.

Thanks,
Jim

> ---
>   libsepol/cil/src/cil.c                             |  1 +
>   libsepol/cil/src/cil_build_ast.c                   | 52 ++++++++++++
>   libsepol/cil/src/cil_internal.h                    |  1 +
>   libsepol/cil/src/cil_list.c                        | 13 +++
>   libsepol/cil/src/cil_list.h                        |  1 +
>   libsepol/cil/src/cil_resolve_ast.c                 | 98 +++++++++++++++++++---
>   .../docs/cil_class_and_permission_statements.xml   | 16 ++++
>   secilc/test/policy.cil                             | 15 +++-
>   8 files changed, 184 insertions(+), 13 deletions(-)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 8716deb..e6e553b 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -230,6 +230,7 @@ static void cil_init_keys(void)
>   	CIL_KEY_DONTAUDITX = cil_strpool_add("dontauditx");
>   	CIL_KEY_PERMISSIONX = cil_strpool_add("permissionx");
>   	CIL_KEY_IOCTL = cil_strpool_add("ioctl");
> +	CIL_KEY_UNORDERED = cil_strpool_add("unordered");
>   }
>
>   void cil_db_init(struct cil_db **db)
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 861b606..0407d20 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -365,6 +365,11 @@ int cil_gen_class(__attribute__((unused)) struct cil_db *db, struct cil_tree_nod
>   	cil_class_init(&class);
>
>   	key = parse_current->next->data;
> +	if (key == CIL_KEY_UNORDERED) {
> +		cil_log(CIL_ERR, "'unordered' keyword is reserved and not a valid class name.\n");
> +		rc = SEPOL_ERR;
> +		goto exit;
> +	}
>
>   	rc = cil_gen_node(db, ast_node, (struct cil_symtab_datum*)class, (hashtab_key_t)key, CIL_SYM_CLASSES, CIL_CLASS);
>   	if (rc != SEPOL_OK) {
> @@ -410,6 +415,8 @@ int cil_gen_classorder(__attribute__((unused)) struct cil_db *db, struct cil_tre
>   	};
>   	int syntax_len = sizeof(syntax)/sizeof(*syntax);
>   	struct cil_classorder *classorder = NULL;
> +	struct cil_list_item *curr = NULL;
> +	struct cil_list_item *head = NULL;
>   	int rc = SEPOL_ERR;
>
>   	if (db == NULL || parse_current == NULL || ast_node == NULL) {
> @@ -427,6 +434,22 @@ int cil_gen_classorder(__attribute__((unused)) struct cil_db *db, struct cil_tre
>   	if (rc != SEPOL_OK) {
>   		goto exit;
>   	}
> +
> +	head = classorder->class_list_str->head;
> +	cil_list_for_each(curr, classorder->class_list_str) {
> +		if (curr->data == CIL_KEY_UNORDERED) {
> +			if (curr == head && curr->next == NULL) {
> +				cil_log(CIL_ERR, "Classorder 'unordered' keyword must be followed by one or more class.\n");
> +				rc = SEPOL_ERR;
> +				goto exit;
> +			} else if (curr != head) {
> +				cil_log(CIL_ERR, "Classorder can only use 'unordered' keyword as the first item in the list.\n");
> +				rc = SEPOL_ERR;
> +				goto exit;
> +			}
> +		}
> +	}
> +
>   	ast_node->data = classorder;
>   	ast_node->flavor = CIL_CLASSORDER;
>
> @@ -1107,6 +1130,7 @@ int cil_gen_sidorder(__attribute__((unused)) struct cil_db *db, struct cil_tree_
>   	};
>   	int syntax_len = sizeof(syntax)/sizeof(*syntax);
>   	struct cil_sidorder *sidorder = NULL;
> +	struct cil_list_item *curr = NULL;
>   	int rc = SEPOL_ERR;
>
>   	if (db == NULL || parse_current == NULL || ast_node == NULL) {
> @@ -1124,6 +1148,15 @@ int cil_gen_sidorder(__attribute__((unused)) struct cil_db *db, struct cil_tree_
>   	if (rc != SEPOL_OK) {
>   		goto exit;
>   	}
> +
> +	cil_list_for_each(curr, sidorder->sid_list_str) {
> +		if (curr->data == CIL_KEY_UNORDERED) {
> +			cil_log(CIL_ERR, "Sidorder cannot be unordered.\n");
> +			rc = SEPOL_ERR;
> +			goto exit;
> +		}
> +	}
> +
>   	ast_node->data = sidorder;
>   	ast_node->flavor = CIL_SIDORDER;
>
> @@ -3553,6 +3586,7 @@ int cil_gen_catorder(__attribute__((unused)) struct cil_db *db, struct cil_tree_
>   	};
>   	int syntax_len = sizeof(syntax)/sizeof(*syntax);
>   	struct cil_catorder *catorder = NULL;
> +	struct cil_list_item *curr = NULL;
>   	int rc = SEPOL_ERR;
>
>   	if (db == NULL || parse_current == NULL || ast_node == NULL) {
> @@ -3570,6 +3604,15 @@ int cil_gen_catorder(__attribute__((unused)) struct cil_db *db, struct cil_tree_
>   	if (rc != SEPOL_OK) {
>   		goto exit;
>   	}
> +
> +	cil_list_for_each(curr, catorder->cat_list_str) {
> +		if (curr->data == CIL_KEY_UNORDERED) {
> +			cil_log(CIL_ERR, "Category order cannot be unordered.\n");
> +			rc = SEPOL_ERR;
> +			goto exit;
> +		}
> +	}
> +
>   	ast_node->data = catorder;
>   	ast_node->flavor = CIL_CATORDER;
>
> @@ -3604,6 +3647,7 @@ int cil_gen_sensitivityorder(__attribute__((unused)) struct cil_db *db, struct c
>   	};
>   	int syntax_len = sizeof(syntax)/sizeof(*syntax);
>   	struct cil_sensorder *sensorder = NULL;
> +	struct cil_list_item *curr = NULL;
>   	int rc = SEPOL_ERR;
>
>   	if (db == NULL || parse_current == NULL || ast_node == NULL) {
> @@ -3622,6 +3666,14 @@ int cil_gen_sensitivityorder(__attribute__((unused)) struct cil_db *db, struct c
>   		goto exit;
>   	}
>
> +	cil_list_for_each(curr, sensorder->sens_list_str) {
> +		if (curr->data == CIL_KEY_UNORDERED) {
> +			cil_log(CIL_ERR, "Sensitivy order cannot be unordered.\n");
> +			rc = SEPOL_ERR;
> +			goto exit;
> +		}
> +	}
> +
>   	ast_node->data = sensorder;
>   	ast_node->flavor = CIL_SENSITIVITYORDER;
>
> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
> index a736eff..7f718d0 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -223,6 +223,7 @@ char *CIL_KEY_AUDITALLOWX;
>   char *CIL_KEY_DONTAUDITX;
>   char *CIL_KEY_PERMISSIONX;
>   char *CIL_KEY_IOCTL;
> +char *CIL_KEY_UNORDERED;
>
>   /*
>   	Symbol Table Array Indices
> diff --git a/libsepol/cil/src/cil_list.c b/libsepol/cil/src/cil_list.c
> index 766985e..dbd554c 100644
> --- a/libsepol/cil/src/cil_list.c
> +++ b/libsepol/cil/src/cil_list.c
> @@ -246,3 +246,16 @@ void cil_list_remove(struct cil_list *list, enum cil_flavor flavor, void *data,
>   		previous = item;
>   	}
>   }
> +
> +int cil_list_contains(struct cil_list *list, void *data)
> +{
> +	struct cil_list_item *curr = NULL;
> +
> +	cil_list_for_each(curr, list) {
> +		if (curr->data == data) {
> +			return CIL_TRUE;
> +		}
> +	}
> +
> +	return CIL_FALSE;
> +}
> diff --git a/libsepol/cil/src/cil_list.h b/libsepol/cil/src/cil_list.h
> index 16d743c..a028036 100644
> --- a/libsepol/cil/src/cil_list.h
> +++ b/libsepol/cil/src/cil_list.h
> @@ -58,5 +58,6 @@ void cil_list_remove(struct cil_list *list, enum cil_flavor flavor, void *data,
>   struct cil_list_item *cil_list_insert(struct cil_list *list, struct cil_list_item *curr, enum cil_flavor flavor, void *data);
>   void cil_list_append_item(struct cil_list *list, struct cil_list_item *item);
>   void cil_list_prepend_item(struct cil_list *list, struct cil_list_item *item);
> +int cil_list_contains(struct cil_list *list, void *data);
>
>   #endif
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 0df5c63..deb3d38 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -59,6 +59,7 @@ struct cil_args_resolve {
>   	struct cil_tree_node *blockstack;
>   	struct cil_list *sidorder_lists;
>   	struct cil_list *classorder_lists;
> +	struct cil_list *unordered_classorder_lists;
>   	struct cil_list *catorder_lists;
>   	struct cil_list *sensitivityorder_lists;
>   	struct cil_list *in_list;
> @@ -1176,7 +1177,7 @@ void __cil_ordered_lists_destroy(struct cil_list **ordered_lists)
>   {
>   	struct cil_list_item *item = NULL;
>
> -	if (*ordered_lists == NULL) {
> +	if (ordered_lists == NULL || *ordered_lists == NULL) {
>   		return;
>   	}
>
> @@ -1351,7 +1352,42 @@ int __cil_ordered_lists_merge(struct cil_list *old, struct cil_list *new)
>   	return SEPOL_OK;
>   }
>
> -struct cil_list *__cil_ordered_lists_merge_all(struct cil_list **ordered_lists)
> +static int insert_unordered(struct cil_list *merged, struct cil_list *unordered)
> +{
> +	struct cil_list_item *curr = NULL;
> +	struct cil_ordered_list *unordered_list = NULL;
> +	struct cil_list_item *item = NULL;
> +	struct cil_list_item *ret = NULL;
> +	int rc = SEPOL_ERR;
> +
> +	cil_list_for_each(curr, unordered) {
> +		unordered_list = curr->data;
> +
> +		cil_list_for_each(item, unordered_list->list) {
> +			if (cil_list_contains(merged, item->data)) {
> +				/* item was declared in an ordered statement, which supercedes
> +				 * all unordered statements */
> +				if (item->flavor == CIL_CLASS) {
> +					cil_log(CIL_WARN, "Ignoring '%s' as it has already been declared in classorder.\n", ((struct cil_class*)(item->data))->datum.name);
> +				}
> +				continue;
> +			}
> +
> +			ret = __cil_ordered_item_insert(merged, merged->tail, item);
> +			if (ret == NULL) {
> +				rc = SEPOL_ERR;
> +				goto exit;
> +			}
> +		}
> +	}
> +
> +	rc = SEPOL_OK;
> +
> +exit:
> +	return rc;
> +}
> +
> +struct cil_list *__cil_ordered_lists_merge_all(struct cil_list **ordered_lists, struct cil_list **unordered_lists)
>   {
>   	struct cil_list *composite = NULL;
>   	struct cil_list_item *curr = NULL;
> @@ -1388,11 +1424,21 @@ struct cil_list *__cil_ordered_lists_merge_all(struct cil_list **ordered_lists)
>   		}
>   	}
>
> +	if (unordered_lists != NULL) {
> +		rc = insert_unordered(composite, *unordered_lists);
> +		if (rc != SEPOL_OK) {
> +			goto exit;
> +		}
> +	}
> +
>   	__cil_ordered_lists_destroy(ordered_lists);
> +	__cil_ordered_lists_destroy(unordered_lists);
>
>   	return composite;
>
>   exit:
> +	__cil_ordered_lists_destroy(ordered_lists);
> +	__cil_ordered_lists_destroy(unordered_lists);
>   	cil_list_destroy(&composite, CIL_FALSE);
>   	return NULL;
>   }
> @@ -1401,16 +1447,23 @@ int cil_resolve_classorder(struct cil_tree_node *current, void *extra_args)
>   {
>   	struct cil_args_resolve *args = extra_args;
>   	struct cil_list *classorder_list = args->classorder_lists;
> +	struct cil_list *unordered_classorder_list = args->unordered_classorder_lists;
>   	struct cil_classorder *classorder = current->data;
>   	struct cil_list *new = NULL;
>   	struct cil_list_item *curr = NULL;
>   	struct cil_symtab_datum *datum = NULL;
> -	struct cil_ordered_list *ordered = NULL;
> +	struct cil_ordered_list *class_list = NULL;
>   	int rc = SEPOL_ERR;
> +	int unordered = CIL_FALSE;
>
>   	cil_list_init(&new, CIL_CLASSORDER);
>
>   	cil_list_for_each(curr, classorder->class_list_str) {
> +		if (curr->data == CIL_KEY_UNORDERED) {
> +			unordered = CIL_TRUE;
> +			continue;
> +		}
> +
>   		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_CLASSES, extra_args, &datum);
>   		if (rc != SEPOL_OK) {
>   			cil_log(CIL_ERR, "Failed to resolve class %s in classorder\n", (char *)curr->data);
> @@ -1419,10 +1472,14 @@ int cil_resolve_classorder(struct cil_tree_node *current, void *extra_args)
>   		cil_list_append(new, CIL_CLASS, datum);
>   	}
>
> -	__cil_ordered_list_init(&ordered);
> -	ordered->list = new;
> -	ordered->node = current;
> -	cil_list_append(classorder_list, CIL_CLASSORDER, ordered);
> +	__cil_ordered_list_init(&class_list);
> +	class_list->list = new;
> +	class_list->node = current;
> +	if (unordered) {
> +		cil_list_append(unordered_classorder_list, CIL_CLASSORDER, class_list);
> +	} else {
> +		cil_list_append(classorder_list, CIL_CLASSORDER, class_list);
> +	}
>
>   	return SEPOL_OK;
>
> @@ -3651,6 +3708,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>   	extra_args.macro = NULL;
>   	extra_args.sidorder_lists = NULL;
>   	extra_args.classorder_lists = NULL;
> +	extra_args.unordered_classorder_lists = NULL;
>   	extra_args.catorder_lists = NULL;
>   	extra_args.sensitivityorder_lists = NULL;
>   	extra_args.in_list = NULL;
> @@ -3658,6 +3716,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>
>   	cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
>   	cil_list_init(&extra_args.classorder_lists, CIL_LIST_ITEM);
> +	cil_list_init(&extra_args.unordered_classorder_lists, CIL_LIST_ITEM);
>   	cil_list_init(&extra_args.catorder_lists, CIL_LIST_ITEM);
>   	cil_list_init(&extra_args.sensitivityorder_lists, CIL_LIST_ITEM);
>   	cil_list_init(&extra_args.in_list, CIL_IN);
> @@ -3678,11 +3737,27 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>   		}
>
>   		if (pass == CIL_PASS_MISC1) {
> -			db->sidorder = __cil_ordered_lists_merge_all(&extra_args.sidorder_lists);
> -			db->classorder = __cil_ordered_lists_merge_all(&extra_args.classorder_lists);
> -			db->catorder = __cil_ordered_lists_merge_all(&extra_args.catorder_lists);
> +			db->sidorder = __cil_ordered_lists_merge_all(&extra_args.sidorder_lists, NULL);
> +			if (db->sidorder == NULL) {
> +				rc = SEPOL_ERR;
> +				goto exit;
> +			}
> +			db->classorder = __cil_ordered_lists_merge_all(&extra_args.classorder_lists, &extra_args.unordered_classorder_lists);
> +			if (db->classorder == NULL) {
> +				rc = SEPOL_ERR;
> +				goto exit;
> +			}
> +			db->catorder = __cil_ordered_lists_merge_all(&extra_args.catorder_lists, NULL);
> +			if (db->catorder == NULL) {
> +				rc = SEPOL_ERR;
> +				goto exit;
> +			}
>   			cil_set_cat_values(db->catorder, db);
> -			db->sensitivityorder = __cil_ordered_lists_merge_all(&extra_args.sensitivityorder_lists);
> +			db->sensitivityorder = __cil_ordered_lists_merge_all(&extra_args.sensitivityorder_lists, NULL);
> +			if (db->sensitivityorder == NULL) {
> +				rc = SEPOL_ERR;
> +				goto exit;
> +			}
>
>   			rc = __cil_verify_ordered(current, CIL_SID);
>   			if (rc != SEPOL_OK) {
> @@ -3718,6 +3793,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>   			if (pass >= CIL_PASS_MISC1) {
>   				__cil_ordered_lists_reset(&extra_args.sidorder_lists);
>   				__cil_ordered_lists_reset(&extra_args.classorder_lists);
> +				__cil_ordered_lists_reset(&extra_args.unordered_classorder_lists);
>   				__cil_ordered_lists_reset(&extra_args.catorder_lists);
>   				__cil_ordered_lists_reset(&extra_args.sensitivityorder_lists);
>   				cil_list_destroy(&db->sidorder, CIL_FALSE);
> diff --git a/secilc/docs/cil_class_and_permission_statements.xml b/secilc/docs/cil_class_and_permission_statements.xml
> index 2926d7c..20c3eb7 100644
> --- a/secilc/docs/cil_class_and_permission_statements.xml
> +++ b/secilc/docs/cil_class_and_permission_statements.xml
> @@ -198,6 +198,22 @@
>   (classorder (file dir))
>   (classorder (dir process))]]>
>         </programlisting>
> +         <para><emphasis role="bold">Unordered Classorder Statement:</emphasis></para>
> +         <para>If users do not have knowledge of the existing classorder, the <literal>unordered</literal> keyword may be used in a <literal>classorder</literal> statement. The <link linkend="class">class</link>es in an unordered statement are appended to the existing classorder. A class in an ordered statement always supercedes the class redeclaration in an unordered statement. The <literal>unordered</literal> keyword must be the first item in the classorder listing.</para>
> +         <para><emphasis role="bold">Example:</emphasis></para>
> +         <para>This will produce an ordered list of "<literal>file dir foo a bar baz</literal>"</para>
> +         <programlisting><![CDATA[
> +(class file)
> +(class dir)
> +(class foo)
> +(class bar)
> +(class baz)
> +(class a)
> +(classorder (file dir))
> +(classorder (dir foo))
> +(classorder (unordered a))
> +(classorder (unordered bar foo baz))]]>
> +      </programlisting>
>         </sect2>
>        <sect2 id="classpermission">
>            <title>classpermission</title>
> diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
> index 69103d1..884d2dc 100644
> --- a/secilc/test/policy.cil
> +++ b/secilc/test/policy.cil
> @@ -46,8 +46,13 @@
>   (levelrange lh4 ((s0) (s1)))
>
>   (block policy
> -	(classorder (file char dir))
> -	(class file (execute_no_trans entrypoint execmod open audit_access))
> +	(class file (execute_no_trans entrypoint execmod open audit_access a b c d e))
> +	; order should be: file char b c a dir d e f
> +	(classorder (file char))
> +	(classorder (unordered dir))
> +	(classorder (unordered c a b d e f))
> +	(classorder (char b c a))
> +
>   	(common file (ioctl read write create getattr setattr lock relabelfrom
>   			relabelto append unlink link rename execute swapon
>   			quotaon mounton))
> @@ -67,6 +72,12 @@
>   	(classcommon char file)
>
>   	(class dir ())
> +	(class a ())
> +	(class b ())
> +	(class c ())
> +	(class d ())
> +	(class e ())
> +	(class f ())
>   	(classcommon dir file)
>
>   	(classpermission char_w)
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
