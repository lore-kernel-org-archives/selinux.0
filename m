Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D541C433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1732071E
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 13:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1q6263Ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHYNi5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgHYNir (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 09:38:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10391C0617A4
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 06:38:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l23so11255231edv.11
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zFQ7lW9wDnCGOlGaO9qxYO0EL1Bi1Ise4K2xXXDejTA=;
        b=1q6263RyIWTTvUIYM+C8Ea/v+MA76nfQn8vbopYvD5VRRnLq17m6an7/BFeURIz8jY
         0dznrogeYiwyaRSiA7yBqRmuroCUoJDKGedz7zj5AQ83nNg3sf6ejTQL+urAvT86MSsn
         WriZrQtvpL5E4rWSGynsJNL5myly6uKmDOibjiQ0cgMhN4jrYDSqvI6+wcQZ2r0qr5Bk
         cWnB+p1GafEAjvoHQcnssykmlmgUDbTjKy5DxW5190srfIdAv7+CTBIxVnajbwGP9sYM
         XLZZWQxdFcSNmDRkqixBWfiCPrf0eWMeHp3TXW7Cj6Z0ZhV8lQHu9JTaB4pUyc6YdkGS
         twzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFQ7lW9wDnCGOlGaO9qxYO0EL1Bi1Ise4K2xXXDejTA=;
        b=KKumAtEOCbUyUn3ASaxvbsKc0xzE1ciZJ/VDMkmmpNydOORo3ChDI67F/lkE/bRI4k
         bO4wd9UZulbc42xWo5FvmN1YIN5mTUQNlFV929ix0P0k3B5rwW8Q5Ppy8nXvy8zp8aIP
         9RyaHL8R+h5vAWXshzpbJMOXnYAXJWy1Y+SYfZQw1PO/pu8U8G2gTYgNjfQkVo8Bke76
         NByptrASbkUDjUcJl6HL+Ie08xW+VEEqBJo5BOBGy8/7WZHl4y9XXfduk/+bEI4FMBDa
         4C/EcIKzt0XV5cV94e53qe40Z+TFlnVlKGVrVTfn8ZNDDB4G5GIbeUJThE6LLCV92xw1
         fnBA==
X-Gm-Message-State: AOAM531VZpEr5DR9vMgKUy+fVo2ijQo+GyymnAfaG6Qrcz4xE/G4hWny
        MskCO9MIg8+9SvOEpx+YdmZxcyLqGTMidYMq5823UmfuDt/L
X-Google-Smtp-Source: ABdhPJwNz4dyn/ZVot9zFaLgxNn2pO0Ir2DfKNyO6Xikxo/pfmL58/LF9UYei+ML6GUi+YR7t3G39W6Qn32GyHl8gAA=
X-Received: by 2002:aa7:c383:: with SMTP id k3mr9956342edq.164.1598362713402;
 Tue, 25 Aug 2020 06:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200825125130.GA304650@mwanda>
In-Reply-To: <20200825125130.GA304650@mwanda>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Aug 2020 09:38:22 -0400
Message-ID: <CAHC9VhS5pAr8g9C18cniKDrh3NRgg1z8e3qYs14P1iBpioOS7w@mail.gmail.com>
Subject: Re: [bug report] selinux: encapsulate policy state, refactor policy load
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 8:51 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Stephen Smalley,
>
> The patch 461698026ffa: "selinux: encapsulate policy state, refactor
> policy load" from Aug 7, 2020, leads to the following static checker
> warning:
>
>         security/selinux/ss/services.c:2288 security_load_policy()
>         error: we previously assumed 'newpolicy->sidtab' could be null (see line 2227)
>
> security/selinux/ss/services.c
>   2221
>   2222          newpolicy = kzalloc(sizeof(*newpolicy), GFP_KERNEL);
>   2223          if (!newpolicy)
>   2224                  return -ENOMEM;
>   2225
>   2226          newpolicy->sidtab = kzalloc(sizeof(*newpolicy->sidtab), GFP_KERNEL);
>   2227          if (!newpolicy->sidtab)
>   2228                  goto err;

...

>   2287  err:
>   2288          selinux_policy_free(newpolicy);
>
> This style of "one function frees everything" error handling is the
> most bug prone style of error handling ...

In this particular case I think the use of selinux_poicy_free() is
okay, we should just make selinux_policy_free() a bit more robust,
e.g. checking that ->sidtab is non-NULL before calling
sidtab_destroy().  While we are at it, it probably wouldn't hurt to
also check ->policydb.

-- 
paul moore
www.paul-moore.com
