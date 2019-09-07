Return-Path: <SRS0=xPIW=XC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F832C43331
	for <selinux@archiver.kernel.org>; Sat,  7 Sep 2019 10:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69116206BB
	for <selinux@archiver.kernel.org>; Sat,  7 Sep 2019 10:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfIGKTG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 7 Sep 2019 06:19:06 -0400
Received: from ithil.bigon.be ([163.172.57.153]:48004 "EHLO ithil.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfIGKTF (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 7 Sep 2019 06:19:05 -0400
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id 943B31FE12
        for <selinux@vger.kernel.org>; Sat,  7 Sep 2019 12:19:03 +0200 (CEST)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id CnAIKl5PmXhh for <selinux@vger.kernel.org>;
        Sat,  7 Sep 2019 12:19:03 +0200 (CEST)
Received: from [IPv6:2a02:a03f:3c7a:f100:b31:3ea2:297c:1269] (unknown [IPv6:2a02:a03f:3c7a:f100:b31:3ea2:297c:1269])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA
        for <selinux@vger.kernel.org>; Sat,  7 Sep 2019 12:19:03 +0200 (CEST)
From:   Laurent Bigonville <bigon@debian.org>
Subject: Permissions in the udevadm_t domain
To:     selinux@vger.kernel.org
Message-ID: <6d208e36-cf81-7fde-2b57-fddf4a529f52@debian.org>
Date:   Sat, 7 Sep 2019 12:19:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

(Re-sending it because thunderbird decided to send it in HTML...)

Hello,

One of the remaining blocker to have (a very minimal) debian buster boot 
in enforcing mode with the refpolicy is systemd-udev-trigger.service 
which call udevadm

On my test VM I see the two following denials:

----
type=PROCTITLE msg=audit(06/09/19 18:32:23.171:98) : proctitle=/bin/udevadm trigger --type=devices --action=add
type=PATH msg=audit(06/09/19 18:32:23.171:98) : item=0 name=/run/udev/data/+platform:QEMU0002:00 inode=12544 dev=00:15 mode=file,644 ouid=root ogid=root rdev=00:00 obj=system_u:object_r:udev_var_run_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
type=CWD msg=audit(06/09/19 18:32:23.171:98) : cwd=/
type=SYSCALL msg=audit(06/09/19 18:32:23.171:98) : arch=x86_64 syscall=openat success=yes exit=5 a0=0xffffff9c a1=0x7ffd84825cc0 a2=O_RDONLY|O_CLOEXEC a3=0x0 items=1 ppid=1 pid=1140 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=udevadm exe=/usr/bin/udevadm subj=system_u:system_r:udevadm_t:s0 key=(null)
type=AVC msg=audit(06/09/19 18:32:23.171:98) : avc:  denied  { open } for  pid=1140 comm=udevadm path=/run/udev/data/+platform:QEMU0002:00 dev="tmpfs" ino=12544 scontext=system_u:system_r:udevadm_t:s0 tcontext=system_u:object_r:udev_var_run_t:s0 tclass=file permissive=1
type=AVC msg=audit(06/09/19 18:32:23.171:98) : avc:  denied  { read } for  pid=1140 comm=udevadm name=+platform:QEMU0002:00 dev="tmpfs" ino=12544 scontext=system_u:system_r:udevadm_t:s0 tcontext=system_u:object_r:udev_var_run_t:s0 tclass=file permissive=1
----
type=PROCTITLE msg=audit(06/09/19 18:32:23.175:99) : proctitle=/bin/udevadm trigger --type=devices --action=add
type=SYSCALL msg=audit(06/09/19 18:32:23.175:99) : arch=x86_64 syscall=fstat success=yes exit=0 a0=0x5 a1=0x7ffd84825be0 a2=0x7ffd84825be0 a3=0x0 items=0 ppid=1 pid=1140 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=udevadm exe=/usr/bin/udevadm subj=system_u:system_r:udevadm_t:s0 key=(null)
type=AVC msg=audit(06/09/19 18:32:23.175:99) : avc:  denied  { getattr } for  pid=1140 comm=udevadm path=/run/udev/data/+platform:QEMU0002:00 dev="tmpfs" ino=12544 scontext=system_u:system_r:udevadm_t:s0 tcontext=system_u:object_r:udev_var_run_t:s0 tclass=file permissive=1

And

type=PROCTITLE msg=audit(29/08/19 15:37:14.505:417) : proctitle=/bin/udevadm trigger --type=subsystems --action=add
type=PATH msg=audit(29/08/19 15:37:14.505:417) : item=0 name=/sys/module/snd_hda_codec_generic/uevent inode=17769 dev=00:13 mode=file,200 ouid=root ogid=root rdev=00:00 obj=system_u:object_r:sysfs_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
type=CWD msg=audit(29/08/19 15:37:14.505:417) : cwd=/
type=SYSCALL msg=audit(29/08/19 15:37:14.505:417) : arch=x86_64 syscall=openat success=no exit=EACCES(Permission non accordée) a0=0xffffff9c a1=0x7fff23710260 a2=O_RDONLY|O_CLOEXEC a3=0x0 items=1 ppid=1 pid=481 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=udevadm exe=/usr/bin/udevadm subj=system_u:system_r:udevadm_t:s0 key=(null)
type=AVC msg=audit(29/08/19 15:37:14.505:417) : avc:  denied  { dac_override } for  pid=481 comm=udevadm capability=dac_override  scontext=system_u:system_r:udevadm_t:s0 tcontext=system_u:system_r:udevadm_t:s0 tclass=capability permissive=0
type=AVC msg=audit(29/08/19 15:37:14.505:417) : avc:  denied  { dac_read_search } for  pid=481 comm=udevadm capability=dac_read_search  scontext=system_u:system_r:udevadm_t:s0 tcontext=system_u:system_r:udevadm_t:s0 tclass=capability permissive=0

For the former, adding read_files_pattern(udevadm_t, udev_var_run_t, 
udev_var_run_t) fixes the issues (and then the VM boots fine). But when 
looking at the current policy code I'm seeing that udevadm is allowed to 
delete files/directory/.. in /var/run and I'm wondering why. I've never 
seen this happening during my (limited) test, an idea?

For the later, it seems that the kernel the mode to 400 on some files in 
/sys (ie. --w------- 1 root root 4096 sep  5 17:06 
/sys/module/snd_hda_codec_generic/uevent) looking at the code it seems 
that udev is ready to handle EACCES already, so I was wondering, should 
we just allow dac_read_search or don't audit dac_read_search (and 
dac_override as well then)?

I can provide patches if you want

Kind regards,

Laurent Bigonville

