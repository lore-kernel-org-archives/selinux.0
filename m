Return-Path: <SRS0=Wrvk=XF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F62C3A5A2
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 12:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4702084D
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 12:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="V5CGTRY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfIJMiW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:38:22 -0400
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:52230 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfIJMiV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Sep 2019 08:38:21 -0400
X-EEMSG-check-017: 12439821|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,489,1559520000"; 
   d="scan'208";a="12439821"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Sep 2019 12:38:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568119099; x=1599655099;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+L08nxECWr1p4xJLcE7uw68gZHO0ENcKdyMUzAgGyyI=;
  b=V5CGTRY0/WOAGzr5ZZ47Xw9RDM7xr9DenBnkvL4L1FY69vQ+wCsGIAf+
   T3Pg9BFsn+De5NAOBmHW1wexOqssFtE0vArWSyi1WuKtskYoemO+gLuvR
   CiO1gbALPvBirC7t9+lR0Eq22IinfKJEfHEJCv3CtxCGIvP2gS/FfHqfx
   HvQtv2CLDEZm/e7q2daOnZ5afEocYr77Va6P4pwim2kwXwECuoSLGoJo+
   lrHF8XWF5IDLvniavIEiEPkXjJNfy0RkTn3BnzAPLWinqVqk4BT7vY1qK
   My7f+vp4nUS3Nk43apJ3epssoxCp0bUWamz2u5aTfL7GzSvwUO5/3Wh5i
   A==;
X-IronPort-AV: E=Sophos;i="5.64,489,1559520000"; 
   d="scan'208";a="27719332"
IronPort-PHdr: =?us-ascii?q?9a23=3A9H0s1BDFBq0/M448Ts3lUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPT+ocbcNUDSrc9gkEXOFd2Cra4d0KyO6+u7ASRAuc/H7ClYNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULj4ZuMLo9xg?=
 =?us-ascii?q?fGrnZGZ+hd2GdkKU6Okxrm6cq84YBv/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
 =?us-ascii?q?o75NfstRnNTAuP4mUTX2ALmRdWAAbL8Q/3UI7pviT1quRy1i+aPdbrTb8vQj?=
 =?us-ascii?q?St871rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4USm?=
 =?us-ascii?q?pbWsZaSjJPDIWyYYASC+YNJOZVoo34q1YIsBCwBxSjBPn3xzFVmHH206003e?=
 =?us-ascii?q?cvHw7I0wMvHc4BvnvPodXpNqofS/y5wLXGwDjBaf5dxDfz6JLPchAkufyCQK?=
 =?us-ascii?q?5wftTJyUkvCQzFiEibp5HgPzyP0uQNt3aU7up9Xu+okG4othpxryOzxsYslo?=
 =?us-ascii?q?bJhoUVxkrC9SVi2ok5P9K4SEllYdO9FpZbqiKUN5NuT88/TGxltzw2x70btZ?=
 =?us-ascii?q?KhYiQHx4orywTCZ/GBboOG+AjsVPyLLjd9nH9lfbW/iAus/kW40e38U9W00E?=
 =?us-ascii?q?5NripYjtnArnAN2ALX6siAUvZ94l2u2SyO1wDO8eFIO1w0lKrHJJ4hxb48jJ?=
 =?us-ascii?q?wTvljYHiDqgkn2ia6WdkE89uip7eTofKnmq4eBO4J7hQzyKKQjltGlDegmPQ?=
 =?us-ascii?q?UCQXKX9fmk2L3m50L5QbFKjvMskqnetZDXPd8bqbOiAwJOzoYi6wqwDzeh0N?=
 =?us-ascii?q?gCm3kHN0hKdAiIj4juJVHCOOr4Auung1SwjDdrwOjLPqP7DZXRNXjMiq3tfb?=
 =?us-ascii?q?N560NHxwozyMpQ55NQCr0bPP3zXUrxvsTCDhAlKwy03/rnCNJl24MFR22PBq?=
 =?us-ascii?q?6ZMKXPsV6H/e8vPeaMa5EPuDrnKPgq+eTujXknll8ZZ6Wp2oEXaH/rVshhdn?=
 =?us-ascii?q?6DYGTlnswIWVkDsgY3Q+3wiRXWTzdPfH/0WqYU6TQyCYbgBoDGENODmruEiR?=
 =?us-ascii?q?ynE4VWa2YOMVWFFXPlZs3QQPsXQD6DKc9m1DofXP6uTJF3hkLmjxPz17cydr?=
 =?us-ascii?q?mcwSYfr5+2kYUk6g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AXAQB0mHdd/wHyM5BlHgEGBwaBVQcLAYFtKoE/ATKES?=
 =?us-ascii?q?49gAQMGgTaJc48rgXsJAQEBAQEBAQEBNAECAQGEPwKCSSM2Bw4CDAEBAQQBA?=
 =?us-ascii?q?QEBAQYDAQFshTqCOimCaAEFIxVBEAsOCgICJgICVwYNCAEBgl8/gXcUpw2BM?=
 =?us-ascii?q?oVLgy6BSYEMKIt4GHiBB4E4gj0uPodPglgElV+WaIIrgiySRQYbmQqobgQtg?=
 =?us-ascii?q?VgrCAIYCCEPgyiCTReOPiQDgTYBAY8gAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Sep 2019 12:37:57 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8ACbuGp014858;
        Tue, 10 Sep 2019 08:37:56 -0400
Subject: Re: Changing selinux enforcing mode at runtime
To:     Srivatsa Vaddagiri <vatsa.ml@gmail.com>
Cc:     selinux@vger.kernel.org
References: <CAMHO8so3mL4hOLd12gg=DZQz7=1auXQET6dVip+r=9GGPjec+Q@mail.gmail.com>
 <45562434-a8bc-ba91-2eee-7407dab4a97f@tycho.nsa.gov>
 <CAMHO8sq4J8wOicx57uNyVa1bsbR7ACz87On2NS0sXve6D-5UrQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <460b110f-e2e3-01da-2aef-ed363eeb1ccf@tycho.nsa.gov>
Date:   Tue, 10 Sep 2019 08:37:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMHO8sq4J8wOicx57uNyVa1bsbR7ACz87On2NS0sXve6D-5UrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/10/19 7:04 AM, Srivatsa Vaddagiri wrote:
>> The more complicated scenario is tasks created before initial policy
>> load, because those may not be assigned the correct security context.
> 
> I think we may be interested in that case (tasks created before
> initial policy load). Would those tasks' operations
> fail when subsequently selinux policies are loaded and mode set to enforcing?

Tasks created before initial policy load will be running in the kernel 
SID and hence once policy has loaded they will have the kernel context. 
Thus, they can perform whatever actions are allowed to the kernel 
context in the policy.  In the case of the init process, it switches 
from the kernel context into the init context by either re-exec'ing 
itself after policy load or by dynamically setting its context via 
setcon(3) after policy load.
