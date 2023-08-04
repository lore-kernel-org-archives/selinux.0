Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3B6C001DE
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 19:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjHDT54 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Aug 2023 15:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjHDT5z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Aug 2023 15:57:55 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A704E60
        for <selinux@vger.kernel.org>; Fri,  4 Aug 2023 12:57:54 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9d3dacb33so40370761fa.1
        for <selinux@vger.kernel.org>; Fri, 04 Aug 2023 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691179073; x=1691783873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eM4+EpCGKIiL88V0JBkLj+eDtUUivVrNmmc5f/5XwGo=;
        b=Y1080SvKp9jPXIIx25Huk0WGJv88OMgDhAY1L7+sYeYaxgxpCiHw2KN+xzG0q8Yep2
         YKO9iZZyW3xcZObsHCdIfgBSOPFls4kF37N9qSX2Suct+Dp4GIpHRm7V3ac6vr9St9Yq
         Z+UbiaoYHZy0tbWcabXt8UFNN2rp4u0cLeFg2PUzPV/JsnKp76lpTjAUyR6kbi7puzxl
         VEyAU05y4nneyW7FQmvj/Oj/5ZFihzY+TE6vfwQtADmrtpq2VDjqdqV35z2NE3SdiKo2
         jzSlt/Ik+rny6hXDEk21b5CojLm6BDuJPL75azFRqvOZTZ20XtcWeYmJXbcqfatnd2PR
         i1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691179073; x=1691783873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eM4+EpCGKIiL88V0JBkLj+eDtUUivVrNmmc5f/5XwGo=;
        b=Hvw06HSxMDGbab/IjpgcEjnm64DDu/2oBpt4ku6YeXBlYs9TQjpL2JYz6LVYWxdu7u
         bExceTsdkATfKLgni1W55xK5ZsnGT7m9wjuGCYNXqKyV6L9OmJ9iJV3Bi8BSoYf5zZ3X
         NaHmJZ+6ZJf1NlWo7wXwguyWllCc/QbhMzF2swWHYSeQs4XuacoWLvXsTJmNcxBCyAaL
         fY9AwZp1/+aOgTAZoN+aDtVDWZKMG1ep1tHFhSipLP/yK5UuIOXFln+mc54KyDIqNHK+
         CUQenxPXaiEHDhLfWU/S1gcVe5lkSDOWSl/ihJb404FNdLawIhk+afhCcxRf8jGJk4fF
         m8zw==
X-Gm-Message-State: AOJu0Ywbhfcl50Q8o/eQHrhzCYWZ9IJgaB8+fbYrLR/C4DDqE5Dphaxr
        0GhHm+N7Vj9t729ZrwZivob0yVlXtvSmKOTZ81w=
X-Google-Smtp-Source: AGHT+IHq3wO36I8Xej5H//9ozlbSjdM9qsl/J3KTQUIACVC/gC14r0GBKiisSwcQIwuuP36TYkHm5Aeb8r8V2VGlRHk=
X-Received: by 2002:a2e:7d02:0:b0:2b9:4324:b0a7 with SMTP id
 y2-20020a2e7d02000000b002b94324b0a7mr2258860ljc.51.1691179072537; Fri, 04 Aug
 2023 12:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230713180816.101924-1-cgzones@googlemail.com> <20230713180816.101924-2-cgzones@googlemail.com>
In-Reply-To: <20230713180816.101924-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Aug 2023 15:57:41 -0400
Message-ID: <CAP+JOzQ-AuM9M3c4ehKYca-eUAOy0wbVGkygkpPkhhSTNaVC-Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] libsepol: reject avtab entries with invalid specifier
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 13, 2023 at 2:35=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Neverallow avtab entries are not supported (normal and extended). Reject
> them to avoid lookup confusions via avtab_search(), e.g. when searching
> for a invalid key of AVTAB_TRANSITION|AVTAB_NEVERALLOW and the result of
> only AVTAB_NEVERALLOW has no transition value.
>
> Simplify the check for the number of specifiers by using the compiler
> popcount builtin (already used in libsepol).
>
> Reported-by: oss-fuzz (issue 60568)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/avtab.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 5c76fe12..7b85519b 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -564,7 +564,6 @@ int avtab_read_item(struct policy_file *fp, uint32_t =
vers, avtab_t * a,
>         avtab_datum_t datum;
>         avtab_trans_t trans;
>         avtab_extended_perms_t xperms;
> -       unsigned set;
>         unsigned int i;
>         int rc;
>
> @@ -666,13 +665,13 @@ int avtab_read_item(struct policy_file *fp, uint32_=
t vers, avtab_t * a,
>         key.target_class =3D le16_to_cpu(buf16[items++]);
>         key.specified =3D le16_to_cpu(buf16[items++]);
>
> -       set =3D 0;
> -       for (i =3D 0; i < ARRAY_SIZE(spec_order); i++) {
> -               if (key.specified & spec_order[i])
> -                       set++;
> +       if (key.specified & ~(AVTAB_AV | AVTAB_TYPE | AVTAB_XPERMS | AVTA=
B_ENABLED)) {
> +               ERR(fp->handle, "invalid specifier");
> +               return -1;
>         }
> -       if (!set || set > 1) {
> -               ERR(fp->handle, "more than one specifier");
> +
> +       if (__builtin_popcount(key.specified & ~AVTAB_ENABLED) !=3D 1) {
> +               ERR(fp->handle, "not exactly one specifier");
>                 return -1;
>         }
>
> --
> 2.40.1
>

Patches 1, 3, and 4 depended on the prefix/suffix patches and are no
longer applicable.
But this one does seem like it is, but, of course, it will not longer
apply cleanly.
Jim
