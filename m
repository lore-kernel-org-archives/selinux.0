Return-Path: <SRS0=kzV7=AE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC08C433DF
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 15:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CBA20781
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 15:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6JoRaTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbgFWPmP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732941AbgFWPmP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 11:42:15 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B321C061573
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 08:42:14 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x202so19221317oix.11
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pFdoeGhdOBhXGsu75iPUVOF72xaP4c/HSsXMZA/sEI=;
        b=m6JoRaTpqVY7XTUR2iqIuYjDt79+6WcHhM0oi18MlMsD67S3GxF4af+DTrt4JHlrc5
         AwxX/X5haxxSWzwDdVYA4m/o3GBn326pwz15hTvSidh/hC5ZCFo/CpMTY025ECByHpjf
         g/ff1WyLO4CWInfcRk+XtfOjjlSrxxMLMtIx0DuQxitTnRSU8TXu+xUcM/OcHkIZYDr1
         yWnJbAkRgjlQbqCfI3897IalJHkjTKEGMqZ1zmJcn0Lsy/NvNrtHFEC7rk7jU6BjJcKg
         qiVxZ1P4jOt8QDgXOnW3clEsu50uCGagIcYf9QYdbwMbrfb9maSWSomUB+F6fS0SZTx+
         6VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pFdoeGhdOBhXGsu75iPUVOF72xaP4c/HSsXMZA/sEI=;
        b=Uh/I6VVnGw70JQeY4kJC53+I6HDr5T/tULi/lhYy8VWg7aHgI+ppzLwcVTlj8DldBO
         cBXhOF/1iJ5rNap+mH7124HlHv9pbCOm0sEL+uTNCk9x5hluLAaiWBZzpbAJkH8LA7kD
         E0NZe+2J4kEoUUnJhaJwPyum0fgEUhztppqkLh7m8dqxeGvK9feUJ1xvoHjQYGSwRO4I
         d1FcHi8PwzW0lkeq46B+POpgCw76X9xYW3JaQIMnXQnckNcY61A27kaYgG+VrJ8aBW2a
         tkkCX5z9y7i7iukBHSR9bL5npcwVKt46t1GspWzLJxj5TNr+KWo1/Hwt9SKkE9u2Fb1B
         xufg==
X-Gm-Message-State: AOAM533cbA/WtkO3nyRT0EWQ9gD2fJru+O5yOpvtHJZ8eC3fplmvFgvx
        607N0Q1EP1/itF3CuHUiu/G61ZvwC4G0TlSPIO4=
X-Google-Smtp-Source: ABdhPJxpAMHqiAQwiLJ3k43spFzbssDIB56wZ6VnBvXk+QIAjdAQVqEtqdVyOzd0myM9mUaNLgZsyJlTzM7kyTtyL0Q=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr15904533oib.160.1592926933865;
 Tue, 23 Jun 2020 08:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200623123702.401338-1-omosnace@redhat.com> <20200623123702.401338-3-omosnace@redhat.com>
 <CAEjxPJ6OPt0r2Dv2u2Skt=ojKTVpNMcvDFKkoyw50naHetLC7Q@mail.gmail.com> <CAFqZXNuajPrS0KSg=mcA=nRCACf6o_vscbY00pX=j9aYupVZOw@mail.gmail.com>
In-Reply-To: <CAFqZXNuajPrS0KSg=mcA=nRCACf6o_vscbY00pX=j9aYupVZOw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 23 Jun 2020 11:42:02 -0400
Message-ID: <CAEjxPJ4-9eB9FTXxt+RN0c3zLGhM6KYbcuwO=xNPZqfTAZoYEg@mail.gmail.com>
Subject: Re: [PATCH testsuite 2/4] travis: add missing node to fake selinuxfs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 23, 2020 at 9:29 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Jun 23, 2020 at 3:13 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Jun 23, 2020 at 8:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Since commit e95fe9503816 ("Add tests for default_range glblub") we look
> > > at $(SELINUXFS)/initial_contexts/kernel to determine the type of the
> > > policy. However, this node is not provided by the fake selinuxfs created
> > > by our CI scripts, leading to non-fatal errors like this:
> > >
> > > [...]
> > > make[1]: Entering directory '/home/travis/build/WOnder93/selinux-testsuite/policy'
> > > cat: /tmp/fake-selinuxfs/initial_contexts/kernel: No such file or directory
> > > [...]
> > >
> > > Create that node and fill it with the ussual kernel context to silence
> > > the errors.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Not objecting to fixing this but wondered if you had considered
> > extending the .travis.yml to actually run the testsuite in a
> > SELinux-enabled VM as per the selinux .travis.yml.
>
> Maybe eventually, but for now I wanted to at least fix what we have now,

Sure, no problem.  In an ideal world, we'd even run it on a Debian
and/or Ubuntu SELinux-enabled VM too as part of travis-ci (following
the README.md instructions and if on Ubuntu ignoring the two
kernel-config-induced failures) but that would require an extra
relabeling and reboot step to get the VM into a SELinux enabled state.
