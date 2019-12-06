Return-Path: <SRS0=TNfp=Z4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3557EC43603
	for <selinux@archiver.kernel.org>; Fri,  6 Dec 2019 00:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6F92466E
	for <selinux@archiver.kernel.org>; Fri,  6 Dec 2019 00:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Wo9iqlYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfLFAuh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Dec 2019 19:50:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35447 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfLFAuh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Dec 2019 19:50:37 -0500
Received: by mail-lf1-f65.google.com with SMTP id 15so3942707lfr.2
        for <selinux@vger.kernel.org>; Thu, 05 Dec 2019 16:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ynmedbz0weEMLkq3Shtoowb4gat0g5FoVqW/kJ0FlxI=;
        b=Wo9iqlYLJwdC1hSiGGV4DtVuQ5itinpsBD8ivtVoL7p7/X05OujrGgprxAFcNmQ9B4
         nXsvpQD7irL57dBOxYQZFqvc6CZkiyGLWozp7g3iww8fkF5SJc5/hAIYJA+aXttE/9Th
         Fo15f+pbDB8fDcOnlHF60fH6qf78bhHC9A7TPplXcs9W/Lk9pWhu8bTb2E8K8D4EgeGb
         QY17mxOxFbs1a8GxKyR9AAHyZRk56UARbq9r+iT6wC7wk4Narxvq4ZfSDIgpZqIuPW88
         5EtrP+zseQFro2MFikmOnGAVLedwo+rv6o08OlvZuNhO8ToYHpwu6sF5LrJtx6veQoUV
         5QPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ynmedbz0weEMLkq3Shtoowb4gat0g5FoVqW/kJ0FlxI=;
        b=RABiQ3KX2NjFFGrfY+OYE29DohMOQjBalKp+xM5UFqjzUVSx71w8pSToboO3JVYnaW
         lLmP2VRroSjwrKjAMvoj/DkTwfspxx1CIvp2bCYq9mP9OAbtMp+XDdhRMHqV39fxiUlu
         zwAePfsPsRPLqsD2ptKyzbd5nAozYwErGu4n3hykshWxzSN5hiN1KGB4FSt14x+jsNgI
         YzQ/D11A8RIc3W/5WWYdLgnT6Nok0+LsJMDYdAgLrCXmh2V8b6GJ+e+JechlzZ2LlTbx
         MjFCVeHUhG0lbiD9Bj+WqgyzMF68jP3VN5tglHt1l1XiPkZkU14sK0xJ0Z2yTi7po09b
         7SRg==
X-Gm-Message-State: APjAAAU8KfwnFf8jYyzNNRlgF7MqT0Cu/hcJEPjzj/9+VubkCRCR7hAG
        Ndt18SEXVrIPEH8cHfbetZC/ylSEffc0MXG2LbzN
X-Google-Smtp-Source: APXvYqyP5wwQjdlYIpS/1EM4H1QbysnSln5ThYZwqZzaWW6pOlhH12XuwM8bcdwN316IXbP0q2IP45FJqTY4hc1F9Ns=
X-Received: by 2002:a19:6108:: with SMTP id v8mr6495070lfb.119.1575593435163;
 Thu, 05 Dec 2019 16:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20191122093306.17335-1-jeffv@google.com> <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
 <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
 <CAHC9VhTwct8daQoXFg4JpHkWUhijQFn8D0Tq=VX989mq3TVfvg@mail.gmail.com>
 <CAFqZXNvQV+syzOE0CGczzTvi9g65AUT8bdsG0YN6NcHzd5GVHQ@mail.gmail.com>
 <CAHC9VhSVsmu6hjmUAi2wM6wAkkQnUDx7MM1G8Ln9OLAzwFmz6A@mail.gmail.com>
 <CAHC9VhR+hYnLoMkAPuRNJygk+dOoNyhooNuz3Ma=F07b9gh=rA@mail.gmail.com>
 <8257410c-025a-7250-fa78-944289e378bd@tycho.nsa.gov> <CAHC9VhREL17FH0XOUkvegY4yGeQu5p1qLdWEdnwvPw1W+bLfRA@mail.gmail.com>
In-Reply-To: <CAHC9VhREL17FH0XOUkvegY4yGeQu5p1qLdWEdnwvPw1W+bLfRA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Dec 2019 19:50:24 -0500
Message-ID: <CAHC9VhQOb5skqQofnrESFuAqfRE1+xq9OD48JcYzq77v0XJsog@mail.gmail.com>
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

On Thu, Dec 5, 2019 at 1:14 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Dec 5, 2019 at 1:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 12/5/19 12:41 PM, Paul Moore wrote:
> > > Hmm.  I haven't done any debugging yet, but the BPF tests are failing
> > > (they pass with kernel-5.5.0-0.rc0.git5.1.2.secnext.fc32.x86_64):

...

> > They all pass for me (with your next-queue branch, using the
> > selinux-testsuite defconfig fragment merged with the Fedora config).
>
> Oh goodie, I'm special :/
>
> FWIW, my current test kernel is the next-queue branch rebased on top
> of Linus' current tree, using the latest config from the secnext
> kernel builds (Fedora Rawhide + stuff for the test suite).
>
> > The error above doesn't look SELinux-related; it looks like your kernel
> > is rejecting the trivial bpf program used in the test code as being
> > invalid for some reason.
>
> That's where I'm at as well, I'm building an instrumented kernel right
> now to try and track down the source.  I'm sure it is something silly
> like a messed up kernel config or something, but I'd like to
> understand *why*.

I traced the "./bpf_test -p" failure down to a BTF check in the BPF
verifier, there is a comment in that code block which helpfully reads:
"Either gcc or pahole or kernel are broken.".

 :/

The relevant commit is 8580ac9404f6 ("bpf: Process in-kernel BTF"),
and it appears to be new for v5.5; it isn't present in selinux/next or
selinux/next-queue.  Recompiling with CONFIG_DEBUG_INFO_BTF disabled
does allow "./bpf_test -p" to succeed, but I hit other BPF test
failures further along.  For reasons I don't understand, the secnext
kernel builds (which should have this code, and have
CONFIG_DEBUG_INFO_BTF enabled) are not hitting this problem, but that
may be due to differences in the build tools on the two systems
(although they *should* be the same).

Given that we haven't hit -rc1 yet, and everyone else's builds are
working just fine, I'm going to leave this alone for now.  Whatever
the problems may be, they definitely don't appear to be SELinux
related.

--
paul moore
www.paul-moore.com
