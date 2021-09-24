Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48134C433F5
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 19:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E55610CB
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 19:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346035AbhIXTFW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhIXTFV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 15:05:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2C8C061571
        for <selinux@vger.kernel.org>; Fri, 24 Sep 2021 12:03:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v10so35194356edj.10
        for <selinux@vger.kernel.org>; Fri, 24 Sep 2021 12:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDnpogF8dbmMCk025QFyYiU2yMMI4IdTnKilTSso6uI=;
        b=1FAI3LlXyvJgEXl7k+kM3Xp/uOIB4/3fO7OHeAI70maSkm7KwltqOa0D1LP1JSiD/R
         PTQJXe3fCKBXRr5ZwO73mSbaCvVN7u2pqnBwzL1eJ7VveI9p0pI0m2A5kOCyniO3ZiUH
         51WukJCbVILS17DMyKH2z4vIHa2O79E7Tzoms+IDL2t3KtEX57vap9uDXuAafFSL/INs
         ycqZ9XwyYghj0vSmbVxRiottVWlW0YmnQ8FCwH56my76bXP5/Nzod5gh/861/BOkxKYx
         awq7eoyn2Lq4BBwmm1RrJY7OGAdKCPKQn0LqDNsczZrOzs1faSPROZTdvado7J/3JjYd
         c5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDnpogF8dbmMCk025QFyYiU2yMMI4IdTnKilTSso6uI=;
        b=qbJCIzTKC6RTd2GNmuI6CuQKQ3SBpZ8LkOlYzSfec4wl6pJnldq0fsZJGLlEJgXGHH
         fkFe+TJFuVruQOed65f6vh7TOnrGjkxLwabZmHIZ4A5/Ekzfm2WCXp0wB3LhC9FuxuEL
         tyqDmVGZVxI6vP46zGj2bwlG1utvXYChWmsmyuTc6W9AE3VH0GBOYIDuRU4uvM+/OEUo
         UKUN9aKiZWHgMetzarywK9Sr1ydqughBev50UJcj657hebtOsUvrBJp8bn8C7+37kbTU
         4lekKJikq3tzEZdBihT5ZzwexzBiEQF/yoL7HTlp4HTpL8dFQGJbcA00HAe701N2wc2R
         aXjQ==
X-Gm-Message-State: AOAM532cXWO1HW4eFFggUJ7mCqZSVNjWrFplKjYpsjQ8wULQXrypfb2R
        86HpiJ5wr4XF23E9pUtZDKb2xpELm+MMIh9nPiwOftOpNA==
X-Google-Smtp-Source: ABdhPJyTmMh2oBD9zsDPYepGu6HwacLHUD4tgwMUh33TjjYyjNln4+56ULIId83TUuf/6hgize3LlOX2zyWiCmiZZzQ=
X-Received: by 2002:a17:906:6011:: with SMTP id o17mr12575165ejj.157.1632510226253;
 Fri, 24 Sep 2021 12:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <163243191040.178880.4295195865966623164.stgit@olly>
 <CAEjxPJ5pxox=oE0TxmEFA-PkFGPDbAjtK_nqM3y-xaT0e3or0w@mail.gmail.com>
 <CAHC9VhTAY0povyGpv3QhiE9n4WDmnSYTi9Cq8ZnVO_AkH8M6EA@mail.gmail.com> <CAEjxPJ7wkCyPZb7h3C_U3zVmJtiVtm4FAi5K+6U7kS63g0Vm-w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7wkCyPZb7h3C_U3zVmJtiVtm4FAi5K+6U7kS63g0Vm-w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 Sep 2021 15:03:35 -0400
Message-ID: <CAHC9VhQAzp4zgok7qofiHK21qJ_NiVoUh8z7VpE5AwUFbEpdYQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: use SECINITSID_KERNEL as the subj/obj in the
 lockdown hook
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 24, 2021 at 11:12 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Looks like Fedora policy allowed both permissions unconditionally (no
> boolean) to all unconfined domains.
> So SECINITSID_KERNEL checks will pass but are rather pointless unless
> Fedora decides to define separate
> integrity/confidentiality rules and wrap them each with a boolean
> (e.g. allow_kernel_integrity_violation,
> allow_kernel_confidentiality_violation) so that an admin can disable
> them to enforce lockdown independently
> of the lockdown module.
>
> Android policy allows all domains :lockdown confidentiality but
> prohibits (neverallow) integrity permission from
> being allowed on user (production) builds. They do allow apps
> :lockdown integrity on debug builds for debugfs
> kcov usage, so that rule would need to be fixed if switching to always
> using SECINITSID_KERNEL or the checks will
> start failing.

Thanks Stephen.

> Did all the issues around invoking audit from arbitrary contexts in
> which security_locked_down() is called get sorted?
> If not, we'll still have that as a potential problem if permission is
> denied or an auditallow rule is defined on lockdown.

I believe the only issue was the eBPF code and that was resolved in a
separate patch that is already upstream.

> Can we get Linux distro and Android folks to speak as to whether they
> consider the check in this reduced form to still be useful or whether
> we should just remove it altogether?

Yes, that's probably going to be the deal breaker.  However as the day
goes on I'm growing more fond of just ripping out that SELinux hook
and being done with it.

-- 
paul moore
www.paul-moore.com
