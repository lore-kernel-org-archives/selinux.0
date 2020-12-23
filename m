Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7288EC433E6
	for <selinux@archiver.kernel.org>; Wed, 23 Dec 2020 15:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4682C2333D
	for <selinux@archiver.kernel.org>; Wed, 23 Dec 2020 15:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgLWP0p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Dec 2020 10:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbgLWP0p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Dec 2020 10:26:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9748FC061794
        for <selinux@vger.kernel.org>; Wed, 23 Dec 2020 07:26:04 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u19so16549292edx.2
        for <selinux@vger.kernel.org>; Wed, 23 Dec 2020 07:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aynHpdcYEJRz/G4CBLqyTBkxsILBk/FZ/rPZaYz6pvM=;
        b=J4wY+oArnYHud7p7/uFKptm8CckBN9kukMJauD8QY6bmx5CRgW5o0MdoSGMVTLGA18
         ooXDuOQr8hM0lf0AHLQkGVcrv/sB7SQBq4lR/52o/UDgeHRwGqDKZhBS7VbqZpyFyZoW
         CYT1QuI0Ek5md8N4cDvINmNKPKkhxLbmWXczxt4ywz+M9BCp8B7hZkvheiYjcIc/mggj
         IJtRDLJmbiIp0BBEtDKX2LfeKswhZgmVTBjdD+c0FE1txdUgLUhJhDdT5mjpz9+aoCsw
         nu/R2g7GjRfGXFS/gU8HuROZO6vKcAcQOXh6LRKDDEjhf5MINtrloMzbvXKD//VHHemE
         nvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aynHpdcYEJRz/G4CBLqyTBkxsILBk/FZ/rPZaYz6pvM=;
        b=q3fYlwL6PckbVMuY32yxjLFZx0RoUmGIZm03h4jKNBOM6/GrUojfeQ6PRALhCP6o8Z
         lTzWEmVKrwDOV+ngStuaqCsc57y5N8VeumhB80xDowuAmMV5vZv/gPkE3ZSkyicr9iNr
         KIj0uepQSY+esqD+jHxv0DW9eXEsWRh8mkM0H1l33FHKSAUusjLVmMy7Yspyq2RS0qNT
         zeoJjJjhX7HeHgH1FYjK9K663ktqWox4jBxYXwwhL9TrPYZzE7Ku5DESDRCKDZtX0he+
         n4CpCD5G+qNVraGdOTaqxnbosipq6VyYCJ/uome01cJ14Lr12oOMlsVfzuVuhc8Dl8Gj
         x/6Q==
X-Gm-Message-State: AOAM5308FnoKyrNr0QUAYqV58EwOIriRC1cssreMcrUfEIyAqA8/slto
        1ndC2JTZQWF8QukNgRAK9H6cqz4mF2uKc2O3Ip2x
X-Google-Smtp-Source: ABdhPJyLihsxjTzvi2HeA+elHryUhKXCikwl0sshvsYpsB9sLKnEzQgaCF/ge7mTmh3r4hbiJgUJdj9GGXXq4Xex2DQ=
X-Received: by 2002:a05:6402:1593:: with SMTP id c19mr25530180edv.269.1608737163153;
 Wed, 23 Dec 2020 07:26:03 -0800 (PST)
MIME-Version: 1.0
References: <X9vP2uwRZb1l1ySE@server-build.lan> <CAFqZXNtvY4tJnH07wNvTGuynzGYQQrwVQiXVWBTDfzWUPCWpsw@mail.gmail.com>
 <CAHC9VhTfs_qfyiY916dW3GOMtzyUSebgH8W5H-k7GdBii7vHzg@mail.gmail.com>
In-Reply-To: <CAHC9VhTfs_qfyiY916dW3GOMtzyUSebgH8W5H-k7GdBii7vHzg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Dec 2020 10:25:52 -0500
Message-ID: <CAHC9VhSZt3YP_TLBvr4nU7CeRqaccj0E1uTK-PcHT_MW2xSGbw@mail.gmail.com>
Subject: Re: [kernel-secnext] Automated Testing Results Linux
 5.11.0-0.rc0.20201217gite994cc240a3b.102.1.secnext.fc34.x86_64 [12/17/2020 16:38]
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     kernel-secnext@googlegroups.com,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 21, 2020 at 11:03 AM Paul Moore <paul@paul-moore.com> wrote:
> On Sat, Dec 19, 2020 at 6:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Dec 17, 2020 at 10:38 PM <paul@paul-moore.com> wrote:
> > >
> > > SYSTEM: test-rawhide-1.lan
> > > DATE: Thu, 17 Dec 2020 16:38:34 -0500
> > >
> > > KERNEL: Linux 5.11.0-0.rc0.20201217gite994cc240a3b.102.1.secnext.fc34.x86_64
> > >
> > >    audit-testsuite: PASS
> > >  selinux-testsuite: FAILED
>
> ...
>
> > > ### START SELINUX TEST LOG
> > > Compiling targeted test_policy module
> > > Creating targeted test_policy.pp policy package
> > > domain_fd_use --> on
> > > Running as user root with context unconfined_u:unconfined_r:unconfined_t
> > >
> > > domain_trans/test ........... ok
>
> ...
>
> > > tun_tap/test ................ ok
> > >
> > > #   Failed test at perf_event/test line 61.
> > > # Looks like you failed 1 test of 9.
> > > perf_event/test .............
> > > Dubious, test returned 1 (wstat 256, 0x100)
> > > Failed 1/9 subtests
> >
> > So as you can see, we finally added the perf_event class to Fedora
> > policy :) (at least that one for a start...)
> >
> > The failure seems to be caused by the introduction of CAP_PERFMON (and
> > the fact that we haven't yet added *that one* to the policy...). I'll
> > try to come up with a patch, but it probably won't happen until next
> > year, so if someone wants to have a go at it, they are of course free
> > to do so :)
>
> Thanks for looking into this.  I noticed some consistent test failures
> last week but figured I would give it a few days to see if it resolved
> upstream (test failures during the merge window are not uncommon, and
> they often resolve themselves in a day or two).
>
> At the very least I'll see if there is a quick patch I can do for my
> automated test runs so we don't keep seeing this failure.

I took the easy way out and just downgraded the policy packages and
blocked the two affected versions :)

-- 
paul moore
www.paul-moore.com
