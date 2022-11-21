Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420FDC4332F
	for <selinux@archiver.kernel.org>; Mon, 21 Nov 2022 20:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiKUUz6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 15:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKUUz6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Nov 2022 15:55:58 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B347CC9A92
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 12:55:56 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x102so18025119ede.0
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 12:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waieekcuf9pvqzdQ26yAQoTHY7JTvYY9SDLWzxC28yM=;
        b=qqv2cOrWu4vkuA6oFNiByMuNv5Dle2JPJZuxOBK2yOKchJZXb8070zmckZnHalpprd
         dSwgQWrKg9SKlmaHM2dbdgXpPdPcCxaJXhafuYBkTUdohiQcnsYtm/Tvu9YAfZ3hij79
         gtxgHYN0iEl1sQ+yhYt2CX6BrvH3Dtxsm55bXIdfSt9K0Q9SM2NDTuz8rzw8V/QHdfLh
         KQikJMagd36fCUdVEq2elW+5tMXvkjem42p3PgfZLpHZO1QZ3+wOa4w9bBeatOmduWbM
         2kFnlbtVO/qedAvVZ7Liid7ksWBsY41CK7xkQWwTPLXVSkoKI4JceyLmkZmEDLTYkXpz
         PzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waieekcuf9pvqzdQ26yAQoTHY7JTvYY9SDLWzxC28yM=;
        b=OXXnKjqlt2+DG60Men5yGmMtZNz3fmcXwo+0SGUAv7SNDYSmdK6Y3e4ppETymQFKy/
         T0a5zOtTB38qrJuxzRPiCeNyYSAOJs/93DHUDJ3ct5uRR/fZmLb6eBDj5ZxY+Z6Lp/fV
         ZJJdeaSZcEGDNE6zS/9pchR+YRcZpGDtjsH4695pDIyCxqnI/X0kwVO42oVnG15d3ioT
         cnAsQexyKfj+UdaNzUR8mGjnQRUE1pWP+zwaIf3QeNL1f3PSUANsueq69rmOuSanGhG9
         grWHtKpT/VsKxbJ+qjUQv4AHNou7mkRcGzw4ULImVxJiNukxEMjhG2jylb4s3YJqwQ3i
         y+Kg==
X-Gm-Message-State: ANoB5pmfvG9j8uUc/fY9x1cf7XxN7AVd+Jt4+dibL+gCY3feG5Q5QUKH
        2Ozeiy58g+NOuaObdbGlIah6o+kdROaw9CPQ92E=
X-Google-Smtp-Source: AA0mqf5e8/+dA9ni2G1z4u1LV7p/OvWxCskRuBKUsma0au6l+bInm7wGe3K7dIET7dpcL3WoUFe5FVBvlQtWLCepNZs=
X-Received: by 2002:aa7:cb07:0:b0:463:ca19:6cdf with SMTP id
 s7-20020aa7cb07000000b00463ca196cdfmr18500019edt.379.1669064154975; Mon, 21
 Nov 2022 12:55:54 -0800 (PST)
MIME-Version: 1.0
References: <20221109200939.62525-1-cgzones@googlemail.com> <CAP+JOzTBu1J+8yxXae0FB1-udOA8L1C5yHM2BfKfLpuRTW-GzA@mail.gmail.com>
In-Reply-To: <CAP+JOzTBu1J+8yxXae0FB1-udOA8L1C5yHM2BfKfLpuRTW-GzA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Nov 2022 15:55:43 -0500
Message-ID: <CAP+JOzQ+jr2Ni9fxTPusQFg1-j9T3+F3zxx+JLmvnSKkiFefTA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: simplify string copying
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 10, 2022 at 8:55 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Nov 9, 2022 at 3:11 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Use strdup(3)/strndup(3) instead of allocating memory and then manually
> > copying the content.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These three patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/src/context.c                     | 11 +++++------
> >  libselinux/src/get_default_type.c            |  3 +--
> >  libselinux/src/matchpathcon.c                |  9 +++------
> >  libselinux/utils/selabel_lookup_best_match.c | 10 ++++------
> >  4 files changed, 13 insertions(+), 20 deletions(-)
> >
> > diff --git a/libselinux/src/context.c b/libselinux/src/context.c
> > index 9dddbc5a..8830bf42 100644
> > --- a/libselinux/src/context.c
> > +++ b/libselinux/src/context.c
> > @@ -149,19 +149,18 @@ static int set_comp(context_private_t * n, int id=
x, const char *str)
> >         char *t =3D NULL;
> >         const char *p;
> >         if (str) {
> > -               t =3D (char *)malloc(strlen(str) + 1);
> > -               if (!t) {
> > -                       return -1;
> > -               }
> >                 for (p =3D str; *p; p++) {
> >                         if (*p =3D=3D '\t' || *p =3D=3D '\n' || *p =3D=
=3D '\r' ||
> >                             ((*p =3D=3D ':' || *p =3D=3D ' ') && idx !=
=3D COMP_RANGE)) {
> > -                               free(t);
> >                                 errno =3D EINVAL;
> >                                 return -1;
> >                         }
> >                 }
> > -               strcpy(t, str);
> > +
> > +               t =3D strdup(str);
> > +               if (!t) {
> > +                       return -1;
> > +               }
> >         }
> >         conditional_free(&n->component[idx]);
> >         n->component[idx] =3D t;
> > diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_def=
ault_type.c
> > index dd7b5d79..766ea4b7 100644
> > --- a/libselinux/src/get_default_type.c
> > +++ b/libselinux/src/get_default_type.c
> > @@ -62,10 +62,9 @@ static int find_default_type(FILE * fp, const char *=
role, char **type)
> >                 return -1;
> >         }
> >
> > -       t =3D malloc(strlen(buf) - len);
> > +       t =3D strndup(ptr, strlen(buf) - len - 1);
> >         if (!t)
> >                 return -1;
> > -       strcpy(t, ptr);
> >         *type =3D t;
> >         return 0;
> >  }
> > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathco=
n.c
> > index ea78a23e..bf2da083 100644
> > --- a/libselinux/src/matchpathcon.c
> > +++ b/libselinux/src/matchpathcon.c
> > @@ -215,10 +215,9 @@ int matchpathcon_filespec_add(ino_t ino, int speci=
nd, const char *file)
> >                         if (ret < 0 || sb.st_ino !=3D ino) {
> >                                 fl->specind =3D specind;
> >                                 free(fl->file);
> > -                               fl->file =3D malloc(strlen(file) + 1);
> > +                               fl->file =3D strdup(file);
> >                                 if (!fl->file)
> >                                         goto oom;
> > -                               strcpy(fl->file, file);
> >                                 return fl->specind;
> >
> >                         }
> > @@ -232,10 +231,9 @@ int matchpathcon_filespec_add(ino_t ino, int speci=
nd, const char *file)
> >                              __FUNCTION__, file, fl->file,
> >                              con_array[fl->specind]);
> >                         free(fl->file);
> > -                       fl->file =3D malloc(strlen(file) + 1);
> > +                       fl->file =3D strdup(file);
> >                         if (!fl->file)
> >                                 goto oom;
> > -                       strcpy(fl->file, file);
> >                         return fl->specind;
> >                 }
> >
> > @@ -248,10 +246,9 @@ int matchpathcon_filespec_add(ino_t ino, int speci=
nd, const char *file)
> >                 goto oom;
> >         fl->ino =3D ino;
> >         fl->specind =3D specind;
> > -       fl->file =3D malloc(strlen(file) + 1);
> > +       fl->file =3D strdup(file);
> >         if (!fl->file)
> >                 goto oom_freefl;
> > -       strcpy(fl->file, file);
> >         fl->next =3D prevfl->next;
> >         prevfl->next =3D fl;
> >         return fl->specind;
> > diff --git a/libselinux/utils/selabel_lookup_best_match.c b/libselinux/=
utils/selabel_lookup_best_match.c
> > index a4af0679..e816c04b 100644
> > --- a/libselinux/utils/selabel_lookup_best_match.c
> > +++ b/libselinux/utils/selabel_lookup_best_match.c
> > @@ -30,7 +30,7 @@ static __attribute__ ((__noreturn__)) void usage(cons=
t char *progname)
> >         exit(1);
> >  }
> >
> > -static mode_t string_to_mode(char *s)
> > +static mode_t string_to_mode(const char *s)
> >  {
> >         switch (s[0]) {
> >         case 'b':
> > @@ -53,7 +53,7 @@ static mode_t string_to_mode(char *s)
> >
> >  int main(int argc, char **argv)
> >  {
> > -       int raw =3D 0, mode =3D 0, rc, opt, i, num_links, string_len;
> > +       int raw =3D 0, mode =3D 0, rc, opt, i, num_links;
> >         char *validate =3D NULL, *path =3D NULL, *context =3D NULL, *fi=
le =3D NULL;
> >         char **links =3D NULL;
> >
> > @@ -101,13 +101,11 @@ int main(int argc, char **argv)
> >                 }
> >
> >                 for (i =3D optind, num_links =3D 0; i < argc; i++, num_=
links++) {
> > -                       string_len =3D strlen(argv[i]) + 1;
> > -                       links[num_links] =3D malloc(string_len);
> > +                       links[num_links] =3D strdup(argv[i]);
> >                         if (!links[num_links]) {
> > -                               fprintf(stderr, "ERROR: malloc failed.\=
n");
> > +                               fprintf(stderr, "ERROR: strdup failed.\=
n");
> >                                 exit(1);
> >                         }
> > -                       strcpy(links[num_links], argv[i]);
> >                 }
> >         }
> >
> > --
> > 2.38.1
> >
