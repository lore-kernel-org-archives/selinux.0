Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E76C33CB3
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 04:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB8422522
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 04:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA1E1K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 23:27:10 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:41781 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1E1K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jan 2020 23:27:10 -0500
Received: by mail-io1-f72.google.com with SMTP id z201so7012197iof.8
        for <selinux@vger.kernel.org>; Mon, 27 Jan 2020 20:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=p+rB1dZgkwqfEmd+2Nzrd3XdbBvZlV/M6qDLNM8VIIA=;
        b=g4gZVJpejCqHBKcaOuwQLpYEgEaWFIZr+w+AmPeMrNrqduRs2pCq9RNgHecFGBc8fw
         x6QUDYj6p+hR8vfrsmagaLczxfQvkBHZyZCUoAnj7iaKEfAqb7HHx3UFCsBK93226e6p
         FUu14A+izR0ZdBzdNMvTvVxTUiM8+YAz0XUxdZNc/8okdRumGwjegITFhaf4pbMLCtFO
         DuArMNyET8oNddwh49AUYwEmSSRUMHwH0LKyCtBPc3+lvOeZuocMuDLkqxV1urMZd4AB
         p8fUZv8sbcY3pOOi0Oc7RasI9SYbNKjPPbW1szntHO3kW8aApJ7iWCyXRSWUblibm47Q
         UUww==
X-Gm-Message-State: APjAAAU6/QBim0sv0XwuABesS80xUbFOWyiYfHqas22mzaApcPpsdHwT
        P1cu5jUttvWjroaalNMatOeDHqJYMIcdwhAv7O+xHmoZzhma
X-Google-Smtp-Source: APXvYqztJ4oBsJRoUATG8s4x1XvITJEwgVUJOyBwugK0MGqhbyEFY41H+53bobTJkmbDsoHVrjRB1Ahf/+9mjK3jcpuDJ4w1pD61
MIME-Version: 1.0
X-Received: by 2002:a02:3946:: with SMTP id w6mr16386407jae.9.1580185628718;
 Mon, 27 Jan 2020 20:27:08 -0800 (PST)
Date:   Mon, 27 Jan 2020 20:27:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000143de7059d2ba3e5@google.com>
Subject: possible deadlock in sidtab_sid2str_put
From:   syzbot <syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com>
To:     eparis@parisplace.org, jeffv@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, omosnace@redhat.com,
        paul@paul-moore.com, paulmck@kernel.org, sds@tycho.nsa.gov,
        selinux@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b0be0eff Merge tag 'x86-pti-2020-01-28' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15232735e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9784e57c96a92f20
dashboard link: https://syzkaller.appspot.com/bug?extid=61cba5033e2072d61806
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.5.0-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.3/20867 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
ffff888022b68098 (&(&s->cache_lock)->rlock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
ffff888022b68098 (&(&s->cache_lock)->rlock){+.+.}, at: sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533

and this task is already holding:
ffffffff898605d8 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
ffffffff898605d8 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
which would create a new lock dependency:
 (&(&nf_conntrack_locks[i])->rlock){+.-.} -> (&(&s->cache_lock)->rlock){+.+.}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&(&nf_conntrack_locks[i])->rlock){+.-.}

... which became SOFTIRQ-irq-safe at:
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:338 [inline]
  nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
  nf_conntrack_double_lock.isra.0+0xac/0x100 net/netfilter/nf_conntrack_core.c:134
  __nf_conntrack_confirm+0x252/0x1710 net/netfilter/nf_conntrack_core.c:963
  nf_conntrack_confirm include/net/netfilter/nf_conntrack_core.h:63 [inline]
  nf_confirm+0x3e7/0x4d0 net/netfilter/nf_conntrack_proto.c:154
  ipv4_confirm+0x14c/0x240 net/netfilter/nf_conntrack_proto.c:169
  nf_hook_entry_hookfn include/linux/netfilter.h:135 [inline]
  nf_hook_slow+0xbc/0x1e0 net/netfilter/core.c:512
  nf_hook include/linux/netfilter.h:262 [inline]
  NF_HOOK include/linux/netfilter.h:305 [inline]
  ip_local_deliver+0x352/0x520 net/ipv4/ip_input.c:252
  dst_input include/net/dst.h:442 [inline]
  ip_sublist_rcv_finish+0x9b/0x2d0 net/ipv4/ip_input.c:549
  ip_list_rcv_finish net/ipv4/ip_input.c:599 [inline]
  ip_sublist_rcv+0x5a6/0xa20 net/ipv4/ip_input.c:607
  ip_list_rcv+0x37e/0x4bf net/ipv4/ip_input.c:642
  __netif_receive_skb_list_ptype net/core/dev.c:5193 [inline]
  __netif_receive_skb_list_core+0x5fc/0x9d0 net/core/dev.c:5241
  __netif_receive_skb_list net/core/dev.c:5293 [inline]
  netif_receive_skb_list_internal+0x7eb/0xe50 net/core/dev.c:5388
  gro_normal_list.part.0+0x1e/0xb0 net/core/dev.c:5499
  gro_normal_list net/core/dev.c:6232 [inline]
  napi_complete_done+0x208/0x510 net/core/dev.c:6220
  virtqueue_napi_complete+0x31/0xa0 drivers/net/virtio_net.c:329
  virtnet_poll+0xbad/0xe90 drivers/net/virtio_net.c:1432
  napi_poll net/core/dev.c:6534 [inline]
  net_rx_action+0x508/0x1120 net/core/dev.c:6602
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:603 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:595
  smpboot_thread_fn+0x6a3/0xa40 kernel/smpboot.c:165
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

to a SOFTIRQ-irq-unsafe lock:
 (&(&s->cache_lock)->rlock){+.+.}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:338 [inline]
  sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
  sidtab_sid2str_put+0xa0/0xc0 security/selinux/ss/sidtab.c:566
  sidtab_entry_to_string security/selinux/ss/services.c:1279 [inline]
  sidtab_entry_to_string+0xf2/0x110 security/selinux/ss/services.c:1266
  security_sid_to_context_core+0x2c6/0x3c0 security/selinux/ss/services.c:1361
  security_sid_to_context+0x34/0x40 security/selinux/ss/services.c:1384
  avc_audit_post_callback+0x102/0x790 security/selinux/avc.c:709
  common_lsm_audit+0x5ac/0x1e00 security/lsm_audit.c:466
  slow_avc_audit+0x16a/0x1f0 security/selinux/avc.c:782
  avc_audit security/selinux/include/avc.h:140 [inline]
  avc_has_perm+0x543/0x610 security/selinux/avc.c:1185
  inode_has_perm+0x1a8/0x230 security/selinux/hooks.c:1631
  selinux_mmap_file+0x10a/0x1d0 security/selinux/hooks.c:3701
  security_mmap_file+0xa4/0x1e0 security/security.c:1482
  vm_mmap_pgoff+0xf0/0x230 mm/util.c:502
  vm_mmap+0x94/0xc0 mm/util.c:525
  elf_map+0x10a/0x2b0 fs/binfmt_elf.c:377
  load_elf_binary+0xd4b/0x5310 fs/binfmt_elf.c:982
  search_binary_handler fs/exec.c:1658 [inline]
  search_binary_handler+0x16d/0x570 fs/exec.c:1635
  exec_binprm fs/exec.c:1701 [inline]
  __do_execve_file.isra.0+0x1329/0x22b0 fs/exec.c:1821
  do_execveat_common fs/exec.c:1867 [inline]
  do_execve fs/exec.c:1884 [inline]
  __do_sys_execve fs/exec.c:1960 [inline]
  __se_sys_execve fs/exec.c:1955 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1955
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&s->cache_lock)->rlock);
                               local_irq_disable();
                               lock(&(&nf_conntrack_locks[i])->rlock);
                               lock(&(&s->cache_lock)->rlock);
  <Interrupt>
    lock(&(&nf_conntrack_locks[i])->rlock);

 *** DEADLOCK ***

4 locks held by syz-executor.3/20867:
 #0: ffffffff8c1acc68 (&table[i].mutex){+.+.}, at: nfnl_lock net/netfilter/nfnetlink.c:62 [inline]
 #0: ffffffff8c1acc68 (&table[i].mutex){+.+.}, at: nfnetlink_rcv_msg+0x9ee/0xfb0 net/netfilter/nfnetlink.c:224
 #1: ffff88800ce3c5d8 (nlk_cb_mutex-NETFILTER){+.+.}, at: netlink_dump+0xe7/0xfb0 net/netlink/af_netlink.c:2199
 #2: ffffffff898605d8 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
 #2: ffffffff898605d8 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
 #3: ffffffff8b7df008 (&selinux_ss.policy_rwlock){.+.?}, at: security_sid_to_context_core+0x1ca/0x3c0 security/selinux/ss/services.c:1344

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&(&nf_conntrack_locks[i])->rlock){+.-.} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:338 [inline]
                    nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
                    get_next_corpse net/netfilter/nf_conntrack_core.c:2001 [inline]
                    nf_ct_iterate_cleanup+0x1d2/0x4e0 net/netfilter/nf_conntrack_core.c:2035
                    nf_ct_iterate_destroy+0x12e/0x160 net/netfilter/nf_conntrack_core.c:2162
                    nf_conntrack_helper_unregister+0x111/0x160 net/netfilter/nf_conntrack_helper.c:469
                    nf_conntrack_helpers_unregister net/netfilter/nf_conntrack_helper.c:532 [inline]
                    nf_conntrack_helpers_register+0xaa/0xe0 net/netfilter/nf_conntrack_helper.c:523
                    nf_conntrack_sip_init+0x266/0x2a4 net/netfilter/nf_conntrack_sip.c:1693
                    do_one_initcall+0x120/0x820 init/main.c:939
                    do_initcall_level init/main.c:1007 [inline]
                    do_initcalls init/main.c:1015 [inline]
                    do_basic_setup init/main.c:1032 [inline]
                    kernel_init_freeable+0x4ca/0x570 init/main.c:1203
                    kernel_init+0x12/0x1bf init/main.c:1110
                    ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
   IN-SOFTIRQ-W at:
                    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:338 [inline]
                    nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
                    nf_conntrack_double_lock.isra.0+0xac/0x100 net/netfilter/nf_conntrack_core.c:134
                    __nf_conntrack_confirm+0x252/0x1710 net/netfilter/nf_conntrack_core.c:963
                    nf_conntrack_confirm include/net/netfilter/nf_conntrack_core.h:63 [inline]
                    nf_confirm+0x3e7/0x4d0 net/netfilter/nf_conntrack_proto.c:154
                    ipv4_confirm+0x14c/0x240 net/netfilter/nf_conntrack_proto.c:169
                    nf_hook_entry_hookfn include/linux/netfilter.h:135 [inline]
                    nf_hook_slow+0xbc/0x1e0 net/netfilter/core.c:512
                    nf_hook include/linux/netfilter.h:262 [inline]
                    NF_HOOK include/linux/netfilter.h:305 [inline]
                    ip_local_deliver+0x352/0x520 net/ipv4/ip_input.c:252
                    dst_input include/net/dst.h:442 [inline]
                    ip_sublist_rcv_finish+0x9b/0x2d0 net/ipv4/ip_input.c:549
                    ip_list_rcv_finish net/ipv4/ip_input.c:599 [inline]
                    ip_sublist_rcv+0x5a6/0xa20 net/ipv4/ip_input.c:607
                    ip_list_rcv+0x37e/0x4bf net/ipv4/ip_input.c:642
                    __netif_receive_skb_list_ptype net/core/dev.c:5193 [inline]
                    __netif_receive_skb_list_core+0x5fc/0x9d0 net/core/dev.c:5241
                    __netif_receive_skb_list net/core/dev.c:5293 [inline]
                    netif_receive_skb_list_internal+0x7eb/0xe50 net/core/dev.c:5388
                    gro_normal_list.part.0+0x1e/0xb0 net/core/dev.c:5499
                    gro_normal_list net/core/dev.c:6232 [inline]
                    napi_complete_done+0x208/0x510 net/core/dev.c:6220
                    virtqueue_napi_complete+0x31/0xa0 drivers/net/virtio_net.c:329
                    virtnet_poll+0xbad/0xe90 drivers/net/virtio_net.c:1432
                    napi_poll net/core/dev.c:6534 [inline]
                    net_rx_action+0x508/0x1120 net/core/dev.c:6602
                    __do_softirq+0x262/0x98c kernel/softirq.c:292
                    run_ksoftirqd kernel/softirq.c:603 [inline]
                    run_ksoftirqd+0x8e/0x110 kernel/softirq.c:595
                    smpboot_thread_fn+0x6a3/0xa40 kernel/smpboot.c:165
                    kthread+0x361/0x430 kernel/kthread.c:255
                    ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
   INITIAL USE at:
                   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
                   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
                   spin_lock include/linux/spinlock.h:338 [inline]
                   nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
                   get_next_corpse net/netfilter/nf_conntrack_core.c:2001 [inline]
                   nf_ct_iterate_cleanup+0x1d2/0x4e0 net/netfilter/nf_conntrack_core.c:2035
                   nf_ct_iterate_destroy+0x12e/0x160 net/netfilter/nf_conntrack_core.c:2162
                   nf_conntrack_helper_unregister+0x111/0x160 net/netfilter/nf_conntrack_helper.c:469
                   nf_conntrack_helpers_unregister net/netfilter/nf_conntrack_helper.c:532 [inline]
                   nf_conntrack_helpers_register+0xaa/0xe0 net/netfilter/nf_conntrack_helper.c:523
                   nf_conntrack_sip_init+0x266/0x2a4 net/netfilter/nf_conntrack_sip.c:1693
                   do_one_initcall+0x120/0x820 init/main.c:939
                   do_initcall_level init/main.c:1007 [inline]
                   do_initcalls init/main.c:1015 [inline]
                   do_basic_setup init/main.c:1032 [inline]
                   kernel_init_freeable+0x4ca/0x570 init/main.c:1203
                   kernel_init+0x12/0x1bf init/main.c:1110
                   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
 }
 ... key      at: [<ffffffff8c1ad440>] __key.79496+0x0/0x40
 ... acquired at:
   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:338 [inline]
   sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
   sidtab_sid2str_put security/selinux/ss/sidtab.c:594 [inline]
   sidtab_sid2str_get+0x3b5/0x66e security/selinux/ss/sidtab.c:594
   sidtab_entry_to_string+0x37/0x110 security/selinux/ss/services.c:1271
   security_sid_to_context_core+0x2c6/0x3c0 security/selinux/ss/services.c:1361
   security_sid_to_context+0x34/0x40 security/selinux/ss/services.c:1384
   selinux_secid_to_secctx+0x2d/0x40 security/selinux/hooks.c:6451
   security_secid_to_secctx+0x75/0xc0 security/security.c:1950
   ctnetlink_dump_secctx.isra.0+0x8c/0x330 net/netfilter/nf_conntrack_netlink.c:335
   ctnetlink_dump_info net/netfilter/nf_conntrack_netlink.c:531 [inline]
   ctnetlink_fill_info+0x750/0xd40 net/netfilter/nf_conntrack_netlink.c:591
   ctnetlink_dump_table+0x68c/0x1130 net/netfilter/nf_conntrack_netlink.c:979
   netlink_dump+0x558/0xfb0 net/netlink/af_netlink.c:2244
   __netlink_dump_start+0x66a/0x930 net/netlink/af_netlink.c:2352
   netlink_dump_start include/linux/netlink.h:233 [inline]
   ctnetlink_get_conntrack+0x55e/0x6a0 net/netfilter/nf_conntrack_netlink.c:1355
   nfnetlink_rcv_msg+0xcf2/0xfb0 net/netfilter/nfnetlink.c:229
   netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
   nfnetlink_rcv+0x1ba/0x460 net/netfilter/nfnetlink.c:563
   netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
   netlink_unicast+0x58c/0x7d0 net/netlink/af_netlink.c:1328
   netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1917
   sock_sendmsg_nosec net/socket.c:639 [inline]
   sock_sendmsg+0xd7/0x130 net/socket.c:659
   ____sys_sendmsg+0x753/0x880 net/socket.c:2330
   ___sys_sendmsg+0x100/0x170 net/socket.c:2384
   __sys_sendmsg+0x105/0x1d0 net/socket.c:2417
   __do_sys_sendmsg net/socket.c:2426 [inline]
   __se_sys_sendmsg net/socket.c:2424 [inline]
   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2424
   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
   entry_SYSCALL_64_after_hwframe+0x49/0xbe


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (&(&s->cache_lock)->rlock){+.+.} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:338 [inline]
                    sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
                    sidtab_sid2str_put+0xa0/0xc0 security/selinux/ss/sidtab.c:566
                    sidtab_entry_to_string security/selinux/ss/services.c:1279 [inline]
                    sidtab_entry_to_string+0xf2/0x110 security/selinux/ss/services.c:1266
                    security_sid_to_context_core+0x2c6/0x3c0 security/selinux/ss/services.c:1361
                    security_sid_to_context+0x34/0x40 security/selinux/ss/services.c:1384
                    avc_audit_post_callback+0x102/0x790 security/selinux/avc.c:709
                    common_lsm_audit+0x5ac/0x1e00 security/lsm_audit.c:466
                    slow_avc_audit+0x16a/0x1f0 security/selinux/avc.c:782
                    avc_audit security/selinux/include/avc.h:140 [inline]
                    avc_has_perm+0x543/0x610 security/selinux/avc.c:1185
                    inode_has_perm+0x1a8/0x230 security/selinux/hooks.c:1631
                    selinux_mmap_file+0x10a/0x1d0 security/selinux/hooks.c:3701
                    security_mmap_file+0xa4/0x1e0 security/security.c:1482
                    vm_mmap_pgoff+0xf0/0x230 mm/util.c:502
                    vm_mmap+0x94/0xc0 mm/util.c:525
                    elf_map+0x10a/0x2b0 fs/binfmt_elf.c:377
                    load_elf_binary+0xd4b/0x5310 fs/binfmt_elf.c:982
                    search_binary_handler fs/exec.c:1658 [inline]
                    search_binary_handler+0x16d/0x570 fs/exec.c:1635
                    exec_binprm fs/exec.c:1701 [inline]
                    __do_execve_file.isra.0+0x1329/0x22b0 fs/exec.c:1821
                    do_execveat_common fs/exec.c:1867 [inline]
                    do_execve fs/exec.c:1884 [inline]
                    __do_sys_execve fs/exec.c:1960 [inline]
                    __se_sys_execve fs/exec.c:1955 [inline]
                    __x64_sys_execve+0x8f/0xc0 fs/exec.c:1955
                    do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
   SOFTIRQ-ON-W at:
                    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:338 [inline]
                    sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
                    sidtab_sid2str_put+0xa0/0xc0 security/selinux/ss/sidtab.c:566
                    sidtab_entry_to_string security/selinux/ss/services.c:1279 [inline]
                    sidtab_entry_to_string+0xf2/0x110 security/selinux/ss/services.c:1266
                    security_sid_to_context_core+0x2c6/0x3c0 security/selinux/ss/services.c:1361
                    security_sid_to_context+0x34/0x40 security/selinux/ss/services.c:1384
                    avc_audit_post_callback+0x102/0x790 security/selinux/avc.c:709
                    common_lsm_audit+0x5ac/0x1e00 security/lsm_audit.c:466
                    slow_avc_audit+0x16a/0x1f0 security/selinux/avc.c:782
                    avc_audit security/selinux/include/avc.h:140 [inline]
                    avc_has_perm+0x543/0x610 security/selinux/avc.c:1185
                    inode_has_perm+0x1a8/0x230 security/selinux/hooks.c:1631
                    selinux_mmap_file+0x10a/0x1d0 security/selinux/hooks.c:3701
                    security_mmap_file+0xa4/0x1e0 security/security.c:1482
                    vm_mmap_pgoff+0xf0/0x230 mm/util.c:502
                    vm_mmap+0x94/0xc0 mm/util.c:525
                    elf_map+0x10a/0x2b0 fs/binfmt_elf.c:377
                    load_elf_binary+0xd4b/0x5310 fs/binfmt_elf.c:982
                    search_binary_handler fs/exec.c:1658 [inline]
                    search_binary_handler+0x16d/0x570 fs/exec.c:1635
                    exec_binprm fs/exec.c:1701 [inline]
                    __do_execve_file.isra.0+0x1329/0x22b0 fs/exec.c:1821
                    do_execveat_common fs/exec.c:1867 [inline]
                    do_execve fs/exec.c:1884 [inline]
                    __do_sys_execve fs/exec.c:1960 [inline]
                    __se_sys_execve fs/exec.c:1955 [inline]
                    __x64_sys_execve+0x8f/0xc0 fs/exec.c:1955
                    do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
   INITIAL USE at:
                   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
                   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
                   spin_lock include/linux/spinlock.h:338 [inline]
                   sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
                   sidtab_sid2str_put+0xa0/0xc0 security/selinux/ss/sidtab.c:566
                   sidtab_entry_to_string security/selinux/ss/services.c:1279 [inline]
                   sidtab_entry_to_string+0xf2/0x110 security/selinux/ss/services.c:1266
                   security_sid_to_context_core+0x2c6/0x3c0 security/selinux/ss/services.c:1361
                   security_sid_to_context+0x34/0x40 security/selinux/ss/services.c:1384
                   avc_audit_post_callback+0x102/0x790 security/selinux/avc.c:709
                   common_lsm_audit+0x5ac/0x1e00 security/lsm_audit.c:466
                   slow_avc_audit+0x16a/0x1f0 security/selinux/avc.c:782
                   avc_audit security/selinux/include/avc.h:140 [inline]
                   avc_has_perm+0x543/0x610 security/selinux/avc.c:1185
                   inode_has_perm+0x1a8/0x230 security/selinux/hooks.c:1631
                   selinux_mmap_file+0x10a/0x1d0 security/selinux/hooks.c:3701
                   security_mmap_file+0xa4/0x1e0 security/security.c:1482
                   vm_mmap_pgoff+0xf0/0x230 mm/util.c:502
                   vm_mmap+0x94/0xc0 mm/util.c:525
                   elf_map+0x10a/0x2b0 fs/binfmt_elf.c:377
                   load_elf_binary+0xd4b/0x5310 fs/binfmt_elf.c:982
                   search_binary_handler fs/exec.c:1658 [inline]
                   search_binary_handler+0x16d/0x570 fs/exec.c:1635
                   exec_binprm fs/exec.c:1701 [inline]
                   __do_execve_file.isra.0+0x1329/0x22b0 fs/exec.c:1821
                   do_execveat_common fs/exec.c:1867 [inline]
                   do_execve fs/exec.c:1884 [inline]
                   __do_sys_execve fs/exec.c:1960 [inline]
                   __se_sys_execve fs/exec.c:1955 [inline]
                   __x64_sys_execve+0x8f/0xc0 fs/exec.c:1955
                   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
                   entry_SYSCALL_64_after_hwframe+0x49/0xbe
 }
 ... key      at: [<ffffffff8b7dec80>] __key.69173+0x0/0x40
 ... acquired at:
   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:338 [inline]
   sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
   sidtab_sid2str_put security/selinux/ss/sidtab.c:594 [inline]
   sidtab_sid2str_get+0x3b5/0x66e security/selinux/ss/sidtab.c:594
   sidtab_entry_to_string+0x37/0x110 security/selinux/ss/services.c:1271
   security_sid_to_context_core+0x2c6/0x3c0 security/selinux/ss/services.c:1361
   security_sid_to_context+0x34/0x40 security/selinux/ss/services.c:1384
   selinux_secid_to_secctx+0x2d/0x40 security/selinux/hooks.c:6451
   security_secid_to_secctx+0x75/0xc0 security/security.c:1950
   ctnetlink_dump_secctx.isra.0+0x8c/0x330 net/netfilter/nf_conntrack_netlink.c:335
   ctnetlink_dump_info net/netfilter/nf_conntrack_netlink.c:531 [inline]
   ctnetlink_fill_info+0x750/0xd40 net/netfilter/nf_conntrack_netlink.c:591
   ctnetlink_dump_table+0x68c/0x1130 net/netfilter/nf_conntrack_netlink.c:979
   netlink_dump+0x558/0xfb0 net/netlink/af_netlink.c:2244
   __netlink_dump_start+0x66a/0x930 net/netlink/af_netlink.c:2352
   netlink_dump_start include/linux/netlink.h:233 [inline]
   ctnetlink_get_conntrack+0x55e/0x6a0 net/netfilter/nf_conntrack_netlink.c:1355
   nfnetlink_rcv_msg+0xcf2/0xfb0 net/netfilter/nfnetlink.c:229
   netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
   nfnetlink_rcv+0x1ba/0x460 net/netfilter/nfnetlink.c:563
   netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
   netlink_unicast+0x58c/0x7d0 net/netlink/af_netlink.c:1328
   netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1917
   sock_sendmsg_nosec net/socket.c:639 [inline]
   sock_sendmsg+0xd7/0x130 net/socket.c:659
   ____sys_sendmsg+0x753/0x880 net/socket.c:2330
   ___sys_sendmsg+0x100/0x170 net/socket.c:2384
   __sys_sendmsg+0x105/0x1d0 net/socket.c:2417
   __do_sys_sendmsg net/socket.c:2426 [inline]
   __se_sys_sendmsg net/socket.c:2424 [inline]
   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2424
   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
   entry_SYSCALL_64_after_hwframe+0x49/0xbe


stack backtrace:
CPU: 0 PID: 20867 Comm: syz-executor.3 Not tainted 5.5.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_bad_irq_dependency kernel/locking/lockdep.c:2094 [inline]
 check_irq_usage.cold+0x586/0x6fe kernel/locking/lockdep.c:2292
 check_prev_add kernel/locking/lockdep.c:2479 [inline]
 check_prevs_add kernel/locking/lockdep.c:2580 [inline]
 validate_chain kernel/locking/lockdep.c:2970 [inline]
 __lock_acquire+0x25b4/0x4a00 kernel/locking/lockdep.c:3954
 lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:338 [inline]
 sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
 sidtab_sid2str_put security/selinux/ss/sidtab.c:594 [inline]
 sidtab_sid2str_get+0x3b5/0x66e security/selinux/ss/sidtab.c:594
 sidtab_entry_to_string+0x37/0x110 security/selinux/ss/services.c:1271
 security_sid_to_context_core+0x2c6/0x3c0 security/selinux/ss/services.c:1361
 security_sid_to_context+0x34/0x40 security/selinux/ss/services.c:1384
 selinux_secid_to_secctx+0x2d/0x40 security/selinux/hooks.c:6451
 security_secid_to_secctx+0x75/0xc0 security/security.c:1950
 ctnetlink_dump_secctx.isra.0+0x8c/0x330 net/netfilter/nf_conntrack_netlink.c:335
 ctnetlink_dump_info net/netfilter/nf_conntrack_netlink.c:531 [inline]
 ctnetlink_fill_info+0x750/0xd40 net/netfilter/nf_conntrack_netlink.c:591
 ctnetlink_dump_table+0x68c/0x1130 net/netfilter/nf_conntrack_netlink.c:979
 netlink_dump+0x558/0xfb0 net/netlink/af_netlink.c:2244
 __netlink_dump_start+0x66a/0x930 net/netlink/af_netlink.c:2352
 netlink_dump_start include/linux/netlink.h:233 [inline]
 ctnetlink_get_conntrack+0x55e/0x6a0 net/netfilter/nf_conntrack_netlink.c:1355
 nfnetlink_rcv_msg+0xcf2/0xfb0 net/netfilter/nfnetlink.c:229
 netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
 nfnetlink_rcv+0x1ba/0x460 net/netfilter/nfnetlink.c:563
 netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
 netlink_unicast+0x58c/0x7d0 net/netlink/af_netlink.c:1328
 netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1917
 sock_sendmsg_nosec net/socket.c:639 [inline]
 sock_sendmsg+0xd7/0x130 net/socket.c:659
 ____sys_sendmsg+0x753/0x880 net/socket.c:2330
 ___sys_sendmsg+0x100/0x170 net/socket.c:2384
 __sys_sendmsg+0x105/0x1d0 net/socket.c:2417
 __do_sys_sendmsg net/socket.c:2426 [inline]
 __se_sys_sendmsg net/socket.c:2424 [inline]
 __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2424
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45b3f9
Code: bd b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 8b b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbe326f8c88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000072bf00 RCX: 000000000045b3f9
RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000003
RBP: 00007fbe326f96d4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000008f1 R14: 00000000004ba9a8 R15: 00000000006eaa80


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
