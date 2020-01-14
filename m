Return-Path: <SRS0=4X/7=3D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5ACC33CB2
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 13:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC21F2465A
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 13:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="K3PQi4cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgANN3g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:29:36 -0500
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:10383 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANN3g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jan 2020 08:29:36 -0500
X-EEMSG-check-017: 69216094|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,432,1571702400"; 
   d="scan'208";a="69216094"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Jan 2020 13:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579008571; x=1610544571;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=wb7eaGtMB15dVi6w7hLPSvlsbpqz0JpclOKvCQFiMZU=;
  b=K3PQi4cn9ThDanowFHw1tsYZ5qvhbF+eM1Q0sgbD0JazRqx6TzT6EUzJ
   3ovfY40LzZhLJeTUy4oX6hN6xaUU3RcWzsYFyjx80JEIu3K0jRK528iX4
   aW9SbWk/m+BiAGpcBhU+qfTfyqt+xMiFxAhna+vY7ijxB2UjZ/CrLw7Jm
   b6h4npHHcURhOUshhtv8N7AgCIGpuy7GQufN9gJgz/Cs2GzDuvJNeyfEe
   5KaNZuHuL4W4sFyERc506sw2D2wt/rhPwhnmrSzcgoZcLttybvVuyH3X0
   DM6aIkrgR6NfMQlQhi3cjLd1h8LRg4CVwWRBj9kFABHBeikZBQTmhMWBR
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,432,1571702400"; 
   d="scan'208";a="31919085"
IronPort-PHdr: =?us-ascii?q?9a23=3APYBghhcUdZba9LCh1MFw5i/rlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc26ZRWN2/xhgRfzUJnB7Loc0qyK6vymATRLus3J8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HVrndUdOhby21lLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsOqofVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDnMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8kxlo?=
 =?us-ascii?q?nGmJoVylDa+iV/3Y07ONi4R1R/Yd6gDpRRtzyROoxtQsw/WGFlozo6y70atp?=
 =?us-ascii?q?67eygG0pInxwXFZPCdfIiI5QzjWf+XLDxlinxlf7e/iAyz8Uim0uD8Vde70E?=
 =?us-ascii?q?xMriVbltnArHcN1wbc6sWBV/Bz/V+h1C6S2w3c5exIO0A5mbfBJ5I/zbM8iI?=
 =?us-ascii?q?AfvVnFEyTrgkv5lrWWeV8h+uWw7uTnZajpqYGEOo9vjwH+LrwumsuiAeQkKg?=
 =?us-ascii?q?QOX3aU+eC71LD74U32Wq9KjvwrkqnCqpzaJMIbpqC+Aw9OzIks9wyzDyum0d?=
 =?us-ascii?q?sEnXkHK0hJeBSbgIjyJ17COvX4Dfa7g1i0kTdrwe7JPqH5D5nQIXXOn63tcL?=
 =?us-ascii?q?Zg50JG1gY+ws5T64hJBr0ZJfL8QE7xtNjWDh8jNAy0xv7qCM5g2YMFQm+PHq?=
 =?us-ascii?q?+YP7/SsV+P/O4vJfKMa5UPtDbyLPgl+ebijWUlll8FYampwZwXZWiiHvRnP0?=
 =?us-ascii?q?qZYWDjgs0cHmgSogUxVOzqh0eDUT5VeXmyRLkx6SonCIKnC4fDWp6igKaH3C?=
 =?us-ascii?q?ilAp1afHxJCleJEX3wbYWLR+8MaD6OIs9mijEETqauS4sg1RGoqQ/7xKFqLv?=
 =?us-ascii?q?Tb+iIGr5Lvztt16PPJlRE06zN0C96R02aXT2F7zSs0QGoM3at/qFZxgneK0K?=
 =?us-ascii?q?51mLQMD91Y5/pTXjAxAp7Vzup3EPj4RgPHYtqTTlu6BN6hBGd1Bsk8x94Ifl?=
 =?us-ascii?q?ZVBdqvlFbA0jCsDrtTkKaEV7Iu9aeJ5GT8P8ZwzT790aAli1Q3Cp9UOXaOmr?=
 =?us-ascii?q?909w+VAZXA1UqeifD5JuwnwCfR+TLbniK1t0ZCXVs1CP6UUA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BmAAAzwR1e/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF7gX2BGFUgEiqEDYkDhm0GgRIliW6RSQkBAQEBAQEBAQEtCgEBh?=
 =?us-ascii?q?EACgiE4EwIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgnkBAQEBAgEjFUYLCxgCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBgmM/AYJKAwkFIA+qYXWBMoQ0AYEUg06BNwaBDiiMM3mBB?=
 =?us-ascii?q?4ERJwwDgl0+ghuFPoI8IgSNQQqIemFGepZYgkKCSYRzjmsGG5ptjluIXJQsI?=
 =?us-ascii?q?oFYKwgCGAghD4MoTxgNV4czGohkhV0jAzEBjR8BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Jan 2020 13:29:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00EDSq2t131197;
        Tue, 14 Jan 2020 08:28:52 -0500
Subject: Re: [PATCH V4 0/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200114122804.321628-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f483648a-7687-8388-917d-c2520b8f3bd6@tycho.nsa.gov>
Date:   Tue, 14 Jan 2020 08:30:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114122804.321628-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/14/20 7:28 AM, Richard Haines wrote:
> These tests should cover all the areas in selinux/hooks.c that touch
> the 'filesystem' class. Each hooks.c function is listed in the 'test'
> script as there are some permissions that are checked in multiple places.
> 
> Tested on Fedora 31 and Rawhide (5.5 for the new watch perm).
> 
> V4 Changes:
> 1) Test non-name based type transition rule.
> 2) Test two different name-based type transition rules that only differ
>     in name.

Sorry, I guess my wording was confusing.  What I meant was that the 
inputs to the two name-based type transition rules were identical except 
for the name, but you would want them to have different output/result 
types so that you can tell whether it actually distinguished them.

> 3) Creating ext4 filesystems with inodes > 128 bytes using -I 256.
> 4) Use kernel_setsched() macro.
> 
> V3 Changes:
> 1) Lots of minor updates.
> 2) Add 'udevadm settle' as suggested by Ondrej to resolve udisks(8) issue.
> 3) Add stopping udisks(8) daemon as a '-d' option.
> 4) Add file quotaon test.
> 5) Add test for name type_transition rule.
> 6) Fix setfscreatecon(3) test to create a directory and check context.
> 7) Use kernel_dontaudit_setsched() as explained in [1].
> 
> [1] https://lore.kernel.org/selinux/f863a91987c1926a4351f3edf968c9003197fead.camel@btinternet.com/
> 
> V2 Changes:
> 1) If udisks(8) daemon is running, stop then restart after tests. The tests
>     run faster and stops the annoying habit of adding mounts to the 'files'
>     app on the desktop. Supports /usr/bin/systemctl or /usr/sbin/service
>     More importantly it stops interferance with the '*context=' tests as it
>     can cause intermittent failures. Tested by running 'test' in a continuous
>     loop with udisks enabled, and then again disabled.
>     Loop 200 times, with udisks failed between 1 to 70 iterations, without
>     udisks, no failures.
> 2) Add "#define QFMT_VFS_V0 2" to quotas_test.c to fix a RHEL/CentOS 7 and
>     below build issue.
> 3) Build new file context based on the original in
>     create_file_change_context.c
> 4) Use "runcon `id -Z` quotacheck ..." to resolve RHEL-6 test run issue.
> 5) Fix free() contexts in create_file_change_context.c and
>     check_mount_context.c
> 
> To test fanotify fs watch perm on 5.5+:
> 1) Build the testsuite policy first:
> make -C policy load
> 
> 2) Add the following CIL statements to watch.cil and install:
> semodule -i watch.cil
> 
> (common filesystem (watch))
> (classcommon filesystem filesystem)
> (allow test_filesystem_t self(filesystem (watch)))
> ; Until 'fs_watch_all_fs(test_filesystem_t)' in Policy use:
> (allow test_filesystem_t fs_t (filesystem (watch)))
> ; Required if notify policy enabled
> ;(allow test_filesystem_t self (dir (watch_sb)))
> 
> 3) Edit /usr/share/selinux/devel/include/support/all_perms.spt
>     and insert the 'watch' permission at:
> 
> define(`all_filesystem_perms',`{ mount remount ..... watch }')
> 
> Richard Haines (1):
>    selinux-testsuite: Add filesystem tests
> 
>   defconfig                                     |   6 +
>   policy/Makefile                               |   4 +
>   policy/test_filesystem.te                     | 356 +++++++
>   tests/Makefile                                |   7 +
>   tests/filesystem/.gitignore                   |  11 +
>   tests/filesystem/Makefile                     |  16 +
>   tests/filesystem/check_file_context.c         |  75 ++
>   tests/filesystem/check_mount_context.c        | 127 +++
>   tests/filesystem/create_file.c                | 117 +++
>   tests/filesystem/create_file_change_context.c | 146 +++
>   tests/filesystem/fanotify_fs.c                |  79 ++
>   tests/filesystem/fs_relabel.c                 | 138 +++
>   tests/filesystem/grim_reaper.c                |  89 ++
>   tests/filesystem/mount.c                      | 130 +++
>   tests/filesystem/quotas_test.c                | 143 +++
>   tests/filesystem/statfs_test.c                |  65 ++
>   tests/filesystem/test                         | 941 ++++++++++++++++++
>   tests/filesystem/umount.c                     |  84 ++
>   18 files changed, 2534 insertions(+)
>   create mode 100644 policy/test_filesystem.te
>   create mode 100644 tests/filesystem/.gitignore
>   create mode 100644 tests/filesystem/Makefile
>   create mode 100644 tests/filesystem/check_file_context.c
>   create mode 100644 tests/filesystem/check_mount_context.c
>   create mode 100644 tests/filesystem/create_file.c
>   create mode 100644 tests/filesystem/create_file_change_context.c
>   create mode 100644 tests/filesystem/fanotify_fs.c
>   create mode 100644 tests/filesystem/fs_relabel.c
>   create mode 100644 tests/filesystem/grim_reaper.c
>   create mode 100644 tests/filesystem/mount.c
>   create mode 100644 tests/filesystem/quotas_test.c
>   create mode 100644 tests/filesystem/statfs_test.c
>   create mode 100755 tests/filesystem/test
>   create mode 100644 tests/filesystem/umount.c
> 

