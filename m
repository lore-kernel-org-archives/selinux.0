Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03685C4332F
	for <selinux@archiver.kernel.org>; Thu, 13 Oct 2022 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJMPyO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiJMPyN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Oct 2022 11:54:13 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38E437F8F
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 08:54:12 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-357208765adso21323257b3.12
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyo8O9FEhIdn/u/8CuqYRYf70y/mPW3w9VZLa8UfvfU=;
        b=PKmkt5NrNtOgXzD+4HeTCi5ddHBkCdT7X20AraAu4ODQu1MXQk863zhIAf7FeIDi6I
         KVLTJI2pjp6syxUFqkF/FJiW/BMPSOm7AEWyERFWPWo8PKxsCpoQxiN8U+AXcgqgXmtT
         nBC/FQ76h3CmVzI7D7/2lJBYEvjXLPawmAch3KG4/b5Yc+dratZjHMAOR0x6AsQNeg8V
         xMHCkde9RniK53OQhLZhd/v/z9OaTg9y+huViCbbmXO+0Rl0Lay9Ch5pkg4Lcu691fIE
         3HelEQwq4eIQFvYLY6Lr78jB/8AePuRtdzo5tUiWI93EOWWUbsf5qrn8ZyWJQ49brYKf
         Axsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fyo8O9FEhIdn/u/8CuqYRYf70y/mPW3w9VZLa8UfvfU=;
        b=2nnNOXYDEdTXMPQBck5g2x7YuNPb5JIGS3SciSYKwH+cDOUxxphVgYy4vueSer7uMv
         N5WIk3DMNhOnnxGew5MC4Gfd4Mxo2CitEwcpj4ZN5uQawcK3R3Kj4y+eGJQY6bE3b3Uh
         ZJzAH6lmf5aBEdchhvDLPHHg4J7yjo3+C3C420AnBYioPQ7fYT4ssKw0rUuf7O74Nhkx
         jaa8cTB0jm0q/U/4D5TzG+AkSwcDD9UW2rhnShJVkBUhguI5ZffwAMTR9bnj/xPnG+J+
         du6HthoeBwkik9ZcH1CffuySMbh9QfwLDwr/DRmdDYuHlk7mopcN/spfdR/ktGZ/aK5M
         nRSw==
X-Gm-Message-State: ACrzQf2OkRkvYhe66qO11UT9sdQdbjHmJ7duWxxRF5sv23jVyxxNviNP
        mEfSLKSz5ygJ8K3/vOV5OOsGSIsI4PH09PjJvl/8
X-Google-Smtp-Source: AMsMyM5vc1ZjeZGB1VMuEMxTU0986jPg4LXENa9/KXSO6sMaOXl2oD0JpE28Xo248FWrW3uv8WHpwgMcy3iE0uuPy4U=
X-Received: by 2002:a0d:e64f:0:b0:357:815d:614 with SMTP id
 p76-20020a0de64f000000b00357815d0614mr624412ywe.276.1665676452042; Thu, 13
 Oct 2022 08:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221013153051.2598199-1-jwcart2@gmail.com>
In-Reply-To: <20221013153051.2598199-1-jwcart2@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Oct 2022 11:54:00 -0400
Message-ID: <CAHC9VhTyMtYV91XsUtfxudgzJdDzr8x=dfrkK_+Y2=YPowRbaw@mail.gmail.com>
Subject: Re: [PATCH] docs: Add GPG fingerprints
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org, perfinion@gentoo.org, omosnace@redhat.com,
        nicolas.iooss@m4x.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 13, 2022 at 11:31 AM James Carter <jwcart2@gmail.com> wrote:
>
> For Nicolas Iooss, James Carter, Jason Zaman, and Ondrej Mosnacek
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  SECURITY.md | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/SECURITY.md b/SECURITY.md
> index c817eac9..87e7030e 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -26,15 +26,19 @@ the issue as quickly as possible and shorten the disclosure window.
>
>  * Petr Lautrbach, plautrba@redhat.com
>  * Nicolas Iooss, nicolas.iooss@m4x.org
> +  *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494 C5EB

This matches what I verified.

>  * Jeffrey Vander Stoep, jeffv@google.com
>  * Joshua Brindle, brindle@gmail.com
>  * James Carter, jwcart2@gmail.com
> +  *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA 62AE

Matches.

>  * Paul Moore, paul@paul-moore.com
>    *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8A
>  * Jason Zaman, perfinion@gentoo.org
> +  *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF

Matches.

>  * Steve Lawrence, slawrence@tresys.com
>  * William Roberts, bill.c.roberts@gmail.com
>  * Ondrej Mosnacek, omosnace@redhat.com
> +  *  (GPG fingerprint) BDAC 5EDA 6318 7BEE 99D0  4ECA CE45 D31D D1EB 364E

To the best of my knowledge none of the other SELinux maintainers have
yet to verify Ondrej's key, until that has been done I don't think we
should include Ondrej's key in this list.

-- 
paul-moore.com
