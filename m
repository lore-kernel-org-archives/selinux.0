Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E62C2D0DB
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 15:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11162073A
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 15:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kRAT4hsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA1PpU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:45:20 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36851 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgA1PpU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jan 2020 10:45:20 -0500
Received: by mail-ed1-f65.google.com with SMTP id j17so15182251edp.3
        for <selinux@vger.kernel.org>; Tue, 28 Jan 2020 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85X9GHeVc4w641RnmcMhBwx63v1ZtyBTAYXogoHDpfQ=;
        b=kRAT4hsqeY1G2RqpIvDJyOlRh+9IPwSvzJ/6s1rAVlOpPhCcFoGOjdkvx+lJIou22U
         VVU9fyEDF9xoeFWlQgSJlLB9AFO7Po/f3AESKI1fIJY9o3c0h30JszruELCuVhqjQrtP
         Bqthr8KemN93kQvyjwLMqQ+8/rVK2HzSj8qfZaxP/DgDKEJYsTliVTBvKvehdOpBNq1s
         ZBjJIhTz5sJ7wJFoWUTveJIYUJ8+dsVYXACE71ZUPrvCJdqMBBGxFphYlq6Qu3QOPcys
         dny8kA8WYCOGSTZRVu2v3VG14MqSM6tlTPAh9mCYr2lJmWtW75jGexV3+LEwvf0f89P8
         wOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85X9GHeVc4w641RnmcMhBwx63v1ZtyBTAYXogoHDpfQ=;
        b=bqWztuvdXg5k+yoaw3Lm8Te8HtJ3LfarzBpmBh98BUmAIP4HsYUGeLXy5H320b1/i7
         wXlen/S3VjtmGRjRN45R2bf2lrG1kbaVc/5CZ5tVVbrsmySYTz+u45a/mjbOLsS5MLb9
         V+NeBjbkXCmrxqqw9OTO8KM92XHwBpPVg3uiRkC+TytioZYz3oWrOPRWXdyohgugPcta
         dPSKryEVo7Rg+v7pjq1DBSksr2iYF6RtvyiJhl3vvJ7ym8RoUVJzmMkAiMNKsev5YUka
         GnsaNhbe/g0HCne+r+a3dIxe85o5Idv5QPMngZFMt8+PgO2qfMNrElVTsvuUKrxLccsi
         b6sw==
X-Gm-Message-State: APjAAAVohxN+NQm13tPLMQtoYF7yKuz7Hld6RUv+n2oMTBNmrAAEB7ZJ
        X51OCQ3b2bzGaKgdpTEg68sGNXcuwOwP3nlTDwm/
X-Google-Smtp-Source: APXvYqxW2+QQA/TNUC70Hc/xwNtkpkqJcBLbjw6JiLi1VTz4Pd/sGtiHW49upzu1IC3E6RN0GzPW9dhwgOYYh7dUSj0=
X-Received: by 2002:a50:e108:: with SMTP id h8mr3668227edl.196.1580226317332;
 Tue, 28 Jan 2020 07:45:17 -0800 (PST)
MIME-Version: 1.0
References: <000000000000143de7059d2ba3e5@google.com> <000000000000fdbd71059d32a906@google.com>
 <CAHC9VhS_Bfywhp+6H03bY7LrQsBz+io672pSS0DpiZKFiz4L6g@mail.gmail.com>
 <850873b8-8a30-58e5-ad3c-86fb35296130@tycho.nsa.gov> <CAFqZXNuxFTKXVZDpPGCTHifn_AeCdVmP+PZrMDKDOYiLOWtsUA@mail.gmail.com>
In-Reply-To: <CAFqZXNuxFTKXVZDpPGCTHifn_AeCdVmP+PZrMDKDOYiLOWtsUA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Jan 2020 10:45:05 -0500
Message-ID: <CAHC9VhR9a1xEB3gXUkb4KRVkwXUAo-701ZumN2OTOmJ7r5ez8g@mail.gmail.com>
Subject: Re: possible deadlock in sidtab_sid2str_put
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>,
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

On Tue, Jan 28, 2020 at 9:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Jan 28, 2020 at 2:44 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 1/28/20 8:39 AM, Paul Moore wrote:
> > > On Tue, Jan 28, 2020 at 7:50 AM syzbot
> > > <syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com> wrote:
> > >>
> > >> syzbot has found a reproducer for the following crash on:
> > >>
> > >> HEAD commit:    b0be0eff Merge tag 'x86-pti-2020-01-28' of git://git.kerne..
> > >> git tree:       upstream
> > >> console output: https://syzkaller.appspot.com/x/log.txt?x=1432aebee00000
> > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=9784e57c96a92f20
> > >> dashboard link: https://syzkaller.appspot.com/bug?extid=61cba5033e2072d61806
> > >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10088e95e00000
> > >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fa605ee00000
> > >>
> > >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > >> Reported-by: syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com
> > >>
> > >> =====================================================
> > >> WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> > >> 5.5.0-syzkaller #0 Not tainted
> > >> -----------------------------------------------------
> > >> syz-executor305/10624 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
> > >> ffff888098c14098 (&(&s->cache_lock)->rlock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> > >> ffff888098c14098 (&(&s->cache_lock)->rlock){+.+.}, at: sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
> > >>
> > >> and this task is already holding:
> > >> ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> > >> ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> > >> which would create a new lock dependency:
> > >>   (&(&nf_conntrack_locks[i])->rlock){+.-.} -> (&(&s->cache_lock)->rlock){+.+.}
> > >>
> > >> but this new dependency connects a SOFTIRQ-irq-safe lock:
> > >>   (&(&nf_conntrack_locks[i])->rlock){+.-.}
> > >>
> > >> ... which became SOFTIRQ-irq-safe at:
> > >>    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
> > >>    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> > >>    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
> > >>    spin_lock include/linux/spinlock.h:338 [inline]
> > >>    nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> > >
> > > ...
> > >
> > >> to a SOFTIRQ-irq-unsafe lock:
> > >>   (&(&s->cache_lock)->rlock){+.+.}
> > >>
> > >> ... which became SOFTIRQ-irq-unsafe at:
> > >> ...
> > >>    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
> > >>    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> > >>    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
> > >>    spin_lock include/linux/spinlock.h:338 [inline]
> > >>    sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
> > >>    sidtab_sid2str_put+0xa0/0xc0 security/selinux/ss/sidtab.c:566
> > >>    sidtab_entry_to_string security/selinux/ss/services.c:1279 [inline]
> > >>    sidtab_entry_to_string+0xf2/0x110 security/selinux/ss/services.c:1266
> > >>    security_sid_to_context_core+0x2c6/0x3c0 security/selinux/ss/services.c:1361
> > >>    security_sid_to_context+0x34/0x40 security/selinux/ss/services.c:1384
> > >>    avc_audit_post_callback+0x102/0x790 security/selinux/avc.c:709
> > >>    common_lsm_audit+0x5ac/0x1e00 security/lsm_audit.c:466
> > >>    slow_avc_audit+0x16a/0x1f0 security/selinux/avc.c:782
> > >>    avc_audit security/selinux/include/avc.h:140 [inline]
> > >>    avc_has_perm+0x543/0x610 security/selinux/avc.c:1185
> > >>    inode_has_perm+0x1a8/0x230 security/selinux/hooks.c:1631
> > >>    selinux_mmap_file+0x10a/0x1d0 security/selinux/hooks.c:3701
> > >>    security_mmap_file+0xa4/0x1e0 security/security.c:1482
> > >>    vm_mmap_pgoff+0xf0/0x230 mm/util.c:502
> > >
> > > ...
> > >
> > >> other info that might help us debug this:
> > >>
> > >>   Possible interrupt unsafe locking scenario:
> > >>
> > >>         CPU0                    CPU1
> > >>         ----                    ----
> > >>    lock(&(&s->cache_lock)->rlock);
> > >>                                 local_irq_disable();
> > >>                                 lock(&(&nf_conntrack_locks[i])->rlock);
> > >>                                 lock(&(&s->cache_lock)->rlock);
> > >>    <Interrupt>
> > >>      lock(&(&nf_conntrack_locks[i])->rlock);
> > >>
> > >>   *** DEADLOCK ***
> > >>
> > >> 4 locks held by syz-executor305/10624:
> > >>   #0: ffffffff8c1acc68 (&table[i].mutex){+.+.}, at: nfnl_lock net/netfilter/nfnetlink.c:62 [inline]
> > >>   #0: ffffffff8c1acc68 (&table[i].mutex){+.+.}, at: nfnetlink_rcv_msg+0x9ee/0xfb0 net/netfilter/nfnetlink.c:224
> > >>   #1: ffff8880836415d8 (nlk_cb_mutex-NETFILTER){+.+.}, at: netlink_dump+0xe7/0xfb0 net/netlink/af_netlink.c:2199
> > >>   #2: ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> > >>   #2: ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> > >>   #3: ffffffff8b7df008 (&selinux_ss.policy_rwlock){.+.?}, at: security_sid_to_context_core+0x1ca/0x3c0 security/selinux/ss/services.c:1344
> > >
> > > I think this is going to be tricky to fix due to the differing
> > > contexts from which sidtab_sid2str_put() may be called.  We already
> > > have a check for !in_task() in sidtab_sid2str_put(), do we want to add
> > > a check for !in_serving_softirq() too?
> >
> > No, we should just use spin_lock_irqsave/unlock_irqrestore() IMHO, but
> > that then means we need to re-evaluate the performance gain of this change.
>
> I just tested a patch that switches to the IRQ-disabling locking under
> the systemd-journald scenario from [1] and the impact seems not that
> bad - the security_secid_to_secctx() function only takes up 3.18% of
> total run time vs. ~2% I reported in the original patch
> (d97bd23c2d7d). I'll post the patch shortly.
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1733259, i.e.:
>     cat /dev/urandom | base64 | logger &
>     timeout 30s perf record -p $(pidof systemd-journald) -a -g

I'm skeptical of the real world impact of disabling IRQs here,
although I'm not sure off the top of my head how we could manage a
cache (I'm thinking more about adding to, and evicting entries, from
the cache) without some form of locking.  Perhaps we look into per-cpu
caching?

-- 
paul moore
www.paul-moore.com
