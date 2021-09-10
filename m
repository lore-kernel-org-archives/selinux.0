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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86716C433F5
	for <selinux@archiver.kernel.org>; Fri, 10 Sep 2021 13:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554CC60462
	for <selinux@archiver.kernel.org>; Fri, 10 Sep 2021 13:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhIJN0w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Sep 2021 09:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhIJN0v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Sep 2021 09:26:51 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1D1C061574
        for <selinux@vger.kernel.org>; Fri, 10 Sep 2021 06:25:40 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso2200285ota.8
        for <selinux@vger.kernel.org>; Fri, 10 Sep 2021 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/SBSv1PG6wGTqDkRenQFLPU/l2vgiIOjxkwvIaWTeU=;
        b=KM5GNwZpLhOQyctPAiEl278C7n2ARk0xGdK89z+k3nedkb1K6+TspgfO0u8vWkcE5P
         m50iL3tZx1hR/XbV/odLAe6X771wS5c6ryoS6ZFixEsLa6RtUgZhEusYoIhJOTy9yYII
         EKsxQK9ackvWYOGnJBepC0x4CH+0XAcisISBAJpSBN1GcYqUw6O+4/rcPeZ8GsRV/ziX
         Ngh6efG/JjGi3DXDRxJWemGz/p0wkmAUTPaLQinZDd6SUrvF+6TJCGaK9KCfhWHlIbzE
         vNwTLawr4fgMLndvgdwm4P0yfWFfK1IwBu18P6V5CCNqi8tny1mnunuX7Y3dtroku1eM
         Mwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/SBSv1PG6wGTqDkRenQFLPU/l2vgiIOjxkwvIaWTeU=;
        b=quW3RQNR6fCjF9qZxaFBdxOAIsd9BgsTgGf03lIvyb2O9HOrQc1Rcv7tNFoMLI+sDV
         knNOUVxd9IDOFJDF96gNUQ8JoMKzoZ0+OfORPQYUugr1sNI6YQXRXRWMY1FGIuOaIIWv
         TjzG+BECCHmp9PUUEKeGv1WVfsgpIn1SeCSd+WPwz82LmsqY1L1/vkgIRM4Hanl7/MDK
         Vq7wD+/NHJ7ll9A5uLPahPaQ6NuTI9EZMrG1l6dSDkPWB0dRWXyeJnE7Pqpb9nbWKOF+
         PsLZwqt0BXk3126jh4qQTGChfDOP3dHu4Gd/GriggxK1XxebxAMnn0FHdxMUCWXEqObW
         PhFQ==
X-Gm-Message-State: AOAM532EQ0xEdBNpJZYlKHbMqdMg0BvQ6PwZ2w7ecpLAGxEqkBaznE3k
        UIf52GZev+NxB35MqGgWerpaTRQKVKFP1hI9y0hS/5gSFj0=
X-Google-Smtp-Source: ABdhPJwFhYWj7JsLZFNNgzscUVt7ucJ74eQI+WV3Ht7QHDax9d+YvV+xO4CZGre30AyPYFeYxpkdLrhADwvlzeTI1vc=
X-Received: by 2002:a9d:5f85:: with SMTP id g5mr4644632oti.139.1631280339837;
 Fri, 10 Sep 2021 06:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210910121252.71710-1-toiwoton@gmail.com>
In-Reply-To: <20210910121252.71710-1-toiwoton@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 10 Sep 2021 09:33:15 -0400
Message-ID: <CAP+JOzSd28YWZdzFcJ9m33bWk6n9LdnYfjW=9Baz540G4Zt76g@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix typo
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 10, 2021 at 8:13 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/module_to_cil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 9c7e3d3a..3c8ba10a 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -573,7 +573,7 @@ static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const
>                 rule = "auditallow";
>                 break;
>         case AVRULE_AUDITDENY:
> -               rule = "auditdenty";
> +               rule = "auditdeny";
>                 break;
>         case AVRULE_DONTAUDIT:
>                 rule = "dontaudit";
> --
> 2.30.2
>
