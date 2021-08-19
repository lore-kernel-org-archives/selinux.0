Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A07C4338F
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 19:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE79260F5C
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 19:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhHSTXs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Aug 2021 15:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhHSTXr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Aug 2021 15:23:47 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE007C061756
        for <selinux@vger.kernel.org>; Thu, 19 Aug 2021 12:23:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bj40so9894054oib.6
        for <selinux@vger.kernel.org>; Thu, 19 Aug 2021 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBRkJC6x3tq0GDc5GCnLxORYT7fw8ueX1t/U90g0JHg=;
        b=J3q1LF1Nd5Iyg99gSXL/kazHucW0oUzdwfRj9PrxC1e/QMCgcWDzG6H81bQg7Y1/Eh
         TSg/OwrSCtGHyCdyn6q+Krd+q0olb03Z83cPe4KTTk5w3S62jFamv7UcKdGmJBx6GsRu
         2Epr6mC5GAW3PpkbUrbO28LiRi01BvzLvQMkY3hhmEJSeDvoq6TxsxlpVjZeLEQg/9e1
         d5D6yJzceEa3lez7agTZYA8b2hXOYHpdZ9apZRhEjMiFlz9EC48nKVnrQu2cNR5Y+if2
         bUmFfYWujqdLhGCRXQvkwfUczpkMMzrhmjO2wEXGdvNpXk5u/tIgoQ6cJE4G1Rrzs6EH
         dROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBRkJC6x3tq0GDc5GCnLxORYT7fw8ueX1t/U90g0JHg=;
        b=KHSzORjmJZsUWP9qyi8R4rmkhBPfnpqHGzU4OFZC15ji3wN/rIJSZc+6Zm0B+q5CRO
         AqFwdAHEO/vli451lkVIxrcfK0yIfDkK+boj2fiqp3d7+zSfyWoVC9Ls0EEKxzDj2YXZ
         wyJgUoGxjr19OVCfom/f5G9VaEbbBti6BjvjbqNoQe8rQHsa8hasfB35EGO7eBqj6OAi
         R71eXXjxGqRmOkk/7pAJLzNszhEbdDX140jm2BEcNgGUY0BrXrFLJ9f8oaFq4kjoVEKJ
         fzmv3yjPc7WfTbqXR82NS9Z5jDrb2N8lIe70XojWhbToqDfWGBjz3Lmkn/xCdWjAjGx0
         tkbg==
X-Gm-Message-State: AOAM533+IO7DtlQ7rdkWJ+nEL0Mk45rpJPHuGsg4h1HUb3XGOGNUCiRl
        xGMCIS2Jqwm/10XaqaRBG/qctgtrj0Ee4Wzb3Ds=
X-Google-Smtp-Source: ABdhPJzo44ym7qigTpUSTk6KIbjdxG7YcF5rb410/gyg0/027f8Dl2wktx9342QFWdI8zSxxKP40NZp/yaiOEJPGzg8=
X-Received: by 2002:aca:1b19:: with SMTP id b25mr243411oib.138.1629400990348;
 Thu, 19 Aug 2021 12:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210816165459.1741490-1-zhangkelvin@google.com>
In-Reply-To: <20210816165459.1741490-1-zhangkelvin@google.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 19 Aug 2021 15:22:59 -0400
Message-ID: <CAP+JOzQ0y=vSvgeRzAfUU4dY=5dGrCudBmV08tfGzu29+HDiyA@mail.gmail.com>
Subject: Re: [PATCH] Improve error message for label file validation
To:     Kelvin Zhang <zhangkelvin@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Kelvin Zhang <zhangxp1998@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 16, 2021 at 12:55 PM Kelvin Zhang <zhangkelvin@google.com> wrote:
>
> From: Kelvin Zhang <zhangxp1998@gmail.com>
>
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>

This is not what I normally work on, but it looks fine to me.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label_file.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 56f499fa..2e28d047 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -188,6 +188,9 @@ static int load_mmap(FILE *fp, size_t len, struct selabel_handle *rec,
>
>                 str_buf[entry_len] = '\0';
>                 if ((strcmp(str_buf, reg_version) != 0)) {
> +                       COMPAT_LOG(SELINUX_ERROR,
> +                               "Regex version mismatch, expected: %s actual: %s\n",
> +                               reg_version, str_buf);
>                         free(str_buf);
>                         return -1;
>                 }
> --
> 2.33.0.rc1.237.g0d66db33f3-goog
>
