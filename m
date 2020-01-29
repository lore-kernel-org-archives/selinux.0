Return-Path: <SRS0=m98w=3S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B7EC2D0DB
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 18:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C270206D4
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 18:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="AylT3BU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgA2SVY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:21:24 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:10505 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgA2SVY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jan 2020 13:21:24 -0500
X-EEMSG-check-017: 51548370|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="51548370"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Jan 2020 18:21:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580322074; x=1611858074;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=f6LZ9lDuoazjVK0S+lajdXnx82SKQFpWGfBqzO4Co0o=;
  b=AylT3BU4GZFNtHaUKCMcuvvlSSchK/oekQ631vA+kYPbP9Wg0oziv84g
   d+8lPdWcE4hmmcJHQ6lWZDOg8wYRYFMblbn6HQVio554yQaN1aLhCGE9e
   uU30LMa2R8X3h2zqTAe88jzeAbbIEAyGZH486uj43zvj4Bh0F/YKuoeDS
   68C45EjQAjzAetvrDz4/X5hSMbofkeL6LVkvTQjl8LjQsUQJWx6IW6LdZ
   OqhPWlsTHXIeiCOVwy2oph9J2NumP8DhYeCmL77npedRW2EKPVoM62mm2
   8OYQl71wcLcgiQsJZeVMIGhcrvhB0ubDNlowCSw4tbv2f5YeVyuf0SaQR
   A==;
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="38419909"
IronPort-PHdr: =?us-ascii?q?9a23=3AkSgXEB9kQQ5P9v9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21OwcTK2v8tzYMVDF4r011RmVBNmdsKwP0rKG++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMj4ZvK6k9xg?=
 =?us-ascii?q?bVrnZLZu9awX9kKU+Jkxvz+8u98oRv/zhMt/4k6sVNTbj0c6MkQLJCET8oKX?=
 =?us-ascii?q?o15MrltRnCSQuA+H4RWXgInxRLHgbI8gj0Uo/+vSXmuOV93jKaPdDtQrAvRT?=
 =?us-ascii?q?ui9aZrRwT2hyoBKjU07XvYis10jKJcvRKhuxlyyJPabY2JKPZzeL7WcMgETm?=
 =?us-ascii?q?RdQMleSy1BApu9b4QRCeoBIf1YpJT5q1cXsBeyGRWgCObpxzBGnH/22bAx3f?=
 =?us-ascii?q?onHw/IwQcsG8sCvXrQodnwMqoZTOK7w7TSzTjbcv1Yxzn95ojLfB4vr/6DUr?=
 =?us-ascii?q?B/ftbex0Q0CwPIjE+dpZD5Mz6b1OkAtXWQ4ep6VeKojm4qsxx/oiSxycc0io?=
 =?us-ascii?q?nGmIQVwU3Z+yV82ok1Idm4R1B7YNW5F5ZQrDyVN5BtT8M+Q2BnpCY6yroctZ?=
 =?us-ascii?q?69ZygF0o4rxxHYa/yZaoWF5A/oWuWJITpgmX5od72yiwyy/ES90OHwSMa53E?=
 =?us-ascii?q?hQoiZYlNTHq2oD2AbJ6sedT/tw5kKh2TGS2A/N8uxEOkU0lbbDK54m374wio?=
 =?us-ascii?q?IfsUTdES/yn0X7lLOWeV8++uip9uTnea/qpp6aN496jQH+KbohldClDeQkMg?=
 =?us-ascii?q?kBQ2ib+eOm2L3l4UL5W6lFguczkqnYtJDWPcUbpqinDA9Jyosv9hmyAji83N?=
 =?us-ascii?q?kYgHULNkxJdR2Zg4TzJl3COPX4Au2+g1Sonjdr3ffGPrj5D5XWM3fDi6zsfa?=
 =?us-ascii?q?p96kFAyAozyspT55RPCr4bOv7zVUjxtMLAAh8jLwO02/rnCMl61o4GQ2KPA7?=
 =?us-ascii?q?OWMKPIvl+S++0gO/WDa5cVuDnnKvgl4eDhjWQilFAGYamp3J0XaGymEfR8JU?=
 =?us-ascii?q?WWf2bsjs0dHmcNuwo0VPbqh0GaUT5Pe3ayWLox5iolB4KiDIfDQJ2tgbOa0S?=
 =?us-ascii?q?elEZ1ZeHpGBkqPEXj2bYWEXekDaCaILs9miDwEWuvpd4h07xCltAbgx/JHJ+?=
 =?us-ascii?q?vS9zZQ4Yji39h8/eHkniYy/D1yAt+12X2MSX15hGUFW3k926Up5QRmx1OC17?=
 =?us-ascii?q?Voq+JXGMYV5P5TVAo+c5nGwL9UEdf3Dzndc8+JRVDuedCvBTU8X5pl2NMVS1?=
 =?us-ascii?q?psENWlyBbY1mylBKFDxO/DP4A97q+Jhyu5HM160XuTkfB63lQ=3D?=
X-IPAS-Result: =?us-ascii?q?A2B6AwBmzDFe/wHyM5BmHQEBAQkBEQUFAYF7gX2BbAEgE?=
 =?us-ascii?q?iqEFIkDhlsGgRIliW+RSQkBAQEBAQEBAQE3AQGEQAKCTjgTAhABAQEEAQEBA?=
 =?us-ascii?q?QEFAwEBbIVDgjspAYJ6AQUjFVELGAICJgICVwYBDAYCAQGCYz+CSwMJJa4Ig?=
 =?us-ascii?q?TKFSoMtgT6BDiqMOnmBB4E4DAOCXT6CG4U+gjwiBJc0RogqjzSCQ4JMk2UGG?=
 =?us-ascii?q?5p/jmCdHiKBWCsIAhgIIQ+DJ1AYDZ0BIwMwjkcBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Jan 2020 18:21:04 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00TIKEPT196085;
        Wed, 29 Jan 2020 13:20:19 -0500
Subject: Re: [PATCH V2 2/2] selinux-testsuite: Add fs*(2) API filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200127093249.3143-1-richard_c_haines@btinternet.com>
 <20200127093249.3143-3-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4138a048-2300-26bb-4d1b-f5026055fd04@tycho.nsa.gov>
Date:   Wed, 29 Jan 2020 13:21:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127093249.3143-3-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/27/20 4:32 AM, Richard Haines wrote:
> Test filesystem permissions using the fsopen(2), fsconfig(2), fsmount(2),
> fspick(2) and fsmount(2) api's introduced in kernel 5.2.
> 
> Also tests move_mount(2) using open_tree(2).
> 
> These tests use common code from tests/filesystem.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>   policy/test_filesystem.te        |  18 +-
>   tests/Makefile                   |   6 +
>   tests/fs_filesystem/.gitignore   |   3 +
>   tests/fs_filesystem/Makefile     |  16 +
>   tests/fs_filesystem/fs_common.c  | 110 ++++
>   tests/fs_filesystem/fs_common.h  |  30 ++
>   tests/fs_filesystem/fsmount.c    |  89 ++++
>   tests/fs_filesystem/fspick.c     |  68 +++
>   tests/fs_filesystem/move_mount.c |  76 +++
>   tests/fs_filesystem/test         | 835 +++++++++++++++++++++++++++++++
>   10 files changed, 1249 insertions(+), 2 deletions(-)
>   create mode 100644 tests/fs_filesystem/.gitignore
>   create mode 100644 tests/fs_filesystem/Makefile
>   create mode 100644 tests/fs_filesystem/fs_common.c
>   create mode 100644 tests/fs_filesystem/fs_common.h
>   create mode 100644 tests/fs_filesystem/fsmount.c
>   create mode 100644 tests/fs_filesystem/fspick.c
>   create mode 100644 tests/fs_filesystem/move_mount.c
>   create mode 100755 tests/fs_filesystem/test

These are now applied.

