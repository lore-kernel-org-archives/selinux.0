Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5695CDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379624AbjJLRwc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379676AbjJLRwb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:52:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42F7DA
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:52:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50306b2920dso1435378e87.0
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133148; x=1697737948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5uvQn5UdIwPIlkT7GJOYvRdrB1u7IIeUrmA+ltgglw=;
        b=P0K//IJ/4i4bdTLWIx+EdGBbmDFtbS/cuNW6HcbTpM+6WaSLh1zShQKxOOy6cYW9Xn
         128nmENUBjRMMyDyMj7dNsj5U+oeEza20sUAhhDPr97yDrR5mFjGbOKMoIV7BWP5C3mv
         QyHABelEe2pVVgXtv9RN20YiHPJqGtebHlxr+OvzX39KetFyAkVrfytfgtidFygF+Ona
         cJtY0d+Wh1F4NDRxzaS/V8oxTn20wEQQHgg4K8mmXDXQYW0DOVuvrDh02WShG1Ry0SoP
         cPE1Zbmf7bZbvL+UF+cbXEM5T9qnQRp5qhY3ppHJG9KANb/qVWE8l/A3wP0olYmi6NRz
         elcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133148; x=1697737948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5uvQn5UdIwPIlkT7GJOYvRdrB1u7IIeUrmA+ltgglw=;
        b=t+0trOvY2lixY/oabjlFXsVul3arf5LBzJ/jLbh4cQB5hrsiiKQSjskWI5uqLFRbSw
         z6YP1dgJBTHSo+oOmuf+WqbTR2YL2M3VBWBmYsj5FBXDPNnRpEssNlrWh2MNV2emofgF
         tq5bLMh7kUVkqKVmBHG1I0vtEDVBfxol0vU/BUWLRLR38Ix4UAntU9In7NT5vkAoHeCG
         H5zCkqcDRW/NEF6tLbeWd5/UIV7H4CzylpehLlE5uRAmHI75epycBeVhtY3metXdb2Tj
         gEjdRrcc6EdlTQ/6QhPeBDeFVoKdvP1UZGj1gzkV7Crnb0nlc8nS/2wjK7X/ac8npWxa
         xNfA==
X-Gm-Message-State: AOJu0YxZ+v+CBVii3w8r+S8PqyxNARBae5boueaW2negkF96psvtFfeB
        vffvwwkBAkl/QsQiCzVbK4h8MkUNzASa6TMAp7KFax7w
X-Google-Smtp-Source: AGHT+IE1v3q0WV6Nd4oelVgkMvVxMDQdVgjd5eoiNKqGJrakeelfb+vj2XdOEYTEUpaJJhSy2uw0QJ9A1Ln9OGLShrY=
X-Received: by 2002:a05:6512:313c:b0:500:96dd:f95a with SMTP id
 p28-20020a056512313c00b0050096ddf95amr16336598lfd.24.1697133147797; Thu, 12
 Oct 2023 10:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-2-cgzones@googlemail.com> <CAP+JOzTD6muhUFDoaMOP=bqbL76pPq_doWvZekW_v7QJeWEiNw@mail.gmail.com>
In-Reply-To: <CAP+JOzTD6muhUFDoaMOP=bqbL76pPq_doWvZekW_v7QJeWEiNw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:52:16 -0400
Message-ID: <CAP+JOzSMymihd9HrQf=K6YGWTV6faKvATmfnyzKv9rrnNszvew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/27] libselinux/utils: update selabel_partial_match
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
> > Print usage information and exit if required path option is not given
> > or superfluous arguments are given.
> >
> > Constify read-only variables assigned command line arguments.
> >
> > Simplify bool evaluation.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/utils/selabel_partial_match.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/utils/selabel_partial_match.c b/libselinux/util=
s/selabel_partial_match.c
> > index 7bbd5777..0df2627a 100644
> > --- a/libselinux/utils/selabel_partial_match.c
> > +++ b/libselinux/utils/selabel_partial_match.c
> > @@ -28,7 +28,7 @@ int main(int argc, char **argv)
> >  {
> >         int opt;
> >         bool partial_match;
> > -       char *validate =3D NULL, *path =3D NULL, *file =3D NULL;
> > +       const char *validate =3D NULL, *path =3D NULL, *file =3D NULL;
> >
> >         struct selabel_handle *hnd;
> >         struct selinux_opt selabel_option[] =3D {
> > @@ -55,6 +55,9 @@ int main(int argc, char **argv)
> >                 }
> >         }
> >
> > +       if (!path || optind !=3D argc)
> > +               usage(argv[0]);
> > +
> >         selabel_option[0].value =3D file;
> >         selabel_option[1].value =3D validate;
> >
> > @@ -69,7 +72,7 @@ int main(int argc, char **argv)
> >         partial_match =3D selabel_partial_match(hnd, path);
> >
> >         printf("Match or Partial match: %s\n",
> > -                   partial_match =3D=3D 1 ? "TRUE" : "FALSE");
> > +                   partial_match ? "TRUE" : "FALSE");
> >
> >         selabel_close(hnd);
> >         return partial_match;
> > --
> > 2.40.1
> >
