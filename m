Return-Path: <SRS0=V9Cn=C3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B078C43464
	for <selinux@archiver.kernel.org>; Fri, 18 Sep 2020 14:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F3E21D42
	for <selinux@archiver.kernel.org>; Fri, 18 Sep 2020 14:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="U1IB12Z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIRO2f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Sep 2020 10:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIRO2e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Sep 2020 10:28:34 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E1CC0613CE
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2020 07:28:34 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n13so6231579edo.10
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2020 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4M5eEOeyArAHdfLutxde3WdPyTICE9xvbTvewJOXTIQ=;
        b=U1IB12Z9u2eoOWHr15ITbJtCwglIwBHS2CXaDNhkE82GrKuE5IZyv983ffkPIM+8uq
         tlZG39RMSvQsVhW+6dVGYCKRzDXYFYbGGUHK81YkIUeIGKrAlxaGddZ1McVSFUqtSnQw
         Rx8kk4dYtcR5lfR6Z+WdkeEGTLhnA4cU04Za8+BPMi0eIgUUlwIZ72DjYoyNKnjVjmGZ
         oNt0c8T4YrOhVT1VPavgYbrjm1Az5eJIUNj9PUumGlD6VLNpic00obQs0dpsiXJJIzGV
         scZGkrAxqgBnbMuziRVzjyBAJ85O+gPbz0+zH/VY7RcIPmiNj7bOo3L9eWH7sxuLimFw
         f+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4M5eEOeyArAHdfLutxde3WdPyTICE9xvbTvewJOXTIQ=;
        b=L6eX0mczUTtjwvt7hpOkHyi6F1GBNPsVpDtuJXDtBWaWLcnfTCBygC6SWWhORg9G7r
         uvP9SOjuhs81gc4o6TCNoGsh+FBsbIvCHkz0ZGgxNA2OzSS/nXEMqNSPds5phuYqDCXB
         8PAw7V6CtcrYrGNt0rBO/H4LihpbhTHXh7HMf9c1y0OtssaD5maJAgqfJsnLzAjyP+//
         Dphg4zmbG59AC4+1vhc5z6esQ6HRLPL5z13pqdLig7Oaya7GMG2xH0AT6/HHqrpinJ91
         up6UWoMtX91+FLKVETF77XdrCQPB9E0kbPMmovDj4Ep261V+etiy65IHzFYRVzP2lOBA
         GyKQ==
X-Gm-Message-State: AOAM530RCXsBfTO68wC0NlRC2dz45b7gDyiyi2B7hd+CS/EdBIPButbw
        BNSbxJmog6TgxYlTCSjEuNNNgiV8wLC4+ACohCNB
X-Google-Smtp-Source: ABdhPJx29RCzpccc4m8TLoUzrGMOn6VNYYHzJgJTPEBh260qWugDhamMvDLwbgtWT2gs356ZDqDyTAAJtEF2/+Ib+6I=
X-Received: by 2002:a05:6402:1805:: with SMTP id g5mr37604301edy.135.1600439312778;
 Fri, 18 Sep 2020 07:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200904161834.7677-1-cgzones@googlemail.com>
In-Reply-To: <20200904161834.7677-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Sep 2020 10:28:21 -0400
Message-ID: <CAHC9VhS7iWZnKnKcrwzS1ssreX5zzc1GGPeLxHs=-Qgrp=yzcQ@mail.gmail.com>
Subject: Re: [RFC PATCH] xperm_rules: add two notes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 4, 2020 at 12:18 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> I *hope* the note number 4 is actually correct!?
>
>  src/xperm_rules.md | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Hi Christian, I'm sorry for the delay but this fix is now merged.  I
did have to merge it by hand so please double check to make sure I
didn't mess it up (it looked good to me in all three formats).

> diff --git a/src/xperm_rules.md b/src/xperm_rules.md
> index 7f8744b..1e1dfff 100644
> --- a/src/xperm_rules.md
> +++ b/src/xperm_rules.md
> @@ -1,6 +1,6 @@
>  # Extended Access Vector Rules
>
> -There are three extended AV rules implemented from Policy version 30
> +There are four extended AV rules implemented from Policy version 30
>  with the target platform 'selinux' that expand the permission sets from
>  a fixed 32 bits to permission sets in 256 bit increments: *allowxperm*,
>  *dontauditxperm*, *auditallowxperm* and *neverallowxperm*.
> @@ -127,6 +127,12 @@ Notes:
>      class/permission is required.
>  3.  To deny all ioctl requests for a specific source/target/class the
>      *xperm_set* should be set to *0* or *0x0*.
> +4.  From the 32-bit ioctl request parameter value only the least signifi=
cant
> +    16 bits are used. Thus *0x8927*, *0x00008927* and *0xabcd8927*
> +    are the same extended permission.
> +5.  To decode a numeric ioctl request parameter into the corresponding
> +    textual identifier see
> +    <https://www.kernel.org/doc/html/latest/userspace-api/ioctl/ioctl-de=
coding.html>
>
>  <!-- %CUTHERE% -->
>
> --
> 2.28.0

--=20
paul moore
www.paul-moore.com
