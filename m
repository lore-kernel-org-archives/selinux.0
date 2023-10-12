Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B1ECDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441912AbjJLR4W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441848AbjJLR4W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:56:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43113BB
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:56:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50433d8385cso1798274e87.0
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133378; x=1697738178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HylIGxaJcX9UmglyHxWl8uPhsJm1MoicGtkHJYpA1wA=;
        b=PILAhl3ssBXXgdr6RiYySxp6chYYliEpC7Z4Ui6vJQI9t7p55hajcklMvVGpA5ICTl
         f5jfeYOdzYNL1ZlJRs+8gS1RNbdJyD4HgwcyVxHfO/EmFs0TWklWeom11SZrngLuMF5/
         Tf/dWDlIYhgVuGrCvGLZu7w2ayl3aQMbTtMtFefrCwKotVVyRyaJRlPcN47pCgDEd686
         KtIe2yjL8ObF7PeYK5+gC9puc16VAIA9ddVM/rdNPOWp/LTGVUH2KEYEClzAAUIOdc98
         cbjaJ9DO7vQsZb+hRV9/IcgUrGPO6ExxzfXY01LjxeY7FAeS01fczYGn7JhOYp24p7sC
         vMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133378; x=1697738178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HylIGxaJcX9UmglyHxWl8uPhsJm1MoicGtkHJYpA1wA=;
        b=OiChCActtqTwu5ZX/FQJkD7CBk7oBvJf6nxLPo4nm63Et9JQdru4ZAxONGrq4nbJkj
         NQ+kKysMrDRBCsHUbQxCyvmZbZruIM016vemGLZD6IVBkUwz2wcq9c2372AY51oi/uug
         TBphpLOc4POeZU6rUh8utffrH3MLGywvwBeVkRU64yNkTLmAV0N6k4D8wnMeMHvkXmTu
         XaVeGXDoCYwjLWabvBmJT/iUaMxeW8SI/XzIFE/FoqhSPxWQgjH0kV7AQNZLttVoXYz4
         5uIBEbsxPRGmNW3blTtiE5OYlmKjYhB/Yflz8L0DfM03HNQLsM6nafzT9koVC0Vu3GEQ
         8a+A==
X-Gm-Message-State: AOJu0YzC2W8AqMfO6nd+MlrgVMcGHP2GK9vONQ52/Tr5+0Z4pp4fTgzz
        1bm1qcYQmuGCkL6l0DZ6/ge5Vok0fVxunoJflDSWyxpa6BI=
X-Google-Smtp-Source: AGHT+IHWt0418KI5B7adFoe/WI3nQPU0LtIh65gXv3fVB4dutzzWPwwKtoKdnY51w3ngYsLiRC+/k3QCFjK6dSFv8GM=
X-Received: by 2002:a19:2d4d:0:b0:4fd:f77d:5051 with SMTP id
 t13-20020a192d4d000000b004fdf77d5051mr20314998lft.26.1697133378393; Thu, 12
 Oct 2023 10:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-21-cgzones@googlemail.com> <CAP+JOzR+5ukWPRBfs0QaNBcWZ3TNpKg1r60sUf-rLgsi60ZjCQ@mail.gmail.com>
In-Reply-To: <CAP+JOzR+5ukWPRBfs0QaNBcWZ3TNpKg1r60sUf-rLgsi60ZjCQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:56:07 -0400
Message-ID: <CAP+JOzRvdwY_Q4ygb7FuRzK11UB-wm+0+6GCYk6-Kq6dFTjgnA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/27] libselinux: check for stream rewind failures
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 11, 2023 at 2:48=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Use fseek(3) instead of rewind(3) to detect failures.
> >
> > Drop the final rewind in digest_add_specfile(), since all callers are
> > going to close the stream without any further action.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/is_customizable_type.c   |  7 ++++++-
> >  libselinux/src/label_backends_android.c |  5 ++++-
> >  libselinux/src/label_file.c             | 16 +++++++++++++---
> >  libselinux/src/label_media.c            |  5 ++++-
> >  libselinux/src/label_support.c          |  5 +++--
> >  libselinux/src/label_x.c                |  5 ++++-
> >  6 files changed, 34 insertions(+), 9 deletions(-)
> >
> > diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_=
customizable_type.c
> > index f83e1e83..9be50174 100644
> > --- a/libselinux/src/is_customizable_type.c
> > +++ b/libselinux/src/is_customizable_type.c
> > @@ -31,7 +31,12 @@ static void customizable_init(void)
> >         while (fgets_unlocked(buf, selinux_page_size, fp) && ctr < UINT=
_MAX) {
> >                 ctr++;
> >         }
> > -       rewind(fp);
> > +
> > +       if (fseek(fp, 0L, SEEK_SET) =3D=3D -1) {
> > +               fclose(fp);
> > +               return;
> > +       }
> > +
> >         if (ctr) {
> >                 list =3D
> >                     (char **) calloc(sizeof(char *),
> > diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/l=
abel_backends_android.c
> > index c2d78360..6494f3cd 100644
> > --- a/libselinux/src/label_backends_android.c
> > +++ b/libselinux/src/label_backends_android.c
> > @@ -208,7 +208,10 @@ static int init(struct selabel_handle *rec, const =
struct selinux_opt *opts,
> >                                 goto finish;
> >
> >                         maxnspec =3D data->nspec;
> > -                       rewind(fp);
> > +
> > +                       status =3D fseek(fp, 0L, SEEK_SET);
> > +                       if (status =3D=3D -1)
> > +                               goto finish;
> >                 }
> >         }
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 471fd56b..a5677411 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -519,12 +519,16 @@ static char *rolling_append(char *current, const =
char *suffix, size_t max)
> >         return current;
> >  }
> >
> > -static bool fcontext_is_binary(FILE *fp)
> > +static int fcontext_is_binary(FILE *fp)
> >  {
> >         uint32_t magic;
> > +       int rc;
> >
> >         size_t len =3D fread(&magic, sizeof(magic), 1, fp);
> > -       rewind(fp);
> > +
> > +       rc =3D fseek(fp, 0L, SEEK_SET);
> > +       if (rc =3D=3D -1)
> > +               return -1;
> >
> >         return (len && (magic =3D=3D SELINUX_MAGIC_COMPILED_FCONTEXT));
> >  }
> > @@ -622,7 +626,13 @@ static int process_file(const char *path, const ch=
ar *suffix,
> >                 if (fp =3D=3D NULL)
> >                         return -1;
> >
> > -               rc =3D fcontext_is_binary(fp) ?
> > +               rc =3D fcontext_is_binary(fp);
> > +               if (rc < 0) {
> > +                       (void) fclose(fp);
> > +                       return -1;
> > +               }
> > +
> > +               rc =3D rc ?
> >                                 load_mmap(fp, sb.st_size, rec, found_pa=
th) :
> >                                 process_text_file(fp, rec, found_path);
> >                 if (!rc)
> > diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.=
c
> > index f09461ab..b3443b47 100644
> > --- a/libselinux/src/label_media.c
> > +++ b/libselinux/src/label_media.c
> > @@ -130,7 +130,10 @@ static int init(struct selabel_handle *rec, const =
struct selinux_opt *opts,
> >                                 goto finish;
> >                         memset(data->spec_arr, 0, sizeof(spec_t)*data->=
nspec);
> >                         maxnspec =3D data->nspec;
> > -                       rewind(fp);
> > +
> > +                       status =3D fseek(fp, 0L, SEEK_SET);
> > +                       if (status =3D=3D -1)
> > +                               goto finish;
> >                 }
> >         }
> >         free(line_buf);
> > diff --git a/libselinux/src/label_support.c b/libselinux/src/label_supp=
ort.c
> > index 94fb6697..f7ab9292 100644
> > --- a/libselinux/src/label_support.c
> > +++ b/libselinux/src/label_support.c
> > @@ -174,12 +174,13 @@ int  digest_add_specfile(struct selabel_digest *d=
igest, FILE *fp,
> >         digest->hashbuf =3D tmp_buf;
> >
> >         if (fp) {
> > -               rewind(fp);
> > +               if (fseek(fp, 0L, SEEK_SET) =3D=3D -1)
> > +                       return -1;
> > +
> >                 if (fread(digest->hashbuf + (digest->hashbuf_size - buf=
_len),
> >                                             1, buf_len, fp) !=3D buf_le=
n)
> >                         return -1;
> >
> > -               rewind(fp);
> >         } else if (from_addr) {
> >                 tmp_buf =3D memcpy(digest->hashbuf +
> >                                     (digest->hashbuf_size - buf_len),
> > diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> > index e80bf107..e15190ca 100644
> > --- a/libselinux/src/label_x.c
> > +++ b/libselinux/src/label_x.c
> > @@ -157,7 +157,10 @@ static int init(struct selabel_handle *rec, const =
struct selinux_opt *opts,
> >                                 goto finish;
> >                         memset(data->spec_arr, 0, sizeof(spec_t)*data->=
nspec);
> >                         maxnspec =3D data->nspec;
> > -                       rewind(fp);
> > +
> > +                       status =3D fseek(fp, 0L, SEEK_SET);
> > +                       if (status =3D=3D -1)
> > +                               goto finish;
> >                 }
> >         }
> >         free(line_buf);
> > --
> > 2.40.1
> >
