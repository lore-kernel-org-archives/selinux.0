Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5631BC001DE
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 18:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGSSrX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGSSrW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 14:47:22 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAA1199A
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 11:47:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so111610031fa.0
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689792439; x=1690397239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJosxKIKXcovtSt3rOVhcgsBGE8jhWw5hHzsaNboklc=;
        b=c7F0k1Eg2TUZlCpPC1D/pFgXM1OT3ncdChKXfA2j+s+a3ksynvrKyJgfYgB/G1sFJH
         L+l76jld1k1VB00AwICrfVddxEtwBuHZ0RI+YMZNPdGRlZ+1h5T5XqrEICtmmCSPVtLF
         9klbMLIr64y6lXQioq81szv+4W1hwe7i6VJ1L9uEfhVbA4hqQI/1tMvvCu4VP9Ft09ix
         6ehTHUu/vjM/xBSUY+/3KSt8zRHQfkC2bZzaFkpqPg871F0jF+tgCfV7hHprZ/MLcb9B
         aRAdwlBiJyDxT+EXZ9pihoQSRC1yDdjTKr7v6+wnu4lEnWlaqvx5Mdgf9ID9ioZDon0B
         dXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689792439; x=1690397239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJosxKIKXcovtSt3rOVhcgsBGE8jhWw5hHzsaNboklc=;
        b=jvN3Nu5jKMfjqaHoabCEUCFFiO3DmQea3l6Z6hTiMCQ2ensX/k9rJ3Njqh6x0Lhakb
         Ruh95mX9VRsY1yUCN+TP8ED+p6yDb2l4M1jKoAJWXpbRZBCfiGBOUZG1zwyyFCtT6V1q
         +gJZqqEVg8gqydOeBtAOLhNDvx4Ht89H5md94gcxmALAYRYhUPf6bO2ojlaTywf/9Gy0
         RcSbLv6y5u8X7tv2UvwlLF+JCS7LMatnSGv8lI3f8CY/1pvIkcyPhcZfatN9RB5Egt+N
         FKXSnnETBFT1sTiLDZCHz7eMFbXRd37OB42HnrN7ypaYflDrpz4fMGQRtaVVlzhMxmM+
         KdvQ==
X-Gm-Message-State: ABy/qLYJz9GmTkfBZtbRlLWLm1FPHTFuEp8qnjJaveVP0Bqdgym/QijS
        KEFUY4TFgJ/lL2/qhI/IFh+Jbm4HbP8Cg/Hlt0M=
X-Google-Smtp-Source: APBJJlHKunfqXCzYADAz3W6rUo6IqW8bA4z8prMiWETsXVyKkSyOnsc0mzhdZNXq6lNVjhFnObQDRl/bnOqg3ivSO8E=
X-Received: by 2002:a05:651c:14b:b0:2b6:d63d:cc1e with SMTP id
 c11-20020a05651c014b00b002b6d63dcc1emr546399ljd.51.1689792438816; Wed, 19 Jul
 2023 11:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230713063504.161485-1-luhuaxin1@huawei.com>
In-Reply-To: <20230713063504.161485-1-luhuaxin1@huawei.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 19 Jul 2023 14:47:07 -0400
Message-ID: <CAP+JOzQ2i+QG9ZUsauW75jeoXQYoPEJvSAFCHRqbF8iMd43dxA@mail.gmail.com>
Subject: Re: [PATCH] secilc: add check for malloc in secilc
To:     Huaxin Lu <luhuaxin1@huawei.com>
Cc:     selinux@vger.kernel.org, shenyining@huawei.com,
        fangxiuning@huawei.com, zhujianwei7@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 13, 2023 at 5:12=E2=80=AFAM Huaxin Lu <luhuaxin1@huawei.com> wr=
ote:
>
> Check the return value of malloc() to avoid null pointer reference.
>
> Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  secilc/secil2conf.c | 6 ++++++
>  secilc/secil2tree.c | 6 ++++++
>  secilc/secilc.c     | 6 ++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
> index c49522e..bf050f3 100644
> --- a/secilc/secil2conf.c
> +++ b/secilc/secil2conf.c
> @@ -152,6 +152,12 @@ int main(int argc, char *argv[])
>                 file_size =3D filedata.st_size;
>
>                 buffer =3D malloc(file_size);
> +               if (!buffer) {
> +                       fprintf(stderr, "Out of memory\n");
> +                       rc =3D SEPOL_ERR;
> +                       goto exit;
> +               }
> +
>                 rc =3D fread(buffer, file_size, 1, file);
>                 if (rc !=3D 1) {
>                         fprintf(stderr, "Failure reading file: %s\n", arg=
v[i]);
> diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
> index e5cdf6b..d04566d 100644
> --- a/secilc/secil2tree.c
> +++ b/secilc/secil2tree.c
> @@ -158,6 +158,12 @@ int main(int argc, char *argv[])
>                 file_size =3D filedata.st_size;
>
>                 buffer =3D malloc(file_size);
> +               if (!buffer) {
> +                       fprintf(stderr, "Out of memory\n");
> +                       rc =3D SEPOL_ERR;
> +                       goto exit;
> +               }
> +
>                 rc =3D fread(buffer, file_size, 1, file);
>                 if (rc !=3D 1) {
>                         fprintf(stderr, "Failure reading file: %s\n", arg=
v[i]);
> diff --git a/secilc/secilc.c b/secilc/secilc.c
> index 80d3583..f3102ca 100644
> --- a/secilc/secilc.c
> +++ b/secilc/secilc.c
> @@ -286,6 +286,12 @@ int main(int argc, char *argv[])
>                 }
>
>                 buffer =3D malloc(file_size);
> +               if (!buffer) {
> +                       fprintf(stderr, "Out of memory\n");
> +                       rc =3D SEPOL_ERR;
> +                       goto exit;
> +               }
> +
>                 rc =3D fread(buffer, file_size, 1, file);
>                 if (rc !=3D 1) {
>                         fprintf(stderr, "Failure reading file: %s\n", arg=
v[i]);
> --
> 2.33.0
>
