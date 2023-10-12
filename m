Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F831CDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441939AbjJLR4j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441848AbjJLR4i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:56:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16ACB8
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:56:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso16050501fa.0
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133395; x=1697738195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZFxCw3MBAMGUyq/CsmHi3i6d9Grc+o/A43ZXvezLRQ=;
        b=LcRbXCt5m6V2JGPRKbGOnc/hovHA6XxJ8sNdQpTVg9qexgKNRk08xMDOzc/PxGtZ0B
         4z6wtuR60sz9+8el37phi+S8Uosd4QhF67QPCnu6Jh3J+Hou1OHtaE0tjEh6AhrXCbEr
         NhBjlZdZJjKWu6UYnRunibOMW2HreAIrhfjG6OjpOV5IvdsmPx/ODaJ+EhmYvMGrjr1o
         v06dI9qWD+4tKZHQAEc6mE7y64hrdxye/wJiibCP6/36wmr8re7AOl8CmQkf/iXV5kBD
         zraTDRouhYPP+an4P2ZNq0ng6Rgx4IavF0kboP2kVv6cLxpR821QKEEqrDNvmvyoAosQ
         cEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133395; x=1697738195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZFxCw3MBAMGUyq/CsmHi3i6d9Grc+o/A43ZXvezLRQ=;
        b=lV5vx8UpaAqMOlmaFOeT1X8K5LUJySHwE3QMZCQ82I8D78+qv0NrUOosnaJd+vQHE3
         zDUQ53rsRBDRdir0qUUP4WQMdczt5g8cfUurMeYKFCr7gudvVsO9gEkZwdOCtHcZb/Yi
         2STlJFgF+1R9tsqkOpzfYKpWlRAQUAbeBkwfIelhtqeGN+Our2/zyTQwTajIGcwAssC6
         KJp9b1FnVHfoEZDtU/pWeIDduDOFrcjYp5UdI2EyMMnnnJv6pz1pcDGf7UBZqIZEZtQF
         KpMFCHwnb6utetQBIcvyW/5Ut3afOTscYGqmetzL5lxIKrQHt8NxScveRFPwgI52IuRN
         KBBA==
X-Gm-Message-State: AOJu0YxV8JB1ykpjjs1d5Z1cAd7kMHYJXOqEZsdIcRmU3lOFfIK+VSES
        6WWsGVU3aH0LajFsqGjORT3+rUyBDwS3e0qEBgE3gWFB9qA=
X-Google-Smtp-Source: AGHT+IGIlL30ZKL7J4VmMx4EeHuljRHqy8O2+CLWUrWrwKUJXc5Hcfjp6KEdPVQe9+H+zOoY8TerwLDz9qGgYaNiVfQ=
X-Received: by 2002:a05:6512:3154:b0:4fd:faa5:64ed with SMTP id
 s20-20020a056512315400b004fdfaa564edmr18390277lfi.11.1697133395111; Thu, 12
 Oct 2023 10:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-22-cgzones@googlemail.com> <CAP+JOzQqYAUo1=XNyD5DirbkrGeQwiq4DFyueOHQP-HocME7ug@mail.gmail.com>
In-Reply-To: <CAP+JOzQqYAUo1=XNyD5DirbkrGeQwiq4DFyueOHQP-HocME7ug@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:56:23 -0400
Message-ID: <CAP+JOzR9H73O67pSvuiemW-bjx7zew7s4KgvKNvA3AnrDiXqqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 21/27] libselinux: simplify internal
 selabel_validate prototype
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 11, 2023 at 2:49=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Move the check whether to validate or not to the caller, to avoid all
> > having to carry the complete selabel_handle around.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/label.c                  | 5 ++---
> >  libselinux/src/label_backends_android.c | 2 +-
> >  libselinux/src/label_file.c             | 2 +-
> >  libselinux/src/label_internal.h         | 3 +--
> >  libselinux/src/matchpathcon.c           | 7 ++++---
> >  5 files changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> > index 9a972f79..1ea9bdcd 100644
> > --- a/libselinux/src/label.c
> > +++ b/libselinux/src/label.c
> > @@ -119,12 +119,11 @@ static inline int selabel_is_validate_set(const s=
truct selinux_opt *opts,
> >         return 0;
> >  }
> >
> > -int selabel_validate(const struct selabel_handle *rec,
> > -                    struct selabel_lookup_rec *contexts)
> > +int selabel_validate(struct selabel_lookup_rec *contexts)
> >  {
> >         int rc =3D 0;
> >
> > -       if (!rec->validating || contexts->validated)
> > +       if (contexts->validated)
> >                 goto out;
> >
> >         rc =3D selinux_validate(&contexts->ctx_raw);
> > diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/l=
abel_backends_android.c
> > index 6494f3cd..cd3875fc 100644
> > --- a/libselinux/src/label_backends_android.c
> > +++ b/libselinux/src/label_backends_android.c
> > @@ -126,7 +126,7 @@ static int process_line(struct selabel_handle *rec,
> >                 spec_arr[nspec].lr.ctx_raw =3D context;
> >
> >                 if (rec->validating) {
> > -                       if (selabel_validate(rec, &spec_arr[nspec].lr) =
< 0) {
> > +                       if (selabel_validate(&spec_arr[nspec].lr) < 0) =
{
> >                                 selinux_log(SELINUX_ERROR,
> >                                             "%s:  line %u has invalid c=
ontext %s\n",
> >                                             path, lineno, spec_arr[nspe=
c].lr.ctx_raw);
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index a5677411..64b58d42 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -404,7 +404,7 @@ end_arch_check:
> >                 spec->lr.ctx_raw =3D str_buf;
> >
> >                 if (strcmp(spec->lr.ctx_raw, "<<none>>") && rec->valida=
ting) {
> > -                       if (selabel_validate(rec, &spec->lr) < 0) {
> > +                       if (selabel_validate(&spec->lr) < 0) {
> >                                 selinux_log(SELINUX_ERROR,
> >                                             "%s: context %s is invalid\=
n",
> >                                             path, spec->lr.ctx_raw);
> > diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_int=
ernal.h
> > index bc5a6928..ea60cd9a 100644
> > --- a/libselinux/src/label_internal.h
> > +++ b/libselinux/src/label_internal.h
> > @@ -118,8 +118,7 @@ struct selabel_handle {
> >   * Validation function
> >   */
> >  extern int
> > -selabel_validate(const struct selabel_handle *rec,
> > -                struct selabel_lookup_rec *contexts) ;
> > +selabel_validate(struct selabel_lookup_rec *contexts);
> >
> >  /*
> >   * Compatibility support
> > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathco=
n.c
> > index 971ace62..4ed25ce9 100644
> > --- a/libselinux/src/matchpathcon.c
> > +++ b/libselinux/src/matchpathcon.c
> > @@ -46,8 +46,8 @@ int compat_validate(const struct selabel_handle *rec,
> >                 rc =3D myinvalidcon(path, lineno, *ctx);
> >         else if (mycanoncon)
> >                 rc =3D mycanoncon(path, lineno, ctx);
> > -       else {
> > -               rc =3D selabel_validate(rec, contexts);
> > +       else if (rec->validating) {
> > +               rc =3D selabel_validate(contexts);
> >                 if (rc < 0) {
> >                         if (lineno) {
> >                                 COMPAT_LOG(SELINUX_WARNING,
> > @@ -58,7 +58,8 @@ int compat_validate(const struct selabel_handle *rec,
> >                                             "%s: has invalid context %s=
\n", path, *ctx);
> >                         }
> >                 }
> > -       }
> > +       } else
> > +               rc =3D 0;
> >
> >         return rc ? -1 : 0;
> >  }
> > --
> > 2.40.1
> >
