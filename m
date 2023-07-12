Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7746DEB64DA
	for <selinux@archiver.kernel.org>; Wed, 12 Jul 2023 17:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjGLRf1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjGLRf0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jul 2023 13:35:26 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC771FD2
        for <selinux@vger.kernel.org>; Wed, 12 Jul 2023 10:35:23 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6ef9ed2fdso120098181fa.2
        for <selinux@vger.kernel.org>; Wed, 12 Jul 2023 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689183322; x=1691775322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qOckOilpr3y0tNUzzDSA81thRQ6GicT21wbPoFLgyg=;
        b=WKs13ch3FCJQzirC820Pij0DHTS35RYBRpyortOzU9PAtyUTwcp/1pCpYMnlyufoX1
         Ccs1zWE35p8Iw2hoElmOZ4mDgVaEgDJzUR/64pRROaJkLBTyNjMqXGaG9GH7KH/7n7tz
         ZkzDL+oybYG+OgpMhbMWhF7TUYihVkvPDVkHTTYta6lNyCKw61wmdENL/cznZOtqEh2O
         V4WxST/86dXDqmH2/BtlQHYGQXWJepAbZbyor4VcLdhStkdMl91wU25E50KLnFAfx4GX
         NIn9DzCe18PxHuvPPxXsACOZxe4wMJVvNGosILoV2mHyyeWPc4MBs09FTXWpVrFm9SrE
         UXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183322; x=1691775322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qOckOilpr3y0tNUzzDSA81thRQ6GicT21wbPoFLgyg=;
        b=XhHwUCJlwpgyfbQEVUrYSmovqs8tDBsY14GQgbDMHlJNUHPTYJz1dKm/ac0yO5+gGJ
         vSTPmHB04hQYfK4l5MoAZX2ROCbUY87uIq+86ss+pxTO11K3eS+kT6Cy6dUxrre1wytW
         Ftuc+DMp2iHWj8eVnmKjv5fJCH5JVvM00rkN+w8hCJ/jU85CaOUnC4evIcceKb/JTjJ8
         hc47fn/gtxIS8UzrngAq87uMEFeK3sPeICkmyGeilz7PlfJSdAJtH6BZ4rD/bqkSq71M
         b+XJnmn9PxlRTTtz9oCGOOO2PAwdCTsfEX4NRT2zYcIVm2Pr2sM/E6lmfu5ypIgw9u9o
         xiag==
X-Gm-Message-State: ABy/qLZ5o1tnzAMHECtHVHrw+ow3/XYQpWSFwW71Lkx3ogLj5ypKUtPt
        RLmYRnpJawn2ws/c7at1s677qm93l8jmW7/C8iJqkt6O
X-Google-Smtp-Source: APBJJlEKWKx153bZKqxJnrI+cHsHJb8dB9nOqiJUMTFIntMu1nPNMVpAhYuY6wKEyDEmttRYvwzrmmFknphodx9QvKo=
X-Received: by 2002:a2e:97c7:0:b0:2b7:a64:6c3e with SMTP id
 m7-20020a2e97c7000000b002b70a646c3emr14006087ljj.26.1689183321551; Wed, 12
 Jul 2023 10:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230706135718.44908-1-cgzones@googlemail.com> <CAP+JOzThojv3f2ScWr4v7-6oBDidzXqB3fHWA4OufUjRi9rt5g@mail.gmail.com>
In-Reply-To: <CAP+JOzThojv3f2ScWr4v7-6oBDidzXqB3fHWA4OufUjRi9rt5g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 12 Jul 2023 13:35:10 -0400
Message-ID: <CAP+JOzSde=B2hN8=xCYQL1i0Hqez+6_S77pRxBEawFZ6TgfacQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: check for overflow in put_entry()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 11, 2023 at 3:16=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jul 6, 2023 at 10:03=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > put_entry() is used during writing binary policies.  Avoid short writes
> > due to an overflow.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/services.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index 062510ab..07ae051b 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -1708,7 +1708,10 @@ int next_entry(void *buf, struct policy_file *fp=
, size_t bytes)
> >  size_t put_entry(const void *ptr, size_t size, size_t n,
> >                         struct policy_file *fp)
> >  {
> > -       size_t bytes =3D size * n;
> > +       size_t bytes;
> > +
> > +       if (__builtin_mul_overflow(size, n, &bytes))
> > +               return 0;
> >
> >         switch (fp->type) {
> >         case PF_USE_STDIO:
> > --
> > 2.40.1
> >
