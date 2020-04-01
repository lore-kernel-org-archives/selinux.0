Return-Path: <SRS0=rNkQ=5R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADB9C43331
	for <selinux@archiver.kernel.org>; Wed,  1 Apr 2020 03:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E484206DB
	for <selinux@archiver.kernel.org>; Wed,  1 Apr 2020 03:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbgDAD0G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Mar 2020 23:26:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35500 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731556AbgDAD0F (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 31 Mar 2020 23:26:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 869109E1DB308C35FD27;
        Wed,  1 Apr 2020 11:25:54 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.234) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Apr 2020
 11:25:51 +0800
Subject: Re: KASAN: slab-out-of-bounds Read in selinux_xfrm_alloc_user
To:     syzbot <syzbot+9bc8c4f42b3e1d0274fe@syzkaller.appspotmail.com>,
        <eparis@parisplace.org>, <linux-kernel@vger.kernel.org>,
        <paul@paul-moore.com>, <sds@tycho.nsa.gov>,
        <selinux@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
References: <0000000000008a567905a2151e07@google.com>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <9a659458-c117-bba2-fc88-9e5febf01363@huawei.com>
Date:   Wed, 1 Apr 2020 11:25:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <0000000000008a567905a2151e07@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


#syz fix: xfrm: add the missing verify_sec_ctx_len check in xfrm_add_acquire

On 2020/3/31 0:41, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    906c4043 Merge branch 'i2c/for-current' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14f4a825e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
> dashboard link: https://syzkaller.appspot.com/bug?extid=9bc8c4f42b3e1d0274fe
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1160f46de00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107c7c97e00000
> 
> Bisection is inconclusive: the bug happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133ca825e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=10bca825e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=173ca825e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9bc8c4f42b3e1d0274fe@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:381 [inline]
> BUG: KASAN: slab-out-of-bounds in selinux_xfrm_alloc_user+0x23e/0x450 security/selinux/xfrm.c:99
> Read of size 768 at addr ffff88808d161934 by task syz-executor391/7036
> 
> CPU: 0 PID: 7036 Comm: syz-executor391 Not tainted 5.6.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x188/0x20d lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:374
>  __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
>  kasan_report+0xe/0x20 mm/kasan/common.c:641
>  check_memory_region_inline mm/kasan/generic.c:185 [inline]
>  check_memory_region+0x128/0x190 mm/kasan/generic.c:192
>  memcpy+0x20/0x50 mm/kasan/common.c:127
>  memcpy include/linux/string.h:381 [inline]
>  selinux_xfrm_alloc_user+0x23e/0x450 security/selinux/xfrm.c:99
>  security_xfrm_policy_alloc+0x6c/0xb0 security/security.c:2263
>  copy_from_user_sec_ctx net/xfrm/xfrm_user.c:1462 [inline]
>  xfrm_policy_construct+0x2a8/0x660 net/xfrm/xfrm_user.c:1627
>  xfrm_add_acquire+0x215/0x9f0 net/xfrm/xfrm_user.c:2280
>  xfrm_user_rcv_msg+0x414/0x700 net/xfrm/xfrm_user.c:2676
>  netlink_rcv_skb+0x15a/0x410 net/netlink/af_netlink.c:2469
>  xfrm_netlink_rcv+0x6b/0x90 net/xfrm/xfrm_user.c:2684
>  netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
>  netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
>  netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:672
>  ____sys_sendmsg+0x6b9/0x7d0 net/socket.c:2345
>  ___sys_sendmsg+0x100/0x170 net/socket.c:2399
>  __sys_sendmsg+0xec/0x1b0 net/socket.c:2432
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4405f9
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fffabe06278 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004405f9
> RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401e80
> R13: 0000000000401f10 R14: 0000000000000000 R15: 0000000000000000
> 
> Allocated by task 7036:
>  save_stack+0x1b/0x80 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  __kasan_kmalloc mm/kasan/common.c:515 [inline]
>  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:488
>  __kmalloc_reserve.isra.0+0x39/0xe0 net/core/skbuff.c:142
>  __alloc_skb+0xef/0x5a0 net/core/skbuff.c:210
>  alloc_skb include/linux/skbuff.h:1083 [inline]
>  netlink_alloc_large_skb net/netlink/af_netlink.c:1175 [inline]
>  netlink_sendmsg+0x97b/0xe10 net/netlink/af_netlink.c:1893
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:672
>  ____sys_sendmsg+0x6b9/0x7d0 net/socket.c:2345
>  ___sys_sendmsg+0x100/0x170 net/socket.c:2399
>  __sys_sendmsg+0xec/0x1b0 net/socket.c:2432
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 5010:
>  save_stack+0x1b/0x80 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  kasan_set_free_info mm/kasan/common.c:337 [inline]
>  __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:476
>  __cache_free mm/slab.c:3426 [inline]
>  kfree+0x109/0x2b0 mm/slab.c:3757
>  skb_free_head+0x8b/0xa0 net/core/skbuff.c:590
>  skb_release_data+0x42e/0x8b0 net/core/skbuff.c:610
>  skb_release_all+0x46/0x60 net/core/skbuff.c:664
>  __kfree_skb net/core/skbuff.c:678 [inline]
>  consume_skb net/core/skbuff.c:837 [inline]
>  consume_skb+0xf3/0x400 net/core/skbuff.c:831
>  netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>  netlink_unicast+0x53f/0x740 net/netlink/af_netlink.c:1329
>  netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:672
>  ____sys_sendmsg+0x6b9/0x7d0 net/socket.c:2345
>  ___sys_sendmsg+0x100/0x170 net/socket.c:2399
>  __sys_sendmsg+0xec/0x1b0 net/socket.c:2432
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The buggy address belongs to the object at ffff88808d161800
>  which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 308 bytes inside of
>  1024-byte region [ffff88808d161800, ffff88808d161c00)
> The buggy address belongs to the page:
> page:ffffea0002345840 refcount:1 mapcount:0 mapping:ffff8880aa000c40 index:0x0
> flags: 0xfffe0000000200(slab)
> raw: 00fffe0000000200 ffffea00023d3008 ffffea00029cb048 ffff8880aa000c40
> raw: 0000000000000000 ffff88808d161000 0000000100000002 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff88808d161b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88808d161b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffff88808d161c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                    ^
>  ffff88808d161c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88808d161d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
> .
> 

