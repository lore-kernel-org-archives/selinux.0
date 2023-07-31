Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFC1C00528
	for <selinux@archiver.kernel.org>; Mon, 31 Jul 2023 19:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGaTzG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jul 2023 15:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjGaTzE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jul 2023 15:55:04 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F39019A2
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 12:55:00 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso73782041fa.0
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690833298; x=1691438098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90D2UFcYP0Jxmhozoc2hSMqdriIOdphEiGENQ3N8ybU=;
        b=J4lBUI/yhZ4kjga7Y2E9QkV2aIVJQAjXgwCwvnLsVUdljpCJinNGPiRtQF+sU0e+Pt
         3Rj7RreRvJVHu7fUd7EcXb0EojHiJ1h5c5KzGsPLWfSmoIpt+gUigoHg8dlqpezRaMXY
         opeIJ0pKyXmctt0yREqmz5zOly1ZGJK8thMqdBFJNxx0/Xj6N/6uSxJSFCMkgHmslHeg
         +a2thsnsKmsGID5eFbaWmMZP/iFwht44n8Akrfn4rmUvMYpthzDADarnrlJq1fNosKX+
         fQ0HJxVzVToFBdSktZycCYdSFbiAXru994dhESoj3IBrgv/cEV/0oSqw3UTp3cAMpsN4
         vhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690833298; x=1691438098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90D2UFcYP0Jxmhozoc2hSMqdriIOdphEiGENQ3N8ybU=;
        b=lv60yDdwCxJuG9bwHItWRZ6eVoHQtDT5AQwlwlZR6eJHXHLhnATqYuasFEgupfpoqw
         sFNpFAZiFDeWsZtCDnU5ntM6MV/nP6AE5S8yn/TGEn5vu+VnsMd0DACdA4j5D5bLVlzl
         BhSP4K4MQzW4FaxMEv2NrsxqnZpbVnSztHDakQ5EUxGaxHUo+CHMO8hOv0ukyJGUKfif
         l/dGGFTUKmM+8oJk1vcPOQHihs8Pbwi81eAkovedGQx3w9/ClqqCtTIYSuPl/f7V8+WZ
         2TVde6YBFM3xMs7GXSA92KUbD+3/n7wH3djc4SGVaXgX1+XpUVXBOinbvIBgXSCyPDbo
         d57Q==
X-Gm-Message-State: ABy/qLYl48AzlPLobMHxZD1z4l189ez6A3QRuBrCwJRCpOTjHgS59x9b
        9yRynqNtjR4+GRgE4dYzsOd/uIzEarjRPieOcdj+IjiM3A4=
X-Google-Smtp-Source: APBJJlHUV41hj8buzsXTswgXZyNiYAPnrCjWmN3OvOW+h93ViXVPUGh4u9174tUH36C5DlEdtN/bOVbLEVb+LpL5FnM=
X-Received: by 2002:a2e:87cb:0:b0:2b6:df25:1ab0 with SMTP id
 v11-20020a2e87cb000000b002b6df251ab0mr693972ljj.34.1690833298107; Mon, 31 Jul
 2023 12:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230714182918.30917-1-cgzones@googlemail.com>
In-Reply-To: <20230714182918.30917-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 31 Jul 2023 15:54:46 -0400
Message-ID: <CAP+JOzSt6w0Upwd=8tywUR3xwcuzKZ6JQwrkzKbEYmGg15-8rA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: use explicit type for function parameters
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 14, 2023 at 2:46=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use a pointer to the explicit type struct policy_file instead of void
> for increased type safety and readability.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/include/sepol/policydb/avtab.h | 2 +-
>  libsepol/src/avtab.c                    | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/s=
epol/policydb/avtab.h
> index 7d892879..2bb583f5 100644
> --- a/libsepol/include/sepol/policydb/avtab.h
> +++ b/libsepol/include/sepol/policydb/avtab.h
> @@ -158,7 +158,7 @@ extern int avtab_insert_filename_trans(avtab_t *a, av=
tab_key_t *key,
>                                        uint32_t otype, const char *name,
>                                        uint8_t name_match,
>                                        uint32_t *present_otype);
> -extern int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a=
);
> +extern int avtab_filename_trans_read(struct policy_file *fp, uint32_t ve=
rs, avtab_t *a);
>
>  #ifdef __cplusplus
>  }
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 99fdaa87..7a35fc17 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -843,7 +843,7 @@ bad:
>         return rc;
>  }
>
> -static int filename_trans_read_one(avtab_t *a, void *fp)
> +static int filename_trans_read_one(avtab_t *a, struct policy_file *fp)
>  {
>         int rc;
>         uint32_t buf[4], len, otype;
> @@ -882,7 +882,7 @@ err:
>         return SEPOL_ERR;
>  }
>
> -static int filename_trans_comp_read_one(avtab_t *a, void *fp)
> +static int filename_trans_comp_read_one(avtab_t *a, struct policy_file *=
fp)
>  {
>         int rc;
>         uint32_t buf[3], len, ndatum, i, bit, otype;
> @@ -941,7 +941,7 @@ err:
>         return rc;
>  }
>
> -int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a)
> +int avtab_filename_trans_read(struct policy_file *fp, uint32_t vers, avt=
ab_t *a)
>  {
>         uint32_t buf[1], nel, i;
>         int rc;
> --
> 2.40.1
>
