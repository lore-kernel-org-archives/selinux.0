Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DE9C2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 18:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2858221EB
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 18:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rsZxiDPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389443AbgDPSIf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388949AbgDPSIe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 14:08:34 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9419C061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 11:08:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id p6so9274170edu.10
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6FyaOH8u6YrQEexBV5ldSSYhmmpsKw7a4cmfz6JMKcQ=;
        b=rsZxiDPD1uJPe+iz15tD3Kutl/ylnhHhNpdLRqBxe0fBeJnr6hvb29k/e75W6aiADU
         jvaonQvEX9l7RbW/fRN3HfAJ/RMGoFIF/0bKOSA4g5VzxhulkY05XDyWzcp0Iu/JpT+/
         ITwsuyuGltf1Ap7aFystP4QSU//p/ev/OUv2pdmKJmC7f+7Wcrb5s8c7Nx+79XQo3rEK
         ItEn5aZxbPEHWDbB9W6Bssal65yXcdms7ETCJGzyeLgKbsaPJNtYuUcnkSWqN18k/jgw
         hfK0OnXa5EP0oqmZXFeWiyBOPUciTG46jP5DB4fgKwIA+uAmUknw/co3NPygGuAT3itU
         Hbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6FyaOH8u6YrQEexBV5ldSSYhmmpsKw7a4cmfz6JMKcQ=;
        b=FKjW6mipRDU8A9rjrXsxPG2v33zCiJzsKxzcZVObbMNMZ2ko9OMkpuQguY8W6MWySg
         14ea3Y5sSKFdDSJ6Z0GljYMPyxeI3eZbUc3g+g5KYiDb/CS7R0rLZ/fAlqr4iwDhUmRr
         aCfGXafNBzZwJvydhnXDtRR3d8jKBE0bdZtnu37wijH8M9R/Psj2WMyqDUTPxJB+i0T8
         wFx0zEoItTPscXzdLW8hAVxFC8JVHmzQTuDt/IIdoHlcKaeDC4JrraN6XSC4Ie/W47Rd
         iQN4e/dneeXylky0l/6MUi1cC7o/ILqZb4pkWzqf3oBFIXWdj7FvBdsGFqEN6z6twGFL
         O5MQ==
X-Gm-Message-State: AGi0Pubv84578CW3jzgQhajQq0nvuy3OB437EwFFeaG1DqzhKYD6U2su
        WOBxRQ0xK8NbxC4dsVWZFYbmYu8xMVlRRZatYf/E
X-Google-Smtp-Source: APiQypIznIctVG0sbb+QEKLZYb8Gc1aV6sAXN8aOyDdsp9N9DR4hDLr/A0MwHlbhmgwA7wyToUHnaDDkOj6irJlUnE0=
X-Received: by 2002:aa7:c401:: with SMTP id j1mr3383870edq.31.1587060511457;
 Thu, 16 Apr 2020 11:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <158697587242.118532.14560996990720692395.stgit@chester> <CAFqZXNsTFv14wTc_aim7AZEi17rb562V=FAU8y-E82npF-Hh0g@mail.gmail.com>
In-Reply-To: <CAFqZXNsTFv14wTc_aim7AZEi17rb562V=FAU8y-E82npF-Hh0g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Apr 2020 14:08:20 -0400
Message-ID: <CAHC9VhRrQeD5WwYu-EEooE2zR6-pMObA9Mh97feCQWAKK9-dOg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: add capability:sys_admin to the bpf()
 related test domains
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 16, 2020 at 6:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Apr 15, 2020 at 9:22 PM Paul Moore <paul@paul-moore.com> wrote:
> > From: Paul Moore <paul@paul-moore.com>
> >
> > Historically the Fedora Kernels have been built with the
> > kernel.unprivileged_bpf_disabled set to 0, which skipped a
> > CAP_SYS_ADMIN check in the bpf() syscall.  However, starting
> > with the Fedora Rawhide v5.7-rcX kernel builds this sysctl
> > is now set to 1 which is triggering a CAP_SYS_ADMIN check
> > when performing bpf() operations.
> >
> > Add the capability:sys_admin to the BPF test domains so they can
> > pass this newly triggered check.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  policy/test_binder_bpf.te    |    2 +-
> >  policy/test_bpf.te           |   12 ++++++------
> >  policy/test_fdreceive_bpf.te |    6 +++---
> >  3 files changed, 10 insertions(+), 10 deletions(-)
>
> I have been applying a similar workaround in our RHEL testing, because
> I encountered the same setting on RHEL-8. Interesting that Fedora is
> doing the same thing now... Perhaps this is an unintended consequence
> of the recent workflow change? Anyway, it seems better to have the
> test ready to work regardless of the sysctl value, so:
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

FYI, I just merged this fix into the test suite.

-- 
paul moore
www.paul-moore.com
