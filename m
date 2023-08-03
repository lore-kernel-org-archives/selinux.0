Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9970DC001DF
	for <selinux@archiver.kernel.org>; Thu,  3 Aug 2023 20:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjHCUen (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 16:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHCUen (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 16:34:43 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076872D5A
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 13:34:41 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so21317891fa.1
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691094879; x=1691699679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ib0PKJT4//XjXFUKuCz26kYMtF6s0WUHzQsISgNwW7I=;
        b=jmfb7p9dbND0WKv9zPca7BWzcin7SWcaXdUlHiL9k0U4XDxO84bhbNF1nD9LBhlgbt
         nmRUcyuFt4Coqipvad7FJRQAMuk4NLDadon6t+b3NgavsnPaVFQ3iTqfbQVFqV+z1Fg8
         A3MItTEzw0UPusKwhnApmT9xPzqIc5+R2abvSmo5m1Fhf4bBGyHEhzIE3kBSslJJA+xw
         AqumSpsGhkd+iRwHh+xasselya+lxXcyegPelOFfBaTrS4h2WUnopcEYbaI1irvXb1pN
         wUvFhYrfjPelphRyehxyyyi6rTlpZ2q+wfHR3XB5V0uSR2KxU0tg0rMG6NTFq4kT92eo
         TWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691094879; x=1691699679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ib0PKJT4//XjXFUKuCz26kYMtF6s0WUHzQsISgNwW7I=;
        b=gSpt6/H+8nN+JPnk8iTOKdZpHECCcKGdRk8bbGBDep3hWxPLsgJYg960j7UXj1HH2E
         EhWz84ZRZYqkvZ6K9bp/eZ+Ro/L8+F2L5pCNzvXIiGfekNVymncoEgjUq1mGv4y/ALKJ
         0MgxqjuPzE4NfI10IOnmNTkHarFSi+2P+osG4zntMVFc2Ll+2hoEfDPL9Y3KcxPaxzlP
         Bn8Hchnr8BmRCv9Jcnn/8YAw7q0yuQrPgn+fmXRzM/Ajaw/mbxPdYiCnXQenu+U/CcT8
         l8HStmc4q8zeh9XgsPvzz2RfEU1WOHotREZCX3mDuztBl+LhcbiAjkLYsM0de4cIimr4
         ISWg==
X-Gm-Message-State: ABy/qLZjA6LZcRBbKbM9e5bSbM2B9Gy1zojbR3nbpx6u2wl13X+kl9fZ
        0FcLQueGOOCTg32lmpTfJ9VRBhn+/J0ceAm03K50dHMh
X-Google-Smtp-Source: APBJJlHEon5QRUyAbHcphIFIQdZkeQk8tmnPpxJ8wRpTzg/Q52N2dBs8KA1G7QgtIWd2oy5i7d+E0tx4xswvqer1q+E=
X-Received: by 2002:a2e:9d8b:0:b0:2b9:cb50:7043 with SMTP id
 c11-20020a2e9d8b000000b002b9cb507043mr7996725ljj.2.1691094878936; Thu, 03 Aug
 2023 13:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230420125801.999381-1-jwcart2@gmail.com> <fbad54d3-07e6-c364-2547-0730f4d69cd7@googlemail.com>
In-Reply-To: <fbad54d3-07e6-c364-2547-0730f4d69cd7@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 3 Aug 2023 16:34:27 -0400
Message-ID: <CAP+JOzSqtLfbyQwsFU03eXvqvsjteWTPmWv=Laot=Mn8=27+Aw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix class permission verification in CIL
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 12, 2023 at 12:01=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On 4/20/23 14:58, James Carter wrote:
> > Before the CIL post processing phase (where expressions are evaluated,
> > various ebitmaps are set, etc) there is a pre-verification where
> > checks are made to find self references or loops in bounds, attribute
> > sets, and class permissions. The class permission checking is faulty
> > in two ways.
> >
> > First, it does not check for the use of "all" in a permission expressio=
n
> > for a class that has no permissions. An error will still be generated
> > later and secilc will exit cleanly, but without an error message that
> > explains the problem.
> >
> > Second, it does not properly handle lists in permission expressions.
> > For example, "(C ((P)))" is a legitimate class permission. The
> > permissions expression contains one item that is a list containing
> > one permission. This permission expression will be properly evaluated.
> > Unfortunately, the class permission verification assumes that each
> > item in the permission expression is either an operator or a
> > permission datum and a segmenation fault will occur.
> >
> > Refactor the class permission checking to give a proper error when
> > "all" is used in a permission expression for a class that has no
> > permissions and so that it can handle lists in permission
> > expressions. Also, check for the actual flavor of each item in
> > the permission expression and return an error if an unexpected
> > flavor is found.
> >
> > The failure to properly handle lists in permission expressions was
> > found by oss-fuzz (#58085).
>
>
> For what it's worth:
>
> Verified the fuzzer no longer crashes and no new issues arose after
> running for ~1h.
>
> Successfully build DSSP5.
>
>
> Tested-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>

I plan on merging this soon, unless I hear any objections.
Jim


>
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >   libsepol/cil/src/cil_verify.c | 167 +++++++++++++++++++++++----------=
-
> >   1 file changed, 114 insertions(+), 53 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verif=
y.c
> > index 4640dc59..3f58969d 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -1700,31 +1700,109 @@ static int __add_perm_to_list(__attribute__((u=
nused)) hashtab_key_t k, hashtab_d
> >       return SEPOL_OK;
> >   }
> >
> > -static int __cil_verify_classperms(struct cil_list *classperms,
> > -                                struct cil_symtab_datum *orig,
> > -                                struct cil_symtab_datum *parent,
> > -                                struct cil_symtab_datum *cur,
> > -                                enum cil_flavor flavor,
> > -                                unsigned steps, unsigned limit)
> > +static int __cil_verify_classperms(struct cil_list *classperms, struct=
 cil_symtab_datum *orig, struct cil_symtab_datum *cur, unsigned steps, unsi=
gned limit);
> > +
> > +static int __cil_verify_map_perm(struct cil_class *class, struct cil_p=
erm *perm, struct cil_symtab_datum *orig, unsigned steps, unsigned limit)
> > +{
> > +     int rc;
> > +
> > +     if (!perm->classperms) {
> > +             cil_tree_log(NODE(class), CIL_ERR, "No class permissions =
for map class %s, permission %s", DATUM(class)->name, DATUM(perm)->name);
> > +             goto exit;
> > +     }
> > +
> > +     rc =3D __cil_verify_classperms(perm->classperms, orig, &perm->dat=
um, steps, limit);
> > +     if (rc !=3D SEPOL_OK) {
> > +             cil_tree_log(NODE(class), CIL_ERR, "There was an error ve=
rifying class permissions for map class %s, permission %s", DATUM(class)->n=
ame, DATUM(perm)->name);
> > +             goto exit;
> > +     }
> > +
> > +     return SEPOL_OK;
> > +
> > +exit:
> > +     return SEPOL_ERR;
> > +}
> > +
> > +
> > +static int __cil_verify_perms(struct cil_class *class, struct cil_list=
 *perms, struct cil_symtab_datum *orig, unsigned steps, unsigned limit)
> >   {
> >       int rc =3D SEPOL_ERR;
> > -     struct cil_list_item *curr;
> > +     int count =3D 0;
> > +     struct cil_list_item *i =3D NULL;
> >
> > -     if (classperms =3D=3D NULL) {
> > -             if (flavor =3D=3D CIL_MAP_PERM) {
> > -                     cil_tree_log(NODE(cur), CIL_ERR, "Map class %s do=
es not have a classmapping for %s", parent->name, cur->name);
> > +     if (!perms) {
> > +             cil_tree_log(NODE(class), CIL_ERR, "No permissions for cl=
ass %s in class permissions", DATUM(class)->name);
> > +             goto exit;
> > +     }
> > +
> > +     cil_list_for_each(i, perms) {
> > +             count++;
> > +             if (i->flavor =3D=3D CIL_LIST) {
> > +                     rc =3D __cil_verify_perms(class, i->data, orig, s=
teps, limit);
> > +                     if (rc !=3D SEPOL_OK) {
> > +                             goto exit;
> > +                     }
> > +             } else if (i->flavor =3D=3D CIL_DATUM) {
> > +                     struct cil_perm *perm =3D i->data;
> > +                     if (FLAVOR(perm) =3D=3D CIL_MAP_PERM) {
> > +                             rc =3D __cil_verify_map_perm(class, perm,=
 orig, steps, limit);
> > +                             if (rc !=3D SEPOL_OK) {
> > +                                     goto exit;
> > +                             }
> > +                     }
> > +             } else if (i->flavor =3D=3D CIL_OP) {
> > +                     enum cil_flavor op =3D (enum cil_flavor)(uintptr_=
t)i->data;
> > +                     if (op =3D=3D CIL_ALL) {
> > +                             struct cil_list *perm_list;
> > +                             struct cil_list_item *j =3D NULL;
> > +                             int count2 =3D 0;
> > +                             cil_list_init(&perm_list, CIL_MAP_PERM);
> > +                             cil_symtab_map(&class->perms, __add_perm_=
to_list, perm_list);
> > +                             cil_list_for_each(j, perm_list) {
> > +                                     count2++;
> > +                                     struct cil_perm *perm =3D j->data=
;
> > +                                     if (FLAVOR(perm) =3D=3D CIL_MAP_P=
ERM) {
> > +                                             rc =3D __cil_verify_map_p=
erm(class, perm, orig, steps, limit);
> > +                                             if (rc !=3D SEPOL_OK) {
> > +                                                     cil_list_destroy(=
&perm_list, CIL_FALSE);
> > +                                                     goto exit;
> > +                                             }
> > +                                     }
> > +                             }
> > +                             cil_list_destroy(&perm_list, CIL_FALSE);
> > +                             if (count2 =3D=3D 0) {
> > +                                     cil_tree_log(NODE(class), CIL_ERR=
, "Operator \"all\" used for %s which has no permissions associated with it=
", DATUM(class)->name);
> > +                                     goto exit;
> > +                             }
> > +                     }
> >               } else {
> > -                     cil_tree_log(NODE(cur), CIL_ERR, "Classpermission=
 %s does not have a classpermissionset", cur->name);
> > +                     cil_tree_log(NODE(class), CIL_ERR, "Permission li=
st for %s has an unexpected flavor: %d", DATUM(class)->name, i->flavor);
> > +                     goto exit;
> >               }
> > +     }
> > +
> > +     if (count =3D=3D 0) {
> > +             cil_tree_log(NODE(class), CIL_ERR, "Empty permissions lis=
t for class %s in class permissions", DATUM(class)->name);
> > +             goto exit;
> > +     }
> > +
> > +     return SEPOL_OK;
> > +
> > +exit:
> > +     return SEPOL_ERR;
> > +}
> > +
> > +static int __cil_verify_classperms(struct cil_list *classperms, struct=
 cil_symtab_datum *orig, struct cil_symtab_datum *cur, unsigned steps, unsi=
gned limit)
> > +{
> > +     int rc;
> > +     struct cil_list_item *i;
> > +
> > +     if (classperms =3D=3D NULL) {
> >               goto exit;
> >       }
> >
> >       if (steps > 0 && orig =3D=3D cur) {
> > -             if (flavor =3D=3D CIL_MAP_PERM) {
> > -                     cil_tree_log(NODE(cur), CIL_ERR, "Found circular =
class permissions involving the map class %s and permission %s", parent->na=
me, cur->name);
> > -             } else {
> > -                     cil_tree_log(NODE(cur), CIL_ERR, "Found circular =
class permissions involving the set %s", cur->name);
> > -             }
> > +             cil_tree_log(NODE(cur), CIL_ERR, "Found circular class pe=
rmissions involving %s", cur->name);
> >               goto exit;
> >       } else {
> >               steps++;
> > @@ -1735,44 +1813,20 @@ static int __cil_verify_classperms(struct cil_l=
ist *classperms,
> >               }
> >       }
> >
> > -     cil_list_for_each(curr, classperms) {
> > -             if (curr->flavor =3D=3D CIL_CLASSPERMS) {
> > -                     struct cil_classperms *cp =3D curr->data;
> > -                     if (FLAVOR(cp->class) !=3D CIL_CLASS) { /* MAP */
> > -                             struct cil_list_item *i =3D NULL;
> > -                             cil_list_for_each(i, cp->perms) {
> > -                                     if (i->flavor !=3D CIL_OP) {
> > -                                             struct cil_perm *cmp =3D =
i->data;
> > -                                             rc =3D __cil_verify_class=
perms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM, =
steps, limit);
> > -                                             if (rc !=3D SEPOL_OK) {
> > -                                                     goto exit;
> > -                                             }
> > -                                     } else {
> > -                                             enum cil_flavor op =3D (e=
num cil_flavor)(uintptr_t)i->data;
> > -                                             if (op =3D=3D CIL_ALL) {
> > -                                                     struct cil_class =
*mc =3D cp->class;
> > -                                                     struct cil_list *=
perm_list;
> > -                                                     struct cil_list_i=
tem *j =3D NULL;
> > -
> > -                                                     cil_list_init(&pe=
rm_list, CIL_MAP_PERM);
> > -                                                     cil_symtab_map(&m=
c->perms, __add_perm_to_list, perm_list);
> > -                                                     cil_list_for_each=
(j, perm_list) {
> > -                                                             struct ci=
l_perm *cmp =3D j->data;
> > -                                                             rc =3D __=
cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum=
, CIL_MAP_PERM, steps, limit);
> > -                                                             if (rc !=
=3D SEPOL_OK) {
> > -                                                                     c=
il_list_destroy(&perm_list, CIL_FALSE);
> > -                                                                     g=
oto exit;
> > -                                                             }
> > -                                                     }
> > -                                                     cil_list_destroy(=
&perm_list, CIL_FALSE);
> > -                                             }
> > -                                     }
> > -                             }
> > +     cil_list_for_each(i, classperms) {
> > +             if (i->flavor =3D=3D CIL_CLASSPERMS) {
> > +                     struct cil_classperms *cp =3D i->data;
> > +                     rc =3D __cil_verify_perms(cp->class, cp->perms, o=
rig, steps, limit);
> > +                     if (rc !=3D SEPOL_OK) {
> > +                             goto exit;
> >                       }
> >               } else { /* SET */
> > -                     struct cil_classperms_set *cp_set =3D curr->data;
> > +                     struct cil_classperms_set *cp_set =3D i->data;
> >                       struct cil_classpermission *cp =3D cp_set->set;
> > -                     rc =3D __cil_verify_classperms(cp->classperms, or=
ig, NULL, &cp->datum, CIL_CLASSPERMISSION, steps, limit);
> > +                     if (!cp->classperms) {
> > +                             cil_tree_log(NODE(cur), CIL_ERR, "Classpe=
rmission %s does not have a classpermissionset", DATUM(cp)->name);
> > +                     }
> > +                     rc =3D __cil_verify_classperms(cp->classperms, or=
ig, &cp->datum, steps, limit);
> >                       if (rc !=3D SEPOL_OK) {
> >                               goto exit;
> >                       }
> > @@ -1787,9 +1841,15 @@ exit:
> >
> >   static int __cil_verify_classpermission(struct cil_tree_node *node)
> >   {
> > +     int rc;
> >       struct cil_classpermission *cp =3D node->data;
> >
> > -     return __cil_verify_classperms(cp->classperms, &cp->datum, NULL, =
&cp->datum, CIL_CLASSPERMISSION, 0, 2);
> > +     rc =3D __cil_verify_classperms(cp->classperms, &cp->datum, &cp->d=
atum, 0, 2);
> > +     if (rc !=3D SEPOL_OK) {
> > +             cil_tree_log(node, CIL_ERR, "Error verifying class permis=
sions for classpermission %s", DATUM(cp)->name);
> > +     }
> > +
> > +     return rc;
> >   }
> >
> >   struct cil_verify_map_args {
> > @@ -1804,8 +1864,9 @@ static int __verify_map_perm_classperms(__attribu=
te__((unused)) hashtab_key_t k,
> >       struct cil_perm *cmp =3D (struct cil_perm *)d;
> >       int rc;
> >
> > -     rc =3D __cil_verify_classperms(cmp->classperms, &cmp->datum, &map=
_args->class->datum, &cmp->datum, CIL_MAP_PERM, 0, 2);
> > +     rc =3D __cil_verify_classperms(cmp->classperms, &cmp->datum, &cmp=
->datum, 0, 2);
> >       if (rc !=3D SEPOL_OK) {
> > +             cil_tree_log(NODE(cmp), CIL_ERR, "Error verifying class p=
ermissions for map class %s, permission %s", DATUM(map_args->class)->name, =
DATUM(cmp)->name);
> >               map_args->rc =3D rc;
> >       }
> >
