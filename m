Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268E4C43613
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 14:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB407208C3
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 14:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="oFjqAyBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfFUOK5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:10:57 -0400
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:16861 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUOK5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 10:10:57 -0400
X-EEMSG-check-017: 421901271|UHIL19PA11_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Jun 2019 14:10:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1561126255; x=1592662255;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=+VSp5pwQd+QC+njcnidkVMF7nPSwZjxWyK17tz9xz1A=;
  b=oFjqAyBYwoSrKHsG+TbqsR2u+ZYCwiOlAh+p9L2uelqMtKye4lJdv/Mj
   qXBZHbm+ZKKF2xYXWEF8pOaF8NZdILPq+nu6BZkETwuWJmhhfNDdmGLOa
   2z3pd4Lgo9sC2Lvs9nwFo4GShQ+9sMYyMk4eatfmFl2j8jjSgbJh0IzJf
   9VL3BTTE9nh38yY3vtTLlWyP5vjzshS21WnIeGzPgRM/t/NDUzpAP8PQ6
   OYIMhh5vuZb/5RNupZ42n+h5szZKhYKl8TsROoedbDXFOB+nEw9tiKga1
   c8CJe9eK4JXvDJVp31dsuzHa0ec97ZhJRQtdnrvewCTzI3/MGFmMZBadg
   A==;
X-IronPort-AV: E=Sophos;i="5.63,400,1557187200"; 
   d="scan'208";a="24992476"
IronPort-PHdr: =?us-ascii?q?9a23=3A6HwH0xOgvP2A1m1o1Tgl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z5r8bcNUDSrc9gkEXOFd2Cra4d0ayO7eu/AiRAuc/H7ClbNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULn4duMLo9xx?=
 =?us-ascii?q?rGrnZKdeld2GdkKU6Okxrm6cq84YNv/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
 =?us-ascii?q?o75NfstRnNTAuP4mUTX2ALmRdWAAbL8Q/3UI7pviT1quRy1i+aPdbrTb8vQj?=
 =?us-ascii?q?St871rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSG?=
 =?us-ascii?q?FfQsheSTBOAoKkb4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOiHD2x6k62P?=
 =?us-ascii?q?k/Hw/A0gIrAtYCvG3KoNjxMasfV/2+wqvVwjXZd/5YxCnz6IbIfB4ir/+DU7?=
 =?us-ascii?q?1/fsjNxkcgDA7FkledpJb5Mz+J2OkAsW6W5PdgW+K1jG4nrhl8ojqhx8gwkI?=
 =?us-ascii?q?bJnJ4Vxk7Z/ih+woY0K8G3R1RhYd64DpddrD2aNotqTcMiRGFkoiA6yqYctp?=
 =?us-ascii?q?KhcygKz4onygfZZveafYaI5RfjW/yQITd+nH9le6ywhwy08Ue+zu3wTM600E?=
 =?us-ascii?q?xFriZdndnMt2wN1xjJ5cecUPdy4kCh2TOX2wDP8OFLO140lavAK5I43rEwl4?=
 =?us-ascii?q?AfsUPZHi/5gEn2g66Wdlkk+ui18OvreKnpppiZN4JylwrwMbwul9SiDek3PQ?=
 =?us-ascii?q?UCRWiW9fmm2LH98kD1Xq9GguAwn6LEqp7VP94bqbS8AwJN14Yj7AuwACm+3d?=
 =?us-ascii?q?QDmHkHMEpFeBWaj4j1I13OIO73DfO4g1m0jDdk3erGPrz8ApXWNHTDjLfgcq?=
 =?us-ascii?q?p9605b0gYzy8xQ54lIBb0bJfLzW0vxuMTZDh8/LQO03/7qBMhy244RQ26CAr?=
 =?us-ascii?q?KVPLnMvVKH+O4jOfSAaJcQuDnnKvgl4/DujWU+mV8YZaSp35UWZ2yiEfR8P0?=
 =?us-ascii?q?WVf2HhgssBEGgWvgo+S/bmiFuZUTFJfXqyUKU85i8jBIK8EYjDXpytgKCG3C?=
 =?us-ascii?q?qjGZ1WY2dGCkuKEXjya4qLRewBaDiMLcB8kjwLT6ShR5U92hGpsQ/w06BnIf?=
 =?us-ascii?q?bM+i0EqZLj08B45/bNmhE29Dx0Cdmd0m6WQmFqkWMHWSU20Lp8oUNj0FeD17?=
 =?us-ascii?q?Z3g/hCGdxU/fNJXVRyCZmJ6Op2Ed3wEifGZdGAQ1ulCoGhBDYqSNs6zvcUbk?=
 =?us-ascii?q?p9EsnkhRfGiW7iGLIRlrqWFLQq/a/GmXv8PcBwzzDBzqZyoUMhR55NKmavnL?=
 =?us-ascii?q?Ilv1zRGIXAiVnDv7q7fqQbmijW/SGMynTY7xIQaxJ5TaiQBSNXXUDRt9msox?=
 =?us-ascii?q?qYHrI=3D?=
X-IPAS-Result: =?us-ascii?q?A2BDAwBt5Axd/wHyM5BfBh4BBgcGgVYGCwGBbCpqUQEyK?=
 =?us-ascii?q?IQWkneCD5phCQEBAQEBAQEBAS0HAQIBAYISgWhGAoJeIzcGDgEDAQEBBAEBA?=
 =?us-ascii?q?QEEAQFsijcMgjopAYJnAQUjFTwVCwkFCgICJgICVwYBDAYCAQGCXz8BggoPp?=
 =?us-ascii?q?0uBMYQyAYEUgyKBRoEMKItegVZAgREngms+gmECgVODGIJYBIEtAYo5iFWUW?=
 =?us-ascii?q?WsGA4IUhk2NDgYbgihrlDONJYEvhX6RYCKBWCsKQYFogRoBMwkKgmWDOYJWg?=
 =?us-ascii?q?j6FWyMDMAEBgQQBAY8OAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 21 Jun 2019 14:10:54 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5LEArwv009034;
        Fri, 21 Jun 2019 10:10:54 -0400
Subject: Re: [Non-DoD Source] [PATCH userspace v4 0/4] Remove redundant rules
 when building policydb
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190613114558.32621-1-omosnace@redhat.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <bdb2280a-23f3-e386-2ffb-801f0ec35c34@tycho.nsa.gov>
Date:   Fri, 21 Jun 2019 10:11:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613114558.32621-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/13/19 7:45 AM, Ondrej Mosnacek wrote:
> Changes in v4:
>   * fix deallocation in error path in build_type_map()
>   * fix leaked cond nodes
>   * also update the man pages
>   * use UINT32_C for 0xFFFFFFFF constant
>   * squash in the RFC patches & drop the semodule patch
> v3: https://lore.kernel.org/selinux/20190529073759.20548-1-omosnace@redhat.com/T/
> 
> Changes in v3:
>   * fix bad patch squashing
>   * rename secilc --optimize-policy option to --optimize (to be simpler
>     and consistent with checkpolicy and semodule)
> v2: https://lore.kernel.org/selinux/20190528145912.13827-1-omosnace@redhat.com/T/
> 
> Changes in v2:
>   * fix handling of dontaudit (AVTAB_DENY) rules
>   * switch optimization from opt-out to opt-in everywhere
>   * add a patch from jwcart2 that adds optimization support to
>     checkpolicy as well
>   * add two RFC modifications (see log messages for details):
>     * one improves the optimization to detect also rules covered by the
>       union of two or more other rules (on permission set level)
>     * the other one drops libsemanage/semodule run-time enabling/
>       disabling of optimization in favor of a global config option
> v1: https://lore.kernel.org/selinux/20190523102449.9621-1-omosnace@redhat.com/T/
> 
> This series implements an optional optimization step when building a
> policydb via semodule or secilc, which identifies and removes rules that
> are redundant -- i.e. they are already covered by a more general rule
> based on the type attribute hierarchy.
> 
> Since the optimization might not always be useful (e.g. when care is
> taken to not have redundant rules or when the attributes are
> aggressively expanded) and might even drastically increase policy build
> times under some cicumstances (for example with the DSSP standard policy
> [1]), the optimization is applied only when requested explictly.
> 
> The optimization routine eliminates:
>   * all allow/dontaudit/auditallow(/neverallow) rules (including xperm
>     variants) that are covered by another more general rule (or by a
>     union of other rules),
>   * all conditional versions of the above rules that are covered by a
>     more general rule either in the unconditional table or in the same
>     branch of the same conditional.
> 
> The optimization doesn't process other rules, since they currently do
> not support attributes. There is some room left for more precise
> optimization of conditional rules, but it would likely bring only little
> additional benefit.
> 
> Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/545184071
> 
> Tested:
>   * live on my Fedora 29 devel machine under normal use (no unusual AVCs
>     observed with the optimized policy loaded)
>   * using: https://gitlab.com/omos/selinux-misc/blob/master/opt_test.sh
>     * tests also xperm rules
>     * doesn't test conditionals
> 
> [1] https://github.com/DefenSec/dssp2-standard
> 
> James Carter (1):
>    checkpolicy: add flag to enable policy optimization
> 
> Ondrej Mosnacek (3):
>    libsepol: add a function to optimize kernel policy
>    libsemanage: optionally optimize policy on rebuild
>    secilc: add flag to enable policy optimization
> 
>   checkpolicy/checkpolicy.8                  |   3 +
>   checkpolicy/checkpolicy.c                  |  16 +-
>   libsemanage/man/man5/semanage.conf.5       |   5 +
>   libsemanage/src/conf-parse.y               |  15 +-
>   libsemanage/src/conf-scan.l                |   1 +
>   libsemanage/src/direct_api.c               |   7 +
>   libsemanage/src/semanage_conf.h            |   1 +
>   libsepol/include/sepol/policydb.h          |   5 +
>   libsepol/include/sepol/policydb/policydb.h |   2 +
>   libsepol/src/libsepol.map.in               |   5 +
>   libsepol/src/optimize.c                    | 378 +++++++++++++++++++++
>   libsepol/src/policydb_public.c             |   5 +
>   secilc/secilc.8.xml                        |   5 +
>   secilc/secilc.c                            |  16 +-
>   14 files changed, 460 insertions(+), 4 deletions(-)
>   create mode 100644 libsepol/src/optimize.c
> 

Acked-by: James Carter <jwcart2@tycho.nsa.gov>

staged: https://github.com/SELinuxProject/selinux/pull/168

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
