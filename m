Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A3BC4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 21:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC1161245
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 21:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhFUVC5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUVC5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 17:02:57 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2B1C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 14:00:43 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso4826328ooc.13
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 14:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3Z7x4bbPt9qQSY6hw4fEn4aNo271tgmR6y0nMHqtTac=;
        b=ClmMoRqcZDh/ChziILgfgmVGM69ReNB983vfkXa67sXraIsDGgxAJ7VlMkSE9xyYd4
         uiun3PJtiExrYzCthH2/i8USMYg47w5FoLqmyVTcUZ7AEnsdatqtDBarXJstKGriKMS5
         v1oeqyzrfEtqpXrJi0a/lcyX9eaEtWLQ5YTBdw3QLieclypOz7paW5kZUifttG32J5wc
         cFJGTuCawuVQcrA5GWWUpIXZGJFxs9WpB1nNTdz35E/m9UjSRk5nEFio7mZhJ5Xc6/+I
         UHRgfd7R6Y2FOG55XHDrnjB8gRk6bN4Vn0Id80y3lkkDCnXhMdkZIA6IW2f6WO/E3bBb
         d1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Z7x4bbPt9qQSY6hw4fEn4aNo271tgmR6y0nMHqtTac=;
        b=kdmPtYFCYAuTF08GWsLSrGpZ8EnxjkK8QIi9SSZnBWBPJFDp6r7/SZk/iABD7oR9w2
         Uf4VfTeqPKZnbRdImWXYiN/wfu2meEbkjZNsxhn3pfDALPYjMONa6BIPe+z32zD1RamC
         Andm+JYMjfafZPQ8rTMqDVuf38TSpE5+GS2q00Eaki8GK9XU3KWVWekzTPtkIyThkmKD
         C+5YJHpujE/v3vg127ziI8Y5Zu0v+vXyFTbJO4K+/qewBi2tT/CAR++oSnOkJ65T+o4U
         7ur2HUAqYCwewHYFYy2UjNy+GRPrILQQ7IDTsM1PDt4bSJv+iPOJZyjEoRxwDpnpiUNk
         zXLQ==
X-Gm-Message-State: AOAM5315ocs2Za39i6J6zGwytLwM2pdqa2gCmJgKWASOWovnKBw7KbYO
        evOwRGYUEffdB8oqce3JYlEPChBq+qWx6/kP71k=
X-Google-Smtp-Source: ABdhPJzhQBMRovS2MSg3BGgRYN1MMC8Kq7xo+Zhm1PsmIZRNeiLFjlGbnqnidRSY4OJMHAODR/yrXIXcKTCy1fWZU8w=
X-Received: by 2002:a4a:3011:: with SMTP id q17mr60455oof.35.1624309242563;
 Mon, 21 Jun 2021 14:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-23-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-23-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 17:00:31 -0400
Message-ID: <CAP+JOzSHyvt2_=CsXp4TOJDZS=a+fFrncFnoJ5p+3qREwk5Scw@mail.gmail.com>
Subject: Re: [PATCH 22/23] libsepol: declare file local variable static
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:02 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Clang issues:
>
>     module_to_cil.c:65:7: warning: no previous extern declaration for non=
-static variable 'out_file' [-Wmissing-variable-declarations]
>     FILE *out_file;
>           ^
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/module_to_cil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 73ec7971..1d724b91 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -62,7 +62,7 @@
>  #  define UNUSED(x) UNUSED_ ## x
>  #endif
>
> -FILE *out_file;
> +static FILE *out_file;
>
>  #define STACK_SIZE 16
>  #define DEFAULT_LEVEL "systemlow"
> --
> 2.32.0
>
