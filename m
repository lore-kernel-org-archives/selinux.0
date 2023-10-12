Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383F8CDB47E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379676AbjJLRwv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379681AbjJLRwv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:52:51 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4B3D9
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:52:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5041335fb9cso1684041e87.0
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133167; x=1697737967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJiZ2G2t9NtJV9iC3+PKyyi/7i4BFJXh9TRnAGhy3YA=;
        b=ZUrIvwfe1H7mOV7PiZSaHAH6nRepWQZYsa/T3Rpc2yzVCKKjGLPe68gp5FlxJmVi+J
         k+EDUyOemjjIpSMiYzKDPdwH4T0ZSo5l17c/hVcrErdUS4ayBoPankePF0CaDfg/W2Tg
         mdsDii+Zw+G75rAKLiU4iFk+L/37oLxtP7AnnzItDQcEcvPHgB9jOpCCba4e48nLy2wI
         F3UMWHANNyRAd3chRlqOz1YBULQPAXzCZm67/IHGqnm4nb2oHbhVbCkJFpuS248NAu1J
         Yf+QkdviE+QqKcAfgdKwMzcuE54p2QzKh3p+AczFcQ3VbSRk01JIDIE73DaqZQ7L+3Qs
         dhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133167; x=1697737967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJiZ2G2t9NtJV9iC3+PKyyi/7i4BFJXh9TRnAGhy3YA=;
        b=Pu7MNR7DHCyynw16Bd6U1gKWaoXICThK0vacAjtIhEyrqkXvyfHRewzaGER1W/yMGd
         F1Df3cErTldLzdn2t9m5JYGlZcVIcQx9aIQIBxN6ZekEZCGArMi3Znjts7SyEw6GtXHN
         QvYEGNo1v4gaCREPLXkwqOxaZiW32ugrvolw4A8GWG3e7NrfXqEPhAmFIUXToosyGJd/
         ztYvivIh3a8bf3uAXlNHLLAsxteVSKuVkosnZ7rDowFLA2921LDIuv4h8XuIVkeUF04R
         B3T20ztNc2smYGR9kwlQVxFcKSjcZRb4igTYu+oWCQS22gA80rjz0iG72byuDCFsVtlO
         5LwA==
X-Gm-Message-State: AOJu0YwU+ESvLvneFdKZLxwzlyoy65LowaFuv7LxSPqoZhMmqxAnb0Rj
        m4YNpI5Ta/4RqzekO4CDJgODzr29zlCx6c+OoI5KkiuzdSg=
X-Google-Smtp-Source: AGHT+IHOb3vyVSsPQeonke5inivMo6ZhUyI9xLWB1kWNn1FmNsXxgkvGg5VHbrm/X4xbJOm1jywBQwAoMmqqaZ90TV4=
X-Received: by 2002:ac2:4da8:0:b0:500:bffa:5b85 with SMTP id
 h8-20020ac24da8000000b00500bffa5b85mr18805858lfe.32.1697133166980; Thu, 12
 Oct 2023 10:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-3-cgzones@googlemail.com> <CAP+JOzR5S45N3uMkTsOu3YbEgK3pcSFJ6AZxPMtuK3R4Hwcfrw@mail.gmail.com>
In-Reply-To: <CAP+JOzR5S45N3uMkTsOu3YbEgK3pcSFJ6AZxPMtuK3R4Hwcfrw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:52:35 -0400
Message-ID: <CAP+JOzSKUH8mniOrgSojwmzSrj0qMEgCm-3VFg1UeCuP+c04Ag@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/27] libselinux: misc label cleanup
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 2, 2023 at 1:13=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Drop unused parameter from selabel_is_digest_set().  It is only written
> > to but writes to the function local copy of the pointer are void.
> >
> > Constify read-only handle parameter of selabel_validate() and
> > compat_validate().
> >
> > Constify read-only from-address parameter of digest_add_specfile().
> >
> > Constify read-only function pointer array initfuncs.
> >
> > Merge malloc(3) and memset(3) calls into calloc(3).
> >
> > Simplify boolean assignment.
> >
> > Drop duplicate include file.
> >
> > Drop return at end of void function.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/label.c          | 17 +++++++----------
> >  libselinux/src/label_internal.h |  6 +++---
> >  libselinux/src/label_support.c  |  4 +---
> >  libselinux/src/matchpathcon.c   |  2 +-
> >  4 files changed, 12 insertions(+), 17 deletions(-)
> >
> > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> > index 586e5e5e..a2efa99c 100644
> > --- a/libselinux/src/label.c
> > +++ b/libselinux/src/label.c
> > @@ -45,7 +45,7 @@ typedef int (*selabel_initfunc)(struct selabel_handle=
 *rec,
> >                                 const struct selinux_opt *opts,
> >                                 unsigned nopts);
> >
> > -static selabel_initfunc initfuncs[] =3D {
> > +static const selabel_initfunc initfuncs[] =3D {
> >         &selabel_file_init,
> >         CONFIG_MEDIA_BACKEND(selabel_media_init),
> >         CONFIG_X_BACKEND(selabel_x_init),
> > @@ -56,8 +56,7 @@ static selabel_initfunc initfuncs[] =3D {
> >
> >  static inline struct selabel_digest *selabel_is_digest_set
> >                                     (const struct selinux_opt *opts,
> > -                                   unsigned n,
> > -                                   struct selabel_digest *entry)
> > +                                   unsigned n)
> >  {
> >         struct selabel_digest *digest =3D NULL;
> >
> > @@ -77,8 +76,7 @@ static inline struct selabel_digest *selabel_is_diges=
t_set
> >                         if (!digest->specfile_list)
> >                                 goto err;
> >
> > -                       entry =3D digest;
> > -                       return entry;
> > +                       return digest;
> >                 }
> >         }
> >         return NULL;
> > @@ -121,7 +119,7 @@ static inline int selabel_is_validate_set(const str=
uct selinux_opt *opts,
> >         return 0;
> >  }
> >
> > -int selabel_validate(struct selabel_handle *rec,
> > +int selabel_validate(const struct selabel_handle *rec,
> >                      struct selabel_lookup_rec *contexts)
> >  {
> >         int rc =3D 0;
> > @@ -133,7 +131,7 @@ int selabel_validate(struct selabel_handle *rec,
> >         if (rc < 0)
> >                 goto out;
> >
> > -       contexts->validated =3D 1;
> > +       contexts->validated =3D true;
> >  out:
> >         return rc;
> >  }
> > @@ -215,15 +213,14 @@ struct selabel_handle *selabel_open(unsigned int =
backend,
> >                 goto out;
> >         }
> >
> > -       rec =3D (struct selabel_handle *)malloc(sizeof(*rec));
> > +       rec =3D (struct selabel_handle *)calloc(1, sizeof(*rec));
> >         if (!rec)
> >                 goto out;
> >
> > -       memset(rec, 0, sizeof(*rec));
> >         rec->backend =3D backend;
> >         rec->validating =3D selabel_is_validate_set(opts, nopts);
> >
> > -       rec->digest =3D selabel_is_digest_set(opts, nopts, rec->digest)=
;
> > +       rec->digest =3D selabel_is_digest_set(opts, nopts);
> >
> >         if ((*initfuncs[backend])(rec, opts, nopts)) {
> >                 if (rec->digest)
> > diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_int=
ernal.h
> > index 782c6aa8..273a630a 100644
> > --- a/libselinux/src/label_internal.h
> > +++ b/libselinux/src/label_internal.h
> > @@ -63,7 +63,7 @@ struct selabel_digest {
> >  };
> >
> >  extern int digest_add_specfile(struct selabel_digest *digest, FILE *fp=
,
> > -                                                   char *from_addr,
> > +                                                   const char *from_ad=
dr,
> >                                                     size_t buf_len,
> >                                                     const char *path);
> >  extern void digest_gen_hash(struct selabel_digest *digest);
> > @@ -118,7 +118,7 @@ struct selabel_handle {
> >   * Validation function
> >   */
> >  extern int
> > -selabel_validate(struct selabel_handle *rec,
> > +selabel_validate(const struct selabel_handle *rec,
> >                  struct selabel_lookup_rec *contexts) ;
> >
> >  /*
> > @@ -136,7 +136,7 @@ extern void __attribute__ ((format(printf, 1, 2)))
> >         } while (0)
> >
> >  extern int
> > -compat_validate(struct selabel_handle *rec,
> > +compat_validate(const struct selabel_handle *rec,
> >                 struct selabel_lookup_rec *contexts,
> >                 const char *path, unsigned lineno) ;
> >
> > diff --git a/libselinux/src/label_support.c b/libselinux/src/label_supp=
ort.c
> > index 54fd49a5..df474cba 100644
> > --- a/libselinux/src/label_support.c
> > +++ b/libselinux/src/label_support.c
> > @@ -10,7 +10,6 @@
> >  #include <string.h>
> >  #include <stdio.h>
> >  #include <errno.h>
> > -#include <errno.h>
> >  #include "label_internal.h"
> >
> >  /*
> > @@ -138,7 +137,6 @@ void  digest_gen_hash(struct selabel_digest *digest=
)
> >         Sha1Finalise(&context, (SHA1_HASH *)digest->digest);
> >         free(digest->hashbuf);
> >         digest->hashbuf =3D NULL;
> > -       return;
> >  }
> >
> >  /**
> > @@ -154,7 +152,7 @@ void  digest_gen_hash(struct selabel_digest *digest=
)
> >   * Return %0 on success, -%1 with @errno set on failure.
> >   */
> >  int  digest_add_specfile(struct selabel_digest *digest, FILE *fp,
> > -                                   char *from_addr, size_t buf_len,
> > +                                   const char *from_addr, size_t buf_l=
en,
> >                                     const char *path)
> >  {
> >         unsigned char *tmp_buf;
> > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathco=
n.c
> > index bf2da083..9a9bafb0 100644
> > --- a/libselinux/src/matchpathcon.c
> > +++ b/libselinux/src/matchpathcon.c
> > @@ -35,7 +35,7 @@ void set_matchpathcon_printf(void (*f) (const char *f=
mt, ...))
> >         myprintf_compat =3D 1;
> >  }
> >
> > -int compat_validate(struct selabel_handle *rec,
> > +int compat_validate(const struct selabel_handle *rec,
> >                     struct selabel_lookup_rec *contexts,
> >                     const char *path, unsigned lineno)
> >  {
> > --
> > 2.40.1
> >
