Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F86C2D0DB
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7359E2173E
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 13:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diQxNiIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgA1Nvb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:51:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54174 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725852AbgA1Nvb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jan 2020 08:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580219489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xYwXigMHs9ibErg+EUOIdW+B0ZNS8vmFHtUCpU8Vzfc=;
        b=diQxNiIKcOHqccAVuWVqUdGnUfcIv8e5qkU1Svej2C/VJICbs6ns1EcxOWXsWuau/EsR7p
        sb/bi2hjYeSkkFDACZP5wxS6ecpSPC5ZUaH87uI1BCSbTaiLOooHWJMcI+rOW0KKQq+q/9
        L2+L8xq5si+zq7AXCH2GIMXbv49ufsg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-y8E3yn50MMqiNim3irseHQ-1; Tue, 28 Jan 2020 08:51:24 -0500
X-MC-Unique: y8E3yn50MMqiNim3irseHQ-1
Received: by mail-oi1-f197.google.com with SMTP id x75so3341543oix.3
        for <selinux@vger.kernel.org>; Tue, 28 Jan 2020 05:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYwXigMHs9ibErg+EUOIdW+B0ZNS8vmFHtUCpU8Vzfc=;
        b=nyXgDgsZI1UtUUhQuO0IkSTh/an4acqDgXulwtxdmpJfzeTAaz/I0cw+CVhI4WVYwb
         mNETWVah7+V0y5vqTQCszuzL0o48n5ngmp4HplbvCSbBCqBOTYrstKlnUxM7Aia9OJ+I
         Ndi6Ck8nWxZ0hmRprWo9tnNZFK8tzH2+5Ew4EzQdh51uiJl9xKtkZX9KAzrk+tp0R0q4
         oXbzeWtKmyEy+Damawt6qIA1mLc0v0fRqeTXgwwjZ3D/bBLWXBwGY+CZu2gcu/bMyPFC
         vnRfts7huE6rNu5UIVFrx4vR0AS55SxQR77VsQq+aZ+Co2nOmqgyOvXyelRpqZpJkap5
         FfgQ==
X-Gm-Message-State: APjAAAXsg4lYs37HinXgsmexkgcaIT9BtnMgSJ9RUOG3WimhHKLfJ76t
        1w+psRy2UYcZTWfUnPv3fFSjW7UXOHhHyYH2utgEFyr9aTIizhcQe8XE9DMCB9Fjgn6prrBFb/u
        ID30dEJT+cXqNgbMmgq1ucGzOmGxKk3sfRA==
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr17105160otn.22.1580219483345;
        Tue, 28 Jan 2020 05:51:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRvQI1gr/NFgoti/hhT7JXmXbeDFLVnhKG/bADBQcuYLCllybAUzHF3MW9GatHixvAK2KOIfLcBws0vdYKGo8=
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr17105143otn.22.1580219483054;
 Tue, 28 Jan 2020 05:51:23 -0800 (PST)
MIME-Version: 1.0
References: <000000000000143de7059d2ba3e5@google.com> <000000000000fdbd71059d32a906@google.com>
 <CAHC9VhS_Bfywhp+6H03bY7LrQsBz+io672pSS0DpiZKFiz4L6g@mail.gmail.com>
In-Reply-To: <CAHC9VhS_Bfywhp+6H03bY7LrQsBz+io672pSS0DpiZKFiz4L6g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 28 Jan 2020 14:51:11 +0100
Message-ID: <CAFqZXNsevSVXroCCBMaWHiVG9sh3Sb9ZDy3tYGDs=ONV8Mc25A@mail.gmail.com>
Subject: Re: possible deadlock in sidtab_sid2str_put
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jeff Vander Stoep <jeffv@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 28, 2020 at 2:39 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jan 28, 2020 at 7:50 AM syzbot
> <syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    b0be0eff Merge tag 'x86-pti-2020-01-28' of git://git.kerne..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1432aebee00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9784e57c96a92f20
> > dashboard link: https://syzkaller.appspot.com/bug?extid=61cba5033e2072d61806
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10088e95e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fa605ee00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com
> >
> > =====================================================
> > WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> > 5.5.0-syzkaller #0 Not tainted
> > -----------------------------------------------------
> > syz-executor305/10624 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
> > ffff888098c14098 (&(&s->cache_lock)->rlock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> > ffff888098c14098 (&(&s->cache_lock)->rlock){+.+.}, at: sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
> >
> > and this task is already holding:
> > ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> > ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> > which would create a new lock dependency:
> >  (&(&nf_conntrack_locks[i])->rlock){+.-.} -> (&(&s->cache_lock)->rlock){+.+.}
> >
> > but this new dependency connects a SOFTIRQ-irq-safe lock:
> >  (&(&nf_conntrack_locks[i])->rlock){+.-.}
> >
> > ... which became SOFTIRQ-irq-safe at:
> >   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
> >   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
> >   spin_lock include/linux/spinlock.h:338 [inline]
> >   nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
>
> ...
>
> > to a SOFTIRQ-irq-unsafe lock:
> >  (&(&s->cache_lock)->rlock){+.+.}
> >
> > ... which became SOFTIRQ-irq-unsafe at:
> > ...
> >   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
> >   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
> >   spin_lock include/linux/spinlock.h:338 [inline]
> >   sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
> >   sidtab_sid2str_put+0xa0/0xc0 security/selinux/ss/sidtab.c:566
> >   sidtab_entry_to_string security/selinux/ss/services.c:1279 [inline]
> >   sidtab_entry_to_string+0xf2/0x110 security/selinux/ss/services.c:1266
> >   security_sid_to_context_core+0x2c6/0x3c0 security/selinux/ss/services.c:1361
> >   security_sid_to_context+0x34/0x40 security/selinux/ss/services.c:1384
> >   avc_audit_post_callback+0x102/0x790 security/selinux/avc.c:709
> >   common_lsm_audit+0x5ac/0x1e00 security/lsm_audit.c:466
> >   slow_avc_audit+0x16a/0x1f0 security/selinux/avc.c:782
> >   avc_audit security/selinux/include/avc.h:140 [inline]
> >   avc_has_perm+0x543/0x610 security/selinux/avc.c:1185
> >   inode_has_perm+0x1a8/0x230 security/selinux/hooks.c:1631
> >   selinux_mmap_file+0x10a/0x1d0 security/selinux/hooks.c:3701
> >   security_mmap_file+0xa4/0x1e0 security/security.c:1482
> >   vm_mmap_pgoff+0xf0/0x230 mm/util.c:502
>
> ...
>
> > other info that might help us debug this:
> >
> >  Possible interrupt unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&(&s->cache_lock)->rlock);
> >                                local_irq_disable();
> >                                lock(&(&nf_conntrack_locks[i])->rlock);
> >                                lock(&(&s->cache_lock)->rlock);
> >   <Interrupt>
> >     lock(&(&nf_conntrack_locks[i])->rlock);
> >
> >  *** DEADLOCK ***
> >
> > 4 locks held by syz-executor305/10624:
> >  #0: ffffffff8c1acc68 (&table[i].mutex){+.+.}, at: nfnl_lock net/netfilter/nfnetlink.c:62 [inline]
> >  #0: ffffffff8c1acc68 (&table[i].mutex){+.+.}, at: nfnetlink_rcv_msg+0x9ee/0xfb0 net/netfilter/nfnetlink.c:224
> >  #1: ffff8880836415d8 (nlk_cb_mutex-NETFILTER){+.+.}, at: netlink_dump+0xe7/0xfb0 net/netlink/af_netlink.c:2199
> >  #2: ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> >  #2: ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> >  #3: ffffffff8b7df008 (&selinux_ss.policy_rwlock){.+.?}, at: security_sid_to_context_core+0x1ca/0x3c0 security/selinux/ss/services.c:1344
>
> I think this is going to be tricky to fix due to the differing
> contexts from which sidtab_sid2str_put() may be called.  We already
> have a check for !in_task() in sidtab_sid2str_put(), do we want to add
> a check for !in_serving_softirq() too?

I don't think that is going to fix it. The issue here is that an
interrupt may happen while we are holding the lock and in that
interrupt we try to take some other lock, which another thread has
taken before the cache lock... I'm afraid using the irqsave/irqrestore
locking is the only possible fix here... (Either that or giving up on
the proper least-recently-used logic.)

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

