Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45BBC433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 20:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7099164DAE
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhBHUhO convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Mon, 8 Feb 2021 15:37:14 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:56237 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhBHUge (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Feb 2021 15:36:34 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 81E4B564E85;
        Mon,  8 Feb 2021 21:35:27 +0100 (CET)
Received: by mail-ot1-f54.google.com with SMTP id r21so6942281otk.13;
        Mon, 08 Feb 2021 12:35:27 -0800 (PST)
X-Gm-Message-State: AOAM5333FPRATLrEjn1RK9c/3Rs5RD0xNbkBzjXv1puYbuBSyB3kpzmS
        ficGcdaR4YJWCYDqtp60Y0Ck9sLIdYVec2aGlZ8=
X-Google-Smtp-Source: ABdhPJy+ZN0ibyvgXl9jW88DEzCuz/PtgmuT6GX9Ro8SPUCzukV27gnUSrknh5SROFSUG5xX7iYpl2aFJENFcp4su2Y=
X-Received: by 2002:a05:6830:4121:: with SMTP id w33mr13233348ott.361.1612816526498;
 Mon, 08 Feb 2021 12:35:26 -0800 (PST)
MIME-Version: 1.0
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 8 Feb 2021 21:35:15 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nKqT7mmE73r1K3YjBak=OmPACmDi5ccX=SzKhT9=vJ-g@mail.gmail.com>
Message-ID: <CAJfZ7=nKqT7mmE73r1K3YjBak=OmPACmDi5ccX=SzKhT9=vJ-g@mail.gmail.com>
Subject: Recommended value in CONFIG_LSM option on SELinux system?
To:     linux-security-module@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Feb  8 21:35:27 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

Recently there was a bug in Arch Linux where SELinux was no longer
enabled after booting [1], because the default kernel configuration
changed recently [2]:

-CONFIG_LSM="lockdown,yama"
+CONFIG_LSM="lockdown,yama,bpf"

By doing so, setting "security=selinux" on the kernel command line
seemed to break the system, because reading /proc/$PID/attr/current
resulted in "Invalid argument" errors. Replacing "security=selinux"
with "lsm=selinux,lockdown,yama,bpf" fixed the issue and everything is
now fine, but now I am wondering: how should CONFIG_LSM (and option
"lsm" on the kernel command line) be set, on a system which is using
SELinux?

Such information is lacking from the documentation [3] [4]. Therefore
I took a look at Fedora [5] and RHEL [6]:

* Fedora uses CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor",
which was the default value until Linux 5.4 [7].
* RHEL uses CONFIG_LSM="yama,integrity,selinux".

It seems to be strange to have an "outdated" configuration value in
the configuration file, but this could be fine if the new modules are
not expected to be used without the kernel being booted with a
"lsm=..." option.

But there is something that I did not understand: setting
"lsm=selinux,lockdown,yama,bpf" worked, /sys/kernel/security/lsm
showed "capability,selinux,lockdown,yama,bpf", but this violated what
the documentation stated [3]:
"A list of the active security modules can be found by reading
/sys/kernel/security/lsm. This is a comma separated list, and will
always include the capability module. The list reflects the order in
which checks are made. The capability module will always be first,
followed by any “minor” modules (e.g. Yama) and then the one “major”
module (e.g. SELinux) if there is one configured."

Is "lsm=selinux,lockdown,yama,bpf" really problematic?

TL;DR: It would be very helpful if there were some clear guidelines
which were documented in the kernel documentation about how to
configure CONFIG_LSM on SELinux systems.

Thanks,
Nicolas

[1] https://github.com/archlinuxhardened/selinux/issues/81
[2] https://github.com/archlinux/svntogit-packages/commit/69cb8c2d2884181e799e67b09d67fcf7944d8408
[3] https://www.kernel.org/doc/html/v5.11-rc7/admin-guide/LSM/index.html
[4] https://www.kernel.org/doc/html/v5.11-rc7/admin-guide/LSM/SELinux.html
[5] https://src.fedoraproject.org/rpms/kernel/blob/dd9f5d552f96c5171a0f04170dbca7e74e8d13c7/f/kernel-x86_64-fedora.config#_3232
[6] https://src.fedoraproject.org/rpms/kernel/blob/dd9f5d552f96c5171a0f04170dbca7e74e8d13c7/f/kernel-x86_64-rhel.config#_2834
[7] commit https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=000d388ed3bbed745f366ce71b2bb7c2ee70f449

