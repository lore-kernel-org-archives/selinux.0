Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C2EC433F5
	for <selinux@archiver.kernel.org>; Fri, 28 Jan 2022 14:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349323AbiA1OfD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jan 2022 09:35:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245467AbiA1OfD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jan 2022 09:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643380502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AS375kZcH7Gxl6xgxJ+AAvvkuFL+9FuKzLq71kevTCk=;
        b=KHuDYFSYJcaVARV9ws1f82uRfsPbGOQ0GoUcAMn8SwpO8wveTZnIXSmJGQZyN0ZYzRXSpe
        WuQfBLdDx6iStIg2aMVRgFwZBoTiQSu+oyzElYn+k0jizJtTznBTPQNsIgU331yv2jO4ZD
        +RawMdgb9KmFDpLea2rfhl5grIoC1pI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-MFrqUwB5MdeJjG26FerDgw-1; Fri, 28 Jan 2022 09:35:01 -0500
X-MC-Unique: MFrqUwB5MdeJjG26FerDgw-1
Received: by mail-yb1-f199.google.com with SMTP id g67-20020a25db46000000b0061437d5e4b3so12583412ybf.10
        for <selinux@vger.kernel.org>; Fri, 28 Jan 2022 06:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AS375kZcH7Gxl6xgxJ+AAvvkuFL+9FuKzLq71kevTCk=;
        b=7J2vIzMqxVmzb7Ub18CMywzfxsNCh0L1GEKZtl4CvymTKf6w2+oHunadsFnuOIhSe/
         8nA/vifM9upLemkpNF0GtDQG0JYYDHw5vZxbxQtHzcj6mttwvoUJOdc359W35YcuI6tC
         Qw87JVDZM3BS/DQFuJN/g3sjMmsnzEcT9igdJ6+jjjdoDmbNzS7LZT7Z5nWV2gKvSGeB
         zqKKvWuGIQ5oiuCx+mili8hKa7q5/FX/uFy8Rb+nCs754mvnk769i5w4OaMA8J1axDcU
         MbCw5Pw3z7+M/IaXL7F99FtW8i7Kg1YfP9BX001mRoLyWCgg3uYcTfrbm303tQd5xpcp
         q3MA==
X-Gm-Message-State: AOAM533dFNaYpf1K1KiJRkgZYHEKzbD5ECzXPE2FXv3O+jGrioTru76v
        Se76DMG1UWOD+WYuKJ6xGBWqo+/Ffq8/sX4FXovqEAOxcdLntODbEHCAZB0v9wYFKWrO+CF+cvX
        2g18pxDc+t3gzGdIqPYKsaXi5e1LfY3OMmw==
X-Received: by 2002:a25:7382:: with SMTP id o124mr12528736ybc.318.1643380500096;
        Fri, 28 Jan 2022 06:35:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyURjMV7VLDuTpcxSjCtsoMJOmwEkG3aybY9c+KHh2IKkyIgt7lElFP9YdP8t/jWfEUTa/MBRYSlxxOPDaiYH4=
X-Received: by 2002:a25:7382:: with SMTP id o124mr12528721ybc.318.1643380499897;
 Fri, 28 Jan 2022 06:34:59 -0800 (PST)
MIME-Version: 1.0
References: <164330771809.139041.6643670399086580972.stgit@olly>
 <CAFqZXNv9LhVWD_cK+TbgnPSRnVSndecqJOh2vwqTVkxOQdu0zw@mail.gmail.com> <CAHC9VhRBpsH24bv7sPGg-KsTs4zx=5Zfifvnw0EsvinRw-DuSA@mail.gmail.com>
In-Reply-To: <CAHC9VhRBpsH24bv7sPGg-KsTs4zx=5Zfifvnw0EsvinRw-DuSA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 28 Jan 2022 15:34:42 +0100
Message-ID: <CAFqZXNsi-7vAC6TbMR_u3_pzAKNN=z+oD-GW=rd6g-fBEPW_GQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: various sparse fixes
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 27, 2022 at 9:04 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jan 27, 2022 at 2:03 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, Jan 27, 2022 at 7:22 PM Paul Moore <paul@paul-moore.com> wrote:
> > > When running the SELinux code through sparse, there are a handful of
> > > warnings.  This patch resolves some of these warnings caused by
> > > "__rcu" mismatches.
> > >
> > >  % make W=1 C=1 security/selinux/
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/selinux/hooks.c   |    6 +++---
> > >  security/selinux/ibpkey.c  |    2 +-
> > >  security/selinux/netnode.c |    5 +++--
> > >  security/selinux/netport.c |    2 +-
> > >  4 files changed, 8 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 221e642025f5..0e857f86f5a7 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -2534,7 +2534,7 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
> > >         if (rc) {
> > >                 clear_itimer();
> > >
> > > -               spin_lock_irq(&current->sighand->siglock);
> > > +               spin_lock_irq(unrcu_pointer(&current->sighand->siglock));
> > >                 if (!fatal_signal_pending(current)) {
> > >                         flush_sigqueue(&current->pending);
> > >                         flush_sigqueue(&current->signal->shared_pending);
> > > @@ -2542,13 +2542,13 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
> > >                         sigemptyset(&current->blocked);
> > >                         recalc_sigpending();
> > >                 }
> > > -               spin_unlock_irq(&current->sighand->siglock);
> > > +               spin_unlock_irq(unrcu_pointer(&current->sighand->siglock));
> >
> > Shouldn't this be:
> >
> > spin_[un]lock_irq(&unrcu_pointer(current->sighand)->siglock);
>
> Maybe.
>
> The __rcu space annotation is definitely on task_struct::sighand, but
> my (quick) look at unrcu_pointer() was that the the de-rcu'ification
> applies to all of the dereferencing that is passed as the macro
> argument.  Because of that I decided to pass the entire dereferencing
> chain to the unrcu_pointer() macro just in case.  If that way of
> thinking is incorrect please let me know, otherwise I would rather
> just leave it as it is in v2.

While it does work this way, too, it just doesn't feel right. IMHO
it's more self-documenting to mark the exact pointer for which we are
applying the RCU access exception.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

