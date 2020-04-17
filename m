Return-Path: <SRS0=6dkg=6B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4ABC2D0EF
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 20:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A419E221EA
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 20:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="tKz+OYQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgDQUIj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbgDQUIi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Apr 2020 16:08:38 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD5EC061A0C
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 13:08:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so2467193ejd.8
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJ0XEnJgzf2nAJvFkOl8llFi48pg0PKDijO+E7rNDfo=;
        b=tKz+OYQZqURgbmeM/0YF0Ok2PBfgjBVggLqNMC5xpc/op+z+1zVnYSbIIEYmwDCcNQ
         hRlBuE6+mTQJ4uL4Ihb+b7RJK0z/KdlK8syQKmI0ysn+s8z82js10YfUgPK0og4IaTCC
         lJCBNQuA1l1tQtp0WNDSIj/1alxLp2tBg6Xf8wgpNJCti00G0MFh9evPgagldvaXZuD3
         7Q6iR1TOetk03sJnMAM7hqVmrSmusPe9FECZmaKzh6dKR2UOATkCI+5VN1Y8BcpMNgdB
         RV/oXyN5ivuRHxI2U+LKhYyMSF9PhWIft6C040h5a5aKQ/9y5B4RUYudXwLJmbU7Bqsg
         IB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJ0XEnJgzf2nAJvFkOl8llFi48pg0PKDijO+E7rNDfo=;
        b=T63GlQK2sQ0Y3/snkLEQmkhoF6YFjnemvVugJ3psfj53ey7VEGEDucNSj1GoOmDQHJ
         jB/A5xst1JfeNcpJoSWs+aoJs3OLTBYv9mGDL1F4vEm9ol+TEUvfBdwjJmIHq7zPbOIU
         6cAGttXlfUa8Zt22fC/LVwHmcGqivLMJir1w4Gh1sBODkoJxo+edigNCDCWgwy4MI0hc
         WeiNh28ZIla9jxFIF0gKOyF7RUHBlHhY3HpIDWN6krhDfdIqxcNz0+QqmA67tm0YqLfg
         LxPYlr26XINjlDKqrV35ahCyRJgFA1q3zMfqWUneUrQ7+729p8raW3cVpEANEEiO8yQr
         YBcA==
X-Gm-Message-State: AGi0PuY8Vuv3gHO9kavuXabBpoWd3W3yywLuGX8ZKVWhETBeZAwYr3Ae
        e/RCFp1M62xoo1kdd8//avheIhPvF7o25UB0dhGT
X-Google-Smtp-Source: APiQypKiAuUFufhvdNJCiK978WdlvmfzsR8N7JcXvJKhxUn4M0rkjO6WxKb/wwhUQPN/AFMRKqQMMKwXvvEuXOaOqJ0=
X-Received: by 2002:a17:906:d7a2:: with SMTP id pk2mr4917714ejb.272.1587154115605;
 Fri, 17 Apr 2020 13:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200417081157.606789-1-omosnace@redhat.com> <20200417081157.606789-2-omosnace@redhat.com>
In-Reply-To: <20200417081157.606789-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Apr 2020 16:08:24 -0400
Message-ID: <CAHC9VhS_HDwvd8E8icECHNx6hM4Pjew4Z_2ohDqXqvCOzxD1-w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: hash context structure directly
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 17, 2020 at 4:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Always hashing the string representation is inefficient. Just hash the
> contents of the structure directly (using jhash). If the context is
> invalid (str & len are set), then hash the string as before, otherwise
> hash the structured data.
>
> Since the context hashing function is now faster (about 10 times), this
> patch decreases the overhead of security_transition_sid(), which is
> called from many hooks.
>
> The jhash function seemed as a good choice, since it is used as the
> default hashing algorithm in rhashtable.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/Makefile      |  2 +-
>  security/selinux/ss/context.c  | 32 +++++++++++++++++++++++++++++++
>  security/selinux/ss/context.h  |  6 ++++--
>  security/selinux/ss/ebitmap.c  | 14 ++++++++++++++
>  security/selinux/ss/ebitmap.h  |  1 +
>  security/selinux/ss/mls.h      | 11 +++++++++++
>  security/selinux/ss/policydb.c |  7 ++-----
>  security/selinux/ss/services.c | 35 ++++------------------------------
>  security/selinux/ss/services.h |  3 ---
>  9 files changed, 69 insertions(+), 42 deletions(-)
>  create mode 100644 security/selinux/ss/context.c

Merged into selinux/next, with the spelling correction ;)

-- 
paul moore
www.paul-moore.com
