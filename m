Return-Path: <SRS0=bAF8=OP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F22CC04EB9
	for <selinux@archiver.kernel.org>; Thu,  6 Dec 2018 09:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AA020892
	for <selinux@archiver.kernel.org>; Thu,  6 Dec 2018 09:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AA020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeLFJgx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:36:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34813 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFJgx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Dec 2018 04:36:53 -0500
Received: by mail-oi1-f195.google.com with SMTP id h25so20179791oig.1
        for <selinux@vger.kernel.org>; Thu, 06 Dec 2018 01:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufJ4wJxDRGsHyDn03fCdpXFFIofbj3LFBwuGLeAT8ao=;
        b=Wv6NW1JhQGVIuGPvmcgsHHpQw9/51yZ3GJZBXgxfhgfPdxdFkpWHZaZ7oA/H8wqtFG
         pPWmR0/shTHFZsTZGv2SBus8pnrjpE9IllIbqoVf//cJZeU/VpHzjNP8Gn2kDAobsnCw
         56A8nEm36X+N1vIsNZDOnLzrH0kuynStVLjNWBpX3EyS4v56LYGM36K4WMWxeFjgo098
         dnXGBr7V5oVDaRpNbgxCvYcgyPMFaBp82BI8EuJHPrh8As4kV/sAvwQ76U/5Mjrt/uCi
         MhNjzh7ClwpamPPc/j4EMyVi8uO1oCD+JtHX9jf1MFZjMu2kesiNS0TdPofshiQeUZxN
         aKyQ==
X-Gm-Message-State: AA+aEWYcqfTdVeE53g7UJ9A9TvQdfpmU3jHkxi0NfwdSHhUgXwWQ0yz9
        Ud9vyg3NcEaRbIwdXhJ4mdTY4qYo/wCf/tcQZ8Lj3Q==
X-Google-Smtp-Source: AFSGD/UrUkheE2Tlb/HYoR8YWOI3awlFriwB5b/VHHR0qd3Nqjhr433CtuSS45bO68S4Xxf+suzdFJkSF+pfPwmBKb4=
X-Received: by 2002:aca:50cf:: with SMTP id e198mr17785974oib.343.1544089012590;
 Thu, 06 Dec 2018 01:36:52 -0800 (PST)
MIME-Version: 1.0
References: <20181130152408.24513-1-omosnace@redhat.com> <20181130152408.24513-3-omosnace@redhat.com>
 <CAHC9VhR8P0+1emYZMAJ+6y6ga9Za_AJ0cw0g0QEViv5NoBXfBw@mail.gmail.com>
In-Reply-To: <CAHC9VhR8P0+1emYZMAJ+6y6ga9Za_AJ0cw0g0QEViv5NoBXfBw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 6 Dec 2018 10:36:41 +0100
Message-ID: <CAFqZXNvhYR1WbRv+Q8J+ufBazSxPZ2HS3FRQHOpAgZncjWwd9g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/2] selinux: overhaul sidtab to fix bug and
 improve performance
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 5, 2018 at 11:53 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Nov 30, 2018 at 10:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Before this patch, during a policy reload the sidtab would become frozen
> > and trying to map a new context to SID would be unable to add a new
> > entry to sidtab and fail with -ENOMEM.
> >
> > Such failures are usually propagated into userspace, which has no way of
> > distignuishing them from actual allocation failures and thus doesn't
> > handle them gracefully. Such situation can be triggered e.g. by the
> > following reproducer:
> >
> >     while true; do load_policy; echo -n .; sleep 0.1; done &
> >     for (( i = 0; i < 1024; i++ )); do
> >         runcon -l s0:c$i echo -n x || break
> >         # or:
> >         # chcon -l s0:c$i <some_file> || break
> >     done
> >
> > This patch overhauls the sidtab so it doesn't need to be frozen during
> > policy reload, thus solving the above problem.
> >
> > The new SID table leverages the fact that SIDs are allocated
> > sequentially and are never invalidated and stores them in linear buckets
> > indexed by a tree structure. This brings several advantages:
> >   1. Fast SID -> context lookup - this lookup can now be done in
> >      logarithmic time complexity (usually in less than 4 array lookups)
> >      and can still be done safely without locking.
> >   2. No need to re-search the whole table on reverse lookup miss - after
> >      acquiring the spinlock only the newly added entries need to be
> >      searched, which means that reverse lookups that end up inserting a
> >      new entry are now about twice as fast.
> >   3. No need to freeze sidtab during policy reload - it is now possible
> >      to handle insertion of new entries even during sidtab conversion.
> >
> > The tree structure of the new sidtab is able to grow automatically to up
> > to about 2^31 entries (at which point it should not have more than about
> > 4 tree levels). The old sidtab had a theoretical capacity of almost 2^32
> > entries, but half of that is still more than enough since by that point
> > the reverse table lookups would become unusably slow anyway...
> >
> > The number of entries per tree node is selected automatically so that
> > each node fits into a single page, which should be the easiest size for
> > kmalloc() to handle.
> >
> > Note that the cache for reverse lookup is preserved with equivalent
> > logic. The only difference is that instead of storing pointers to the
> > hash table nodes it stores just the indices of the cached entries.
> >
> > The new cache ensures that the indices are loaded/stored atomically, but
> > it still has the drawback that concurrent cache updates may mess up the
> > contents of the cache. Such situation however only reduces its
> > effectivity, not the correctness of lookups.
> >
> > Tested by selinux-testsuite and thoroughly tortured by this simple
> > stress test:
> > ```
> > function rand_cat() {
> >         echo $(( $RANDOM % 1024 ))
> > }
> >
> > function do_work() {
> >         while true; do
> >                 echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
> >                         >/sys/fs/selinux/context 2>/dev/null || true
> >         done
> > }
> >
> > do_work >/dev/null &
> > do_work >/dev/null &
> > do_work >/dev/null &
> >
> > while load_policy; do echo -n .; sleep 0.1; done
> >
> > kill %1
> > kill %2
> > kill %3
> > ```
> >
> > Reported-by: Orion Poplawski <orion@nwra.com>
> > Reported-by: Li Kun <hw.likun@huawei.com>
> > Link: https://github.com/SELinuxProject/selinux-kernel/issues/38
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/mls.c      |  23 +-
> >  security/selinux/ss/mls.h      |   3 +-
> >  security/selinux/ss/services.c | 120 +++----
> >  security/selinux/ss/sidtab.c   | 556 ++++++++++++++++++++-------------
> >  security/selinux/ss/sidtab.h   |  80 +++--
> >  5 files changed, 459 insertions(+), 323 deletions(-)
>
> This also looks okay on quick inspection, and once again I know you
> and Stephen have gone over this a lot, so I've merged it into
> selinux/next.  However, I had to basically merge all of sidtab.c by
> hand so please double check it still looks correct to you; I've gone
> over it a few times and it looks like it matches, but it's easy to
> miss something small.

Thank you, I ran a diff with meld between the fixed and original
versions and I can confirm there are only whitespace/comment
differences.

Just one small nit though: I think you used a "bad" format fro the
multiline comment in sidtab_convert(). Or at least Linus seems to hate
it [1] :) OTOH, Documentation/process/coding-style.rst [2] still lists
it as the preferred format for networking code... Not that it would
bother me, but that e-mail has stuck in my mind and now I almost
always notice the comment styles.

[1] https://lkml.org/lkml/2016/7/8/625
[2] https://www.kernel.org/doc/html/v4.19/process/coding-style.html#commenting

>
> Finally, one more reminder to use checkpatch on everything you submit.
> There were a number of errors in this patch too.
>
> [...]

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
