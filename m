Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600F9C74A5B
	for <selinux@archiver.kernel.org>; Tue, 21 Mar 2023 15:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjCUPzO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Mar 2023 11:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjCUPzI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Mar 2023 11:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E15128848
        for <selinux@vger.kernel.org>; Tue, 21 Mar 2023 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679414064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B6flKw6o7hSI07tY5N+XQ/+13wS5mHKyULm4+pnZnHo=;
        b=Wyn3U+ZvqWEIlIhyRYfzBNzX7sI1Hpbnhj5VE5LSkjX2T5quS02RaBcKAi9XAoQr+SYIxS
        cH40qWEvFw3Ty8HbrR/vla53NAZTLtTjQwr+qicV8Y1fRUVY4bj5sCPJPbUlTcbVGjboXK
        b+dxEaE6ZFoNnXlHDdwAWciRUcAfQtw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-yNK6BYfnPC20a4Vjt-K2GA-1; Tue, 21 Mar 2023 11:54:23 -0400
X-MC-Unique: yNK6BYfnPC20a4Vjt-K2GA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A428688B7A0;
        Tue, 21 Mar 2023 15:54:22 +0000 (UTC)
Received: from localhost (unknown [10.45.225.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A42E1121315;
        Tue, 21 Mar 2023 15:54:22 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>,
        Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [RFC PATCH v4 2/6] libsepol/cil: Add notself and minusself
 support to CIL
In-Reply-To: <CAP+JOzTZ22QrP1rONfz0H0twhYDSZGHY_hFt6pvn+zXfhcMT2g@mail.gmail.com>
References: <20221125154952.20910-1-cgzones@googlemail.com>
 <20221125154952.20910-3-cgzones@googlemail.com>
 <CAP+JOzTZ22QrP1rONfz0H0twhYDSZGHY_hFt6pvn+zXfhcMT2g@mail.gmail.com>
Date:   Tue, 21 Mar 2023 16:54:21 +0100
Message-ID: <87r0ti5ccy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Fri, Nov 25, 2022 at 10:50=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
>>
>> From: James Carter <jwcart2@gmail.com>
>>
>> Like "self", both of these reserved words can be used as a target
>> in an access vector rule. "notself" means all types other than
>> the source type. "minuself" is meant to be used with an attribute
>> and its use results in the rule being expanded with each type of
>> the attribute being used as the source type with each of the other
>> types being used as the target type. Using "minusself" with just
>> a type will result in no rule.
>>
>> Example 1
>>   (allow TYPE1 notself (CLASS (PERM)))
>>
>> This rule is expanded to a number of rules with TYPE1 as the source
>> and every type except for TYPE1 as the target.
>>
>> Example 2
>>   (allow ATTR1 notself (CLASS (PERM)))
>>
>> Like Example 1, this rule will be expanded to each type in ATTR1
>> being the source with every type except for the type used as the
>> source being the target.
>>
>> Example 3
>>   (allow TYPE1 minusself (CLASS (PERM)))
>>
>> This expands to no rule.
>>
>> Example 4
>>   (allow ATTR1 minusself (CLASS (PERM)))
>>
>> Like Example 2, but the target types will be limited to the types
>> in the attribute ATTR1 instead of all types. So if ATTR1 has the
>> type t1, t2, and t3, then this rule expands to the following rules.
>>   (allow t1 t2 (CLASS (PERM)))
>>   (allow t1 t3 (CLASS (PERM)))
>>   (allow t2 t1 (CLASS (PERM)))
>>   (allow t2 t3 (CLASS (PERM)))
>>   (allow t3 t1 (CLASS (PERM)))
>>   (allow t3 t2 (CLASS (PERM)))
>>
>> Original patch from James Carter <jwcart2@gmail.com>
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> I am going to send an update of this patch.
> I have come to prefer using "other" rather than "minusself"
> And updated the patch to use ebitmap_is_empty()
>

Other patches were acked. Is it possible to merge them without this?=20

Thanks,

Petr


>
>> ---
>>  libsepol/cil/src/cil.c             |  12 ++
>>  libsepol/cil/src/cil_binary.c      |  91 ++++++++++++-
>>  libsepol/cil/src/cil_build_ast.c   |  10 +-
>>  libsepol/cil/src/cil_find.c        | 206 +++++++++++++++++++++++++----
>>  libsepol/cil/src/cil_internal.h    |   4 +
>>  libsepol/cil/src/cil_resolve_ast.c |   4 +
>>  libsepol/cil/src/cil_verify.c      |   3 +-
>>  7 files changed, 300 insertions(+), 30 deletions(-)
>>
>> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
>> index 38edcf8e..d807a2c4 100644
>> --- a/libsepol/cil/src/cil.c
>> +++ b/libsepol/cil/src/cil.c
>> @@ -84,6 +84,8 @@ char *CIL_KEY_CONS_INCOMP;
>>  char *CIL_KEY_CONDTRUE;
>>  char *CIL_KEY_CONDFALSE;
>>  char *CIL_KEY_SELF;
>> +char *CIL_KEY_NOTSELF;
>> +char *CIL_KEY_MINUSSELF;
>>  char *CIL_KEY_OBJECT_R;
>>  char *CIL_KEY_STAR;
>>  char *CIL_KEY_TCP;
>> @@ -253,6 +255,8 @@ static void cil_init_keys(void)
>>         CIL_KEY_CONDTRUE =3D cil_strpool_add("true");
>>         CIL_KEY_CONDFALSE =3D cil_strpool_add("false");
>>         CIL_KEY_SELF =3D cil_strpool_add("self");
>> +       CIL_KEY_NOTSELF =3D cil_strpool_add("notself");
>> +       CIL_KEY_MINUSSELF =3D cil_strpool_add("minusself");
>>         CIL_KEY_OBJECT_R =3D cil_strpool_add("object_r");
>>         CIL_KEY_STAR =3D cil_strpool_add("*");
>>         CIL_KEY_UDP =3D cil_strpool_add("udp");
>> @@ -430,6 +434,12 @@ void cil_db_init(struct cil_db **db)
>>         cil_type_init(&(*db)->selftype);
>>         (*db)->selftype->datum.name =3D CIL_KEY_SELF;
>>         (*db)->selftype->datum.fqn =3D CIL_KEY_SELF;
>> +       cil_type_init(&(*db)->notselftype);
>> +       (*db)->notselftype->datum.name =3D CIL_KEY_NOTSELF;
>> +       (*db)->notselftype->datum.fqn =3D CIL_KEY_NOTSELF;
>> +       cil_type_init(&(*db)->minusselftype);
>> +       (*db)->minusselftype->datum.name =3D CIL_KEY_MINUSSELF;
>> +       (*db)->minusselftype->datum.fqn =3D CIL_KEY_MINUSSELF;
>>         (*db)->num_types_and_attrs =3D 0;
>>         (*db)->num_classes =3D 0;
>>         (*db)->num_types =3D 0;
>> @@ -483,6 +493,8 @@ void cil_db_destroy(struct cil_db **db)
>>         cil_list_destroy(&(*db)->names, CIL_TRUE);
>>
>>         cil_destroy_type((*db)->selftype);
>> +       cil_destroy_type((*db)->notselftype);
>> +       cil_destroy_type((*db)->minusselftype);
>>
>>         cil_strpool_destroy();
>>         free((*db)->val_to_type);
>> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary=
.c
>> index 40615db2..29b00336 100644
>> --- a/libsepol/cil/src/cil_binary.c
>> +++ b/libsepol/cil/src/cil_binary.c
>> @@ -1519,6 +1519,46 @@ static int __cil_avrule_to_avtab(policydb_t *pdb,=
 const struct cil_db *db, struc
>>                         }
>>                 }
>>                 ebitmap_destroy(&src_bitmap);
>> +       } else if (tgt->fqn =3D=3D CIL_KEY_NOTSELF) {
>> +               rc =3D __cil_expand_type(src, &src_bitmap);
>> +               if (rc !=3D SEPOL_OK) {
>> +                       goto exit;
>> +               }
>> +
>> +               ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
>> +                       src =3D DATUM(db->val_to_type[s]);
>> +                       for (t =3D 0; t < (unsigned int)db->num_types; t=
++) {
>> +                               if (s !=3D t) {
>> +                                       tgt =3D DATUM(db->val_to_type[t]=
);
>> +                                       rc =3D __cil_avrule_expand(pdb, =
kind, src, tgt, classperms, cond_node, cond_flavor);
>> +                                       if (rc !=3D SEPOL_OK) {
>> +                                               ebitmap_destroy(&src_bit=
map);
>> +                                               goto exit;
>> +                                       }
>> +                               }
>> +                       }
>> +               }
>> +               ebitmap_destroy(&src_bitmap);
>> +       } else if (tgt->fqn =3D=3D CIL_KEY_MINUSSELF) {
>> +               rc =3D __cil_expand_type(src, &src_bitmap);
>> +               if (rc !=3D SEPOL_OK) {
>> +                       goto exit;
>> +               }
>> +
>> +               ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
>> +                       src =3D DATUM(db->val_to_type[s]);
>> +                       ebitmap_for_each_positive_bit(&src_bitmap, tnode=
, t) {
>> +                               if (s !=3D t) {
>> +                                       tgt =3D DATUM(db->val_to_type[t]=
);
>> +                                       rc =3D __cil_avrule_expand(pdb, =
kind, src, tgt, classperms, cond_node, cond_flavor);
>> +                                       if (rc !=3D SEPOL_OK) {
>> +                                               ebitmap_destroy(&src_bit=
map);
>> +                                               goto exit;
>> +                                       }
>> +                               }
>> +                       }
>> +               }
>> +               ebitmap_destroy(&src_bitmap);
>>         } else {
>>                 int expand_src =3D __cil_should_expand_attribute(db, src=
);
>>                 int expand_tgt =3D __cil_should_expand_attribute(db, tgt=
);
>> @@ -1875,10 +1915,51 @@ static int cil_avrulex_to_hashtable(policydb_t *=
pdb, const struct cil_db *db, st
>>                         src =3D DATUM(db->val_to_type[s]);
>>                         rc =3D __cil_avrulex_to_hashtable_helper(pdb, ki=
nd, src, src, cil_avrulex->perms.x.permx, args);
>>                         if (rc !=3D SEPOL_OK) {
>> +                               ebitmap_destroy(&src_bitmap);
>>                                 goto exit;
>>                         }
>>                 }
>>                 ebitmap_destroy(&src_bitmap);
>> +       } else if (tgt->fqn =3D=3D CIL_KEY_NOTSELF) {
>> +               rc =3D __cil_expand_type(src, &src_bitmap);
>> +               if (rc !=3D SEPOL_OK) {
>> +                       goto exit;
>> +               }
>> +
>> +               ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
>> +                       src =3D DATUM(db->val_to_type[s]);
>> +                       for (t =3D 0; t < (unsigned int)db->num_types; t=
++) {
>> +                               if (s !=3D t) {
>> +                                       tgt =3D DATUM(db->val_to_type[t]=
);
>> +                                       rc =3D __cil_avrulex_to_hashtabl=
e_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
>> +                                       if (rc !=3D SEPOL_OK) {
>> +                                               ebitmap_destroy(&src_bit=
map);
>> +                                               goto exit;
>> +                                       }
>> +                               }
>> +                       }
>> +               }
>> +               ebitmap_destroy(&src_bitmap);
>> +       } else if (tgt->fqn =3D=3D CIL_KEY_MINUSSELF) {
>> +               rc =3D __cil_expand_type(src, &src_bitmap);
>> +               if (rc !=3D SEPOL_OK) {
>> +                       goto exit;
>> +               }
>> +
>> +               ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
>> +                       src =3D DATUM(db->val_to_type[s]);
>> +                       ebitmap_for_each_positive_bit(&src_bitmap, tnode=
, t) {
>> +                               if (s !=3D t) {
>> +                                       tgt =3D DATUM(db->val_to_type[t]=
);
>> +                                       rc =3D __cil_avrulex_to_hashtabl=
e_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
>> +                                       if (rc !=3D SEPOL_OK) {
>> +                                               ebitmap_destroy(&src_bit=
map);
>> +                                               goto exit;
>> +                                       }
>> +                               }
>> +                       }
>> +               }
>> +               ebitmap_destroy(&src_bitmap);
>>         } else {
>>                 int expand_src =3D __cil_should_expand_attribute(db, src=
);
>>                 int expand_tgt =3D __cil_should_expand_attribute(db, tgt=
);
>> @@ -4813,8 +4894,16 @@ static int cil_check_neverallow(const struct cil_=
db *db, policydb_t *pdb, struct
>>
>>         if (tgt->fqn =3D=3D CIL_KEY_SELF) {
>>                 rule->flags =3D RULE_SELF;
>> +       } else if (tgt->fqn =3D=3D CIL_KEY_NOTSELF) {
>> +               rule->flags =3D RULE_NOTSELF;
>> +       } else if (tgt->fqn =3D=3D CIL_KEY_MINUSSELF) {
>> +               rule->flags =3D RULE_NOTSELF;
>> +               rc =3D __cil_add_sepol_type(pdb, db, cil_rule->src, &rul=
e->ttypes.types);
>> +               if (rc !=3D SEPOL_OK) {
>> +                       goto exit;
>> +               }
>>         } else {
>> -               rc =3D __cil_add_sepol_type(pdb, db, cil_rule->tgt, &rul=
e->ttypes.types);
>> +               rc =3D __cil_add_sepol_type(pdb, db, tgt, &rule->ttypes.=
types);
>>                 if (rc !=3D SEPOL_OK) {
>>                         goto exit;
>>                 }
>> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_bui=
ld_ast.c
>> index 4177c9f6..ca9f80c7 100644
>> --- a/libsepol/cil/src/cil_build_ast.c
>> +++ b/libsepol/cil/src/cil_build_ast.c
>> @@ -3126,9 +3126,13 @@ int cil_gen_aliasactual(struct cil_db *db, struct=
 cil_tree_node *parse_current,
>>                 goto exit;
>>         }
>>
>> -       if ((flavor =3D=3D CIL_TYPEALIAS && parse_current->next->data =
=3D=3D CIL_KEY_SELF) || parse_current->next->next->data =3D=3D CIL_KEY_SELF=
) {
>> -               cil_log(CIL_ERR, "The keyword '%s' is reserved\n", CIL_K=
EY_SELF);
>> -               rc =3D SEPOL_ERR;
>> +       rc =3D cil_verify_name(db, parse_current->next->data, flavor);
>> +       if (rc !=3D SEPOL_OK) {
>> +               goto exit;
>> +       }
>> +
>> +       rc =3D cil_verify_name(db, parse_current->next->next->data, flav=
or);
>> +       if (rc !=3D SEPOL_OK) {
>>                 goto exit;
>>         }
>>
>> diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
>> index 8b755277..1518d33d 100644
>> --- a/libsepol/cil/src/cil_find.c
>> +++ b/libsepol/cil/src/cil_find.c
>> @@ -115,12 +115,13 @@ static int cil_type_matches(ebitmap_t *matches, st=
ruct cil_symtab_datum *d1, str
>>
>>  /* s1 is the src type that is matched with a self
>>   * s2, and t2 are the source and type of the other rule
>> + * Assumes there is a match between s1 and s2
>>   */
>>  static int cil_self_match_any(struct cil_symtab_datum *s1, struct cil_s=
ymtab_datum *s2, struct cil_symtab_datum *t2)
>>  {
>>         int rc;
>> -       struct cil_tree_node *n1 =3D NODE(s1);
>> -       if (n1->flavor !=3D CIL_TYPEATTRIBUTE) {
>> +
>> +       if (FLAVOR(s1) !=3D CIL_TYPEATTRIBUTE) {
>>                 rc =3D cil_type_match_any(s1, t2);
>>         } else {
>>                 struct cil_typeattribute *a =3D (struct cil_typeattribut=
e *)s1;
>> @@ -129,20 +130,149 @@ static int cil_self_match_any(struct cil_symtab_d=
atum *s1, struct cil_symtab_dat
>>                 rc =3D cil_type_matches(&map, s2, t2);
>>                 if (rc < 0) {
>>                         ebitmap_destroy(&map);
>> -                       goto exit;
>> +                       return rc;
>>                 }
>> -               if (map.node =3D=3D NULL) {
>> -                       rc =3D CIL_FALSE;
>> -                       goto exit;
>> +               if (!ebitmap_startnode(&map)) {
>> +                       ebitmap_destroy(&map);
>> +                       return CIL_FALSE;
>>                 }
>>                 rc =3D ebitmap_match_any(&map, a->types);
>>                 ebitmap_destroy(&map);
>>         }
>>
>> -exit:
>>         return rc;
>>  }
>>
>> +/* s1 is the src type that is matched with a notself
>> + * s2 and t2 are the source and type of the other rule
>> + * Assumes there is a match between s1 and s2
>> + */
>> +static int cil_notself_match_any(struct cil_symtab_datum *s1, struct ci=
l_symtab_datum *s2, struct cil_symtab_datum *t2)
>> +{
>> +       int rc;
>> +       ebitmap_node_t *snode, *tnode;
>> +       unsigned int s,t;
>> +
>> +       if (FLAVOR(s1) !=3D CIL_TYPEATTRIBUTE) {
>> +               struct cil_type *ts1 =3D (struct cil_type *)s1;
>> +               if (FLAVOR(t2) !=3D CIL_TYPEATTRIBUTE) {
>> +                       struct cil_type *tt2 =3D (struct cil_type *)t2;
>> +                       if (ts1->value !=3D tt2->value) {
>> +                               return CIL_TRUE;
>> +                       }
>> +               } else {
>> +                       struct cil_typeattribute *at2 =3D (struct cil_ty=
peattribute *)t2;
>> +                       ebitmap_for_each_positive_bit(at2->types, tnode,=
 t) {
>> +                               if (t !=3D (unsigned int)ts1->value) {
>> +                                       return CIL_TRUE;
>> +                               }
>> +                       }
>> +               }
>> +       } else {
>> +               ebitmap_t smap;
>> +               ebitmap_init(&smap);
>> +               rc =3D cil_type_matches(&smap, s1, s2);
>> +               if (rc < 0) {
>> +                       ebitmap_destroy(&smap);
>> +                       return rc;
>> +               }
>> +               if (!ebitmap_startnode(&smap)) {
>> +                       ebitmap_destroy(&smap);
>> +                       return CIL_FALSE;
>> +               }
>> +               if (FLAVOR(t2) !=3D CIL_TYPEATTRIBUTE) {
>> +                       struct cil_type *tt2 =3D (struct cil_type *)t2;
>> +                       ebitmap_for_each_positive_bit(&smap, snode, s) {
>> +                               if (s !=3D (unsigned int)tt2->value) {
>> +                                       ebitmap_destroy(&smap);
>> +                                       return CIL_TRUE;
>> +                               }
>> +                       }
>> +               } else {
>> +                       struct cil_typeattribute *at2 =3D (struct cil_ty=
peattribute *)t2;
>> +                       ebitmap_for_each_positive_bit(&smap, snode, s) {
>> +                               ebitmap_for_each_positive_bit(at2->types=
, tnode, t) {
>> +                                       if (s !=3D t) {
>> +                                               ebitmap_destroy(&smap);
>> +                                               return CIL_TRUE;
>> +                                       }
>> +                               }
>> +                       }
>> +               }
>> +               ebitmap_destroy(&smap);
>> +       }
>> +
>> +       return CIL_FALSE;
>> +}
>> +
>> +/* s1 is the src type that is matched with a minusself
>> + * s2, and t2 are the source and type of the other rule
>> + * Assumes there is a match between s1 and s2
>> + */
>> +static int cil_minusself_match_any(struct cil_symtab_datum *s1, struct =
cil_symtab_datum *s2, struct cil_symtab_datum *t2)
>> +{
>> +       int rc;
>> +
>> +       if (FLAVOR(s1) !=3D CIL_TYPEATTRIBUTE) {
>> +               return CIL_FALSE;
>> +       } else {
>> +               ebitmap_t smap, tmap;
>> +               ebitmap_node_t *snode, *tnode;
>> +               unsigned int s,t;
>> +
>> +               ebitmap_init(&smap);
>> +               rc =3D cil_type_matches(&smap, s1, s2);
>> +               if (rc < 0) {
>> +                       ebitmap_destroy(&smap);
>> +                       return rc;
>> +               }
>> +
>> +               ebitmap_init(&tmap);
>> +               rc =3D cil_type_matches(&tmap, s1, t2);
>> +               if (rc < 0) {
>> +                       ebitmap_destroy(&smap);
>> +                       ebitmap_destroy(&tmap);
>> +                       return rc;
>> +               }
>> +
>> +               if (!ebitmap_startnode(&smap) || !ebitmap_startnode(&tma=
p)) {
>> +                       ebitmap_destroy(&smap);
>> +                       ebitmap_destroy(&tmap);
>> +                       return CIL_FALSE;
>> +               }
>> +
>> +               ebitmap_for_each_positive_bit(&smap, snode, s) {
>> +                       ebitmap_for_each_positive_bit(&tmap, tnode, t) {
>> +                               if (s !=3D t) {
>> +                                       ebitmap_destroy(&smap);
>> +                                       ebitmap_destroy(&tmap);
>> +                                       return CIL_TRUE;
>> +                               }
>> +                       }
>> +               }
>> +
>> +               ebitmap_destroy(&smap);
>> +               ebitmap_destroy(&tmap);
>> +       }
>> +
>> +       return CIL_FALSE;
>> +}
>> +
>> +/* s2 is the src type that is matched with a minusself
>> + * Assumes there is a match between s1 and s2
>> + * s1 is not needed, since it is known that there is a match
>> + */
>> +static int cil_notself_minusself_match_any(struct cil_symtab_datum *s2)
>> +{
>> +       if (FLAVOR(s2) =3D=3D CIL_TYPEATTRIBUTE) {
>> +               struct cil_typeattribute *as2 =3D (struct cil_typeattrib=
ute *)s2;
>> +               if (ebitmap_cardinality(as2->types) > 1) {
>> +                       return CIL_TRUE;
>> +               }
>> +       }
>> +       return CIL_FALSE;
>> +}
>> +
>>  static int cil_classperms_match_any(struct cil_classperms *cp1, struct =
cil_classperms *cp2)
>>  {
>>         struct cil_class *c1 =3D cp1->class;
>> @@ -308,30 +438,56 @@ static int cil_find_matching_avrule(struct cil_tre=
e_node *node, struct cil_avrul
>>
>>         if (!cil_type_match_any(s1, s2)) goto exit;
>>
>> -       if (t1->fqn !=3D CIL_KEY_SELF && t2->fqn !=3D CIL_KEY_SELF) {
>> -               if (!cil_type_match_any(t1, t2)) goto exit;
>> -       } else {
>> -               if (t1->fqn =3D=3D CIL_KEY_SELF && t2->fqn =3D=3D CIL_KE=
Y_SELF) {
>> +       if (t1->fqn =3D=3D CIL_KEY_SELF) {
>> +               if (t2->fqn =3D=3D CIL_KEY_SELF) {
>>                         /* The earlier check whether s1 and s2 matches i=
s all that is needed */
>> -               } else if (t1->fqn =3D=3D CIL_KEY_SELF) {
>> +                       rc =3D CIL_TRUE;
>> +               } else if (t2->fqn =3D=3D CIL_KEY_NOTSELF || t2->fqn =3D=
=3D CIL_KEY_MINUSSELF) {
>> +                       rc =3D CIL_FALSE;
>> +               } else {
>>                         rc =3D cil_self_match_any(s1, s2, t2);
>> -                       if (rc < 0) {
>> -                               goto exit;
>> -                       } else if (rc =3D=3D CIL_FALSE) {
>> -                               rc =3D SEPOL_OK;
>> -                               goto exit;
>> -                       }
>> -               } else if (t2->fqn =3D=3D CIL_KEY_SELF) {
>> +               }
>> +       } else if (t1->fqn =3D=3D CIL_KEY_NOTSELF) {
>> +               if (t2->fqn =3D=3D CIL_KEY_SELF) {
>> +                       rc =3D CIL_FALSE;
>> +               } else if (t2->fqn =3D=3D CIL_KEY_NOTSELF) {
>> +                       /* The earlier check whether s1 and s2 matches i=
s all that is needed */
>> +                       rc =3D CIL_TRUE;
>> +               } else if (t2->fqn =3D=3D CIL_KEY_MINUSSELF) {
>> +                       rc =3D cil_notself_minusself_match_any(s2);
>> +               } else {
>> +                       rc =3D cil_notself_match_any(s1, s2, t2);
>> +               }
>> +       } else if (t1->fqn =3D=3D CIL_KEY_MINUSSELF) {
>> +               if (t2->fqn =3D=3D CIL_KEY_SELF) {
>> +                       rc =3D CIL_FALSE;
>> +               } else if (t2->fqn =3D=3D CIL_KEY_NOTSELF) {
>> +                       rc =3D cil_notself_minusself_match_any(s1);
>> +               } else if (t2->fqn =3D=3D CIL_KEY_MINUSSELF) {
>> +                       /* The earlier check whether s1 and s2 matches i=
s all that is needed */
>> +                       rc =3D CIL_TRUE;
>> +               } else {
>> +                       rc =3D cil_minusself_match_any(s1, s2, t2);
>> +               }
>> +       } else {
>> +               if (t2->fqn =3D=3D CIL_KEY_SELF) {
>>                         rc =3D cil_self_match_any(s2, s1, t1);
>> -                       if (rc < 0) {
>> -                               goto exit;
>> -                       } else if (rc =3D=3D CIL_FALSE) {
>> -                               rc =3D SEPOL_OK;
>> -                               goto exit;
>> -                       }
>> +               } else if (t2->fqn =3D=3D CIL_KEY_NOTSELF) {
>> +                       rc =3D cil_notself_match_any(s2, s1, t1);
>> +               } else if (t2->fqn =3D=3D CIL_KEY_MINUSSELF) {
>> +                       rc =3D cil_minusself_match_any(s2, s1, t1);
>> +               } else {
>> +                       rc =3D cil_type_match_any(t1, t2);
>>                 }
>>         }
>>
>> +       if (rc < 0) {
>> +               goto exit;
>> +       } else if (rc =3D=3D CIL_FALSE) {
>> +               rc =3D SEPOL_OK;
>> +               goto exit;
>> +       }
>> +
>>         if (!target->is_extended) {
>>                 if (cil_classperms_list_match_any(avrule->perms.classper=
ms, target->perms.classperms)) {
>>                         cil_list_append(matching, CIL_NODE, node);
>> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_inte=
rnal.h
>> index a7604762..d293b9ba 100644
>> --- a/libsepol/cil/src/cil_internal.h
>> +++ b/libsepol/cil/src/cil_internal.h
>> @@ -101,6 +101,8 @@ extern char *CIL_KEY_CONS_INCOMP;
>>  extern char *CIL_KEY_CONDTRUE;
>>  extern char *CIL_KEY_CONDFALSE;
>>  extern char *CIL_KEY_SELF;
>> +extern char *CIL_KEY_NOTSELF;
>> +extern char *CIL_KEY_MINUSSELF;
>>  extern char *CIL_KEY_OBJECT_R;
>>  extern char *CIL_KEY_STAR;
>>  extern char *CIL_KEY_TCP;
>> @@ -289,6 +291,8 @@ struct cil_db {
>>         struct cil_tree *parse;
>>         struct cil_tree *ast;
>>         struct cil_type *selftype;
>> +       struct cil_type *notselftype;
>> +       struct cil_type *minusselftype;
>>         struct cil_list *sidorder;
>>         struct cil_list *classorder;
>>         struct cil_list *catorder;
>> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_r=
esolve_ast.c
>> index f5e22c97..9065fe09 100644
>> --- a/libsepol/cil/src/cil_resolve_ast.c
>> +++ b/libsepol/cil/src/cil_resolve_ast.c
>> @@ -333,6 +333,10 @@ int cil_resolve_avrule(struct cil_tree_node *curren=
t, void *extra_args)
>>
>>         if (rule->tgt_str =3D=3D CIL_KEY_SELF) {
>>                 rule->tgt =3D db->selftype;
>> +       } else if (rule->tgt_str =3D=3D CIL_KEY_NOTSELF) {
>> +               rule->tgt =3D db->notselftype;
>> +       } else if (rule->tgt_str =3D=3D CIL_KEY_MINUSSELF) {
>> +               rule->tgt =3D db->minusselftype;
>>         } else {
>>                 rc =3D cil_resolve_name(current, rule->tgt_str, CIL_SYM_=
TYPES, args, &tgt_datum);
>>                 if (rc !=3D SEPOL_OK) {
>> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify=
.c
>> index 4640dc59..1706fbf2 100644
>> --- a/libsepol/cil/src/cil_verify.c
>> +++ b/libsepol/cil/src/cil_verify.c
>> @@ -68,7 +68,8 @@ static int __cil_is_reserved_name(const char *name, en=
um cil_flavor flavor)
>>         case CIL_TYPE:
>>         case CIL_TYPEATTRIBUTE:
>>         case CIL_TYPEALIAS:
>> -               if ((name =3D=3D CIL_KEY_ALL) || (name =3D=3D CIL_KEY_SE=
LF))
>> +               if ((name =3D=3D CIL_KEY_ALL) || (name =3D=3D CIL_KEY_SE=
LF) || (name =3D=3D CIL_KEY_NOTSELF)
>> +                       || (name =3D=3D CIL_KEY_MINUSSELF))
>>                         return CIL_TRUE;
>>                 break;
>>         case CIL_CAT:
>> --
>> 2.38.1
>>

