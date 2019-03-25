Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE044C43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 15:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAADB2083D
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 15:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="y55q/U1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbfCYPQ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:16:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44566 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbfCYPQ5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 11:16:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id u9so6241532lfe.11
        for <selinux@vger.kernel.org>; Mon, 25 Mar 2019 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0nSBhOkcRu9lXMDFAOR9o6xk3dCvFGinJDmxipn1cHY=;
        b=y55q/U1FuUyAlyq3MB4kSiFKFspMUTIx7/BeZ8DqmgWyu0p6liv/JlilN5WJlCB2on
         UBNtv3fiB+iHVZ5Rfi9+Io6rK7n/zXN2suYa/zmJV3+xAIt7WxFwcVULUATaMUb6EArQ
         JwQsVDjzIs7A6oYcKH2PhoBw+sx+wMwpR8xZsGkRLBaZKN8Pgyw0VmLb1rLf86e/IP5D
         4JNJmNp69qD/KAcev44PbVcBEQnfPNnyrqV1FVjaVRNsQvL/n5b/RlIVYo1Ac+6Wj1g5
         rDcMClPEEcRYhwZMWcSttzDaUsDMyXWSJ4AXOxB1AR0Fr2KhE9GpwsHo4Gu3Ksv9LTCJ
         +7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0nSBhOkcRu9lXMDFAOR9o6xk3dCvFGinJDmxipn1cHY=;
        b=ZefJ3q+UlIWgL1bEc5Ky8zDZOyCsq8+K8z46kwzze8h///TCo9lxxdtuxKn/+wrRO6
         DELHVCSe7mZTEBblNiv36sKlXhkTlj7QTCB985LOVciYvscq+f/0yI6ODiLBVShRK30d
         a98ZJDNIsIGjo2kj7sF3wppivuOTuUPv1geqNu70lXX/2FXIXdPg22R+5bCQOQqtS+N4
         K7MwDAXL9CGMBG78XiRypFcdemTFPbdsmqreDrYuedgU0o0QmyjZLYqPpaX0BLn57B7i
         4OdKBNYbA3Pxuqc1gBmpWiX5x962eWeg6PMNBXLDhb84j/MtEd5o1ukEAd10dKijzN06
         50AA==
X-Gm-Message-State: APjAAAXjwpT3z7vfvzXbuyi02zYC+SMOJe9LyrpmngHIyPeqE1bzKm6i
        Wanu5wL7RqJi3MmolFWo2JaPNPozojr0TKOfMjse
X-Google-Smtp-Source: APXvYqzxGVjrvGfPaV7Ly7qNH+kJkG1MNnKMoXjn/inqia3jE2JXpr8n97gx6xhxadfCqThAao88wEbgTnyr7Eoe0yc=
X-Received: by 2002:ac2:5921:: with SMTP id v1mr37478lfi.135.1553527012543;
 Mon, 25 Mar 2019 08:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190325145032.GB21359@shao2-debian>
In-Reply-To: <20190325145032.GB21359@shao2-debian>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Mar 2019 11:16:41 -0400
Message-ID: <CAHC9VhQt6RMdOsVNAXHnPzTrVRpnfaq4PULzBCmMPg7SgdTpfw@mail.gmail.com>
Subject: Re: [kernfs] e19dfdc83b: BUG:KASAN:global-out-of-bounds_in_s
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LKML <linux-kernel@vger.kernel.org>, selinux@vger.kernel.org,
        lkp@01.org, kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej, please look into this.

You've looked at this code more recently than I have, but it looks
like there might be an issue with __kernfs_iattrs() returning a
pointer to a kernfs_iattrs object without taking a kernfs reference
(kernfs_get(kn)).  Although I would be a little surprised if this was
the problem as I think it would cause a number of issues beyond just
this one ... ?

On Mon, Mar 25, 2019 at 10:50 AM kernel test robot
<rong.a.chen@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: e19dfdc83b60f196e0653d683499f7bc5548128f ("kernfs: initialize security of newly created nodes")
> https://git.kernel.org/cgit/linux/kernel/git/pcmoore/selinux.git next
>
> in testcase: locktorture
> with following parameters:
>
>         runtime: 300s
>         test: default
>
> test-description: This torture test consists of creating a number of kernel threads which acquire the lock and hold it for specific amount of time, thus simulating different critical region behaviors.
> test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.txt
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +-------------------------------------------------+------------+------------+
> |                                                 | ec882da5cd | e19dfdc83b |
> +-------------------------------------------------+------------+------------+
> | boot_successes                                  | 0          | 0          |
> | boot_failures                                   | 8          | 8          |
> | BUG:kernel_reboot-without-warning_in_test_stage | 8          |            |
> | BUG:KASAN:global-out-of-bounds_in_s             | 0          | 8          |
> +-------------------------------------------------+------------+------------+
>
>
>
> [   27.938038] BUG: KASAN: global-out-of-bounds in strcmp+0x97/0xa0
> [   27.940755] Read of size 1 at addr ffffffff946a83d7 by task systemd/1
> [   27.943554]
> [   27.944603] CPU: 0 PID: 1 Comm: systemd Not tainted 5.1.0-rc1-00010-ge19dfdc #1
> [   27.948091] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   27.951946] Call Trace:
> [   27.953353]  ? strcmp+0x97/0xa0
> [   27.955026]  print_address_description+0x22/0x270
> [   27.957203]  ? strcmp+0x97/0xa0
> [   27.958841]  kasan_report+0x13b/0x1d0
> [   27.960759]  ? strcmp+0x97/0xa0
> [   27.962378]  ? strcmp+0x97/0xa0
> [   27.963976]  strcmp+0x97/0xa0
> [   27.965846]  simple_xattr_get+0x7b/0x120
> [   27.967473]  selinux_kernfs_init_security+0x108/0x440
> [   27.969360]  ? __radix_tree_replace+0x9a/0x230
> [   27.971200]  ? selinux_secctx_to_secid+0x20/0x20
> [   27.973011]  ? __fprop_inc_percpu_max+0x190/0x190
> [   27.975563]  ? kvm_sched_clock_read+0x12/0x20
> [   27.977907]  ? sched_clock+0x5/0x10
> [   27.979867]  ? sched_clock_cpu+0x24/0xb0
> [   27.982048]  ? idr_alloc_cyclic+0xcb/0x190
> [   27.984229]  ? lock_downgrade+0x620/0x620
> [   27.986388]  security_kernfs_init_security+0x3c/0x70
> [   27.989012]  __kernfs_new_node+0x403/0x5e0
> [   27.991195]  ? kernfs_dop_revalidate+0x330/0x330
> [   27.993589]  ? css_next_child+0xec/0x260
> [   27.995685]  ? css_next_descendant_pre+0x36/0x110
> [   27.998115]  ? cgroup_propagate_control+0x2d6/0x460
> [   28.000662]  kernfs_new_node+0x72/0x140
> [   28.002818]  ? lockdep_hardirqs_on+0x379/0x560
> [   28.005171]  ? cgroup_idr_replace+0x35/0x40
> [   28.007417]  kernfs_create_dir_ns+0x26/0x130
> [   28.009690]  cgroup_mkdir+0x3b9/0xef0
> [   28.011764]  ? cgroup_destroy_locked+0x5e0/0x5e0
> [   28.014196]  kernfs_iop_mkdir+0x12f/0x1b0
> [   28.016396]  vfs_mkdir+0x2e6/0x510
> [   28.018317]  do_mkdirat+0x19b/0x1f0
> [   28.020284]  ? __x64_sys_mknod+0xb0/0xb0
> [   28.022437]  do_syscall_64+0xe5/0x10d0
> [   28.024408]  ? syscall_return_slowpath+0x790/0x790
> [   28.026874]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
> [   28.029504]  ? trace_hardirqs_off_caller+0x58/0x200
> [   28.031993]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [   28.034438]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   28.036748] RIP: 0033:0x7f38cab6f447
> [   28.038825] Code: 00 b8 ff ff ff ff c3 0f 1f 40 00 48 8b 05 49 da 2b 00 64 c7 00 5f 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 21 da 2b 00 f7 d8 64 89 01 48
> [   28.047736] RSP: 002b:00007ffeef143d88 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
> [   28.051776] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f38cab6f447
> [   28.055117] RDX: 00007ffeef143c30 RSI: 00000000000001ed RDI: 000055a7b0458560
> [   28.058533] RBP: 0000000000000040 R08: 0000000000000000 R09: 2f73662f7379732f
> [   28.062031] R10: 732f70756f726763 R11: 0000000000000246 R12: 000055a7b04b30a0
> [   28.065528] R13: 0000000000000000 R14: 000055a7b046bb88 R15: 000055a7b046b540
> [   28.068977]
> [   28.070240] The buggy address belongs to the variable:
> [   28.072491]  securityfs_super_operations+0x4917/0x6220
> [   28.075171]
> [   28.076286] Memory state around the buggy address:
> [   28.078861]  ffffffff946a8280: fa fa fa fa 00 01 fa fa fa fa fa fa 00 02 fa fa
> [   28.082610]  ffffffff946a8300: fa fa fa fa 00 02 fa fa fa fa fa fa 00 01 fa fa
> [   28.086669] >ffffffff946a8380: fa fa fa fa 00 03 fa fa fa fa fa fa 00 fa fa fa
> [   28.090587]                                                  ^
> [   28.093576]  ffffffff946a8400: fa fa fa fa 00 00 00 00 00 00 05 fa fa fa fa fa
> [   28.097599]  ffffffff946a8480: 00 00 01 fa fa fa fa fa 00 00 00 00 00 00 00 00
> [   28.101453] ==================================================================
> [   28.105478] Disabling lock debugging due to kernel taint
>          Starting Load Kernel Modules...
>          Mounting Debug File System...
> ] Listening on RPCbind Server Activation Socket.
>          Starting Remount Root and Kernel File Systems...
>          Starting Journal Service...
>          Mounting RPC Pipe File System...
> [   28.508319] _warn_unseeded_randomness: 131 callbacks suppressed
> [   28.508335] random: get_random_u64 called from copy_process+0x596/0x6450 with crng_init=1
>          Starting Create Static Device Nodes in /dev...
> [   28.552988] random: get_random_u64 called from arch_pick_mmap_layout+0x4a1/0x600 with crng_init=1
> [   28.556785] random: get_random_u64 called from arch_pick_mmap_layout+0x446/0x600 with crng_init=1
>          Starting Load/Save Random Seed...
>          Starting udev Coldplug all Devices...
>          Mounting FUSE Control File System...
>          Starting Apply Kernel Variables...
>          Mounting Configuration File System...
>          Starting Raise network interfaces...
>          Starting Preprocess NFS configuration...
>          Starting udev Kernel Device Manager...
>          Starting Flush Journal to Persistent Storage...
>          Starting Create Volatile Files and Directories...
> [   29.523554] random: get_random_u64 called from arch_pick_mmap_layout+0x446/0x600 with crng_init=1
> [   29.527262] random: get_random_u64 called from load_elf_binary+0x1281/0x2f30 with crng_init=1
>
>          Starting RPC bind portmap service...
>          Starting Network Time Synchronization...
>          Starting Update UTMP about System Boot/Shutdown...
> [   30.574449] _warn_unseeded_randomness: 154 callbacks suppressed
> [   30.574479] random: get_random_u32 called from bucket_table_alloc+0x149/0x370 with crng_init=1
> [   32.628754] random: get_random_u64 called from arch_pick_mmap_layout+0x4a1/0x600 with crng_init=1
> [   32.632973] random: get_random_u64 called from arch_pick_mmap_layout+0x446/0x600 with crng_init=1
> [   32.637364] random: get_random_u64 called from load_elf_binary+0x1281/0x2f30 with crng_init=1
>          Starting Login Service...
>          Starting LSB: Start and stop bmc-watchdog...
>          Starting LSB: Execute the kexec -e command to reboot system...
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.1.0-rc1-00010-ge19dfdc .config
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage
>
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
>
>
>
>
> Thanks,
> Rong Chen
>


-- 
paul moore
www.paul-moore.com
