Return-Path: <SRS0=yfq3=WM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E979EC3A59C
	for <selinux@archiver.kernel.org>; Fri, 16 Aug 2019 16:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A4920665
	for <selinux@archiver.kernel.org>; Fri, 16 Aug 2019 16:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="IgefWocV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfHPQgF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:36:05 -0400
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:46356 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfHPQgF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Aug 2019 12:36:05 -0400
X-EEMSG-check-017: 6105897|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,393,1559520000"; 
   d="scan'208";a="6105897"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Aug 2019 16:36:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1565973362; x=1597509362;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=UQHEDJXdxvenLlUiEWzFnZABe93uaLVqqrX4/u2mEXQ=;
  b=IgefWocVwUMJWYUL/d+Tn/DFtt8A4NZuoCKyyQMW0mj6JL05SOwBouiq
   A77xbtQAmg0mwaaAs7qm3dWJceqFe2r4ldLzLKzZpLBBUaNnfvhmkMnXO
   ocuDEgH3POMVMQ7p6rmMF3D0ZW8l5GSeequXlDaqHg2gU+mAcddCrQgCg
   Tv6RVY3Dth08Gnl+Sf4hYs+AuO4dLKFtC36FUAGvHN2WEGcUxSWKLiPw2
   hljnHqwcV6u455SeVZdNAzu471nYXEn6qTdhbAppYNSfifWcQwZJEsQhM
   sNqUx572Cn+WXHK/h36nUN3We2KTtYpcDQ/wEOh4qt7P4/Xk6UlxEE2eC
   g==;
X-IronPort-AV: E=Sophos;i="5.64,393,1559520000"; 
   d="scan'208";a="31576510"
IronPort-PHdr: =?us-ascii?q?9a23=3AH6c4KB1Wwh8eWXhWsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIfLvad9pjvdHbS+e9qxAeQG9mCsbQd0LGd4v+ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmSSxbalvIBi4owjduc0bjIl/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTnhj0HNzok+2/JjMJ+gr9QrBa4qxFxx4PYZYeYP+d8cKzAZ9MXXX?=
 =?us-ascii?q?dPUNhfVyJBAY2yYYUAAOUDMulEoIfwvEcOoBmkCAWwGO/ixD1Fi3nr1qM6ye?=
 =?us-ascii?q?QhFgTG0RQ9EdISrnvUtNX1O7kUUeuo0afIyC/Mb/dS2Tjj6InDbxcsoeqRUr?=
 =?us-ascii?q?JrasfR1UkuGB/FjlWXs4DlOSiV2f4Xv2iU6OpgS/uihmg6oA9/pTivw90jio?=
 =?us-ascii?q?jPho8NyVDL6z95wIArKt28UkJ7ZsSkEJRWuiqHNIV2WtsvT3xntSs10LELuY?=
 =?us-ascii?q?O3cDIUxJko2RLTceGLfo6V6Rz5TumROy13hHd9dbK6gBa97Favx/XnVsmxzF?=
 =?us-ascii?q?ZKti1FksTQtnwV1xzc9MyHSvxl80e9wzmPzQHT6vxfIUwuiaraK4Iuwr43lp?=
 =?us-ascii?q?YJt0TMAjT2l1nsgK+Td0Uk/vCk6+XhYrr4up+RL5J4hw7xP6g0msGzHP40Ph?=
 =?us-ascii?q?YBUmSF4+iwyaXv/UjjT7VLiv02nLPZsJffJckDva62HhRV350/6xe/Ezim0N?=
 =?us-ascii?q?MYkWMBLFJeYh2LlYfpO1bQIPzgF/ewn0yskCt3x/DBJrDhGYvCLnzCkLfnYL?=
 =?us-ascii?q?Z85FVRyBQ8zd9B/ZJYELIBL+zpWk/3qtPYCgU1Mwuuw+boEN99zJ8RWXqTAq?=
 =?us-ascii?q?+FN6PfqUKH6fgzLOWWY48VpijyK+I/5/7vkHA2h0QQfaas3ZQNaXC4Gu5qLF?=
 =?us-ascii?q?meYXrp0Z89FjIRsw4/SvH6oEONXCQVZHuoWa84oDYhB8buIYDGR4asi7/J8z?=
 =?us-ascii?q?26EIEeMmxPARaLD3rybYSIVt8DbSuTJolqlTlSBpa7TIp07g2jrA/3zfJcK+?=
 =?us-ascii?q?PQ/iAJ/cb42MNd+/zYlRZ08yd9ScuazTfeHClPgmoUSmpuj+hEqktnxwLGiv?=
 =?us-ascii?q?l1?=
X-IPAS-Result: =?us-ascii?q?A2AZDADu2VZd/wHyM5BlHAEBAQQBAQcEAQGBZ4FuKm1RA?=
 =?us-ascii?q?TIqhB+PDU0BAQEBAQEGgTaJapEiCQEBAQEBAQEBAS0HAQIBAYQ/AoMaIzgTA?=
 =?us-ascii?q?gUBAQEEAQEBAQEGAwEBbIUnDII6KYJoAQUjFVELGAICJgICVwYBDAYCAQGCX?=
 =?us-ascii?q?z8BgXYUD6oUgTKEMwGBFIMqgUMGgQwoi2kXeIEHgTiCaz6CYQSEaoJYBJUfl?=
 =?us-ascii?q?jEJgh+CIYRDjUkGG4Ixi0iKSY1Xh2GSNSGBWCsIAhgIIQ+DKItHhVsjAzELe?=
 =?us-ascii?q?gEBjhoBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Aug 2019 16:35:11 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7GGZ9In011733;
        Fri, 16 Aug 2019 12:35:10 -0400
Subject: Re: Question about BPF acccess checks
To:     selinux@vger.kernel.org, Dominick Grift <dac.override@gmail.com>
References: <20190816072744.GA520884@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <79283dc7-fcce-259e-e16e-a78eef87256d@tycho.nsa.gov>
Date:   Fri, 16 Aug 2019 12:35:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190816072744.GA520884@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/16/19 3:27 AM, Dominick Grift wrote:
> As of systemd v243rc1 I have been noticing bpf prog_load and prog_run access checks for systemd --user instances (only if secure boot is disabled)
> I suspect that this is for IPAddressAllow/Deny= functionality.
> So i tried it out and I was not allowed to use the above due to lack of root-access.
> 
> Then i read this:
> https://lore.kernel.org/linux-security-module/4F52274A-CD70-4261-A255-2C4A7E818141@fb.com/T/#t
> 
> My question is: Is it expected that BPF prog_load and prog_run is checked when an *unprivileged* process, i suppose, tries to load and run bpf progs?
> 
> Are prog_load and prog_run unprivileged operations?

They can be checked for processes that do not have CAP_SYS_ADMIN if that 
is what you are asking.  This can occur either during bpf(2) system call 
processing if unprivileged_bpf_disabled is 0 (for prog_load and/or 
prog_run), or upon receiving a bpf prog fd from another process (for 
prog_run). It is possible that the specific operation will nonetheless 
fail due to a later CAP_SYS_ADMIN check applied for specific kinds of 
bpf programs.  So it depends on the specifics.

Android policy appears to have changed over time, with netd originally 
allowed both prog_load and prog_run (but not sys_admin), and then later 
bpf program loading was migrated into a separate bpfloader process (with 
prog_load but not sys_admin) and netd was reduced to prog_run, and still 
later sys_admin was added to bpfloader to enable loading bpf programs 
with tracepoints. Similarly there has been an evolution in the handling 
of bpf maps.
