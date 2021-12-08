Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35067C433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 20:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhLHUPd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbhLHUPd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 15:15:33 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAECC0617A1
        for <selinux@vger.kernel.org>; Wed,  8 Dec 2021 12:12:00 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x15so12416322edv.1
        for <selinux@vger.kernel.org>; Wed, 08 Dec 2021 12:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVJm6GBdyKGFabOP03aXdLCHIwjOUoccR9nPe1YTK5Y=;
        b=cG53+m4y1j7GDnD5oKw7w/+Nh7ELSvzpkmGF2B/2PaFLPvYJDX1IxShK/6UqZbYaUr
         mjUrNfc84RJWMJ/RYW/KwTOapU1bERXmSvQ0ExmG/xyUyPsRoCTwFfepCJ3TLY+PV3bm
         TIXPtwABRw3r/lfxvt/4FTZZzROGKWF3VqhAf+y98BvWBxdVuTF6GlpIpdcycU91uMAv
         TipLjVsQqsDBAFeMXKB+5fuTgwtMgaMEAn6WO6Au5j5kCnJOwBE2v/j/GmnIRdVI3CZi
         dOienCKHL256MUh++bfu7o+dFyHfVb4SCuVU8H94G0FV184cj5QYyppBzr5p71YPqvw9
         8HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVJm6GBdyKGFabOP03aXdLCHIwjOUoccR9nPe1YTK5Y=;
        b=QOqM5X6n1pJwhWRFUjYcVIx1CDd0XVqh5Y2rh4dm/ZfSjDqVrt72Pw3rENGAEazohs
         nl4RggjxVX0kNvLsPglxOmXjrvCq9rAWt2c73lHBWN/o+/o/cgiDii14Mlk/uoBgScYw
         RRSZ03VBniU+3ufaC9sIDt4EGyFFfo9NgMT0QnF+vOHNC1U3z032Q3UUt/FVq9ZphwX2
         Zt5oVJA0Z+Qaek9vE1QSrlYLaR/S3j/Jkh1bQc03uonxNj8G//h3ipWNicshpFu2dLra
         uUYjyWBiRdS4cmmGXCLJtawqGFw3Lbjv8pUW4rIaEn2lfohQsRfzCZkOmSk0KI1iU1US
         6PrQ==
X-Gm-Message-State: AOAM532CUnnRm2quEHQBfuFEy0BUOaW/O0k3C0G7VWvNZoEgtyQrePM1
        TeNMcZIqF7ERxY+ftfWYDel6YgweRSPcG0MzRZw3FmqDlg==
X-Google-Smtp-Source: ABdhPJzrJR7ZRPh14GsL+XuZW8wbxvvo6GLDbgn4PpIm71y0gH6CzdUuSs3Cw67DOw7BlXEq42DHGrXGxEO/B6xubm4=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr9755349ejb.69.1638994319393;
 Wed, 08 Dec 2021 12:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20211208121654.7591-1-richard_c_haines@btinternet.com> <20211208121654.7591-5-richard_c_haines@btinternet.com>
In-Reply-To: <20211208121654.7591-5-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Dec 2021 15:11:48 -0500
Message-ID: <CAHC9VhSzcKySRQXOZ5jgsAzhKVLU_HBMnKQvKanzorVzbiZakA@mail.gmail.com>
Subject: Re: [PATCH V2 4/7] policy_config_files.md: Update openrc_contexts contents
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 8, 2021 at 7:17 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> This config file will only be present if openrc is installed.
> See https://github.com/OpenRC/openrc
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/policy_config_files.md | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

Merged, thanks.

-- 
paul moore
www.paul-moore.com
