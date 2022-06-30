Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F660CCA481
	for <selinux@archiver.kernel.org>; Thu, 30 Jun 2022 18:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiF3SaU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbiF3SaU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jun 2022 14:30:20 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C400C427E9
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 11:30:19 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id i3so325336oif.13
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kruxgj0HNjVP0SlKaMB0fNhG5oKUXGvxAXbaD0XCWGA=;
        b=Uw6HIznhixGvoI3seoLxsSkK+8hgCNx4jOb3IXhmiYbHgfBuLN+8cmkuX3v379CZgx
         sycJySuw0ryJKRLhZB4eCFbnKW7QJbyWtZpRNYxE3X15t7sfjf5tkoDD/AGa/BQHKEze
         Tc2gttUBIYYN7zqcYj0BSacmE/3tKTLSA6K+WRm3irBY0iAqhw5fobHSjRHhk5l2RX61
         KfxUtsw6Vdrlew+nzhDI8y75D8jVbnewbqrdlHs6HzVK33pW3z1lTFmBviha9rClxFCV
         w2P+xX/M+IMLdpidkTuBMgiaZt0JYrwpAMSmNmXfn7v42X4luDNcdU4Yh+XpQ2T8QU0n
         yzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kruxgj0HNjVP0SlKaMB0fNhG5oKUXGvxAXbaD0XCWGA=;
        b=d24WHXMVbCPU7XHkohr/ffDc2i+KwGqFU8sspXqiISnUngzdZnI5qyH0UGaPfB8EnB
         NqX/T3mrF0lIQ/YEFnjk3yodixzpQDLnV+TDStgvcGou7huHNJY8JiK3eoJYEtXjKCjA
         gvrTRicCw1I7K4HvPotA8tiU8k9zHEURRJgpZy2BaIaMjY9pxgw2YRMsVpPcyF7wfaQq
         oA88Ys3Liu+1DRTYZ+L7UWvTyUSUNKC7FMtlmBl4l5D/OYTl8ke6WkkNkdUIC2gZdbje
         0vIKz4XtSDR3mfXIk83IeorDk0K9bcx7U5nQDBf2Q93V04LslMLQc08lw0LiNROzgkmq
         4NYQ==
X-Gm-Message-State: AJIora8L7ZIniYyR8W7BAkn6y4g80sbGoUTFPFt++ora5hnCpLtgDHeY
        go+hR5nxDAcU6sLRtR/jm5Nm0BXMBasIcjTpqCs=
X-Google-Smtp-Source: AGRyM1sD5KxUEw3Lfy6iMFA/WMhhm51HLzLJ35VHDneHZ8ay5OFlyDnobT2KYiQ4E+BfhEEw9gV+YxaJsYG12u0a93w=
X-Received: by 2002:a05:6808:198c:b0:335:9b27:95b with SMTP id
 bj12-20020a056808198c00b003359b27095bmr6160606oib.182.1656613819195; Thu, 30
 Jun 2022 11:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220629110512.5067-1-cgzones@googlemail.com>
In-Reply-To: <20220629110512.5067-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 30 Jun 2022 14:30:08 -0400
Message-ID: <CAP+JOzSiHaokD7P8aXa-qUB5vCvx6kOC2zs1on4e4a+f0YRvww@mail.gmail.com>
Subject: Re: [PATCH] libsepol/utils: improve wording
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 29, 2022 at 7:06 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> A request is denied with SEPOL_COMPUTEAV_RBAC if the source role is not
> allowed to transition to the target role, granted via a
>
>     allow source_role target_role;
>
> statement.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/utils/sepol_check_access.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/utils/sepol_check_access.c b/libsepol/utils/sepol_c=
heck_access.c
> index bd2ea896..5d2bf679 100644
> --- a/libsepol/utils/sepol_check_access.c
> +++ b/libsepol/utils/sepol_check_access.c
> @@ -109,7 +109,7 @@ int main(int argc, char *argv[])
>         if (reason & SEPOL_COMPUTEAV_RBAC) {
>                 if (i > 0)
>                         printf(", ");
> -               printf("transition-constraint");
> +               printf("role-transition");
>                 i++;
>         }
>         if (reason & SEPOL_COMPUTEAV_BOUNDS) {
> --
> 2.36.1
>
