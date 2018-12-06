Return-Path: <SRS0=bAF8=OP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C8CC04EB8
	for <selinux@archiver.kernel.org>; Thu,  6 Dec 2018 23:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6B120878
	for <selinux@archiver.kernel.org>; Thu,  6 Dec 2018 23:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MvNdi3ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6B120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLFX35 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:29:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37663 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLFX35 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Dec 2018 18:29:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so1978529lja.4
        for <selinux@vger.kernel.org>; Thu, 06 Dec 2018 15:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5VEPmDZ7GIKvoN2goXVGt03hS31ZNGL4hbskgT5cig=;
        b=MvNdi3jujfrr/nZK2W1l1bZAU14OtUlu/tRY4HNG00cl4ayHJ2+GcHKy3SlwE0ZH1m
         ReLgcQ5rjpgsNGFO/58c4ftceGiAQghfgRukO+o/94saXBXVxHgV54MaOOu8yRV9Esa7
         EqFThSCIcAmQOP42QN1b0sEN3ohjKhV24ueZvybJmiTTWc+VsQBSTFoU9P/DKJ4y+QjI
         mqznQZjhfzyZjjcCEpJW42OGsgQP2d/wk9mvzFv1Zw8vzYvKqgMGGqtfwrxqO1MyV6Ky
         6hpSDldcXePp8tT9aN4SnWuZBmiAhxvPsP5iPAIPmgHY2hGEPUVzUzUtWFI7ILrKoGjN
         L90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5VEPmDZ7GIKvoN2goXVGt03hS31ZNGL4hbskgT5cig=;
        b=fd/lp1++qboFmr8a62LjvZU2hREQKaozgoei4QEiffwm3V2iGV5GBSw0OP6lj/xL40
         gTwFYd6IaXMP8G4QhdgZzmbd3vUD/VuMbBOCJyDLSw0Bkp3LQD5vzGqUm5httAKlL99Q
         JM+j7O6Oko7pCD87ItK4UN7pdH9KloQ5cO670t1lxxroEVxBW7rEwPJmveyET2iCYYZA
         oWgv33EEJe/ydVMNU6Hvs6OKc3PnVp4Vv6xWC1NRR7UIQq2XleOgo0/iBcm/z7pw2DDs
         KJvfZuEcBweSXQZQhNoj/ZupQs/BFefSI+D0Iyw0cnj2XMLhkbplmRrd6FpECDOh9D50
         Pkqw==
X-Gm-Message-State: AA+aEWZQyqWanxqNLTibk3zHIBjcKuPFDfkdcKnc75YVGG9dIwZPnCXo
        7J71UfQzcg0fNis3RId56wxMgMJFbevIBAF6HR+kb8o=
X-Google-Smtp-Source: AFSGD/V4a+Adbjx83x4I+P+2pRd+SnXDN4ARfqoTe2SEAlXCPLLBb6dbyJcmznD5RoU0Z84rhwGDYakaJMP0fTLTyWA=
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr19714307ljk.55.1544138994585;
 Thu, 06 Dec 2018 15:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20181130152408.24513-1-omosnace@redhat.com> <20181130152408.24513-3-omosnace@redhat.com>
 <CAHC9VhR8P0+1emYZMAJ+6y6ga9Za_AJ0cw0g0QEViv5NoBXfBw@mail.gmail.com> <CAFqZXNvhYR1WbRv+Q8J+ufBazSxPZ2HS3FRQHOpAgZncjWwd9g@mail.gmail.com>
In-Reply-To: <CAFqZXNvhYR1WbRv+Q8J+ufBazSxPZ2HS3FRQHOpAgZncjWwd9g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Dec 2018 18:29:43 -0500
Message-ID: <CAHC9VhR03G=ebYtDcTDmiUi+j7VY0K6h9vUGybVesUQeCV4B_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/2] selinux: overhaul sidtab to fix bug and
 improve performance
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 6, 2018 at 4:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Dec 5, 2018 at 11:53 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Nov 30, 2018 at 10:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > Before this patch, during a policy reload the sidtab would become frozen
> > > and trying to map a new context to SID would be unable to add a new
> > > entry to sidtab and fail with -ENOMEM.
> > >
> > > Such failures are usually propagated into userspace, which has no way of
> > > distignuishing them from actual allocation failures and thus doesn't
> > > handle them gracefully. Such situation can be triggered e.g. by the
> > > following reproducer:
> > >
> > >     while true; do load_policy; echo -n .; sleep 0.1; done &
> > >     for (( i = 0; i < 1024; i++ )); do
> > >         runcon -l s0:c$i echo -n x || break
> > >         # or:
> > >         # chcon -l s0:c$i <some_file> || break
> > >     done
> > >
> > > This patch overhauls the sidtab so it doesn't need to be frozen during
> > > policy reload, thus solving the above problem.
> > >
> > > The new SID table leverages the fact that SIDs are allocated
> > > sequentially and are never invalidated and stores them in linear buckets
> > > indexed by a tree structure. This brings several advantages:
> > >   1. Fast SID -> context lookup - this lookup can now be done in
> > >      logarithmic time complexity (usually in less than 4 array lookups)
> > >      and can still be done safely without locking.
> > >   2. No need to re-search the whole table on reverse lookup miss - after
> > >      acquiring the spinlock only the newly added entries need to be
> > >      searched, which means that reverse lookups that end up inserting a
> > >      new entry are now about twice as fast.
> > >   3. No need to freeze sidtab during policy reload - it is now possible
> > >      to handle insertion of new entries even during sidtab conversion.
> > >
> > > The tree structure of the new sidtab is able to grow automatically to up
> > > to about 2^31 entries (at which point it should not have more than about
> > > 4 tree levels). The old sidtab had a theoretical capacity of almost 2^32
> > > entries, but half of that is still more than enough since by that point
> > > the reverse table lookups would become unusably slow anyway...
> > >
> > > The number of entries per tree node is selected automatically so that
> > > each node fits into a single page, which should be the easiest size for
> > > kmalloc() to handle.
> > >
> > > Note that the cache for reverse lookup is preserved with equivalent
> > > logic. The only difference is that instead of storing pointers to the
> > > hash table nodes it stores just the indices of the cached entries.
> > >
> > > The new cache ensures that the indices are loaded/stored atomically, but
> > > it still has the drawback that concurrent cache updates may mess up the
> > > contents of the cache. Such situation however only reduces its
> > > effectivity, not the correctness of lookups.
> > >
> > > Tested by selinux-testsuite and thoroughly tortured by this simple
> > > stress test:
> > > ```
> > > function rand_cat() {
> > >         echo $(( $RANDOM % 1024 ))
> > > }
> > >
> > > function do_work() {
> > >         while true; do
> > >                 echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
> > >                         >/sys/fs/selinux/context 2>/dev/null || true
> > >         done
> > > }
> > >
> > > do_work >/dev/null &
> > > do_work >/dev/null &
> > > do_work >/dev/null &
> > >
> > > while load_policy; do echo -n .; sleep 0.1; done
> > >
> > > kill %1
> > > kill %2
> > > kill %3
> > > ```
> > >
> > > Reported-by: Orion Poplawski <orion@nwra.com>
> > > Reported-by: Li Kun <hw.likun@huawei.com>
> > > Link: https://github.com/SELinuxProject/selinux-kernel/issues/38
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/ss/mls.c      |  23 +-
> > >  security/selinux/ss/mls.h      |   3 +-
> > >  security/selinux/ss/services.c | 120 +++----
> > >  security/selinux/ss/sidtab.c   | 556 ++++++++++++++++++++-------------
> > >  security/selinux/ss/sidtab.h   |  80 +++--
> > >  5 files changed, 459 insertions(+), 323 deletions(-)
> >
> > This also looks okay on quick inspection, and once again I know you
> > and Stephen have gone over this a lot, so I've merged it into
> > selinux/next.  However, I had to basically merge all of sidtab.c by
> > hand so please double check it still looks correct to you; I've gone
> > over it a few times and it looks like it matches, but it's easy to
> > miss something small.
>
> Thank you, I ran a diff with meld between the fixed and original
> versions and I can confirm there are only whitespace/comment
> differences.

Great, thanks for checking.

> Just one small nit though: I think you used a "bad" format fro the
> multiline comment in sidtab_convert(). Or at least Linus seems to hate
> it [1] :) OTOH, Documentation/process/coding-style.rst [2] still lists
> it as the preferred format for networking code... Not that it would
> bother me, but that e-mail has stuck in my mind and now I almost
> always notice the comment styles.

Part of this comes from my own personal preference, part comes from
starting working on Linux in the networking stack.  While I do care a
lot about line lengths, I don't care too much about multi-line comment
styles :)

-- 
paul moore
www.paul-moore.com
