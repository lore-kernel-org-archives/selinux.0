Return-Path: <SRS0=8MrU=TX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009FAC282DD
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 20:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88AE2075B
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 20:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="MUHIHo3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbfEWUi5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 May 2019 16:38:57 -0400
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:28600 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387394AbfEWUi5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 May 2019 16:38:57 -0400
X-EEMSG-check-017: 678948142|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,504,1549929600"; 
   d="scan'208";a="678948142"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 May 2019 20:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558643929; x=1590179929;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=7mYl85AiQnFDDIuvotgoWEBUKzAGnsZyP5OgbmCgvUg=;
  b=MUHIHo3ilsCuPExf3aGokXPdiuF9fPY0tqddsaSQnHspJvcROAL5v4y0
   ZRRvGQMTbyxnErmPX5x5FHKCF2/1EROYlWGyAKeWG1B+hW/1Sdx6h+JaE
   LgR7AqdBo0qxZIzHGLNvizKov/t6kLiSoUUMGQ8aOJ4Odo3c0u5GeNBJS
   XpTkPBOWiRWW3vnQSSTyysXe/Api+wbKAjKl/FK+JLHObhLiFsZkdDq14
   vgr7XQ0ZRCcWKDHIVCuT6+m7IJx7k3hMkBY0yXhZhVNrRjvRWs9tPzf4w
   bUDEVC0fTZ2Qx9l8gZldLWEYEwNYmo9Yu/RG8moE0kzMqxdS845svia/W
   A==;
X-IronPort-AV: E=Sophos;i="5.60,504,1549929600"; 
   d="scan'208";a="28123635"
IronPort-PHdr: =?us-ascii?q?9a23=3AbFqTHxCir1CK916nwiJ/UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX4pcbcNUDSrc9gkEXOFd2Cra4d0qyP6vyrADFbqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5vIBmssAndq8YbjYR/JqsxxB?=
 =?us-ascii?q?bCv2dFdflRyW50P1yYggzy5t23/J5t8iRQv+wu+stdWqjkfKo2UKJVAi0+P2?=
 =?us-ascii?q?86+MPkux/DTRCS5nQHSWUZjgBIAwne4x7kWJr6rzb3ufB82CmeOs32UKw0VD?=
 =?us-ascii?q?G/5KplVBPklCEKPCMi/WrJlsJ/kr5UoBO5pxx+3YHUZp2VNOFjda/ZZN8WWH?=
 =?us-ascii?q?ZNUtpUWyFHDIy8dY8PBPcfM+heoYf2ul8CoQKwCASoAe/izCJDiH3r0q0gy+?=
 =?us-ascii?q?kvDB/I3AIgEdwNvnrbotr6O6UOXu6616TI0TfOYulK1Tvh5oXFcBYsquyMU7?=
 =?us-ascii?q?JqdsrRzFEiFwHLj1qMs4PlJS+V2voQuGWc7ephW/6ghHQ9qwFtvDSi3dssi4?=
 =?us-ascii?q?nViYIVzVDI7yN5wJ0vKtGiR057ZsCkHYJWuiqHOYV2RcYiTHtpuCY80rAGpY?=
 =?us-ascii?q?S7czIUyJQm3B7TcuCIc4mS7hLkTuaRLjF1j29mdrKnnxu+7Eetx+LmWsS0zV?=
 =?us-ascii?q?pGtDRJn9bSunwXyhDe7NWMROFn8Ue7wzmP0hje6uRDIU8pi6XWM4Uhwrsslp?=
 =?us-ascii?q?oLtkTDAzP2lF32jKCIckUk/fCl6/j9bbX8p5+cKpR0hhviMqUuhsO/AeM4Ph?=
 =?us-ascii?q?IIX2eH4uSzyKfv/Uj4QLVOlvE2k6/Zv47GJckDu6K0DABY3pwj5hqiFTuqzt?=
 =?us-ascii?q?sVkWcdIF5YYB6HipLmO1DKIPD2F/e/hFGsnS9px/HIIrLuGI/NLmTdnLr6Yb?=
 =?us-ascii?q?Z861JTyAo0zdxF4ZJUEasOLOj8Wk/2qtzUFgU5PBCsw+b7FNV90ZsTWWWKAq?=
 =?us-ascii?q?+eK6PSt0WH6f4xLOSXfo8apivyK/g/6P7yl3M2hVgdfayx15sNdH+4BuhmI1?=
 =?us-ascii?q?meYXf0mdcOD2MKvgs4TOz3h1yPSiBTZ3msUKIm/D07C5ypDZ3FRo+zhLyNxi?=
 =?us-ascii?q?C7HodZZjMONlfZNnHkbYiGE9ILcySbKcJi2mgDUL+6TYYq2Dm0uQP6wqYhJe?=
 =?us-ascii?q?3RrGlQrp/n1d5o98XNmhwosz95FcKQ1yeKVW4nsHkPQmo0w6t2u1AnggOBzq?=
 =?us-ascii?q?NxmeACPcBC7PNOFAEhPNjTyPIsWIO6YR7IYtrcEAXued6hGzxkC4tqktI=3D?=
X-IPAS-Result: =?us-ascii?q?A2CuJQDfA+dc/wHyM5BgBoIXAoEoAjYFKmlRATIohBOIe?=
 =?us-ascii?q?4twLZJNhh6BZwkBAQEBAQEBAQErCQECAQGCEoFoRgKCOCM3Bg4BAwEBAQQBA?=
 =?us-ascii?q?QEBAwEBbBwMQgEQAYFmKQGCZwEFIxVRCwkFCgICJgICVwYBDAYCAQGCXz8Bg?=
 =?us-ascii?q?goPpmiBL4QyAYEUgyqBRoEMJgIBAYtQgVZAgREngms+hCwKgxiCWASBLQGKD?=
 =?us-ascii?q?QGIF5RrBgOCD4VdVYFvhkCEJwYbgwWTM4xkhn2QbyKBVysKQYFogU4JCoIzh?=
 =?us-ascii?q?g+CPoVbIwMwgQYBAYcahhUBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 23 May 2019 20:38:49 +0000
Received: from localhost.localdomain (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4NKcmBn031854;
        Thu, 23 May 2019 16:38:48 -0400
Subject: Re: [Non-DoD Source] [PATCH userspace 0/4] Remove redundant rules
 when building policydb
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190523102449.9621-1-omosnace@redhat.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <0571b2a9-2f34-72c4-431d-450adb7df6a5@tycho.nsa.gov>
Date:   Thu, 23 May 2019 16:39:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523102449.9621-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/23/19 6:24 AM, Ondrej Mosnacek wrote:
> This series implements an optional optimization step when building
> a policydb via semodule or secilc, which identifies and removes rules
> that are redundant -- i.e. they are already covered by a more general
> rule based on attribute inheritance.
> 
> Since the performance penalty of this additional step is very small
> (it adds about 1 s to the current running time of ~20-30 s [1]) and
> it can have a big positive effect on the number of rules in policy
> (it manages to remove ~40% AV rules from Fedora 29 policy), the
> optimization is enabled by default and can be turned off using a
> command-line option (--no-optimize) in secilc and semodule [2].
> 
> The optimization routine eliminates:
>   * all allow/neverallow/dontaudit/auditallow rules (including xperm
>     variants) that are covered by another more general rule,
>   * all conditional versions of the above rules that are covered by a
>     more general rule either in the unconditional table or in the same
>     branch of the same conditional.
> 
> The optimization doesn't process other rules, since they currently
> do not support attributes. There is some room left for more precise
> optimization of conditional rules, but it would likely bring only
> little additional benefit.
> 
> When the policy is mostly or fully expanded, the optimization should
> be turned off. If it isn't, the policy build time will increase a lot
> for no benefit. However, the complexity of optimization will be only
> linear w.r.t. the number of rules and so the impact should not be
> catastrophic. (When testing with secilc on a subset of Fedora policy
> with -X 100000 the build time was 1.7 s with optimization vs. 1 s
> without it.)
> 
> Tested live on my Fedora 29 devel machine under normal use. No unusual
> AVCs were observed with optimized policy loaded.
> 
> Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/536157427
> 
> NOTE: The xperm rule support wasn't tested -- I would welcome some
>        peer review/testing of this part.
> 
> [1] As measured on my machine (Fedora 29 policy, x86_64).
> [2] I have no problem with switching it to opt-in if that is preferred.
> 
> Ondrej Mosnacek (4):
>    libsepol: add a function to optimize kernel policy
>    secilc: optimize policy before writing
>    libsemanage: optimize policy on rebuild
>    semodule: add flag to disable policy optimization
> 
>   libsemanage/include/semanage/handle.h      |   4 +
>   libsemanage/src/direct_api.c               |   7 +
>   libsemanage/src/handle.c                   |  13 +
>   libsemanage/src/handle.h                   |   1 +
>   libsemanage/src/libsemanage.map            |   5 +
>   libsepol/include/sepol/policydb.h          |   5 +
>   libsepol/include/sepol/policydb/policydb.h |   2 +
>   libsepol/src/libsepol.map.in               |   5 +
>   libsepol/src/optimize.c                    | 370 +++++++++++++++++++++
>   libsepol/src/policydb_public.c             |   5 +
>   policycoreutils/semodule/semodule.c        |  12 +-
>   secilc/secilc.c                            |  16 +-
>   12 files changed, 442 insertions(+), 3 deletions(-)
>   create mode 100644 libsepol/src/optimize.c
> 

It would be nice to have checkpolicy support this as well. It shouldn't be too 
hard to do that.

I need to do some more testing, but I think something is not working correctly.

I am starting from conf files here because I have both Fedora and Android ones 
that I have used for testing and it is easier to run them through checkpolicy to 
convert to CIL.

With these rules:

# Redundant 1
allow tp01 tpr1:cl01 { p01a p11a p01b p11b };
allow tp02 tpr1:cl01 { p01a p11a };
allow at02 tpr1:cl01 { p01a p11a p01b };

# Redundant 2
dontaudit tp01 tpr2:cl01 { p01a p11a p01b p11b };
dontaudit tp02 tpr2:cl01 { p01a p11a };
dontaudit at02 tpr2:cl01 { p01a p11a p01b };

# Redundant 3
allow at02 tpr3:cl01 { p01a p11a p01b };
if (b01) {
   allow tp01 tpr3:cl01 { p01a p11a p01b p11b };
   allow tp02 tpr3:cl01 { p01a p11a };
}

# Redundant 4
dontaudit at02 tpr4:cl01 { p01a p11a p01b };
if (b01) {
   dontaudit tp01 tpr4:cl01 { p01a p11a p01b p11b };
   dontaudit tp02 tpr4:cl01 { p01a p11a };
}


I see the following from sediff:

Allow Rules (0 Added, 1 Removed, 0 Modified)
    Removed Allow Rules: 1
       - allow tp02 tpr3:cl01 { p01a p11a }; [ b01 ]:True

Dontaudit Rules (0 Added, 1 Removed, 1 Modified)
    Removed Dontaudit Rules: 1
       - dontaudit tp01 tpr4:cl01 { p01a p01b p11a p11b }; [ b01 ]:True
    Modified Dontaudit Rules: 1
       * dontaudit tp01 tpr2:cl01 { p01b p11a p01a -p11b };

So it handles Redundant 1 just fine, but has problems with Redundant 2 which 
should be the same.

I don't remember what to expect from sediff for boolean rules. I had played 
around with removing rules with some of my earlier lua tools and I thought that 
sediff handled removing redundant rules from booleans, but I could be wrong.

I will look at this more maybe tomorrow, but most likely after the Memorial day 
weekend.

Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
