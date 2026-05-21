Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C251A239A
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373416; cv=pass; b=EgEBJfYk3JuYkXESk1Bm8/VYFE/kryq2jrQOL79s+foGQVU6Di3RI2ynKKTOHglHBsc5mcoUetQD5CHdWIG2ZVEMhYDU9R+cmBEWmYXtJuOYnepp5ACSkUqOCwOmXE9iDromr+Ap6p80un1CCyeJeJRYzvflCkJBil5F/ceVkVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373416; c=relaxed/simple;
	bh=mDBMzMiqkeMa1S4tkOXeB9HW8jreGEmFE4xwg4QUL2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K42Ak1FFDKoPyAcB9tDfRdZC/DtK7dmz4gI5zEEMg4RO0cEope8PFUIH46EZwoguDm6HH6eVumTkXkc0VQ+MVJ3GQQlHZgI4Yy9q/4ep1ak1nfXx8brCdYIth6NZG/2wfe+OJCWiCXXd/UhSbwve//WltTAJp2pP5KCGdCRL+Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzOvJ31X; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzOvJ31X"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3922b35e69cso54840481fa.0
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 07:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779373413; cv=none;
        d=google.com; s=arc-20240605;
        b=BbR8Cb+6Eg+Ip4hxwRUs7pBoYJlTo0Lurz8eZ65sq1HUv9QsfbpfUaqVk+xnhc3eyY
         yxYB2ST2uXSQ2WAvyB6nXXCfF/WuBbVFWoT0wnz4XuL7uHFSurFgPOECT4WbaiAxSzuc
         XTJveqm4K5XfyXsfyIiGcRvtBJQRH+CyNHtqa3P7nlCb2GVtithyVQM7pegnDnlRnf2z
         Gd34s98lz1JJ4SW+4DRm4cBlEtAH+vW2F7U4+B8nUpUwWun13nCKRB2Ci4M8TrsVbmuZ
         0ydR5yeSlOxUyolc2Aa63QExgqOJ0E/LQT4z0iv4Mza9+twfG4rthdwp6mzLWUf8IihY
         F/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J8/J5iifF0bjXzfbEqYS3iTAfRasR4aZ+KiA4BKFpzE=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=Tn+3BB4XUYV1MesdSlNzk09Q7X5+bN/8ldi+KI9KZfSIGjggdYikWkP4v5TVzm+9KW
         e66N9vyFfiT40EFynlUPR+4qYqLYPMd6sW7lwGVV7dGWo5t2ccaebbUHgxaRAmS3hu2x
         DT57jVYKpcbx5IgAYE6pO6F/BSE0ZToV5895/We1i615flKT5wToqydGzk0WmGehnZ5m
         1+TZ4tbNaY48VM9NZaZvHyiNvwH0B//f7CUWBBUgq8lOk17nvOIDsxpm6mNKNfxTr7GG
         TNck5nnw9/P2NcVyinFXYTFZrdi2XcNy9iM01d2eH7vkmtWsCVqYxoTEyZT5o44xY4Kz
         v2Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779373413; x=1779978213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8/J5iifF0bjXzfbEqYS3iTAfRasR4aZ+KiA4BKFpzE=;
        b=JzOvJ31XY9+64FL4za1rr9QzZQbxdd7hr69G32WOz8k7E1qC4NrsGoNMUEFbiDvggI
         L7bsuYnh2p+JxpivULhD6VdCfIqHSvHcMSkL3AcYJWhxXLuRtCXozcGf+eHd5qyMG0hc
         e9JVOo6Fz6QtPcFFjNzmtvzWVHHTz5D/ZALqYz6HSpUvAGH/iRXYGGM+2nN2lnVek/kU
         Xf78df2K2hJqTaSnDEvLoaHieBxbzmuA4KIaNGPt33CqlZ5Uv4F48E2DTX5vUqHVbn8X
         EFv1/rTuVIIzmiXuFXpN9+N2U1u9vwvqyUlX2rXDsxDdXG12ZDrc6UNvi+jUq8dip3Wm
         2+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373413; x=1779978213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J8/J5iifF0bjXzfbEqYS3iTAfRasR4aZ+KiA4BKFpzE=;
        b=Gh77jT95y8yWHiPGnAg76+jEGTr6/iPS0JScn30+lRfQHW/e5XcS9lt3TrSrfZIcB7
         TPT+NkDS/tNmWJg/SbsC3FAbfKoMyy9Y4PMqZBq8+mmxy+CRea6SGYsIKF0q4G9f2dQr
         tSZo96VI6DB0QoCYn87dG3kmO26ORUGUiuDjjMdnE++11REhRUWRlIv3omW9pBrE+x4U
         W96yoiI/QRx/tXGPd+QMpVsVmOVe4H3+8CoymnwzqUoUJ+5gd5xjKWQrUuhTCvWN9UYn
         3Vrn0vL1xUjBoEGsXrRAYwUSWp6vQ1T6C3bQKGmycEQ4RkKu/Zwa258L0GtSFXmUFFNQ
         LNBQ==
X-Gm-Message-State: AOJu0YwU3R3L1L9IBQMbAug4EJITiVSr9KnjGtOGeo4I/POveqsTo9Rp
	DaLt5oG0/szAybtoHzdpPViStZYRt5WqIRI9ivPZXj5GYTKSGmTDAseeFA6Lb84c/TXcS1Gycfy
	XsSYpLokvx1gnccanNsYU0+5ve/K6hKPxPQ==
X-Gm-Gg: Acq92OEzq2oUxDyGvr74R5z4/BQMz1HefnKNYEMENpLjIG6k0Ypb+URYFGTD8uiGma1
	40NMSwSFqJ+/jUVUNOvgRCeGcRZzVEPlVnp77bRrYRPn0zL3zLEDhGV2OIp6RWYT4GjIkC4k2CB
	0+VeRcZb0gaUpLIVvPtBJPbLBIeYnunfLwUsr+/blvPgwmqTWANTUtCK7WiHlG1boDrZnHbtAKo
	XdHqTxn4o06YfbzrsRcbGLr3H9ia+iEZ4kSDWqgPGFD2gJ/+yJa7p8OWzDnRREmsUZINPKQZ45h
	ANTgSOjhJ5wfrAQ=
X-Received: by 2002:a2e:a542:0:b0:38e:83a6:d37 with SMTP id
 38308e7fff4ca-395ca564dabmr15560501fa.13.1779373412273; Thu, 21 May 2026
 07:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514204236.96433-1-kalevi@kolttonen.fi> <CAP+JOzQnUGH=8uB9ktzjGOOMh=m-do0zWHhpv3Vu=auhFvCnCA@mail.gmail.com>
In-Reply-To: <CAP+JOzQnUGH=8uB9ktzjGOOMh=m-do0zWHhpv3Vu=auhFvCnCA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 21 May 2026 10:23:20 -0400
X-Gm-Features: AVHnY4JIRjw3smUG_pSW_RilnvGu3XDRrqATygn_LmI5IzkZpwnmu5ihK67wNqM
Message-ID: <CAP+JOzT9OCKiQiuW8-3zC27rWjyuzxqeQ0SnT7vK5uM5TrJ2xA@mail.gmail.com>
Subject: Re: [PATCH v3] libsemanage: use 'bool' for boolean options
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:01=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, May 14, 2026 at 4:42=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttone=
n.fi> wrote:
> >
> > Use 'bool' for boolean options. Check strdup() failures.
> > Add explicit 'conf->disable_genhomedircon =3D false' default
> > initialization.
> >
> > Add missing <stdbool.h> include.
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/src/conf-parse.y    | 68 ++++++++++++++++++---------------
> >  libsemanage/src/direct_api.c    |  2 +-
> >  libsemanage/src/handle.c        |  2 +-
> >  libsemanage/src/semanage_conf.h | 21 +++++-----
> >  4 files changed, 51 insertions(+), 42 deletions(-)
> >
> > diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.=
y
> > index b69ac75b..0f10546e 100644
> > --- a/libsemanage/src/conf-parse.y
> > +++ b/libsemanage/src/conf-parse.y
> > @@ -29,6 +29,7 @@
> >
> >  #include <errno.h>
> >  #include <unistd.h>
> > +#include <stdbool.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > @@ -132,9 +133,9 @@ compiler_dir:       COMPILER_DIR '=3D' ARG  {
> >
> >  ignore_module_cache:   IGNORE_MODULE_CACHE '=3D' ARG  {
> >                                                         if (strcasecmp(=
$3, "true") =3D=3D 0)
> > -                                                               current=
_conf->ignore_module_cache =3D 1;
> > +                                                               current=
_conf->ignore_module_cache =3D true;
> >                                                         else if (strcas=
ecmp($3, "false") =3D=3D 0)
> > -                                                               current=
_conf->ignore_module_cache =3D 0;
> > +                                                               current=
_conf->ignore_module_cache =3D false;
> >                                                         else {
> >                                                                 yyerror=
("disable-caching can only be 'true' or 'false'");
> >                                                         }
> > @@ -195,9 +196,9 @@ file_mode:   FILE_MODE '=3D' ARG  {
> >
> >  save_previous:    SAVE_PREVIOUS '=3D' ARG {
> >                         if (strcasecmp($3, "true") =3D=3D 0)
> > -                               current_conf->save_previous =3D 1;
> > +                               current_conf->save_previous =3D true;
> >                         else if (strcasecmp($3, "false") =3D=3D 0)
> > -                               current_conf->save_previous =3D 0;
> > +                               current_conf->save_previous =3D false;
> >                         else {
> >                                 yyerror("save-previous can only be 'tru=
e' or 'false'");
> >                         }
> > @@ -208,9 +209,9 @@ save_previous:    SAVE_PREVIOUS '=3D' ARG {
> >
> >  save_linked:    SAVE_LINKED '=3D' ARG {
> >                         if (strcasecmp($3, "true") =3D=3D 0)
> > -                               current_conf->save_linked =3D 1;
> > +                               current_conf->save_linked =3D true;
> >                         else if (strcasecmp($3, "false") =3D=3D 0)
> > -                               current_conf->save_linked =3D 0;
> > +                               current_conf->save_linked =3D false;
> >                         else {
> >                                 yyerror("save-linked can only be 'true'=
 or 'false'");
> >                         }
> > @@ -220,9 +221,9 @@ save_linked:    SAVE_LINKED '=3D' ARG {
> >
> >  disable_genhomedircon: DISABLE_GENHOMEDIRCON '=3D' ARG {
> >         if (strcasecmp($3, "false") =3D=3D 0) {
> > -               current_conf->disable_genhomedircon =3D 0;
> > +               current_conf->disable_genhomedircon =3D false;
> >         } else if (strcasecmp($3, "true") =3D=3D 0) {
> > -               current_conf->disable_genhomedircon =3D 1;
> > +               current_conf->disable_genhomedircon =3D true;
> >         } else {
> >                 yyerror("disable-genhomedircon can only be 'true' or 'f=
alse'");
> >         }
> > @@ -231,9 +232,9 @@ disable_genhomedircon: DISABLE_GENHOMEDIRCON '=3D' =
ARG {
> >
> >  usepasswd: USEPASSWD '=3D' ARG {
> >         if (strcasecmp($3, "false") =3D=3D 0) {
> > -               current_conf->usepasswd =3D 0;
> > +               current_conf->usepasswd =3D false;
> >         } else if (strcasecmp($3, "true") =3D=3D 0) {
> > -               current_conf->usepasswd =3D 1;
> > +               current_conf->usepasswd =3D true;
> >         } else {
> >                 yyerror("usepasswd can only be 'true' or 'false'");
> >         }
> > @@ -272,9 +273,9 @@ bzip_blocksize:  BZIP_BLOCKSIZE '=3D' ARG {
> >
> >  bzip_small:  BZIP_SMALL '=3D' ARG {
> >         if (strcasecmp($3, "false") =3D=3D 0) {
> > -               current_conf->bzip_small =3D 0;
> > +               current_conf->bzip_small =3D false;
> >         } else if (strcasecmp($3, "true") =3D=3D 0) {
> > -               current_conf->bzip_small =3D 1;
> > +               current_conf->bzip_small =3D true;
> >         } else {
> >                 yyerror("bzip-small can only be 'true' or 'false'");
> >         }
> > @@ -283,9 +284,9 @@ bzip_small:  BZIP_SMALL '=3D' ARG {
> >
> >  remove_hll:  REMOVE_HLL'=3D' ARG {
> >         if (strcasecmp($3, "false") =3D=3D 0) {
> > -               current_conf->remove_hll =3D 0;
> > +               current_conf->remove_hll =3D false;
> >         } else if (strcasecmp($3, "true") =3D=3D 0) {
> > -               current_conf->remove_hll =3D 1;
> > +               current_conf->remove_hll =3D true;
> >         } else {
> >                 yyerror("remove-hll can only be 'true' or 'false'");
> >         }
> > @@ -294,9 +295,9 @@ remove_hll:  REMOVE_HLL'=3D' ARG {
> >
> >  relabel_store:  RELABEL_STORE'=3D' ARG {
> >         if (strcasecmp($3, "false") =3D=3D 0) {
> > -               current_conf->relabel_store =3D 0;
> > +               current_conf->relabel_store =3D false;
> >         } else if (strcasecmp($3, "true") =3D=3D 0) {
> > -               current_conf->relabel_store =3D 1;
> > +               current_conf->relabel_store =3D true;
> >         } else {
> >                 yyerror("relabel_store can only be 'true' or 'false'");
> >         }
> > @@ -305,9 +306,9 @@ relabel_store:  RELABEL_STORE'=3D' ARG {
> >
> >  optimize_policy:  OPTIMIZE_POLICY '=3D' ARG {
> >         if (strcasecmp($3, "false") =3D=3D 0) {
> > -               current_conf->optimize_policy =3D 0;
> > +               current_conf->optimize_policy =3D false;
> >         } else if (strcasecmp($3, "true") =3D=3D 0) {
> > -               current_conf->optimize_policy =3D 1;
> > +               current_conf->optimize_policy =3D true;
> >         } else {
> >                 yyerror("optimize-policy can only be 'true' or 'false'"=
);
> >         }
> > @@ -316,9 +317,9 @@ optimize_policy:  OPTIMIZE_POLICY '=3D' ARG {
> >
> >  multiple_decls:  MULTIPLE_DECLS '=3D' ARG {
> >         if (strcasecmp($3, "false") =3D=3D 0) {
> > -               current_conf->multiple_decls =3D 0;
> > +               current_conf->multiple_decls =3D false;
> >         } else if (strcasecmp($3, "true") =3D=3D 0) {
> > -               current_conf->multiple_decls =3D 1;
> > +               current_conf->multiple_decls =3D true;
> >         } else {
> >                 yyerror("multiple-decls can only be 'true' or 'false'")=
;
> >         }
> > @@ -398,26 +399,33 @@ static int semanage_conf_init(semanage_conf_t * c=
onf)
> >         const char *policy_root =3D selinux_policy_root();
> >         if (policy_root !=3D NULL) {
> >                 conf->store_path =3D strdup(semanage_basename(policy_ro=
ot));
> > +               if (!conf->store_path)
> > +                       return -1;
> >         }
> >         conf->ignoredirs =3D NULL;
> >         conf->store_root_path =3D strdup("/var/lib/selinux");
> > +       if (!conf->store_root_path)
> > +               return -1;
> >         conf->compiler_directory_path =3D strdup("/usr/libexec/selinux/=
hll");
> > +       if (!conf->compiler_directory_path)
> > +               return -1;
> >         conf->policyvers =3D sepol_policy_kern_vers_max();
> >         conf->target_platform =3D SEPOL_TARGET_SELINUX;
> >         conf->expand_check =3D 1;
> >         conf->handle_unknown =3D -1;
> > -       conf->usepasswd =3D 1;
> > +       conf->usepasswd =3D true;
> >         conf->file_mode =3D 0644;
> >         conf->bzip_blocksize =3D 9;
> > -       conf->bzip_small =3D 0;
> > -       conf->ignore_module_cache =3D 0;
> > -       conf->remove_hll =3D 0;
> > -       conf->relabel_store =3D 1;
> > -       conf->optimize_policy =3D 1;
> > -       conf->multiple_decls =3D 1;
> > -
> > -       conf->save_previous =3D 0;
> > -       conf->save_linked =3D 0;
> > +       conf->bzip_small =3D false;
> > +       conf->ignore_module_cache =3D false;
> > +       conf->remove_hll =3D false;
> > +       conf->relabel_store =3D true;
> > +       conf->optimize_policy =3D true;
> > +       conf->multiple_decls =3D true;
> > +
> > +       conf->save_previous =3D false;
> > +       conf->save_linked =3D false;
> > +       conf->disable_genhomedircon =3D false;
> >
> >         if (!conf->store_path ||
> >             !conf->store_root_path ||
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.=
c
> > index 8f909a3b..9593bf69 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -992,7 +992,7 @@ static int semanage_compile_module(semanage_handle_=
t *sh,
> >                 goto cleanup;
> >         }
> >
> > -       if (sh->conf->remove_hll =3D=3D 1) {
> > +       if (sh->conf->remove_hll) {
> >                 status =3D unlink(hll_path);
> >                 if (status !=3D 0) {
> >                         ERR(sh, "Error while removing HLL file %s.", hl=
l_path);
> > diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
> > index ca57702a..2b3f1e61 100644
> > --- a/libsemanage/src/handle.c
> > +++ b/libsemanage/src/handle.c
> > @@ -231,7 +231,7 @@ void semanage_set_ignore_module_cache(semanage_hand=
le_t *sh,
> >                                     int ignore_module_cache)
> >  {
> >         assert(sh !=3D NULL);
> > -       sh->conf->ignore_module_cache =3D ignore_module_cache;
> > +       sh->conf->ignore_module_cache =3D !!ignore_module_cache;
> >  }
> >
> >  void semanage_set_check_contexts(semanage_handle_t * sh, int do_check_=
contexts)
> > diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage=
_conf.h
> > index 2388faad..4df9b195 100644
> > --- a/libsemanage/src/semanage_conf.h
> > +++ b/libsemanage/src/semanage_conf.h
> > @@ -21,6 +21,7 @@
> >  #define SEMANAGE_CONF_H
> >
> >  #include <semanage/handle.h>
> > +#include <stdbool.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> >
> > @@ -37,19 +38,19 @@ typedef struct semanage_conf {
> >         int policyvers;         /* version for server generated policie=
s */
> >         int target_platform;
> >         int expand_check;
> > -       int save_previous;
> > -       int save_linked;
> > -       int disable_genhomedircon;
> > -       int usepasswd;
> > +       bool save_previous;
> > +       bool save_linked;
> > +       bool disable_genhomedircon;
> > +       bool usepasswd;
> >         int handle_unknown;
> >         mode_t file_mode;
> >         int bzip_blocksize;
> > -       int bzip_small;
> > -       int remove_hll;
> > -       int ignore_module_cache;
> > -       int optimize_policy;
> > -       int multiple_decls;
> > -       int relabel_store;
> > +       bool bzip_small;
> > +       bool remove_hll;
> > +       bool ignore_module_cache;
> > +       bool optimize_policy;
> > +       bool multiple_decls;
> > +       bool relabel_store;
> >         char *ignoredirs;       /* ";" separated of list for genhomedir=
con to ignore */
> >         struct external_prog *load_policy;
> >         struct external_prog *setfiles;
> > --
> > 2.54.0
> >
> >
