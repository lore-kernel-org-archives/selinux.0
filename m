Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC5AC433EF
	for <selinux@archiver.kernel.org>; Mon, 14 Mar 2022 19:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiCNTuv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Mar 2022 15:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244592AbiCNTuo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Mar 2022 15:50:44 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C54B7CF
        for <selinux@vger.kernel.org>; Mon, 14 Mar 2022 12:49:07 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so21723915ooj.2
        for <selinux@vger.kernel.org>; Mon, 14 Mar 2022 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2AX1iIXoWGv9h7zmvNuKg7hw2V5hnQJUUIMWzoWVoBc=;
        b=cga8scO6nxOEIKHJEk1TXiEU1MWDMliK65iuWu2gQliFL7razfzOjEpg437qtlqyOg
         hZTA03BE1rH7AQgY3BXtddDSmj5HPyOxkACKw01qYGkEUmIweV4nv/Vbe0qs1CXU+vTk
         ICYiQg1nY23IWP+F4qT6jd4Ge7gQSp/NovszejzCJ3p89jTsARdLyd2I3XqdessIrnIb
         OXefVqZ/mAYdIorwKBTpAOHQQRiRikT6D2Mu4f9g50gzxIPJEsaU2cbPwmdsL5FGHuF+
         T7o9Nzo+RG5ns+NSIzq8phONCzjF34plkuzDkUi7XWCwTCcIhVTuUSaCD51lzQOOmXKA
         TFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2AX1iIXoWGv9h7zmvNuKg7hw2V5hnQJUUIMWzoWVoBc=;
        b=x22Pcghb7kD6G51iGZB+sCUC777S+p2mZfOk2NRp2AlQTnHHPQ3bPMKcTHwlTGVLn3
         1WpG2TyE01GzkcN64ub2B/UjEIVAYZ/CdVxGwXej3qU/zlK2v3Vaw6hZvv/DStWmg9No
         J/60l/5Z9tlV5NiekgpprUOramLLTX52o94+FY0KAdxF2oV3+ocggRo0u3SqFOFX+YiP
         RK+dJUToLV+Qy/1l09gvpU8QXLgqvrxMDoAcw5H4SZquk7tZ/zuJPQrlgk9d9GcX+ik+
         YYvFfG4V2f5aeBKlYw5uCQsH1VVUOoRyEzhgauLAxtQ1y1TQhk9kzi7+1hKPbJsTugJN
         l4DQ==
X-Gm-Message-State: AOAM532/s9xGeA1kmIVh17TBCe+Sw8inLarTGDZk7GcXD+gWprcThBU/
        jF3T9gWRKrP1uFvISwBV4dn8+QvI9sgJhtQ/GWntUgstN7k=
X-Google-Smtp-Source: ABdhPJyQryi4EDlkOBXZZuwW7VYKFfE3Zj/f5jnfQKCGuTWgCCdBoCqCbG2eBbbt6zAL9nlFsA+zwCotA/4xX3PsjPc=
X-Received: by 2002:a05:6870:46ab:b0:d9:cbf6:855c with SMTP id
 a43-20020a05687046ab00b000d9cbf6855cmr318608oap.156.1647287344633; Mon, 14
 Mar 2022 12:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220311115330.922386-1-plautrba@redhat.com>
In-Reply-To: <20220311115330.922386-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 14 Mar 2022 15:48:53 -0400
Message-ID: <CAP+JOzQp63qBgu47OpOwkAF-yg6Tu89HSB68B2HcjSsrKAnsKQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Close leaked FILEs
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 11, 2022 at 5:10 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Fixes:
> label_media.c:94:24: warning: leak of FILE =E2=80=98fopen (path_28, "re")=
=E2=80=99 [CWE-775] [-Wanalyzer-file-leak]
> label_x.c:121:24: warning: leak of FILE =E2=80=98fopen (path_28, "re")=E2=
=80=99 [CWE-775] [-Wanalyzer-file-leak]
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label_media.c | 4 ++--
>  libselinux/src/label_x.c     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> index eb27deaf510e..3137c18edc19 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -95,10 +95,10 @@ static int init(struct selabel_handle *rec, const str=
uct selinux_opt *opts,
>         __fsetlocking(fp, FSETLOCKING_BYCALLER);
>
>         if (fstat(fileno(fp), &sb) < 0)
> -               return -1;
> +               goto finish;
>         if (!S_ISREG(sb.st_mode)) {
>                 errno =3D EINVAL;
> -               return -1;
> +               goto finish;
>         }
>         rec->spec_file =3D strdup(path);
>
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index e9fa063fafff..e6e8d9f60bff 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -122,10 +122,10 @@ static int init(struct selabel_handle *rec, const s=
truct selinux_opt *opts,
>         __fsetlocking(fp, FSETLOCKING_BYCALLER);
>
>         if (fstat(fileno(fp), &sb) < 0)
> -               return -1;
> +               goto finish;
>         if (!S_ISREG(sb.st_mode)) {
>                 errno =3D EINVAL;
> -               return -1;
> +               goto finish;
>         }
>         rec->spec_file =3D strdup(path);
>
> --
> 2.35.1
>
