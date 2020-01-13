Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FC2C33CA9
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 15:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4282081E
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 15:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="XT5n0s8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgAMPoc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:44:32 -0500
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:38587 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgAMPoc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 10:44:32 -0500
X-EEMSG-check-017: 68992674|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="68992674"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Jan 2020 15:44:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578930271; x=1610466271;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=YIWF0hB1Mx+IF8jTqx9l03rjbVHkKqcADeIQhP5R2n4=;
  b=XT5n0s8PPMNYzG5uHuD5XGMqDRPFqo5ZDNNkX+92RZjyM9PjjKobRlvQ
   F68ufpy3iF7OoQNeFNuPpYTXycdcreyQ9hkma9dmLe8yszJAmz74dbJZ/
   4Z5OyMJ1uCzUyQTer4iETiEwEm55clVsYlLG6DWccDiHWr9yPDUxVFZ3m
   iQYT3JbFUPvjy350e3cqjKLJbODpuY/A8aQ2iqt46QMb3e9NmkPG3R4lU
   zVyzd5ClUBhaLlDT4E14dOVBq2dn4BOi+FkopGS2+noNBA41gDnW5zyys
   rF9WW1aaZGu9UAz+mAUei3z+jlpO6Ep/LKkERJkR/hlGT1uAujvaiL+/i
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="37684795"
IronPort-PHdr: =?us-ascii?q?9a23=3ARjaomRdjnljdZ+CETXC8AyVHlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW+ZB7h7PlgxGXEQZ/co6odzbaP6Oa6BjRLvsnJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusQUnYduJaQ8xx?=
 =?us-ascii?q?nUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezCw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmuz46x6UbtZ?=
 =?us-ascii?q?O0cyUG0pQqywPFZ/CZfIWE/AjvWPuXLDxlnnxqYqi/iAy38UW4z+38UdS730?=
 =?us-ascii?q?hSoypel9nMqmgN1xvO6sibUvd9/lmu2TKI1w3L9uFLO1o0lavGK5462LIwl5?=
 =?us-ascii?q?wTsUrEHi/thkr5kLWadlkk++e06+TnZa/qppmAOI9vlg7yKKEums27AeggMw?=
 =?us-ascii?q?gOWXaU+fik2bH+8kD0T69Gg/0rnqXDrpzXKtoXqrSkDwNN14Ys8Re/DzOo0N?=
 =?us-ascii?q?QCmnkHKUpIeAmagIjyIFzOPPD5Auu/g1SrijtrwevGMaf7DpXCKXjDjq/tfa?=
 =?us-ascii?q?xh5E5E1Aoz0ddf6opOCrEAPP3zWlX+tMbFARAhLwO72+bnB8981oMYR22PGb?=
 =?us-ascii?q?SUP7jOsV+J4OIvP/eDZJUTuDnjN/gp/eLhjXg8mVUFZ6mmwYMXaGykHvRhO0?=
 =?us-ascii?q?iZemTjgtMAEWcMowo/Q/fniEONUTFNfXa+RaE86S8hCIKgE4jDQpqhgLub3C?=
 =?us-ascii?q?e0TdVqYTV8C1uMGG3kP6WNWvEBc2rGOM5qkjUeWY+qfI8o1Bejryfw17thMu?=
 =?us-ascii?q?fO/CAE85nk0Y4xr/bekRA06CxcEcuQySeOQntyk2dOQCU5j45lpkko8UuOya?=
 =?us-ascii?q?h1hbRjENVX4/5YGlMhOYX00/1xC9e0XBnIONiOVgD1EZ2dHTgtQ4dpkJc1aE?=
 =?us-ascii?q?FnFoDn10uS0g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ACAwCjjxxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsASASKoQMiQOGbAaBN4lukUgJAQEBAQEBAQEBNwEBhEACghw4EwIQAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFQ4I7KQGCegEFIxVRCxgCAiYCAlcGAQwGAgEBgmM/gksDC?=
 =?us-ascii?q?SWqAIEyhUmDR4E9gQ4ojDN5gQeBOA+CXT6CG4U+gjwiBJZEYUaXUYJBgkiTX?=
 =?us-ascii?q?wYbmmyOW50HIoFYKwgCGAghD4MnUBgNlmUjAzCNHgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Jan 2020 15:44:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00DFhrBn037300;
        Mon, 13 Jan 2020 10:43:53 -0500
Subject: Re: [PATCH V3 1/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200112192432.862800-1-richard_c_haines@btinternet.com>
 <20200112192432.862800-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <02e4c12e-7cf9-2b10-cc3e-f1570a0c35c0@tycho.nsa.gov>
Date:   Mon, 13 Jan 2020 10:45:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200112192432.862800-2-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/12/20 2:24 PM, Richard Haines wrote:
> Test filesystem permissions, setfscreatecon(3), file { quotaon } and
> changing file context via 'name type_transition rule'.
> 
>  From kernels 5.5 filesystem { watch } is also tested.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Aside from the travis-ci build failure when trying to build the test 
policy against upstream refpolicy, this looks good to me.  NB you can 
reproduce such failures yourself by creating your own github clone of 
selinux-testsuite, enabling travis-ci on your clone, and pushing your 
change to a branch of our clone.

Possible room for improvement (but I won't insist) might include:
- test non-name based type transition rule with a different type and 
confirm that both files are createdi in the right type (i.e. make sure 
we are actually matching on the component name),
- test two different name-based type transition rules that only differ 
in name (similar),
- add tests for the new mount API, fsopen(), fspick(), fsmount().

These could all be done as separate patches later.

> ---
>   defconfig                                     |   6 +
>   policy/Makefile                               |   4 +
>   policy/test_filesystem.te                     | 343 +++++++
>   tests/Makefile                                |   7 +
>   tests/filesystem/.gitignore                   |  11 +
>   tests/filesystem/Makefile                     |  16 +
>   tests/filesystem/check_file_context.c         |  75 ++
>   tests/filesystem/check_mount_context.c        | 127 +++
>   tests/filesystem/create_file.c                | 112 +++
>   tests/filesystem/create_file_change_context.c | 146 +++
>   tests/filesystem/fanotify_fs.c                |  79 ++
>   tests/filesystem/fs_relabel.c                 | 138 +++
>   tests/filesystem/grim_reaper.c                |  89 ++
>   tests/filesystem/mount.c                      | 130 +++
>   tests/filesystem/quotas_test.c                | 143 +++
>   tests/filesystem/statfs_test.c                |  65 ++
>   tests/filesystem/test                         | 929 ++++++++++++++++++
>   tests/filesystem/umount.c                     |  84 ++
>   18 files changed, 2504 insertions(+)
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
