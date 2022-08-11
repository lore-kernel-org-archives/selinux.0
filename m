Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148A7C19F2A
	for <selinux@archiver.kernel.org>; Thu, 11 Aug 2022 12:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiHKMzG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Aug 2022 08:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiHKMzE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Aug 2022 08:55:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ADB6E889
        for <selinux@vger.kernel.org>; Thu, 11 Aug 2022 05:55:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k26so33361543ejx.5
        for <selinux@vger.kernel.org>; Thu, 11 Aug 2022 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:subject:to:content-language:user-agent
         :mime-version:date:message-id:from:from:to:cc;
        bh=rz3NKiMzx1IC8RHsJdZftsxZHAdDkTKNsQ02w+44Rss=;
        b=chW9KFtPDudSeuqWPMSMH09brIFhEkw6yb/rQVMhGzKk3bqzHSeKvDcvyWfmKBSEwW
         93wV2GZlQUHZx57gfAsAl3QliIwqlCbgVNeStta/nZ5gL18RJ6Z/kYtWWETaybHkHgbH
         n9scIceDS6slb6prFikpUZUR+xG4MGJhIYT/6XkwPq0i+QKvCPEPSb+cjK/+IVDujHXT
         1ehdcFe1woYhsCmhN8hpUN+kV37e+ALd1FDeWfRngaCzzTLlgfGNin1+vU26xggwldJw
         2gc19pJWjDUbYwHUGgvLEwHDLkdb4M67h/7biMURftaXbfbhcoLjGiviH+i1sQ/a9XbL
         CPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:content-language:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc;
        bh=rz3NKiMzx1IC8RHsJdZftsxZHAdDkTKNsQ02w+44Rss=;
        b=2nQk2DglV1Z0qfB5wWcrd6bVaVIc5UIvWBkxH/LHcB6h3hoUOw/rqiC8j4Ux2Dcqm1
         FsjCdDLi8zQaNhAJ6PyfhG+ch08hrlZjW6zMPSJ/NdtJ4f98JQTTZwBED9JJsx5K27do
         COTbR/fJVOtzdakakKfYLA2M87Yo85xWRvrHdrkKvqEj7pCvPR+kK5Yqb7bPMsA/Qcbf
         xrPecLiHCOnxmJvA5piXeb37M96uAvK/0OMzMQpbhAgQY3b0w+PjTBBYIpTd5qEJH7rx
         sABhv60Oyccmp4T/mASzc9OIZgSJeenDZP2qAuHa2qiDBDCF8tNNDFojDEsVhMjdUP3w
         57XA==
X-Gm-Message-State: ACgBeo2frLQquD6kqUht5o+GcJ0OvP+rtgmMagc/THX/Er7mFsafuSIP
        Q8Ws64Y0NV27Gh1Oe73mA6wBFLOKuMk=
X-Google-Smtp-Source: AA6agR75gpBaB6mPa5q4JYpdiiTFNkJw6us8KgTEgDbulJWiXszk+Q/+CJn91eJYZ4el6UdzamiN7g==
X-Received: by 2002:a17:907:6818:b0:730:825d:7296 with SMTP id qz24-20020a170907681800b00730825d7296mr25044978ejc.21.1660222500507;
        Thu, 11 Aug 2022 05:55:00 -0700 (PDT)
Received: from ?IPV6:2001:a61:3450:ee01:9da9:8337:59d2:c8c4? ([2001:a61:3450:ee01:9da9:8337:59d2:c8c4])
        by smtp.gmail.com with ESMTPSA id z4-20020aa7cf84000000b0043d5ead65a6sm9067421edx.84.2022.08.11.05.54.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 05:55:00 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Message-ID: <58075d35-609b-bb9e-edc9-d1ccaa8ff725@gmail.com>
Date:   Thu, 11 Aug 2022 14:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Content-Language: en-US
To:     selinux <selinux@vger.kernel.org>
Subject: [BUG] (fsuse xattr "fuse" mycontext) causes deadlock for mount/sync
 syscall
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

I've first discovered this on my debian unstable laptop running "Linux glados 5.18.0-3-amd64 #1 SMP PREEMPT_DYNAMIC Debian 5.18.14-1 (2022-07-23) x86_64 GNU/Linux" while implementing a policy for xdg-desktop-portal which uses a fusefs.
The issue was reproducible in a VM using sshfs.
I am not sure if this is user error or an oversight.

Steps to reproduce:
1. Install sshfs (or another fusefs)
2. Ensure the policy has a `(fsuse xattr "fuse" mycontext)` statement
3. Attempt to Mount a sshfs
4. Attempt to run sync

The sshfs program will hang forever in the mount syscall, while the sync program will hang forever in the sync syscall.

My theory on what is happening:

1. fusermount calls the mount syscall
2. The filesystem superblock is inserted into the global list, however it isn't mounted anywhere and the lock is held.
3. The SELinux mount hook is called.
4. As per policy the sb_check_xattr_support function is called.
5. sb_check_xattr_support will issue a getxattr request on the root inode of the fuse filesystem
6. The getxattr operation is transmitted (I don't know how) to the userspace program fusermount

This leads to a deadlock, since fusermount is inside the mount syscall it won't respond to the getxattr operation required to finish mounting.
At the same time the filesystem super block has already been inserted into a global list, meaning that the sync syscall will now hang (forever).

Terminating the sshfs program will interrupt the syscall.
SELinux will print an error, the filesystem is removed from the global list and the sync syscall can continue.

A few logs from my laptop during shutdown that match my observations:

> Aug 11 00:46:01 glados systemd[1]: session-1.scope: Stopping timed out. Killing.
PID 1 starts killing my normal user process, including the stuck xdg-desktop-portal / fusermount.

> Aug 11 00:46:01 glados kernel: SELinux: (dev fuse, type fuse) getxattr errno 4
This is a warning from the sb_check_xattr_support function, because the getxattr request was interrupted (EINTR: 4)

> Aug 11 00:44:31 glados audit[105683]: SYSCALL arch=c000003e syscall=165 success=no exit=-4 a0=55d5501f22d0 a1=55d55018b7bb a2=55d5501f2240 a3=6 items=0 ppid=1947 pid=105683 auid=1001 uid=1001 gid=1001 euid=0 suid=0 fsuid=0 egid=1001 sgid=1001 fsgid=1001 tty=(none) ses=4 comm="fusermount3" exe="/usr/bin/fusermount3" subj=user.user:user.role:xdg.document_portal.type:s0-s0:c0.c1023 key=(null)
> Aug 11 00:44:31 glados audit: PROCTITLE proctitle="(null)"
These are the audit logs, indicating the the mount syscall from xdg-desktop-portal has returned with EINTR.

> Aug 11 00:46:01 glados xdg-document-portal[1947]: error: fuse init failed: Can't mount path /run/user/1001/doc
And finally xdg-document-portal complains about being unable to actually mount the filesystem.

And the logs showing where sync hangs:
> Aug 09 11:11:51 glados kernel: INFO: task sync:44108 blocked for more than 1208 seconds.
> Aug 09 11:11:51 glados kernel:       Not tainted 5.18.0-3-amd64 #1 Debian 5.18.14-1
> Aug 09 11:11:51 glados kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Aug 09 11:11:51 glados kernel: task:sync            state:D stack:    0 pid:44108 ppid: 37268 flags:0x00004004
> Aug 09 11:11:51 glados kernel: Call Trace:
> Aug 09 11:11:51 glados kernel:  <TASK>
> Aug 09 11:11:51 glados kernel:  __schedule+0x30b/0x9f0
> Aug 09 11:11:51 glados kernel:  schedule+0x4e/0xb0
> Aug 09 11:11:51 glados kernel:  rwsem_down_read_slowpath+0x33b/0x380
> Aug 09 11:11:51 glados kernel:  ? __x64_sys_tee+0xd0/0xd0
> Aug 09 11:11:51 glados kernel:  iterate_supers+0x6f/0xf0
> Aug 09 11:11:51 glados kernel:  ksys_sync+0x40/0xa0
> Aug 09 11:11:51 glados kernel:  __do_sys_sync+0xa/0x20
> Aug 09 11:11:51 glados kernel:  do_syscall_64+0x38/0xc0
> Aug 09 11:11:51 glados kernel:  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> Aug 09 11:11:51 glados kernel: RIP: 0033:0x7ff78490b347
> Aug 09 11:11:51 glados kernel: RSP: 002b:00007fff979d3958 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
> Aug 09 11:11:51 glados kernel: RAX: ffffffffffffffda RBX: 00007fff979d3a98 RCX: 00007ff78490b347
> Aug 09 11:11:51 glados kernel: RDX: 00007ff7849eb801 RSI: 0000000000000000 RDI: 00007ff7849afde5
> Aug 09 11:11:51 glados kernel: RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> Aug 09 11:11:51 glados kernel: R10: fffffffffffffb7d R11: 0000000000000202 R12: 0000000000000000
> Aug 09 11:11:51 glados kernel: R13: 0000000000000000 R14: 000055ad930da0fb R15: 000055ad930dcd00
> Aug 09 11:11:51 glados kernel:  </TASK>

Thanks, Jonathan Hettwer

-- 
bauen1
