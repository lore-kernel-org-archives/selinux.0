Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CE3C56202
	for <selinux@archiver.kernel.org>; Mon, 23 Nov 2020 23:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8499120773
	for <selinux@archiver.kernel.org>; Mon, 23 Nov 2020 23:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="X2WSSnXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgKWXcF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgKWXcF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Nov 2020 18:32:05 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8836C061A4D
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2020 15:32:04 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id k1so5980802eds.13
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2020 15:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvV+CzrApfNhYjd5pOCIdBGV95GxbIoem5LSJfCYLwU=;
        b=X2WSSnXHH2rQD3YeJE8984RyiwASpwGBccF7jIbS/IhQvr7hOBKrtBnLPEzzjGKrUs
         IElScjlTrTfM5OHSLBDD3DfwQlA9x/jqSt4wT8IVnscs4TLABxxvUaBRalU12Ry50ILV
         qmKDi2iD8Sd5j6wUssME+p5UkhIs9k14iXEwMe2Ta7OEXI8mYuZ51VYfyyjMFOkPtEXc
         DQNBIpy5uesOIB+lWwrHubYWY9xdL6iH7YpY9Jr5pKhatOxxUFU9BT9x1SEvhSlkhAsv
         PksmQLp5FJeqhdrDjTWAE5aNHkrMgmRuUaH/oLOCPG/vZpiLsVIfmB9aemvifu6MclzO
         zjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvV+CzrApfNhYjd5pOCIdBGV95GxbIoem5LSJfCYLwU=;
        b=RKp//oRZGMUXEDSzdAzuhELfch63H3hjIzI7fAsHgx/X8PzALfAUe+rVgFGO33Aw6b
         dDdtjqGhJb/zhzkJMoii1BNPYl1j73vMGg2BvO3DzcY5C80kFbTHz1oITM1CzQmZ3uS+
         7hiC3aB7kVOgpofWrczBaBAQgnFlkKXWHBQ+D+KCVugGfC0tL2vPZPRzOY1qsS6X+fAO
         YK+ZPFIWv79CN80kvRQ6FxaTpOklluWwol4Lp5DWlx/qvAB0/3+2cFgCVPuP7x7OnceT
         H3wEt591P6j0OuZphJiJzljUFUFToSpsD+IUDboizkLLNcrSuS54rlOqFeqDJD+vU9T/
         CJUg==
X-Gm-Message-State: AOAM5320q0L1Is7hWcq+ZT8fnY/nS0nA86kvIjQangnXpDFNF8rdCSoW
        I9yYo+OiOMoCX9FidsoXxupz6VQDsDH9K/EV73Km
X-Google-Smtp-Source: ABdhPJwfgXk9K5k7Vqp2Mp/5WkRmckJ6VKgTtlEBpMUrzD0UCrCO7N45actD0P+MGIs0O7jidiVIWzNBe8F/lobK9pE=
X-Received: by 2002:aa7:de01:: with SMTP id h1mr1462746edv.269.1606174323325;
 Mon, 23 Nov 2020 15:32:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <c543804fee333ba315ddf4056ceed79f94e10d19.1605896059.git.gustavoars@kernel.org>
In-Reply-To: <c543804fee333ba315ddf4056ceed79f94e10d19.1605896059.git.gustavoars@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Nov 2020 18:31:52 -0500
Message-ID: <CAHC9VhTFUmRrabTytCyXPtFwb-uVLTgWmgxSkhpy5zjFkcacrQ@mail.gmail.com>
Subject: Re: [PATCH 053/141] selinux: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 20, 2020 at 1:32 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  security/selinux/hooks.c | 1 +
>  1 file changed, 1 insertion(+)

Merged into selinux/next, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6b1826fc3658..e57774367b3a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4029,6 +4029,7 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
>         switch (id) {
>         case LOADING_MODULE:
>                 rc = selinux_kernel_module_from_file(NULL);
> +               break;
>         default:
>                 break;
>         }
> --
> 2.27.0

-- 
paul moore
www.paul-moore.com
