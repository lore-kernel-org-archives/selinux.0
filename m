Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9423CCA483
	for <selinux@archiver.kernel.org>; Wed, 20 Jul 2022 15:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiGTPfg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiGTPfg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jul 2022 11:35:36 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BA32A95A
        for <selinux@vger.kernel.org>; Wed, 20 Jul 2022 08:35:35 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10d6ddda695so8621902fac.0
        for <selinux@vger.kernel.org>; Wed, 20 Jul 2022 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GLqguB+COIs2/vcu066R2rObbfTSNUfdf1wiBbLbPiM=;
        b=LuyeE5/CHVTpi+TipYM+5pZPo1at/d2L775AeSJ+yPjpNu9I/dAY3fmvMoQr8A2UCR
         eNXnXzV3LlplBYnGL1HoMB2xpKfIrTtAsoNmKV5s6Gtm0aBBv8IBrbXf+Vlvho09O1gn
         gCJ/eLIUoTkj+YrhHiY7tW38yMtTJsHZvoxgCDmpE4CiZwP69Pg4nKaBS7WJx3jxv5X9
         wOMHO4RK+hiafiA8VbflfrsYazIyqnvsr5qrLDwXSVt0pWYpovRrODfylZaeI4YLfda4
         6fHwcIg72pqIkMtoaMwljDI86RQBzveZNPLMe/cAgVeBqPr8ZOMQ6JUNPuSsHGaJDicI
         pSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GLqguB+COIs2/vcu066R2rObbfTSNUfdf1wiBbLbPiM=;
        b=bqpb3PTop6PmYQRa8IsHibvWooTFq09ksz6J8b4bgc4bEPxbBoXCw11eBjMzd6QV49
         CBYwfuOAVeL8s2ot6wNGWM+umT41MyZNkZN880BK0JGnTLcOVHYGV231pA/ng2PAHe8/
         SplgO1oao3Gd8aFk7PFzf0SkzBP2cFde5W6yErlzfFYurDNMnDy89S/At8sDrCAbv6IP
         Ym6xt6V3uZNNGzfoODiGrx+R1bisEAcqW3kqaP6nHyChf8S9WbhoporIUnKruxr+meEw
         3h6oNYkogt49sRwPimwh52wVMn8fzFF0x8+kPV8M9eUTJWAsdbqnoeICu0djn7CMEaSH
         dAqw==
X-Gm-Message-State: AJIora9t3gW+0zairljwWTyoyDk/+N47b60PO3pp/uyJBoZ4hs7mMRc6
        muqDUV0OHQmWWKEpwSbiP0/kbvTp2MRezak5lnE=
X-Google-Smtp-Source: AGRyM1urcNMC0RpIWVm3AeMkMFs32YyKC1uVeCvdB/pU2IMoyon02VxpBs35onmMUJx2ELOYHwHWyEyKEJXBWryedM8=
X-Received: by 2002:a05:6870:c0c5:b0:10d:5f5c:9ab1 with SMTP id
 e5-20020a056870c0c500b0010d5f5c9ab1mr2914097oad.156.1658331333943; Wed, 20
 Jul 2022 08:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220713141148.35524-1-cgzones@googlemail.com>
In-Reply-To: <20220713141148.35524-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 20 Jul 2022 11:35:22 -0400
Message-ID: <CAP+JOzRgHNszK8QSMKGuNcBvCFZ2pHb2NPkgnGATUJ9+=7M2kA@mail.gmail.com>
Subject: Re: [PATCH 1/5] libsepol: rename validate_policydb to policydb_validate
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 13, 2022 at 10:12 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Most global functions operating on a policy database use policydb as
> prefix.
>
> Since this function is not exported there should not be any external
> use.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For this series:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb.c          | 2 +-
>  libsepol/src/policydb_validate.c | 2 +-
>  libsepol/src/policydb_validate.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index fc260eb6..8a65df05 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -4570,7 +4570,7 @@ int policydb_read(policydb_t * p, struct policy_fil=
e *fp, unsigned verbose)
>                 }
>         }
>
> -       if (validate_policydb(fp->handle, p))
> +       if (policydb_validate(fp->handle, p))
>                 goto bad;
>
>         return POLICYDB_SUCCESS;
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 99d4eb7f..e1dad236 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1330,7 +1330,7 @@ static void validate_array_destroy(validate_t flavo=
rs[])
>  /*
>   * Validate policydb
>   */
> -int validate_policydb(sepol_handle_t *handle, policydb_t *p)
> +int policydb_validate(sepol_handle_t *handle, policydb_t *p)
>  {
>         validate_t flavors[SYM_NUM] =3D {};
>
> diff --git a/libsepol/src/policydb_validate.h b/libsepol/src/policydb_val=
idate.h
> index d9f7229b..b7f9f191 100644
> --- a/libsepol/src/policydb_validate.h
> +++ b/libsepol/src/policydb_validate.h
> @@ -4,4 +4,4 @@
>  #include <sepol/policydb/policydb.h>
>
>  int value_isvalid(uint32_t value, uint32_t nprim);
> -int validate_policydb(sepol_handle_t *handle, policydb_t *p);
> +int policydb_validate(sepol_handle_t *handle, policydb_t *p);
> --
> 2.36.1
>
