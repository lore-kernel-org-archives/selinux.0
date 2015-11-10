Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAAG8q4B005457
 for <selinux@tycho.nsa.gov>; Tue, 10 Nov 2015 11:08:58 -0500
Received: by wmec201 with SMTP id c201so141247812wme.0
 for <selinux@tycho.nsa.gov>; Tue, 10 Nov 2015 08:08:46 -0800 (PST)
Date: Tue, 10 Nov 2015 17:08:43 +0100
From: Dominick Grift <dac.override@gmail.com>
To: ykhodorkovskiy@tresys.com
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] secilc: Add support for unordered classes
Message-ID: <20151110160842.GA16008@x250>
References: <1447171100-3581-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
In-Reply-To: <1447171100-3581-1-git-send-email-ykhodorkovskiy@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2015 at 10:58:20AM -0500, ykhodorkovskiy@tresys.com wrote:
> From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
>=20
> Resolves https://github.com/SELinuxProject/cil/issues/3

Nice , thanks. By the way also a late thank you for the user attribute
functionality. I have not yet tested that because i now use RBACSEP
instead of UBAC but it's good to have.



>=20
> An 'unordered' keyword provides the ability to append classes to the curr=
ent
> list of ordered classes. This allows users to not need knowledge of exist=
ing
> classes when creating a class and fixes dependencies on classes when remo=
ving a
> module. This enables userspace object managers with custom objects to be
> modularized.
>=20
> If a class is declared in both an unordered and ordered statement, then t=
he
> ordered statement will supercede the unordered declaration.
>=20
> Example usage:
>=20
>     ; Appends new_class to the existing list of classes
>     (class new_class ())
>     (classorder (unordered new_class))
>=20
> Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
> ---
>  libsepol/cil/src/cil.c                             |  1 +
>  libsepol/cil/src/cil_build_ast.c                   | 52 ++++++++++++
>  libsepol/cil/src/cil_internal.h                    |  1 +
>  libsepol/cil/src/cil_list.c                        | 13 +++
>  libsepol/cil/src/cil_list.h                        |  1 +
>  libsepol/cil/src/cil_resolve_ast.c                 | 98 ++++++++++++++++=
+++---
>  .../docs/cil_class_and_permission_statements.xml   | 16 ++++
>  secilc/test/policy.cil                             | 15 +++-
>  8 files changed, 184 insertions(+), 13 deletions(-)
>=20
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 8716deb..e6e553b 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -230,6 +230,7 @@ static void cil_init_keys(void)
>  	CIL_KEY_DONTAUDITX =3D cil_strpool_add("dontauditx");
>  	CIL_KEY_PERMISSIONX =3D cil_strpool_add("permissionx");
>  	CIL_KEY_IOCTL =3D cil_strpool_add("ioctl");
> +	CIL_KEY_UNORDERED =3D cil_strpool_add("unordered");
>  }
> =20
>  void cil_db_init(struct cil_db **db)
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 861b606..0407d20 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -365,6 +365,11 @@ int cil_gen_class(__attribute__((unused)) struct cil=
_db *db, struct cil_tree_nod
>  	cil_class_init(&class);
> =20
>  	key =3D parse_current->next->data;
> +	if (key =3D=3D CIL_KEY_UNORDERED) {
> +		cil_log(CIL_ERR, "'unordered' keyword is reserved and not a valid clas=
s name.\n");
> +		rc =3D SEPOL_ERR;
> +		goto exit;
> +	}
> =20
>  	rc =3D cil_gen_node(db, ast_node, (struct cil_symtab_datum*)class, (has=
htab_key_t)key, CIL_SYM_CLASSES, CIL_CLASS);
>  	if (rc !=3D SEPOL_OK) {
> @@ -410,6 +415,8 @@ int cil_gen_classorder(__attribute__((unused)) struct=
 cil_db *db, struct cil_tre
>  	};
>  	int syntax_len =3D sizeof(syntax)/sizeof(*syntax);
>  	struct cil_classorder *classorder =3D NULL;
> +	struct cil_list_item *curr =3D NULL;
> +	struct cil_list_item *head =3D NULL;
>  	int rc =3D SEPOL_ERR;
> =20
>  	if (db =3D=3D NULL || parse_current =3D=3D NULL || ast_node =3D=3D NULL=
) {
> @@ -427,6 +434,22 @@ int cil_gen_classorder(__attribute__((unused)) struc=
t cil_db *db, struct cil_tre
>  	if (rc !=3D SEPOL_OK) {
>  		goto exit;
>  	}
> +
> +	head =3D classorder->class_list_str->head;
> +	cil_list_for_each(curr, classorder->class_list_str) {
> +		if (curr->data =3D=3D CIL_KEY_UNORDERED) {
> +			if (curr =3D=3D head && curr->next =3D=3D NULL) {
> +				cil_log(CIL_ERR, "Classorder 'unordered' keyword must be followed by=
 one or more class.\n");
> +				rc =3D SEPOL_ERR;
> +				goto exit;
> +			} else if (curr !=3D head) {
> +				cil_log(CIL_ERR, "Classorder can only use 'unordered' keyword as the=
 first item in the list.\n");
> +				rc =3D SEPOL_ERR;
> +				goto exit;
> +			}
> +		}
> +	}
> +
>  	ast_node->data =3D classorder;
>  	ast_node->flavor =3D CIL_CLASSORDER;
> =20
> @@ -1107,6 +1130,7 @@ int cil_gen_sidorder(__attribute__((unused)) struct=
 cil_db *db, struct cil_tree_
>  	};
>  	int syntax_len =3D sizeof(syntax)/sizeof(*syntax);
>  	struct cil_sidorder *sidorder =3D NULL;
> +	struct cil_list_item *curr =3D NULL;
>  	int rc =3D SEPOL_ERR;
> =20
>  	if (db =3D=3D NULL || parse_current =3D=3D NULL || ast_node =3D=3D NULL=
) {
> @@ -1124,6 +1148,15 @@ int cil_gen_sidorder(__attribute__((unused)) struc=
t cil_db *db, struct cil_tree_
>  	if (rc !=3D SEPOL_OK) {
>  		goto exit;
>  	}
> +
> +	cil_list_for_each(curr, sidorder->sid_list_str) {
> +		if (curr->data =3D=3D CIL_KEY_UNORDERED) {
> +			cil_log(CIL_ERR, "Sidorder cannot be unordered.\n");
> +			rc =3D SEPOL_ERR;
> +			goto exit;
> +		}
> +	}
> +
>  	ast_node->data =3D sidorder;
>  	ast_node->flavor =3D CIL_SIDORDER;
> =20
> @@ -3553,6 +3586,7 @@ int cil_gen_catorder(__attribute__((unused)) struct=
 cil_db *db, struct cil_tree_
>  	};
>  	int syntax_len =3D sizeof(syntax)/sizeof(*syntax);
>  	struct cil_catorder *catorder =3D NULL;
> +	struct cil_list_item *curr =3D NULL;
>  	int rc =3D SEPOL_ERR;
> =20
>  	if (db =3D=3D NULL || parse_current =3D=3D NULL || ast_node =3D=3D NULL=
) {
> @@ -3570,6 +3604,15 @@ int cil_gen_catorder(__attribute__((unused)) struc=
t cil_db *db, struct cil_tree_
>  	if (rc !=3D SEPOL_OK) {
>  		goto exit;
>  	}
> +
> +	cil_list_for_each(curr, catorder->cat_list_str) {
> +		if (curr->data =3D=3D CIL_KEY_UNORDERED) {
> +			cil_log(CIL_ERR, "Category order cannot be unordered.\n");
> +			rc =3D SEPOL_ERR;
> +			goto exit;
> +		}
> +	}
> +
>  	ast_node->data =3D catorder;
>  	ast_node->flavor =3D CIL_CATORDER;
> =20
> @@ -3604,6 +3647,7 @@ int cil_gen_sensitivityorder(__attribute__((unused)=
) struct cil_db *db, struct c
>  	};
>  	int syntax_len =3D sizeof(syntax)/sizeof(*syntax);
>  	struct cil_sensorder *sensorder =3D NULL;
> +	struct cil_list_item *curr =3D NULL;
>  	int rc =3D SEPOL_ERR;
> =20
>  	if (db =3D=3D NULL || parse_current =3D=3D NULL || ast_node =3D=3D NULL=
) {
> @@ -3622,6 +3666,14 @@ int cil_gen_sensitivityorder(__attribute__((unused=
)) struct cil_db *db, struct c
>  		goto exit;
>  	}
> =20
> +	cil_list_for_each(curr, sensorder->sens_list_str) {
> +		if (curr->data =3D=3D CIL_KEY_UNORDERED) {
> +			cil_log(CIL_ERR, "Sensitivy order cannot be unordered.\n");
> +			rc =3D SEPOL_ERR;
> +			goto exit;
> +		}
> +	}
> +
>  	ast_node->data =3D sensorder;
>  	ast_node->flavor =3D CIL_SENSITIVITYORDER;
> =20
> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_inter=
nal.h
> index a736eff..7f718d0 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -223,6 +223,7 @@ char *CIL_KEY_AUDITALLOWX;
>  char *CIL_KEY_DONTAUDITX;
>  char *CIL_KEY_PERMISSIONX;
>  char *CIL_KEY_IOCTL;
> +char *CIL_KEY_UNORDERED;
> =20
>  /*
>  	Symbol Table Array Indices
> diff --git a/libsepol/cil/src/cil_list.c b/libsepol/cil/src/cil_list.c
> index 766985e..dbd554c 100644
> --- a/libsepol/cil/src/cil_list.c
> +++ b/libsepol/cil/src/cil_list.c
> @@ -246,3 +246,16 @@ void cil_list_remove(struct cil_list *list, enum cil=
_flavor flavor, void *data,
>  		previous =3D item;
>  	}
>  }
> +
> +int cil_list_contains(struct cil_list *list, void *data)
> +{
> +	struct cil_list_item *curr =3D NULL;
> +
> +	cil_list_for_each(curr, list) {
> +		if (curr->data =3D=3D data) {
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
> @@ -58,5 +58,6 @@ void cil_list_remove(struct cil_list *list, enum cil_fl=
avor flavor, void *data,
>  struct cil_list_item *cil_list_insert(struct cil_list *list, struct cil_=
list_item *curr, enum cil_flavor flavor, void *data);
>  void cil_list_append_item(struct cil_list *list, struct cil_list_item *i=
tem);
>  void cil_list_prepend_item(struct cil_list *list, struct cil_list_item *=
item);
> +int cil_list_contains(struct cil_list *list, void *data);
> =20
>  #endif
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index 0df5c63..deb3d38 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -59,6 +59,7 @@ struct cil_args_resolve {
>  	struct cil_tree_node *blockstack;
>  	struct cil_list *sidorder_lists;
>  	struct cil_list *classorder_lists;
> +	struct cil_list *unordered_classorder_lists;
>  	struct cil_list *catorder_lists;
>  	struct cil_list *sensitivityorder_lists;
>  	struct cil_list *in_list;
> @@ -1176,7 +1177,7 @@ void __cil_ordered_lists_destroy(struct cil_list **=
ordered_lists)
>  {
>  	struct cil_list_item *item =3D NULL;
> =20
> -	if (*ordered_lists =3D=3D NULL) {
> +	if (ordered_lists =3D=3D NULL || *ordered_lists =3D=3D NULL) {
>  		return;
>  	}
> =20
> @@ -1351,7 +1352,42 @@ int __cil_ordered_lists_merge(struct cil_list *old=
, struct cil_list *new)
>  	return SEPOL_OK;
>  }
> =20
> -struct cil_list *__cil_ordered_lists_merge_all(struct cil_list **ordered=
_lists)
> +static int insert_unordered(struct cil_list *merged, struct cil_list *un=
ordered)
> +{
> +	struct cil_list_item *curr =3D NULL;
> +	struct cil_ordered_list *unordered_list =3D NULL;
> +	struct cil_list_item *item =3D NULL;
> +	struct cil_list_item *ret =3D NULL;
> +	int rc =3D SEPOL_ERR;
> +
> +	cil_list_for_each(curr, unordered) {
> +		unordered_list =3D curr->data;
> +
> +		cil_list_for_each(item, unordered_list->list) {
> +			if (cil_list_contains(merged, item->data)) {
> +				/* item was declared in an ordered statement, which supercedes
> +				 * all unordered statements */
> +				if (item->flavor =3D=3D CIL_CLASS) {
> +					cil_log(CIL_WARN, "Ignoring '%s' as it has already been declared in=
 classorder.\n", ((struct cil_class*)(item->data))->datum.name);
> +				}
> +				continue;
> +			}
> +
> +			ret =3D __cil_ordered_item_insert(merged, merged->tail, item);
> +			if (ret =3D=3D NULL) {
> +				rc =3D SEPOL_ERR;
> +				goto exit;
> +			}
> +		}
> +	}
> +
> +	rc =3D SEPOL_OK;
> +
> +exit:
> +	return rc;
> +}
> +
> +struct cil_list *__cil_ordered_lists_merge_all(struct cil_list **ordered=
_lists, struct cil_list **unordered_lists)
>  {
>  	struct cil_list *composite =3D NULL;
>  	struct cil_list_item *curr =3D NULL;
> @@ -1388,11 +1424,21 @@ struct cil_list *__cil_ordered_lists_merge_all(st=
ruct cil_list **ordered_lists)
>  		}
>  	}
> =20
> +	if (unordered_lists !=3D NULL) {
> +		rc =3D insert_unordered(composite, *unordered_lists);
> +		if (rc !=3D SEPOL_OK) {
> +			goto exit;
> +		}
> +	}
> +
>  	__cil_ordered_lists_destroy(ordered_lists);
> +	__cil_ordered_lists_destroy(unordered_lists);
> =20
>  	return composite;
> =20
>  exit:
> +	__cil_ordered_lists_destroy(ordered_lists);
> +	__cil_ordered_lists_destroy(unordered_lists);
>  	cil_list_destroy(&composite, CIL_FALSE);
>  	return NULL;
>  }
> @@ -1401,16 +1447,23 @@ int cil_resolve_classorder(struct cil_tree_node *=
current, void *extra_args)
>  {
>  	struct cil_args_resolve *args =3D extra_args;
>  	struct cil_list *classorder_list =3D args->classorder_lists;
> +	struct cil_list *unordered_classorder_list =3D args->unordered_classord=
er_lists;
>  	struct cil_classorder *classorder =3D current->data;
>  	struct cil_list *new =3D NULL;
>  	struct cil_list_item *curr =3D NULL;
>  	struct cil_symtab_datum *datum =3D NULL;
> -	struct cil_ordered_list *ordered =3D NULL;
> +	struct cil_ordered_list *class_list =3D NULL;
>  	int rc =3D SEPOL_ERR;
> +	int unordered =3D CIL_FALSE;
> =20
>  	cil_list_init(&new, CIL_CLASSORDER);
> =20
>  	cil_list_for_each(curr, classorder->class_list_str) {
> +		if (curr->data =3D=3D CIL_KEY_UNORDERED) {
> +			unordered =3D CIL_TRUE;
> +			continue;
> +		}
> +
>  		rc =3D cil_resolve_name(current, (char *)curr->data, CIL_SYM_CLASSES, =
extra_args, &datum);
>  		if (rc !=3D SEPOL_OK) {
>  			cil_log(CIL_ERR, "Failed to resolve class %s in classorder\n", (char =
*)curr->data);
> @@ -1419,10 +1472,14 @@ int cil_resolve_classorder(struct cil_tree_node *=
current, void *extra_args)
>  		cil_list_append(new, CIL_CLASS, datum);
>  	}
> =20
> -	__cil_ordered_list_init(&ordered);
> -	ordered->list =3D new;
> -	ordered->node =3D current;
> -	cil_list_append(classorder_list, CIL_CLASSORDER, ordered);
> +	__cil_ordered_list_init(&class_list);
> +	class_list->list =3D new;
> +	class_list->node =3D current;
> +	if (unordered) {
> +		cil_list_append(unordered_classorder_list, CIL_CLASSORDER, class_list);
> +	} else {
> +		cil_list_append(classorder_list, CIL_CLASSORDER, class_list);
> +	}
> =20
>  	return SEPOL_OK;
> =20
> @@ -3651,6 +3708,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_t=
ree_node *current)
>  	extra_args.macro =3D NULL;
>  	extra_args.sidorder_lists =3D NULL;
>  	extra_args.classorder_lists =3D NULL;
> +	extra_args.unordered_classorder_lists =3D NULL;
>  	extra_args.catorder_lists =3D NULL;
>  	extra_args.sensitivityorder_lists =3D NULL;
>  	extra_args.in_list =3D NULL;
> @@ -3658,6 +3716,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_t=
ree_node *current)
> =20
>  	cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
>  	cil_list_init(&extra_args.classorder_lists, CIL_LIST_ITEM);
> +	cil_list_init(&extra_args.unordered_classorder_lists, CIL_LIST_ITEM);
>  	cil_list_init(&extra_args.catorder_lists, CIL_LIST_ITEM);
>  	cil_list_init(&extra_args.sensitivityorder_lists, CIL_LIST_ITEM);
>  	cil_list_init(&extra_args.in_list, CIL_IN);
> @@ -3678,11 +3737,27 @@ int cil_resolve_ast(struct cil_db *db, struct cil=
_tree_node *current)
>  		}
> =20
>  		if (pass =3D=3D CIL_PASS_MISC1) {
> -			db->sidorder =3D __cil_ordered_lists_merge_all(&extra_args.sidorder_l=
ists);
> -			db->classorder =3D __cil_ordered_lists_merge_all(&extra_args.classord=
er_lists);
> -			db->catorder =3D __cil_ordered_lists_merge_all(&extra_args.catorder_l=
ists);
> +			db->sidorder =3D __cil_ordered_lists_merge_all(&extra_args.sidorder_l=
ists, NULL);
> +			if (db->sidorder =3D=3D NULL) {
> +				rc =3D SEPOL_ERR;
> +				goto exit;
> +			}
> +			db->classorder =3D __cil_ordered_lists_merge_all(&extra_args.classord=
er_lists, &extra_args.unordered_classorder_lists);
> +			if (db->classorder =3D=3D NULL) {
> +				rc =3D SEPOL_ERR;
> +				goto exit;
> +			}
> +			db->catorder =3D __cil_ordered_lists_merge_all(&extra_args.catorder_l=
ists, NULL);
> +			if (db->catorder =3D=3D NULL) {
> +				rc =3D SEPOL_ERR;
> +				goto exit;
> +			}
>  			cil_set_cat_values(db->catorder, db);
> -			db->sensitivityorder =3D __cil_ordered_lists_merge_all(&extra_args.se=
nsitivityorder_lists);
> +			db->sensitivityorder =3D __cil_ordered_lists_merge_all(&extra_args.se=
nsitivityorder_lists, NULL);
> +			if (db->sensitivityorder =3D=3D NULL) {
> +				rc =3D SEPOL_ERR;
> +				goto exit;
> +			}
> =20
>  			rc =3D __cil_verify_ordered(current, CIL_SID);
>  			if (rc !=3D SEPOL_OK) {
> @@ -3718,6 +3793,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_t=
ree_node *current)
>  			if (pass >=3D CIL_PASS_MISC1) {
>  				__cil_ordered_lists_reset(&extra_args.sidorder_lists);
>  				__cil_ordered_lists_reset(&extra_args.classorder_lists);
> +				__cil_ordered_lists_reset(&extra_args.unordered_classorder_lists);
>  				__cil_ordered_lists_reset(&extra_args.catorder_lists);
>  				__cil_ordered_lists_reset(&extra_args.sensitivityorder_lists);
>  				cil_list_destroy(&db->sidorder, CIL_FALSE);
> diff --git a/secilc/docs/cil_class_and_permission_statements.xml b/secilc=
/docs/cil_class_and_permission_statements.xml
> index 2926d7c..20c3eb7 100644
> --- a/secilc/docs/cil_class_and_permission_statements.xml
> +++ b/secilc/docs/cil_class_and_permission_statements.xml
> @@ -198,6 +198,22 @@
>  (classorder (file dir))
>  (classorder (dir process))]]>
>        </programlisting>
> +         <para><emphasis role=3D"bold">Unordered Classorder Statement:</=
emphasis></para>
> +         <para>If users do not have knowledge of the existing classorder=
, the <literal>unordered</literal> keyword may be used in a <literal>classo=
rder</literal> statement. The <link linkend=3D"class">class</link>es in an =
unordered statement are appended to the existing classorder. A class in an =
ordered statement always supercedes the class redeclaration in an unordered=
 statement. The <literal>unordered</literal> keyword must be the first item=
 in the classorder listing.</para>
> +         <para><emphasis role=3D"bold">Example:</emphasis></para>
> +         <para>This will produce an ordered list of "<literal>file dir f=
oo a bar baz</literal>"</para>
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
>        </sect2>
>       <sect2 id=3D"classpermission">
>           <title>classpermission</title>
> diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
> index 69103d1..884d2dc 100644
> --- a/secilc/test/policy.cil
> +++ b/secilc/test/policy.cil
> @@ -46,8 +46,13 @@
>  (levelrange lh4 ((s0) (s1)))
> =20
>  (block policy
> -	(classorder (file char dir))
> -	(class file (execute_no_trans entrypoint execmod open audit_access))
> +	(class file (execute_no_trans entrypoint execmod open audit_access a b =
c d e))
> +	; order should be: file char b c a dir d e f
> +	(classorder (file char))
> +	(classorder (unordered dir))
> +	(classorder (unordered c a b d e f))
> +	(classorder (char b c a))
> +
>  	(common file (ioctl read write create getattr setattr lock relabelfrom
>  			relabelto append unlink link rename execute swapon
>  			quotaon mounton))
> @@ -67,6 +72,12 @@
>  	(classcommon char file)
> =20
>  	(class dir ())
> +	(class a ())
> +	(class b ())
> +	(class c ())
> +	(class d ())
> +	(class e ())
> +	(class f ())
>  	(classcommon dir file)
> =20
>  	(classpermission char_w)
> --=20
> 2.4.3
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x314883A202DFF788
Dominick Grift

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWQhaBAAoJENAR6kfG5xmcjBQL/Ryt8YiM1HH2qW74JNLfzwIf
aNF9lbuEJ2dKepB7i2T2MdVXIHTB9oYo/AnPZlUrlsWY1FvA/SDaiV2hGOYYyJ0N
KXHWpuzwiSZLaSOro60AVgJn4nRFVv8bwYJ2Vk3XMrzDx1Nx9mXVIMzUtQY1P7hL
LMcmEhzmFzuRt5AbCvhFucs2j8VoVr7VoAAoWjBDdlJ1x++ysP1IZaF/wziaLoQN
KA6AATA0WrZOTmquJ8wxPGokdoBjTr8ND2UTZC9dUE2Rh2lPIbdRNdCmSua0qlWJ
InRhFIOuWYPccmIvcAzwFr+Y6+AE4gIS2phqcH5qNeXekBxcrAajBeucs8gMxtu0
IjRmwfsCpmRk3hofNIAAuHcy838Z+xAE9Lv+uGkVloueISG1AyvWNy95abqkNnKS
huVpohtbbtFOvlQoUz7ZAqIUCm8ohl0Wo9vj7Af5TT+ek2z2OE6yu3A9WSN/aGzr
566XF08cwopvmTcCWzOfSbm+h/2buFYvGB6VssbiBA==
=KPsH
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
