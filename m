Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48C9C54EE9
	for <selinux@archiver.kernel.org>; Tue, 20 Sep 2022 18:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiITSK2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Sep 2022 14:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiITSKM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Sep 2022 14:10:12 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EF769F50
        for <selinux@vger.kernel.org>; Tue, 20 Sep 2022 11:10:04 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id m81so4800741oia.1
        for <selinux@vger.kernel.org>; Tue, 20 Sep 2022 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jN7cGOh4LCw1mape8CHhzbZSj8x2pw/6VAFaqjgk00E=;
        b=rrPbo3AN2E6uQzITxEuNRM9JfTnUG70AX+2Weu7XRh4XdnjC3vW/fMv0b11R/qtVsd
         WvVBaI7WjxFHYnm+qoqlRH27biyZa1LyDHxWRDaeFsbGqIo+kXe8h6nG04+slOhqIIzp
         4kx9XovnjmgBU136fkX8OZJpzMkEr7N6KpysUhmTcydxvJY2k2ZYh12SSf8qtuJ2en8X
         GX+VgRtOr6ryojXUO/cm9IEMN5WhuSZuF4EF1OKmfIFjzEUXhbchF3jwyKQ1F0SQqOt6
         m+P6fBKabRdZ+sqhERLfddnztyTimnT1//uJvfTx66lrK6PaPO34EzZZYgFUOE3ZdMpN
         UQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jN7cGOh4LCw1mape8CHhzbZSj8x2pw/6VAFaqjgk00E=;
        b=QqXSscqs41Kg2vFj62tT3G8eo9H0uY9syD9ZoSL1REY/wnVlFqfcNSOrtzvtnEIf3y
         rC+0N9teMfNMCPIfqefTVo8Grc6fh+hiUR4bQTnrXE3oWRgtmskYhYrbk4cehSLYvKo4
         UcBvxcXhd3zWGMMZoj3uBUfw/Kzn1pDR6fak1kQyu3gr6q/DAAzNBDst/aAbMzLO9mhL
         YYJh7oO2WyYjL1YBGFpjPtFoSvM4iVeJJkZZZPFbsCjfSB9J2o2bmbp44C42ZAAEVgcR
         UiPwMIxAGu5wEzprpr0FK9j1lAQ+QgsPkMn9rlsjQApbWv9PqKuAcelMwnamJwpzhvrz
         upRw==
X-Gm-Message-State: ACrzQf3diPQbsHatQgcLdMLdC026aD8/S0nrVCytCPQ+vdV7YiidOddF
        lq0mdmjvKn9tGXYDujj0N6LHTtWE4YkmAOS9U+GaDj8VyQ==
X-Google-Smtp-Source: AMsMyM4xipMgOrZoZvSuLUYTULSDHIArRuJEHSZk94f5l3Ts7I4O8M+VIz7WdMgNEp3ojh2JXj2h6EPRSLoQq4yFbdo=
X-Received: by 2002:aca:1c13:0:b0:350:ce21:a022 with SMTP id
 c19-20020aca1c13000000b00350ce21a022mr2233278oic.172.1663697403806; Tue, 20
 Sep 2022 11:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220920171252.3135882-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220920171252.3135882-1-gregkh@linuxfoundation.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 20 Sep 2022 14:09:52 -0400
Message-ID: <CAHC9VhRxyWdor-Z9AGKWH6e2_0fx5oSWPH-tuS5QeP7=Pk1MKg@mail.gmail.com>
Subject: Re: [PATCH] scripts/selinux: use "grep -E" instead of "egrep"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 20, 2022 at 1:13 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The latest version of grep claims that egrep is now obsolete so the build
> now contains warnings that look like:
>         egrep: warning: egrep is obsolescent; using grep -E
> fix this up by moving the vdso Makefile to use "grep -E" instead.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: selinux@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  scripts/selinux/install_policy.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, merged into selinux/next.

-- 
paul-moore.com
