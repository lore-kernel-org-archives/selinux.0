Return-Path: <SRS0=r+0f=YV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67959CA9EC0
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 18:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3683D20862
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 18:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbfJ1SJf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:09:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11153 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730690AbfJ1SJf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 28 Oct 2019 14:09:35 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC7767BDA2
        for <selinux@vger.kernel.org>; Mon, 28 Oct 2019 18:09:34 +0000 (UTC)
Received: by mail-oi1-f200.google.com with SMTP id 19so5168473oii.2
        for <selinux@vger.kernel.org>; Mon, 28 Oct 2019 11:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmpYlgO4jJJdIOS80eUEoUydMPGOLR/YN0+mg+F3JtI=;
        b=NqwYfYTzriMTbe6OZH7e7le2qgE5ojkT6vJDFPNvgrHs/OT1FA58yVY7BsO36mOcOT
         /Gb+idPtCjwsIUXnZyyZgRLJYDlebo6rQIk+P6Yo0DUX7FbLoJpo+jM4yG+iwRpahf8D
         v5jryuJPTp6V60K6lSWmeCre0qKAUiClErmCXHz8iQBE2lCuYzuAGQYEaLN6957g5eob
         xtMSkYbCB7j02RsmSvZqfRT0TOA/VyRwuRfEHVLc2HP/GTQGmd2K39K/YPcDmALxzx8g
         SB8fXQFDJajkb9PtkatwRoNDr7BywyrMaEzynfni/Q9BsUtRgw/mnll2iThhw316Gxl3
         gHVQ==
X-Gm-Message-State: APjAAAWGVLbJWj5T6WFojDu0//bLG7P6tmHSMvIrc+eDCQ0VtwfiXj2s
        0hiI+m3XiBDWv8HHrZCSmazrcr7csR4o3UU0DoqtvB+5kJ2q+8b4t2CXYQhpQgGmGbXMdQb7c88
        C6/zET5bb/rOhh8lb19sf1KvjEOoiBEdJBA==
X-Received: by 2002:a9d:8a5:: with SMTP id 34mr14475030otf.197.1572286174067;
        Mon, 28 Oct 2019 11:09:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwwusy9A+gcQ4udCshlJrpMTJ9Tt4Qw3JNPosOiak4bPC84++pBmhrqDTG+nbj2aALqy8IhHrPJlW4FhT5CXJg=
X-Received: by 2002:a9d:8a5:: with SMTP id 34mr14475007otf.197.1572286173605;
 Mon, 28 Oct 2019 11:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191025145535.18474-1-omosnace@redhat.com> <28a70500-5154-3fc7-b4f5-fa4feac7245b@tycho.nsa.gov>
In-Reply-To: <28a70500-5154-3fc7-b4f5-fa4feac7245b@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 28 Oct 2019 19:09:22 +0100
Message-ID: <CAFqZXNvdE_7aQvN=FxYih7_uaGxhZ64_yMn=6DuPVTpuAvjfJA@mail.gmail.com>
Subject: Re: [PATCH] selinux: cache the SID -> context string translation
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 28, 2019 at 6:46 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/25/19 10:55 AM, Ondrej Mosnacek wrote:
> > Translating a context struct to string can be quite slow, especially if
> > the context has a lot of category bits set. This can cause quite
> > noticeable performance impact in situations where the translation needs
> > to be done repeatedly. A common example is a UNIX datagram socket with
> > the SO_PASSSEC option enabled, which is used e.g. by systemd-journald
> > when receiving log messages via datagram socket. This scenario can be
> > reproduced with:
> >
> >      cat /dev/urandom | base64 | logger &
> >      timeout 30s perf record -p $(pidof systemd-journald) -a -g
> >      kill %1
> >      perf report -g none --pretty raw | grep security_secid_to_secctx
> >
> > Before the caching introduced by this patch, computing the context
> > string (security_secid_to_secctx() function) takes up ~65% of
> > systemd-journald's CPU time (assuming a context with 1024 categories
> > set and Fedora x86_64 release kernel configs). After this patch
> > (assuming near-perfect cache hit ratio) this overhead is reduced to just
> > ~2%.
> >
> > This patch addresses the issue by caching a certain number (compile-time
> > configurable) of recently used context strings to speed up repeated
> > translations of the same context, while using only a small amount of
> > memory.
> >
> > The cache is integrated into the existing sidtab table by adding a field
> > to each entry, which when not NULL contains an RCU-protected pointer to
> > a cache entry containing the cached string. The cache entries are kept
> > in a linked list sorted according to how recently they were used. On a
> > cache miss when the cache is full, the least recently used entry is
> > removed to make space for the new entry.
> >
> > The patch migrates security_sid_to_context_core() to use the cache (also
> > a few other functions where it was possible without too much fuss, but
> > these mostly use the translation for logging in case of error, which is
> > rare).
>
> Running selinux-testsuite with lock debugging enabled,
>
> <4>[  237.722577]
> <4>[  237.722581] ================================
> <4>[  237.722582] WARNING: inconsistent lock state
> <4>[  237.722585] 5.4.0-rc1+ #45 Not tainted
> <4>[  237.722586] --------------------------------
> <4>[  237.722588] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> <4>[  237.722590] client/4460 [HC0[0]:SC1[1]:HE1:SE0] takes:
> <4>[  237.722592] ffff888703331198 (&(&s->cache_lock)->rlock){+.?.}, at:
> sidtab_sid2str_put.part.0+0x35/0x2f0
> <4>[  237.722599] {SOFTIRQ-ON-W} state was registered at:
> <4>[  237.722603]   lock_acquire+0xe5/0x210
> <4>[  237.722606]   _raw_spin_lock+0x2c/0x40
> <4>[  237.722608]   sidtab_sid2str_put.part.0+0x35/0x2f0
> <4>[  237.722611]   sidtab_entry_to_string+0x86/0xa0
> <4>[  237.722613]   security_sid_to_context_core.isra.0+0x147/0x190
> <4>[  237.722615]   security_sid_to_context+0x23/0x30
> <4>[  237.722618]   selinux_getprocattr+0x1f5/0x3f0
> <4>[  237.722621]   proc_pid_attr_read+0xdf/0x170
> <4>[  237.722623]   vfs_read+0xf3/0x1e0
> <4>[  237.722625]   ksys_read+0xc3/0x160
> <4>[  237.722628]   do_syscall_64+0x74/0xd0
> <4>[  237.722630]   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> <4>[  237.722632] irq event stamp: 10362
> <4>[  237.722635] hardirqs last  enabled at (10362):
> [<ffffffff9f10badb>] _raw_write_unlock_irqrestore+0x4b/0x60
> <4>[  237.722638] hardirqs last disabled at (10361):
> [<ffffffff9f10bd41>] _raw_write_lock_irqsave+0x21/0x54
> <4>[  237.722641] softirqs last  enabled at (10310):
> [<ffffffff9eee6ea9>] ip_finish_output2+0x3f9/0x1070
> <4>[  237.722644] softirqs last disabled at (10311):
> [<ffffffff9f20107a>] do_softirq_own_stack+0x2a/0x40
> <4>[  237.722645]
> <4>[  237.722645] other info that might help us debug this:
> <4>[  237.722647]  Possible unsafe locking scenario:
> <4>[  237.722647]
> <4>[  237.722648]        CPU0
> <4>[  237.722650]        ----
> <4>[  237.722651]   lock(&(&s->cache_lock)->rlock);
> <4>[  237.722654]   <Interrupt>
> <4>[  237.722657]     lock(&(&s->cache_lock)->rlock);
> <4>[  237.722660]
> <4>[  237.722660]  *** DEADLOCK ***
> <4>[  237.722660]
> <4>[  237.722662] 5 locks held by client/4460:
> <4>[  237.722664]  #0: ffff88870a0a6650 (sk_lock-AF_INET){+.+.}, at:
> inet_stream_connect+0x30/0x70
> <4>[  237.722686]  #1: ffffffffa011e8e0 (rcu_read_lock){....}, at:
> __ip_queue_xmit+0x5/0x9e0
> <4>[  237.722690]  #2: ffffffffa011e8e0 (rcu_read_lock){....}, at:
> process_backlog+0x8d/0x320
> <4>[  237.722695]  #3: ffffffffa011e8e0 (rcu_read_lock){....}, at:
> ip_local_deliver_finish+0x65/0x190
> <4>[  237.722699]  #4: ffffffffa2023128
> (&selinux_ss.policy_rwlock){.+.?}, at:
> security_sid_to_context_core.isra.0+0xde/0x190
> <4>[  237.722703]
> <4>[  237.722703] stack backtrace:
> <4>[  237.722707] CPU: 1 PID: 4460 Comm: client Not tainted 5.4.0-rc1+ #45
> <4>[  237.722708] Hardware name: Dell Inc. OptiPlex 7050/0NW6H5, BIOS
> 1.8.3 03/23/2018
> <4>[  237.722710] Call Trace:
> <4>[  237.722712]  <IRQ>
> <4>[  237.722716]  dump_stack+0x9a/0xf0
> <4>[  237.722719]  mark_lock+0x7d9/0x9c0
> <4>[  237.722722]  ? check_usage_backwards+0x230/0x230
> <4>[  237.722725]  __lock_acquire+0xb5b/0x2600
> <4>[  237.722730]  ? create_object+0x387/0x560
> <4>[  237.722733]  ? lockdep_hardirqs_on+0x260/0x260
> <4>[  237.722736]  ? mark_lock+0xac/0x9c0
> <4>[  237.722738]  ? match_held_lock+0x2e/0x240
> <4>[  237.722741]  ? match_held_lock+0x1b/0x240
> <4>[  237.722744]  lock_acquire+0xe5/0x210
> <4>[  237.722747]  ? sidtab_sid2str_put.part.0+0x35/0x2f0
> <4>[  237.722751]  _raw_spin_lock+0x2c/0x40
> <4>[  237.722753]  ? sidtab_sid2str_put.part.0+0x35/0x2f0
> <4>[  237.722756]  sidtab_sid2str_put.part.0+0x35/0x2f0
> <4>[  237.722760]  sidtab_sid2str_get+0x161/0x237
> <4>[  237.722763]  sidtab_entry_to_string+0x31/0xa0
> <4>[  237.722766]  security_sid_to_context_core.isra.0+0x147/0x190
> <4>[  237.722770]  ? avc_audit_pre_callback+0x120/0x120
> <4>[  237.722772]  security_sid_to_context+0x23/0x30
> <4>[  237.722774]  avc_audit_post_callback+0xb5/0x360
> <4>[  237.722777]  ? avc_audit_pre_callback+0x120/0x120
> <4>[  237.722782]  ? avc_audit_pre_callback+0x120/0x120
> <4>[  237.722784]  common_lsm_audit+0x22d/0xd10
> <4>[  237.722787]  ? mark_lock+0xac/0x9c0
> <4>[  237.722790]  ? ipv6_skb_to_auditdata+0x380/0x380
> <4>[  237.722793]  ? __lock_acquire+0x5e0/0x2600
> <4>[  237.722797]  ? match_held_lock+0x1b/0x240
> <4>[  237.722800]  slow_avc_audit+0x14a/0x1c0
> <4>[  237.722803]  ? avc_get_hash_stats+0x1b0/0x1b0
> <4>[  237.722806]  ? find_held_lock+0x85/0xa0
> <4>[  237.722808]  ? avc_has_perm+0x1ae/0x370
> <4>[  237.722812]  ? lockdep_hardirqs_on+0x182/0x260
> <4>[  237.722815]  ? avc_denied+0xd4/0xf0
> <4>[  237.722818]  avc_has_perm+0x316/0x370
> <4>[  237.722821]  ? avc_has_perm_noaudit+0x300/0x300
> <4>[  237.722824]  ? sel_netnode_sid+0xbc/0x500
> <4>[  237.722829]  selinux_socket_sock_rcv_skb+0x301/0x370
> <4>[  237.722832]  ? selinux_sock_rcv_skb_compat+0x1f0/0x1f0
> <4>[  237.722836]  ? mark_lock+0xac/0x9c0
> <4>[  237.722839]  ? inet_ehashfn+0x80/0x170
> <4>[  237.722842]  ? inet_ehash_locks_alloc+0x120/0x120
> <4>[  237.722846]  security_sock_rcv_skb+0x45/0x60
> <4>[  237.722849]  sk_filter_trim_cap+0x9b/0x500
> <4>[  237.722852]  ? tcp_parse_md5sig_option+0x65/0x90
> <4>[  237.722855]  ? bpf_get_listener_sock+0x70/0x70
> <4>[  237.722858]  ? tcp_v4_reqsk_send_ack+0x1a0/0x1a0
> <4>[  237.722862]  tcp_v4_rcv+0x1313/0x15f0
> <4>[  237.722867]  ? tcp_v4_early_demux+0x2e0/0x2e0
> <4>[  237.722886]  ? rcu_read_lock_held+0xa1/0xb0
> <4>[  237.722889]  ? rcu_read_lock_sched_held+0xd0/0xd0
> <4>[  237.722892]  ? lock_acquire+0xe5/0x210
> <4>[  237.722895]  ip_protocol_deliver_rcu+0x3e/0x360
> <4>[  237.722899]  ip_local_deliver_finish+0xec/0x190
> <4>[  237.722902]  ip_local_deliver+0x252/0x300
> <4>[  237.722905]  ? ip_local_deliver_finish+0x190/0x190
> <4>[  237.722908]  ? ip_protocol_deliver_rcu+0x360/0x360
> <4>[  237.722912]  ip_rcv+0x1fe/0x2a0
> <4>[  237.722915]  ? ip_local_deliver+0x300/0x300
> <4>[  237.722919]  ? ip_rcv_finish_core.isra.0+0x870/0x870
> <4>[  237.722922]  ? lockdep_hardirqs_on+0x260/0x260
> <4>[  237.722925]  ? ip_local_deliver+0x300/0x300
> <4>[  237.722928]  __netif_receive_skb_one_core+0x109/0x120
> <4>[  237.722931]  ? __netif_receive_skb_core+0x16f0/0x16f0
> <4>[  237.722933]  ? lock_acquire+0xe5/0x210
> <4>[  237.722936]  ? process_backlog+0x8d/0x320
> <4>[  237.722940]  process_backlog+0x126/0x320
> <4>[  237.722943]  net_rx_action+0x220/0x670
> <4>[  237.722947]  ? napi_busy_loop+0x520/0x520
> <4>[  237.722950]  ? rcu_read_lock_bh_held+0xb0/0xb0
> <4>[  237.722953]  ? mark_held_locks+0x44/0x90
> <4>[  237.722956]  __do_softirq+0x130/0x5c1
> <4>[  237.722961]  do_softirq_own_stack+0x2a/0x40
> <4>[  237.722963]  </IRQ>
> <4>[  237.722965]  ? ip_finish_output2+0x3f9/0x1070
> <4>[  237.722968]  do_softirq.part.0+0x60/0x70
> <4>[  237.722971]  __local_bh_enable_ip+0x101/0x110
> <4>[  237.722974]  ip_finish_output2+0x422/0x1070
> <4>[  237.722978]  ? ip_frag_next+0x330/0x330
> <4>[  237.722981]  ? ipv4_mtu+0xcf/0x150
> <4>[  237.722985]  ? ip_output+0x119/0x340
> <4>[  237.722987]  ip_output+0x119/0x340
> <4>[  237.722991]  ? ip_mc_output+0x7f0/0x7f0
> <4>[  237.722994]  ? __ip_finish_output+0x480/0x480
> <4>[  237.722998]  __ip_queue_xmit+0x349/0x9e0
> <4>[  237.723002]  ? tcp_options_write+0xce/0x360
> <4>[  237.723005]  __tcp_transmit_skb+0xaca/0x1470
> <4>[  237.723010]  ? __tcp_select_window+0x350/0x350
> <4>[  237.723013]  ? rcu_read_lock_sched_held+0xd0/0xd0
> <4>[  237.723016]  ? rb_insert_color+0x26b/0x3e0
> <4>[  237.723020]  tcp_connect+0x1473/0x1a00
> <4>[  237.723025]  ? __tcp_transmit_skb+0x1470/0x1470
> <4>[  237.723027]  ? siphash_1u64+0x7/0x210
> <4>[  237.723031]  ? secure_tcpv6_seq+0x1a0/0x1a0
> <4>[  237.723034]  tcp_v4_connect+0x88c/0xac0
> <4>[  237.723039]  ? tcp_v4_parse_md5_keys+0x180/0x180
> <4>[  237.723043]  __inet_stream_connect+0x1ba/0x620
> <4>[  237.723047]  ? ipv4_mib_init_net+0x2b0/0x2b0
> <4>[  237.723050]  ? lock_acquire+0xe5/0x210
> <4>[  237.723053]  ? __inet_stream_connect+0x620/0x620
> <4>[  237.723055]  ? mark_held_locks+0x65/0x90
> <4>[  237.723058]  ? __local_bh_enable_ip+0x9d/0x110
> <4>[  237.723061]  ? __inet_stream_connect+0x620/0x620
> <4>[  237.723064]  inet_stream_connect+0x44/0x70
> <4>[  237.723067]  __sys_connect+0x16f/0x1b0
> <4>[  237.723070]  ? __ia32_sys_accept+0x50/0x50
> <4>[  237.723074]  ? ktime_get_coarse_real_ts64+0xb1/0xf0
> <4>[  237.723077]  ? syscall_trace_enter+0x235/0x5f0
> <4>[  237.723081]  ? audit_filter_syscall.part.0.constprop.0+0x2c0/0x2c0
> <4>[  237.723084]  ? rcu_read_lock_sched_held+0xd0/0xd0
> <4>[  237.723087]  ? exit_to_usermode_loop+0x120/0x120
> <4>[  237.723089]  ? unroll_tree_refs+0x166/0x1c0
> <4>[  237.723112]  ? kfree+0x2e6/0x350
> <4>[  237.723114]  ? mark_held_locks+0x24/0x90
> <4>[  237.723117]  ? trace_hardirqs_on_thunk+0x1a/0x20
> <4>[  237.723121]  __x64_sys_connect+0x3e/0x50
> <4>[  237.723124]  do_syscall_64+0x74/0xd0
> <4>[  237.723127]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> <4>[  237.723130] RIP: 0033:0x7f82c00a55b8
> <4>[  237.723133] Code: 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00
> 00 90 f3 0f 1e fa 48 8d 05 65 80 0c 00 8b 00 85 c0 75 17 b8 2a 00 00 00
> 0f 05 <48> 3d 00 f0 ff ff 77 50 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 54
> <4>[  237.723135] RSP: 002b:00007ffefad9fcb8 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002a
> <4>[  237.723138] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007f82c00a55b8
> <4>[  237.723139] RDX: 0000000000000010 RSI: 000000000216a2b0 RDI:
> 0000000000000003
> <4>[  237.723141] RBP: 00007ffefad9fe50 R08: 0000000000000010 R09:
> 0000000000000000
> <4>[  237.723143] R10: 00000000004005a0 R11: 0000000000000246 R12:
> 0000000000401130
> <4>[  237.723145] R13: 00007ffefad9ff30 R14: 0000000000000000 R15:
> 0000000000000000

Ah, stupid me didn't test with the debug kernel variant... Looks like
I'll need to disable interrupts when holding the cache_lock after
all... I mistakenly thought it could be avoided in this case.

Thanks for testing!

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
