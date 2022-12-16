Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7183EC4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 07:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiLPH3k convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 02:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLPH31 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 02:29:27 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52DEB28704
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 23:29:22 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2BG7T1a6002553;
        Fri, 16 Dec 2022 08:29:01 +0100
Date:   Fri, 16 Dec 2022 08:29:01 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     darklight2357@icloud.com
Cc:     "security@kernel.org" <security@kernel.org>,
        selinux@vger.kernel.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Subject: Re: memory leak in inet_create
Message-ID: <20221216072901.GF2473@1wt.eu>
References: <f30a9b00-5133-43ce-ad97-1cb4f1970ff3@me.com>
 <5bfd9daf-9180-4b9d-b4b7-0035848ab860@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <5bfd9daf-9180-4b9d-b4b7-0035848ab860@me.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

could you please fix your mailer and resend, something wrong happened,
we received the totally unreadable block below, as if all line breaks
were removed!

Thanks,
Willy

On Fri, Dec 16, 2022 at 07:16:08AM -0000, ??? wrote:
> On Dec 16, 2022, at 4:11 PM, ??? <darklight2357@icloud.com> wrote:Attachments available until January 15, 2023.Hello, I am "Changheon Lee" concerned with kernel security.A "memory leak in inet_create" was reported in Syzkaller targeting Linux kernel Version 6.1 on December 15, 2022 at 18:36 (KST).The environment in which the bug was detected is as follows.Syzkaller revision : 67be1ae7Kernel version : Linux kernel 6.1The report provided by Syzkaller is as follows.BUG: memory leakunreferenced object 0xffff88810a908c80 (size 2912):  comm "syz-executor609", pid 330, jiffies 4294839395 (age 15.786s)  hex dump (first 32 bytes):    7f 00 00 01 7f 00 00 01 08 e4 6b 1b 4e 20 00 00  ..........k.N ..    02 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............  backtrace:    [<ffffffff83478054>] sk_prot_alloc+0x64/0x2a0 net/core/sock.c:2024    [<ffffffff8348316b>] sk_alloc+0x3b/0x7d0 net/core/sock.c:2083    [<ffffffff838e2e8b>] inet_create+0x39b/0xee0 net/ipv4/af_inet.c:319    [<ffffffff8346bca1>] __sock_create+0x381/0x850 net/socket.c:1515    [<ffffffff8346fa8b>] sock_create net/socket.c:1566 [inline]    [<ffffffff8346fa8b>] __sys_socket_create net/socket.c:1603 [inline]    [<ffffffff8346fa8b>] __sys_socket+0x13b/0x250 net/socket.c:1636    [<ffffffff8346fc13>] __do_sys_socket net/socket.c:1649 [inline]    [<ffffffff8346fc13>] __se_sys_socket net/socket.c:1647 [inline]    [<ffffffff8346fc13>] __x64_sys_socket+0x73/0xb0 net/socket.c:1647    [<ffffffff843153c8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]    [<ffffffff843153c8>] do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80    [<ffffffff8440009b>] entry_SYSCALL_64_after_hwframe+0x63/0xcdBUG: memory leakunreferenced object 0xffff888112a6f020 (size 32):  comm "syz-executor609", pid 330, jiffies 4294839395 (age 15.786s)  hex dump (first 32 bytes):    02 00 00 00 00 00 00 00 40 e9 ba 0e 81 88 ff ff  ........@.......    01 00 00 00 03 00 00 00 10 00 00 00 00 00 00 00  ................  backtrace:    [<ffffffff816d8987>] kmalloc_trace+0x27/0x60 mm/slab_common.c:1045    [<ffffffff81f4869f>] kmalloc include/linux/slab.h:553 [inline]    [<ffffffff81f4869f>] kzalloc include/linux/slab.h:689 [inline]    [<ffffffff81f4869f>] selinux_sk_alloc_security+0x9f/0x230 security/selinux/hooks.c:5190    [<ffffffff81f34938>] security_sk_alloc+0x58/0xc0 security/security.c:2286    [<ffffffff8347809e>] sk_prot_alloc+0xae/0x2a0 net/core/sock.c:2033    [<ffffffff8348316b>] sk_alloc+0x3b/0x7d0 net/core/sock.c:2083    [<ffffffff838e2e8b>] inet_create+0x39b/0xee0 net/ipv4/af_inet.c:319    [<ffffffff8346bca1>] __sock_create+0x381/0x850 net/socket.c:1515    [<ffffffff8346fa8b>] sock_create net/socket.c:1566 [inline]    [<ffffffff8346fa8b>] __sys_socket_create net/socket.c:1603 [inline]    [<ffffffff8346fa8b>] __sys_socket+0x13b/0x250 net/socket.c:1636    [<ffffffff8346fc13>] __do_sys_socket net/socket.c:1649 [inline]    [<ffffffff8346fc13>] __se_sys_socket net/socket.c:1647 [inline]    [<ffffffff8346fc13>] __x64_sys_socket+0x73/0xb0 net/socket.c:1647    [<ffffffff843153c8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]    [<ffffffff843153c8>] do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80    [<ffffffff8440009b>] entry_SYSCALL_64_after_hwframe+0x63/0xcdBUG: memory leakunreferenced object 0xffff88810ebae940 (size 64):  comm "syz-executor609", pid 330, jiffies 4294839395 (age 15.787s)  hex dump (first 32 bytes):    15 00 00 01 00 00 00 00 70 33 b8 02 81 88 ff ff  ........p3......    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................  backtrace:    [<ffffffff816d8987>] kmalloc_trace+0x27/0x60 mm/slab_common.c:1045    [<ffffffff81fb7e15>] kmalloc include/linux/slab.h:553 [inline]    [<ffffffff81fb7e15>] kzalloc include/linux/slab.h:689 [inline]    [<ffffffff81fb7e15>] netlbl_secattr_alloc include/net/netlabel.h:382 [inline]    [<ffffffff81fb7e15>] selinux_netlbl_sock_genattr+0xb5/0x4b0 security/selinux/netlabel.c:77    [<ffffffff81fb9bfc>] selinux_netlbl_socket_post_create+0x7c/0x170 security/selinux/netlabel.c:401    [<ffffffff81f5215f>] selinux_socket_post_create+0x30f/0x820 security/selinux/hooks.c:4605    [<ffffffff81f33fcc>] security_socket_post_create+0x6c/0xd0 security/security.c:2198    [<ffffffff8346c024>] __sock_create+0x704/0x850 net/socket.c:1531    [<ffffffff8346fa8b>] sock_create net/socket.c:1566 [inline]    [<ffffffff8346fa8b>] __sys_socket_create net/socket.c:1603 [inline]    [<ffffffff8346fa8b>] __sys_socket+0x13b/0x250 net/socket.c:1636    [<ffffffff8346fc13>] __do_sys_socket net/socket.c:1649 [inline]    [<ffffffff8346fc13>] __se_sys_socket net/socket.c:1647 [inline]    [<ffffffff8346fc13>] __x64_sys_socket+0x73/0xb0 net/socket.c:1647    [<ffffffff843153c8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]    [<ffffffff843153c8>] do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80    [<ffffffff8440009b>] entry_SYSCALL_64_after_hwframe+0x63/0xcdBUG: memory leakunreferenced object 0xffff888102b83370 (size 16):  comm "syz-executor609", pid 330, jiffies 4294839395 (age 15.787s)  hex dump (first 16 bytes):    6b 65 72 6e 65 6c 5f 74 00 6b 6b 6b 6b 6b 6b a5  kernel_t.kkkkkk.  backtrace:    [<ffffffff816d949c>] __do_kmalloc_node mm/slab_common.c:954 [inline]    [<ffffffff816d949c>] __kmalloc_node_track_caller+0x4c/0xd0 mm/slab_common.c:975    [<ffffffff816b7b90>] kstrdup+0x40/0x80 mm/util.c:61    [<ffffffff81fade31>] security_netlbl_sid_to_secattr+0x1f1/0x4e0 security/selinux/ss/services.c:3973    [<ffffffff81fb7e59>] selinux_netlbl_sock_genattr+0xf9/0x4b0 security/selinux/netlabel.c:80    [<ffffffff81fb9bfc>] selinux_netlbl_socket_post_create+0x7c/0x170 security/selinux/netlabel.c:401    [<ffffffff81f5215f>] selinux_socket_post_create+0x30f/0x820 security/selinux/hooks.c:4605    [<ffffffff81f33fcc>] security_socket_post_create+0x6c/0xd0 security/security.c:2198    [<ffffffff8346c024>] __sock_create+0x704/0x850 net/socket.c:1531    [<ffffffff8346fa8b>] sock_create net/socket.c:1566 [inline]    [<ffffffff8346fa8b>] __sys_socket_create net/socket.c:1603 [inline]    [<ffffffff8346fa8b>] __sys_socket+0x13b/0x250 net/socket.c:1636    [<ffffffff8346fc13>] __do_sys_socket net/socket.c:1649 [inline]    [<ffffffff8346fc13>] __se_sys_socket net/socket.c:1647 [inline]    [<ffffffff8346fc13>] __x64_sys_socket+0x73/0xb0 net/socket.c:1647    [<ffffffff843153c8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]    [<ffffffff843153c8>] do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80    [<ffffffff8440009b>] entry_SYSCALL_64_after_hwframe+0x63/0xcdI cannot rule out the possibility that this bug detected in Syzkaller targeting 6.1 is a false positive.However, as far as I can check, this memory leak has not been reported recently.I just found a reported case on "mail-archive.com" with a backtrace very similar to the memory leak I just reported.Considering the contents of the mail I found, the "memory leak in inet_create" I reported seems to be related to SElinux, and I attach the link at the bottom.Link : https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1950307.htmlThe email in the link was made in 2019, and it seems to be related to what I reported this time, but it is seen as a separate matter.kernel config, vmlinux, bzImage and C reproducer will be attached separately.Thanks.ChangHeon Lee Ps. I have now cheaked that emails with the same contents were sent multiple times due to issues such as the inability to properly set the recipient, CC settings, or HTML forms being included in the email.I apologize for any inconvenience caused.Download from iCloudvmlinux475.5 MBDownload from iCloudC_repo.c5 KBDownload from iCloudbzImage30 MBDownload from iCloudkernel config (.config).txt139 KBI'm so sorry... no more HTML forms or links are included...
