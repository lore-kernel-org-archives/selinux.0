Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA06C433E0
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 14:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA0F22211
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 14:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSmdAjpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgEVOSO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 10:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgEVOSN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 10:18:13 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B70C061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 07:18:13 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l6so9403822oic.9
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F5CgNedxw539NB9OzrJN4eE0eqRPSa80SiwvvWanR1g=;
        b=QSmdAjpSfVu/ancdp0CnDmr4hzIHqWNFdyAatxXSIiAcknkquPlNTa+IkaRKg0GHE3
         exzcNlBrh+hOQm8w2Oyazuh+G3QsTRSW0cnBznGqk1THFuU/QEgRcsvYkK4vRglS+0EZ
         l4EvPXA7mgvTiW/ruS/9DpCfZmwN5Nz/+sUd8ZjHdu8Ag+kZE8eIlpuZL/sFob73H3Zd
         /9JIVwgEyABRRH5g5P7xwfEAEUp/iGugE56NsB7LIPf3ANWZ03jABieCgMQbANcAPaBf
         ffvdWt+rAeki3aKsL0+fDzUEM4XIQcaxP2L2TKEktwYm4tV+glvqr2Rj7VZekgVkLzjZ
         d56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F5CgNedxw539NB9OzrJN4eE0eqRPSa80SiwvvWanR1g=;
        b=NDeJ3NDQey1GLCE+DYVIlqHbITzELde63bkvzZZYst5S9eQiXam+D3URKUzTecjjRP
         aBdqHqKBrutwzWksWurwYxy52eNJlsw78BWlVoxMSEqs1AC0ufivM3gLxfMrmKunKlDF
         GGCHg8qmLUkjxzWO3ckb9ajDv07UPi7cbA1jTVK1On1HB4ueWkz7zubVJoV2G+KnM8TA
         18BjeBU0JtZ9bogYPOurb/2yx5Afi7UVSsXBX1iyw+Gbss2QUsMfLYyv4TtOp/dsLlDL
         GwfTh9X0e+FKSo8RHlnPzs7kVF1H39RHw/sn9JvZQ5PE8tcalgJRQln7Gz83r2o8yPvN
         Avzw==
X-Gm-Message-State: AOAM5301hUyNDeKlcBWLeU42CXNLvD+v1TJyOG7uUQPmr4VJZXvOssz8
        WHmoOe7tTm5058abP6OGjNEL3BzQSDzKI5k/TYM=
X-Google-Smtp-Source: ABdhPJxNqskRMi12pmVeiuBwtSAvHUMFTvAXy3NjIgVLsuVmrhNU5f1gADz2VBznYhtNM35TmdO+sDk8RkJasXwXlt4=
X-Received: by 2002:aca:4155:: with SMTP id o82mr2905293oia.16.1590157092905;
 Fri, 22 May 2020 07:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200521152448.148333-1-jwcart2@gmail.com> <20200521152448.148333-2-jwcart2@gmail.com>
 <CAJfZ7=nEpgceRy6tDZL6XUBsVhX9Y+u-hCaYpUCiREgJiCxONA@mail.gmail.com>
In-Reply-To: <CAJfZ7=nEpgceRy6tDZL6XUBsVhX9Y+u-hCaYpUCiREgJiCxONA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 22 May 2020 10:18:00 -0400
Message-ID: <CAP+JOzSYf-5WS1LzjaQuYPJ8mgZUBU45=g3HgFv=x9QZXWaDLw@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol: Improve writing CIL sensitivity rules
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 21, 2020 at 3:16 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote=
:
>
> On Thu, May 21, 2020 at 5:25 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Improves writing of CIL sensitivity rules when converting MLS kernel
> > policy to CIL. No changes to functionality, but eliminate useless
> > checks for sensitivity aliases when using the p_sens_val_to_name
> > array, find the actual number of aliases before allocating memory,
> > and skip the sensitivity alias rules if there are no aliases.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/src/kernel_to_cil.c | 59 ++++++++++++++++++------------------
> >  1 file changed, 29 insertions(+), 30 deletions(-)
> >
> > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.=
c
> > index cca77251..6103c1a6 100644
> > --- a/libsepol/src/kernel_to_cil.c
> > +++ b/libsepol/src/kernel_to_cil.c
> > @@ -782,6 +782,17 @@ static void write_default_mls_level(FILE *out)
> >         sepol_printf(out, "(level %s (s0))\n", DEFAULT_LEVEL);
> >  }
> >
> > +static int map_count_sensitivity_aliases(char *key, void *data, void *=
args)
> > +{
> > +       level_datum_t *sens =3D data;
> > +       unsigned *count =3D args;
> > +
> > +       if (sens->isalias)
> > +               (*count)++;
> > +
> > +       return SEPOL_OK;
> > +}
>
> Hello,
> This patch looks good to me, but building fails because of an unused
> parameter (here and in other patches),
> https://travis-ci.org/github/fishilico/selinux/jobs/689760790#L2029 :
>
> kernel_to_cil.c: In function =E2=80=98map_count_sensitivity_aliases=E2=80=
=99:
> kernel_to_cil.c:785:48: error: unused parameter =E2=80=98key=E2=80=99 [-W=
error=3Dunused-parameter]
>  static int map_count_sensitivity_aliases(char *key, void *data, void *ar=
gs)
>                                                 ^~~
> kernel_to_cil.c: In function =E2=80=98map_count_category_aliases=E2=80=99=
:
> kernel_to_cil.c:889:45: error: unused parameter =E2=80=98key=E2=80=99 [-W=
error=3Dunused-parameter]
>  static int map_count_category_aliases(char *key, void *data, void *args)
>                                              ^~~
> kernel_to_cil.c: In function =E2=80=98map_count_type_aliases=E2=80=99:
> kernel_to_cil.c:1368:41: error: unused parameter =E2=80=98key=E2=80=99
> [-Werror=3Dunused-parameter]
>  static int map_count_type_aliases(char *key, void *data, void *args)
>                                         ^~~
>
> Other functions use __attribute__((unused)) so you could probably use
> it too in these functions.
>

Thanks, I'll update these patches and resend.

Jim

> Thanks,
> Nicolas
>
> > +
> >  static int map_sensitivity_aliases_to_strs(char *key, void *data, void=
 *args)
> >  {
> >         level_datum_t *sens =3D data;
> > @@ -799,26 +810,13 @@ static int write_sensitivity_rules_to_cil(FILE *o=
ut, struct policydb *pdb)
> >  {
> >         level_datum_t *level;
> >         char *prev, *name, *actual;
> > -       struct strs *strs;
> > -       unsigned i, num;
> > +       struct strs *strs =3D NULL;
> > +       unsigned i, num =3D 0;
> >         int rc =3D 0;
> >
> > -       rc =3D strs_init(&strs, pdb->p_levels.nprim);
> > -       if (rc !=3D 0) {
> > -               goto exit;
> > -       }
> > -
> >         /* sensitivities */
> >         for (i=3D0; i < pdb->p_levels.nprim; i++) {
> >                 name =3D pdb->p_sens_val_to_name[i];
> > -               if (!name) continue;
> > -               level =3D hashtab_search(pdb->p_levels.table, name);
> > -               if (!level) {
> > -                       rc =3D -1;
> > -                       goto exit;
> > -               }
> > -               if (level->isalias) continue;
> > -
> >                 sepol_printf(out, "(sensitivity %s)\n", name);
> >         }
> >
> > @@ -827,14 +825,6 @@ static int write_sensitivity_rules_to_cil(FILE *ou=
t, struct policydb *pdb)
> >         prev =3D NULL;
> >         for (i=3D0; i < pdb->p_levels.nprim; i++) {
> >                 name =3D pdb->p_sens_val_to_name[i];
> > -               if (!name) continue;
> > -               level =3D hashtab_search(pdb->p_levels.table, name);
> > -               if (!level) {
> > -                       rc =3D -1;
> > -                       goto exit;
> > -               }
> > -               if (level->isalias) continue;
> > -
> >                 if (prev) {
> >                         sepol_printf(out, "%s ", prev);
> >                 }
> > @@ -845,6 +835,22 @@ static int write_sensitivity_rules_to_cil(FILE *ou=
t, struct policydb *pdb)
> >         }
> >         sepol_printf(out, "))\n");
> >
> > +       rc =3D hashtab_map(pdb->p_levels.table, map_count_sensitivity_a=
liases, &num);
> > +       if (rc !=3D 0) {
> > +               goto exit;
> > +       }
> > +
> > +       if (num =3D=3D 0) {
> > +               /* No aliases, so skip sensitivity alias rules */
> > +               rc =3D 0;
> > +               goto exit;
> > +       }
> > +
> > +       rc =3D strs_init(&strs, num);
> > +       if (rc !=3D 0) {
> > +               goto exit;
> > +       }
> > +
> >         rc =3D hashtab_map(pdb->p_levels.table, map_sensitivity_aliases=
_to_strs, strs);
> >         if (rc !=3D 0) {
> >                 goto exit;
> > @@ -852,16 +858,9 @@ static int write_sensitivity_rules_to_cil(FILE *ou=
t, struct policydb *pdb)
> >
> >         strs_sort(strs);
> >
> > -       num =3D strs_num_items(strs);
> > -
> >         /* sensitivity aliases */
> >         for (i=3D0; i < num; i++) {
> >                 name =3D strs_read_at_index(strs, i);
> > -               level =3D hashtab_search(pdb->p_levels.table, name);
> > -               if (!level) {
> > -                       rc =3D -1;
> > -                       goto exit;
> > -               }
> >                 sepol_printf(out, "(sensitivityalias %s)\n", name);
> >         }
> >
> > --
> > 2.25.4
> >
>
