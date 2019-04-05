Return-Path: <SRS0=5WGn=SH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D40C282CE
	for <selinux@archiver.kernel.org>; Fri,  5 Apr 2019 18:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FC42146F
	for <selinux@archiver.kernel.org>; Fri,  5 Apr 2019 18:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="tQJyyK7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbfDESxt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:53:49 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:39419 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfDESxt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Apr 2019 14:53:49 -0400
Received: by mail-oi1-f179.google.com with SMTP id n187so5721701oih.6
        for <selinux@vger.kernel.org>; Fri, 05 Apr 2019 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2f/wx1Ht0owhrjCEn4KXqEXERLfnoaRudbtz28sA2mA=;
        b=tQJyyK7sy/dtD9svTcYp52iJYnoI4bYz7uV6RpxvPmqH3hHLqeeJm7YuA9FR0w4G27
         Hg8BdIINwUnlGz5FK/RFmykwrPKdZgJ/jZNmFylA+ICNvbal2T63cqbIDK0KLqAaHQTD
         nMOglglYzNlzdpQdh3laa7KoV8FeCccHXZWSXq7L4INpj+XRuNSOZboP0bi3nScK844d
         7D/KBkO2R/wmSgV5qttbIlPIj7P+3eUchwIyGQSW2l7ve38OOSkuRs6nLVoj4jXxLTI3
         atCQRQFdApBYWbSN1QWj5xL+T7qxbbzrKpa1Nss47ZzBb7lLaYhm4R3Q4zkUwuNxdQwi
         JBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2f/wx1Ht0owhrjCEn4KXqEXERLfnoaRudbtz28sA2mA=;
        b=f8iV19KtkZavySMeh6CgB1/jL11jXoEkWYa7dnNwWO5GxDIFpBDfrWbaflcEFDIJN2
         IyAduJ1J+XPWOZyeqXQnui3HJMM/eCSRAPxR11llpUrHVPxYpACgaO24Lwl+iH9kBwQu
         cYm8nQ6KBJSMMVHyYAyCEKLtZe8R4yPQwOr/JHmhAOw74KXE7Slx0yjqM0KFN0lwZQ3f
         85IOhsaNOwfSirzPRcCNeDb3Yh4GgVretlRDXGTKQjERAqps+xts0jxMqTp0E1+ccRt7
         514xSaVn3QEuaICvFqWbESSqHaA6ff6Jh2yiSH9pRUALdrX3reeid0u7mgF2MVBukvD9
         h96A==
X-Gm-Message-State: APjAAAXtGS7XWBbF9apMpSA9Blap463CBR8icgGyW2crxA/Zm4yTLMOX
        M7zxbljIT45GL8faeSNcCIEkuyMMv6XXzuGnffnYYA==
X-Google-Smtp-Source: APXvYqwrtYbc0OrG7bjHSyIpQclFu5/JB5EiiOKNy34U5GYMSDPgDtpMtHoSw3kzuB/1vCPd1a29F1qDgN3fLqDQN9Q=
X-Received: by 2002:aca:6084:: with SMTP id u126mr6596330oib.145.1554490428574;
 Fri, 05 Apr 2019 11:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdrzF1DnuXyKkinNCEmNKeQdqmyTXxqBLTdgxeR_dT1W7A@mail.gmail.com>
 <20190405183850.10861-1-joshua.brindle@crunchydata.com> <CAFftDdrnLjZdAoZT5+xE1YO5AL6ftTyiZJdBcoiecuJe5ye-eQ@mail.gmail.com>
In-Reply-To: <CAFftDdrnLjZdAoZT5+xE1YO5AL6ftTyiZJdBcoiecuJe5ye-eQ@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Fri, 5 Apr 2019 14:53:37 -0400
Message-ID: <CAGB+Vh5ad2SBUcpY5bNzWRSfV5jjXiojy0aaYJXyzY9EqnVZdQ@mail.gmail.com>
Subject: Re: [PATCH v4] Add security_validatetrans support
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

<snip>
>
> I guess this is fine, I don't think the negative return conditions can
> exist unless you bork the format
> string.
>

I'll fix it.
