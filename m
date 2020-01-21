Return-Path: <SRS0=4+dM=3K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053C7C2D0CE
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 16:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FBF21569
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 16:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="G/+Ho0JF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAUQ7z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:59:55 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:48401 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQ7z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jan 2020 11:59:55 -0500
X-EEMSG-check-017: 71598607|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,346,1574121600"; 
   d="scan'208";a="71598607"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Jan 2020 16:30:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579624252; x=1611160252;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=p5O1bUNEHYfJKWr8zz0UQkGtKxhymW0TBZUQ7m/qSK0=;
  b=G/+Ho0JFR9EylSxqMpjumG0x31TC7NFW2sVwrP37JnbBGtj9+mHpoYjz
   I1nxzDdOsus2tHZMH4Ue4C7VJzFVPfjyJu9ylClg5TL2EgIn7PMMx4O13
   bAqrsWW1G2LgY40ZlVKzH1D+euSi35gK3RFzxYhJwWtuPkBqipGZjiQqq
   KGeO7P4rHAnNR93oWXm3iqqWc1f1rQwbK8DLqeeRwap8CLG7Jk4FS5TMy
   6dSg0ZHXf1fvm5MGX8PPHDKK52zlDv/z103LKmGcEo/t+49ySKxlH4pOh
   Y72T72A7r6vcwFnzUjJb3LutBpNxytrt6O4kIU+KxX610dGlJZKcaX4cj
   A==;
X-IronPort-AV: E=Sophos;i="5.70,346,1574121600"; 
   d="scan'208";a="38043410"
IronPort-PHdr: =?us-ascii?q?9a23=3A8pIGORc88NpH1MtjBvmuKyaqlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW9Zx7h7PlgxGXEQZ/co6odzbaP7+a5CSdQvN7B6ClELMUXEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/Jas90A?=
 =?us-ascii?q?bFr3hHd+lVxW5jOFafkwrh6suq85Nv7ipdt+g9+8JcVKnxYrg1Q6FfADk6KW?=
 =?us-ascii?q?4++dfltQPETQuB53scVnsZnx9VCAXb7x/0Q4n8vDLiuuVyxCeVM8v2TaspWT?=
 =?us-ascii?q?u59KdkVAXoiCYcODEn9mzcl9F9g7haoBKloBx/3pLUbYSIP/dwYq/RYdUXTn?=
 =?us-ascii?q?daU81PSyJOHJ+zb4oXD+oAI+lYqZX9p0ATphe6HAWgGf/jxiNNinLw06I6ye?=
 =?us-ascii?q?AhGhzY0gImEdwFrXDYoMz7OaoWVOy4yrTDwzfeYPNMwTrz9YjGfA4vof+PU7?=
 =?us-ascii?q?x/f8XexkszGA3KlViQtY/oMimJ2ugRvWWW7extXv+vhW49rAFxpyCiyNowio?=
 =?us-ascii?q?bXnoIVyk7L9SNky4goIN23Ukp7Ydq6H5pQqiqXMJB2Td45Q2xzpCY7yqEJuZ?=
 =?us-ascii?q?68fCQQzpQn3ATQZ+aIc4iP/BLuTeCcKip7inJ9YL+zmhm//Ee6xuD8S8W4yk?=
 =?us-ascii?q?hGoyVbntXWq3wA0QHY5NKdRftn5Eih3C6C1wXU6u5ZP085jbHbK5s9wr4okZ?=
 =?us-ascii?q?oTrFjDEjf2mEroiK+WcV0p+vSy5OT9Y7Xmu4ScO5V1igH4PKQunde/DvokPQ?=
 =?us-ascii?q?QUQ2ia+fiz1L3k/UHjRrVFkuY2nbXDvJDfJMQbora1Aw5T0ok99xayFyqq3d?=
 =?us-ascii?q?sXkHUdLF9JZQiLg5bmNl3QOvz0EO+zg1G2nzdqw/DGMKfhApLILnXbi7fuYK?=
 =?us-ascii?q?195lVAyAsz0d9f55VUBqsHIPLoQED9rtPYDhgnMwCs2eboFM191p8CWWKIGq?=
 =?us-ascii?q?KZKqLSvkOI5u01OemDeZcatyrlJPgl/fHujHk5lkEGfaSyxpQXdHG4HvJ6I0?=
 =?us-ascii?q?qHe3rshMkOEXsQsgUiS+zqjUWIUSRPaHaqQ6I8+jY7BZq9DYjdQoCtgbqB3D?=
 =?us-ascii?q?q0H5BNeGBGBU6DEW3ye4WHRfgMciSSLdFlkjAeUrihUYAhhlmSs1rAyrFnJ/?=
 =?us-ascii?q?DYsg0RtJTuz5Ah/ezYlRgo+Qt/OMSU0meAVEl+gmIOWzIs2q1j50d6zwHHmb?=
 =?us-ascii?q?N1h/1eCMx7+fxESEE5OITawug8DMr9CSzbedLcc0qrWtWrB3kKS9s1x9IfKx?=
 =?us-ascii?q?JmF86KkgHI3y3sBaQc0bOMGspnoernw3HtKpMlmD793647ggxjG5AeOA=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2DyAgB5Jide/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsASASKoQSiQOGZAEBBAaBN4lukUkJAQEBAQEBAQEBNwEBhEACgjY4EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIw8BBVEJAhgCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?mM/gksDCSWSSJt2gTKIe4E+gQ4qjC55gQeBOA+CXT6CG4U+gjwiBJZRgSeIK?=
 =?us-ascii?q?I8ygkOCSZNiBhuad45enRcigVgrCAIYCCEPgydQGA2WZSMDMI4RAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 21 Jan 2020 16:30:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00LGU9KS078922;
        Tue, 21 Jan 2020 11:30:10 -0500
Subject: Re: [PATCH V7 1/1] selinux-testsuite: Add filesystem tests
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200119111740.61358-1-richard_c_haines@btinternet.com>
 <20200119111740.61358-2-richard_c_haines@btinternet.com>
 <7403753e-78e8-62b3-3372-476864df8b57@tycho.nsa.gov>
Message-ID: <bc0a2575-01d7-e38b-9ed1-2f59aa391fd0@tycho.nsa.gov>
Date:   Tue, 21 Jan 2020 11:31:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <7403753e-78e8-62b3-3372-476864df8b57@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/21/20 10:59 AM, Stephen Smalley wrote:
> On 1/19/20 6:17 AM, Richard Haines wrote:
>> Test filesystem permissions, setfscreatecon(3), file { quotaon } and
>> changing file context via non and name-based type_transition rules.
>> The name-based rules only apply to:
>>    (MOD_POL_VERS >= 11 and POL_VERS >= 25 and MAX_KERNEL_POLICY >= 25)
>>
>>  From kernels 5.5 filesystem { watch } is also tested.
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

And applied now.

> 
>> ---
>>   defconfig                                     |   6 +
>>   policy/Makefile                               |   7 +
>>   policy/test_filesystem.te                     | 373 +++++++
>>   policy/test_filesystem_name_trans.te          |  20 +
>>   tests/Makefile                                |   7 +
>>   tests/filesystem/.gitignore                   |  11 +
>>   tests/filesystem/Makefile                     |  16 +
>>   tests/filesystem/check_file_context.c         |  75 ++
>>   tests/filesystem/check_mount_context.c        | 127 +++
>>   tests/filesystem/create_file.c                | 117 +++
>>   tests/filesystem/create_file_change_context.c | 146 +++
>>   tests/filesystem/fanotify_fs.c                |  79 ++
>>   tests/filesystem/fs_relabel.c                 | 138 +++
>>   tests/filesystem/grim_reaper.c                |  89 ++
>>   tests/filesystem/mount.c                      | 130 +++
>>   tests/filesystem/quotas_test.c                | 143 +++
>>   tests/filesystem/statfs_test.c                |  65 ++
>>   tests/filesystem/test                         | 968 ++++++++++++++++++
>>   tests/filesystem/umount.c                     |  84 ++
>>   19 files changed, 2601 insertions(+)
>>   create mode 100644 policy/test_filesystem.te
>>   create mode 100644 policy/test_filesystem_name_trans.te
>>   create mode 100644 tests/filesystem/.gitignore
>>   create mode 100644 tests/filesystem/Makefile
>>   create mode 100644 tests/filesystem/check_file_context.c
>>   create mode 100644 tests/filesystem/check_mount_context.c
>>   create mode 100644 tests/filesystem/create_file.c
>>   create mode 100644 tests/filesystem/create_file_change_context.c
>>   create mode 100644 tests/filesystem/fanotify_fs.c
>>   create mode 100644 tests/filesystem/fs_relabel.c
>>   create mode 100644 tests/filesystem/grim_reaper.c
>>   create mode 100644 tests/filesystem/mount.c
>>   create mode 100644 tests/filesystem/quotas_test.c
>>   create mode 100644 tests/filesystem/statfs_test.c
>>   create mode 100755 tests/filesystem/test
>>   create mode 100644 tests/filesystem/umount.c
> 
> [...]
> 

