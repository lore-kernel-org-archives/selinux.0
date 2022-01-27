Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55432C433F5
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 20:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiA0UEX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343848AbiA0UEE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 15:04:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD9DC06176C
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 12:04:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id k25so8397308ejp.5
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 12:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4D/8o0yGCtnpavlwyoAJLDFIObAN8S2G91MnZqRCtI=;
        b=ZUqv1N3UhQj+X7mGPcXnNNjduPNsEgX3Eu1f4QQhGHXl11ZdTLpukEMMbMJKf86dTM
         I3wUffQFQZ+Nae5uEMjI42T4TXSEP6wl6BjmQTuvSdclTa3URRIdJXtU9jiP6scLZi8S
         EYDOtP4NKdkO4h44FY6ogOQdUazUhn95dL0ENB4cOHCAoY+mRvQz9CDSf67GBdEO76pg
         o9ukRiSxDjAsmSOIhaRjOk6IWtTciRUIE40e13C2t81AAQeB34HcIMBj4yF5gnpso6mq
         pfWRletG5eMb/oEjeOegciIEBL8TXIVzJbB3/JorRGESLtehqP3GvcgIESGCGv4xzLRB
         w1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4D/8o0yGCtnpavlwyoAJLDFIObAN8S2G91MnZqRCtI=;
        b=6G0kftVOLI5bCvfGzU2bXJzzHAgJ+569Qaz7YmpAdaX8hhdau+xZ8ehUJnr9tdo1F9
         AUWDG3M8WkaG4IUugHzU24kunUheiEp8RBBz9ucG8Nltv7doanOxMzJ4MgMZYGndI4zn
         Oi3+NPZKPupfG9/xi6JMW+D3YSR4bmUG3u74UUtuD89AuhdvK6rH+vx9a7xrqdleUyiS
         SR8Zg/KaiZ3YQu1hInKztNBgdGcoanVMh7VFTSWdT36KH0PRrgsetIG51gqG/jQuxhca
         Ljy9ktBoo5hGkmGIb9gklk9ev2wTXvR4H6dPcW0g278+sOS+AiZ85ClN5daU837ycTaK
         WfPg==
X-Gm-Message-State: AOAM53043BnztI2zVBQmMXx+Ks5Og/PLzdBUlEbHDRWy99SJ9qWBzUPy
        g+6qibL7gNk3f2kRWgJhks92gOFuLT50H/57UgJVOCTrJA==
X-Google-Smtp-Source: ABdhPJy6vEw62BG0s4hiFICNQrNo1s6/i9H/lCWJW/xmsZh52V/465Bz9INVV6VQmiZrO55Hj/YMTz+vjbjb3fomkq8=
X-Received: by 2002:a17:907:7faa:: with SMTP id qk42mr4125625ejc.29.1643313840383;
 Thu, 27 Jan 2022 12:04:00 -0800 (PST)
MIME-Version: 1.0
References: <164330771809.139041.6643670399086580972.stgit@olly> <CAFqZXNv9LhVWD_cK+TbgnPSRnVSndecqJOh2vwqTVkxOQdu0zw@mail.gmail.com>
In-Reply-To: <CAFqZXNv9LhVWD_cK+TbgnPSRnVSndecqJOh2vwqTVkxOQdu0zw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Jan 2022 15:03:49 -0500
Message-ID: <CAHC9VhRBpsH24bv7sPGg-KsTs4zx=5Zfifvnw0EsvinRw-DuSA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: various sparse fixes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 27, 2022 at 2:03 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Jan 27, 2022 at 7:22 PM Paul Moore <paul@paul-moore.com> wrote:
> > When running the SELinux code through sparse, there are a handful of
> > warnings.  This patch resolves some of these warnings caused by
> > "__rcu" mismatches.
> >
> >  % make W=1 C=1 security/selinux/
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/hooks.c   |    6 +++---
> >  security/selinux/ibpkey.c  |    2 +-
> >  security/selinux/netnode.c |    5 +++--
> >  security/selinux/netport.c |    2 +-
> >  4 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 221e642025f5..0e857f86f5a7 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2534,7 +2534,7 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
> >         if (rc) {
> >                 clear_itimer();
> >
> > -               spin_lock_irq(&current->sighand->siglock);
> > +               spin_lock_irq(unrcu_pointer(&current->sighand->siglock));
> >                 if (!fatal_signal_pending(current)) {
> >                         flush_sigqueue(&current->pending);
> >                         flush_sigqueue(&current->signal->shared_pending);
> > @@ -2542,13 +2542,13 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
> >                         sigemptyset(&current->blocked);
> >                         recalc_sigpending();
> >                 }
> > -               spin_unlock_irq(&current->sighand->siglock);
> > +               spin_unlock_irq(unrcu_pointer(&current->sighand->siglock));
>
> Shouldn't this be:
>
> spin_[un]lock_irq(&unrcu_pointer(current->sighand)->siglock);

Maybe.

The __rcu space annotation is definitely on task_struct::sighand, but
my (quick) look at unrcu_pointer() was that the the de-rcu'ification
applies to all of the dereferencing that is passed as the macro
argument.  Because of that I decided to pass the entire dereferencing
chain to the unrcu_pointer() macro just in case.  If that way of
thinking is incorrect please let me know, otherwise I would rather
just leave it as it is in v2.

-- 
paul-moore.com
