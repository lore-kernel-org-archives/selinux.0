Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B71C001DB
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 18:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjHDSgv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjHDSgH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Aug 2023 14:36:07 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08F84C0D
        for <selinux@vger.kernel.org>; Fri,  4 Aug 2023 11:35:22 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b974031aeaso37561661fa.0
        for <selinux@vger.kernel.org>; Fri, 04 Aug 2023 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691174121; x=1691778921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wZcwQd/0bncD5/Yw8AGEZjxOHPOyGA7jh26HFgN37k=;
        b=DSYuG0Y/JvYKigdZsm8uzz4N0Ux0h+L0CeWBMfKdhqyV/wiXYOOJz983IiWGK1lMAP
         wN43kpUKK/FZx6NFPrZeqyC9gc5pt+v6zTWKU2YpKFM7U3W4DYOuEe82G0QOGSzv/1T1
         bu9xSOZDZ2s5r2/I6CyoGRz2/RWjiuEpFjH2gyRZnwVp8fBaaUM49yZCW2rIgiEkNP3f
         n+3qV51au1rq2h4ldzg5MP/wmGSeEDuuVZgrNEbJuQyTYKd9v1W7/KcYwV7oj0bXrSgl
         7rNxct9h60hcro1BjhmWbYIC+QplkIwSbHgHlo3TkNwjVHXM8Hv2gzbC/FC47PQgAH4R
         AzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174121; x=1691778921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wZcwQd/0bncD5/Yw8AGEZjxOHPOyGA7jh26HFgN37k=;
        b=VLr1g73wf75D7r5dTmSKFQlhbNu+S0AAxXNZ+JQ7D+xzDb/AjoVNQKjgn1l1OtyU3d
         76WcBbdtxIQr/E9rv/nyBmAiP8fqChHbjWO8dfbBEwiPTFMZzUYMuVJLqH0a/vF3ukti
         irpOdzqUEJypGJ7NyzOlkpz1j1syOvzA+mi8Lhhyasl+JahYC3PiBVAmV7k9mdtilkWu
         XBgQIACiwU6JH7oa/6UDdMipThU9Hb+UpYxAnFpkpqL4XnS9gFs8HOF89Gl6AZY+Unkt
         L3vike8e5+Jw4pjBuvvn4McZxYqQBHbYSO6AU8P6Ht0poOTX+4G8dsz+xtChL7p8P0MP
         Ihxg==
X-Gm-Message-State: AOJu0YxpVJAY0Op9lHUJ43I8oqh+uBw0albuH4zQ+6nUSAMVzZgzd5hR
        TEbwc+STmo9ZxQlASJuvicW+qlxh23dAmeyRtiZPcIqH
X-Google-Smtp-Source: AGHT+IEzyF1sXfVoIHCVCSZnoDyf6xQa7Y+4+9TtAU5w9pW7Bj91zfgjupAHphswKhLv05SqKtsAthkZdk7Ujl457Vs=
X-Received: by 2002:a2e:7005:0:b0:2b9:4418:b46e with SMTP id
 l5-20020a2e7005000000b002b94418b46emr2258053ljc.21.1691174120807; Fri, 04 Aug
 2023 11:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230420125801.999381-1-jwcart2@gmail.com> <fbad54d3-07e6-c364-2547-0730f4d69cd7@googlemail.com>
 <CAP+JOzSqtLfbyQwsFU03eXvqvsjteWTPmWv=Laot=Mn8=27+Aw@mail.gmail.com>
In-Reply-To: <CAP+JOzSqtLfbyQwsFU03eXvqvsjteWTPmWv=Laot=Mn8=27+Aw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Aug 2023 14:35:09 -0400
Message-ID: <CAP+JOzR_JY=9Lzmd3ZONc-sc0v8j96hTxBj1qDidA+t+CwEzYw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix class permission verification in CIL
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 3, 2023 at 4:34=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Wed, Jul 12, 2023 at 12:01=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On 4/20/23 14:58, James Carter wrote:
> > > Before the CIL post processing phase (where expressions are evaluated=
,
> > > various ebitmaps are set, etc) there is a pre-verification where
> > > checks are made to find self references or loops in bounds, attribute
> > > sets, and class permissions. The class permission checking is faulty
> > > in two ways.
> > >
> > > First, it does not check for the use of "all" in a permission express=
ion
> > > for a class that has no permissions. An error will still be generated
> > > later and secilc will exit cleanly, but without an error message that
> > > explains the problem.
> > >
> > > Second, it does not properly handle lists in permission expressions.
> > > For example, "(C ((P)))" is a legitimate class permission. The
> > > permissions expression contains one item that is a list containing
> > > one permission. This permission expression will be properly evaluated=
.
> > > Unfortunately, the class permission verification assumes that each
> > > item in the permission expression is either an operator or a
> > > permission datum and a segmenation fault will occur.
> > >
> > > Refactor the class permission checking to give a proper error when
> > > "all" is used in a permission expression for a class that has no
> > > permissions and so that it can handle lists in permission
> > > expressions. Also, check for the actual flavor of each item in
> > > the permission expression and return an error if an unexpected
> > > flavor is found.
> > >
> > > The failure to properly handle lists in permission expressions was
> > > found by oss-fuzz (#58085).
> >
> >
> > For what it's worth:
> >
> > Verified the fuzzer no longer crashes and no new issues arose after
> > running for ~1h.
> >
> > Successfully build DSSP5.
> >
> >
> > Tested-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
>
> I plan on merging this soon, unless I hear any objections.
> Jim
>

This patch has been merged.
Jim

>
> >
> > >
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > > ---
> > >   libsepol/cil/src/cil_verify.c | 167 +++++++++++++++++++++++--------=
---
> > >   1 file changed, 114 insertions(+), 53 deletions(-)
> > >
> > > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_ver=
ify.c
> > > index 4640dc59..3f58969d 100644
> > > --- a/libsepol/cil/src/cil_verify.c
> > > +++ b/libsepol/cil/src/cil_verify.c
> > > @@ -1700,31 +1700,109 @@ static int __add_perm_to_list(__attribute__(=
(unused)) hashtab_key_t k, hashtab_d
> > >       return SEPOL_OK;
> > >   }
> > >
> > > -static int __cil_verify_classperms(struct cil_list *classperms,
> > > -                                struct cil_symtab_datum *orig,
> > > -                                struct cil_symtab_datum *parent,
> > > -                                struct cil_symtab_datum *cur,
> > > -                                enum cil_flavor flavor,
> > > -                                unsigned steps, unsigned limit)
> > > +static int __cil_verify_classperms(struct cil_list *classperms, stru=
ct cil_symtab_datum *orig, struct cil_symtab_datum *cur, unsigned steps, un=
signed limit);
> > > +
> > > +static int __cil_verify_map_perm(struct cil_class *class, struct cil=
_perm *perm, struct cil_symtab_datum *orig, unsigned steps, unsigned limit)
> > > +{
> > > +     int rc;
> > > +
> > > +     if (!perm->classperms) {
> > > +             cil_tree_log(NODE(class), CIL_ERR, "No class permission=
s for map class %s, permission %s", DATUM(class)->name, DATUM(perm)->name);
> > > +             goto exit;
> > > +     }
> > > +
> > > +     rc =3D __cil_verify_classperms(perm->classperms, orig, &perm->d=
atum, steps, limit);
> > > +     if (rc !=3D SEPOL_OK) {
> > > +             cil_tree_log(NODE(class), CIL_ERR, "There was an error =
verifying class permissions for map class %s, permission %s", DATUM(class)-=
>name, DATUM(perm)->name);
> > > +             goto exit;
> > > +     }
> > > +
> > > +     return SEPOL_OK;
> > > +
> > > +exit:
> > > +     return SEPOL_ERR;
> > > +}
> > > +
> > > +
> > > +static int __cil_verify_perms(struct cil_class *class, struct cil_li=
st *perms, struct cil_symtab_datum *orig, unsigned steps, unsigned limit)
> > >   {
> > >       int rc =3D SEPOL_ERR;
> > > -     struct cil_list_item *curr;
> > > +     int count =3D 0;
> > > +     struct cil_list_item *i =3D NULL;
> > >
> > > -     if (classperms =3D=3D NULL) {
> > > -             if (flavor =3D=3D CIL_MAP_PERM) {
> > > -                     cil_tree_log(NODE(cur), CIL_ERR, "Map class %s =
does not have a classmapping for %s", parent->name, cur->name);
> > > +     if (!perms) {
> > > +             cil_tree_log(NODE(class), CIL_ERR, "No permissions for =
class %s in class permissions", DATUM(class)->name);
> > > +             goto exit;
> > > +     }
> > > +
> > > +     cil_list_for_each(i, perms) {
> > > +             count++;
> > > +             if (i->flavor =3D=3D CIL_LIST) {
> > > +                     rc =3D __cil_verify_perms(class, i->data, orig,=
 steps, limit);
> > > +                     if (rc !=3D SEPOL_OK) {
> > > +                             goto exit;
> > > +                     }
> > > +             } else if (i->flavor =3D=3D CIL_DATUM) {
> > > +                     struct cil_perm *perm =3D i->data;
> > > +                     if (FLAVOR(perm) =3D=3D CIL_MAP_PERM) {
> > > +                             rc =3D __cil_verify_map_perm(class, per=
m, orig, steps, limit);
> > > +                             if (rc !=3D SEPOL_OK) {
> > > +                                     goto exit;
> > > +                             }
> > > +                     }
> > > +             } else if (i->flavor =3D=3D CIL_OP) {
> > > +                     enum cil_flavor op =3D (enum cil_flavor)(uintpt=
r_t)i->data;
> > > +                     if (op =3D=3D CIL_ALL) {
> > > +                             struct cil_list *perm_list;
> > > +                             struct cil_list_item *j =3D NULL;
> > > +                             int count2 =3D 0;
> > > +                             cil_list_init(&perm_list, CIL_MAP_PERM)=
;
> > > +                             cil_symtab_map(&class->perms, __add_per=
m_to_list, perm_list);
> > > +                             cil_list_for_each(j, perm_list) {
> > > +                                     count2++;
> > > +                                     struct cil_perm *perm =3D j->da=
ta;
> > > +                                     if (FLAVOR(perm) =3D=3D CIL_MAP=
_PERM) {
> > > +                                             rc =3D __cil_verify_map=
_perm(class, perm, orig, steps, limit);
> > > +                                             if (rc !=3D SEPOL_OK) {
> > > +                                                     cil_list_destro=
y(&perm_list, CIL_FALSE);
> > > +                                                     goto exit;
> > > +                                             }
> > > +                                     }
> > > +                             }
> > > +                             cil_list_destroy(&perm_list, CIL_FALSE)=
;
> > > +                             if (count2 =3D=3D 0) {
> > > +                                     cil_tree_log(NODE(class), CIL_E=
RR, "Operator \"all\" used for %s which has no permissions associated with =
it", DATUM(class)->name);
> > > +                                     goto exit;
> > > +                             }
> > > +                     }
> > >               } else {
> > > -                     cil_tree_log(NODE(cur), CIL_ERR, "Classpermissi=
on %s does not have a classpermissionset", cur->name);
> > > +                     cil_tree_log(NODE(class), CIL_ERR, "Permission =
list for %s has an unexpected flavor: %d", DATUM(class)->name, i->flavor);
> > > +                     goto exit;
> > >               }
> > > +     }
> > > +
> > > +     if (count =3D=3D 0) {
> > > +             cil_tree_log(NODE(class), CIL_ERR, "Empty permissions l=
ist for class %s in class permissions", DATUM(class)->name);
> > > +             goto exit;
> > > +     }
> > > +
> > > +     return SEPOL_OK;
> > > +
> > > +exit:
> > > +     return SEPOL_ERR;
> > > +}
> > > +
> > > +static int __cil_verify_classperms(struct cil_list *classperms, stru=
ct cil_symtab_datum *orig, struct cil_symtab_datum *cur, unsigned steps, un=
signed limit)
> > > +{
> > > +     int rc;
> > > +     struct cil_list_item *i;
> > > +
> > > +     if (classperms =3D=3D NULL) {
> > >               goto exit;
> > >       }
> > >
> > >       if (steps > 0 && orig =3D=3D cur) {
> > > -             if (flavor =3D=3D CIL_MAP_PERM) {
> > > -                     cil_tree_log(NODE(cur), CIL_ERR, "Found circula=
r class permissions involving the map class %s and permission %s", parent->=
name, cur->name);
> > > -             } else {
> > > -                     cil_tree_log(NODE(cur), CIL_ERR, "Found circula=
r class permissions involving the set %s", cur->name);
> > > -             }
> > > +             cil_tree_log(NODE(cur), CIL_ERR, "Found circular class =
permissions involving %s", cur->name);
> > >               goto exit;
> > >       } else {
> > >               steps++;
> > > @@ -1735,44 +1813,20 @@ static int __cil_verify_classperms(struct cil=
_list *classperms,
> > >               }
> > >       }
> > >
> > > -     cil_list_for_each(curr, classperms) {
> > > -             if (curr->flavor =3D=3D CIL_CLASSPERMS) {
> > > -                     struct cil_classperms *cp =3D curr->data;
> > > -                     if (FLAVOR(cp->class) !=3D CIL_CLASS) { /* MAP =
*/
> > > -                             struct cil_list_item *i =3D NULL;
> > > -                             cil_list_for_each(i, cp->perms) {
> > > -                                     if (i->flavor !=3D CIL_OP) {
> > > -                                             struct cil_perm *cmp =
=3D i->data;
> > > -                                             rc =3D __cil_verify_cla=
ssperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM=
, steps, limit);
> > > -                                             if (rc !=3D SEPOL_OK) {
> > > -                                                     goto exit;
> > > -                                             }
> > > -                                     } else {
> > > -                                             enum cil_flavor op =3D =
(enum cil_flavor)(uintptr_t)i->data;
> > > -                                             if (op =3D=3D CIL_ALL) =
{
> > > -                                                     struct cil_clas=
s *mc =3D cp->class;
> > > -                                                     struct cil_list=
 *perm_list;
> > > -                                                     struct cil_list=
_item *j =3D NULL;
> > > -
> > > -                                                     cil_list_init(&=
perm_list, CIL_MAP_PERM);
> > > -                                                     cil_symtab_map(=
&mc->perms, __add_perm_to_list, perm_list);
> > > -                                                     cil_list_for_ea=
ch(j, perm_list) {
> > > -                                                             struct =
cil_perm *cmp =3D j->data;
> > > -                                                             rc =3D =
__cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->dat=
um, CIL_MAP_PERM, steps, limit);
> > > -                                                             if (rc =
!=3D SEPOL_OK) {
> > > -                                                                    =
 cil_list_destroy(&perm_list, CIL_FALSE);
> > > -                                                                    =
 goto exit;
> > > -                                                             }
> > > -                                                     }
> > > -                                                     cil_list_destro=
y(&perm_list, CIL_FALSE);
> > > -                                             }
> > > -                                     }
> > > -                             }
> > > +     cil_list_for_each(i, classperms) {
> > > +             if (i->flavor =3D=3D CIL_CLASSPERMS) {
> > > +                     struct cil_classperms *cp =3D i->data;
> > > +                     rc =3D __cil_verify_perms(cp->class, cp->perms,=
 orig, steps, limit);
> > > +                     if (rc !=3D SEPOL_OK) {
> > > +                             goto exit;
> > >                       }
> > >               } else { /* SET */
> > > -                     struct cil_classperms_set *cp_set =3D curr->dat=
a;
> > > +                     struct cil_classperms_set *cp_set =3D i->data;
> > >                       struct cil_classpermission *cp =3D cp_set->set;
> > > -                     rc =3D __cil_verify_classperms(cp->classperms, =
orig, NULL, &cp->datum, CIL_CLASSPERMISSION, steps, limit);
> > > +                     if (!cp->classperms) {
> > > +                             cil_tree_log(NODE(cur), CIL_ERR, "Class=
permission %s does not have a classpermissionset", DATUM(cp)->name);
> > > +                     }
> > > +                     rc =3D __cil_verify_classperms(cp->classperms, =
orig, &cp->datum, steps, limit);
> > >                       if (rc !=3D SEPOL_OK) {
> > >                               goto exit;
> > >                       }
> > > @@ -1787,9 +1841,15 @@ exit:
> > >
> > >   static int __cil_verify_classpermission(struct cil_tree_node *node)
> > >   {
> > > +     int rc;
> > >       struct cil_classpermission *cp =3D node->data;
> > >
> > > -     return __cil_verify_classperms(cp->classperms, &cp->datum, NULL=
, &cp->datum, CIL_CLASSPERMISSION, 0, 2);
> > > +     rc =3D __cil_verify_classperms(cp->classperms, &cp->datum, &cp-=
>datum, 0, 2);
> > > +     if (rc !=3D SEPOL_OK) {
> > > +             cil_tree_log(node, CIL_ERR, "Error verifying class perm=
issions for classpermission %s", DATUM(cp)->name);
> > > +     }
> > > +
> > > +     return rc;
> > >   }
> > >
> > >   struct cil_verify_map_args {
> > > @@ -1804,8 +1864,9 @@ static int __verify_map_perm_classperms(__attri=
bute__((unused)) hashtab_key_t k,
> > >       struct cil_perm *cmp =3D (struct cil_perm *)d;
> > >       int rc;
> > >
> > > -     rc =3D __cil_verify_classperms(cmp->classperms, &cmp->datum, &m=
ap_args->class->datum, &cmp->datum, CIL_MAP_PERM, 0, 2);
> > > +     rc =3D __cil_verify_classperms(cmp->classperms, &cmp->datum, &c=
mp->datum, 0, 2);
> > >       if (rc !=3D SEPOL_OK) {
> > > +             cil_tree_log(NODE(cmp), CIL_ERR, "Error verifying class=
 permissions for map class %s, permission %s", DATUM(map_args->class)->name=
, DATUM(cmp)->name);
> > >               map_args->rc =3D rc;
> > >       }
> > >
