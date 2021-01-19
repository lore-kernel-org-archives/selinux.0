Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC1FC433E0
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 16:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAF122241
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 16:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391650AbhASQLa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jan 2021 11:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391803AbhASQLH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jan 2021 11:11:07 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D1AC061573
        for <selinux@vger.kernel.org>; Tue, 19 Jan 2021 08:10:26 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hs11so26936996ejc.1
        for <selinux@vger.kernel.org>; Tue, 19 Jan 2021 08:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EinvgJXE09o65NhwcI7G4vlDbMl6WQM+iyR0W0N0V8=;
        b=Zx4EYbkmV1Cy3EvkCkqBR2kLbfZow7tpVjGCKd/W4Tb3v9745eDpI7+xiizkOt3FQB
         XWXW3tWjaA1g6LFrDy5S9O+tETK7ycte6e/zdj9kLM0RY0B3Vui4xrlCaqxpP4JF754a
         qYsGEzH9Y0H71DPcw9iwPChT1f3GmrDc+5H9NDr926eu1nhsGsUdPO4BOtmLGTfvWE89
         mZNoNbuylRkZB6mjUf4c76/xCBTHfjWwdCK36TyvVB0j4F3sP0fSeyDrvCpG0o+gPjar
         W1OsZNBxWQqwUcgbSuS9vzL/X+80eXZ2+NCjCG/OjKa9BVw8NMKL9nqNQnhjtmxaYI2s
         vYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EinvgJXE09o65NhwcI7G4vlDbMl6WQM+iyR0W0N0V8=;
        b=UIx9ifNYyrGqmKT9/a4Xw9/H/Z3jjLKxeaMgUDYPHyqxz090usIVBxDQ3GQuh0H1+u
         XmDtaEvA65z7v/r+Z22/LrVRraDouP1TbHib3IPaFlug+Rza5bwjNSuu3+1MLwWXhz7U
         L8J9a5QOP8XyYkhXxr+JIRLH04IveJy8zJeZRW+npq7UGC/VEEqwX6CvhRAePvesp5Dz
         SvpXh8dhY6XpjEOEO7ykJOEePVemIwLLdg1uVr9ziAFbagLPnsRUaY8/DbRJGZA6wySv
         ih5o/Qd0Y0vrpzyVEWhraNX30kzQt3tFt0xy6GsiLsvJWecVbRCrBuL/pWXf9DBcDQh6
         JTfw==
X-Gm-Message-State: AOAM530GiiRcyYl5ou+VzCv30HgQvaDc2PqjgDdl/Yw5jyxkXWzpbUbG
        8bXuQ6XCH/UI6Laul3/hdpvaLCqM8EREEip+fT27
X-Google-Smtp-Source: ABdhPJxf8Eri0kCBxIeIqFX5mDSOEkO3BB2gNmeH9+TIwM6ns35WlRaUkP2X/S9lNDtj0CDl6AXUtJy2JRJJoU5YkE0=
X-Received: by 2002:a17:906:d159:: with SMTP id br25mr3432534ejb.398.1611072625413;
 Tue, 19 Jan 2021 08:10:25 -0800 (PST)
MIME-Version: 1.0
References: <20210119090651.321390-1-omosnace@redhat.com>
In-Reply-To: <20210119090651.321390-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jan 2021 11:10:14 -0500
Message-ID: <CAHC9VhQtOGREKfh2hSJGnzDzEzNdusWJTb31TkyMnM+5MM2dqg@mail.gmail.com>
Subject: Re: [PATCH testsuite] Makefile: unload policy when testsuite fails
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 19, 2021 at 8:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Make sure that the test policy is properly unloaded when `make test`
> fails, to prevent it from accidentally lingering on the system after a
> failed test.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 9081406..8efe15c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -5,7 +5,11 @@ all:
>
>  test:
>         make -C policy load
> -       make -C tests test
> +       make -C tests test || { \
> +               res=$$?; \
> +               make -C policy unload; \
> +               exit $$res; \
> +       }
>         make -C policy unload

Why not just do '-make -C tests test' instead?

-- 
paul moore
www.paul-moore.com
