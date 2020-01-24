Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ED9C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 15:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6735E20718
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 15:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Ko44SfY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgAXPMq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:12:46 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:42092 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAXPMq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 10:12:46 -0500
X-EEMSG-check-017: 72951572|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="72951572"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 15:12:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579878765; x=1611414765;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=q5dWjIeIBPEwU9L+RLIsIKb2efA72cy2mXKOe4z5RyI=;
  b=Ko44SfY6LPavAixyAgeYZOVUae8FGI+sXgUYw7kO2hmY0f3nHrhaV7e7
   JvMYPiHdES71fDvwjO3JXLPsZmmL6ZTe3lXeZ1DqcblyC0v7SHGrdTAFE
   DSrJNp9mLKIgXr2a/H7HRKN7JkJpREq7flSfcUpAAGcWORfiB3RP4O1A8
   m3pSTAF5M7UVObexcauNvMn3C4/91olqAEi5tbW8ACj/d9fSaq/RSMiy5
   /0/w9Mg9PF0Y1iKd/vvcJieE7lX6GnM+GP6+G513lYOgoAMCwGBKDmwpY
   URenBY//xhUZOJ5FPM24TYNTPKrqJJzqZk0SeKb693KoRf6I+D8+K18A0
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="32297294"
IronPort-PHdr: =?us-ascii?q?9a23=3ApIwybRQJ5rpez17jN8EjPRou9dpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYxeN2/xhgRfzUJnB7Loc0qyK6vymAzBLvs/J8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HXrnZHdOhbx35kLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsOqofVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDnMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8kxlo?=
 =?us-ascii?q?nGmJoVylDa+iV/3Y07ONi4R1R/Yd6gDpRRtzyROoxtQsw/WGFlozo6y70atp?=
 =?us-ascii?q?67eygG0pInxwXFZPCdfIiI5QzjWf+XLDxlh3xlYKqyiwu9/EWv0OHxVtS43E?=
 =?us-ascii?q?xUoidKjNXArG0B2hrO4cadUPR95F2u2TOX2gDW7eFLPF47mLLAK54k3r4wjp?=
 =?us-ascii?q?0TsVnfHiPumEX5kquWdkI89+i08evneLTmpoKHN4NuiwH+NKoumsukAesmLg?=
 =?us-ascii?q?cCRXSb+OSg273j+k31WrNKgeEtkqbFqpzaIMUbpqqhDw9U1IYs9Qq/Ai+73N?=
 =?us-ascii?q?kXknQLNlJIdA+dg4T3NFzCPur0Aeqnj1SpijhrxvTGPrP7ApXKK3jOiKzhcq?=
 =?us-ascii?q?tm60NH1AoyzcxQ55JTCr0bJvLzQVX+uMbXDh8+LQy42/znB8ll1oMCRWKPBb?=
 =?us-ascii?q?eUMLnTsVCU5uIgOfOMa5INtznhM/cl5+ThjX4/mVADZqmkxoAYaGy5HvRgP0?=
 =?us-ascii?q?WWf2DsgtEfHmcWpAYxUOvqiFiaWz5Je3myR7485i08CI++FofMWIStgL2H3C?=
 =?us-ascii?q?emEZxbfX5GCl+SHnfybYmEWOkDaDiUIsB/ljwIT7+hS5Uu1ULmiAiv8btsLu?=
 =?us-ascii?q?PO9mU4vJPl2cM9s/fSnhE77zBDBPOd2mCLQnpclH8JQSM7xqZyvQp2zVLVle?=
 =?us-ascii?q?BjjvhZE8FDz+1GXx18NpPGyeF+TdfoVVHvZNCMHW26T82mDDd5ddc4x9sDcg?=
 =?us-ascii?q?4pANm5pgzS1CqtRbkOnvqEA4JiofGU5GT4O8sokyWO76ImlVRzB5IUZGA=3D?=
X-IPAS-Result: =?us-ascii?q?A2DWAABBCCte/wHyM5BlHQEBAQkBEQUFAYFqBQELAYF8g?=
 =?us-ascii?q?W0gEiqEEokDhnoGgTeJb5FJCQEBAQEBAQEBATcBAYRAAoJGNwYOAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIVDgjspAYJ6AQUjFVELGAICJgICVwYBDAYCAQGCYz+CSwMJJ?=
 =?us-ascii?q?ax0gTKFSoM0gT6BDioBjDB5gQeBOA+CXT6CG4U+gjwiBJc0RpdegkOCTJNlB?=
 =?us-ascii?q?huafI5gnR0jgVgrCAIYCCEPgydQGA2WZSMDMI1WAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 Jan 2020 15:12:44 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OFC23A267247;
        Fri, 24 Jan 2020 10:12:02 -0500
Subject: Re: [PATCH 2/2] selinux-testsuite: Add fs*(2) API filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200120111113.23349-1-richard_c_haines@btinternet.com>
 <20200120111113.23349-3-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8467a014-e9aa-c148-ebc3-25c79c1853c5@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 10:13:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120111113.23349-3-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/20/20 6:11 AM, Richard Haines wrote:
> Test filesystem permissions using the fsopen(2), fsconfig(2), fsmount(2),
> fspick(2) and fsmount(2) api's introduced in kernel 5.2.
> 
> Also tests move_mount(2) using open_tree(2).
> 
> These tests use common code from tests/filesystem.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Only question I have is whether we want to enable the move_mount test 
unconditionally and let it break on kernels with the regression.  Otherwise,

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   tests/Makefile                   |   6 +
>   tests/fs_filesystem/.gitignore   |   3 +
>   tests/fs_filesystem/Makefile     |  16 +
>   tests/fs_filesystem/fs_common.c  | 110 ++++
>   tests/fs_filesystem/fs_common.h  |  30 ++
>   tests/fs_filesystem/fsmount.c    |  89 ++++
>   tests/fs_filesystem/fspick.c     |  68 +++
>   tests/fs_filesystem/move_mount.c |  76 +++
>   tests/fs_filesystem/test         | 833 +++++++++++++++++++++++++++++++
>   9 files changed, 1231 insertions(+)
>   create mode 100644 tests/fs_filesystem/.gitignore
>   create mode 100644 tests/fs_filesystem/Makefile
>   create mode 100644 tests/fs_filesystem/fs_common.c
>   create mode 100644 tests/fs_filesystem/fs_common.h
>   create mode 100644 tests/fs_filesystem/fsmount.c
>   create mode 100644 tests/fs_filesystem/fspick.c
>   create mode 100644 tests/fs_filesystem/move_mount.c
>   create mode 100755 tests/fs_filesystem/test

[...]
