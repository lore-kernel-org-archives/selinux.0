Return-Path: <SRS0=gWJv=57=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426C0C2BA19
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 12:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9D920767
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 12:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ1Up85F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369563AbgDOMbX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369557AbgDOMbT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Apr 2020 08:31:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E864C061A0C
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 05:31:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m21so1424094pff.13
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=ZNgONq080QCupEhBG/Xmg/mjsmV0cAhJB9zpip+oA1E=;
        b=jJ1Up85FELKMmid3aDY/v3bKsfZb7dVWx1nRlzxCeyJDoXl+UwLtuoyPqu4//7x5df
         GfLFwUqBGHWwo/4rvPsYElpUYErg8nfBFeq5vAJMlXjhTGbUBb+ba9kQ8am3IgZv69YI
         rsVOyI1beJlCDxFY+DIxHoAhLdjljuKh141otanlcxbZUwQjkakWICrdwioyzOTCFniq
         T60qN46ua+tvwEIp4rDvmwXJL0comZa3H2k40GJF4/g8yDdniCalsOR7q0HRSBYhOlfl
         +nWUs1ifqe+ra3tHGl9Ri7Gt8KYC0XC2xgcqiJ9yofBtlNpKSH5YwIqMG3hT1Z1WRygr
         m7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=ZNgONq080QCupEhBG/Xmg/mjsmV0cAhJB9zpip+oA1E=;
        b=DndYSrDhC12x4SFGSwmD95vYhevt+yrh9d/il7oS6wr3bGL+sVOJwH79PEAXwwlzWI
         Ao+FS/4mzMZahJj3HX71D/8Qd0k70sHs/383TpzufkEPUAbCS8TVt5pTSYH8VRrh5SSr
         0ZzqHcz02LOZXi4kWcqO41Xz6ZHlveymyKLt4mxX0h6EOMhznT1hvXP0BFWFNKftqraH
         zaghbKFI36Pkz5Ww7sPJcw6KqrpMNQiZjXvO2HLXEvbe0DprD8QgTtgSfHc3OaaNbst+
         mI24DTipO/KGWbRSQZUnsgd3i9QWgIcQolx5TOkdoJ7wUbmVuGm5VTREnWnDfI7dsSQe
         nTpw==
X-Gm-Message-State: AGi0Pua77p/QGeBWWpPei013SXvxWUy8N4N+Vm3wLrYB6Lsm3c+dJwGq
        aR/1Uexv94QJLXAXJNs7ScHhbWQZqes=
X-Google-Smtp-Source: APiQypKsprn4Zy8kCIOYggvO4UZA+sc6vJm9E0YWARsHyANl2R/fa6EQmNW2v5sAStwK+ZrHoRqUZQ==
X-Received: by 2002:a63:954b:: with SMTP id t11mr26585786pgn.309.1586953877784;
        Wed, 15 Apr 2020 05:31:17 -0700 (PDT)
Received: from ?IPv6:2408:8210:a802:abc0:4f0:68fe:470f:b1f3? ([2408:8210:a802:abc0:4f0:68fe:470f:b1f3])
        by smtp.gmail.com with ESMTPSA id m189sm5305390pfm.60.2020.04.15.05.31.15
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 05:31:17 -0700 (PDT)
From:   =?UTF-8?B?6YOt5b2s?= <anole1949@gmail.com>
Subject: ebitmap_node ate over 40GB of memory
To:     selinux@vger.kernel.org
Message-ID: <ebe1a7cc-6a42-0e2d-d704-23011ee2d1d3@gmail.com>
Date:   Wed, 15 Apr 2020 20:31:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: tl
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I'm running a batch of CoreOS boxes, the lsb_release is:

```
# cat /etc/lsb-release
DISTRIB_ID="Container Linux by CoreOS"
DISTRIB_RELEASE=2303.3.0
DISTRIB_CODENAME="Rhyolite"
DISTRIB_DESCRIPTION="Container Linux by CoreOS 2303.3.0 (Rhyolite)"
```

```
# uname -a
Linux cloud-worker-25 4.19.86-coreos #1 SMP Mon Dec 2 20:13:38 -00 2019 
x86_64 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz GenuineIntel GNU/Linux
```
Recently, I found my vms constently being killed due to OOM, and after 
digging into the problem, I finally realized that the kernel is leaking 
memory.

Here's my slabinfo:

```
# slabtop --sort c -o
  Active / Total Objects (% used)    : 739390584 / 740008326 (99.9%)
  Active / Total Slabs (% used)      : 11594275 / 11594275 (100.0%)
  Active / Total Caches (% used)     : 105 / 129 (81.4%)
  Active / Total Size (% used)       : 47121380.33K / 47376581.93K (99.5%)
  Minimum / Average / Maximum Object : 0.01K / 0.06K / 8.00K

   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
734506368 734506368 100%    0.06K 11476662       64 45906648K ebitmap_node
328160  80830  24%    0.50K  10255       32    164080K kmalloc-512
  69442  36292  52%    2.00K   4341       16    138912K kmalloc-2048
  13148  12571  95%    7.50K   3287        4    105184K task_struct
  85359  75134  88%    1.05K   2857       30     91424K ext4_inode_cache
462336 459563  99%    0.19K  11008       42     88064K cred_jar
382641 323093  84%    0.19K   9125       42     73000K dentry
251968 249625  99%    0.25K   7874       32     62992K filp
  51488  41972  81%    1.00K   1609       32     51488K kmalloc-1024
  78846  77530  98%    0.59K   1461       54     46752K inode_cache
  69342  68580  98%    0.66K   1449       48     46368K proc_inode_cache
  70000  63132  90%    0.57K   2500       28     40000K radix_tree_node
  56902  56673  99%    0.69K   1237       46     39584K sock_inode_cache
  57504  54982  95%    0.66K   1198       48     38336K ovl_inode
   9056   9007  99%    4.00K   1132        8     36224K kmalloc-4096
  31756  31756 100%    1.00K    995       32     31840K UNIX
504192 501166  99%    0.06K   7878       64     31512K anon_vma_chain
  27660  27660 100%    1.06K    922       30     29504K signal_cache
336950 335179  99%    0.09K   7325       46     29300K anon_vma
  26400  26400 100%    1.06K    880       30     28160K mm_struct
  38042  38042 100%    0.69K    827       46     26464K files_cache
  12315  12298  99%    2.06K    821       15     26272K sighand_cache
   3001   3001 100%    8.00K    763        4     24416K kmalloc-8192
  74336  73888  99%    0.25K   2323       32     18584K skbuff_head_cache
186102  63644  34%    0.09K   4431       42     17724K kmalloc-96
  24104  22322  92%    0.69K    524       46     16768K shmem_inode_cache
527360 479425  90%    0.03K   4120      128     16480K kmalloc-32
140439 137220  97%    0.10K   3601       39     14404K buffer_head
  10075  10075 100%    1.25K    403       25     12896K UDPv6
183808 158004  85%    0.06K   2872       64     11488K kmalloc-64
  60102  47918  79%    0.19K   1431       42     11448K kmalloc-192
  84704  84704 100%    0.12K   2647       32     10588K pid
  72450  72243  99%    0.13K   2415       30      9660K kernfs_node_cache
131152 131152 100%    0.07K   2342       56      9368K Acpi-Operand
   4020   4020 100%    2.12K    268       15      8576K TCP
   6936   6936 100%    0.94K    204       34      6528K RAW
118320 107640  90%    0.04K   1160      102      4640K numa_policy
  11340  11191  98%    0.38K    270       42      4320K mnt_cache
   1750   1750 100%    2.25K    125       14      4000K TCPv6
   3472   3360  96%    1.12K    124       28      3968K RAWv6
  14976  14893  99%    0.25K    468       32      3744K kmalloc-256
  29728  25895  87%    0.12K    929       32      3716K kmalloc-128
  86190  86190 100%    0.04K    845      102      3380K pde_opener
  44240  44240 100%    0.07K    790       56      3160K eventpoll_pwq
   7392   7222  97%    0.38K    176       42      2816K kmem_cache
329728 329728 100%    0.01K    644      512      2576K kmalloc-8
    320    300  93%    8.00K     80        4      2560K biovec-max
142080 136981  96%    0.02K    555      256      2220K kmalloc-16
  13248  13248 100%    0.12K    414       32      1656K secpath_cache
   6432   5952  92%    0.25K    201       32      1608K pool_workqueue
  10540  10540 100%    0.12K    310       34      1240K jbd2_journal_head
   2400   2400 100%    0.50K     75       32      1200K skbuff_fclone_cache
  29886  29886 100%    0.04K    293      102      1172K ext4_extent_status
   3672   3431  93%    0.31K     72       51      1152K nf_conntrack
  17664  17472  98%    0.06K    276       64      1104K ext4_io_end
   1518   1518 100%    0.69K     33       46      1056K bio-2
   1344   1344 100%    0.75K     32       42      1024K task_group
    256    256 100%    4.00K     32        8      1024K names_cache
   1024   1024 100%    1.00K     32       32      1024K biovec-64
   1632   1632 100%    0.62K     32       51      1024K dio
   4352   4352 100%    0.23K    128       34      1024K tw_sock_TCPv6
   1120   1120 100%    0.91K     32       35      1024K sw_flow
   5292   5292 100%    0.19K    126       42      1008K proc_dir_entry
   6748   6748 100%    0.14K    241       28       964K ext4_groupinfo_4k
   3536   3536 100%    0.23K    104       34       832K tw_sock_TCP
    286    286 100%    2.75K     26       11       832K iommu_domain
    816    816 100%    0.94K     24       34       768K mqueue_inode_cache
  14016  14016 100%    0.05K    192       73       768K mbcache
    819    377  46%    0.81K     21       39       672K bdev_cache
  24480  24480 100%    0.02K    144      170       576K avtab_node
   2940   2940 100%    0.19K     70       42       560K dmaengine-unmap-16
     85     85 100%    5.50K     17        5       544K net_namespace
   1568   1568 100%    0.32K     32       49       512K taskstats
   1696   1696 100%    0.30K     32       53       512K request_sock_TCP
   8128   8128 100%    0.06K    127       64       508K kmem_cache_node
   1073   1073 100%    0.43K     29       37       464K uts_namespace
   3420   3360  98%    0.13K    114       30       456K dm_bufio_buffer-4
   1404   1404 100%    0.30K     27       52       432K blkdev_requests
    169     98  57%    2.40K     13       13       416K request_queue
   3328   3328 100%    0.12K    104       32       416K scsi_sense_cache
   5049   5049 100%    0.08K     99       51       396K inotify_inode_mark
  23040  23040 100%    0.02K     90      256       360K 
selinux_file_security
  10240  10240 100%    0.03K     80      128       320K fscrypt_info
   1120   1120 100%    0.25K     35       32       280K dquot
   1734   1734 100%    0.16K     34       51       272K sigqueue
   5525   5525 100%    0.05K     65       85       260K ftrace_event_field
   1280   1280 100%    0.20K     32       40       256K file_lock_cache
   1088   1088 100%    0.23K     32       34       256K posix_timers_cache
   1092   1092 100%    0.20K     28       39       224K ip4-frags
   1564   1564 100%    0.09K     34       46       136K trace_event_file
   1287   1287 100%    0.10K     33       39       132K blkdev_ioc
   2336   2336 100%    0.05K     32       73       128K Acpi-Parse
   4096   4096 100%    0.03K     32      128       128K avc_xperms_data
    208    157  75%    0.61K      4       52       128K 
hugetlbfs_inode_cache
   2720   2720 100%    0.05K     32       85       128K fscrypt_ctx
   1024   1024 100%    0.12K     32       32       128K 
ext4_allocation_context
     88     88 100%    0.72K      2       44        64K fat_inode_cache
     30     30 100%    1.06K      1       30        32K dmaengine-unmap-128
     15     15 100%    2.06K      1       15        32K dmaengine-unmap-256
     16     16 100%    2.00K      1       16        32K biovec-128
   1024   1024 100%    0.03K      8      128        32K dnotify_struct
      8      8 100%    4.00K      1        8        32K sgpool-128
    306    306 100%    0.08K      6       51        24K Acpi-State
     32     32 100%    0.50K      1       32        16K dma-kmalloc-512
    512    512 100%    0.02K      2      256         8K jbd2_revoke_table_s
      0      0   0%    0.09K      0       42         0K dma-kmalloc-96
      0      0   0%    0.19K      0       42         0K dma-kmalloc-192
      0      0   0%    0.01K      0      512         0K dma-kmalloc-8
      0      0   0%    0.02K      0      256         0K dma-kmalloc-16
      0      0   0%    0.03K      0      128         0K dma-kmalloc-32
      0      0   0%    0.06K      0       64         0K dma-kmalloc-64
      0      0   0%    0.12K      0       32         0K dma-kmalloc-128
      0      0   0%    0.25K      0       32         0K dma-kmalloc-256
      0      0   0%    1.00K      0       32         0K dma-kmalloc-1024
      0      0   0%    2.00K      0       16         0K dma-kmalloc-2048
      0      0   0%    4.00K      0        8         0K dma-kmalloc-4096
      0      0   0%    8.00K      0        4         0K dma-kmalloc-8192
      0      0   0%    0.12K      0       34         0K iint_cache
      0      0   0%    0.45K      0       35         0K user_namespace
      0      0   0%    0.94K      0       34         0K PING
      0      0   0%    0.31K      0       51         0K xfrm_dst_cache
      0      0   0%    0.12K      0       34         0K cfq_io_cq
      0      0   0%    0.30K      0       53         0K request_sock_TCPv6
      0      0   0%    1.12K      0       28         0K PINGv6
      0      0   0%    2.57K      0       12         0K dm_uevent
      0      0   0%    3.23K      0        9         0K kcopyd_job
      0      0   0%    0.04K      0      102         0K fat_cache
      0      0   0%    0.21K      0       37         0K nf_conntrack_expect
      0      0   0%    0.09K      0       42         0K nf_conncount_rb
```
You can see that the `ebitmap_node` is over 40GB and still growing. The 
only thing I can do is rebooting the OS, but there are tens of them and 
lots of workloads running on them, I can't just reboot whenever I want.
So, I run out of options, any help?
