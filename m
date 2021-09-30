Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E3DC433EF
	for <selinux@archiver.kernel.org>; Thu, 30 Sep 2021 14:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F9A61A03
	for <selinux@archiver.kernel.org>; Thu, 30 Sep 2021 14:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351853AbhI3OWw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351840AbhI3OWw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Sep 2021 10:22:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947DCC06176A
        for <selinux@vger.kernel.org>; Thu, 30 Sep 2021 07:21:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g8so23045146edt.7
        for <selinux@vger.kernel.org>; Thu, 30 Sep 2021 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MyCwcfsUDqiUCxvRtESNHDowLGXO0wKtti7O2C84Vg=;
        b=mfWQu1DO2sq+9BOIlfa+C6Tw+0RIUAZqBfjDuguXZcHo8F/kggurvxDfraKmMErN9U
         8kE2AR4ZVVOKDr1tG2oDNJdX9rPBTHEmFcvaHcYqP6mMUhcFSSgj6h9A4nv9ou/lEOws
         PJnR3fZpAiuT/Mki0oNs2nvlSmrK5sLnN2g2KpZMaMzE+blU82/ry50NQPMQdA/OoPYr
         RWfnChlgS7rc+PoUVCgv4V3fzvMrYwDNq5t3eJing2eDx8A+a16axx57PiGvhsRE9TSX
         cNBahPjURyqknmBzpqoQXnPP1jqMzufiXTiVwgxadyDSakG4LGcJOIUkDQRYopikff+A
         lqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MyCwcfsUDqiUCxvRtESNHDowLGXO0wKtti7O2C84Vg=;
        b=rbfdkxCai/atyaz/hmR+jJBe1LlslvBUy9wrWYMegj66A4Vx7uMsnAixWVJ7HBO7UQ
         ksAotb69xGV79p2Spc13sLqmkGv6EdulJOZdLJOaQbGPvTngwz5STHYDfk0GHyRiS2Nv
         cxpGcWv0x82DfT5pqe4ypHgJXulLvR7lHyeKuBEO7ijddndXaxxiYfQPm0UrmxTaI6yf
         8PB91tiOhy+xzTuhAP3LqTu4C6xpXidNvZBbDShvH0XDPk09xSfKSYOYYqJXTgZxc2HM
         VZTbBFYWczWkYzwlIii6TtNKeNvmmER4Jd70ZTnIFGqy5yXeVVF6HJBBzzzph5oy/C/X
         621g==
X-Gm-Message-State: AOAM532lk67BmEkMGafqvnawjUWlefwsVI2L5bt+tnL+tvJZ58C9be2m
        xE+3nj2Sky6JEfL+lp3+YT1KONpMw3U4tiB9VYIaGCX2Zw==
X-Google-Smtp-Source: ABdhPJy4pL0qhuhFIPLdg97q/1WIHBV3HeHvvUMElQbgF8JZFyQqEh2RwxpuGyn6sMN9b+aE3r9RSRLwhfU47gekZWQ=
X-Received: by 2002:a17:907:8811:: with SMTP id ro17mr6991572ejc.104.1633011588593;
 Thu, 30 Sep 2021 07:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <163292547664.17566.8479687865641275719.stgit@olly> <CAFqZXNuYt8f3-H3Dx8q-b9Ce9eUcoEmVPxJtbZZpc4mwvMpZCg@mail.gmail.com>
In-Reply-To: <CAFqZXNuYt8f3-H3Dx8q-b9Ce9eUcoEmVPxJtbZZpc4mwvMpZCg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Sep 2021 10:19:37 -0400
Message-ID: <CAHC9VhT+Jp+Ww8xnxXz6whfD0ZB2iUqewa0ey3gQ6trEXSMi+w@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the SELinux lockdown implementation
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 30, 2021 at 4:32 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Sep 29, 2021 at 4:24 PM Paul Moore <paul@paul-moore.com> wrote:
> > NOTE: This patch intentionally omits any "Fixes:" metadata or stable
> > tagging since it removes a SELinux access control check; while
> > removing the control point is the right thing to do moving forward,
> > removing it in stable kernels could be seen as a regression.
> >
> > The original SELinux lockdown implementation in 59438b46471a
> > ("security,lockdown,selinux: implement SELinux lockdown") used the
> > current task's credentials as both the subject and object in the
> > SELinux lockdown hook, selinux_lockdown().  Unfortunately that
> > proved to be incorrect in a number of cases as the core kernel was
> > calling the LSM lockdown hook in places where the credentials from
> > the "current" task_struct were not the correct credentials to use
> > in the SELinux access check.
> >
> > Attempts were made to resolve this by adding a credential pointer
> > to the LSM lockdown hook as well as suggesting that the single hook
> > be split into two: one for user tasks, one for kernel tasks; however
> > neither approach was deemed acceptable by Linus.  Faced with the
> > prospect of either changing the subj/obj in the access check to a
> > constant context (likely the kernel's label) or removing the SELinux
> > lockdown check entirely, the SELinux community decided that removing
> > the lockdown check was preferable.
> >
> > The supporting changes to the general LSM layer are left intact, this
> > patch only removes the SELinux implementation.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> I would probably also remove LSM_AUDIT_DATA_LOCKDOWN, but I don't care
> enough to argue about it :)

As mentioned in the commit description, that was intentional.  I
wanted to keep the removal of the SELinux hook implementation separate
from any core LSM changes.

At some point in the future we can consider dropping the, rather
small, core LSM changes.  However it is my opinion that if we are
going to do that we should move the lockdown LSM functionality out of
the LSM and into the core kernel.  If Linus is effectively only going
to allow a single lockdown security model I feel the lockdown calls
shouldn't be part of the LSM.

Regardless, this patch is now merged into selinux/next.

-- 
paul moore
www.paul-moore.com
