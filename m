Return-Path: <SRS0=xPIW=XC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12B3C43140
	for <selinux@archiver.kernel.org>; Sat,  7 Sep 2019 13:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55B6218AE
	for <selinux@archiver.kernel.org>; Sat,  7 Sep 2019 13:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391026AbfIGNO3 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Sat, 7 Sep 2019 09:14:29 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:32862 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbfIGNO3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 7 Sep 2019 09:14:29 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C1B23560785;
        Sat,  7 Sep 2019 15:14:24 +0200 (CEST)
Received: by mail-ot1-f45.google.com with SMTP id b2so8351062otq.10;
        Sat, 07 Sep 2019 06:14:24 -0700 (PDT)
X-Gm-Message-State: APjAAAXlLUcFGwO4pdLLJc4rOTwWJ39snEfO5w7gy975vmf+l1P74l8m
        lzbHrVF7B0mv7pIoFj2MRgmY1omgxolTpYfA8+A=
X-Google-Smtp-Source: APXvYqzW1SiATrQ3xWLAsucUi2a7piilMg9btpZ01ylKyNy42qDX/hj1EWRXOLlBKzc6z3S1uAQ5ZBRsuOIrLhGTp8Y=
X-Received: by 2002:a9d:e92:: with SMTP id 18mr5920939otj.321.1567862063741;
 Sat, 07 Sep 2019 06:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <6d208e36-cf81-7fde-2b57-fddf4a529f52@debian.org>
In-Reply-To: <6d208e36-cf81-7fde-2b57-fddf4a529f52@debian.org>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 7 Sep 2019 15:14:12 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nTK1uO0j7wbevyitrNv_1RYyLpgzMPWjJkM3Mzpcg7ag@mail.gmail.com>
Message-ID: <CAJfZ7=nTK1uO0j7wbevyitrNv_1RYyLpgzMPWjJkM3Mzpcg7ag@mail.gmail.com>
Subject: Re: Permissions in the udevadm_t domain
To:     Laurent Bigonville <bigon@debian.org>,
        selinux-refpolicy@vger.kernel.org
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Sep  7 15:14:25 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

[Adding selinux-refpolicy@vger.kernel.org, which is better suited for
questions related to refpolicy]

On Sat, Sep 7, 2019 at 12:19 PM Laurent Bigonville <bigon@debian.org> wrote:
>
> (Re-sending it because thunderbird decided to send it in HTML...)
>
> Hello,
>
> One of the remaining blocker to have (a very minimal) debian buster boot
> in enforcing mode with the refpolicy is systemd-udev-trigger.service
> which call udevadm
>
> On my test VM I see the two following denials:
>
> ----
> type=PROCTITLE msg=audit(06/09/19 18:32:23.171:98) : proctitle=/bin/udevadm trigger --type=devices --action=add
> type=PATH msg=audit(06/09/19 18:32:23.171:98) : item=0 name=/run/udev/data/+platform:QEMU0002:00 inode=12544 dev=00:15 mode=file,644 ouid=root ogid=root rdev=00:00 obj=system_u:object_r:udev_var_run_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
> type=CWD msg=audit(06/09/19 18:32:23.171:98) : cwd=/
> type=SYSCALL msg=audit(06/09/19 18:32:23.171:98) : arch=x86_64 syscall=openat success=yes exit=5 a0=0xffffff9c a1=0x7ffd84825cc0 a2=O_RDONLY|O_CLOEXEC a3=0x0 items=1 ppid=1 pid=1140 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=udevadm exe=/usr/bin/udevadm subj=system_u:system_r:udevadm_t:s0 key=(null)
> type=AVC msg=audit(06/09/19 18:32:23.171:98) : avc:  denied  { open } for  pid=1140 comm=udevadm path=/run/udev/data/+platform:QEMU0002:00 dev="tmpfs" ino=12544 scontext=system_u:system_r:udevadm_t:s0 tcontext=system_u:object_r:udev_var_run_t:s0 tclass=file permissive=1
> type=AVC msg=audit(06/09/19 18:32:23.171:98) : avc:  denied  { read } for  pid=1140 comm=udevadm name=+platform:QEMU0002:00 dev="tmpfs" ino=12544 scontext=system_u:system_r:udevadm_t:s0 tcontext=system_u:object_r:udev_var_run_t:s0 tclass=file permissive=1
> ----
> type=PROCTITLE msg=audit(06/09/19 18:32:23.175:99) : proctitle=/bin/udevadm trigger --type=devices --action=add
> type=SYSCALL msg=audit(06/09/19 18:32:23.175:99) : arch=x86_64 syscall=fstat success=yes exit=0 a0=0x5 a1=0x7ffd84825be0 a2=0x7ffd84825be0 a3=0x0 items=0 ppid=1 pid=1140 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=udevadm exe=/usr/bin/udevadm subj=system_u:system_r:udevadm_t:s0 key=(null)
> type=AVC msg=audit(06/09/19 18:32:23.175:99) : avc:  denied  { getattr } for  pid=1140 comm=udevadm path=/run/udev/data/+platform:QEMU0002:00 dev="tmpfs" ino=12544 scontext=system_u:system_r:udevadm_t:s0 tcontext=system_u:object_r:udev_var_run_t:s0 tclass=file permissive=1
>
> And
>
> type=PROCTITLE msg=audit(29/08/19 15:37:14.505:417) : proctitle=/bin/udevadm trigger --type=subsystems --action=add
> type=PATH msg=audit(29/08/19 15:37:14.505:417) : item=0 name=/sys/module/snd_hda_codec_generic/uevent inode=17769 dev=00:13 mode=file,200 ouid=root ogid=root rdev=00:00 obj=system_u:object_r:sysfs_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
> type=CWD msg=audit(29/08/19 15:37:14.505:417) : cwd=/
> type=SYSCALL msg=audit(29/08/19 15:37:14.505:417) : arch=x86_64 syscall=openat success=no exit=EACCES(Permission non accordée) a0=0xffffff9c a1=0x7fff23710260 a2=O_RDONLY|O_CLOEXEC a3=0x0 items=1 ppid=1 pid=481 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=udevadm exe=/usr/bin/udevadm subj=system_u:system_r:udevadm_t:s0 key=(null)
> type=AVC msg=audit(29/08/19 15:37:14.505:417) : avc:  denied  { dac_override } for  pid=481 comm=udevadm capability=dac_override  scontext=system_u:system_r:udevadm_t:s0 tcontext=system_u:system_r:udevadm_t:s0 tclass=capability permissive=0
> type=AVC msg=audit(29/08/19 15:37:14.505:417) : avc:  denied  { dac_read_search } for  pid=481 comm=udevadm capability=dac_read_search  scontext=system_u:system_r:udevadm_t:s0 tcontext=system_u:system_r:udevadm_t:s0 tclass=capability permissive=0
>
> For the former, adding read_files_pattern(udevadm_t, udev_var_run_t,
> udev_var_run_t) fixes the issues (and then the VM boots fine).

Nice :) Could you please send a patch for this, or open a Pull Request
on https://github.com/SELinuxProject/refpolicy?

> But when
> looking at the current policy code I'm seeing that udevadm is allowed to
> delete files/directory/.. in /var/run and I'm wondering why. I've never
> seen this happening during my (limited) test, an idea?

Which policy? On my test system based on a lightly-patched refpolicy, I have:

# sesearch -A -s udevadm_t -t var_run_t
allow udevadm_t var_run_t:dir { getattr open search };
allow udevadm_t var_run_t:lnk_file { getattr read };

> For the later, it seems that the kernel the mode to 400 on some files in
> /sys (ie. --w------- 1 root root 4096 sep  5 17:06
> /sys/module/snd_hda_codec_generic/uevent) looking at the code it seems
> that udev is ready to handle EACCES already, so I was wondering, should
> we just allow dac_read_search or don't audit dac_read_search (and
> dac_override as well then)?

For the record, even with dac_read_search, opening this file fails
with EACCES, because the kernel did not implement show() on this sysfs
file (cf. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/module.c?h=v5.2#n1204
and kernfs_fop_open() in fs/kernfs/file.c). More precisely, openat()
returns EACCES because kernfs_fop_open() returns this error code when
trying to open a write-only file for reading. Unfortunately this check
happens after the capability checks, which is why you got the denials
for dac_override and dac_read_search.

I do not have an opinion about allowing dac_read_search vs.
dontaudit-ing dac_read_search and dac_override.

Kind regards,
Nicolas

