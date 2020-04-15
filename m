Return-Path: <SRS0=gWJv=57=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C53C2BA19
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 23:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D1220774
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 23:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FdEnhcpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbgDOXA2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Apr 2020 19:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbgDOXAY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Apr 2020 19:00:24 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92230C061A0C
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 16:00:23 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w4so6999308edv.13
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vg+ns/+EVXFqKser9IbTSUWCYcNj0HawjncAmXP9o5g=;
        b=FdEnhcpVYUXrtyfzk/fsRhs5sBqLAmBTMm+BTc3kDpmYdVBCWHUbmtDeig8dNCiC91
         GScBFQJOoRV3VVtzaXGBFCoeRL3eBDjGbhlAOr7TO03xOXC4tnhMXZe0hFMNWQhc9r6q
         cJGgLusyj1EHXyhTqHkEl1jJbvkqbZfgt6XhParnTptxyLEzZSWRpQztWRf8H7WRYlUI
         dP3CdFWtkVJlP0YQrIA4j8fQbdfo6oahVNcDW3C1xx7MOPpqE46dS44U6bVFZMk3Nd0s
         un6Oz6G5t9njaSYKmPzTy54i/1z7g2ADf0cD8XbfYZnmkSkZWFmP9a2GJ/q1A/dxt4lz
         9Llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vg+ns/+EVXFqKser9IbTSUWCYcNj0HawjncAmXP9o5g=;
        b=gCT8KZoN/LOxceNXzIKrDnpmSTMUZob8Di2/NYlG4JjbA0HkAX8UDYAQHGrVtsRPEA
         LLeClzRCO4uiTYu4Gw8KOUtGs8FBm7Ce75TAXx9bAQOmdgrKV31F5rr6WgE2xppH1qRE
         MISpfz4IgI+/lH2OMeeQ2bH96lwYX6rsVW83wChg3P4rcy21RtDJMtK3XcmR1f5LZGWH
         enz0tGiheziRdCpIO0YCBBMH4HEzNzlncaqzxS4ylgsd477eI0/2ZwIfD64FlXFmqIiR
         F06E29mT2ys47hSx9CFCdNIFnLBf3Jc8C2chiCr4RuMN1FsrFcGA/WigzCjnKAYy/adC
         GYPQ==
X-Gm-Message-State: AGi0PuYFlONDhE67a0j96an3s5H4l7LMJ5lbu93rSXnQR5jEsO7i0dGt
        N8/Udc2lVAobw9Goj0KVWj0kBnjJP0MWBVPdz+IgV88=
X-Google-Smtp-Source: APiQypLaAgQ0bo2Sw/F7hiqKzngh5w5Ae8d6P4juxbxIMZkKNTEcOg1Ax+rBcYrd3Le9MKiVy3D6z0qDTAIeVOmLTuU=
X-Received: by 2002:a50:f152:: with SMTP id z18mr26927358edl.31.1586991622282;
 Wed, 15 Apr 2020 16:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200408090808.1219529-1-omosnace@redhat.com>
In-Reply-To: <20200408090808.1219529-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Apr 2020 19:00:11 -0400
Message-ID: <CAHC9VhSU7OExVgXE06Q=Os=_pQ6Lv=dN_4BkPPpobWHDXk-7Xg@mail.gmail.com>
Subject: Re: [PATCH] selinux: drop unnecessary smp_load_acquire() call
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 8, 2020 at 5:08 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> In commit 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table") the
> corresponding load is moved under the spin lock, so there is no race
> possible and we can read the count directly. The smp_store_release() is
> still needed to avoid racing with the lock-free readers.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/sidtab.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
