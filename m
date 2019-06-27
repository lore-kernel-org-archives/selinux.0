Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635C1C48BD3
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 02:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECAB216E3
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 02:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfF0Cli (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:41:38 -0400
Received: from namei.org ([65.99.196.166]:48822 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfF0Clh (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 26 Jun 2019 22:41:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5R2fNJH013144;
        Thu, 27 Jun 2019 02:41:23 GMT
Date:   Thu, 27 Jun 2019 12:41:23 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
In-Reply-To: <20190626192234.11725-1-casey@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1906271230490.12379@namei.org>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 26 Jun 2019, Casey Schaufler wrote:

> This patchset provides the changes required for
> the AppArmor security module to stack safely with any other.

I get a kernel oops with this patchset when running the SELinux testsuite 
(binder test) with:

$ cat /sys/kernel/security/lsm 
capability,yama,loadpin,safesetid,selinux,tomoyo


[  485.357377] binder: 4224 RLIMIT_NICE not set
[  485.360727] binder: 4224 RLIMIT_NICE not set
[  485.361480] binder: 4224 RLIMIT_NICE not set
[  485.362164] BUG: unable to handle kernel paging request at 0000000000001080
[  485.362927] #PF error: [normal kernel read fault]
[  485.363143] ------------[ cut here ]------------
[  485.363581] PGD 800000044e17b067 P4D 800000044e17b067 PUD 44b796067 PMD 0 
[  485.364226] kernel BUG at drivers/android/binder_alloc.c:1139!
[  485.364865] Oops: 0000 [#1] SMP PTI
[  485.366430] CPU: 1 PID: 4224 Comm: manager Not tainted 5.1.0+ #7
[  485.367290] Hardware name: LENOVO 20HGS3KS0S/20HGS3KS0S, BIOS N1WET44W (1.23 ) 01/24/2018
[  485.367900] RIP: 0010:binder_alloc_do_buffer_copy+0x88/0x210
[  485.368515] Code: 00 65 48 8b 2c 25 00 5c 01 00 41 bd 00 10 00 00 48 89 
eb eb 3d 83 f8 08 0f 83 e3 00 00 00 a8 04 0f 
85 45 01 00 00 85 c0 74 0e <41> 0f b6 08 88 0e a8 02 0f 85 5d 01 00 00 83 
ab a8 19 00 00 01 49
[  485.369170] RSP: 0018:ffffaf3ac1f9bb88 EFLAGS: 00010202
[  485.369804] RAX: 0000000000000002 RBX: ffff8d3c84340000 RCX: 0000000000000000
[  485.370470] RDX: ffff8d3c8db74cc0 RSI: ffff8d3c8b425000 RDI: ffff8d3c89844978
[  485.371132] RBP: ffff8d3c84340000 R08: 0000000000001080 R09: 0000000000000002
[  485.371887] R10: 0000000000000000 R11: ffff8d3c89844978 R12: 0000000000000001
[  485.372656] R13: 0000000000001000 R14: ffff8d3c865d6300 R15: ffffffffa1a719c8
[  485.373340] FS:  00007fae657a8680(0000) GS:ffff8d3c91480000(0000) knlGS:0000000000000000
[  485.374017] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  485.374710] CR2: 0000000000001080 CR3: 000000044d482002 CR4: 00000000003606e0
[  485.375423] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  485.376122] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  485.376823] Call Trace:
[  485.377514]  binder_transaction+0x371/0x2320
[  485.378231]  ? printk+0x58/0x6f
[  485.378940]  ? common_lsm_audit+0x162/0x800
[  485.379641]  ? __check_object_size+0x41/0x15d
[  485.380347]  ? binder_thread_read+0x9e4/0x1460
[  485.381065]  ? binder_update_ref_for_handle+0x83/0x1a0
[  485.381759]  binder_thread_write+0x2ae/0xfc0
[  485.382472]  ? tomoyo_path_number_perm+0x66/0x1d0
[  485.383150]  ? finish_wait+0x80/0x80
[  485.383839]  binder_ioctl+0x659/0x836
[  485.384531]  do_vfs_ioctl+0x405/0x660
[  485.385194]  ? __fput+0x157/0x230
[  485.385850]  ksys_ioctl+0x5e/0x90
[  485.386473]  __x64_sys_ioctl+0x16/0x20
[  485.387137]  do_syscall_64+0x5b/0x150
[  485.387782]  entry_SYSCALL_64_after_hwframe+0x44/0xa9


Looks to be:
(gdb) list *(binder_alloc_do_buffer_copy + 0x88)
0xffffffff817e2cb8 is in binder_alloc_do_buffer_copy 
(./include/linux/string.h:355).
350			if (q_size < size)
351				__read_overflow2();
352		}
353		if (p_size < size || q_size < size)
354			fortify_panic(__func__);
355		return __builtin_memcpy(p, q, size);
356	}
357

