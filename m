Return-Path: <SRS0=K0yT=Z3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0A6C2BD09
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 18:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0909124249
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 18:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="16KI71Ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfLESOd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:14:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42342 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbfLESOd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Dec 2019 13:14:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so3191722lfl.9
        for <selinux@vger.kernel.org>; Thu, 05 Dec 2019 10:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1mbu72fue1w94f7H/01z6lpC91UZjJyYTpTWo5hbi4=;
        b=16KI71TivqjkJWZYsGoENfAhUsb6bJZiFzHGUJK4qdg4lvGvdQiblNkFtvVOwBr+Z4
         Qp/CyieE2jQja0MLLCmHgneRzGHhCLKJ+oMZbGCzW3dQionQI8urhKveWNZeRPugyweu
         lbiGDtvqHoeL8xBmjixl/eb8eYj1LbfCh1Q9TW1KmQ50Ujj41f3UiZ+yBEzgc/bhN32K
         P4JmHRwTsfqLJOuY84kPWdcdybcoMl+kCNlceLvqCpC+/69tT8wvUU5xGTv4kxCt2sO/
         Rqy1IVVxeyLXcmoHaGX+LHAi/DG5F2CF8pC+cEmTEbFWxcfwhfm+SqGsS8SLE8oAbReL
         q8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1mbu72fue1w94f7H/01z6lpC91UZjJyYTpTWo5hbi4=;
        b=l5w05bVfkJ63bb2gjY8MnKBDxO94JXgWIJnhZsDaY91YRcyHkbLQa2Fc38KYXOpXvs
         rGyYgI7Hk1z56D+4omZc6nqdXshUl7/Tb/qnRLholLrO99S9kZKENKtZt2tV9398NttU
         m8nI1Bi4kS/EZhT8wQJCP0uNnNbwsRJMRDgdmT3/1TwXZ5DCi2qbgroomCqOEq38e6Cd
         JAA6Y93mBTFN4t/vhEFqmOfFi/iPKVnn2CpoepDVbfiFSwGR02drWSyRSNDGR6Ki9LYx
         k9g2sTKV5CjlewoD8FsShdipQ2QoonwGXB6Yxz9yd8bEVV09MJsZh3TZjmx96PlVUj75
         k6Pg==
X-Gm-Message-State: APjAAAWLpCdRjoyLb9AZdb+Yu/micp81CfX/BS+h6i+cX2F5umekAZ1q
        0Yv0O7tTLWCLPM34NwqCrdTs83/lfce1WddNcfBd5/M=
X-Google-Smtp-Source: APXvYqxhz1I4bu3yvW1j9yK5AxaadYl5b9S36DePy6tmAY2e5I5Fgfhy+OtI2Peb8VOL/6bngEoyyyRthBZ++aL0Lp0=
X-Received: by 2002:ac2:54b5:: with SMTP id w21mr5846567lfk.175.1575569671124;
 Thu, 05 Dec 2019 10:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20191122093306.17335-1-jeffv@google.com> <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
 <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
 <CAHC9VhTwct8daQoXFg4JpHkWUhijQFn8D0Tq=VX989mq3TVfvg@mail.gmail.com>
 <CAFqZXNvQV+syzOE0CGczzTvi9g65AUT8bdsG0YN6NcHzd5GVHQ@mail.gmail.com>
 <CAHC9VhSVsmu6hjmUAi2wM6wAkkQnUDx7MM1G8Ln9OLAzwFmz6A@mail.gmail.com>
 <CAHC9VhR+hYnLoMkAPuRNJygk+dOoNyhooNuz3Ma=F07b9gh=rA@mail.gmail.com> <8257410c-025a-7250-fa78-944289e378bd@tycho.nsa.gov>
In-Reply-To: <8257410c-025a-7250-fa78-944289e378bd@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Dec 2019 13:14:19 -0500
Message-ID: <CAHC9VhREL17FH0XOUkvegY4yGeQu5p1qLdWEdnwvPw1W+bLfRA@mail.gmail.com>
Subject: Re: [PATCH v9] selinux: sidtab: reverse lookup hash table
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 5, 2019 at 1:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/5/19 12:41 PM, Paul Moore wrote:
> > On Thu, Dec 5, 2019 at 9:08 AM Paul Moore <paul@paul-moore.com> wrote:
> >> Thanks for the double check.  Unfortunately my kernel build locks my
> >> test VM in early boot; it appears to be non-SELinux related and since
> >> the test build is based on selinux/next+patches (which is based off
> >> v5.4-rc1) I imagine there might be some unrelated problems in the
> >> build.  I'm going to rebase my test build to Linus' current and try
> >> this again.
> >
> > Hmm.  I haven't done any debugging yet, but the BPF tests are failing
> > (they pass with kernel-5.5.0-0.rc0.git5.1.2.secnext.fc32.x86_64):
> >
> > 1..15
> > ok 1
> > Failed to load BPF prog: Invalid argument
> > not ok 2
> > #   Failed test at ./test line 68.
> > Failed to create BPF map: Permission denied
> > ok 3
> > Failed to create BPF map: Permission denied
> > ok 4
> > Failed to create BPF map: Permission denied
> > ok 5
> > Failed to load BPF prog: Permission denied
> > ok 6
> > Failed to load BPF prog: Invalid argument
> > ok 7
> > client: Using a BPF map fd
> > client: Connected to server via ./test_sock
> > server:  Accepted a connection, receiving message
> > client: Sent descriptor, waiting for reply
> > server:  Received a descriptor, fd=5, sending back 0
> > client: Received reply, code=0
> > client: ...This implies the descriptor was received
> > ok 8
> > Failed to load BPF prog: Invalid argument
> > client: Using a BPF prog fd
> > client: Connected to server via ./test_sock
> > sendmsg: Bad file descriptor
> > server:  Accepted a connection, receiving message
> > server:  Received no descriptor, sending back 1
> > not ok 9
> > #   Failed test at ./test line 118.
> > Failed to load BPF prog: Invalid argument
> > client: Using a BPF prog fd
> > connect: Connection refused
> > ok 10
> > client: Using a BPF map fd
> > connect: Connection refused
> > ok 11
> > ok 12
> > Client request_service_provider_fd() failing command BR_FAILED_REPLY, exiting.
> > ok 13
> > ok 14
> > Failed to load BPF prog: Invalid argument
> > Client request_service_provider_fd() failing command BR_FAILED_REPLY, exiting.
> > ok 15
> > # Looks like you failed 2 tests of 15.
>
> They all pass for me (with your next-queue branch, using the
> selinux-testsuite defconfig fragment merged with the Fedora config).

Oh goodie, I'm special :/

FWIW, my current test kernel is the next-queue branch rebased on top
of Linus' current tree, using the latest config from the secnext
kernel builds (Fedora Rawhide + stuff for the test suite).

> The error above doesn't look SELinux-related; it looks like your kernel
> is rejecting the trivial bpf program used in the test code as being
> invalid for some reason.

That's where I'm at as well, I'm building an instrumented kernel right
now to try and track down the source.  I'm sure it is something silly
like a messed up kernel config or something, but I'd like to
understand *why*.

-- 
paul moore
www.paul-moore.com
