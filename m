Return-Path: <SRS0=e/d8=CO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A61C43461
	for <selinux@archiver.kernel.org>; Sat,  5 Sep 2020 13:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0E22072D
	for <selinux@archiver.kernel.org>; Sat,  5 Sep 2020 13:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zuIDeADX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgIENZ1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgIENZ0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Sep 2020 09:25:26 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30800C061244
        for <selinux@vger.kernel.org>; Sat,  5 Sep 2020 06:25:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so11006753ejb.1
        for <selinux@vger.kernel.org>; Sat, 05 Sep 2020 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ie9e005vGpeYxWm0WXYp4ZFqRLXamHsEroBYvkvSe6o=;
        b=zuIDeADXkz8tJwtl0SbURyUkAA3XlVMuaNLSYiCxAAekyiiFXzExEiylis3mEXv6k5
         KgGSiONjkQlHp0C6s6LXAGTvDc/BX9dW9Nz9MMIoiLqpnwXw/5AXeSAiLinq7hp4DzYo
         s4dc6EGykUo1seb4WZCaU4gaKsTqXBOsnbEqGbskRUgLPrXwJtThKs51fO9ae/Lk3A5h
         PCImRLUjdxlJhIbNv4HWa8zrAUdDtiorojeVrMttvZS5g6nPfS4muEiCzQLvYFgQoGj9
         vA+cmLHGkwK5lf3eiUEGR69eXTiVJWOfS5PKkx0flxSIZ6FYhupU6IdHFojFxLBleHa1
         ygOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ie9e005vGpeYxWm0WXYp4ZFqRLXamHsEroBYvkvSe6o=;
        b=LKBtU8HAAvY+dj2CeuuYXxkmwZng+XbUNEmwHM0WXgoJFQV4bGC7/kmYFWQBngxShS
         kvzGcoTLGpARWYvIw/YqSLD+q9YLZ+HnAhyCdJaejNAsd7qE9fsFep7ZWwarPK2LuSIQ
         3k9dvfQf8/58t6+YYaf9hXjAhOPgufdhjQCRtN8azgtqPzY92BDwzhFqx1QGPAr7YWqt
         jqdo+RvvdUfdJQCIoLOfmQFjXTfokXHT7Eg9dCshio22PSyhOw2xyTUjCfHcRCbpJLpv
         00fII/Vbsh5W21gFuShevY3L69kqf/0Ra+TgNRhU64dezjlD4jVtO/qSHUGyzNVApUO7
         /h9A==
X-Gm-Message-State: AOAM532DTvaq3bJM2IVGMxcS7X5BW8441BkuBcVivDcNTgfc1iBYANBO
        3an8p3pnTwbZUc6di1bGXk9ISqFaaTDNvHwth60F
X-Google-Smtp-Source: ABdhPJwCaOgYK/F9wk68UkyQKW1/SozAMRuWXaWQi2G9kZivtfrjsCtXnEpBDCt41ghL1Cqjg24uuP1iTYI81sdPCzQ=
X-Received: by 2002:a17:906:5205:: with SMTP id g5mr12119953ejm.488.1599312324669;
 Sat, 05 Sep 2020 06:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-6-casey@schaufler-ca.com> <CAHC9VhSh=r4w_3mZOUwmKN0UxCMxPNGKd=_vr_iGV06rvCNbSA@mail.gmail.com>
 <1eeef766-405f-3800-c0cf-3eb008f9673e@schaufler-ca.com> <CAHC9VhSf8RWUnRPYLR6LLzbn-cvNg8J0wnZGwTOAe=dOqkvd0g@mail.gmail.com>
 <ef6a049a-c6b9-370b-c521-4594aa73e403@schaufler-ca.com>
In-Reply-To: <ef6a049a-c6b9-370b-c521-4594aa73e403@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Sep 2020 09:25:13 -0400
Message-ID: <CAHC9VhSu4qqKWsutm3=GF_pihUKpwjAtc9gAhfjGsGtKfz-Azw@mail.gmail.com>
Subject: Re: [PATCH v20 05/23] net: Prepare UDS for security module stacking
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 4, 2020 at 7:58 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 9/4/2020 2:53 PM, Paul Moore wrote:
> > On Fri, Sep 4, 2020 at 5:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 9/4/2020 1:08 PM, Paul Moore wrote:

...

> > I understand the concerns you mention, they are all valid as far as
> > I'm concerned, but I think we are going to get burned by this code as
> > it currently stands.
>
> Yes, I can see that. We're getting burned by the non-extensibility
> of secids. It will take someone smarter than me to figure out how to
> fit N secids into 32bits without danger of either failure or memory
> allocation.

Sooo what are the next steps here?  It sounds like there is some
agreement that the currently proposed unix_skb_params approach is a
problem, but it also sounds like you just want to merge it anyway?

I was sorta hoping for something a bit better.

-- 
paul moore
www.paul-moore.com
