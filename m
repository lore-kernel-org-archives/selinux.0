Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1FBC433EF
	for <selinux@archiver.kernel.org>; Fri, 28 Jan 2022 18:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbiA1SNP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jan 2022 13:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbiA1SNN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jan 2022 13:13:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660E2C061714
        for <selinux@vger.kernel.org>; Fri, 28 Jan 2022 10:13:13 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a8so18579273ejc.8
        for <selinux@vger.kernel.org>; Fri, 28 Jan 2022 10:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwx+fCfQlOQPWLrbZgwu4bBzKUAr7O76fmoNLqfy3XI=;
        b=W72gbpu8ifdM+tePIMky87q7cQkhmC678n88O14JB+JQEYw3YHVM9RwF+6u6uGjR2V
         Dwv99YujyDwgjB3wCa4i38/Y7Q+MGm9DugHR80JoEm9zglSHHxbDzpbtwKlxc6vgP1Bq
         klkeTHm6U23KL+Y7baNL9rPqQohrKxpwN7ZkTc08B8PvTIAhoY5H24bmAW2x7lUmz7FC
         F/nVqThndQLutAlUyWj2LO9MaI357dSpf4Lk4E6gtNUosGgyxYA74bSAjz8QbhJsKRaX
         ifJ0fX+kHACLJ6kuEl2J65pYYYdTMnZIcMNXb1ABKQfqzgxFdiFZRIepqWpbsiVQcc0s
         MvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwx+fCfQlOQPWLrbZgwu4bBzKUAr7O76fmoNLqfy3XI=;
        b=7+3HBk4qXU5kgULws96Ev4MnMTpw16PQYRikNgjMnobyTzs2BUhsZ76NH/okTZ+Yg0
         /ytIWGgLHCKX6l2mtpVNbEcL4HbGIGi7nSG23Yk742xTDtD/LgT5b+PImTBTGLgtRUaS
         9NNu2hC6rYbq0NRVNZh363LzI2Efs4C6XjwJF76etw/jd5vXAYLwTTX+P+fBU2PIBc7z
         G0ATYugO5Hoz3SoMT8Bq76hY+T1lxw+vsX+GrL7nBF4CLCDBmDUAhWxYVlzFpojKWS9H
         tDybLTpoSqLJ8mh/Yb1X+BpuJff8Tild0ppW8DvCxft/mHG9DfazrJqiXRdE6f+E26d+
         8wlw==
X-Gm-Message-State: AOAM5320xJGtwp0rqP2f0Ocq+huasAJS9dXscfxi6uuzKONumUgvGrLP
        nGMoDlUZNVxZkzfRc6kr3kqouQOXtJJMzIkxcAR0n/kDyw==
X-Google-Smtp-Source: ABdhPJzJzKYZ9LsYEwMKaSLpvGLlBT2E03jHSUA880nxqVr0jngg+ItAYvi7IrltdhuUnypxjxLK9xxhnYJJHwxo+DI=
X-Received: by 2002:a17:907:2d93:: with SMTP id gt19mr7728824ejc.610.1643393591397;
 Fri, 28 Jan 2022 10:13:11 -0800 (PST)
MIME-Version: 1.0
References: <164330771809.139041.6643670399086580972.stgit@olly>
 <CAFqZXNv9LhVWD_cK+TbgnPSRnVSndecqJOh2vwqTVkxOQdu0zw@mail.gmail.com>
 <CAHC9VhRBpsH24bv7sPGg-KsTs4zx=5Zfifvnw0EsvinRw-DuSA@mail.gmail.com> <CAFqZXNsi-7vAC6TbMR_u3_pzAKNN=z+oD-GW=rd6g-fBEPW_GQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsi-7vAC6TbMR_u3_pzAKNN=z+oD-GW=rd6g-fBEPW_GQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Jan 2022 13:13:00 -0500
Message-ID: <CAHC9VhTrAWYYR_UxunGpcL=EQquKBEpG0oL1rLE2JwOL-5JB=A@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: various sparse fixes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 28, 2022 at 9:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Jan 27, 2022 at 9:04 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Jan 27, 2022 at 2:03 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Thu, Jan 27, 2022 at 7:22 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > When running the SELinux code through sparse, there are a handful of
> > > > warnings.  This patch resolves some of these warnings caused by
> > > > "__rcu" mismatches.
> > > >
> > > >  % make W=1 C=1 security/selinux/
> > > >
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > ---
> > > >  security/selinux/hooks.c   |    6 +++---
> > > >  security/selinux/ibpkey.c  |    2 +-
> > > >  security/selinux/netnode.c |    5 +++--
> > > >  security/selinux/netport.c |    2 +-
> > > >  4 files changed, 8 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 221e642025f5..0e857f86f5a7 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -2534,7 +2534,7 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
> > > >         if (rc) {
> > > >                 clear_itimer();
> > > >
> > > > -               spin_lock_irq(&current->sighand->siglock);
> > > > +               spin_lock_irq(unrcu_pointer(&current->sighand->siglock));
> > > >                 if (!fatal_signal_pending(current)) {
> > > >                         flush_sigqueue(&current->pending);
> > > >                         flush_sigqueue(&current->signal->shared_pending);
> > > > @@ -2542,13 +2542,13 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
> > > >                         sigemptyset(&current->blocked);
> > > >                         recalc_sigpending();
> > > >                 }
> > > > -               spin_unlock_irq(&current->sighand->siglock);
> > > > +               spin_unlock_irq(unrcu_pointer(&current->sighand->siglock));
> > >
> > > Shouldn't this be:
> > >
> > > spin_[un]lock_irq(&unrcu_pointer(current->sighand)->siglock);
> >
> > Maybe.
> >
> > The __rcu space annotation is definitely on task_struct::sighand, but
> > my (quick) look at unrcu_pointer() was that the the de-rcu'ification
> > applies to all of the dereferencing that is passed as the macro
> > argument.  Because of that I decided to pass the entire dereferencing
> > chain to the unrcu_pointer() macro just in case.  If that way of
> > thinking is incorrect please let me know, otherwise I would rather
> > just leave it as it is in v2.
>
> While it does work this way, too, it just doesn't feel right. IMHO
> it's more self-documenting to mark the exact pointer for which we are
> applying the RCU access exception.

FWIW, the documentation aspect here is the "__rcu" marking on the
pointer in the task_struct, and possibly the sparse warnings.  What we
are doing here is basically a hack to tell sparse to be quiet, and
since these core kernel variable annotations are likely to come and go
independent of the SELinux code I'm not overly worried about minor
self-documenting issues such as this (they are going to go out-of-date
anyway).  I'm more concerned with keeping a clean {sparse} build.

-- 
paul-moore.com
