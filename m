Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE0AC33C9E
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 19:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6532082F
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 19:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="qbFx8LSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgAQTsV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:48:21 -0500
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:34419 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbgAQTsU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 14:48:20 -0500
X-EEMSG-check-017: 70999817|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="70999817"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Jan 2020 19:47:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579290473; x=1610826473;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=X5YIqqIiypm0/fyZvdfSa7SLtMzVMyrga8bqBvDBuk4=;
  b=qbFx8LSygvNL/hZB+9U/gIW+iLo/5lafj93Pyo/utPIQK802EJpaJrBz
   mqC8AAO231mdY95wQ/GBBJe7d001p6P+N+T3II8OvDtvXaw14Hy3Sf+md
   PimMFS/c8FH82BQIP4z+zektfyQf1I8b4VNyX7WY1nXabcasRy6FWfLof
   RCh1MmP2P3JdaTQsnn4DJX3/Sixnxj53Rs0OK7/AEmaBai5ObIjuGrp2p
   4i/UeED22+qF+lW2Wz59MxB7Wt+g531Gq8Y2kVn7iFr4ifQT1Pkw0pJhg
   cr/8bHdpWyQkpKjR5sVjhZcbFzO1+TplblpFApeJiSHaWdZz8WXXqrwKy
   g==;
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="32091291"
IronPort-PHdr: =?us-ascii?q?9a23=3AGrWtoxNJ66o6dPqT4XAl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z5ocbcNUDSrc9gkEXOFd2Cra4d16yO4+u7AiRAuc/H7ClZNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULjoZuMLo9xx?=
 =?us-ascii?q?jGrnZGdeld2GdkKU6Okxrm6cq84ZBu/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
 =?us-ascii?q?o75NfstRnNTAuP4mUTX2ALmRdWAAbL8Q/3UI7pviT1quRy1i+aPdbrTb8vQj?=
 =?us-ascii?q?St871rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSG?=
 =?us-ascii?q?FfQsheSTBOAoKkb4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOiHD2x6k62P?=
 =?us-ascii?q?k/Hw/A0gIrAtYCvG3aodjxMasfV/2+wqvVwjXZd/5YxCnz6IbIfB4ir/+DU7?=
 =?us-ascii?q?1/fsjNxkcgDA7FkledpJb5Mz+J2OkAsW6W5PdgW+K1jG4nrhl8rCWzxsgyko?=
 =?us-ascii?q?nJhpwaylbZ/itkxYY6P9m4SEplbt+kDZBdsDqaOJZtQs45X2FpuDo1yr0BuZ?=
 =?us-ascii?q?KheigK044oywTQa/yAbYiF+xTuX/uSLzdgnH9pZb2yihmo/UWg1+HwTNe43V?=
 =?us-ascii?q?lUoiZfj9XBsG0G2QbJ5cidUPR9+1+s2TOI1w/O9O5JOVs0la/HK545xb4wi4?=
 =?us-ascii?q?YTvVzDHiDonEX2i7ebdlk+9eiy6uTnf67mqoWdN49yhAH+Nb8uldKjDugiLg?=
 =?us-ascii?q?gPX3SU+eS71LH5+032XK5KgeEsnqncsZDaIdwXpq+/AwBLzoYu8wuzAjip3d?=
 =?us-ascii?q?gCnXQLMUhJdAyIgoT3IV3CPej0DfKljFStlDdryerGPrrkApjVNXjMjazhcK?=
 =?us-ascii?q?1h609c1AUzzddf64hSCrEaOv3/QEDxtNvGDhMhKQy73/7nCMlh1oMZQW+PBa?=
 =?us-ascii?q?qZMKTJsV+O/O0gP/eDaZQPuDnjNvcl5+ThjWMjlVABeqmp2IMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88aEWgUugo+TerqiECNUDNIeXayULwz5ishBIKlE4jDXIatj6KF3C?=
 =?us-ascii?q?uhGZ1WfG9GAEiWEXj0b4WER+sMaCWKL895iDMESLyhRpQ51R60qQ/6z6NrLu?=
 =?us-ascii?q?/T+i0fr5LsysJ56PHUlRE3pnRICJG61W2XQmM8u2QTQTY90aM39Ut4zUyF2K?=
 =?us-ascii?q?N1q+ZVGdxa+7VCVQJscdbHwuh7Dc3ichzOc83PS1u8RNiiRzYrQZZ5+9YTZw?=
 =?us-ascii?q?5YHNK4g1iXxyO3B5cNnqGPQZkz9bjRmXP2IpAu5WzB0fwak1Q+QsZJfVajj6?=
 =?us-ascii?q?p7+hmbU5XFiG2Fhq2qcuIaxyeL+2Cdmznd9HpEWRJ9BP2WFUsUYVHb+JGgvR?=
 =?us-ascii?q?LP?=
X-IPAS-Result: =?us-ascii?q?A2AhAwAYDyJe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YINEiqEEYkDhmEGgTeJbpFJCQEBAQEBAQEBATcBAYRAAoIuOBMCEAEBAQQBA?=
 =?us-ascii?q?QEBAQUDAQFshUOCOykBgnoBBSMVUQsOCgICJgICVwYBDAYCAQGCYz+CVyWtb?=
 =?us-ascii?q?4EyhUqDMIE+gQ4ojC55gQeBOA+CXT6HWYJeBI1aiVZGl1aCQ4JJk2EGG5pyL?=
 =?us-ascii?q?Y4vnRYigVgrCAIYCCEPgydQGA2WZSMDMI1nAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Jan 2020 19:47:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00HJkshp021377;
        Fri, 17 Jan 2020 14:46:56 -0500
Subject: Re: [PATCH] selinux: move status variables out of selinux_ss
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200117131514.496122-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f7e09f46-59b0-2bdf-d270-1ce292b33033@tycho.nsa.gov>
Date:   Fri, 17 Jan 2020 14:48:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117131514.496122-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/20 8:15 AM, Ondrej Mosnacek wrote:
> It fits more naturally in selinux_state, since it reflects also global
> state (the enforcing and policyload fields).
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/Makefile           |  4 ++--
>   security/selinux/hooks.c            |  1 +
>   security/selinux/include/security.h |  4 ++++
>   security/selinux/ss/services.c      |  2 --
>   security/selinux/ss/services.h      |  2 --
>   security/selinux/{ss => }/status.c  | 32 ++++++++++++++---------------
>   6 files changed, 23 insertions(+), 22 deletions(-)
>   rename security/selinux/{ss => }/status.c (81%)

[...]


