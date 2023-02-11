Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921D1C61DA4
	for <selinux@archiver.kernel.org>; Sat, 11 Feb 2023 06:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjBKGT6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Feb 2023 01:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKGT5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Feb 2023 01:19:57 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F1C7072E
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 22:19:56 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id ay1so4891699pfb.7
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 22:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sdw0UUk4mehDwk6gmZqo+381epwJ21NHdf8FQk7c4+Q=;
        b=awpK0sSXC2WmckioianJ7rx5PrGFfSqCpbWclTnJ4PbRa3Piyx1x5u9UDEvcSY+te3
         SWIDfoYPQfaKYNVRu/RINnGxxT4je/7B1hNoXkTgIQ18Q/oEfuX+0rkxWrDi6JR5uWdM
         DgM4N2CjWa9UxinO9X5Awy9NKEHGyAuK1k2ZDN/Wm1Usa146Mu+iNmJp+VgimQXVkrwr
         0upHDFm0SY/ydUvKgv+VrEHlekkYccosHp1CAH4JNAsMLMf6L2tyoR3ell34d71IfbIH
         vud526+FrPE+hjnVL8hU+rv5RZAdY2xO0yJK0V7nqJMCzMCFfQ65+Z+D7DbFANjPvv6m
         tTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdw0UUk4mehDwk6gmZqo+381epwJ21NHdf8FQk7c4+Q=;
        b=gac4RqCWQbzgjIx0DdC4T8Syxp6eaR4Ad52bdusWzKSX4V4bYzsKMJ7/wUUANlwtUp
         432zLkh/T3Uj0CziRP0FfBf1J0VfFgEzxQYt5GwGMC6hHnmvu6jdbjTymyYBIyFP6WIY
         ECLh63Vd1wgPQacPMOexJpTgHxj/8fwj2xIwU5Mx7BHUgfDwUI9jMIjnw6NhSLY84t68
         yUGadpWLWnw7DSL56mbpqtwcZP/1fJaRBLyrgDMZBBs0wdmSI1kvRxmTWUe34ilaiSHt
         O26reqM83BXUF4XRn3c+8NtVdcEfIe6KwtoYP1J5kdCNgzd80/kPXWzu7f4FGf0/mmB5
         XmxA==
X-Gm-Message-State: AO0yUKUCPwO6XEXTIr4CZn45sx4tzagF7aycgjXutfCw5F9O44W8Bo/r
        JrvwMafFyGYWKOpp+NqXaW5s0ec/nvFxJdOK6ZE=
X-Google-Smtp-Source: AK7set9KLulP5MkJnrMZ6UQfJUMZ5bI7GZYgDfecRVisSLPwoD77vltk8lWISYl+vHnKkFvOuq+Rlw==
X-Received: by 2002:aa7:9aca:0:b0:592:61e2:f598 with SMTP id x10-20020aa79aca000000b0059261e2f598mr17251796pfp.26.1676096395334;
        Fri, 10 Feb 2023 22:19:55 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id s22-20020a62e716000000b005a817973a81sm4155068pfh.43.2023.02.10.22.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 22:19:54 -0800 (PST)
Date:   Fri, 10 Feb 2023 22:19:53 -0800
From:   Jason Zaman <jason@perfinion.com>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 1/3] libselinux: drop obsolete optimization flag
Message-ID: <Y+cziVNJYpGQp0JL@anduin.perfinion.com>
References: <20230201105510.14125-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201105510.14125-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 01, 2023 at 11:55:08AM +0100, Christian Göttsche wrote:
> The optimization flag -funit-at-a-time is enabled by default in GCC[1]
> and not supported by Clang:
> 
>     clang: error: optimization flag '-funit-at-a-time' is not supported [-Werror,-Wignored-optimization-argument]
> 
> [1]: https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
This whole series:
Acked-by: Jason Zaman <jason@perfinion.com>
And merged, thanks!
> ---
>  libselinux/src/Makefile   | 2 +-
>  libselinux/utils/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 70ba063a..36d57122 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -86,7 +86,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
>            -Wno-missing-field-initializers -Wno-sign-compare \
>            -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) \
>            -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
> -          -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
> +          -fasynchronous-unwind-tables -fdiagnostics-show-option \
>            -Werror -Wno-aggregate-return -Wno-redundant-decls \
>            $(EXTRA_CFLAGS)
>  
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 801066cb..f3cedc11 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -32,7 +32,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
>            -Wno-missing-field-initializers -Wno-sign-compare \
>            -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
>            -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
> -          -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
> +          -fasynchronous-unwind-tables -fdiagnostics-show-option \
>            -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-overflow=5 \
>            $(EXTRA_CFLAGS)
>  
> -- 
> 2.39.1
> 
