Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89506C43441
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 21:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCB7223AE
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 21:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCB7223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbeKNH33 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:29:29 -0500
Received: from mout.gmx.net ([212.227.17.22]:48599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeKNH33 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 14 Nov 2018 02:29:29 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LejNC-1fhdVK2XgU-00qU01; Tue, 13 Nov 2018 22:28:21 +0100
Message-ID: <1542144497.12945.29.camel@gmx.us>
Subject: Kernel panic - not syncing: corrupted stack end detected inside
 scheduler
From:   Qian Cai <cai@gmx.us>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Date:   Tue, 13 Nov 2018 16:28:17 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Sj/yB5StTIMkJhIF4dZ4w9Bx//1tjf/1hFIo1F/yRWnOd3x4+fY
 vvh18ppDgCPC8qvDOULIEHA9c9FzD+4/PwPH2EajrZRbx0aO5xtsUb2RMi1xT6dg0lliPaF
 AXwqRW8KiIWockf1HbVAZx3I0Y+EDRtccZbYKe6FhiUUTIAHmbuqVX8eL0WL0rMSx/NGGgU
 c2OjkdN29NREKLWTSRm+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SLyvZSDQH3o=:VVA4UyyzVKHtac5KDytcNz
 CrhH8FTKV8k5TnUULV+GPxzGu/ZqlZ7n5gNe7kuq2TzIolStXzaPpkxPfgdP6i3nC+/od5b6F
 NTiDm+dWIVVQOtY0kpayFySgFaPAsOBd1eSB1b5MViSlwO6AbvAYsVvkPC6mTpKOkspX3m1Dh
 5L1emgG3O5jEkSlu/lvikQ1vEguVcrw+TOR2N6Bsz92Y/mjNvdbfOD2h1X2EF5HzZ2EBaKqJk
 H4pPrpzQqk3cmN4p6HLUyxsRaT27g7j6KVsqcxYTworpplGQk/Ocm+RYMg7xgvI2zC5X8Vf4s
 99yxkeTRM85z5EHghqDot1ISxgzVA29m3/BbcCQy2lx8jpxwgdUPGJCY72bXigMoVekOinGqL
 1Q7gHL02o4VQQwxn9rgQZjL6lyPfVxdbRduVnjKp785KYLLI4Nvf05x4+AdUvqZ1SJ6viNN6N
 AcUTxyuTwUf/9DwCnZZ+Mc0+zDgZU/s6xvGB+C6218+u9x7zH2XOb64OoWcq7/2YcPasOBp9b
 qpCJL+oh0cQdussw8lxCLLhLivqHx3WJLSukVw+coSn3Z4tNzc6lNA1QgHC1jOUpa2bZ3wuhl
 GkK+rEd6gYk/BZjcrln9WqInUFyJRTmR5QhUASONvrg8D7ymOypHIqTiWu+ubujA2Wjdjn95c
 K4UV8/QM2HLGGm3KPaDSVmAV8cg7o1Loj60LKeLaFixVV0PQ0//CgqHDaz3K+5rdSupGGJtin
 2FE9I0reYJr6i0CbsI2eVCvFhiutS/HOF/oHl49G10z3clzY5u0a9+aLJ835cZYlQxoq184jw
 yzIVzXVoBzSrI2XXToA4vjgZIiJ40rZJJLlB1j/+srnpI8GZz2FR+tLXwK1uMRZJLnr+IbK1u
 Gn9NEEN1RBesIICeanYoex0qrkEdAwGkeYqZlUBBNUE00QUlJ2w6Dnu9YSZad/
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Running a runc testsuite [1] on an aarch64 server with the latest mainline (rc2)
triggered this,

[1] https://fedorapeople.org/cgit/caiqian/public_git/runctst.git/tree/runctst.py

=============

# python runctst.py
...
- start: runc ocf poststart
load container root: container "root" does not exist
container_linux.go:364: running poststart hook 0 caused "error running hook:
exit status 1, stdout: , stderr: "
- error: unexpected zero-size output.
- start: runc ocf mount dev
- pass: runc ocf mount dev
- start: runc ocf network
- pass: runc ocf network
- start: runc ocf args systemd
- error: unexpected dbus output is USER        PID %CPU %MEM    VSZ   RSS
TTY      STAT START   TIME COMMAND
root          1 68.6  0.0   8832  7424 ?        Rs   19:29   0:03 /usr/sbin/init
root         18 24.0  0.0  14848  8704 ?        Ss   19:29   0:00
/usr/lib/systemd/systemd-journald
root         22  0.0  0.0   9728  6592 ?        Rs   19:29   0:00 ps aux

==============

[ 2231.649459] Kernel panic - not syncing: corrupted stack end detected inside
scheduler
[ 2231.657307] CPU: 185 PID: 11718 Comm: dbus-daemon Kdump: loaded Tainted:
G        W         4.20.0-rc2+ #4
[ 2231.666961] Hardware name: HPE Apollo 70             /C01_APACHE_MB         ,
BIOS L50_5.13_1.0.6 07/10/2018
[ 2231.676788] Call trace:
[ 2231.679273]  dump_backtrace+0x0/0x2c8
[ 2231.682950]  show_stack+0x24/0x30
[ 2231.686273]  dump_stack+0x118/0x19c
[ 2231.689765]  panic+0x1b8/0x31c
[ 2231.692822]  schedule+0x0/0x240
[ 2231.695963]  preempt_schedule_common+0x3c/0x78
[ 2231.700406]  _cond_resched+0xfc/0x108
[ 2231.704077]  kmem_cache_alloc+0x2e0/0x3f8
[ 2231.708102]  selinux_inode_alloc_security+0xc4/0x1b0
[ 2231.713080]  security_inode_alloc+0x44/0x70
[ 2231.717267]  inode_init_always+0x270/0x4b8
[ 2231.721364]  alloc_inode+0x50/0xd0
[ 2231.724768]  new_inode_pseudo+0x84/0x120
[ 2231.728691]  sock_alloc+0x30/0x108
[ 2231.732093]  __sock_create+0x154/0x560
[ 2231.735843]  __sys_socket+0xc8/0x178
[ 2231.739429]  __arm64_sys_socket+0x4c/0x60
[ 2231.743460]  el0_svc_handler+0xd4/0x198
[ 2231.747295]  el0_svc+0x8/0xc
[ 2231.750777] SMP: stopping secondary CPUs
[ 2231.757333] Starting crashdump kernel...
[ 2231.761260] Bye!
