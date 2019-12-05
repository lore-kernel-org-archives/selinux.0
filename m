Return-Path: <SRS0=K0yT=Z3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928BBC43603
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 14:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6453D2245C
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 14:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="BUTirq37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfLEOSf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:18:35 -0500
Received: from UHIL19PA39.eemsg.mail.mil ([214.24.21.198]:33553 "EHLO
        UHIL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfLEOSe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Dec 2019 09:18:34 -0500
X-EEMSG-check-017: 54465481|UHIL19PA39_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,281,1571702400"; 
   d="scan'208";a="54465481"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Dec 2019 14:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575555513; x=1607091513;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=QhI4sj/4fFKrcRQkfBQ+Az8xij2UHxPcFbBDbB73xmo=;
  b=BUTirq37XGS+eSdo5pOk0lWozJdwizmkErzZcMFIKvYy/PmKu9cYD9/h
   kikZ0KlaQMgcFBQ+HWJezkbv0ji6WkiN7vqpMCb7YzTKn/2ptL1uCGJDC
   xa+Cbstshv+UozgqZwVKuEvHAxEwRzU6UyXPndUV1lSp6bYBg65neyUeY
   GbPwR267hlIhtNC8HhumwNrPd4ePndhGC/GArQXIi+9097U46WIuO5lQA
   7mA23rX8tbP5mbN1LqBUiMXdD0y9ljib3AetNQFdYy3Ofwl2vZ8nBkUr3
   ZIbJ4ySXzGIH3WiiEwswGwP1wpYL/YPweLk48eM6l/9XwKZyYdbbm0gAU
   g==;
X-IronPort-AV: E=Sophos;i="5.69,281,1571702400"; 
   d="scan'208";a="30790270"
IronPort-PHdr: =?us-ascii?q?9a23=3Ay/iFGBAy5fbAy3DdMTKXUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPT8pcbcNUDSrc9gkEXOFd2Cra4d0KyP4/mrBDxIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQjSq8UajotvJ6UswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwIOSQ58GXKgcJuiqxVrg+qqxhmz4PUZIyZMfxzdb7fc9wHX2?=
 =?us-ascii?q?pMRttfWTJPAo28bIUBAeQOMulaoIbhqFUDtge+CAu2Ce/z1jNFiH370Ksn2O?=
 =?us-ascii?q?ohCwHG2wkgEsoTvnTIstr1LKcSXv6zzKLV0DvDaulZ2TP56IfWchEqvPaBXa?=
 =?us-ascii?q?ltfsrK0kQvCwPEgUmQqYziJT+V0P8NvHKB4+pvUuKvlXcqpgdsqTas3schkp?=
 =?us-ascii?q?TFi40ax1ze9Sh13Zw5KcO3RUJle9KoDZ1dvDyAOYRsWMMtWWRotT4/yr0BpJ?=
 =?us-ascii?q?G0YjAHyI8ixx7Dc/yHdJWI4g77WOaRPzh4gHVldaqjhxmo60igy/D8VtKu3F?=
 =?us-ascii?q?ZLqCpFnN7MtmsT2BPP8MSHVvt88Vuh2TaIzQzT7P1LIVsomqbBLp4hw7owmo?=
 =?us-ascii?q?ISsUTFACD2hF37gLKZe0gr4OSl6/nrbq/4qpKTKYN4kBzyPrwrmsOlAOQ4Ng?=
 =?us-ascii?q?YOX3Kc+eS5zLDj5lD2QK5Rg/0qkqjWrJDaJcMBqq6/GA9ayJwv6xm4Dze4yN?=
 =?us-ascii?q?gYh2UILEpZeBKbiIjkI0rOL+78Dfe+hVSsjThqyuvYPr3uHJrNNGLPkLT/cr?=
 =?us-ascii?q?Zn7U5T1g4zwcpY55JOBbELOOjzVVPptNzEEh85NBS5zPv9B9phzI8eXnyPDb?=
 =?us-ascii?q?GDMKPIsF+H+/wgLvKDZI8Qojn9Kvwl6+Tygn8+nF9ONZWuiIAabHG+A+ROPU?=
 =?us-ascii?q?qUezzvj80HHGNMuRAxCKTGj1iDVz9YZD6dRaMy+nlvBIutS4DdS5q3gbCM9C?=
 =?us-ascii?q?i+F5xSIGtBDwbfP23vctC/R/oUaC+UavRkmzgAWKnpH5QtzjmypQT6zPxhNe?=
 =?us-ascii?q?OS9SoG48GwnONp7vHewElhvQd/CN6QhiTQHmw=3D?=
X-IPAS-Result: =?us-ascii?q?A2C9AgCWDuld/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?IFtIBKEVYkDhmIGgTeJaZFECQEBAQEBAQEBATcBAYRAAoI2OBMCEAEBAQQBA?=
 =?us-ascii?q?QEBAQUDAQFshUOCOymCbwEFIxVRCxgCAiYCAlcGAQwIAQGCUww/glMlrnuBM?=
 =?us-ascii?q?oVPgzaBSIEOKIwxeYEHgREnD4JdPodZgl4EjQyJZUaXE4I4gjmTGwYbmiYtj?=
 =?us-ascii?q?h2cNCKBWCsIAhgIIQ+DKE8RFJtKIwOSGAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 05 Dec 2019 14:18:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB5EILZR211618;
        Thu, 5 Dec 2019 09:18:23 -0500
Subject: Re: perf and cap_syslog
To:     selinux@vger.kernel.org, Dominick Grift <dac.override@gmail.com>
References: <20191205140423.GB1734091@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <348d54cd-f6f7-3dad-d2cc-4d7e2cf57186@tycho.nsa.gov>
Date:   Thu, 5 Dec 2019 09:18:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205140423.GB1734091@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/5/19 9:04 AM, Dominick Grift wrote:
> I am also trying out the new perf_event access vectors. I use the perf util for this.
> 
> Whilst I wwas confining `perf` at some point there were no avc denials anymore but `perf` was segfaulting in enforcing mode.
> After some brute force it turns out that it wanted access to cap_syslog.
> 
> My question: why was it not logging the capability2 syslog event?
> Could this be due to an access vectors ordering issue?

Sometimes capability checks are not audited by the kernel because a 
denial is not fatal to the operation; it just causes the kernel to fall 
back to an unprivileged code path or provide a hashed or NULL value for 
sensitive data.  Offhand, I'd guess you are hitting one of these two checks:
./kernel/kallsyms.c:		if (has_capability_noaudit(current, CAP_SYSLOG))
./lib/vsprintf.c:		if (!has_capability_noaudit(current, CAP_SYSLOG) ||

In these cases, you'll end up with NULL pointer values to avoid leaking 
kernel pointers to userspace, and perf apparently doesn't bother 
checking before dereferencing them.
