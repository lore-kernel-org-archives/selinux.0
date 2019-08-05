Return-Path: <SRS0=PMFh=WB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FBFC433FF
	for <selinux@archiver.kernel.org>; Mon,  5 Aug 2019 20:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EBF2086D
	for <selinux@archiver.kernel.org>; Mon,  5 Aug 2019 20:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="NRQseSET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfHEUsn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:48:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40746 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEUsn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Aug 2019 16:48:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id b17so59117747lff.7
        for <selinux@vger.kernel.org>; Mon, 05 Aug 2019 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PgI2J3EbuHvfuKT/ReqlMO/XmXN7WANMO1SDmSCfnnM=;
        b=NRQseSETEgMLSeOYPjZVlpVfaNgVBAjmWJeClEEeB7p1/2T7zS95bc1pDjl7AyyP4B
         kUcvwYJZu0XHY2bW2COhSiC+2uhPhUWDtKhLjpu5YXsvtvbC4mMEFP9kKc4wBl56Yn/e
         Yd1qRUtAANz1m1KWyC92HcPLQyNamN0TGHr4hqTfelS2MxYHy8nRbLv/bcDeQEA859e0
         QyuMLAmI0hjExo7X7AF/FLhE/jNF36TIoYmUAd8ky/ZceENSXrK0n2uqC7lwLNykfPpw
         /nWvXQiYjeDe9r7prrH1tVrCE7lN8WTSmt2lIgbGzSrGSsfDyy9iH5SZks6LQeVZUpWm
         uqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgI2J3EbuHvfuKT/ReqlMO/XmXN7WANMO1SDmSCfnnM=;
        b=QBuEgdE/GqUS6lD59/BKGzmnqO9sPEFxZQ8SebiEqGJ4Vwdkhpiq2ZmENEMwPucugr
         ToH09h8q+ROO/KObEd5NiyCL1XC3Hdw+gSMRTwfSP06ml/08bBfhVQzGd0C1Y7LUiLLH
         Y/gIUiMVwJUwpZEQNekYiY9YVEjxyXINgpdJ3Sa0eTDs65VORC02bJeKar34UZVrfWD7
         bMg1fp0KrEVarfKl2DAqD7zRFgmmdcQswq8p0lQkA0hqC9rG4MsAvqDHWQk8Y7yPwraT
         1S4MHBCW4HVsEYWUmHrJ6CpPm0UiMmFn+N+/cBnTcjqStNuKKZcQ3Lixc/b3hGBHkYoy
         1L/w==
X-Gm-Message-State: APjAAAXjyNlJkrFAuaMdAaKc9SHMrouf5WcHOFlb3GLV1JP7AZENV2IM
        wX+biNWqrpeS8f07XuQwmh4nQJ4d/BNDggCpDA==
X-Google-Smtp-Source: APXvYqyolCPkrCgOr7/0PZEQwX6f8DVvuxp71jntXaXULUt7/yYmym8woTUyediXyLPjCjA2DKXRma3SrTfxIKf7x8Q=
X-Received: by 2002:a19:5e10:: with SMTP id s16mr70961462lfb.13.1565038120865;
 Mon, 05 Aug 2019 13:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190729084117.18677-1-omosnace@redhat.com> <20190729084117.18677-3-omosnace@redhat.com>
In-Reply-To: <20190729084117.18677-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 5 Aug 2019 16:48:30 -0400
Message-ID: <CAHC9VhTQO2OGvyR+Xp0wE=typ3Xhe8ODBXU3rMoFuMHJFXZX7w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selinux: policydb - fix some checkpatch.pl warnings
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 29, 2019 at 4:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Fix most of the code style warnings discovered when moving code around.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
