Return-Path: <SRS0=yfq3=WM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE278C3A59D
	for <selinux@archiver.kernel.org>; Fri, 16 Aug 2019 17:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911D32086C
	for <selinux@archiver.kernel.org>; Fri, 16 Aug 2019 17:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="UMkUECm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfHPR21 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:28:27 -0400
Received: from UHIL19PA35.eemsg.mail.mil ([214.24.21.194]:62249 "EHLO
        UHIL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfHPR20 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Aug 2019 13:28:26 -0400
X-EEMSG-check-017: 14273630|UHIL19PA35_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,394,1559520000"; 
   d="scan'208";a="14273630"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Aug 2019 17:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1565976486; x=1597512486;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=sUja0To9Yzel2Yl5MUkpTPbhSh789p62qPvJ+QIWtQE=;
  b=UMkUECm+1ChpeZgjm/kemYoVfpDWSfLJ9aHc9KjlzlvlU2Uv50ub3REw
   rb357Q7f+gSIYGxmd1LwCwuF/tli61SEMiAR7xcDmvAwa4VwG5xsJJeSk
   R6onuFgeuIC9MCbiEV2HIUjq2R4zL97uc4ExJGDqPi4+yJZDCBA2VoqTY
   t92r7B2xK6LMktnmycpxtdgEey6Ku3bbPw2IrUHxkoZRwOX37Wb8UxxpE
   cgXtlqwpYjiJ+BvDjYRFIGB10TxlTXPVbhtx1R8M03VWZqOXJF0tFS3Tc
   3kx3acRUGySpsnwa8/RBeUbYSpFYhPTsu/BOeesqyrWtfM8kLIXh8kr6w
   w==;
X-IronPort-AV: E=Sophos;i="5.64,394,1559520000"; 
   d="scan'208";a="26886805"
IronPort-PHdr: =?us-ascii?q?9a23=3AlmtpnxQ7vU4ZIPSBioeFoCPcpNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zZhWN2/xhgRfzUJnB7Loc0qyK6vqmADdbqs/Z4DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrswndrNQajIVsJ6o+1x?=
 =?us-ascii?q?fFvnhFcPlKyG11Il6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKhMNwlqZbqw+/qRJ5zYDffYWZOONgcq7ZeN8XQ3?=
 =?us-ascii?q?dKUMRMWCxbGo6ycpUBD+QBM+hboYfyqVQBohmiCgejH+7v1j1Fi2Xq0aEm3e?=
 =?us-ascii?q?ksEwfL1xEgEdIUt3TUqc34OroOUe+r1KnIzSvMb/VL0jng7YjHaBQhofWSUr?=
 =?us-ascii?q?NwbMHczlIvGB7ejliLtYzkPy+a1uQKs2SB6epgTvigh3QoqwF2vDii38EhgZ?=
 =?us-ascii?q?THiIISz1DL7yR5wIAtKN27VkF7e9ikH4VUty2AMIt2WMwiT3l1tykkxL0Jp5?=
 =?us-ascii?q?i7fDMUx5s73RLfbfiHfo6V6RzgTOacOSp0iX1qdb6lhxu+7FKsxvPzW8Wqyl?=
 =?us-ascii?q?pGsyxImcTWuH8XzRzc8M2HR+N4/kemxDmAyRje6vpBIUAojarbLIMhwqIomp?=
 =?us-ascii?q?oTr0vDGij2lV3qjKCMbEUk+/Wo6//9brX6pp6TK490igbkPqQohsO/Gvg3Ph?=
 =?us-ascii?q?ILX2ia/eSwzLzj/UvnT7VWlvA6j6bUvZ/AKckbu6K1GRFZ34k95xqlEjuqyN?=
 =?us-ascii?q?EYkmMGLFJBdhKHlY/pO1TWLfDjEPi/mE+hkCtrxv/aPr3hBY/BLn7YkLj7Z7?=
 =?us-ascii?q?p95ElcyBQrwdBF+51UEq0BIO70WkLpr9zXEBs5Mw2yw+b6B9RwzZ0eWW2RDa?=
 =?us-ascii?q?+DKq/SskGH5vgpI+aSYI8ZojH9K+Iq5/T2l382hUcdfbW13ZsQcH23A+5pLF?=
 =?us-ascii?q?mDbXrrnNcOD30KvhA/TOP3llKPSjFTZ3OoUKI94jE3Ep6pDYDGRtPlvLvUxy?=
 =?us-ascii?q?q/H5tLdkhYBV2WV3TlbYOJX7ELci3WauNmlz0CVLOiA6A71B+y/Fv2wrEhKf?=
 =?us-ascii?q?TZ4DcZuZ/L29185umVnhY3o29aFcOYhlqRQnl0k2VAfDo/2KRysAQp0VuY+b?=
 =?us-ascii?q?RpiPxfU9pI7rVGVRlsZs2U9PBzF92nAlGJRdyOUlvzB4/3DA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AWBACo5lZd/wHyM5BlGwEBAQEDAQEBBwMBAQGBZ4FuK?=
 =?us-ascii?q?m1RATIqhB+PDE0BAQEBAQEGgTaJapEiCQEBAQEBAQEBAS0HAQIBAYQ/AoMaI?=
 =?us-ascii?q?zgTAgUBAQEEAQEBAQEGAwEBbIUnDII6KYJnAQEBAQIBIxVGCwsYAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJfPwGBdgUPD6okgTKEMwGBFIMugUMGgQwoi2kXeIEHgTiCaz6CY?=
 =?us-ascii?q?QQYhFKCWASMF1OINZYxCYIfgiGEQ41JBhuCMYtIikmNV4dhkjUhgVgrCAIYC?=
 =?us-ascii?q?CEPgyiLIySFWyMDMQkCegEBjhoBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Aug 2019 17:28:05 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7GHS5VT015762;
        Fri, 16 Aug 2019 13:28:05 -0400
Subject: Re: Question about BPF acccess checks
To:     selinux@vger.kernel.org, Dominick Grift <dac.override@gmail.com>
References: <20190816072744.GA520884@brutus.lan>
 <79283dc7-fcce-259e-e16e-a78eef87256d@tycho.nsa.gov>
 <20190816165351.GA700733@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6e7d4a0e-dc7b-3c4b-14fd-b824b261f201@tycho.nsa.gov>
Date:   Fri, 16 Aug 2019 13:28:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190816165351.GA700733@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/16/19 12:53 PM, Dominick Grift wrote:
> On Fri, Aug 16, 2019 at 12:35:09PM -0400, Stephen Smalley wrote:
>> On 8/16/19 3:27 AM, Dominick Grift wrote:
>>> As of systemd v243rc1 I have been noticing bpf prog_load and prog_run access checks for systemd --user instances (only if secure boot is disabled)
>>> I suspect that this is for IPAddressAllow/Deny= functionality.
>>> So i tried it out and I was not allowed to use the above due to lack of root-access.
>>>
>>> Then i read this:
>>> https://lore.kernel.org/linux-security-module/4F52274A-CD70-4261-A255-2C4A7E818141@fb.com/T/#t
>>>
>>> My question is: Is it expected that BPF prog_load and prog_run is checked when an *unprivileged* process, i suppose, tries to load and run bpf progs?
>>>
>>> Are prog_load and prog_run unprivileged operations?
>>
>> They can be checked for processes that do not have CAP_SYS_ADMIN if that is
>> what you are asking.  This can occur either during bpf(2) system call
> 
> Yes I suppose that was what I was asking. According to an LWN article today unprivileged bpf is not going to happen.

There was sufficient disagreement in that thread by other kernel 
developers that you shouldn't assume it.

> Thus i dontaudited these two since it does not work presently, and it is not going to work in the future.
> 
> https://defensec.nl/gitweb/?p=dssp2.git;a=commitdiff;h=1ef329b09a3bee549cd08640663ba5e8ed9d3f56

That's fine as an interim workaround to avoid noise in your logs but it 
may in fact be supported some day.

> 
> Thanks
> 
>> processing if unprivileged_bpf_disabled is 0 (for prog_load and/or
>> prog_run), or upon receiving a bpf prog fd from another process (for
>> prog_run). It is possible that the specific operation will nonetheless fail
>> due to a later CAP_SYS_ADMIN check applied for specific kinds of bpf
>> programs.  So it depends on the specifics.
>>
>> Android policy appears to have changed over time, with netd originally
>> allowed both prog_load and prog_run (but not sys_admin), and then later bpf
>> program loading was migrated into a separate bpfloader process (with
>> prog_load but not sys_admin) and netd was reduced to prog_run, and still
>> later sys_admin was added to bpfloader to enable loading bpf programs with
>> tracepoints. Similarly there has been an evolution in the handling of bpf
>> maps.
> 

