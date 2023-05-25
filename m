Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68DEC7EE33
	for <selinux@archiver.kernel.org>; Thu, 25 May 2023 19:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbjEYTBe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 May 2023 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244139AbjEYTBP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 May 2023 15:01:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B78730EF
        for <selinux@vger.kernel.org>; Thu, 25 May 2023 11:50:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af2c35fb85so9556411fa.3
        for <selinux@vger.kernel.org>; Thu, 25 May 2023 11:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685040502; x=1687632502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mwkVY71w/z2XXzxNAc/VeOoadT4I+LmmXc6Cz0Keng=;
        b=Q/7YQivmuojfI8jdj+UY6vWtfXjxjb0PngwIFyrfQlacSsYAdcK3f8PZf2pXEpSAqU
         su8/qBcf67ZU8uKAE/DR9GfhEgcaaQqJOL/MEt/uFWbAtfnTqxmPKtFeaXQwgFG2xFt7
         bcSFOL32H9fEMyaGzNb7IKsRlh+Uep8OEUCxNSsx9ihBifgKOwcDw0KJbiuLSVn7zoBu
         lB1e//DaByQKr82kgw2VF2i/1RfS33C24myxp4rF0uZpx2IBQ9pL5adlBiGdl3TEl2q2
         zqXVl657gACM3/u8757DFear6cb20yYO1aJIsP1gqnntDrZwnSvcTE8AcekFYmujg/ax
         vHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685040502; x=1687632502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mwkVY71w/z2XXzxNAc/VeOoadT4I+LmmXc6Cz0Keng=;
        b=MEYSgq7JZ9F1JAFDB2bBxACL6ffijjB/lGBBSk4QljCuIwx2WjJWj9NhcUFKN4Ekyo
         /7eKiuzbVx71twk/FaaU4K3oS5kji8HieMEEy2GXvJH+prD4m9+es7+9JQLpiPfqnLED
         m/TAK3uE/08UKO9Gh1k2Gv4kgeBSjEHx++gJXeKnX9zdA1pHCar7cYEjkVFgTRVSp1vW
         PYUWq46V9C5DibMWxh42UQ5oBwsVG0FxgHqKlTwpFkiw18vR7xpPcc+s95elHQskZ/X2
         qCjemLah/R5ETxrjXOiU/dbLy4HhDQDMd0ef7C6dh+QoTn2DRV+U+9YkIMpZSBwus/Uc
         Y2Qg==
X-Gm-Message-State: AC+VfDx9kU2v27sr/1J97/UZl9abgx+gBGEgtbax1470o2SxZ5BTWvot
        kFKAddgRpRBP1VgXXCa+y5FAFl3s5TGWnAE7jWxXHQ7nc8w=
X-Google-Smtp-Source: ACHHUZ7yAN/pK+sdMG7525uBXcBY0VI1EMux512fDtfjnqWUUhjgFMC5CdM9HlE+CqBLr1DP6BdFr+HKwJr/7JXEoPc=
X-Received: by 2002:a2e:8ecf:0:b0:2af:3147:86d8 with SMTP id
 e15-20020a2e8ecf000000b002af314786d8mr1596362ljl.15.1685040501464; Thu, 25
 May 2023 11:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230512092311.42583-1-cgzones@googlemail.com>
In-Reply-To: <20230512092311.42583-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 25 May 2023 14:48:10 -0400
Message-ID: <CAP+JOzSwY830VyjN6o4-NuFwuBpq_LWO4LCTY5utEhgiztFRPQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] checkpolicy: drop unused token CLONE
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 12, 2023 at 5:24=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The token CLONE is never used in the grammar; drop it.
>
> As side effect `clone` and `CLONE` become available as identifier names.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_parse.y | 1 -
>  checkpolicy/policy_scan.l  | 2 --
>  2 files changed, 3 deletions(-)
>
> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> index 45f973ff..da32a776 100644
> --- a/checkpolicy/policy_parse.y
> +++ b/checkpolicy/policy_parse.y
> @@ -85,7 +85,6 @@ typedef int (* require_func_t)(int pass);
>  %token PATH
>  %token QPATH
>  %token FILENAME
> -%token CLONE
>  %token COMMON
>  %token CLASS
>  %token CONSTRAIN
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 9fefea7b..2c025b61 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -77,8 +77,6 @@ hexval        [0-9A-Fa-f]
>                                       source_lineno++;
>                                   yyless(1);
>                                 }
> -CLONE |
> -clone                          { return(CLONE); }
>  COMMON |
>  common                         { return(COMMON); }
>  CLASS |
> --
> 2.40.1
>
