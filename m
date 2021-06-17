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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72140C48BE5
	for <selinux@archiver.kernel.org>; Thu, 17 Jun 2021 17:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 575A6613CA
	for <selinux@archiver.kernel.org>; Thu, 17 Jun 2021 17:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFQRpF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhFQRpF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Jun 2021 13:45:05 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D919C061574
        for <selinux@vger.kernel.org>; Thu, 17 Jun 2021 10:42:57 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so337136ote.11
        for <selinux@vger.kernel.org>; Thu, 17 Jun 2021 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YS9KkuT6foqmnRYE0iab1ZCGSSMnLcaZgmUyEPfUzLA=;
        b=JpkGx2ZRGp8cTxNBQOGcRJ8FRCxaN3VY2BZqadbnOWhbC8PsZIXEDrunfICi7rTZbF
         xAQCCyU/Yz/1RpKRDVWwE5tUSxiW85WyA1o9Gw/IMwzphWy84Et6fpTnpLhxYt115m/g
         XSUIdfbQSGfFPY/rO2jyELUfLZGZk0aoKFiv7Q2iwX40mZ1DbcJ3BDZ03JtcCuKme3O8
         yZsjy+M5JXpOPKG0m9ckY99I2fDVuT1RFvLgl3x9lVLA4LC5oYxduY0BFN4zCD2Ou10S
         Q3hPxCTo5OOG1wsj92M7clHNfdkUd8slwLbsbjeKhlc2/NxQnAJYK5h1SsI/OutJVpAD
         UTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YS9KkuT6foqmnRYE0iab1ZCGSSMnLcaZgmUyEPfUzLA=;
        b=B75Ao1M+sYOYe3y5ArxrPxbCzkr8CcJYY0Fu4p2JnsWxFuWWLscd8viocg7G+96STg
         tNNwIWBMu1nIY+bzH587obv/4CS7IHAFYw3CB/0WkuC0S6b2vi0c40t8Sqal/kQZHrlQ
         RzyvF8PXvDfCzxu5Py6plqYulcBJnJSaZ101/piG0P9pvvOdihOi/CBovxLKq0/+l5GX
         S+z2O2NB74no4+e+gO7ZUTpWXPqJ07WIh13FW6kAzvOwNJ39uE8czfbr0eKbEkgcrEL6
         1MMBsm7rtpAf+tf4rSX6EuPkbSF5OQcVKe+R9nuO2eQMzXSFQEL+fmIWh58jCFFVlZFQ
         l6fg==
X-Gm-Message-State: AOAM531qgTNU4qpLbhSCjz9aqFxUhR2MFHsoNedB+Pi4tQ6swjhRCCtn
        GG100weNavPnxQygjIO0EB9aV0c255S1u1xO+SI=
X-Google-Smtp-Source: ABdhPJyxFtZOP/B8rxHq567IDSD7F8TwyOu01AtuL25Ajqb6qlc+hwcB2orgVrGI7VzqAnT2J2EIhDEl3d1v7yp8CUA=
X-Received: by 2002:a05:6830:2011:: with SMTP id e17mr5583588otp.295.1623951776796;
 Thu, 17 Jun 2021 10:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_90BF03402499B510C39EB8BC137D04294607@qq.com>
In-Reply-To: <tencent_90BF03402499B510C39EB8BC137D04294607@qq.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 17 Jun 2021 13:42:45 -0400
Message-ID: <CAP+JOzRjAoU2oRueyT6sPv9-xjVtjzhyxzXLuR6Pubd+-=R7jA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fix use-after-free in parse_module_store()
To:     HuaxinLu <luhuaxin1@foxmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 14, 2021 at 12:52 AM HuaxinLu <luhuaxin1@foxmail.com> wrote:
>
> The passing parameter "arg" of parse_module_store will be freed after
> calling. A copy of parameter should be used instead of itself.
>
> Signed-off-by: HuaxinLu <luhuaxin1@foxmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/conf-parse.y | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index 9bf9364a..eac91344 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -516,12 +516,12 @@ static int parse_module_store(char *arg)
>                 char *s;
>                 current_conf->store_type = SEMANAGE_CON_POLSERV_REMOTE;
>                 if ((s = strchr(arg, ':')) == NULL) {
> -                       current_conf->store_path = arg;
> +                       current_conf->store_path = strdup(arg);
>                         current_conf->server_port = 4242;
>                 } else {
>                         char *endptr;
>                         *s = '\0';
> -                       current_conf->store_path = arg;
> +                       current_conf->store_path = strdup(arg);
>                         current_conf->server_port = strtol(s + 1, &endptr, 10);
>                         if (*(s + 1) == '\0' || *endptr != '\0') {
>                                 return -2;
> --
> 2.26.0
>
