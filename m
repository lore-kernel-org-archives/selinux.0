Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01547C04A6A
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 18:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjHDSin (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHDSif (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Aug 2023 14:38:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7682B1734
        for <selinux@vger.kernel.org>; Fri,  4 Aug 2023 11:38:34 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso37222591fa.2
        for <selinux@vger.kernel.org>; Fri, 04 Aug 2023 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691174313; x=1691779113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiQLa5CjThphnhA9mUwAisVUDdCzcGY8ur5SSNq+8hE=;
        b=k0PMYF5JvorxEnvtQieK/5XBZzR4u0FoSaNjpyv+cNjFQC8mr5mHAURpT7+LDcyTZW
         FLgAKjXSZX58LXELX4d9I0lpWNW4y5Ug11JpQRMUUY9V92RitfC+EacQYQ6UF+VAD9du
         JGnGs1pEUEGLixRGdEGFii+2IiX34hUa50XNYKaYPOJZ7g+sZpGDfPLTuuRhoawiI0tB
         qDGfiw/Ff98h6sMpI11yJKcFfqmrZJwEYd2mZLewXkT8vLirNUvsuK/7Zan8wPx5lU3y
         OSJWpi5wGOsvIKStMirWCawhpDSKUA1EPc7rVvPZx673O8stC1MgjU2Gt5a3UZt+uQh8
         pOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174313; x=1691779113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiQLa5CjThphnhA9mUwAisVUDdCzcGY8ur5SSNq+8hE=;
        b=i4nqCYiPtYizKimhuKa340Vdvzj0+Zoqnr8XgwDKT6dq2b1jO8q8IgwZ7cyf8R2j77
         9q9deEFbCgD0XgWbEGqhWcF8DZZpYml28btXkQiK980V9bjD9vkob7uNVZcU0skcm+3d
         E1zyLypHiFq4GjJ2g5PszfcNDAFn0adPtvtOhqyEN9qDMBl9Ov5uO86mebIgTfBrHnO/
         DablfoeTUlgg0z+ugyXigqCzisDj+o4+0lB9LCVRw1G2dDhJgqMkqXuBbCAZsGwzaIrI
         rY+hrBAe2PNyTddNq6//zoxm9ohy64YhF3r+FaFfp5MUJYFa/pIYtCpW1ZhITmpi1JM5
         9TMg==
X-Gm-Message-State: AOJu0Yzl3s+2+SbOGj9fAJShaeXl/+I3lhZcSnm3Ml90c2LKKUoFoegs
        ntBiVZ7li6qStlheM8GGDX0ArYpbiKYJoLrCrCCJ0Q68
X-Google-Smtp-Source: AGHT+IG6R1JR354CyzBcqviqiSH7qbErdkMOfSnu/mfWKBbysSOqqQshL5GZ4J+V0n82kO3/ehByHQsFdDRhEnFOmQg=
X-Received: by 2002:a2e:964e:0:b0:2b9:edcd:8770 with SMTP id
 z14-20020a2e964e000000b002b9edcd8770mr2440425ljh.43.1691174312510; Fri, 04
 Aug 2023 11:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230713063504.161485-1-luhuaxin1@huawei.com> <CAP+JOzQ2i+QG9ZUsauW75jeoXQYoPEJvSAFCHRqbF8iMd43dxA@mail.gmail.com>
In-Reply-To: <CAP+JOzQ2i+QG9ZUsauW75jeoXQYoPEJvSAFCHRqbF8iMd43dxA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Aug 2023 14:38:21 -0400
Message-ID: <CAP+JOzTjG+t0h_MNdb7rPFDZ5PZ=qK9B-c_0FDLKQWHvWav1VA@mail.gmail.com>
Subject: Re: [PATCH] secilc: add check for malloc in secilc
To:     Huaxin Lu <luhuaxin1@huawei.com>
Cc:     selinux@vger.kernel.org, shenyining@huawei.com,
        fangxiuning@huawei.com, zhujianwei7@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 19, 2023 at 2:47=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jul 13, 2023 at 5:12=E2=80=AFAM Huaxin Lu <luhuaxin1@huawei.com> =
wrote:
> >
> > Check the return value of malloc() to avoid null pointer reference.
> >
> > Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  secilc/secil2conf.c | 6 ++++++
> >  secilc/secil2tree.c | 6 ++++++
> >  secilc/secilc.c     | 6 ++++++
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
> > index c49522e..bf050f3 100644
> > --- a/secilc/secil2conf.c
> > +++ b/secilc/secil2conf.c
> > @@ -152,6 +152,12 @@ int main(int argc, char *argv[])
> >                 file_size =3D filedata.st_size;
> >
> >                 buffer =3D malloc(file_size);
> > +               if (!buffer) {
> > +                       fprintf(stderr, "Out of memory\n");
> > +                       rc =3D SEPOL_ERR;
> > +                       goto exit;
> > +               }
> > +
> >                 rc =3D fread(buffer, file_size, 1, file);
> >                 if (rc !=3D 1) {
> >                         fprintf(stderr, "Failure reading file: %s\n", a=
rgv[i]);
> > diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
> > index e5cdf6b..d04566d 100644
> > --- a/secilc/secil2tree.c
> > +++ b/secilc/secil2tree.c
> > @@ -158,6 +158,12 @@ int main(int argc, char *argv[])
> >                 file_size =3D filedata.st_size;
> >
> >                 buffer =3D malloc(file_size);
> > +               if (!buffer) {
> > +                       fprintf(stderr, "Out of memory\n");
> > +                       rc =3D SEPOL_ERR;
> > +                       goto exit;
> > +               }
> > +
> >                 rc =3D fread(buffer, file_size, 1, file);
> >                 if (rc !=3D 1) {
> >                         fprintf(stderr, "Failure reading file: %s\n", a=
rgv[i]);
> > diff --git a/secilc/secilc.c b/secilc/secilc.c
> > index 80d3583..f3102ca 100644
> > --- a/secilc/secilc.c
> > +++ b/secilc/secilc.c
> > @@ -286,6 +286,12 @@ int main(int argc, char *argv[])
> >                 }
> >
> >                 buffer =3D malloc(file_size);
> > +               if (!buffer) {
> > +                       fprintf(stderr, "Out of memory\n");
> > +                       rc =3D SEPOL_ERR;
> > +                       goto exit;
> > +               }
> > +
> >                 rc =3D fread(buffer, file_size, 1, file);
> >                 if (rc !=3D 1) {
> >                         fprintf(stderr, "Failure reading file: %s\n", a=
rgv[i]);
> > --
> > 2.33.0
> >
