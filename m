Return-Path: <SRS0=MU1A=5P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E11C43331
	for <selinux@archiver.kernel.org>; Mon, 30 Mar 2020 16:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC86D20578
	for <selinux@archiver.kernel.org>; Mon, 30 Mar 2020 16:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgC3QlP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:41:15 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:44190 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgC3QlP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Mar 2020 12:41:15 -0400
Received: by mail-il1-f197.google.com with SMTP id b15so14136512ilh.11
        for <selinux@vger.kernel.org>; Mon, 30 Mar 2020 09:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J392luCNfWRWxhPZVD+EzyJ0PTGAErJoBStDUC9J4Zk=;
        b=ALg6Q/MHSMe4wLgA0C4ZEtIONmK7TtE3B1mTmyoINmv31htIHreC7CmMhaeDoPFgV8
         ioz/6ZndLI5F84X7jblbSvZmnTDBf8nzi/KJBmjTITOLrulLoq9CeDOhvpCi22eC4LYc
         R73oxvRojFdLY64jlvcJgXk+qxTWPyEUd770iAgWhuC+XPP1dvtcvhkA/RT0UQ9KRga0
         FWJpp+1XRcb4RPCO6HIjlnrIqqbvF79xKF1Dk7jTN2VpbEvCLi0fut2kNrZsGQi7Rq/s
         uDEmSCu5LY3vfs7lsxL1DYsT0j8eDk3LCD+99B1qCQTE7k/WFpjiV92tDqAh91sbi1Gf
         y0Kw==
X-Gm-Message-State: ANhLgQ2hWbar+dObEDYwVimSfTFKcrQkmIF/Zbt+7RuUB8AGTvyyfqSE
        fLjaVFc/jH8g9todP2UI7ydq2BpxS0OHYR44KIsvgxsAVphX
X-Google-Smtp-Source: ADFU+vsymLPDiPA2g5MIUzyCHCea3vA0ojr2x8lphgAtvW8cqlCQPZ3Wy9PYZav0sWndRkClAxRhE3aAfWrAQY6yvQPQ3ONDW3X+
MIME-Version: 1.0
X-Received: by 2002:a6b:7d0c:: with SMTP id c12mr11248274ioq.83.1585586473946;
 Mon, 30 Mar 2020 09:41:13 -0700 (PDT)
Date:   Mon, 30 Mar 2020 09:41:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a567905a2151e07@google.com>
Subject: KASAN: slab-out-of-bounds Read in selinux_xfrm_alloc_user
From:   syzbot <syzbot+9bc8c4f42b3e1d0274fe@syzkaller.appspotmail.com>
To:     eparis@parisplace.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    906c4043 Merge branch 'i2c/for-current' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f4a825e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
dashboard link: https://syzkaller.appspot.com/bug?extid=9bc8c4f42b3e1d0274fe
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1160f46de00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107c7c97e00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133ca825e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10bca825e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=173ca825e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9bc8c4f42b3e1d0274fe@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:381 [inline]
BUG: KASAN: slab-out-of-bounds in selinux_xfrm_alloc_user+0x23e/0x450 security/selinux/xfrm.c:99
Read of size 768 at addr ffff88808d161934 by task syz-executor391/7036

CPU: 0 PID: 7036 Comm: syz-executor391 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:374
 __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x128/0x190 mm/kasan/generic.c:192
 memcpy+0x20/0x50 mm/kasan/common.c:127
 memcpy include/linux/string.h:381 [inline]
 selinux_xfrm_alloc_user+0x23e/0x450 security/selinux/xfrm.c:99
 security_xfrm_policy_alloc+0x6c/0xb0 security/security.c:2263
 copy_from_user_sec_ctx net/xfrm/xfrm_user.c:1462 [inline]
 xfrm_policy_construct+0x2a8/0x660 net/xfrm/xfrm_user.c:1627
 xfrm_add_acquire+0x215/0x9f0 net/xfrm/xfrm_user.c:2280
 xfrm_user_rcv_msg+0x414/0x700 net/xfrm/xfrm_user.c:2676
 netlink_rcv_skb+0x15a/0x410 net/netlink/af_netlink.c:2469
 xfrm_netlink_rcv+0x6b/0x90 net/xfrm/xfrm_user.c:2684
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6b9/0x7d0 net/socket.c:2345
 ___sys_sendmsg+0x100/0x170 net/socket.c:2399
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2432
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4405f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffabe06278 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004405f9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401e80
R13: 0000000000401f10 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 7036:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:488
 __kmalloc_reserve.isra.0+0x39/0xe0 net/core/skbuff.c:142
 __alloc_skb+0xef/0x5a0 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1083 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1175 [inline]
 netlink_sendmsg+0x97b/0xe10 net/netlink/af_netlink.c:1893
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6b9/0x7d0 net/socket.c:2345
 ___sys_sendmsg+0x100/0x170 net/socket.c:2399
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2432
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5010:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:476
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x109/0x2b0 mm/slab.c:3757
 skb_free_head+0x8b/0xa0 net/core/skbuff.c:590
 skb_release_data+0x42e/0x8b0 net/core/skbuff.c:610
 skb_release_all+0x46/0x60 net/core/skbuff.c:664
 __kfree_skb net/core/skbuff.c:678 [inline]
 consume_skb net/core/skbuff.c:837 [inline]
 consume_skb+0xf3/0x400 net/core/skbuff.c:831
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x53f/0x740 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6b9/0x7d0 net/socket.c:2345
 ___sys_sendmsg+0x100/0x170 net/socket.c:2399
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2432
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88808d161800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 308 bytes inside of
 1024-byte region [ffff88808d161800, ffff88808d161c00)
The buggy address belongs to the page:
page:ffffea0002345840 refcount:1 mapcount:0 mapping:ffff8880aa000c40 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00023d3008 ffffea00029cb048 ffff8880aa000c40
raw: 0000000000000000 ffff88808d161000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88808d161b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88808d161b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88808d161c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88808d161c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88808d161d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
