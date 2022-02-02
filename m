Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E837DC433F5
	for <selinux@archiver.kernel.org>; Wed,  2 Feb 2022 00:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbiBBARx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Feb 2022 19:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243178AbiBBARx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Feb 2022 19:17:53 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6426C061714
        for <selinux@vger.kernel.org>; Tue,  1 Feb 2022 16:17:52 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id s5so59225745ejx.2
        for <selinux@vger.kernel.org>; Tue, 01 Feb 2022 16:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KK7I25AgkRzgGvdAK0a7A5EkaEe1A4C5P04pdjx6r0A=;
        b=itoeu+1LFk/IcJhctmsZLvlAHUqL5i0/XtqfnsEPQ1/ZniDf80mjwA0dYQ5rtGwjD8
         7BSE84+I+cDA7a/7n6DU0/5GB4A/NYjp20ebSbeN+hz2LKpHbJAim+20oTYGCsKhi6C5
         BOXuimH05YKX8jasaFcl7vhqVnDJON/8/1ZWVFyVLg6m1oSi2F8QLuSleEhwp+jleJA6
         mryYDJsqexkLGLegWnWyg7uxI3wiYOH99uISBzEuZGigDfRdFMDK8BzKXNuntItncZmE
         d5pHbYjJxroTbqrTWqY+7WiWdcdWaWNKPadCPnYYSjXvMpA8Ztv//tX8SEY+tfWlX7K7
         heZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KK7I25AgkRzgGvdAK0a7A5EkaEe1A4C5P04pdjx6r0A=;
        b=k1i0qjAe4igBU/OZRkxeuQg29cAVHRjIT5FE1Ii6ULyVbYCWGEcN4Adv9JU0/KPFNs
         II7vcNI3m17vU/Ee2NHwd2bkSFGWDklzEWvpMwkTc53Asp+5wkIiiffnVqTIGNsFX9DB
         MzfXFLiICKZ08TztADTQPLKnusSWjrxeFnDWd1wMNPWvY8CxKPninrr3L4YNerH5QLL7
         PquGDcsDrJ+v19b/wMSYif0gc42fPrm1WwF1fzPAlxuiilwUrArc2r/xqggnryMrQ5S5
         csevcqB2X0A68fp+ErWwFyQx7xPdd0VJZZlbuaA1G4LetcdwpHcOVAdeBJb/c88EOnkM
         JyDw==
X-Gm-Message-State: AOAM53218zUNgyfFan97hNg48vPhDnC0zgSC/qjL0/FiyYzyHs3kbVgt
        M2urP9QZbXWg24y0cNsHh+e4lpbaMX4kie+7xgczDrh98g==
X-Google-Smtp-Source: ABdhPJxzWsps3EN75NuEkFWl3bloaqHTy3+tSgD1kLtu0RAYlNG7y156h+N2faAU4g/exiFkPCeC1aP5gY83GtyXVQQ=
X-Received: by 2002:a17:907:2d93:: with SMTP id gt19mr22605151ejc.610.1643761070921;
 Tue, 01 Feb 2022 16:17:50 -0800 (PST)
MIME-Version: 1.0
References: <164330771809.139041.6643670399086580972.stgit@olly>
 <CAFqZXNv9LhVWD_cK+TbgnPSRnVSndecqJOh2vwqTVkxOQdu0zw@mail.gmail.com>
 <CAHC9VhRBpsH24bv7sPGg-KsTs4zx=5Zfifvnw0EsvinRw-DuSA@mail.gmail.com>
 <CAFqZXNsi-7vAC6TbMR_u3_pzAKNN=z+oD-GW=rd6g-fBEPW_GQ@mail.gmail.com> <CAHC9VhTrAWYYR_UxunGpcL=EQquKBEpG0oL1rLE2JwOL-5JB=A@mail.gmail.com>
In-Reply-To: <CAHC9VhTrAWYYR_UxunGpcL=EQquKBEpG0oL1rLE2JwOL-5JB=A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Feb 2022 19:17:39 -0500
Message-ID: <CAHC9VhTT8k56ZB5Okp6mcWj+9DndUD2EQRP=Hx+PzYFLkZVL4w@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: various sparse fixes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 28, 2022 at 1:13 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jan 28, 2022 at 9:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Jan 27, 2022 at 9:04 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Thu, Jan 27, 2022 at 2:03 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > On Thu, Jan 27, 2022 at 7:22 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > When running the SELinux code through sparse, there are a handful of
> > > > > warnings.  This patch resolves some of these warnings caused by
> > > > > "__rcu" mismatches.
> > > > >
> > > > >  % make W=1 C=1 security/selinux/
> > > > >
> > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > > ---
> > > > >  security/selinux/hooks.c   |    6 +++---
> > > > >  security/selinux/ibpkey.c  |    2 +-
> > > > >  security/selinux/netnode.c |    5 +++--
> > > > >  security/selinux/netport.c |    2 +-
> > > > >  4 files changed, 8 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > index 221e642025f5..0e857f86f5a7 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -2534,7 +2534,7 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
> > > > >         if (rc) {
> > > > >                 clear_itimer();
> > > > >
> > > > > -               spin_lock_irq(&current->sighand->siglock);
> > > > > +               spin_lock_irq(unrcu_pointer(&current->sighand->siglock));
> > > > >                 if (!fatal_signal_pending(current)) {
> > > > >                         flush_sigqueue(&current->pending);
> > > > >                         flush_sigqueue(&current->signal->shared_pending);
> > > > > @@ -2542,13 +2542,13 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
> > > > >                         sigemptyset(&current->blocked);
> > > > >                         recalc_sigpending();
> > > > >                 }
> > > > > -               spin_unlock_irq(&current->sighand->siglock);
> > > > > +               spin_unlock_irq(unrcu_pointer(&current->sighand->siglock));
> > > >
> > > > Shouldn't this be:
> > > >
> > > > spin_[un]lock_irq(&unrcu_pointer(current->sighand)->siglock);
> > >
> > > Maybe.
> > >
> > > The __rcu space annotation is definitely on task_struct::sighand, but
> > > my (quick) look at unrcu_pointer() was that the the de-rcu'ification
> > > applies to all of the dereferencing that is passed as the macro
> > > argument.  Because of that I decided to pass the entire dereferencing
> > > chain to the unrcu_pointer() macro just in case.  If that way of
> > > thinking is incorrect please let me know, otherwise I would rather
> > > just leave it as it is in v2.
> >
> > While it does work this way, too, it just doesn't feel right. IMHO
> > it's more self-documenting to mark the exact pointer for which we are
> > applying the RCU access exception.
>
> FWIW, the documentation aspect here is the "__rcu" marking on the
> pointer in the task_struct, and possibly the sparse warnings.  What we
> are doing here is basically a hack to tell sparse to be quiet, and
> since these core kernel variable annotations are likely to come and go
> independent of the SELinux code I'm not overly worried about minor
> self-documenting issues such as this (they are going to go out-of-date
> anyway).  I'm more concerned with keeping a clean {sparse} build.

Merged into selinux/next, and ultimately I changed my mind and decided
to change the current::sighand lines as Ondrej suggested.

-- 
paul-moore.com
