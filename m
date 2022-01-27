Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EB0C433F5
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 15:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbiA0Paz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 10:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiA0Paz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 10:30:55 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B75C061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 07:30:54 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id e81so6501834oia.6
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 07:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l+aRlkdBMpZOqBypFB67vbucy1jPu9YqSD06tHJiBpM=;
        b=UAy/Casx0Px6UykVuvv2UOKvCLCQS5nqYKeo+O/3Ddyk/etOwIeAQ+F89DOlbHJP4H
         SPTmZy1u+yTDd7DZe8RMxAWbi0+S/OTJDtQtXQPQP5EgmthgbJrwGEpOXcDgHKQZzZ7y
         sjQstvlU68zRFlMlI/0SDmgE+ewMoMD7omtQvHhOhDqOcWQCDNUn7SdCbCKW8hRPzpXC
         RlMmtiL/zKEYO5iifzxtpKB+ngASBZAhTRqYN3qllK7ie+1UKY5P2RuE+AAz5Ssv/e9f
         0tWgDVDpb73D9QCfX2xPyXjRVTpFstkwlbST3qc576AWPhTJ/Ri03TPaghtAysHlBsX3
         Ahug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l+aRlkdBMpZOqBypFB67vbucy1jPu9YqSD06tHJiBpM=;
        b=Zdsz4XUgIb8t/0pd/sL2pGCSUKtehxTh4RIOGxMIBwNVNpUaeZWHmUc0ZpqlNv220s
         1A3LRZSZvWT7SFQUoZSYI5vrsiG1nAZO1Ky5h+TroQyPqdEZAPzQI9dI2Xa+nte/cv9I
         C8ImU3LDThC46J6yHpCEYQYJMfGBTxxapHS4ViwHfo0LKb+BaFqK4jkWRIHSbUGQ+Ld2
         H4ol70hK28VZk1BuZe4h5eSQXCnMsGebiqtHJEY+hc0M5akafHuC6OEy8vmmdxo6iJQ4
         zkqRndXwZpOmbtiUmWA0R7/dQPtYo1zVES+HZYJ4LvqCP9zYISw8Xt0eKNjUacws4tWD
         xhCw==
X-Gm-Message-State: AOAM5326ierOJ7FlXDfcmlCZ3xoH0J72jbgZIkzuzHs0c1wsIwBtMUfZ
        DLUqT0IzjRoJZaCSiJy4oDkbv3vst8E8k4Wu6wIXvkPb
X-Google-Smtp-Source: ABdhPJx9zaon526qXNQm0g0sv2x/KSSr5VFSv+Sz0t/nRXsIeNv3nlZpOn61J6OBYrrvPRsueFS1+Jx3qUF3YHS4xhA=
X-Received: by 2002:a05:6808:1147:: with SMTP id u7mr7072249oiu.189.1643297453543;
 Thu, 27 Jan 2022 07:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20220119160339.12072-1-cgzones@googlemail.com> <CAP+JOzQAN-MPSG0aZe=hPSeMsWz33E42Bxbq0yfkMDJ-E5_nHQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQAN-MPSG0aZe=hPSeMsWz33E42Bxbq0yfkMDJ-E5_nHQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 27 Jan 2022 10:30:42 -0500
Message-ID: <CAP+JOzRBkx+AvDm_xQ_oiPwPoXfUd=L3w7-2F4g9E5P4AWaa3w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: drop trailing newlines in log messages
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 9:44 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Jan 21, 2022 at 2:44 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The default log handler sepol_msg_default_handler() appends a newline
> > and the majority of log messages do not contain a trailing newline in
> > the format string.
> >
> > Fixes: 5c178f9f55 ("libsepol: use logging framework in conditional.c")
> > Fixes: 852f14d43d ("libsepol: use logging framework in ebitmap.c")
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/avtab.c          |  2 +-
> >  libsepol/src/conditional.c    | 14 +++++++-------
> >  libsepol/src/context_record.c |  2 +-
> >  libsepol/src/ebitmap.c        | 20 ++++++++++----------
> >  libsepol/src/expand.c         |  8 ++++----
> >  libsepol/src/hierarchy.c      |  2 +-
> >  libsepol/src/link.c           | 16 ++++++++--------
> >  libsepol/src/services.c       |  2 +-
> >  8 files changed, 33 insertions(+), 33 deletions(-)
> >
> > diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> > index 9dc5d9f1..7920b60a 100644
> > --- a/libsepol/src/avtab.c
> > +++ b/libsepol/src/avtab.c
> > @@ -548,7 +548,7 @@ int avtab_read_item(struct policy_file *fp, uint32_=
t vers, avtab_t * a,
> >         if ((vers < POLICYDB_VERSION_XPERMS_IOCTL) &&
> >                         (key.specified & AVTAB_XPERMS)) {
> >                 ERR(fp->handle, "policy version %u does not support ext=
ended "
> > -                               "permissions rules and one was specifie=
d\n", vers);
> > +                               "permissions rules and one was specifie=
d", vers);
> >                 return -1;
> >         } else if (key.specified & AVTAB_XPERMS) {
> >                 rc =3D next_entry(&buf8, fp, sizeof(uint8_t));
> > diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> > index a3125fdd..f78b38a2 100644
> > --- a/libsepol/src/conditional.c
> > +++ b/libsepol/src/conditional.c
> > @@ -315,7 +315,7 @@ static int evaluate_cond_node(policydb_t * p, cond_=
node_t * node)
> >         if (new_state !=3D node->cur_state) {
> >                 node->cur_state =3D new_state;
> >                 if (new_state =3D=3D -1)
> > -                       WARN(NULL, "expression result was undefined - d=
isabling all rules.\n");
> > +                       WARN(NULL, "expression result was undefined - d=
isabling all rules.");
> >                 /* turn the rules on or off */
> >                 for (cur =3D node->true_list; cur !=3D NULL; cur =3D cu=
r->next) {
> >                         if (new_state <=3D 0) {
> > @@ -368,7 +368,7 @@ int cond_normalize_expr(policydb_t * p, cond_node_t=
 * cn)
> >                 if (ne) {
> >                         ne->next =3D NULL;
> >                 } else {        /* ne should never be NULL */
> > -                       ERR(NULL, "Found expr with no bools and only a =
! - this should never happen.\n");
> > +                       ERR(NULL, "Found expr with no bools and only a =
! - this should never happen.");
> >                         return -1;
> >                 }
> >                 /* swap the true and false lists */
> > @@ -421,7 +421,7 @@ int cond_normalize_expr(policydb_t * p, cond_node_t=
 * cn)
> >                         k =3D cond_evaluate_expr(p, cn->expr);
> >                         if (k =3D=3D -1) {
> >                                 ERR(NULL, "While testing expression, ex=
pression result "
> > -                                    "was undefined - this should never=
 happen.\n");
> > +                                    "was undefined - this should never=
 happen.");
> >                                 return -1;
> >                         }
> >                         /* set the bit if expression evaluates true */
> > @@ -660,13 +660,13 @@ static int cond_insertf(avtab_t * a
> >                                         }
> >                                 }
> >                                 if (!found) {
> > -                                       ERR(NULL, "security: conflictin=
g type rules.\n");
> > +                                       ERR(NULL, "security: conflictin=
g type rules.");
> >                                         return -1;
> >                                 }
> >                         }
> >                 } else {
> >                         if (avtab_search(&p->te_cond_avtab, k)) {
> > -                               ERR(NULL, "security: conflicting type r=
ules when adding type rule for true.\n");
> > +                               ERR(NULL, "security: conflicting type r=
ules when adding type rule for true.");
> >                                 return -1;
> >                         }
> >                 }
> > @@ -733,12 +733,12 @@ static int cond_read_av_list(policydb_t * p, void=
 *fp,
> >  static int expr_isvalid(policydb_t * p, cond_expr_t * expr)
> >  {
> >         if (expr->expr_type <=3D 0 || expr->expr_type > COND_LAST) {
> > -               WARN(NULL, "security: conditional expressions uses unkn=
own operator.\n");
> > +               WARN(NULL, "security: conditional expressions uses unkn=
own operator.");
> >                 return 0;
> >         }
> >
> >         if (expr->bool > p->p_bools.nprim) {
> > -               WARN(NULL, "security: conditional expressions uses unkn=
own bool.\n");
> > +               WARN(NULL, "security: conditional expressions uses unkn=
own bool.");
> >                 return 0;
> >         }
> >         return 1;
> > diff --git a/libsepol/src/context_record.c b/libsepol/src/context_recor=
d.c
> > index 435f7880..2bda121b 100644
> > --- a/libsepol/src/context_record.c
> > +++ b/libsepol/src/context_record.c
> > @@ -127,7 +127,7 @@ int sepol_context_create(sepol_handle_t * handle, s=
epol_context_t ** con_ptr)
> >             (sepol_context_t *) malloc(sizeof(sepol_context_t));
> >
> >         if (!con) {
> > -               ERR(handle, "out of memory, could not " "create context=
\n");
> > +               ERR(handle, "out of memory, could not create context");
> >                 return STATUS_ERR;
> >         }
> >
> > diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> > index fa728558..bd98c0f8 100644
> > --- a/libsepol/src/ebitmap.c
> > +++ b/libsepol/src/ebitmap.c
> > @@ -406,7 +406,7 @@ int ebitmap_read(ebitmap_t * e, void *fp)
> >         count =3D le32_to_cpu(buf[2]);
> >
> >         if (mapsize !=3D MAPSIZE) {
> > -               ERR(NULL, "security: ebitmap: map size %d does not matc=
h my size %zu (high bit was %d)\n",
> > +               ERR(NULL, "security: ebitmap: map size %d does not matc=
h my size %zu (high bit was %d)",
> >                      mapsize, MAPSIZE, e->highbit);
> >                 goto bad;
> >         }
> > @@ -415,7 +415,7 @@ int ebitmap_read(ebitmap_t * e, void *fp)
> >                 goto ok;
> >         }
> >         if (e->highbit & (MAPSIZE - 1)) {
> > -               ERR(NULL, "security: ebitmap: high bit (%d) is not a mu=
ltiple of the map size (%zu)\n",
> > +               ERR(NULL, "security: ebitmap: high bit (%d) is not a mu=
ltiple of the map size (%zu)",
> >                      e->highbit, MAPSIZE);
> >                 goto bad;
> >         }
> > @@ -427,12 +427,12 @@ int ebitmap_read(ebitmap_t * e, void *fp)
> >         for (i =3D 0; i < count; i++) {
> >                 rc =3D next_entry(buf, fp, sizeof(uint32_t));
> >                 if (rc < 0) {
> > -                       ERR(NULL, "security: ebitmap: truncated map\n")=
;
> > +                       ERR(NULL, "security: ebitmap: truncated map");
> >                         goto bad;
> >                 }
> >                 n =3D (ebitmap_node_t *) malloc(sizeof(ebitmap_node_t))=
;
> >                 if (!n) {
> > -                       ERR(NULL, "security: ebitmap: out of memory\n")=
;
> > +                       ERR(NULL, "security: ebitmap: out of memory");
> >                         rc =3D -ENOMEM;
> >                         goto bad;
> >                 }
> > @@ -441,30 +441,30 @@ int ebitmap_read(ebitmap_t * e, void *fp)
> >                 n->startbit =3D le32_to_cpu(buf[0]);
> >
> >                 if (n->startbit & (MAPSIZE - 1)) {
> > -                       ERR(NULL, "security: ebitmap start bit (%d) is =
not a multiple of the map size (%zu)\n",
> > +                       ERR(NULL, "security: ebitmap start bit (%d) is =
not a multiple of the map size (%zu)",
> >                              n->startbit, MAPSIZE);
> >                         goto bad_free;
> >                 }
> >                 if (n->startbit > (e->highbit - MAPSIZE)) {
> > -                       ERR(NULL, "security: ebitmap start bit (%d) is =
beyond the end of the bitmap (%zu)\n",
> > +                       ERR(NULL, "security: ebitmap start bit (%d) is =
beyond the end of the bitmap (%zu)",
> >                              n->startbit, (e->highbit - MAPSIZE));
> >                         goto bad_free;
> >                 }
> >                 rc =3D next_entry(&map, fp, sizeof(uint64_t));
> >                 if (rc < 0) {
> > -                       ERR(NULL, "security: ebitmap: truncated map\n")=
;
> > +                       ERR(NULL, "security: ebitmap: truncated map");
> >                         goto bad_free;
> >                 }
> >                 n->map =3D le64_to_cpu(map);
> >
> >                 if (!n->map) {
> > -                       ERR(NULL, "security: ebitmap: null map in ebitm=
ap (startbit %d)\n",
> > +                       ERR(NULL, "security: ebitmap: null map in ebitm=
ap (startbit %d)",
> >                              n->startbit);
> >                         goto bad_free;
> >                 }
> >                 if (l) {
> >                         if (n->startbit <=3D l->startbit) {
> > -                               ERR(NULL, "security: ebitmap: start bit=
 %d comes after start bit %d\n",
> > +                               ERR(NULL, "security: ebitmap: start bit=
 %d comes after start bit %d",
> >                                      n->startbit, l->startbit);
> >                                 goto bad_free;
> >                         }
> > @@ -475,7 +475,7 @@ int ebitmap_read(ebitmap_t * e, void *fp)
> >                 l =3D n;
> >         }
> >         if (count && l->startbit + MAPSIZE !=3D e->highbit) {
> > -               ERR(NULL, "security: ebitmap: high bit %u has not the e=
xpected value %zu\n",
> > +               ERR(NULL, "security: ebitmap: high bit %u has not the e=
xpected value %zu",
> >                      e->highbit, l->startbit + MAPSIZE);
> >                 goto bad;
> >         }
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 898e6b87..6d4384ae 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -166,7 +166,7 @@ static int type_copy_callback(hashtab_key_t key, ha=
shtab_datum_t datum,
> >
> >         if (new_type->flags & TYPE_FLAGS_PERMISSIVE)
> >                 if (ebitmap_set_bit(&state->out->permissive_map, new_ty=
pe->s.value, 1)) {
> > -                       ERR(state->handle, "Out of memory!\n");
> > +                       ERR(state->handle, "Out of memory!");
> >                         return -1;
> >                 }
> >
> > @@ -937,7 +937,7 @@ int mls_semantic_level_expand(mls_semantic_level_t =
* sl, mls_level_t * l,
> >         levdatum =3D (level_datum_t *) hashtab_search(p->p_levels.table=
,
> >                                                     p->p_sens_val_to_na=
me[l->sens - 1]);
> >         if (!levdatum) {
> > -               ERR(h, "%s: Impossible situation found, nothing in p_le=
vels.table.\n",
> > +               ERR(h, "%s: Impossible situation found, nothing in p_le=
vels.table.",
> >                     __func__);
> >                 errno =3D ENOENT;
> >                 return -1;
> > @@ -1694,7 +1694,7 @@ static int expand_terule_helper(sepol_handle_t * =
handle,
> >         uint32_t oldtype =3D 0;
> >
> >         if (!(specified & (AVRULE_TRANSITION|AVRULE_MEMBER|AVRULE_CHANG=
E))) {
> > -               ERR(handle, "Invalid specification: %"PRIu32"\n", speci=
fied);
> > +               ERR(handle, "Invalid specification: %"PRIu32, specified=
);
> >                 return EXPAND_RULE_ERROR;
> >         }
> >
> > @@ -1873,7 +1873,7 @@ static int expand_avrule_helper(sepol_handle_t * =
handle,
> >                                 return EXPAND_RULE_ERROR;
> >                         break;
> >                 default:
> > -                       ERR(handle, "Unknown specification: %"PRIu32"\n=
", specified);
> > +                       ERR(handle, "Unknown specification: %"PRIu32, s=
pecified);
> >                         return EXPAND_RULE_ERROR;
> >                 }
> >
> > diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
> > index 8919daa7..350443a8 100644
> > --- a/libsepol/src/hierarchy.c
> > +++ b/libsepol/src/hierarchy.c
> > @@ -237,7 +237,7 @@ oom:
> >         ERR(handle, "Insufficient memory");
> >
> >  exit:
> > -       ERR(handle,"Failed to expand parent rules\n");
> > +       ERR(handle,"Failed to expand parent rules");
> >         avtab_destroy(global_avtab);
> >         bounds_destroy_cond_info(*cond_info);
> >         *cond_info =3D NULL;
> > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > index dfcb0673..21a5a935 100644
> > --- a/libsepol/src/link.c
> > +++ b/libsepol/src/link.c
> > @@ -165,7 +165,7 @@ static int permission_copy_callback(hashtab_key_t k=
ey, hashtab_datum_t datum,
> >                                              (hashtab_datum_t) new_perm=
);
> >                         if (ret) {
> >                                 ERR(state->handle,
> > -                                   "could not insert permission into c=
lass\n");
> > +                                   "could not insert permission into c=
lass");
> >                                 goto err;
> >                         }
> >                         new_perm->s.value =3D dest_class->permissions.n=
prim + 1;
> > @@ -289,7 +289,7 @@ static int class_copy_callback(hashtab_key_t key, h=
ashtab_datum_t datum,
> >                         new_class =3D
> >                             (class_datum_t *) calloc(1, sizeof(class_da=
tum_t));
> >                         if (new_class =3D=3D NULL) {
> > -                               ERR(state->handle, "Memory error\n");
> > +                               ERR(state->handle, "Memory error");
> >                                 ret =3D SEPOL_ERR;
> >                                 goto err;
> >                         }
> > @@ -300,7 +300,7 @@ static int class_copy_callback(hashtab_key_t key, h=
ashtab_datum_t datum,
> >                         }
> >                         new_id =3D strdup(id);
> >                         if (new_id =3D=3D NULL) {
> > -                               ERR(state->handle, "Memory error\n");
> > +                               ERR(state->handle, "Memory error");
> >                                 symtab_destroy(&new_class->permissions)=
;
> >                                 ret =3D SEPOL_ERR;
> >                                 goto err;
> > @@ -696,7 +696,7 @@ static int sens_copy_callback(hashtab_key_t key, ha=
shtab_datum_t datum,
> >                         return SEPOL_ENOTSUP;
> >                 } else {
> >                         ERR(state->handle,
> > -                           "%s: has an unknown scope: %d\n",
> > +                           "%s: has an unknown scope: %d",
> >                             state->cur_mod_name, scope->scope);
> >                         return SEPOL_ENOTSUP;
> >                 }
> > @@ -738,7 +738,7 @@ static int cat_copy_callback(hashtab_key_t key, has=
htab_datum_t datum,
> >                 } else {
> >                         /* unknown scope?  malformed policy? */
> >                         ERR(state->handle,
> > -                           "%s: has an unknown scope: %d\n",
> > +                           "%s: has an unknown scope: %d",
> >                             state->cur_mod_name, scope->scope);
> >                         return SEPOL_ENOTSUP;
> >                 }
> > @@ -1781,7 +1781,7 @@ static int copy_avrule_block(link_state_t * state=
, policy_module_t * module,
> >                 if (module->policy->name !=3D NULL) {
> >                         new_decl->module_name =3D strdup(module->policy=
->name);
> >                         if (new_decl->module_name =3D=3D NULL) {
> > -                               ERR(state->handle, "Out of memory\n");
> > +                               ERR(state->handle, "Out of memory");
> >                                 avrule_decl_destroy(new_decl);
> >                                 ret =3D -1;
> >                                 goto cleanup;
> > @@ -2208,7 +2208,7 @@ static int enable_avrules(link_state_t * state, p=
olicydb_t * pol)
> >                         if (state->verbose) {
> >                                 const char *mod_name =3D decl->module_n=
ame ?
> >                                     decl->module_name : "BASE";
> > -                               INFO(state->handle, "check module %s de=
cl %d\n",
> > +                               INFO(state->handle, "check module %s de=
cl %d",
> >                                      mod_name, decl->decl_id);
> >                         }
> >                         rc =3D is_decl_requires_met(state, decl, &req);
> > @@ -2554,7 +2554,7 @@ int link_modules(sepol_handle_t * handle,
> >
> >                 if (mods[i]->policyvers > b->policyvers) {
> >                         WARN(state.handle,
> > -                            "Upgrading policy version from %u to %u\n"=
, b->policyvers, mods[i]->policyvers);
> > +                            "Upgrading policy version from %u to %u", =
b->policyvers, mods[i]->policyvers);
> >                         b->policyvers =3D mods[i]->policyvers;
> >                 }
> >
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index 0f36ac53..7becfd1b 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -1553,7 +1553,7 @@ static int validate_class(hashtab_key_t key, hash=
tab_datum_t datum, void *p)
> >                      cladatum2->comdatum->permissions.table)) {
> >                         ERR(NULL,
> >                             " in the access vector definition "
> > -                           "for class %s\n", key);
> > +                           "for class %s", key);
> >                         return -1;
> >                 }
> >         }
> > --
> > 2.34.1
> >
