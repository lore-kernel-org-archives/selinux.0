Return-Path: <SRS0=qSAh=YB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF35FC4360C
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D1F2070B
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 12:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="hPRTRNDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfJHMsX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:48:23 -0400
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:55510 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbfJHMsX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Oct 2019 08:48:23 -0400
X-EEMSG-check-017: 15732599|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,270,1566864000"; 
   d="scan'208";a="15732599"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Oct 2019 12:48:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570538902; x=1602074902;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=3GitIRpuR0p4cLsmeK3W1d0BwqcEwo1QIzdV7x4G0/o=;
  b=hPRTRNDFUerdPT7tr208FTnz4FKMffwmjDnZlQNvnD9azzmP/SPVYhLu
   oqz6UQ67UA3d23ZGk06DPaVBeFY+TSfNyWfP7xQ39FnO3zEifM1NLt7Ka
   FFoHFV/WD+wJQwGMrn7IHCxLfOSWxnEkSqPTP2h2W637XjQHl2GwQrLQv
   r9erdMCNeHxY1c6uwiJsicWGE9CjEvla/5E/yTRV2hCFIMU8gq7Ae1/aX
   vnK2V97tgVm3V///JtDqviQsJ5fKbnCB2Va87iGF5jpRUYPtPxe8s4A9+
   PUNovzFD3kBr8m5q/+vud08duRdqCYrNUYRxfj8KkVIZIzmEXrRZM1smZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.67,270,1566864000"; 
   d="scan'208";a="33885965"
IronPort-PHdr: =?us-ascii?q?9a23=3AlFdNwBI9Iqo8lqDeqNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeIvzxwZ3uMQTl6Ol3ixeRBMOHsqkC1rud7v6ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalyIRiyognctsgbipZ+J6gszR?=
 =?us-ascii?q?fEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3QqBWAzogM2?=
 =?us-ascii?q?Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VS?=
 =?us-ascii?q?ik4qx2UxLjljsJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ2?=
 =?us-ascii?q?ROXtxVVydcHI2yaYUBBPcFMepBr4Two14CoB2jDgeuGezv0CdFiGLo06000+?=
 =?us-ascii?q?ovEg/I0wIvEN0MrHvao874NLsQXO2v0KXE0TvOYvFQ1Dzg6IbIaBchofSUUL?=
 =?us-ascii?q?xtbcre11EvFwPbgVWWtIfrIjaV2f4Js2if8eVhVf+khmk8qw5suTii3dssi4?=
 =?us-ascii?q?nViYIVzVDI7yN5wJ0vKtGiR057ZsCkHYJWuiqHNIV2WtsvT3xntSs10LELuY?=
 =?us-ascii?q?O3cDIUxJko2RLTceGLfo6V6Rz5TumROy13hHd9dbK6gBa97Favx/XnVsmxzF?=
 =?us-ascii?q?ZKti1FksTQtnwV1xzc9MyHSvxl80e9wzmPzQHT6vxfIUwuiaraK4Iuwr43lp?=
 =?us-ascii?q?YJt0TMAjT2l1nsgK+Td0Uk/vCk6+XhYrr4up+RL5J4hw7xP6g0msGzHP40Ph?=
 =?us-ascii?q?YBUmSF4+iwyaXv/UjjT7VLiv02nLPZsJffJckDva62HhRV350/6xe/Ezim0N?=
 =?us-ascii?q?MYkWMBLFJeYh2LlYfpO1bQIPzgF/ewn0yskCt3x/DBJrDgAo/CLn3Zn7f9er?=
 =?us-ascii?q?Zw8FRcxxQuwtBf/Z1UFqsNL+70Wk/0rNbYFAM2MxSow+b7D9VwzpgeVnyLAq?=
 =?us-ascii?q?+YNqPSrFCJ6/kxI+mDeoAVoizxK/s76P70i382h1sdcbOu3ZsNZ3DrVshhdm?=
 =?us-ascii?q?CQenPwi9QMWVYjmyMCa6S+mVSHWCJUT2y/U6I1+ncwD4fwSc/YS4SshqGR9D?=
 =?us-ascii?q?m0E4cQZW1cDF2IV3DyeNaqQfAJPRmOL9dhnzpMbr2oT4ssxFn6rwPh46Z2Je?=
 =?us-ascii?q?rTvCsDvNTs08YjtL6brg076TEhV5fV6GqKVWwh2zpVFjI=3D?=
X-IPAS-Result: =?us-ascii?q?A2BcBAAphJxd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBd?=
 =?us-ascii?q?CqBPwEyhE2OYU0BAQEBAQEGgREliXiRLgkBAQEBAQEBAQE0AQIBAYRAAoJEI?=
 =?us-ascii?q?zgTAgwBAQEEAQEBAQEFAwEBbIU5gjopAYJoAQUjFVELGAICJgICVwYBDAgBA?=
 =?us-ascii?q?YJfP4F3FK1tgTKFTYMvgUiBDCiMDhh4gQeBOAyCXz6HUYJYBI0FiSGXHIIsg?=
 =?us-ascii?q?jCSZAYbgjqLeosMji2bRyKBWCsIAhgIIQ87gm1PEBSQMSUDgTYBAZBjAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 08 Oct 2019 12:48:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x98CmKTp002991;
        Tue, 8 Oct 2019 08:48:20 -0400
Subject: Re: [PATCH 0/5] dispol: add batch execution mode
To:     Masatake YAMATO <yamato@redhat.com>, selinux@vger.kernel.org
References: <20191008064500.8651-1-yamato@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6065d682-8226-ebd3-ede2-3a8ddab3ba4f@tycho.nsa.gov>
Date:   Tue, 8 Oct 2019 08:48:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008064500.8651-1-yamato@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/8/19 2:44 AM, Masatake YAMATO wrote:
> dispol command requires interaction, and is not suitable for using
> in a script. This patch set introduces -b that is for running
> dispol in non-interactively.
> 
> An example:
> 
>      $ ./dispol -b 1 /sys/fs/selinux/policy
>      allow deltacloudd_log_t tmp_t : filesystem { associate };
>      allow kern_unconfined sysctl_type : lnk_file { ioctl read ...

What is your intended use case for this support, i.e. how do you 
envision using dispol in scripts?

If you just want to decompile policy, I'd recommend using checkpolicy 
-F/--conf or checkpolicy -c/--cil, ala:
checkpolicy -M -b /sys/fs/selinux/policy -F -o policy.conf
or
checkpolicy -M -b /sys/fs/selinux/policy -C -o policy.cil

>      ...
> 
> Masatake YAMATO (5):
>    dispol: extend usage() to take exit status
>    dispol: add an option for printing the command usage
>    dispol: introduce a local variable representing the input file
>    dispol: introduce -b option to run commands in batch
>    dispol: add the list of commands for batch mode to help message
> 
>   checkpolicy/test/dispol.c | 96 ++++++++++++++++++++++++++++-----------
>   1 file changed, 69 insertions(+), 27 deletions(-)
> 

