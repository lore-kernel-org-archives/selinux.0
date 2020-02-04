Return-Path: <SRS0=kuBz=3Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE37C35247
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 19:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B925920674
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 19:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="B5x2t86z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgBDT7j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:59:39 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:17241 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgBDT7j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Feb 2020 14:59:39 -0500
X-EEMSG-check-017: 54303445|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,403,1574121600"; 
   d="scan'208";a="54303445"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Feb 2020 18:21:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580840515; x=1612376515;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=0chuA4uokmmPLbXLFOtvpyRRhJVnAfRUJP1xRrLxnhw=;
  b=B5x2t86zAPMTVYW+Q2HxtuD8NjN9FFloJ50GaLpBGTGrmkDGfNBCbIH4
   ZmtbsBJID77IRl+/VIbI99rse3NBj7a+xl3y6hQUg88u5qL/aV1eNu2HU
   DBPG8nmsgJA6fYiRj3JxybSf9+ZnnL5hNRmxFabqGY/qprWS2SU6IHeLM
   OqQdAOdoL5MJKsBWks7ypOtQuhL7qh92KZQzLqc0Sy50AzNyxk272W97R
   wG76AQpiCWFnpdIHuKTMosraF7kJKPT2060hp1YgJ2K2g9QH7X46TmzBL
   Fde5HkSWE6ftLkBnh3upMSiybEaLSLDZufFKIKTDMp9nTpKRZ/gaz05Bf
   A==;
X-IronPort-AV: E=Sophos;i="5.70,402,1574121600"; 
   d="scan'208";a="38660833"
IronPort-PHdr: =?us-ascii?q?9a23=3AVh8hzx8wE4Ua4v9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21OwcTK2v8tzYMVDF4r011RmVBNmdt6MP0rKN++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMjoZvLqk9xg?=
 =?us-ascii?q?bVrnZGZu9awX9kKU+Jkxvz+8u98oRv/zhMt/4k6sVNTbj0c6MkQLJCET8oKX?=
 =?us-ascii?q?o15MrltRnCSQuA+H4RWXgInxRLHgbI8gj0Uo/+vSXmuOV93jKaPdDtQrAvRT?=
 =?us-ascii?q?ui9aZrRwT2hyoBKjU07XvYis10jKJcvRKhuxlyyJPabY2JKPZzeL7WcMgETm?=
 =?us-ascii?q?RdQMleSy1BApu9b4QRCeoBIf1YpJT5q1cXsBeyGRWgCObpxzBGnH/22bAx3f?=
 =?us-ascii?q?onHw/IwQcsG8sCvXTQodnwMqoZTOK7w7TSzTjbcv1Yxzn95ojLfB4vr/6DUr?=
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
 =?us-ascii?q?psENWlyBbY1mylBKFDxO/DP4A97q+Jhyu5HM160XuTkfB83lQ=3D?=
X-IPAS-Result: =?us-ascii?q?A2DZAABatTle/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gRhVIBIqhBSJA4ZmAQEBBoE3iW+RSQkBAQEBAQEBAQEjFAEBhEACg?=
 =?us-ascii?q?ls4EwIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgwEBAQEBAgEjFVELGAICJgICV?=
 =?us-ascii?q?wYBDAgBAYJjPwGCVgUgrFh1gTKFSoM+gT6BDiqMPHmBB4E4D4IoNT6BDoE9h?=
 =?us-ascii?q?RCCXgSNVIllRnuWaYJFgk6Ee450BhuDQJdIjmGdKyKBWCsIAhgIIQ+DJwlHG?=
 =?us-ascii?q?A2TRIQUhSkjAzCOTQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Feb 2020 18:21:52 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 014IL1N7270121;
        Tue, 4 Feb 2020 13:21:02 -0500
Subject: Re: [RFC PATCH 0/1] selinux-testsuite: Test all mount option context
 types
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200204143707.318337-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ad706239-69a1-eeae-31ce-ac8b70081613@tycho.nsa.gov>
Date:   Tue, 4 Feb 2020 13:22:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204143707.318337-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/4/20 9:37 AM, Richard Haines wrote:
> Not sure how useful these tests are but using them as a starter for running
> tests on all supported filesystems (that I could find).
> 
> These test all the *context= mount options by reading /sbin/mkfs.* entries.
> I've failed/passed tests based on what I have seen, however some could be
> wrong.

A few preliminary comments:

- The existence of /sbin/mkfs.foo does not guarantee that the kernel 
config enables the foo filesystem,

- I'm not sure that we really want to test all of these filesystem types 
all the time; my earlier comments were more directed at enabling us to 
apply as many of the existing filesystem + fs_filesystem tests as 
possible to whatever filesystem type is in use as the native/host 
filesystem type in which selinux-testsuite lives as is the case for all 
other tests, so that distributions with different defaults will get 
their own defaults tested automatically (e.g. ext4 vs xfs vs btrfs) when 
run on their distribution and labeled NFS will be fully exercised when 
running nfs.sh,

- Only exercising fsconfig(2) without actually mounting won't tell us if 
the context is actually being applied as expected, unlike the existing 
filesystem tests,

- Fail/pass shouldn't be based on what we happen to see when we run the 
test but on what is known to be the actual correct behavior. Offhand, 
the only cases expected to fail if allowed by policy would be use of any 
of the context mount options in a non-init user namespace (except for 
tmpfs/ramfs/devpts) or use of defcontext= with a filesystem type that 
isn't fs_use_xattr in policy or using native labeling (labeled NFS).

> 
> Notes:
> 1) As I use fsconfig(2), the btrfs tests will always fail as there is a
>     bug somewhere in the kernel (being investigated).
> 2) I have had to disable udisks as that interferes with the tests. You can
>     keep it enabled by ./test -e.
>     I think there is really a problem with udisks getting in the way as I
>     rapidly fsopen(fd), fsconfig(2) close(fd) for each test (on my system
>     this equals 48 times).
> 
> Richard Haines (1):
>    selinux-testsuite: Test all mount option context types
> 
>   policy/test_filesystem.te      |  12 +++
>   tests/Makefile                 |   2 +-
>   tests/filesystem/Filesystem.pm |  19 +++-
>   tests/fs_contexts/.gitignore   |   1 +
>   tests/fs_contexts/Makefile     |  13 +++
>   tests/fs_contexts/fsconfig.c   |  72 ++++++++++++++++
>   tests/fs_contexts/test         | 153 +++++++++++++++++++++++++++++++++
>   7 files changed, 268 insertions(+), 4 deletions(-)
>   create mode 100644 tests/fs_contexts/.gitignore
>   create mode 100644 tests/fs_contexts/Makefile
>   create mode 100644 tests/fs_contexts/fsconfig.c
>   create mode 100755 tests/fs_contexts/test


