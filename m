Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34422C433EF
	for <selinux@archiver.kernel.org>; Mon, 16 May 2022 17:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344110AbiEPROK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 May 2022 13:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiEPROJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 May 2022 13:14:09 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD3532ECB
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:14:08 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so20975832fac.7
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N4IDTTetA4isW2EYHnXJe79pEeDlOTrbwFQ/6ns9wsE=;
        b=XOjw4fublbMNwAzONIcF75NX8goCi/PNohvFs8oti8q2svcn59B0sd9wqjJ/UFjINc
         5jqbpS1gSm8bXprIiE4fgV7ZSx+pDO6gJjeKn1LlL7h38IIU/9vQ2pPSaWQHBdhhqB6/
         iCnN+HAtVZNsLNyShgV+NovXGzS13AQ5ZGT8KRz5i1URAwvQKqcIII0BG2M9hL/NNEql
         tkvNg0lIkRoL9BjhCjuBrJUmW60ISsMMcKD22ulVXxaXGSv0KkvFu1Hn+q6aXpxog6lT
         F49cmkJ89FlrKZNX6IRdkJur0Ow1nHiHngS/1nObaLGmZi9h8xzBLXgnIVm6DhGnNhIx
         3wBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N4IDTTetA4isW2EYHnXJe79pEeDlOTrbwFQ/6ns9wsE=;
        b=omOz5H+W6YuwQUZ3ZEwJGH0uRgoDM44ABgKQLNbGxjaEY6RvfXtWpcPqRRW68MBYl4
         4Qxie8lyxB7UMs4nfP6y3xzj/bG8UJRWilDI5/rgn7eZwi/QsXRgNzzTL3XKyC6cDSq/
         EdAmgYAt1JeJE6luqLsh4SV5sqXM/YDJPZ4RH7tgfXEN7RT4n3UonLNSXKUyCzteuDFY
         N6PqVGgmvzeWxKf2NiT0vvjKigDyDsLFX8kojwajvgWPoY6QuTis9+EW3MnVvkd2XItX
         4Sobk2axh0kb8OpIz6QmUmWLVXeizKcImv0J4j1knT4BgLX3wGNXUGxUfUvR/L+kv0QL
         CdoA==
X-Gm-Message-State: AOAM533qxDzLHFwzN+tmhB7xuOwwndlAATc796RewO4RWE0HQwqUuzVp
        58I1Cnb7CH4Ir+j+hiIJjsKq2aiBYaIjfia+T7Deenzv
X-Google-Smtp-Source: ABdhPJxQrhsTC0s7WUAZx9aLy1G7PaDsPNUgEQmpgqiwJtSzasvPykThDUdLqkza5KPnY5mdxthHVs7wyoadboZq2j0=
X-Received: by 2002:a05:6870:c692:b0:e9:5368:10df with SMTP id
 cv18-20020a056870c69200b000e9536810dfmr10096606oab.182.1652721248344; Mon, 16
 May 2022 10:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220511184132.217891-1-cgzones@googlemail.com> <CAP+JOzQfnzb-FRB9rMOiej0YE1ESTOc51JNNdwaWhO5GdmQF_A@mail.gmail.com>
In-Reply-To: <CAP+JOzQfnzb-FRB9rMOiej0YE1ESTOc51JNNdwaWhO5GdmQF_A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 16 May 2022 13:13:57 -0400
Message-ID: <CAP+JOzTALVPhf=+HjavbM2Cj0QfCFC0HBrU=mvmq42MpjX0Kuw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: preserve errno in selinux_log()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 12, 2022 at 1:58 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, May 12, 2022 at 12:02 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > selinux_log() is used in many error branches, where the caller might
> > expect errno to bet set, e.g. label_file.c::lookup_all():
> >
> >     if (match_count) {
> >                 *match_count =3D 0;
> >                 result =3D calloc(data->nspec, sizeof(struct spec*));
> >         } else {
> >                 result =3D calloc(1, sizeof(struct spec*));
> >         }
> >         if (!result) {
> >                 selinux_log(SELINUX_ERROR, "Failed to allocate %zu byte=
s of data\n",
> >                             data->nspec * sizeof(struct spec*));
> >                 goto finish;
> >         }
> >
> > Preserve errno in the macro wrapper itself, also preventing accidental
> > errno modifications in client specified SELINUX_CB_LOG callbacks.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/callbacks.h              | 3 +++
> >  libselinux/src/label_backends_android.c | 2 --
> >  libselinux/src/label_file.h             | 2 --
> >  libselinux/src/selinux_restorecon.c     | 6 +-----
> >  4 files changed, 4 insertions(+), 9 deletions(-)
> >
> > diff --git a/libselinux/src/callbacks.h b/libselinux/src/callbacks.h
> > index f4dab157..5a4d0f8a 100644
> > --- a/libselinux/src/callbacks.h
> > +++ b/libselinux/src/callbacks.h
> > @@ -5,6 +5,7 @@
> >  #ifndef _SELINUX_CALLBACKS_H_
> >  #define _SELINUX_CALLBACKS_H_
> >
> > +#include <errno.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > @@ -32,9 +33,11 @@ extern int
> >  extern pthread_mutex_t log_mutex;
> >
> >  #define selinux_log(type, ...) do { \
> > +       int saved_errno__ =3D errno; \
> >         __pthread_mutex_lock(&log_mutex); \
> >         selinux_log_direct(type, __VA_ARGS__); \
> >         __pthread_mutex_unlock(&log_mutex); \
> > +       errno =3D saved_errno__; \
> >  } while(0)
> >
> >  #endif                         /* _SELINUX_CALLBACKS_H_ */
> > diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/l=
abel_backends_android.c
> > index 66d4df2d..c2d78360 100644
> > --- a/libselinux/src/label_backends_android.c
> > +++ b/libselinux/src/label_backends_android.c
> > @@ -93,7 +93,6 @@ static int process_line(struct selabel_handle *rec,
> >
> >         items =3D read_spec_entries(line_buf, &errbuf, 2, &prop, &conte=
xt);
> >         if (items < 0) {
> > -               items =3D errno;
> >                 if (errbuf) {
> >                         selinux_log(SELINUX_ERROR,
> >                                     "%s:  line %u error due to: %s\n", =
path,
> > @@ -103,7 +102,6 @@ static int process_line(struct selabel_handle *rec,
> >                                     "%s:  line %u error due to: %m\n", =
path,
> >                                     lineno);
> >                 }
> > -               errno =3D items;
> >                 return -1;
> >         }
> >
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index b453e13f..190bc175 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -444,7 +444,6 @@ static inline int process_line(struct selabel_handl=
e *rec,
> >
> >         items =3D read_spec_entries(line_buf, &errbuf, 3, &regex, &type=
, &context);
> >         if (items < 0) {
> > -               rc =3D errno;
> >                 if (errbuf) {
> >                         selinux_log(SELINUX_ERROR,
> >                                     "%s:  line %u error due to: %s\n", =
path,
> > @@ -454,7 +453,6 @@ static inline int process_line(struct selabel_handl=
e *rec,
> >                                     "%s:  line %u error due to: %m\n", =
path,
> >                                     lineno);
> >                 }
> > -               errno =3D rc;
> >                 return -1;
> >         }
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index e6192912..ba7b3692 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -1032,7 +1032,7 @@ static int selinux_restorecon_common(const char *=
pathname_orig,
> >         struct stat sb;
> >         char *pathname =3D NULL, *pathdnamer =3D NULL, *pathdname, *pat=
hbname;
> >         char *paths[2] =3D { NULL, NULL };
> > -       int fts_flags, error, sverrno;
> > +       int fts_flags, error;
> >         struct dir_hash_node *current =3D NULL;
> >
> >         if (state.flags.verbose && state.flags.progress)
> > @@ -1286,18 +1286,14 @@ cleanup:
> >         return error;
> >
> >  oom:
> > -       sverrno =3D errno;
> >         selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
> > -       errno =3D sverrno;
> >         error =3D -1;
> >         goto cleanup;
> >
> >  realpatherr:
> > -       sverrno =3D errno;
> >         selinux_log(SELINUX_ERROR,
> >                     "SELinux: Could not get canonical path for %s resto=
recon: %m.\n",
> >                     pathname_orig);
> > -       errno =3D sverrno;
> >         error =3D -1;
> >         goto cleanup;
> >
> > --
> > 2.36.1
> >
