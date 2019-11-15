Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DDEC432C3
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A8A206D3
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FADu32ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfKOPxW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:53:22 -0500
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:8246 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfKOPxW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Nov 2019 10:53:22 -0500
X-EEMSG-check-017: 49945942|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,308,1569283200"; 
   d="scan'208";a="49945942"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Nov 2019 15:52:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573833177; x=1605369177;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=qY0QoxeIZT5AjSBm2jwCnMXrKnntZdRFVFfCLl20RQs=;
  b=FADu32ubMhGvsx3TIIx1TSIy9z7XegtXaVjjFiMHlw8h8oaJYkB25R/U
   og+Bp7PNArXtrfsBdNyCm3G8NEbGNPLi7CvvmtUCbAhaSXgL/DS6RIl6H
   l6iU6STn7DHpeMK664Xuf1YMQUq/Ecj1A1rGUoSNcrYz+4wrtmiY1vpoP
   rqLX+O7Y90AybMqbJi+Id1RLJ+mc+zlDfoI967Q0Fur9wuN9gmyZsaSuA
   Gp+hty3CWYJ7zAfYYFWa74VnnS6jvyPOOStR/yGyCk7TFWeXR0HKn88pq
   2xIOofGhpfbYJq+pVWs2BcG06Ll7MhSJy0zmMzIcoBHoqqgJnaQnvsUfI
   w==;
X-IronPort-AV: E=Sophos;i="5.68,308,1569283200"; 
   d="scan'208";a="30157122"
IronPort-PHdr: =?us-ascii?q?9a23=3Acpog+h3+G0ihvZOQsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMULfad9pjvdHbS+e9qxAeQG9mCsLQd0Led4/mocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBi4rQjducobjZZ/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXwqV8DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4TMQiQ2RytyY7zL0LoZ?=
 =?us-ascii?q?27czYQyJQh2RHfb+aLc4+S4hLsUuuaPDR2hGp9db6iiBu//lKsx+3hWsWuzl?=
 =?us-ascii?q?pHoTRJnsPRun0Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lp?=
 =?us-ascii?q?oOrUTPBi/2l1vyjK+Rbkgk5vKn6/7mYrX7vZ+QLZN0iwHiPaQuncyzG+I4PR?=
 =?us-ascii?q?QVX2eH4+i80bzj/UnhTLVLiP05jLXZvYjHKckUqaO1GQ9Y3ps55xqhADqqzs?=
 =?us-ascii?q?4UkWQfIFJAYh2HjozpO1/UIPD/CPeym0+snypwx/3dIr3gAonCLnjEkLv7e7?=
 =?us-ascii?q?Z98FRTxBA8zdBY+ZJYEqsBL+7rWk/tqNzYCQc0Mwuxw+bgE9V90JkRVn6RDa?=
 =?us-ascii?q?KCKqPdr0KH5uI1LOmQfoMapDH9K/097f70kXA5gUMdfbWu3ZYPc3C3APBmI0?=
 =?us-ascii?q?SfYXrxjdYMCnkKvgUgQ+zwklGCUiBcZ2y0X60i4jE3EoWmDZ3MRtPlvLvU+y?=
 =?us-ascii?q?G3BJBULkVBEVaFGnrrP9GDXvAXbiuZL+d7nzAEXKTnQIgkg1XmrwL+yrx6Ps?=
 =?us-ascii?q?LK9SAC85Huzt5446vUjx5h2yZzCpGmz2yVT2xy1lgNTjsy0bE39Vdx0X+fwK?=
 =?us-ascii?q?N4hLpeDtUV6PRXBFRpfaXAxvB3XoihEjnKec2EHRP/GYSr?=
X-IPAS-Result: =?us-ascii?q?A2BVBwA0yc5d/wHyM5BkHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?CxsVTIqhCmPClEBAQEGgREliWaRQwkBAQEBAQEBAQEtBwECAQGEQAKCIyQ4E?=
 =?us-ascii?q?wIOAQEBBAEBAQEBBQMBAWyFNwyCOykBgmwBAQEBAgEjFVELDgoCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/AYJSBSAPrlp1gTKEOQGBFINAgUiBDiiMFRh4gQeBOAyCXz6HV?=
 =?us-ascii?q?YJeBJZYRpcHgjSCN4Riji4GG5oOLY4biDiTYSKBWCsIAhgIIQ+DJwlHERSRU?=
 =?us-ascii?q?ohPgT2EICMDMAEBgQMBAZBfAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Nov 2019 15:52:57 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAFFquJY008667;
        Fri, 15 Nov 2019 10:52:57 -0500
Subject: Re: [PATCH testsuite v2 0/3] Fix refpolicy build & build
 test_policy.pp in Travis
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191115151623.265770-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <74a989a0-4288-af3b-21c1-05cbfa6ba167@tycho.nsa.gov>
Date:   Fri, 15 Nov 2019 10:52:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191115151623.265770-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/15/19 10:16 AM, Ondrej Mosnacek wrote:
> This series fixes the remaining test_policy.pp build errors under
> refpolicy and enables building the test policy under both Fedora policy
> and refpolicy in Travis CI.
> 
> Changes in v2:
>   - report policy version 999 in the fake selinuxfs to force building
>     latest version
>   - install userspace tools and libraries straight from source instead
>     of working around maissing features in the Ubuntu builds
>   - install also latest keyutils from source to allow the new 'keys'
>     subtest helpers to build

Doesn't appear to have addressed any of my comments on the first version 
of the first two patches:

https://lore.kernel.org/selinux/6df6dafe-56a6-7de0-0196-d2b714b453bb@tycho.nsa.gov/

https://lore.kernel.org/selinux/c7521035-8608-c24e-4056-c58aa02de387@tycho.nsa.gov/

> 
> Ondrej Mosnacek (3):
>    policy: consolidate macros for home dirs access
>    policy: add fallbacks for Fedora-specific macros
>    travis: test building the test policy package
> 
>   .travis.yml                         | 48 ++++++++++++++++++++++++++---
>   policy/Makefile                     | 11 ++++---
>   policy/test_overlayfs.te            |  6 ++--
>   policy/test_policy.if               | 23 ++++++++++++--
>   travis-ci/enable-policy.sh          | 10 ++++++
>   travis-ci/setup-policy-fedora.sh    | 33 ++++++++++++++++++++
>   travis-ci/setup-policy-refpolicy.sh | 19 ++++++++++++
>   7 files changed, 136 insertions(+), 14 deletions(-)
>   create mode 100644 travis-ci/enable-policy.sh
>   create mode 100644 travis-ci/setup-policy-fedora.sh
>   create mode 100644 travis-ci/setup-policy-refpolicy.sh
> 

