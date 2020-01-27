Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B250C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 17:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45924214D8
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 17:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="afDaL0+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgA0Rpn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:45:43 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:23985 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0Rpm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jan 2020 12:45:42 -0500
X-EEMSG-check-017: 49701800|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,370,1574121600"; 
   d="scan'208";a="49701800"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Jan 2020 17:45:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580147139; x=1611683139;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=1HdatU0Z2FBe3cHUQ9IqYo2o3vMqWI2SiWq5bHQMuss=;
  b=afDaL0+EdSJdxEfhkDJ1NGUEgXBc2pcgunHOxumnrXsm09xCdZSTtE6P
   KUAKKeKWcDXZD/nL5Pc6PwTtMLU4jUGaYz0/BFJBZnPrDTt488dhRuQ6l
   Wp82v43w275iSWK5ZrrgrdSLpB6qVri6N1r3YFzgdosjzp7ijhyYZijwF
   xRrsXYgjuDrYUbomVx9S3bssxQh8nkUCJBJD86Si17xPRO4VqxAihZrD5
   wj4T6EIAWSzOTMlsNpBemU01cbYObybozgc855ZagJDB0o7T1FDLBgz+5
   I3O5H9Xm7NPJlU6X7JqNTAPZ/1OJw3YJ5M5pyiQYzk0e9PzBDg3CM7BL0
   g==;
X-IronPort-AV: E=Sophos;i="5.70,370,1574121600"; 
   d="scan'208";a="32368456"
IronPort-PHdr: =?us-ascii?q?9a23=3ABf9QHxCpz9eC5odKnMFaUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP36rsmwAkXT6L1XgUPTWs2DsrQY0raQ6PqrADRYqdbZ6TZeKccKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZtJ6orxB?=
 =?us-ascii?q?bFvHREd/lKyW90OFmfmwrw6tqq8JNs7ihdtegt+9JcXan/Yq81UaFWADM6Pm?=
 =?us-ascii?q?4v+cblrwPDTQyB5nsdVmUZjB9FCBXb4R/5Q5n8rDL0uvJy1yeGM8L2S6s0WS?=
 =?us-ascii?q?m54KdwVBDokiYHOCUn/2zRl8d9kbhUoBOlpxx43o7UfISYP+dwc6/BYd8XQ3?=
 =?us-ascii?q?dKU91PXCJdHIyzc4oPD/IAPelGqYn9u0AOpga6CQW1Ge/j1iNEinrw0KI0ye?=
 =?us-ascii?q?QhFRzN0hImEdwArX/YqMz5OakWXOywyqTD0DfNYO5M2Trl9YbGbB4hr/GPU7?=
 =?us-ascii?q?x+f8XexksgGB/KgFiLtYzoPSmY2vgRv2WV7edtU/+khW49qwF2pzii3toiip?=
 =?us-ascii?q?XXiYINylDL6yN5y5soK929UkF7ZdqkH4VQtiqHMIZ2Wd4tQ3pztSYmyrwJpZ?=
 =?us-ascii?q?67fC8QxJQh3B7QceaLc4eP4hL9TeucJypzinxieLK6nRmy8E6gx/X/Vsaqyl?=
 =?us-ascii?q?ZKqDRKkt3WunAKzRzT5c6KQeZ+8Ee5wTuDyg/e5+5eLU00iKbXMYAtz7Eump?=
 =?us-ascii?q?YJrEjOGDL9ll/sg6+MbEok//Cl6+HgYrr7uJCRL5R0igTiMqQ2ncy/HPg4Ph?=
 =?us-ascii?q?AOX2eF/eS806Xu/VHjT7VQj/02j7LZvIrbJcQdqK65BBRV3Zg/5BqlEzen0M?=
 =?us-ascii?q?gXnXkALF5ffhKIk5PpNE3ULPD9DPe/h0ygkDZtx//YIr3sGojBI3fMnbv7fb?=
 =?us-ascii?q?tx9lRQxBQ8wNxB/Z5YF6kNIPfpVU/wsNzYAAU5Mwuxw+v/E9Vyy5geVHmTAq?=
 =?us-ascii?q?6ZLKzSsViI6vgpI+mXfoAZojn9K/875/L2l382hUcdfbW13ZsQcH24BPVmLF?=
 =?us-ascii?q?mZYXX2mNcODH8FsRYmQ+zqklKCUDhTaGipX68n/T47FIOmDYHfRo+zmryB2j?=
 =?us-ascii?q?m0HoFMam9aDVCMFG/id5+YVPcUdCKSPshhnyQfVbe/T48h1BeutBL1yrd8MO?=
 =?us-ascii?q?rU9TMXtYj52Nh2+eLTjxcy+iJwD8iH1GGNVW50lHsSRzAqxKB/vVB9ylCb3K?=
 =?us-ascii?q?h/hvxYEsdT5/VTXQgmK5HR1PZ6BM7vVQLBZNiJVEyqTcmhATE0Vtgx2cMBY1?=
 =?us-ascii?q?5hG9W+iRDOxzKqDKUIl7yPH5E06rjT32X1J8pkznbG064hj0M4TcdVKWKmga?=
 =?us-ascii?q?t/pEDvANvzkk6ZnrymPYQV3SjA7y/X12uFvEhCXDl7ZqXMXHYSfWPcsdX/+k?=
 =?us-ascii?q?7YSbKyT78gN10FgdWPLqpMd83Bk1pLXrHgNc7Ybmb3nH2/QV6vwL+WYYiiXm?=
 =?us-ascii?q?IG2izWBUtMxwcW+m2APAMzLj2sr2LXEHplEle5JwvU+PR64Fa8SVU5h1WSZl?=
 =?us-ascii?q?Bl/6K85xpQgPubUf5V1bUB7nQPsTJxSW2h0srWBtzInA9oeKFRcJtp+1tc/X?=
 =?us-ascii?q?7IvAx6eJq7JuZtgUBIIFc/hF/nyxgiUtYIqsMttn5/iVMpeK8=3D?=
X-IPAS-Result: =?us-ascii?q?A2AWAwC2IC9e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBe?=
 =?us-ascii?q?AWBGFQhEiqEFIkDhnUBAQEBAQEGgTeJb5FJCQEBAQEBAQEBAS0KAQGEQAKCS?=
 =?us-ascii?q?DgTAhABAQEEAQEBAQEFAwEBbIU3DII7KQGCegEFIxVRCxgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgmM/AYJWJQ+sWYEyhDUBgRSDOIE+gQ4qjDh5gQeBOA+CXT6HWYI8IgSNU?=
 =?us-ascii?q?oliRnqWZIJDgkyEdo5vBhuCSHiXPI5ggUqHGpQ6IoFYKwgCGAghD4MnCQo9G?=
 =?us-ascii?q?A2cczSFKSMDMAIBAY4IAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Jan 2020 17:45:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00RHio1s036190;
        Mon, 27 Jan 2020 12:44:53 -0500
Subject: Re: [PATCH V2 0/2] selinux-testsuite: Add fs*(2) API filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
References: <20200127093249.3143-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <29631d39-9d64-71b4-5fb7-8a0180466f73@tycho.nsa.gov>
Date:   Mon, 27 Jan 2020 12:46:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127093249.3143-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/27/20 4:32 AM, Richard Haines wrote:
> These patches update the current tests/filesystem to share code (patch 1)
> with the fs*(2) API filesystem tests (patch 2).
> 
> V2 Changes:
> 1) If kernel patch [1] installed move_mount test for denying FILE__MOUNTON
>     should pass. If not installed, display 'Failed as kernel 5.x without
>     "selinux: fix regression introduced by move_mount(2) syscall" patch'
>     (as there is a regression that should be fixed).
>     Note: Kernels 5.2 - 5.5 will fail unless [1] backported. 5.6 is expected
>     to have [1].
> 2) Move policy changes to patch 2.

These look ok to me; we'll see if anyone else objects to the error message.

One other item that occurred to me is that most of the current 
filesystem and fs_filesystem tests are only exercising ext4 regardless 
of the native filesystem in which you run the testsuite (e.g. if I run 
it on a labeled NFS mount most of the tests end up running in the ext4 
filesystem that is created and mounted rather than on labeled NFS 
itself, and likewise if I run it on xfs or btrfs or ...).  For tests 
where it does not matter (e.g. the type_transition tests) it might be 
better to run those on the host/native filesystem directly so we can 
more readily reuse those tests.  Obviously the mount tests themselves 
require some other filesystem besides the one in which the testsuite 
itself resides.  Don't know if people may want to make it easier to 
substitute or add additional filesystem types for testing; you already 
provide a fs_type variable in the test script but that requires patching 
the script and still only supports testing one filesystem type at a time.

> 
> [1] https://lore.kernel.org/selinux/20200117202407.12344-1-sds@tycho.nsa.gov
> 
> Richard Haines (2):
>    selinux-testsuite: Prepare for adding fs*(2) API tests
>    selinux-testsuite: Add fs*(2) API filesystem tests
> 
>   policy/test_filesystem.te        |  18 +-
>   tests/Makefile                   |   6 +
>   tests/filesystem/Filesystem.pm   | 166 ++++++
>   tests/filesystem/test            | 219 ++------
>   tests/fs_filesystem/.gitignore   |   3 +
>   tests/fs_filesystem/Makefile     |  16 +
>   tests/fs_filesystem/fs_common.c  | 110 ++++
>   tests/fs_filesystem/fs_common.h  |  30 ++
>   tests/fs_filesystem/fsmount.c    |  89 ++++
>   tests/fs_filesystem/fspick.c     |  68 +++
>   tests/fs_filesystem/move_mount.c |  76 +++
>   tests/fs_filesystem/test         | 835 +++++++++++++++++++++++++++++++
>   tools/check-syntax               |   2 +-
>   13 files changed, 1455 insertions(+), 183 deletions(-)
>   create mode 100644 tests/filesystem/Filesystem.pm
>   create mode 100644 tests/fs_filesystem/.gitignore
>   create mode 100644 tests/fs_filesystem/Makefile
>   create mode 100644 tests/fs_filesystem/fs_common.c
>   create mode 100644 tests/fs_filesystem/fs_common.h
>   create mode 100644 tests/fs_filesystem/fsmount.c
>   create mode 100644 tests/fs_filesystem/fspick.c
>   create mode 100644 tests/fs_filesystem/move_mount.c
>   create mode 100755 tests/fs_filesystem/test
> 

