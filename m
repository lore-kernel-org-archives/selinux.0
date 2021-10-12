Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A3BC433F5
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AC461074
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 15:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbhJLPEE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhJLPED (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Oct 2021 11:04:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9AC061570
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 08:02:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d3so787365edp.3
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/p2JpLVwY1rUQlmn5MvkOkvipDx0E07Cvy9Ru60bUFA=;
        b=HbldBI/EiAff+3kOBfQsxVhyxcY3J9L70k2SL6+0BxLzt8lYapKoj8UO68ZiwUHoJi
         vtJIH6od72nwJHz3YUvWtOqFISom/jO6lf4BK4YEa+b4pFAlbTW8va5gbTJ/FpkXndz7
         3l+HHOFf/X7rxKOJGwYBg9vgd8KeGj6WNXRqstK/vLvOsZFdlq4NpytgJMGavYgAkS8g
         vtTQFoDNSPsouOoMVHeFW3/+2yMaS1u03NIMJr52184ApXE6v7hj3oRphfxWT/vFXgDk
         pZOwqHJICbOCPNJ2IIX1gicSBh34lKakI12lbeVZAT1NjJrvqFBdobg7kTV2UnpH4tyJ
         h49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/p2JpLVwY1rUQlmn5MvkOkvipDx0E07Cvy9Ru60bUFA=;
        b=1ePD+ZxDregxEBnn9N3CqqF63H6W40D0c8jCqfn5evoOai7YskDTWWvJ4Pv6qLQeYH
         zEgsIZK7KwTsiokEI/ac6CFtZPhu1Ru8Lszi7N69/F5/i78qU8zmGDOXEGbfLOZPbOBF
         b0/p+5qU/FmF6wQml1cynrHypXmLUC3lSi560lWKTgdXa+m0QfvpjoZgUsYg6iUwoOEz
         qjGPBydmgNbcm108wvv+Cx+15sgBzQQ1skyHMbveidUYAu4FzLnB8wzO03jXuVDHtf79
         QdWqF7tNDnYHtMMpKSVAzb9cgRqK+cG/VcJrZwSbw39MioXpaR9rZnC/AcXKkpQEklEe
         /4Fw==
X-Gm-Message-State: AOAM5339kYQRcNaNa6Y1LIi5mLHU03sNtwLG7JOUYWzbPAaSZ458T8E1
        9S6agOCO9S8CW/3Z/uS5U8E3YxvvmeNh+bc5MDtVPH27jw==
X-Google-Smtp-Source: ABdhPJw5oUKTL7XXgMWLXXOS2RflsrrfpDY50aDW97G423OXFi9zYIt9Cjzu3/ZWp5chJi64BhebZW12tWmBOwzTzkM=
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr471857edd.256.1634050918818;
 Tue, 12 Oct 2021 08:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <163399358463.185926.1386262780774440656.stgit@olly>
In-Reply-To: <163399358463.185926.1386262780774440656.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Oct 2021 11:01:48 -0400
Message-ID: <CAHC9VhQA+RMAGmzBpr6UEAi6EAp5bZ7jWKFSCWpJWZvJuW8Q5g@mail.gmail.com>
Subject: Re: [PATCH] selinux: make better use of the nf_hook_state passed to
 the NF hooks
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 7:06 PM Paul Moore <paul@paul-moore.com> wrote:
>
> This patch builds on a previous SELinux/netfilter patch by Florian
> Westphal and makes better use of the nf_hook_state variable passed
> into the SELinux/netfilter hooks as well as a number of other small
> cleanups in the related code.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c |   53 +++++++++++++++++++++-------------------------
>  1 file changed, 24 insertions(+), 29 deletions(-)

FYI, I just merged this into selinux/next.

-- 
paul moore
www.paul-moore.com
