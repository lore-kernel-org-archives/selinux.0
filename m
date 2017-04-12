Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3CHRt4V011770
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 13:27:56 -0400
Received: by mail-io0-f172.google.com with SMTP id r16so48224592ioi.2
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 10:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1491933223-18277-2-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1491933223-18277-2-git-send-email-jwcart2@tycho.nsa.gov>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Wed, 12 Apr 2017 17:27:38 +0000
Message-ID: <CABXk95BpE=McjjPOiiaXKLcuZz8KD1Xnrp0iBS8JGGz=ydnG1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/cil: Add ability to expand some attributes
 in binary policy
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11c1662a0aaad2054cfb8715
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c1662a0aaad2054cfb8715
Content-Type: text/plain; charset=UTF-8

Just a couple of missing space nits.

Can we get this merged today? I'd like to start using the
--expand-generated feature.

On Tue, Apr 11, 2017 at 10:53 AM James Carter <jwcart2@tycho.nsa.gov> wrote:

> Originally, all type attributes were expanded when building a binary
> policy. As the policy grew, binary policy sizes became too large, so
> changes were made to keep attributes in the binary policy to minimize
> policy size.
>
> Keeping attributes works well as long as each type does not have too
> many attributes. If an access check fails for types t1 and t2, then
> additional checks must be made for every attribute that t1 is a member
> of against t2 and all the attributes that t2 is a member of. This is
> O(n*m) behavior and there are cases now where this is becoming a
> performance issue.
>
> Attributes are more aggressively removed than before. An attribute
> will now be removed if it only appears in rules where attributes are
> always expanded (typetransition, typechange, typemember, roletransition,
> rangetransition, roletype, and AV Rules with self).
>
> Attributes that are used in constraints are always kept because the
> attribute name is stored for debugging purposes in the binary policy.
>
> Attributes that are used in neverallow rules, but not in other AV rules,
> will be kept unless the attribute is auto-generated.
>
> Attributes that are only used in AV rules other than neverallow rules
> are kept unless the number of types assigned to them is less than the
> value of attrs_expand_size in the CIL db. The default is 1, which means
> that any attribute that has no types assigned to it will be expanded (and
> the rule removed from the policy), which is CIL's current behavior. The
> value can be set using the function cil_set_attrs_expand_size().
>
> Auto-generated attributes that are used only in neverallow rules are
> always expanded. The rest are kept by default, but if the value of
> attrs_expand_generated in the CIL db is set to true, they will be
> expanded. The function cil_set_attrs_expand_generated() can be used
> to set the value.
>
> When creating the binary policy, CIL will expand all attributes that
> are being removed and it will expand all attributes with less members
> than the value specified by attrs_expand_size. So even if an attribute
> is used in a constraint or neverallow and the attribute itself will be
> included in the binary policy, it will be expanded when writing AV
> rules if it has less members than attrs_expand_size.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  libsepol/cil/include/cil/cil.h     |   2 +
>  libsepol/cil/src/cil.c             |  12 ++
>  libsepol/cil/src/cil_binary.c      | 253
> +++++++++++++++++++++++++++----------
>  libsepol/cil/src/cil_internal.h    |   7 +-
>  libsepol/cil/src/cil_post.c        |  32 +++--
>  libsepol/cil/src/cil_resolve_ast.c |  25 ++--
>  libsepol/src/libsepol.map.in       |   2 +
>  7 files changed, 233 insertions(+), 100 deletions(-)
>
> diff --git a/libsepol/cil/include/cil/cil.h
> b/libsepol/cil/include/cil/cil.h
> index c4a6fb9..4507892 100644
> --- a/libsepol/cil/include/cil/cil.h
> +++ b/libsepol/cil/include/cil/cil.h
> @@ -50,6 +50,8 @@ extern void cil_set_disable_neverallow(cil_db_t *db, int
> disable_neverallow);
>  extern void cil_set_preserve_tunables(cil_db_t *db, int
> preserve_tunables);
>  extern int cil_set_handle_unknown(cil_db_t *db, int handle_unknown);
>  extern void cil_set_mls(cil_db_t *db, int mls);
> +extern void cil_set_attrs_expand_generated(struct cil_db *db, int
> attrs_expand_generated);
> +extern void cil_set_attrs_expand_size(struct cil_db *db, unsigned
> attrs_expand_size);
>  extern void cil_set_target_platform(cil_db_t *db, int target_platform);
>  extern void cil_set_policy_version(cil_db_t *db, int policy_version);
>  extern void cil_write_policy_conf(FILE *out, struct cil_db *db);
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 7c40ad0..a64c528 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -282,6 +282,8 @@ void cil_db_init(struct cil_db **db)
>
>         (*db)->disable_dontaudit = CIL_FALSE;
>         (*db)->disable_neverallow = CIL_FALSE;
> +       (*db)->attrs_expand_generated = CIL_FALSE;
> +       (*db)->attrs_expand_size = 1;
>         (*db)->preserve_tunables = CIL_FALSE;
>         (*db)->handle_unknown = -1;
>         (*db)->mls = -1;
> @@ -1629,6 +1631,16 @@ void cil_set_disable_neverallow(struct cil_db *db,
> int disable_neverallow)
>         db->disable_neverallow = disable_neverallow;
>  }
>
> +void cil_set_attrs_expand_generated(struct cil_db *db, int
> attrs_expand_generated)
> +{
> +       db->attrs_expand_generated = attrs_expand_generated;
> +}
> +
> +void cil_set_attrs_expand_size(struct cil_db *db, unsigned
> attrs_expand_size)
> +{
> +       db->attrs_expand_size = attrs_expand_size;
> +}
> +
>  void cil_set_preserve_tunables(struct cil_db *db, int preserve_tunables)
>  {
>         db->preserve_tunables = preserve_tunables;
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index ac18c4e..e1481a4 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -567,7 +567,7 @@ int cil_typeattribute_to_policydb(policydb_t *pdb,
> struct cil_typeattribute *cil
>         char *key = NULL;
>         type_datum_t *sepol_attr = NULL;
>
> -       if (cil_attr->used == CIL_FALSE) {
> +       if (!cil_attr->used) {
>                 return SEPOL_OK;
>         }
>
> @@ -632,7 +632,7 @@ int cil_typeattribute_to_bitmap(policydb_t *pdb, const
> struct cil_db *db, struct
>         ebitmap_node_t *tnode;
>         unsigned int i;
>
> -       if (cil_attr->used == CIL_FALSE) {
> +       if (!cil_attr->used) {
>                 return SEPOL_OK;
>         }
>
> @@ -1429,46 +1429,20 @@ exit:
>         return rc;
>  }
>
> -static int __cil_type_datum_is_unused_attrib(struct cil_symtab_datum *src)
> +static int __cil_should_expand_attribute( const struct cil_db *db, struct
> cil_symtab_datum *datum)
>  {
> -       struct cil_tree_node *node = NULL;
> -       struct cil_typeattribute *attrib = NULL;
> +       struct cil_tree_node *node;
> +       struct cil_typeattribute *attr;
>
> -       if (src->fqn == CIL_KEY_SELF) {
> -               return CIL_FALSE;
> -       }
> -
> -       node = NODE(src);
> +       node = NODE(datum);
>
>         if (node->flavor != CIL_TYPEATTRIBUTE) {
>                 return CIL_FALSE;
>         }
>
> -       attrib = (struct cil_typeattribute *) src;
> -       return ebitmap_cardinality(attrib->types) == 0;
> -}
> -
> -static int __cil_avrule_can_remove(struct cil_avrule *cil_avrule)
> -{
> -       struct cil_symtab_datum *src = cil_avrule->src;
> -       struct cil_symtab_datum *tgt = cil_avrule->tgt;
> -
> -       // Don't remove neverallow rules so they are written to
> -       // the resulting policy and can be checked by tools in
> -       // AOSP.
> -       if (cil_avrule->rule_kind == CIL_AVRULE_NEVERALLOW) {
> -               return CIL_FALSE;
> -       }
> -
> -       if (__cil_type_datum_is_unused_attrib(src)) {
> -               return CIL_TRUE;
> -       }
> -
> -       if (__cil_type_datum_is_unused_attrib(tgt)) {
> -               return CIL_TRUE;
> -       }
> +       attr = (struct cil_typeattribute *)datum;
>
>
 Nit: missing space on )datum.

-       return CIL_FALSE;
> +       return !attr->used || (ebitmap_cardinality(attr->types) <
> db->attrs_expand_size);
>  }
>
>  int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db,
> struct cil_avrule *cil_avrule, cond_node_t *cond_node, enum cil_flavor
> cond_flavor)
> @@ -1478,6 +1452,9 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const
> struct cil_db *db, struct cil_a
>         struct cil_symtab_datum *src = NULL;
>         struct cil_symtab_datum *tgt = NULL;
>         struct cil_list *classperms = cil_avrule->perms.classperms;
> +       ebitmap_t src_bitmap, tgt_bitmap;
> +       ebitmap_node_t *snode, *tnode;
> +       unsigned int s,t;
>

nit: missing space


>
>         if (cil_avrule->rule_kind == CIL_AVRULE_DONTAUDIT &&
> db->disable_dontaudit == CIL_TRUE) {
>                 // Do not add dontaudit rules to binary
> @@ -1485,36 +1462,98 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const
> struct cil_db *db, struct cil_a
>                 goto exit;
>         }
>
> -       if (__cil_avrule_can_remove(cil_avrule)) {
> -               rc = SEPOL_OK;
> -               goto exit;
> -       }
> -
>         src = cil_avrule->src;
>         tgt = cil_avrule->tgt;
>
>         if (tgt->fqn == CIL_KEY_SELF) {
> -               ebitmap_t type_bitmap;
> -               ebitmap_node_t *tnode;
> -               unsigned int i;
> -
> -               rc = __cil_expand_type(src, &type_bitmap);
> -               if (rc != SEPOL_OK) goto exit;
> +               rc = __cil_expand_type(src, &src_bitmap);
> +               if (rc != SEPOL_OK) {
> +                       goto exit;
> +               }
>
> -               ebitmap_for_each_bit(&type_bitmap, tnode, i) {
> -                       if (!ebitmap_get_bit(&type_bitmap, i)) continue;
> +               ebitmap_for_each_bit(&src_bitmap, snode, s) {
> +                       if (!ebitmap_get_bit(&src_bitmap, s)) continue;
>
> -                       src = DATUM(db->val_to_type[i]);
> +                       src = DATUM(db->val_to_type[s]);
>                         rc = __cil_avrule_expand(pdb, kind, src, src,
> classperms, cond_node, cond_flavor);
>                         if (rc != SEPOL_OK) {
> -                               ebitmap_destroy(&type_bitmap);
> +                               ebitmap_destroy(&src_bitmap);
>                                 goto exit;
>                         }
>                 }
> -               ebitmap_destroy(&type_bitmap);
> +               ebitmap_destroy(&src_bitmap);
>         } else {
> -               rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms,
> cond_node, cond_flavor);
> -               if (rc != SEPOL_OK) goto exit;
> +               int expand_src = __cil_should_expand_attribute(db, src);
> +               int expand_tgt = __cil_should_expand_attribute(db, tgt);
> +               if (!expand_src && !expand_tgt) {
> +                       rc = __cil_avrule_expand(pdb, kind, src, tgt,
> classperms, cond_node, cond_flavor);
> +                       if (rc != SEPOL_OK) {
> +                               goto exit;
> +                       }
> +               } else if (expand_src && expand_tgt) {
> +                       rc = __cil_expand_type(src, &src_bitmap);
> +                       if (rc != SEPOL_OK) {
> +                               goto exit;
> +                       }
> +
> +                       rc = __cil_expand_type(tgt, &tgt_bitmap);
> +                       if (rc != SEPOL_OK) {
> +                               ebitmap_destroy(&src_bitmap);
> +                               goto exit;
> +                       }
> +
> +                       ebitmap_for_each_bit(&src_bitmap, snode, s) {
> +                               if (!ebitmap_get_bit(&src_bitmap, s))
> continue;
> +                               src = DATUM(db->val_to_type[s]);
> +                               ebitmap_for_each_bit(&tgt_bitmap, tnode,
> t) {
> +                                       if (!ebitmap_get_bit(&tgt_bitmap,
> t)) continue;
> +                                       tgt = DATUM(db->val_to_type[t]);
> +
> +                                       rc = __cil_avrule_expand(pdb,
> kind, src, tgt, classperms, cond_node, cond_flavor);
> +                                       if (rc != SEPOL_OK) {
> +
>  ebitmap_destroy(&src_bitmap);
> +
>  ebitmap_destroy(&tgt_bitmap);
> +                                               goto exit;
> +                                       }
> +                               }
> +                       }
> +                       ebitmap_destroy(&src_bitmap);
> +                       ebitmap_destroy(&tgt_bitmap);
> +               } else if (expand_src) {
> +                       rc = __cil_expand_type(src, &src_bitmap);
> +                       if (rc != SEPOL_OK) {
> +                               goto exit;
> +                       }
> +
> +                       ebitmap_for_each_bit(&src_bitmap, snode, s) {
> +                               if (!ebitmap_get_bit(&src_bitmap, s))
> continue;
> +                               src = DATUM(db->val_to_type[s]);
> +
> +                               rc = __cil_avrule_expand(pdb, kind, src,
> tgt, classperms, cond_node, cond_flavor);
> +                               if (rc != SEPOL_OK) {
> +                                       ebitmap_destroy(&src_bitmap);
> +                                       goto exit;
> +                               }
> +                       }
> +                       ebitmap_destroy(&src_bitmap);
> +               } else { /* expand_tgt */
> +                       rc = __cil_expand_type(tgt, &tgt_bitmap);
> +                       if (rc != SEPOL_OK) {
> +                               goto exit;
> +                       }
> +
> +                       ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
> +                               if (!ebitmap_get_bit(&tgt_bitmap, t))
> continue;
> +                               tgt = DATUM(db->val_to_type[t]);
> +
> +                               rc = __cil_avrule_expand(pdb, kind, src,
> tgt, classperms, cond_node, cond_flavor);
> +                               if (rc != SEPOL_OK) {
> +                                       ebitmap_destroy(&tgt_bitmap);
> +                                       goto exit;
> +                               }
> +                       }
> +                       ebitmap_destroy(&tgt_bitmap);
> +               }
>         }
>
>         return SEPOL_OK;
> @@ -1789,11 +1828,9 @@ int cil_avrulex_to_hashtable(policydb_t *pdb, const
> struct cil_db *db, struct ci
>         uint16_t kind;
>         struct cil_symtab_datum *src = NULL;
>         struct cil_symtab_datum *tgt = NULL;
> -       ebitmap_t type_bitmap;
> -       ebitmap_node_t *tnode;
> -       unsigned int i;
> -
> -       ebitmap_init(&type_bitmap);
> +       ebitmap_t src_bitmap, tgt_bitmap;
> +       ebitmap_node_t *snode, *tnode;
> +       unsigned int s,t;
>

missing space


>         if (cil_avrulex->rule_kind == CIL_AVRULE_DONTAUDIT &&
> db->disable_dontaudit == CIL_TRUE) {
>                 // Do not add dontaudit rules to binary
> @@ -1806,28 +1843,97 @@ int cil_avrulex_to_hashtable(policydb_t *pdb,
> const struct cil_db *db, struct ci
>         tgt = cil_avrulex->tgt;
>
>         if (tgt->fqn == CIL_KEY_SELF) {
> -               rc = __cil_expand_type(src, &type_bitmap);
> +               rc = __cil_expand_type(src, &src_bitmap);
>                 if (rc != SEPOL_OK) goto exit;
>
> -               ebitmap_for_each_bit(&type_bitmap, tnode, i) {
> -                       if (!ebitmap_get_bit(&type_bitmap, i)) continue;
> +               ebitmap_for_each_bit(&src_bitmap, snode, s) {
> +                       if (!ebitmap_get_bit(&src_bitmap, s)) continue;
>
> -                       src = DATUM(db->val_to_type[i]);
> +                       src = DATUM(db->val_to_type[s]);
>                         rc = __cil_avrulex_to_hashtable_helper(pdb, kind,
> src, src, cil_avrulex->perms.x.permx, args);
>                         if (rc != SEPOL_OK) {
>                                 goto exit;
>                         }
>                 }
> +               ebitmap_destroy(&src_bitmap);
>         } else {
> -               rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src,
> tgt, cil_avrulex->perms.x.permx, args);
> -               if (rc != SEPOL_OK) goto exit;
> +               int expand_src = __cil_should_expand_attribute(db, src);
> +               int expand_tgt = __cil_should_expand_attribute(db, tgt);
> +
> +               if (!expand_src && !expand_tgt) {
> +                       rc = __cil_avrulex_to_hashtable_helper(pdb, kind,
> src, tgt, cil_avrulex->perms.x.permx, args);
> +                       if (rc != SEPOL_OK) {
> +                               goto exit;
> +                       }
> +               } else if (expand_src && expand_tgt) {
> +                       rc = __cil_expand_type(src, &src_bitmap);
> +                       if (rc != SEPOL_OK) {
> +                               goto exit;
> +                       }
> +
> +                       rc = __cil_expand_type(tgt, &tgt_bitmap);
> +                       if (rc != SEPOL_OK) {
> +                               ebitmap_destroy(&src_bitmap);
> +                               goto exit;
> +                       }
> +
> +                       ebitmap_for_each_bit(&src_bitmap, snode, s) {
> +                               if (!ebitmap_get_bit(&src_bitmap, s))
> continue;
> +                               src = DATUM(db->val_to_type[s]);
> +                               ebitmap_for_each_bit(&tgt_bitmap, tnode,
> t) {
> +                                       if (!ebitmap_get_bit(&tgt_bitmap,
> t)) continue;
> +                                       tgt = DATUM(db->val_to_type[t]);
> +
> +                                       rc =
> __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt,
> cil_avrulex->perms.x.permx, args);
> +                                       if (rc != SEPOL_OK) {
> +
>  ebitmap_destroy(&src_bitmap);
> +
>  ebitmap_destroy(&tgt_bitmap);
> +                                               goto exit;
> +                                       }
> +                               }
> +                       }
> +                       ebitmap_destroy(&src_bitmap);
> +                       ebitmap_destroy(&tgt_bitmap);
> +               } else if (expand_src) {
> +                       rc = __cil_expand_type(src, &src_bitmap);
> +                       if (rc != SEPOL_OK) {
> +                               goto exit;
> +                       }
> +
> +                       ebitmap_for_each_bit(&src_bitmap, snode, s) {
> +                               if (!ebitmap_get_bit(&src_bitmap, s))
> continue;
> +                               src = DATUM(db->val_to_type[s]);
> +
> +                               rc =
> __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt,
> cil_avrulex->perms.x.permx, args);
> +                               if (rc != SEPOL_OK) {
> +                                       ebitmap_destroy(&src_bitmap);
> +                                       goto exit;
> +                               }
> +                       }
> +                       ebitmap_destroy(&src_bitmap);
> +               } else { /* expand_tgt */
> +                       rc = __cil_expand_type(tgt, &tgt_bitmap);
> +                       if (rc != SEPOL_OK) {
> +                               goto exit;
> +                       }
> +
> +                       ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
> +                               if (!ebitmap_get_bit(&tgt_bitmap, t))
> continue;
> +                               tgt = DATUM(db->val_to_type[t]);
> +
> +                               rc =
> __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt,
> cil_avrulex->perms.x.permx, args);
> +                               if (rc != SEPOL_OK) {
> +                                       ebitmap_destroy(&tgt_bitmap);
> +                                       goto exit;
> +                               }
> +                       }
> +                       ebitmap_destroy(&tgt_bitmap);
> +               }
>         }
>
> -       rc = SEPOL_OK;
> +       return SEPOL_OK;
>
>  exit:
> -       ebitmap_destroy(&type_bitmap);
> -
>         return rc;
>  }
>
> @@ -2417,12 +2523,19 @@ int
> __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb, const struct cil_d
>                 if (pdb->policyvers >= POLICYDB_VERSION_CONSTRAINT_NAMES) {
>                         rc = __cil_get_sepol_type_datum(pdb, item->data,
> &sepol_type);
>                         if (rc != SEPOL_OK) {
> -                               ebitmap_destroy(&type_bitmap);
> -                               goto exit;
> +                               if (FLAVOR(item->data) ==
> CIL_TYPEATTRIBUTE) {
> +                                       struct cil_typeattribute *attr =
> item->data;
> +                                       if (!attr->used) {
> +                                               rc = 0;
> +                                       }
> +                               }
>                         }
>
> -                       if (ebitmap_set_bit(&expr->type_names->types,
> sepol_type->s.value - 1, 1)) {
> -                               ebitmap_destroy(&type_bitmap);
> +                       if (sepol_type) {
> +                               rc =
> ebitmap_set_bit(&expr->type_names->types, sepol_type->s.value - 1, 1);
> +                       }
> +
> +                       if (rc != SEPOL_OK) {
>                                 goto exit;
>                         }
>                 }
> diff --git a/libsepol/cil/src/cil_internal.h
> b/libsepol/cil/src/cil_internal.h
> index 03672bb..efa2cd6 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -306,6 +306,8 @@ struct cil_db {
>         struct cil_user **val_to_user;
>         int disable_dontaudit;
>         int disable_neverallow;
> +       int attrs_expand_generated;
> +       unsigned attrs_expand_size;
>         int preserve_tunables;
>         int handle_unknown;
>         int mls;
> @@ -513,11 +515,14 @@ struct cil_type   {
>         int value;
>  };
>
> +#define CIL_ATTR_AVRULE     0x01
> +#define CIL_ATTR_NEVERALLOW 0x02
> +#define CIL_ATTR_CONSTRAINT 0x04
>  struct cil_typeattribute {
>         struct cil_symtab_datum datum;
>         struct cil_list *expr_list;
>         ebitmap_t *types;
> -       int used;       // whether or not this typeattribute was used and
> should be added to the binary
> +       int used;       // whether or not this attribute was used in a
> binary policy rule
>  };
>
>  struct cil_typeattributeset {
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 089c02f..ae62ddb 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -1188,22 +1188,32 @@ exit:
>         return SEPOL_ERR;
>  }
>
> -static int cil_typeattribute_used(struct cil_typeattribute *cil_attr)
> +static int cil_typeattribute_used(struct cil_typeattribute *attr, struct
> cil_db *db)
>  {
> -       if (cil_attr->used) {
> -               return CIL_TRUE;
> +       if (!attr->used) {
> +               return CIL_FALSE;
>         }
>
> -       if (strcmp(DATUM(cil_attr)->name, GEN_REQUIRE_ATTR) == 0) {
> -               return CIL_FALSE;
> +       if (attr->used & CIL_ATTR_CONSTRAINT) {
> +               return CIL_TRUE;
>         }
>
> -       if (strstr(DATUM(cil_attr)->name,TYPEATTR_INFIX) != NULL) {
> -               return CIL_FALSE;
> +       if (db->attrs_expand_generated || attr->used ==
> CIL_ATTR_NEVERALLOW) {
> +               if (strcmp(DATUM(attr)->name, GEN_REQUIRE_ATTR) == 0) {
> +                       return CIL_FALSE;
> +               } else if (strstr(DATUM(attr)->name, TYPEATTR_INFIX) !=
> NULL) {
> +                       return CIL_FALSE;
> +               }
> +
> +               if (attr->used == CIL_ATTR_NEVERALLOW) {
> +                       return CIL_TRUE;
> +               }
>         }
>
> -       if (ebitmap_cardinality(cil_attr->types) == 0) {
> -               return CIL_FALSE;
> +       if (attr->used == CIL_ATTR_AVRULE) {
> +               if (ebitmap_cardinality(attr->types) <
> db->attrs_expand_size) {
> +                       return CIL_FALSE;
> +               }
>         }
>
>         return CIL_TRUE;
> @@ -1231,9 +1241,7 @@ static int __cil_post_db_attr_helper(struct
> cil_tree_node *node, uint32_t *finis
>                 if (attr->types == NULL) {
>                         rc = __evaluate_type_expression(attr, db);
>                         if (rc != SEPOL_OK) goto exit;
> -                       if (cil_typeattribute_used(attr)) {
> -                               attr->used = CIL_TRUE;
> -                       }
> +                       attr->used = cil_typeattribute_used(attr, db);
>                 }
>                 break;
>         }
> diff --git a/libsepol/cil/src/cil_resolve_ast.c
> b/libsepol/cil/src/cil_resolve_ast.c
> index 1870501..6da44ba 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -269,13 +269,13 @@ exit:
>         return rc;
>  }
>
> -int cil_type_used(struct cil_symtab_datum *datum)
> +int cil_type_used(struct cil_symtab_datum *datum, int used)
>  {
>         struct cil_typeattribute *attr = NULL;
>
>         if (FLAVOR(datum) == CIL_TYPEATTRIBUTE) {
>                 attr = (struct cil_typeattribute*)datum;
> -               attr->used = CIL_TRUE;
> +               attr->used |= used;
>         }
>
>         return 0;
> @@ -307,6 +307,7 @@ int cil_resolve_avrule(struct cil_tree_node *current,
> void *extra_args)
>         struct cil_symtab_datum *src_datum = NULL;
>         struct cil_symtab_datum *tgt_datum = NULL;
>         struct cil_symtab_datum *permx_datum = NULL;
> +       int used;
>         int rc = SEPOL_ERR;
>
>         if (args != NULL) {
> @@ -318,9 +319,6 @@ int cil_resolve_avrule(struct cil_tree_node *current,
> void *extra_args)
>                 goto exit;
>         }
>         rule->src = src_datum;
> -       if (rule->rule_kind != CIL_AVRULE_NEVERALLOW) {
> -               cil_type_used(src_datum);
> -       }
>
>         if (rule->tgt_str == CIL_KEY_SELF) {
>                 rule->tgt = db->selftype;
> @@ -330,9 +328,10 @@ int cil_resolve_avrule(struct cil_tree_node *current,
> void *extra_args)
>                         goto exit;
>                 }
>                 rule->tgt = tgt_datum;
> -               if (rule->rule_kind != CIL_AVRULE_NEVERALLOW) {
> -                       cil_type_used(tgt_datum);
> -               }
> +               used = (rule->rule_kind == CIL_AVRULE_NEVERALLOW) ?
> +                       CIL_ATTR_NEVERALLOW : CIL_ATTR_AVRULE;
> +               cil_type_used(src_datum, used); /* src not used if tgt is
> self */
> +               cil_type_used(tgt_datum, used);
>         }
>
>         if (!rule->is_extended) {
> @@ -376,14 +375,12 @@ int cil_resolve_type_rule(struct cil_tree_node
> *current, void *extra_args)
>                 goto exit;
>         }
>         rule->src = src_datum;
> -       cil_type_used(src_datum);
>
>         rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES,
> extra_args, &tgt_datum);
>         if (rc != SEPOL_OK) {
>                 goto exit;
>         }
>         rule->tgt = tgt_datum;
> -       cil_type_used(tgt_datum);
>
>         rc = cil_resolve_name(current, rule->obj_str, CIL_SYM_CLASSES,
> extra_args, &obj_datum);
>         if (rc != SEPOL_OK) {
> @@ -589,14 +586,12 @@ int cil_resolve_nametypetransition(struct
> cil_tree_node *current, void *extra_ar
>                 goto exit;
>         }
>         nametypetrans->src = src_datum;
> -       cil_type_used(src_datum);
>
>         rc = cil_resolve_name(current, nametypetrans->tgt_str,
> CIL_SYM_TYPES, extra_args, &tgt_datum);
>         if (rc != SEPOL_OK) {
>                 goto exit;
>         }
>         nametypetrans->tgt = tgt_datum;
> -       cil_type_used(tgt_datum);
>
>         rc = cil_resolve_name(current, nametypetrans->obj_str,
> CIL_SYM_CLASSES, extra_args, &obj_datum);
>         if (rc != SEPOL_OK) {
> @@ -647,14 +642,12 @@ int cil_resolve_rangetransition(struct cil_tree_node
> *current, void *extra_args)
>                 goto exit;
>         }
>         rangetrans->src = src_datum;
> -       cil_type_used(src_datum);
>
>         rc = cil_resolve_name(current, rangetrans->exec_str,
> CIL_SYM_TYPES, extra_args, &exec_datum);
>         if (rc != SEPOL_OK) {
>                 goto exit;
>         }
>         rangetrans->exec = exec_datum;
> -       cil_type_used(exec_datum);
>
>         rc = cil_resolve_name(current, rangetrans->obj_str,
> CIL_SYM_CLASSES, extra_args, &obj_datum);
>         if (rc != SEPOL_OK) {
> @@ -1006,7 +999,6 @@ int cil_resolve_roletype(struct cil_tree_node
> *current, void *extra_args)
>                 goto exit;
>         }
>         roletype->type = (struct cil_type*)type_datum;
> -       cil_type_used(type_datum);
>
>         return SEPOL_OK;
>
> @@ -1035,7 +1027,6 @@ int cil_resolve_roletransition(struct cil_tree_node
> *current, void *extra_args)
>                 goto exit;
>         }
>         roletrans->tgt = tgt_datum;
> -       cil_type_used(tgt_datum);
>
>         rc = cil_resolve_name(current, roletrans->obj_str,
> CIL_SYM_CLASSES, extra_args, &obj_datum);
>         if (rc != SEPOL_OK) {
> @@ -3108,7 +3099,7 @@ int cil_resolve_expr(enum cil_flavor expr_type,
> struct cil_list *str_expr, struc
>                         }
>
>                         if (sym_index == CIL_SYM_TYPES && (expr_type ==
> CIL_CONSTRAIN || expr_type == CIL_VALIDATETRANS)) {
> -                               cil_type_used(res_datum);
> +                               cil_type_used(res_datum,
> CIL_ATTR_CONSTRAINT);
>                         }
>
>                         cil_list_append(*datum_expr, CIL_DATUM, res_datum);
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index 5e68fcb..4042640 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -45,6 +45,8 @@ LIBSEPOL_1.1 {
>         cil_set_target_platform;
>         cil_set_policy_version;
>         cil_set_mls;
> +       cil_set_attrs_expand_generated;
> +       cil_set_attrs_expand_size;
>         cil_write_policy_conf;
>         sepol_ppfile_to_module_package;
>         sepol_module_package_to_cil;
> --
> 2.7.4
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a11c1662a0aaad2054cfb8715
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Just a couple of missing space nits.<div><br></div><div>Ca=
n we get this merged today? I&#39;d like to start using the --expand-genera=
ted feature.<br><div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue=
, Apr 11, 2017 at 10:53 AM James Carter &lt;<a href=3D"mailto:jwcart2@tycho=
.nsa.gov">jwcart2@tycho.nsa.gov</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Originally, all type attributes were expanded when building a=
 binary<br class=3D"gmail_msg">
policy. As the policy grew, binary policy sizes became too large, so<br cla=
ss=3D"gmail_msg">
changes were made to keep attributes in the binary policy to minimize<br cl=
ass=3D"gmail_msg">
policy size.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Keeping attributes works well as long as each type does not have too<br cla=
ss=3D"gmail_msg">
many attributes. If an access check fails for types t1 and t2, then<br clas=
s=3D"gmail_msg">
additional checks must be made for every attribute that t1 is a member<br c=
lass=3D"gmail_msg">
of against t2 and all the attributes that t2 is a member of. This is<br cla=
ss=3D"gmail_msg">
O(n*m) behavior and there are cases now where this is becoming a<br class=
=3D"gmail_msg">
performance issue.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Attributes are more aggressively removed than before. An attribute<br class=
=3D"gmail_msg">
will now be removed if it only appears in rules where attributes are<br cla=
ss=3D"gmail_msg">
always expanded (typetransition, typechange, typemember, roletransition,<br=
 class=3D"gmail_msg">
rangetransition, roletype, and AV Rules with self).<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Attributes that are used in constraints are always kept because the<br clas=
s=3D"gmail_msg">
attribute name is stored for debugging purposes in the binary policy.<br cl=
ass=3D"gmail_msg">
<br class=3D"gmail_msg">
Attributes that are used in neverallow rules, but not in other AV rules,<br=
 class=3D"gmail_msg">
will be kept unless the attribute is auto-generated.<br class=3D"gmail_msg"=
>
<br class=3D"gmail_msg">
Attributes that are only used in AV rules other than neverallow rules<br cl=
ass=3D"gmail_msg">
are kept unless the number of types assigned to them is less than the<br cl=
ass=3D"gmail_msg">
value of attrs_expand_size in the CIL db. The default is 1, which means<br =
class=3D"gmail_msg">
that any attribute that has no types assigned to it will be expanded (and<b=
r class=3D"gmail_msg">
the rule removed from the policy), which is CIL&#39;s current behavior. The=
<br class=3D"gmail_msg">
value can be set using the function cil_set_attrs_expand_size().<br class=
=3D"gmail_msg">
<br class=3D"gmail_msg">
Auto-generated attributes that are used only in neverallow rules are<br cla=
ss=3D"gmail_msg">
always expanded. The rest are kept by default, but if the value of<br class=
=3D"gmail_msg">
attrs_expand_generated in the CIL db is set to true, they will be<br class=
=3D"gmail_msg">
expanded. The function cil_set_attrs_expand_generated() can be used<br clas=
s=3D"gmail_msg">
to set the value.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
When creating the binary policy, CIL will expand all attributes that<br cla=
ss=3D"gmail_msg">
are being removed and it will expand all attributes with less members<br cl=
ass=3D"gmail_msg">
than the value specified by attrs_expand_size. So even if an attribute<br c=
lass=3D"gmail_msg">
is used in a constraint or neverallow and the attribute itself will be<br c=
lass=3D"gmail_msg">
included in the binary policy, it will be expanded when writing AV<br class=
=3D"gmail_msg">
rules if it has less members than attrs_expand_size.<br class=3D"gmail_msg"=
>
<br class=3D"gmail_msg">
Signed-off-by: James Carter &lt;<a href=3D"mailto:jwcart2@tycho.nsa.gov" cl=
ass=3D"gmail_msg" target=3D"_blank">jwcart2@tycho.nsa.gov</a>&gt;<br class=
=3D"gmail_msg">
---<br class=3D"gmail_msg">
=C2=A0libsepol/cil/include/cil/cil.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<b=
r class=3D"gmail_msg">
=C2=A0libsepol/cil/src/cil.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 12 ++<br class=3D"gmail_msg">
=C2=A0libsepol/cil/src/cil_binary.c=C2=A0 =C2=A0 =C2=A0 | 253 +++++++++++++=
++++++++++++++----------<br class=3D"gmail_msg">
=C2=A0libsepol/cil/src/cil_internal.h=C2=A0 =C2=A0 |=C2=A0 =C2=A07 +-<br cl=
ass=3D"gmail_msg">
=C2=A0libsepol/cil/src/cil_post.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 32 +++=
--<br class=3D"gmail_msg">
=C2=A0libsepol/cil/src/cil_resolve_ast.c |=C2=A0 25 ++--<br class=3D"gmail_=
msg">
=C2=A0libsepol/src/<a href=3D"http://libsepol.map.in" rel=3D"noreferrer" cl=
ass=3D"gmail_msg" target=3D"_blank">libsepol.map.in</a>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A02 +<br class=3D"gmail_msg">
=C2=A07 files changed, 233 insertions(+), 100 deletions(-)<br class=3D"gmai=
l_msg">
<br class=3D"gmail_msg">
diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.=
h<br class=3D"gmail_msg">
index c4a6fb9..4507892 100644<br class=3D"gmail_msg">
--- a/libsepol/cil/include/cil/cil.h<br class=3D"gmail_msg">
+++ b/libsepol/cil/include/cil/cil.h<br class=3D"gmail_msg">
@@ -50,6 +50,8 @@ extern void cil_set_disable_neverallow(cil_db_t *db, int =
disable_neverallow);<br class=3D"gmail_msg">
=C2=A0extern void cil_set_preserve_tunables(cil_db_t *db, int preserve_tuna=
bles);<br class=3D"gmail_msg">
=C2=A0extern int cil_set_handle_unknown(cil_db_t *db, int handle_unknown);<=
br class=3D"gmail_msg">
=C2=A0extern void cil_set_mls(cil_db_t *db, int mls);<br class=3D"gmail_msg=
">
+extern void cil_set_attrs_expand_generated(struct cil_db *db, int attrs_ex=
pand_generated);<br class=3D"gmail_msg">
+extern void cil_set_attrs_expand_size(struct cil_db *db, unsigned attrs_ex=
pand_size);<br class=3D"gmail_msg">
=C2=A0extern void cil_set_target_platform(cil_db_t *db, int target_platform=
);<br class=3D"gmail_msg">
=C2=A0extern void cil_set_policy_version(cil_db_t *db, int policy_version);=
<br class=3D"gmail_msg">
=C2=A0extern void cil_write_policy_conf(FILE *out, struct cil_db *db);<br c=
lass=3D"gmail_msg">
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c<br class=3D"gm=
ail_msg">
index 7c40ad0..a64c528 100644<br class=3D"gmail_msg">
--- a/libsepol/cil/src/cil.c<br class=3D"gmail_msg">
+++ b/libsepol/cil/src/cil.c<br class=3D"gmail_msg">
@@ -282,6 +282,8 @@ void cil_db_init(struct cil_db **db)<br class=3D"gmail_=
msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*db)-&gt;disable_dontaudit =3D CIL_FALSE;<br c=
lass=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*db)-&gt;disable_neverallow =3D CIL_FALSE;<br =
class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0(*db)-&gt;attrs_expand_generated =3D CIL_FALSE;=
<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0(*db)-&gt;attrs_expand_size =3D 1;<br class=3D"=
gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*db)-&gt;preserve_tunables =3D CIL_FALSE;<br c=
lass=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*db)-&gt;handle_unknown =3D -1;<br class=3D"gm=
ail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*db)-&gt;mls =3D -1;<br class=3D"gmail_msg">
@@ -1629,6 +1631,16 @@ void cil_set_disable_neverallow(struct cil_db *db, i=
nt disable_neverallow)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 db-&gt;disable_neverallow =3D disable_neverallo=
w;<br class=3D"gmail_msg">
=C2=A0}<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
+void cil_set_attrs_expand_generated(struct cil_db *db, int attrs_expand_ge=
nerated)<br class=3D"gmail_msg">
+{<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0db-&gt;attrs_expand_generated =3D attrs_expand_=
generated;<br class=3D"gmail_msg">
+}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+void cil_set_attrs_expand_size(struct cil_db *db, unsigned attrs_expand_si=
ze)<br class=3D"gmail_msg">
+{<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0db-&gt;attrs_expand_size =3D attrs_expand_size;=
<br class=3D"gmail_msg">
+}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
=C2=A0void cil_set_preserve_tunables(struct cil_db *db, int preserve_tunabl=
es)<br class=3D"gmail_msg">
=C2=A0{<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 db-&gt;preserve_tunables =3D preserve_tunables;=
<br class=3D"gmail_msg">
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c<=
br class=3D"gmail_msg">
index ac18c4e..e1481a4 100644<br class=3D"gmail_msg">
--- a/libsepol/cil/src/cil_binary.c<br class=3D"gmail_msg">
+++ b/libsepol/cil/src/cil_binary.c<br class=3D"gmail_msg">
@@ -567,7 +567,7 @@ int cil_typeattribute_to_policydb(policydb_t *pdb, stru=
ct cil_typeattribute *cil<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *key =3D NULL;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 type_datum_t *sepol_attr =3D NULL;<br class=3D"=
gmail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cil_attr-&gt;used =3D=3D CIL_FALSE) {<br cl=
ass=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cil_attr-&gt;used) {<br class=3D"gmail_msg=
">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return SEPOL_OK;<br=
 class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
@@ -632,7 +632,7 @@ int cil_typeattribute_to_bitmap(policydb_t *pdb, const =
struct cil_db *db, struct<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ebitmap_node_t *tnode;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int i;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cil_attr-&gt;used =3D=3D CIL_FALSE) {<br cl=
ass=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cil_attr-&gt;used) {<br class=3D"gmail_msg=
">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return SEPOL_OK;<br=
 class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
@@ -1429,46 +1429,20 @@ exit:<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;<br class=3D"gmail_msg">
=C2=A0}<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-static int __cil_type_datum_is_unused_attrib(struct cil_symtab_datum *src)=
<br class=3D"gmail_msg">
+static int __cil_should_expand_attribute( const struct cil_db *db, struct =
cil_symtab_datum *datum)<br class=3D"gmail_msg">
=C2=A0{<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_tree_node *node =3D NULL;<br class=
=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_typeattribute *attrib =3D NULL;<br c=
lass=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_tree_node *node;<br class=3D"gmail_m=
sg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_typeattribute *attr;<br class=3D"gma=
il_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (src-&gt;fqn =3D=3D CIL_KEY_SELF) {<br class=
=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_FALSE;<b=
r class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
-<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D NODE(src);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D NODE(datum);<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (node-&gt;flavor !=3D CIL_TYPEATTRIBUTE) {<b=
r class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return CIL_FALSE;<b=
r class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0attrib =3D (struct cil_typeattribute *) src;<br=
 class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ebitmap_cardinality(attrib-&gt;types) =
=3D=3D 0;<br class=3D"gmail_msg">
-}<br class=3D"gmail_msg">
-<br class=3D"gmail_msg">
-static int __cil_avrule_can_remove(struct cil_avrule *cil_avrule)<br class=
=3D"gmail_msg">
-{<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_symtab_datum *src =3D cil_avrule-&gt=
;src;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_symtab_datum *tgt =3D cil_avrule-&gt=
;tgt;<br class=3D"gmail_msg">
-<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0// Don&#39;t remove neverallow rules so they ar=
e written to<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0// the resulting policy and can be checked by t=
ools in<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0// AOSP.<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cil_avrule-&gt;rule_kind =3D=3D CIL_AVRULE_=
NEVERALLOW) {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_FALSE;<b=
r class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
-<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (__cil_type_datum_is_unused_attrib(src)) {<b=
r class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_TRUE;<br=
 class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
-<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (__cil_type_datum_is_unused_attrib(tgt)) {<b=
r class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_TRUE;<br=
 class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0attr =3D (struct cil_typeattribute *)datum;<br =
class=3D"gmail_msg">
<br class=3D"gmail_msg"></blockquote><div>=C2=A0</div><div>=C2=A0Nit: missi=
ng space on )datum.</div><div><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_FALSE;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return !attr-&gt;used || (ebitmap_cardinality(a=
ttr-&gt;types) &lt; db-&gt;attrs_expand_size);<br class=3D"gmail_msg">
=C2=A0}<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, s=
truct cil_avrule *cil_avrule, cond_node_t *cond_node, enum cil_flavor cond_=
flavor)<br class=3D"gmail_msg">
@@ -1478,6 +1452,9 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const stru=
ct cil_db *db, struct cil_a<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cil_symtab_datum *src =3D NULL;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cil_symtab_datum *tgt =3D NULL;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cil_list *classperms =3D cil_avrule-&gt;=
perms.classperms;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_t src_bitmap, tgt_bitmap;<br class=3D"g=
mail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_node_t *snode, *tnode;<br class=3D"gmai=
l_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int s,t;<br class=3D"gmail_msg"></bloc=
kquote><div><br></div><div>nit: missing space</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cil_avrule-&gt;rule_kind =3D=3D CIL_AVRULE_=
DONTAUDIT &amp;&amp; db-&gt;disable_dontaudit =3D=3D CIL_TRUE) {<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // Do not add donta=
udit rules to binary<br class=3D"gmail_msg">
@@ -1485,36 +1462,98 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const st=
ruct cil_db *db, struct cil_a<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (__cil_avrule_can_remove(cil_avrule)) {<br c=
lass=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D SEPOL_OK;<br=
 class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br class=
=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
-<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 src =3D cil_avrule-&gt;src;<br class=3D"gmail_m=
sg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt =3D cil_avrule-&gt;tgt;<br class=3D"gmail_m=
sg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tgt-&gt;fqn =3D=3D CIL_KEY_SELF) {<br class=
=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_t type_bitm=
ap;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_node_t *tno=
de;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br =
class=3D"gmail_msg">
-<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __cil_expand=
_type(src, &amp;type_bitmap);<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_O=
K) goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __cil_expand=
_type(src, &amp;src_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_O=
K) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail=
_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_for_each_bi=
t(&amp;type_bitmap, tnode, i) {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!ebitmap_get_bit(&amp;type_bitmap, i)) continue;<br class=3D"=
gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_for_each_bi=
t(&amp;src_bitmap, snode, s) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!ebitmap_get_bit(&amp;src_bitmap, s)) continue;<br class=3D"g=
mail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0src =3D DATUM(db-&gt;val_to_type[i]);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0src =3D DATUM(db-&gt;val_to_type[s]);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rc =3D __cil_avrule_expand(pdb, kind, src, src, classperms, cond=
_node, cond_flavor);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&amp;type_bitmap);<br=
 class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&amp;src_bitmap);<br =
class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail=
_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&am=
p;type_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&am=
p;src_bitmap);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __cil_avrule=
_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);<br class=
=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_O=
K) goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int expand_src =3D =
__cil_should_expand_attribute(db, src);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int expand_tgt =3D =
__cil_should_expand_attribute(db, tgt);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!expand_src &am=
p;&amp; !expand_tgt) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_=
node, cond_flavor);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (expand_s=
rc &amp;&amp; expand_tgt) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D __cil_expand_type(src, &amp;src_bitmap);<br class=3D"gmail=
_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D __cil_expand_type(tgt, &amp;tgt_bitmap);<br class=3D"gmail=
_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&amp;src_bitmap);<br =
class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_for_each_bit(&amp;src_bitmap, snode, s) {<br class=3D"gma=
il_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ebitmap_get_bit(&amp;src_bitmap,=
 s)) continue;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src =3D DATUM(db-&gt;val_to_type[s]);=
<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_for_each_bit(&amp;tgt_bitmap,=
 tnode, t) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ebit=
map_get_bit(&amp;tgt_bitmap, t)) continue;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tgt =3D D=
ATUM(db-&gt;val_to_type[t]);<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __=
cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);=
<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=
=3D SEPOL_OK) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&amp;src_bitmap);<br class=3D"gmail_msg=
">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&amp;tgt_bitmap);<br class=3D"gmail_msg=
">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br clas=
s=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_destroy(&amp;src_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_destroy(&amp;tgt_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (expand_s=
rc) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D __cil_expand_type(src, &amp;src_bitmap);<br class=3D"gmail=
_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_for_each_bit(&amp;src_bitmap, snode, s) {<br class=3D"gma=
il_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ebitmap_get_bit(&amp;src_bitmap,=
 s)) continue;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src =3D DATUM(db-&gt;val_to_type[s]);=
<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __cil_avrule_expand(pdb, kind,=
 src, tgt, classperms, cond_node, cond_flavor);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"g=
mail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_d=
estroy(&amp;src_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit=
;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_destroy(&amp;src_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else { /* expand_=
tgt */<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D __cil_expand_type(tgt, &amp;tgt_bitmap);<br class=3D"gmail=
_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_for_each_bit(&amp;tgt_bitmap, tnode, t) {<br class=3D"gma=
il_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ebitmap_get_bit(&amp;tgt_bitmap,=
 t)) continue;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tgt =3D DATUM(db-&gt;val_to_type[t]);=
<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __cil_avrule_expand(pdb, kind,=
 src, tgt, classperms, cond_node, cond_flavor);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"g=
mail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_d=
estroy(&amp;tgt_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit=
;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_destroy(&amp;tgt_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail=
_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return SEPOL_OK;<br class=3D"gmail_msg">
@@ -1789,11 +1828,9 @@ int cil_avrulex_to_hashtable(policydb_t *pdb, const =
struct cil_db *db, struct ci<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t kind;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cil_symtab_datum *src =3D NULL;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cil_symtab_datum *tgt =3D NULL;<br class=
=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_t type_bitmap;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_node_t *tnode;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br class=3D"gmail_msg">
-<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_init(&amp;type_bitmap);<br class=3D"gma=
il_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_t src_bitmap, tgt_bitmap;<br class=3D"g=
mail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_node_t *snode, *tnode;<br class=3D"gmai=
l_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int s,t;<br class=3D"gmail_msg"></bloc=
kquote><div>=C2=A0</div><div>missing space=C2=A0</div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cil_avrulex-&gt;rule_kind =3D=3D CIL_AVRULE=
_DONTAUDIT &amp;&amp; db-&gt;disable_dontaudit =3D=3D CIL_TRUE) {<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // Do not add donta=
udit rules to binary<br class=3D"gmail_msg">
@@ -1806,28 +1843,97 @@ int cil_avrulex_to_hashtable(policydb_t *pdb, const=
 struct cil_db *db, struct ci<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt =3D cil_avrulex-&gt;tgt;<br class=3D"gmail_=
msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tgt-&gt;fqn =3D=3D CIL_KEY_SELF) {<br class=
=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __cil_expand=
_type(src, &amp;type_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __cil_expand=
_type(src, &amp;src_bitmap);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc !=3D SEPOL_O=
K) goto exit;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_for_each_bi=
t(&amp;type_bitmap, tnode, i) {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!ebitmap_get_bit(&amp;type_bitmap, i)) continue;<br class=3D"=
gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_for_each_bi=
t(&amp;src_bitmap, snode, s) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!ebitmap_get_bit(&amp;src_bitmap, s)) continue;<br class=3D"g=
mail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0src =3D DATUM(db-&gt;val_to_type[i]);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0src =3D DATUM(db-&gt;val_to_type[s]);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rc =3D __cil_avrulex_to_hashtable_helper(pdb, kind, src, src, ci=
l_avrulex-&gt;perms.x.permx, args);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail=
_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&am=
p;src_bitmap);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __cil_avrule=
x_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex-&gt;perms.x.permx, a=
rgs);<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_O=
K) goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int expand_src =3D =
__cil_should_expand_attribute(db, src);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int expand_tgt =3D =
__cil_should_expand_attribute(db, tgt);<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!expand_src &am=
p;&amp; !expand_tgt) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil=
_avrulex-&gt;perms.x.permx, args);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (expand_s=
rc &amp;&amp; expand_tgt) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D __cil_expand_type(src, &amp;src_bitmap);<br class=3D"gmail=
_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D __cil_expand_type(tgt, &amp;tgt_bitmap);<br class=3D"gmail=
_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&amp;src_bitmap);<br =
class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_for_each_bit(&amp;src_bitmap, snode, s) {<br class=3D"gma=
il_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ebitmap_get_bit(&amp;src_bitmap,=
 s)) continue;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src =3D DATUM(db-&gt;val_to_type[s]);=
<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_for_each_bit(&amp;tgt_bitmap,=
 tnode, t) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ebit=
map_get_bit(&amp;tgt_bitmap, t)) continue;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tgt =3D D=
ATUM(db-&gt;val_to_type[t]);<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __=
cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex-&gt;perms.=
x.permx, args);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=
=3D SEPOL_OK) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&amp;src_bitmap);<br class=3D"gmail_msg=
">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&amp;tgt_bitmap);<br class=3D"gmail_msg=
">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br clas=
s=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_destroy(&amp;src_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_destroy(&amp;tgt_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (expand_s=
rc) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D __cil_expand_type(src, &amp;src_bitmap);<br class=3D"gmail=
_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_for_each_bit(&amp;src_bitmap, snode, s) {<br class=3D"gma=
il_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ebitmap_get_bit(&amp;src_bitmap,=
 s)) continue;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src =3D DATUM(db-&gt;val_to_type[s]);=
<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __cil_avrulex_to_hashtable_hel=
per(pdb, kind, src, tgt, cil_avrulex-&gt;perms.x.permx, args);<br class=3D"=
gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"g=
mail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_d=
estroy(&amp;src_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit=
;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_destroy(&amp;src_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else { /* expand_=
tgt */<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D __cil_expand_type(tgt, &amp;tgt_bitmap);<br class=3D"gmail=
_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_for_each_bit(&amp;tgt_bitmap, tnode, t) {<br class=3D"gma=
il_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ebitmap_get_bit(&amp;tgt_bitmap,=
 t)) continue;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tgt =3D DATUM(db-&gt;val_to_type[t]);=
<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __cil_avrulex_to_hashtable_hel=
per(pdb, kind, src, tgt, cil_avrulex-&gt;perms.x.permx, args);<br class=3D"=
gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"g=
mail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_d=
estroy(&amp;tgt_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit=
;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ebitmap_destroy(&amp;tgt_bitmap);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail=
_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D SEPOL_OK;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return SEPOL_OK;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0exit:<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&amp;type_bitmap);<br class=3D"=
gmail_msg">
-<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;<br class=3D"gmail_msg">
=C2=A0}<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
@@ -2417,12 +2523,19 @@ int __cil_constrain_expr_datum_to_sepol_expr(policy=
db_t *pdb, const struct cil_d<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pdb-&gt;policyv=
ers &gt;=3D POLICYDB_VERSION_CONSTRAINT_NAMES) {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rc =3D __cil_get_sepol_type_datum(pdb, item-&gt;data, &amp;sepol=
_type);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&amp;type_bitmap);<br=
 class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (FLAVOR(item-&gt;data) =3D=3D CIL_=
TYPEATTRIBUTE) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ci=
l_typeattribute *attr =3D item-&gt;data;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!attr=
-&gt;used) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0rc =3D 0;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br clas=
s=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ebitmap_set_bit(&amp;expr-&gt;type_names-&gt;types, sepol_typ=
e-&gt;s.value - 1, 1)) {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&amp;type_bitmap);<br=
 class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (sepol_type) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D ebitmap_set_bit(&amp;expr-&gt;=
type_names-&gt;types, sepol_type-&gt;s.value - 1, 1);<br class=3D"gmail_msg=
">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail=
_msg">
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_interna=
l.h<br class=3D"gmail_msg">
index 03672bb..efa2cd6 100644<br class=3D"gmail_msg">
--- a/libsepol/cil/src/cil_internal.h<br class=3D"gmail_msg">
+++ b/libsepol/cil/src/cil_internal.h<br class=3D"gmail_msg">
@@ -306,6 +306,8 @@ struct cil_db {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cil_user **val_to_user;<br class=3D"gmai=
l_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int disable_dontaudit;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int disable_neverallow;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int attrs_expand_generated;<br class=3D"gmail_m=
sg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned attrs_expand_size;<br class=3D"gmail_m=
sg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int preserve_tunables;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int handle_unknown;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int mls;<br class=3D"gmail_msg">
@@ -513,11 +515,14 @@ struct cil_type=C2=A0 =C2=A0{<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int value;<br class=3D"gmail_msg">
=C2=A0};<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
+#define CIL_ATTR_AVRULE=C2=A0 =C2=A0 =C2=A00x01<br class=3D"gmail_msg">
+#define CIL_ATTR_NEVERALLOW 0x02<br class=3D"gmail_msg">
+#define CIL_ATTR_CONSTRAINT 0x04<br class=3D"gmail_msg">
=C2=A0struct cil_typeattribute {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cil_symtab_datum datum;<br class=3D"gmai=
l_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cil_list *expr_list;<br class=3D"gmail_m=
sg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ebitmap_t *types;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int used;=C2=A0 =C2=A0 =C2=A0 =C2=A0// whether =
or not this typeattribute was used and should be added to the binary<br cla=
ss=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int used;=C2=A0 =C2=A0 =C2=A0 =C2=A0// whether =
or not this attribute was used in a binary policy rule<br class=3D"gmail_ms=
g">
=C2=A0};<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0struct cil_typeattributeset {<br class=3D"gmail_msg">
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c<br c=
lass=3D"gmail_msg">
index 089c02f..ae62ddb 100644<br class=3D"gmail_msg">
--- a/libsepol/cil/src/cil_post.c<br class=3D"gmail_msg">
+++ b/libsepol/cil/src/cil_post.c<br class=3D"gmail_msg">
@@ -1188,22 +1188,32 @@ exit:<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return SEPOL_ERR;<br class=3D"gmail_msg">
=C2=A0}<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-static int cil_typeattribute_used(struct cil_typeattribute *cil_attr)<br c=
lass=3D"gmail_msg">
+static int cil_typeattribute_used(struct cil_typeattribute *attr, struct c=
il_db *db)<br class=3D"gmail_msg">
=C2=A0{<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cil_attr-&gt;used) {<br class=3D"gmail_msg"=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_TRUE;<br=
 class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!attr-&gt;used) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_FALSE;<b=
r class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(DATUM(cil_attr)-&gt;name, GEN_REQUIR=
E_ATTR) =3D=3D 0) {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_FALSE;<b=
r class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (attr-&gt;used &amp; CIL_ATTR_CONSTRAINT) {<=
br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_TRUE;<br=
 class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strstr(DATUM(cil_attr)-&gt;name,TYPEATTR_IN=
FIX) !=3D NULL) {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_FALSE;<b=
r class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (db-&gt;attrs_expand_generated || attr-&gt;u=
sed =3D=3D CIL_ATTR_NEVERALLOW) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(DATUM(at=
tr)-&gt;name, GEN_REQUIRE_ATTR) =3D=3D 0) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return CIL_FALSE;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (strstr(D=
ATUM(attr)-&gt;name, TYPEATTR_INFIX) !=3D NULL) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return CIL_FALSE;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail=
_msg">
+<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (attr-&gt;used =
=3D=3D CIL_ATTR_NEVERALLOW) {<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return CIL_TRUE;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail=
_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ebitmap_cardinality(cil_attr-&gt;types) =3D=
=3D 0) {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_FALSE;<b=
r class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (attr-&gt;used =3D=3D CIL_ATTR_AVRULE) {<br =
class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ebitmap_cardina=
lity(attr-&gt;types) &lt; db-&gt;attrs_expand_size) {<br class=3D"gmail_msg=
">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return CIL_FALSE;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail=
_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return CIL_TRUE;<br class=3D"gmail_msg">
@@ -1231,9 +1241,7 @@ static int __cil_post_db_attr_helper(struct cil_tree_=
node *node, uint32_t *finis<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (attr-&gt;types =
=3D=3D NULL) {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rc =3D __evaluate_type_expression(attr, db);<br class=3D"gmail_m=
sg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (rc !=3D SEPOL_OK) goto exit;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (cil_typeattribute_used(attr)) {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr-&gt;used =3D CIL_TRUE;<br class=
=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0attr-&gt;used =3D cil_typeattribute_used(attr, db);<br class=3D"g=
mail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail=
_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br class=3D"=
gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_reso=
lve_ast.c<br class=3D"gmail_msg">
index 1870501..6da44ba 100644<br class=3D"gmail_msg">
--- a/libsepol/cil/src/cil_resolve_ast.c<br class=3D"gmail_msg">
+++ b/libsepol/cil/src/cil_resolve_ast.c<br class=3D"gmail_msg">
@@ -269,13 +269,13 @@ exit:<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;<br class=3D"gmail_msg">
=C2=A0}<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-int cil_type_used(struct cil_symtab_datum *datum)<br class=3D"gmail_msg">
+int cil_type_used(struct cil_symtab_datum *datum, int used)<br class=3D"gm=
ail_msg">
=C2=A0{<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cil_typeattribute *attr =3D NULL;<br cla=
ss=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FLAVOR(datum) =3D=3D CIL_TYPEATTRIBUTE) {<b=
r class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 attr =3D (struct ci=
l_typeattribute*)datum;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr-&gt;used =3D C=
IL_TRUE;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr-&gt;used |=3D =
used;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br class=3D"gmail_msg">
@@ -307,6 +307,7 @@ int cil_resolve_avrule(struct cil_tree_node *current, v=
oid *extra_args)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cil_symtab_datum *src_datum =3D NULL;<br=
 class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cil_symtab_datum *tgt_datum =3D NULL;<br=
 class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cil_symtab_datum *permx_datum =3D NULL;<=
br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int used;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc =3D SEPOL_ERR;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (args !=3D NULL) {<br class=3D"gmail_msg">
@@ -318,9 +319,6 @@ int cil_resolve_avrule(struct cil_tree_node *current, v=
oid *extra_args)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rule-&gt;src =3D src_datum;<br class=3D"gmail_m=
sg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rule-&gt;rule_kind !=3D CIL_AVRULE_NEVERALL=
OW) {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(src_d=
atum);<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rule-&gt;tgt_str =3D=3D CIL_KEY_SELF) {<br =
class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rule-&gt;tgt =3D db=
-&gt;selftype;<br class=3D"gmail_msg">
@@ -330,9 +328,10 @@ int cil_resolve_avrule(struct cil_tree_node *current, =
void *extra_args)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto exit;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail=
_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rule-&gt;tgt =3D tg=
t_datum;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rule-&gt;rule_k=
ind !=3D CIL_AVRULE_NEVERALLOW) {<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cil_type_used(tgt_datum);<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail=
_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0used =3D (rule-&gt;=
rule_kind =3D=3D CIL_AVRULE_NEVERALLOW) ?<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0CIL_ATTR_NEVERALLOW : CIL_ATTR_AVRULE;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(src_d=
atum, used); /* src not used if tgt is self */<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(tgt_d=
atum, used);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!rule-&gt;is_extended) {<br class=3D"gmail_=
msg">
@@ -376,14 +375,12 @@ int cil_resolve_type_rule(struct cil_tree_node *curre=
nt, void *extra_args)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rule-&gt;src =3D src_datum;<br class=3D"gmail_m=
sg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(src_datum);<br class=3D"gmail_msg=
">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D cil_resolve_name(current, rule-&gt;tgt_s=
tr, CIL_SYM_TYPES, extra_args, &amp;tgt_datum);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rule-&gt;tgt =3D tgt_datum;<br class=3D"gmail_m=
sg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(tgt_datum);<br class=3D"gmail_msg=
">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D cil_resolve_name(current, rule-&gt;obj_s=
tr, CIL_SYM_CLASSES, extra_args, &amp;obj_datum);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
@@ -589,14 +586,12 @@ int cil_resolve_nametypetransition(struct cil_tree_no=
de *current, void *extra_ar<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 nametypetrans-&gt;src =3D src_datum;<br class=
=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(src_datum);<br class=3D"gmail_msg=
">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D cil_resolve_name(current, nametypetrans-=
&gt;tgt_str, CIL_SYM_TYPES, extra_args, &amp;tgt_datum);<br class=3D"gmail_=
msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 nametypetrans-&gt;tgt =3D tgt_datum;<br class=
=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(tgt_datum);<br class=3D"gmail_msg=
">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D cil_resolve_name(current, nametypetrans-=
&gt;obj_str, CIL_SYM_CLASSES, extra_args, &amp;obj_datum);<br class=3D"gmai=
l_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
@@ -647,14 +642,12 @@ int cil_resolve_rangetransition(struct cil_tree_node =
*current, void *extra_args)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rangetrans-&gt;src =3D src_datum;<br class=3D"g=
mail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(src_datum);<br class=3D"gmail_msg=
">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D cil_resolve_name(current, rangetrans-&gt=
;exec_str, CIL_SYM_TYPES, extra_args, &amp;exec_datum);<br class=3D"gmail_m=
sg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rangetrans-&gt;exec =3D exec_datum;<br class=3D=
"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(exec_datum);<br class=3D"gmail_ms=
g">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D cil_resolve_name(current, rangetrans-&gt=
;obj_str, CIL_SYM_CLASSES, extra_args, &amp;obj_datum);<br class=3D"gmail_m=
sg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
@@ -1006,7 +999,6 @@ int cil_resolve_roletype(struct cil_tree_node *current=
, void *extra_args)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 roletype-&gt;type =3D (struct cil_type*)type_da=
tum;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(type_datum);<br class=3D"gmail_ms=
g">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return SEPOL_OK;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
@@ -1035,7 +1027,6 @@ int cil_resolve_roletransition(struct cil_tree_node *=
current, void *extra_args)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br class=
=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 roletrans-&gt;tgt =3D tgt_datum;<br class=3D"gm=
ail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(tgt_datum);<br class=3D"gmail_msg=
">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D cil_resolve_name(current, roletrans-&gt;=
obj_str, CIL_SYM_CLASSES, extra_args, &amp;obj_datum);<br class=3D"gmail_ms=
g">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc !=3D SEPOL_OK) {<br class=3D"gmail_msg">
@@ -3108,7 +3099,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struc=
t cil_list *str_expr, struc<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (sym_index =3D=3D CIL_SYM_TYPES &amp;&amp; (expr_type =3D=3D =
CIL_CONSTRAIN || expr_type =3D=3D CIL_VALIDATETRANS)) {<br class=3D"gmail_m=
sg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(res_datum);<br class=3D=
"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(res_datum, CIL_ATTR_CON=
STRAINT);<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cil_list_append(*datum_expr, CIL_DATUM, res_datum);<br class=3D"=
gmail_msg">
diff --git a/libsepol/src/<a href=3D"http://libsepol.map.in" rel=3D"norefer=
rer" class=3D"gmail_msg" target=3D"_blank">libsepol.map.in</a> b/libsepol/s=
rc/<a href=3D"http://libsepol.map.in" rel=3D"noreferrer" class=3D"gmail_msg=
" target=3D"_blank">libsepol.map.in</a><br class=3D"gmail_msg">
index 5e68fcb..4042640 100644<br class=3D"gmail_msg">
--- a/libsepol/src/<a href=3D"http://libsepol.map.in" rel=3D"noreferrer" cl=
ass=3D"gmail_msg" target=3D"_blank">libsepol.map.in</a><br class=3D"gmail_m=
sg">
+++ b/libsepol/src/<a href=3D"http://libsepol.map.in" rel=3D"noreferrer" cl=
ass=3D"gmail_msg" target=3D"_blank">libsepol.map.in</a><br class=3D"gmail_m=
sg">
@@ -45,6 +45,8 @@ LIBSEPOL_1.1 {<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cil_set_target_platform;<br class=3D"gmail_msg"=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cil_set_policy_version;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cil_set_mls;<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cil_set_attrs_expand_generated;<br class=3D"gma=
il_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cil_set_attrs_expand_size;<br class=3D"gmail_ms=
g">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cil_write_policy_conf;<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sepol_ppfile_to_module_package;<br class=3D"gma=
il_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sepol_module_package_to_cil;<br class=3D"gmail_=
msg">
--<br class=3D"gmail_msg">
2.7.4<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
Selinux mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:Selinux@tycho.nsa.gov" class=3D"gmail_msg" target=3D"_bla=
nk">Selinux@tycho.nsa.gov</a><br class=3D"gmail_msg">
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" class=3D"gmail_msg" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br=
 class=3D"gmail_msg">
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" class=3D"gmail_msg" target=3D"_blank">Selin=
ux-request@tycho.nsa.gov</a>.<br class=3D"gmail_msg">
</blockquote></div></div></div></div>

--001a11c1662a0aaad2054cfb8715--
