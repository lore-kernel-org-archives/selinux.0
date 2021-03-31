Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D197C433DB
	for <selinux@archiver.kernel.org>; Wed, 31 Mar 2021 01:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358596195C
	for <selinux@archiver.kernel.org>; Wed, 31 Mar 2021 01:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhCaBNi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 21:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhCaBNV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 21:13:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAECC061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 18:13:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a7so27528599ejs.3
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 18:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgkbewSu//kZ9Yy+gMbEyYik3KELJ5PUNe+bvnkgNNQ=;
        b=NomMlWS21oCAQpPRnHAqvU3N/gEFznDerZIQ9ablohU3RCXp1/eJGs2ybZHZh/pv6/
         nUPA0SNTeDwm13yldfEYKHzeZwatTt2OjH57C3hY/0A7/lhbUZcMqa3bpqHZt5UIp28l
         2cx/+Xp70zezkHl7ra+J/pIcXFq8MO9tV98fl+fSYHn9anQnAwC0ts+LtrNDWZXVIxwU
         7LQNKIoNjzZfZ9vRn5O9V2tQ+FWngS8I8sJUauu2Wda+a71asIEXS0EG9cgUhy9bMKxq
         0xsvRgAgTa2S9I0+1fws5TPvpy7JCDePHWd1bP3//qhQeCB2YlEj9zKPX3EUnJPxCFCP
         rJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgkbewSu//kZ9Yy+gMbEyYik3KELJ5PUNe+bvnkgNNQ=;
        b=Fkx0I3mx0oMjlQ77s/VJNLZe5YROobjmzjEK7/WSvQvPIzPFoGCGUHLtOj/sRSKDUY
         +31O7ID12eza1+befsC5VIEYiSrijjy6hZ6cH3FY+KqwAT+M64UXfDsGP6AXZN0O+PHN
         iL4T/DmHVh3hKc/OU1vrOFs4jEXwrJJANa4vn+whp1QAV78a85l5otIy04N1TPBzWQty
         aT7tJ9MIJf+c0St8o4qRpbLukKei7kr8/45nry2XJB6vssGJ9Ouutxl+nBzkGFDpjptO
         /IYvv9mGw6r9r9nkdQnRFl4UsoxaDcr+e4esf6Bk+cGgc/3sW+RwOZVRT4X6C70SF253
         VH7g==
X-Gm-Message-State: AOAM53156hQIe38scx93VcT7y/q0GQkYZ5DFKgIU3FFrrsxEo0iyHnOW
        ZptJzPdGuQUsMMqPMmbgQVQG2tnP52lJjwwkJLMn
X-Google-Smtp-Source: ABdhPJzmxg2vVGpF75/iDas/SC8gmhCMJZz4vFoXBo17Q9/dgLDxL281rI3uB0xbYLLiSbXzIT6kYmnInrwXhSXSCgY=
X-Received: by 2002:a17:906:2314:: with SMTP id l20mr948666eja.178.1617153199597;
 Tue, 30 Mar 2021 18:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210330131646.1401838-1-omosnace@redhat.com>
In-Reply-To: <20210330131646.1401838-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Mar 2021 21:13:08 -0400
Message-ID: <CAHC9VhQHTP4eXTEDtd=TztN-wPC=EZ84SG44sX9bZ=KtLfzp=g@mail.gmail.com>
Subject: Re: [PATCH 0/3] selinux: fix changing booleans
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 30, 2021 at 9:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This series contains a patch that fixes broken conditional AV list
> duplication introduced by c7c556f1e81b ("selinux: refactor changing
> booleans") and a couple "and while I'm here..." cleanup patches on top.
>
> Ondrej Mosnacek (3):
>   selinux: fix cond_list corruption when changing booleans
>   selinux: simplify duplicate_policydb_cond_list() by using kmemdup()
>   selinux: constify some avtab function arguments

Please don't resubmit, but in the future if you are submitting a patch
(or two (or three ...)) which is potential -stable material (and so
far I think 1/3 qualifies) don't submit it in a patchset with trivial
cleanup patches.  Adding cleanup patches to a patchset that adds a
feature is okay, but fixes should generally stand by themselves.

-- 
paul moore
www.paul-moore.com
