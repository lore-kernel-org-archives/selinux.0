Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D568C001DF
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 18:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjHDSji (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjHDSjd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Aug 2023 14:39:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207A4C0E
        for <selinux@vger.kernel.org>; Fri,  4 Aug 2023 11:39:23 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so37492771fa.2
        for <selinux@vger.kernel.org>; Fri, 04 Aug 2023 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691174361; x=1691779161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvQOBgarlXDSY20vj2KowyzgLNSiCzFJljV9xmNtSHc=;
        b=Epk1+xdhIvTW/lsMAS8aWzv9TjuaCsDFsbqxBgx5fHrypUNmUbeNhYlaDxD/+aO4lk
         zdd0ySt1NUKubXb1rU6djrtjLCYR09ndL1DWt3fvLm4/gD2QL6frvOcCu31GctsO1qh7
         VksTLPGOwwQy6ImxeEH7ytThX5H3DSvi2h/cACXk1IqxFbQDyT67HzazNAK1rwcBTmtT
         kG9uzZqjg4Q0mYTOjqrSgnoFVy3SWEHf2rjM+d/NKt25NSPFxJvwUEs+szcZg9rAOm6b
         wvpQ3SlGAMX7j0Rb5e4DA0kq4FNCMN+UyxNlebfBP3lD+7icfyoXyYY1JRGAJcCvanS9
         wDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174361; x=1691779161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvQOBgarlXDSY20vj2KowyzgLNSiCzFJljV9xmNtSHc=;
        b=TOGSbSrzLM+3Hcyeh9i33noVlQhUtwsauLgw3A5hSYly48Kuk/z/EzRV167EN/55bs
         haDUDaDZtIyUrH81rWUqcEvytIHm4zbEZxpiXVoWuxLvH8Xc1L0YIP3LG3Thk2UgCgwU
         14ckZSobSdMlh80J45BMK9HjNBhRStBWGCGGR3VTz4qbAc8f5tiTT/0hqcHXoyM/uvPR
         7qsFUxE8Sgd3lM8Cfvsr5HQhgdUjqi0IzeBluYwHosvW/PiZ6ASIXIwufunzReZbcRj/
         Agsfa5wVOmcJctWqlq6xF5sXuKJaTNZhbikQxTb8EKK3DUgQlN2z8Leq4A6oF49Rrlrj
         hs9A==
X-Gm-Message-State: AOJu0Yw2Uy207KviZiM1Ssu+00xdoC+gwUOsxrnYZs83lcRlzHj1sm9S
        AtkeF8UTxPzh9ox39BuOTyPVX+u8+SMsqewPrJ17N9Ca
X-Google-Smtp-Source: AGHT+IGblkaAA+yDZyCTwhGBRtoN+GrN8iQlp9kmv0bWzpN11Pf+urffYLGjas85ft5ynADbzgyVZBIgxB9VCswXvn4=
X-Received: by 2002:a2e:9b4c:0:b0:2b9:3523:6f20 with SMTP id
 o12-20020a2e9b4c000000b002b935236f20mr2148922ljj.51.1691174361659; Fri, 04
 Aug 2023 11:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230714185033.45471-1-cgzones@googlemail.com> <CAP+JOzSz83bTgWaWF6EogNrfcbsZG7SgKZ_5aFz2co4iYMZgxg@mail.gmail.com>
In-Reply-To: <CAP+JOzSz83bTgWaWF6EogNrfcbsZG7SgKZ_5aFz2co4iYMZgxg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Aug 2023 14:39:10 -0400
Message-ID: <CAP+JOzT3k25CMrWGOTE6sEiqdacv5oJ8Z=bFWpdmhrThjKhOGA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux/utils: introduce getpolicyload
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 28, 2023 at 2:11=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Jul 14, 2023 at 2:56=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Introduce a helper binary to print the number of policy reloads on the
> > running system.
> > Print only a single number to ease the usage by scripts.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > v2:
> >   - use main() prototype with arguments
> >   - use argv[0] instead of hard coding program name
> >   - fix indentation and spacing issues
> >   - add binary to .gitignore file
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/utils/.gitignore      |  1 +
> >  libselinux/utils/getpolicyload.c | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> >  create mode 100644 libselinux/utils/getpolicyload.c
> >
> > diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> > index b19b94a8..b3311360 100644
> > --- a/libselinux/utils/.gitignore
> > +++ b/libselinux/utils/.gitignore
> > @@ -10,6 +10,7 @@ getenforce
> >  getfilecon
> >  getpidcon
> >  getpidprevcon
> > +getpolicyload
> >  getsebool
> >  getseuser
> >  matchpathcon
> > diff --git a/libselinux/utils/getpolicyload.c b/libselinux/utils/getpol=
icyload.c
> > new file mode 100644
> > index 00000000..ce06bb78
> > --- /dev/null
> > +++ b/libselinux/utils/getpolicyload.c
> > @@ -0,0 +1,30 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +#include <selinux/avc.h>
> > +
> > +
> > +int main(int argc __attribute__ ((unused)),
> > +         char* argv[] __attribute__ ((unused))) {
> > +       int rc;
> > +
> > +       /*
> > +       * Do not use netlink as fallback, since selinux_status_policylo=
ad(3)
> > +       * works only after a first message has been received.
> > +       */
> > +       rc =3D selinux_status_open(/*fallback=3D*/0);
> > +       if (rc < 0) {
> > +               fprintf(stderr, "%s:  failed to open SELinux status map=
:  %m\n", argv[0]);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       rc =3D selinux_status_policyload();
> > +       if (rc < 0)
> > +               fprintf(stderr, "%s:  failed to read policyload from SE=
Linux status page:  %m\n", argv[0]);
> > +       else
> > +               printf("%d\n", rc);
> > +
> > +       selinux_status_close();
> > +
> > +       return (rc < 0) ? EXIT_FAILURE : EXIT_SUCCESS;
> > +}
> > --
> > 2.40.1
> >
