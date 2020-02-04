Return-Path: <SRS0=kuBz=3Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C18BC2D0B1
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 13:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F86720730
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 13:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YF8WgKHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgBDNsZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:48:25 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:44925 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgBDNsZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Feb 2020 08:48:25 -0500
X-EEMSG-check-017: 54262098|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,401,1574121600"; 
   d="scan'208";a="54262098"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Feb 2020 13:44:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580823844; x=1612359844;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=/AKdrOBuoJf6Aq+4eUBVHcQErLQIuMgLZqADgvMCRK4=;
  b=YF8WgKHe6FFDdALiPfxngX2sOniQI49LM1EOF7sDvCLD4+fW/XV5VcHn
   M+jHBLBdezhibTkfdco4DkK/2GH7CncM30nIsBxop8tIlgqpMDCmSSIuO
   0rycapn4ngqy9mksUXz/47wsRORit4UgHsZ2AECfXI9b6LGx+BsMwiHJi
   HAmU0j7YVqyiNGZNO4pPegN+O/rRAV54c384ICFj5tDeMvKnhCeZSrBGo
   bCyoAnaBcyfpCNLvjW2Rq/0HErJ0QIyrAMJ1HzbudJSe5gNHkm1VbUpad
   WuCYhb7zytq3ePdTd9S9o+X4sXNV789U1/9GsjYY50eAKNGTebmky//Es
   A==;
X-IronPort-AV: E=Sophos;i="5.70,401,1574121600"; 
   d="scan'208";a="38638840"
IronPort-PHdr: =?us-ascii?q?9a23=3A8dCMlRDFb2yOd+McsEQ0UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX8pMbcNUDSrc9gkEXOFd2Cra4d16yK4uu9AiRAuc/H7ClZNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULjoZuMKk8xx?=
 =?us-ascii?q?/GrnZIdeld2GdkKU6Okxrm6cq84ZBu/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
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
 =?us-ascii?q?1h609c1AUzzddf64hSCrEaOv3/QEDxtNvGDhMhKQy73/7nCMlh1oMZQW+PGK?=
 =?us-ascii?q?6ZP7/SsVCS/OIgPvGDa5MNtzb9Mfcl5vjugmEimVIGZqapwZoXaHakHvt4OU?=
 =?us-ascii?q?WZZ2TjgssbHWgWuQo+SfTgiEeeXj5Le3ayQ6U86ykgCI24CYfDR4atgKGO3S?=
 =?us-ascii?q?qgAJ1WaX5JCkqWHXfraYqEQfEMZzyWIsN7lTwET7ehGMcd0kSUtQT6wqBrZs?=
 =?us-ascii?q?rd+ysVrtq3ztl+5+TJmSY5wjx9DsKQyEmHU2Bygm4SQTIqmqt4pBo5gkyO1a?=
 =?us-ascii?q?l+nuxwC9Ne/bVKXx08OJqayPZ1WP7oXQeURcuEUFarRJ2dBDg1St8gi4sVb1?=
 =?us-ascii?q?1VB8SpjheF2TGjRbASierYV9QP7qvA0i2pdI5GwHHc2fxk1gJ3Tw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BpAgCWczle/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVCESKoQUiQOGZQaBN4lvkUkJAQEBAQEBAQEBIxQBAYRAAoJbOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshTcMgjspAYMCAQUjFVELGAICJgICVwYBDAYCAQGCYz8Bg?=
 =?us-ascii?q?koDCSWsYYEyhUqDOoE+gQ4qjDx5gQeBOA+CXT6CG4VAgl4ElzlGl2SCRYJOh?=
 =?us-ascii?q?HuOdAYbg0CXSC2ONJ0rIoFYKwgCGAghD4MnCUcYDZdYhSkjAzCPDQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Feb 2020 13:44:02 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 014DhAai123401;
        Tue, 4 Feb 2020 08:43:10 -0500
Subject: Re: [PATCH 1/1] selinux-testsuite: Add watch_sb and watch_mount
 checks
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200130190732.110012-1-richard_c_haines@btinternet.com>
 <20200130190732.110012-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <19defad5-2e33-8da5-ad91-c8bd4042f11b@tycho.nsa.gov>
Date:   Tue, 4 Feb 2020 08:44:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130190732.110012-2-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/30/20 2:07 PM, Richard Haines wrote:
> Test watch_sb and watch_mount permissions.
> The policy is contained in test_filesystem_notify.te as it can then be
> built if the policy supports the permissions.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Tested with and without the watch permissions defined in base.cil and 
all_perms.spt; everything worked as expected.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   policy/Makefile                  |  3 ++
>   policy/test_filesystem.te        | 15 -------
>   policy/test_filesystem_notify.te | 60 ++++++++++++++++++++++++++
>   tests/filesystem/Filesystem.pm   |  6 +--
>   tests/filesystem/fanotify_fs.c   | 18 ++++++--
>   tests/filesystem/test            | 74 ++++++++++++++++++++++++++++++--
>   tests/fs_filesystem/test         | 74 ++++++++++++++++++++++++++++++--
>   7 files changed, 221 insertions(+), 29 deletions(-)
>   create mode 100644 policy/test_filesystem_notify.te

[...]

