Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF9BC4167B
	for <selinux@archiver.kernel.org>; Tue,  7 Nov 2023 21:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjKGVmU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Nov 2023 16:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjKGVmT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Nov 2023 16:42:19 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F69110DF
        for <selinux@vger.kernel.org>; Tue,  7 Nov 2023 13:42:17 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50970c2115eso3732563e87.1
        for <selinux@vger.kernel.org>; Tue, 07 Nov 2023 13:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699393336; x=1699998136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8ci42MbUbx4w6wBh0LNDxz17jMJmlYKQDhw1EHNS1E=;
        b=SP4h2S0GOwVfDCxClZ8vmRBF980C5wF0nTTTjN4ZoE1R2RhIBtXt7dvMTcvEeJfHXr
         UFDMOZ2c5gPsM5kbgpbPsfrTVvWDIXTZVvgjDgMKwgE525OeUOxZU3cBoYGr4R0NfiI6
         zJJneThxe4bohyRbPv6AJGHhT3DCBONt+FAp14uz30Lcep21I2FA1N/82R/eblrslIRI
         IwTuu5Hlf9+OamZ3Gg/9qieAozUZ+e/brv2xnj6MQIyk2fx4MtmgV9gkL722A3/6dDEQ
         uuK/JKnFdqAQworA2P6zhwK0SGluKDW3jbPhurBNGdZZDZXfIrPeKrPcqi3lJTEhxrUZ
         SHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393336; x=1699998136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8ci42MbUbx4w6wBh0LNDxz17jMJmlYKQDhw1EHNS1E=;
        b=PIlIFeC4R4P/TvnZ9gB/pwNsaRiyl6mqDCPwTiVdRf4kslNyl5w/BRnKuYsdaBY4uf
         Sr6AB+O7bVztDqyzGXFIXcNrl9TCdCqhSSiJDj1ybYjjzCDCXs1lKczFdGcGAwDXujCA
         UqzlmHWDr0ADQucxs2kFRQDC57zfK5S+AN1kI5i+k/HF8Gk2KUVYviAZ7qVfSuN5AZju
         0St2+MjMqy8Qjp6YNPUDObxSzzqOAIVPDhJOS3sktsSxCoaOPELAJ4YkKjPbL8jzbuPf
         GisHvtltBbfa40+7pSWWTgo99efdb8t6n3pHEnlE8A9qJ0+4OZ/bAhRkO6xSlFCCzpl+
         02vw==
X-Gm-Message-State: AOJu0YyF7W+FRfNZtPGf6tW0tGkt+GabaAyUcW59+2bfhtZPceK8CnEU
        R4Ft3H49jI4EG/cImw9aRraforE+i6CnRZYV694=
X-Google-Smtp-Source: AGHT+IGqBqfllkYcu6X92Jqq0sCjsqCYOb9YB0glYYagNLX5YfEU8kA+UBtgXT3ifWWU0FqwOCEkroq9MAxCYqIz43M=
X-Received: by 2002:a05:6512:2349:b0:507:bc6b:38a6 with SMTP id
 p9-20020a056512234900b00507bc6b38a6mr32662703lfu.33.1699393335507; Tue, 07
 Nov 2023 13:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20231101163754.177452-1-cgzones@googlemail.com> <CAP+JOzSGwx3f4MrtnXtMWwr8AcG46RpQG3qW-A0bMVBPYapEfw@mail.gmail.com>
In-Reply-To: <CAP+JOzSGwx3f4MrtnXtMWwr8AcG46RpQG3qW-A0bMVBPYapEfw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Nov 2023 16:42:04 -0500
Message-ID: <CAP+JOzS7xgpzQuQo66fW8uPrd25_anCpzqacLA8J5PsA1vypMA@mail.gmail.com>
Subject: Re: [PATCH] libselinux/utils: update getdefaultcon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 2, 2023 at 11:42=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Nov 1, 2023 at 12:38=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > * mention -r <role> and -v command line options in usage string
> > * use distinct error messages on getseuser(3) and
> >   get_default_context_with_[role]level(3) failure
> > * always print program name on error
> > * drop unnecessary double parenthesis
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/utils/getdefaultcon.c | 40 ++++++++++++++++++--------------
> >  1 file changed, 23 insertions(+), 17 deletions(-)
> >
> > diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdef=
aultcon.c
> > index 93102e5e..50f1ea91 100644
> > --- a/libselinux/utils/getdefaultcon.c
> > +++ b/libselinux/utils/getdefaultcon.c
> > @@ -11,7 +11,7 @@
> >
> >  static __attribute__ ((__noreturn__)) void usage(const char *name, con=
st char *detail, int rc)
> >  {
> > -       fprintf(stderr, "usage:  %s [-l level] [-s service] user [fromc=
on]\n", name);
> > +       fprintf(stderr, "usage:  %s [-r role] [-l level] [-s service] [=
-v] user [fromcon]\n", name);
> >         if (detail)
> >                 fprintf(stderr, "%s:  %s\n", name, detail);
> >         exit(rc);
> > @@ -60,9 +60,9 @@ int main(int argc, char **argv)
> >         user =3D argv[optind];
> >
> >         /* If a context wasn't passed, use the current context. */
> > -       if (((argc - optind) < 2)) {
> > +       if ((argc - optind) < 2) {
> >                 if (getcon(&cur_context) < 0) {
> > -                       fprintf(stderr, "Couldn't get current context: =
 %s\n", strerror(errno));
> > +                       fprintf(stderr, "%s:  couldn't get current cont=
ext:  %s\n", argv[0], strerror(errno));
> >                         return 2;
> >                 }
> >         } else
> > @@ -73,23 +73,29 @@ int main(int argc, char **argv)
> >                 return 3;
> >         }
> >
> > -       if ((ret =3D getseuser(user, service, &seuser, &dlevel)) =3D=3D=
 0) {
> > -               if (! level) level=3Ddlevel;
> > -               if (role !=3D NULL && role[0])
> > -                       ret=3Dget_default_context_with_rolelevel(seuser=
, role, level,cur_context,&usercon);
> > -               else
> > -                       ret=3Dget_default_context_with_level(seuser, le=
vel, cur_context,&usercon);
> > +       ret =3D getseuser(user, service, &seuser, &dlevel);
> > +       if (ret) {
> > +               fprintf(stderr, "%s:  failed to get seuser:  %s\n", arg=
v[0], strerror(errno));
> > +               goto out;
> >         }
> > -       if (ret < 0)
> > -               perror(argv[0]);
> > -       else {
> > -               if (verbose) {
> > -                       printf("%s: %s from %s %s %s %s -> %s\n", argv[=
0], user, cur_context, seuser, role, level, usercon);
> > -               } else {
> > -                       printf("%s\n", usercon);
> > -               }
> > +
> > +       if (! level) level=3Ddlevel;
> > +       if (role !=3D NULL && role[0])
> > +               ret =3D get_default_context_with_rolelevel(seuser, role=
, level, cur_context, &usercon);
> > +       else
> > +               ret =3D get_default_context_with_level(seuser, level, c=
ur_context, &usercon);
> > +       if (ret) {
> > +               fprintf(stderr, "%s:  failed to get default context:  %=
s\n", argv[0], strerror(errno));
> > +               goto out;
> > +       }
> > +
> > +       if (verbose) {
> > +               printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user=
, cur_context, seuser, role, level, usercon);
> > +       } else {
> > +               printf("%s\n", usercon);
> >         }
> >
> > +out:
> >         free(role);
> >         free(seuser);
> >         if (level !=3D dlevel) free(level);
> > --
> > 2.42.0
> >
