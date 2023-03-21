Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5973C6FD1D
	for <selinux@archiver.kernel.org>; Tue, 21 Mar 2023 17:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCURng (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCURnf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Mar 2023 13:43:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570D244A5
        for <selinux@vger.kernel.org>; Tue, 21 Mar 2023 10:43:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r11so62882989edd.5
        for <selinux@vger.kernel.org>; Tue, 21 Mar 2023 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679420590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1HyrlbeFHokAnAdlq+pDzsx36/4vYtedwcX2HA5Cuc=;
        b=lcfhWvFAhkcvZzxlCTfpjWO8KHiIPECMOvZ7AOxO2hZH7iVukBlcUnwVIQl/sOybTO
         bq0Zf29wU10OEuzkmNWjihjQpgvBoFHBvYJvvb4Y0ICzCjZo6xgOvc0uZwTmcdoJFHqi
         RwDhArUiX+JBSTBVc6SQ8ZvRrhmtlNlCAxb/jrMfp5jMNJtbJ8UyP0d7joc2yTsWdNSS
         yzJY7SjGTN6ztXDrdcdslyvqZDjhJDz0ShEVXKJBFiyA4s1GidXQLO4H92JEQDo6KMrc
         nSjAdzZ/C67EoKZaEDouqVVdygS2bCoNUXKeNDjjMxdjEAqpetrPBBWhxJ6wBaxyYmtL
         GisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679420590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1HyrlbeFHokAnAdlq+pDzsx36/4vYtedwcX2HA5Cuc=;
        b=Q738hzVTmYTtA6/3r02JNOM2LjH9VGc2D95c0YkrlKh2gQtvz6mxq7rVvzuTnvNp4O
         hszyeq2XGG32OthgRsfybwm+U3ZRRkCpb1V3VZXkq9VGbCV3E24qazf4nqHQD+dMM0rs
         /oK2OfqHIlQgadvYA55+QxKGaR0mXhFvI4b0GRkLiOMflnIIdF7CtVQ48A2LVY4aT94v
         ayKPqEFj/di+jrI7J09GZ9MJgrrUpUWDrJYCm20VoYSindfXfzuaszMKLHMjnaCQR6Kn
         g/m+7jcx+2W9HXiOexDRJn7Z7EgpxQGwDDsNyQ5gVk291HB6KsM1mGzvqMEvxPBoN9p+
         6eDg==
X-Gm-Message-State: AO0yUKW2FTDa2bw/d7MsM9YWgQO+0BhVQZw8TqTJaOzOFhS6/UIZzvVf
        w73lhGlgtvemEmBz4vORAEKIOaJR14eXYzEpSJ4=
X-Google-Smtp-Source: AK7set/6pMjPH3P7sZMoFu7s5DyCjV27eVIMa8JWSgLHoRGXuApEhw1J0FS1IJ3x69w/I68jDTv7g9Wz4x2hMTimkDg=
X-Received: by 2002:a17:906:41b:b0:931:ce20:db96 with SMTP id
 d27-20020a170906041b00b00931ce20db96mr1739970eja.5.1679420590146; Tue, 21 Mar
 2023 10:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221125154952.20910-1-cgzones@googlemail.com>
 <20221125154952.20910-3-cgzones@googlemail.com> <CAP+JOzTZ22QrP1rONfz0H0twhYDSZGHY_hFt6pvn+zXfhcMT2g@mail.gmail.com>
 <87r0ti5ccy.fsf@redhat.com>
In-Reply-To: <87r0ti5ccy.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 21 Mar 2023 13:42:58 -0400
Message-ID: <CAP+JOzRiidEdNGO8K8KprvO86J=0J4xu8MOikCTrzohHSYKCNw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/6] libsepol/cil: Add notself and minusself
 support to CIL
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 21, 2023 at 11:54=E2=80=AFAM Petr Lautrbach <plautrba@redhat.co=
m> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Fri, Nov 25, 2022 at 10:50=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> >>
> >> From: James Carter <jwcart2@gmail.com>
> >>
> >> Like "self", both of these reserved words can be used as a target
> >> in an access vector rule. "notself" means all types other than
> >> the source type. "minuself" is meant to be used with an attribute
> >> and its use results in the rule being expanded with each type of
> >> the attribute being used as the source type with each of the other
> >> types being used as the target type. Using "minusself" with just
> >> a type will result in no rule.
> >>
> >> Example 1
> >>   (allow TYPE1 notself (CLASS (PERM)))
> >>
> >> This rule is expanded to a number of rules with TYPE1 as the source
> >> and every type except for TYPE1 as the target.
> >>
> >> Example 2
> >>   (allow ATTR1 notself (CLASS (PERM)))
> >>
> >> Like Example 1, this rule will be expanded to each type in ATTR1
> >> being the source with every type except for the type used as the
> >> source being the target.
> >>
> >> Example 3
> >>   (allow TYPE1 minusself (CLASS (PERM)))
> >>
> >> This expands to no rule.
> >>
> >> Example 4
> >>   (allow ATTR1 minusself (CLASS (PERM)))
> >>
> >> Like Example 2, but the target types will be limited to the types
> >> in the attribute ATTR1 instead of all types. So if ATTR1 has the
> >> type t1, t2, and t3, then this rule expands to the following rules.
> >>   (allow t1 t2 (CLASS (PERM)))
> >>   (allow t1 t3 (CLASS (PERM)))
> >>   (allow t2 t1 (CLASS (PERM)))
> >>   (allow t2 t3 (CLASS (PERM)))
> >>   (allow t3 t1 (CLASS (PERM)))
> >>   (allow t3 t2 (CLASS (PERM)))
> >>
> >> Original patch from James Carter <jwcart2@gmail.com>
> >>
> >> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > I am going to send an update of this patch.
> > I have come to prefer using "other" rather than "minusself"
> > And updated the patch to use ebitmap_is_empty()
> >
>
> Other patches were acked. Is it possible to merge them without this?
>
> Thanks,
>
> Petr
>

Yes, they can be merged at any time.
Thanks,
Jim

>
> >
> >> ---
> >>  libsepol/cil/src/cil.c             |  12 ++
> >>  libsepol/cil/src/cil_binary.c      |  91 ++++++++++++-
> >>  libsepol/cil/src/cil_build_ast.c   |  10 +-
> >>  libsepol/cil/src/cil_find.c        | 206 +++++++++++++++++++++++++---=
-
> >>  libsepol/cil/src/cil_internal.h    |   4 +
> >>  libsepol/cil/src/cil_resolve_ast.c |   4 +
> >>  libsepol/cil/src/cil_verify.c      |   3 +-
> >>  7 files changed, 300 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> >> index 38edcf8e..d807a2c4 100644
> >> --- a/libsepol/cil/src/cil.c
> >> +++ b/libsepol/cil/src/cil.c
> >> @@ -84,6 +84,8 @@ char *CIL_KEY_CONS_INCOMP;
> >>  char *CIL_KEY_CONDTRUE;
> >>  char *CIL_KEY_CONDFALSE;
> >>  char *CIL_KEY_SELF;
> >> +char *CIL_KEY_NOTSELF;
> >> +char *CIL_KEY_MINUSSELF;
> >>  char *CIL_KEY_OBJECT_R;
> >>  char *CIL_KEY_STAR;
> >>  char *CIL_KEY_TCP;
> >> @@ -253,6 +255,8 @@ static void cil_init_keys(void)
> >>         CIL_KEY_CONDTRUE =3D cil_strpool_add("true");
> >>         CIL_KEY_CONDFALSE =3D cil_strpool_add("false");
> >>         CIL_KEY_SELF =3D cil_strpool_add("self");
> >> +       CIL_KEY_NOTSELF =3D cil_strpool_add("notself");
> >> +       CIL_KEY_MINUSSELF =3D cil_strpool_add("minusself");
> >>         CIL_KEY_OBJECT_R =3D cil_strpool_add("object_r");
> >>         CIL_KEY_STAR =3D cil_strpool_add("*");
> >>         CIL_KEY_UDP =3D cil_strpool_add("udp");
> >> @@ -430,6 +434,12 @@ void cil_db_init(struct cil_db **db)
> >>         cil_type_init(&(*db)->selftype);
> >>         (*db)->selftype->datum.name =3D CIL_KEY_SELF;
> >>         (*db)->selftype->datum.fqn =3D CIL_KEY_SELF;
> >> +       cil_type_init(&(*db)->notselftype);
> >> +       (*db)->notselftype->datum.name =3D CIL_KEY_NOTSELF;
> >> +       (*db)->notselftype->datum.fqn =3D CIL_KEY_NOTSELF;
> >> +       cil_type_init(&(*db)->minusselftype);
> >> +       (*db)->minusselftype->datum.name =3D CIL_KEY_MINUSSELF;
> >> +       (*db)->minusselftype->datum.fqn =3D CIL_KEY_MINUSSELF;
> >>         (*db)->num_types_and_attrs =3D 0;
> >>         (*db)->num_classes =3D 0;
> >>         (*db)->num_types =3D 0;
> >> @@ -483,6 +493,8 @@ void cil_db_destroy(struct cil_db **db)
> >>         cil_list_destroy(&(*db)->names, CIL_TRUE);
> >>
> >>         cil_destroy_type((*db)->selftype);
> >> +       cil_destroy_type((*db)->notselftype);
> >> +       cil_destroy_type((*db)->minusselftype);
> >>
> >>         cil_strpool_destroy();
> >>         free((*db)->val_to_type);
> >> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_bina=
ry.c
> >> index 40615db2..29b00336 100644
> >> --- a/libsepol/cil/src/cil_binary.c
> >> +++ b/libsepol/cil/src/cil_binary.c
> >> @@ -1519,6 +1519,46 @@ static int __cil_avrule_to_avtab(policydb_t *pd=
b, const struct cil_db *db, struc
> >>                         }
> >>                 }
> >>                 ebitmap_destroy(&src_bitmap);
> >> +       } else if (tgt->fqn =3D=3D CIL_KEY_NOTSELF) {
> >> +               rc =3D __cil_expand_type(src, &src_bitmap);
> >> +               if (rc !=3D SEPOL_OK) {
> >> +                       goto exit;
> >> +               }
> >> +
> >> +               ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
> >> +                       src =3D DATUM(db->val_to_type[s]);
> >> +                       for (t =3D 0; t < (unsigned int)db->num_types;=
 t++) {
> >> +                               if (s !=3D t) {
> >> +                                       tgt =3D DATUM(db->val_to_type[=
t]);
> >> +                                       rc =3D __cil_avrule_expand(pdb=
, kind, src, tgt, classperms, cond_node, cond_flavor);
> >> +                                       if (rc !=3D SEPOL_OK) {
> >> +                                               ebitmap_destroy(&src_b=
itmap);
> >> +                                               goto exit;
> >> +                                       }
> >> +                               }
> >> +                       }
> >> +               }
> >> +               ebitmap_destroy(&src_bitmap);
> >> +       } else if (tgt->fqn =3D=3D CIL_KEY_MINUSSELF) {
> >> +               rc =3D __cil_expand_type(src, &src_bitmap);
> >> +               if (rc !=3D SEPOL_OK) {
> >> +                       goto exit;
> >> +               }
> >> +
> >> +               ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
> >> +                       src =3D DATUM(db->val_to_type[s]);
> >> +                       ebitmap_for_each_positive_bit(&src_bitmap, tno=
de, t) {
> >> +                               if (s !=3D t) {
> >> +                                       tgt =3D DATUM(db->val_to_type[=
t]);
> >> +                                       rc =3D __cil_avrule_expand(pdb=
, kind, src, tgt, classperms, cond_node, cond_flavor);
> >> +                                       if (rc !=3D SEPOL_OK) {
> >> +                                               ebitmap_destroy(&src_b=
itmap);
> >> +                                               goto exit;
> >> +                                       }
> >> +                               }
> >> +                       }
> >> +               }
> >> +               ebitmap_destroy(&src_bitmap);
> >>         } else {
> >>                 int expand_src =3D __cil_should_expand_attribute(db, s=
rc);
> >>                 int expand_tgt =3D __cil_should_expand_attribute(db, t=
gt);
> >> @@ -1875,10 +1915,51 @@ static int cil_avrulex_to_hashtable(policydb_t=
 *pdb, const struct cil_db *db, st
> >>                         src =3D DATUM(db->val_to_type[s]);
> >>                         rc =3D __cil_avrulex_to_hashtable_helper(pdb, =
kind, src, src, cil_avrulex->perms.x.permx, args);
> >>                         if (rc !=3D SEPOL_OK) {
> >> +                               ebitmap_destroy(&src_bitmap);
> >>                                 goto exit;
> >>                         }
> >>                 }
> >>                 ebitmap_destroy(&src_bitmap);
> >> +       } else if (tgt->fqn =3D=3D CIL_KEY_NOTSELF) {
> >> +               rc =3D __cil_expand_type(src, &src_bitmap);
> >> +               if (rc !=3D SEPOL_OK) {
> >> +                       goto exit;
> >> +               }
> >> +
> >> +               ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
> >> +                       src =3D DATUM(db->val_to_type[s]);
> >> +                       for (t =3D 0; t < (unsigned int)db->num_types;=
 t++) {
> >> +                               if (s !=3D t) {
> >> +                                       tgt =3D DATUM(db->val_to_type[=
t]);
> >> +                                       rc =3D __cil_avrulex_to_hashta=
ble_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
> >> +                                       if (rc !=3D SEPOL_OK) {
> >> +                                               ebitmap_destroy(&src_b=
itmap);
> >> +                                               goto exit;
> >> +                                       }
> >> +                               }
> >> +                       }
> >> +               }
> >> +               ebitmap_destroy(&src_bitmap);
> >> +       } else if (tgt->fqn =3D=3D CIL_KEY_MINUSSELF) {
> >> +               rc =3D __cil_expand_type(src, &src_bitmap);
> >> +               if (rc !=3D SEPOL_OK) {
> >> +                       goto exit;
> >> +               }
> >> +
> >> +               ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
> >> +                       src =3D DATUM(db->val_to_type[s]);
> >> +                       ebitmap_for_each_positive_bit(&src_bitmap, tno=
de, t) {
> >> +                               if (s !=3D t) {
> >> +                                       tgt =3D DATUM(db->val_to_type[=
t]);
> >> +                                       rc =3D __cil_avrulex_to_hashta=
ble_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
> >> +                                       if (rc !=3D SEPOL_OK) {
> >> +                                               ebitmap_destroy(&src_b=
itmap);
> >> +                                               goto exit;
> >> +                                       }
> >> +                               }
> >> +                       }
> >> +               }
> >> +               ebitmap_destroy(&src_bitmap);
> >>         } else {
> >>                 int expand_src =3D __cil_should_expand_attribute(db, s=
rc);
> >>                 int expand_tgt =3D __cil_should_expand_attribute(db, t=
gt);
> >> @@ -4813,8 +4894,16 @@ static int cil_check_neverallow(const struct ci=
l_db *db, policydb_t *pdb, struct
> >>
> >>         if (tgt->fqn =3D=3D CIL_KEY_SELF) {
> >>                 rule->flags =3D RULE_SELF;
> >> +       } else if (tgt->fqn =3D=3D CIL_KEY_NOTSELF) {
> >> +               rule->flags =3D RULE_NOTSELF;
> >> +       } else if (tgt->fqn =3D=3D CIL_KEY_MINUSSELF) {
> >> +               rule->flags =3D RULE_NOTSELF;
> >> +               rc =3D __cil_add_sepol_type(pdb, db, cil_rule->src, &r=
ule->ttypes.types);
> >> +               if (rc !=3D SEPOL_OK) {
> >> +                       goto exit;
> >> +               }
> >>         } else {
> >> -               rc =3D __cil_add_sepol_type(pdb, db, cil_rule->tgt, &r=
ule->ttypes.types);
> >> +               rc =3D __cil_add_sepol_type(pdb, db, tgt, &rule->ttype=
s.types);
> >>                 if (rc !=3D SEPOL_OK) {
> >>                         goto exit;
> >>                 }
> >> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_b=
uild_ast.c
> >> index 4177c9f6..ca9f80c7 100644
> >> --- a/libsepol/cil/src/cil_build_ast.c
> >> +++ b/libsepol/cil/src/cil_build_ast.c
> >> @@ -3126,9 +3126,13 @@ int cil_gen_aliasactual(struct cil_db *db, stru=
ct cil_tree_node *parse_current,
> >>                 goto exit;
> >>         }
> >>
> >> -       if ((flavor =3D=3D CIL_TYPEALIAS && parse_current->next->data =
=3D=3D CIL_KEY_SELF) || parse_current->next->next->data =3D=3D CIL_KEY_SELF=
) {
> >> -               cil_log(CIL_ERR, "The keyword '%s' is reserved\n", CIL=
_KEY_SELF);
> >> -               rc =3D SEPOL_ERR;
> >> +       rc =3D cil_verify_name(db, parse_current->next->data, flavor);
> >> +       if (rc !=3D SEPOL_OK) {
> >> +               goto exit;
> >> +       }
> >> +
> >> +       rc =3D cil_verify_name(db, parse_current->next->next->data, fl=
avor);
> >> +       if (rc !=3D SEPOL_OK) {
> >>                 goto exit;
> >>         }
> >>
> >> diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
> >> index 8b755277..1518d33d 100644
> >> --- a/libsepol/cil/src/cil_find.c
> >> +++ b/libsepol/cil/src/cil_find.c
> >> @@ -115,12 +115,13 @@ static int cil_type_matches(ebitmap_t *matches, =
struct cil_symtab_datum *d1, str
> >>
> >>  /* s1 is the src type that is matched with a self
> >>   * s2, and t2 are the source and type of the other rule
> >> + * Assumes there is a match between s1 and s2
> >>   */
> >>  static int cil_self_match_any(struct cil_symtab_datum *s1, struct cil=
_symtab_datum *s2, struct cil_symtab_datum *t2)
> >>  {
> >>         int rc;
> >> -       struct cil_tree_node *n1 =3D NODE(s1);
> >> -       if (n1->flavor !=3D CIL_TYPEATTRIBUTE) {
> >> +
> >> +       if (FLAVOR(s1) !=3D CIL_TYPEATTRIBUTE) {
> >>                 rc =3D cil_type_match_any(s1, t2);
> >>         } else {
> >>                 struct cil_typeattribute *a =3D (struct cil_typeattrib=
ute *)s1;
> >> @@ -129,20 +130,149 @@ static int cil_self_match_any(struct cil_symtab=
_datum *s1, struct cil_symtab_dat
> >>                 rc =3D cil_type_matches(&map, s2, t2);
> >>                 if (rc < 0) {
> >>                         ebitmap_destroy(&map);
> >> -                       goto exit;
> >> +                       return rc;
> >>                 }
> >> -               if (map.node =3D=3D NULL) {
> >> -                       rc =3D CIL_FALSE;
> >> -                       goto exit;
> >> +               if (!ebitmap_startnode(&map)) {
> >> +                       ebitmap_destroy(&map);
> >> +                       return CIL_FALSE;
> >>                 }
> >>                 rc =3D ebitmap_match_any(&map, a->types);
> >>                 ebitmap_destroy(&map);
> >>         }
> >>
> >> -exit:
> >>         return rc;
> >>  }
> >>
> >> +/* s1 is the src type that is matched with a notself
> >> + * s2 and t2 are the source and type of the other rule
> >> + * Assumes there is a match between s1 and s2
> >> + */
> >> +static int cil_notself_match_any(struct cil_symtab_datum *s1, struct =
cil_symtab_datum *s2, struct cil_symtab_datum *t2)
> >> +{
> >> +       int rc;
> >> +       ebitmap_node_t *snode, *tnode;
> >> +       unsigned int s,t;
> >> +
> >> +       if (FLAVOR(s1) !=3D CIL_TYPEATTRIBUTE) {
> >> +               struct cil_type *ts1 =3D (struct cil_type *)s1;
> >> +               if (FLAVOR(t2) !=3D CIL_TYPEATTRIBUTE) {
> >> +                       struct cil_type *tt2 =3D (struct cil_type *)t2=
;
> >> +                       if (ts1->value !=3D tt2->value) {
> >> +                               return CIL_TRUE;
> >> +                       }
> >> +               } else {
> >> +                       struct cil_typeattribute *at2 =3D (struct cil_=
typeattribute *)t2;
> >> +                       ebitmap_for_each_positive_bit(at2->types, tnod=
e, t) {
> >> +                               if (t !=3D (unsigned int)ts1->value) {
> >> +                                       return CIL_TRUE;
> >> +                               }
> >> +                       }
> >> +               }
> >> +       } else {
> >> +               ebitmap_t smap;
> >> +               ebitmap_init(&smap);
> >> +               rc =3D cil_type_matches(&smap, s1, s2);
> >> +               if (rc < 0) {
> >> +                       ebitmap_destroy(&smap);
> >> +                       return rc;
> >> +               }
> >> +               if (!ebitmap_startnode(&smap)) {
> >> +                       ebitmap_destroy(&smap);
> >> +                       return CIL_FALSE;
> >> +               }
> >> +               if (FLAVOR(t2) !=3D CIL_TYPEATTRIBUTE) {
> >> +                       struct cil_type *tt2 =3D (struct cil_type *)t2=
;
> >> +                       ebitmap_for_each_positive_bit(&smap, snode, s)=
 {
> >> +                               if (s !=3D (unsigned int)tt2->value) {
> >> +                                       ebitmap_destroy(&smap);
> >> +                                       return CIL_TRUE;
> >> +                               }
> >> +                       }
> >> +               } else {
> >> +                       struct cil_typeattribute *at2 =3D (struct cil_=
typeattribute *)t2;
> >> +                       ebitmap_for_each_positive_bit(&smap, snode, s)=
 {
> >> +                               ebitmap_for_each_positive_bit(at2->typ=
es, tnode, t) {
> >> +                                       if (s !=3D t) {
> >> +                                               ebitmap_destroy(&smap)=
;
> >> +                                               return CIL_TRUE;
> >> +                                       }
> >> +                               }
> >> +                       }
> >> +               }
> >> +               ebitmap_destroy(&smap);
> >> +       }
> >> +
> >> +       return CIL_FALSE;
> >> +}
> >> +
> >> +/* s1 is the src type that is matched with a minusself
> >> + * s2, and t2 are the source and type of the other rule
> >> + * Assumes there is a match between s1 and s2
> >> + */
> >> +static int cil_minusself_match_any(struct cil_symtab_datum *s1, struc=
t cil_symtab_datum *s2, struct cil_symtab_datum *t2)
> >> +{
> >> +       int rc;
> >> +
> >> +       if (FLAVOR(s1) !=3D CIL_TYPEATTRIBUTE) {
> >> +               return CIL_FALSE;
> >> +       } else {
> >> +               ebitmap_t smap, tmap;
> >> +               ebitmap_node_t *snode, *tnode;
> >> +               unsigned int s,t;
> >> +
> >> +               ebitmap_init(&smap);
> >> +               rc =3D cil_type_matches(&smap, s1, s2);
> >> +               if (rc < 0) {
> >> +                       ebitmap_destroy(&smap);
> >> +                       return rc;
> >> +               }
> >> +
> >> +               ebitmap_init(&tmap);
> >> +               rc =3D cil_type_matches(&tmap, s1, t2);
> >> +               if (rc < 0) {
> >> +                       ebitmap_destroy(&smap);
> >> +                       ebitmap_destroy(&tmap);
> >> +                       return rc;
> >> +               }
> >> +
> >> +               if (!ebitmap_startnode(&smap) || !ebitmap_startnode(&t=
map)) {
> >> +                       ebitmap_destroy(&smap);
> >> +                       ebitmap_destroy(&tmap);
> >> +                       return CIL_FALSE;
> >> +               }
> >> +
> >> +               ebitmap_for_each_positive_bit(&smap, snode, s) {
> >> +                       ebitmap_for_each_positive_bit(&tmap, tnode, t)=
 {
> >> +                               if (s !=3D t) {
> >> +                                       ebitmap_destroy(&smap);
> >> +                                       ebitmap_destroy(&tmap);
> >> +                                       return CIL_TRUE;
> >> +                               }
> >> +                       }
> >> +               }
> >> +
> >> +               ebitmap_destroy(&smap);
> >> +               ebitmap_destroy(&tmap);
> >> +       }
> >> +
> >> +       return CIL_FALSE;
> >> +}
> >> +
> >> +/* s2 is the src type that is matched with a minusself
> >> + * Assumes there is a match between s1 and s2
> >> + * s1 is not needed, since it is known that there is a match
> >> + */
> >> +static int cil_notself_minusself_match_any(struct cil_symtab_datum *s=
2)
> >> +{
> >> +       if (FLAVOR(s2) =3D=3D CIL_TYPEATTRIBUTE) {
> >> +               struct cil_typeattribute *as2 =3D (struct cil_typeattr=
ibute *)s2;
> >> +               if (ebitmap_cardinality(as2->types) > 1) {
> >> +                       return CIL_TRUE;
> >> +               }
> >> +       }
> >> +       return CIL_FALSE;
> >> +}
> >> +
> >>  static int cil_classperms_match_any(struct cil_classperms *cp1, struc=
t cil_classperms *cp2)
> >>  {
> >>         struct cil_class *c1 =3D cp1->class;
> >> @@ -308,30 +438,56 @@ static int cil_find_matching_avrule(struct cil_t=
ree_node *node, struct cil_avrul
> >>
> >>         if (!cil_type_match_any(s1, s2)) goto exit;
> >>
> >> -       if (t1->fqn !=3D CIL_KEY_SELF && t2->fqn !=3D CIL_KEY_SELF) {
> >> -               if (!cil_type_match_any(t1, t2)) goto exit;
> >> -       } else {
> >> -               if (t1->fqn =3D=3D CIL_KEY_SELF && t2->fqn =3D=3D CIL_=
KEY_SELF) {
> >> +       if (t1->fqn =3D=3D CIL_KEY_SELF) {
> >> +               if (t2->fqn =3D=3D CIL_KEY_SELF) {
> >>                         /* The earlier check whether s1 and s2 matches=
 is all that is needed */
> >> -               } else if (t1->fqn =3D=3D CIL_KEY_SELF) {
> >> +                       rc =3D CIL_TRUE;
> >> +               } else if (t2->fqn =3D=3D CIL_KEY_NOTSELF || t2->fqn =
=3D=3D CIL_KEY_MINUSSELF) {
> >> +                       rc =3D CIL_FALSE;
> >> +               } else {
> >>                         rc =3D cil_self_match_any(s1, s2, t2);
> >> -                       if (rc < 0) {
> >> -                               goto exit;
> >> -                       } else if (rc =3D=3D CIL_FALSE) {
> >> -                               rc =3D SEPOL_OK;
> >> -                               goto exit;
> >> -                       }
> >> -               } else if (t2->fqn =3D=3D CIL_KEY_SELF) {
> >> +               }
> >> +       } else if (t1->fqn =3D=3D CIL_KEY_NOTSELF) {
> >> +               if (t2->fqn =3D=3D CIL_KEY_SELF) {
> >> +                       rc =3D CIL_FALSE;
> >> +               } else if (t2->fqn =3D=3D CIL_KEY_NOTSELF) {
> >> +                       /* The earlier check whether s1 and s2 matches=
 is all that is needed */
> >> +                       rc =3D CIL_TRUE;
> >> +               } else if (t2->fqn =3D=3D CIL_KEY_MINUSSELF) {
> >> +                       rc =3D cil_notself_minusself_match_any(s2);
> >> +               } else {
> >> +                       rc =3D cil_notself_match_any(s1, s2, t2);
> >> +               }
> >> +       } else if (t1->fqn =3D=3D CIL_KEY_MINUSSELF) {
> >> +               if (t2->fqn =3D=3D CIL_KEY_SELF) {
> >> +                       rc =3D CIL_FALSE;
> >> +               } else if (t2->fqn =3D=3D CIL_KEY_NOTSELF) {
> >> +                       rc =3D cil_notself_minusself_match_any(s1);
> >> +               } else if (t2->fqn =3D=3D CIL_KEY_MINUSSELF) {
> >> +                       /* The earlier check whether s1 and s2 matches=
 is all that is needed */
> >> +                       rc =3D CIL_TRUE;
> >> +               } else {
> >> +                       rc =3D cil_minusself_match_any(s1, s2, t2);
> >> +               }
> >> +       } else {
> >> +               if (t2->fqn =3D=3D CIL_KEY_SELF) {
> >>                         rc =3D cil_self_match_any(s2, s1, t1);
> >> -                       if (rc < 0) {
> >> -                               goto exit;
> >> -                       } else if (rc =3D=3D CIL_FALSE) {
> >> -                               rc =3D SEPOL_OK;
> >> -                               goto exit;
> >> -                       }
> >> +               } else if (t2->fqn =3D=3D CIL_KEY_NOTSELF) {
> >> +                       rc =3D cil_notself_match_any(s2, s1, t1);
> >> +               } else if (t2->fqn =3D=3D CIL_KEY_MINUSSELF) {
> >> +                       rc =3D cil_minusself_match_any(s2, s1, t1);
> >> +               } else {
> >> +                       rc =3D cil_type_match_any(t1, t2);
> >>                 }
> >>         }
> >>
> >> +       if (rc < 0) {
> >> +               goto exit;
> >> +       } else if (rc =3D=3D CIL_FALSE) {
> >> +               rc =3D SEPOL_OK;
> >> +               goto exit;
> >> +       }
> >> +
> >>         if (!target->is_extended) {
> >>                 if (cil_classperms_list_match_any(avrule->perms.classp=
erms, target->perms.classperms)) {
> >>                         cil_list_append(matching, CIL_NODE, node);
> >> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_in=
ternal.h
> >> index a7604762..d293b9ba 100644
> >> --- a/libsepol/cil/src/cil_internal.h
> >> +++ b/libsepol/cil/src/cil_internal.h
> >> @@ -101,6 +101,8 @@ extern char *CIL_KEY_CONS_INCOMP;
> >>  extern char *CIL_KEY_CONDTRUE;
> >>  extern char *CIL_KEY_CONDFALSE;
> >>  extern char *CIL_KEY_SELF;
> >> +extern char *CIL_KEY_NOTSELF;
> >> +extern char *CIL_KEY_MINUSSELF;
> >>  extern char *CIL_KEY_OBJECT_R;
> >>  extern char *CIL_KEY_STAR;
> >>  extern char *CIL_KEY_TCP;
> >> @@ -289,6 +291,8 @@ struct cil_db {
> >>         struct cil_tree *parse;
> >>         struct cil_tree *ast;
> >>         struct cil_type *selftype;
> >> +       struct cil_type *notselftype;
> >> +       struct cil_type *minusselftype;
> >>         struct cil_list *sidorder;
> >>         struct cil_list *classorder;
> >>         struct cil_list *catorder;
> >> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil=
_resolve_ast.c
> >> index f5e22c97..9065fe09 100644
> >> --- a/libsepol/cil/src/cil_resolve_ast.c
> >> +++ b/libsepol/cil/src/cil_resolve_ast.c
> >> @@ -333,6 +333,10 @@ int cil_resolve_avrule(struct cil_tree_node *curr=
ent, void *extra_args)
> >>
> >>         if (rule->tgt_str =3D=3D CIL_KEY_SELF) {
> >>                 rule->tgt =3D db->selftype;
> >> +       } else if (rule->tgt_str =3D=3D CIL_KEY_NOTSELF) {
> >> +               rule->tgt =3D db->notselftype;
> >> +       } else if (rule->tgt_str =3D=3D CIL_KEY_MINUSSELF) {
> >> +               rule->tgt =3D db->minusselftype;
> >>         } else {
> >>                 rc =3D cil_resolve_name(current, rule->tgt_str, CIL_SY=
M_TYPES, args, &tgt_datum);
> >>                 if (rc !=3D SEPOL_OK) {
> >> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_veri=
fy.c
> >> index 4640dc59..1706fbf2 100644
> >> --- a/libsepol/cil/src/cil_verify.c
> >> +++ b/libsepol/cil/src/cil_verify.c
> >> @@ -68,7 +68,8 @@ static int __cil_is_reserved_name(const char *name, =
enum cil_flavor flavor)
> >>         case CIL_TYPE:
> >>         case CIL_TYPEATTRIBUTE:
> >>         case CIL_TYPEALIAS:
> >> -               if ((name =3D=3D CIL_KEY_ALL) || (name =3D=3D CIL_KEY_=
SELF))
> >> +               if ((name =3D=3D CIL_KEY_ALL) || (name =3D=3D CIL_KEY_=
SELF) || (name =3D=3D CIL_KEY_NOTSELF)
> >> +                       || (name =3D=3D CIL_KEY_MINUSSELF))
> >>                         return CIL_TRUE;
> >>                 break;
> >>         case CIL_CAT:
> >> --
> >> 2.38.1
> >>
>
