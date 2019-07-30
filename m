Return-Path: <SRS0=so3z=V3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ED7C0650F
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 17:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA39208E3
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 17:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jnEi3VI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfG3R76 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:59:58 -0400
Received: from UHIL19PA35.eemsg.mail.mil ([214.24.21.194]:24728 "EHLO
        UHIL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfG3R75 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Jul 2019 13:59:57 -0400
X-EEMSG-check-017: 6087082|UHIL19PA35_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,327,1559520000"; 
   d="scan'208";a="6087082"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA35.eemsg.mail.mil with ESMTP; 30 Jul 2019 17:59:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1564509595; x=1596045595;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=K9fSFLdS6akfL232sbhuzIOlQ+T7VA9QBLfegoBJUyg=;
  b=jnEi3VI3hKj/C5unP/5hPgFsbcFjWNGvUYA+BLCA3TZwxV+rGv3am/wy
   Q4TRWnGfxQCE2zItxQcwWEjwvv1xak57+ThvnIOyd/RWbX/1Yi5kVHfJa
   ElIUvMN8dgfYi1tQJXSYYzVpRKp26uEFT1h9DW5iE/3guElCDgMRa0BS9
   XB75Yh7MGpGP4naQT4x7uVuG0Uvbr+s/04gpjIf9XatjZF22uWCIwkYKz
   SEtnc70srrrvnORvie1vSQLGps0bqqJoH7IGjjyDt8hAyZD6FjFZROOQX
   73jDn0f9gOaIrndle7DHkwNn2L/iPm7RQfRxlcb7Pv/r/FFTpMzoQ/IYj
   g==;
X-IronPort-AV: E=Sophos;i="5.64,327,1559520000"; 
   d="scan'208";a="26250040"
IronPort-PHdr: =?us-ascii?q?9a23=3AALaWmBMv3wKgF8z0Ul0l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z+p8bcNUDSrc9gkEXOFd2Cra4d0ayH6Ou5ADBIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK1+IA+yoAjfucUanJZuJ6kswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcDrR+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsQHlotT4nxrAJtp?=
 =?us-ascii?q?O3ZigHxIk9yxLBZPGLbZKE7g/lWe2MOzl3nmhld6i6hxuq9EigzfDzWdes3V?=
 =?us-ascii?q?ZRqypFjsHMtncQ1xzP8sSHSuVy/kOm2TuXywDc8PtEIUEplarAMZIh3r4xmY?=
 =?us-ascii?q?YTsUTEBCP2nln5jLSKeUk+/+io6uDnbq3npp+aKYB0lhnzPrkhl8GwG+g1Mh?=
 =?us-ascii?q?UCU3KF9emzyrHv51D1TK1PjvIsk6nZtJ7aJd4cpq68GwJVyZss6w2kAje60N?=
 =?us-ascii?q?UXgXkHLFVfdBKBlIjmIUvCIP//Dfehm1isiitkx+jaPr39BZXANn7DkLHifb?=
 =?us-ascii?q?tm5E5czw0zzd9b551KEL0OPPXzWkrpvtzCEhA5KxC0w/rgCNhlzYMRR2aPAq?=
 =?us-ascii?q?6fMKPPvl6F/fwvI+aSa48Pojr9KOYq5+TojXAnnV8RZ66p3YEYaHqgBPRpP1?=
 =?us-ascii?q?2ZYWbwgtcGCWoKvBQxTOLkiF2cSjNTaHGyX6Uz5jE/Fo2qF5vMRoeogLaZxi?=
 =?us-ascii?q?e0AoVWZnxaClCLCXrob5+LW+oIaC+JOs9uiCEEVby4R48k0hGusxX6xKR9Iu?=
 =?us-ascii?q?XI/S0YsMGr6N8gwezYllkR7zVwAtqc2GHFG2dynUsHQDg52K05qkt4nBPLyq?=
 =?us-ascii?q?V8gvpFBfRN6P5TFAQ3L5jRy6p9Ed+2EiDMcNmTRUfufNygDTwrBuktxNIWKx?=
 =?us-ascii?q?J/FtuskDjM2C2lB7JTnLuOUth8yqvB2zDUIMFnxj6SzKA8i3E+S9ZLcGihgb?=
 =?us-ascii?q?RysQPUAtiavV+ekvORaakE3CPLvFyGxG6KsVAQBBV8So3ZTHsfYQ3Qtt2/6U?=
 =?us-ascii?q?TcGez9QY87OxdMnJbRYpBBbcfk2BAfGabu?=
X-IPAS-Result: =?us-ascii?q?A2CICgDMhEBd/wHyM5BlHgEGBwaBZ4FtKoE+ATKESJEbT?=
 =?us-ascii?q?QEBAQEBAQaBCS2JYpEbCQEBAQEBAQEBATQBAgEBhEACgkIjOBMBAwEBAQQBA?=
 =?us-ascii?q?QEBBQEBbIUqgjopAYJnAQUjFVELDgoCAiYCAlcGAQwIAQGCXz+BdxSsaIEyh?=
 =?us-ascii?q?UiDMoFIgQwoi2AXeIEHgTiCaz6HT4JYBIwiiFeWBAmCHIIfkXEGG5gRjT2Za?=
 =?us-ascii?q?SGBWCsIAhgIIQ+DKJEhIwOBNgEBjW4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Jul 2019 17:59:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6UHxmIv013606;
        Tue, 30 Jul 2019 13:59:49 -0400
Subject: Re: userfaultfd SELinux support?
To:     Nick Kralevich <nnk@google.com>, selinux@vger.kernel.org,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Paul Moore <paul@paul-moore.com>
References: <CAFJ0LnFZcJRQdZzMYXvqodk=H45wEwCJt5evWa0YkM+P0pDtNA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <672ca771-12f4-b6c2-c05c-446860c05a0d@tycho.nsa.gov>
Date:   Tue, 30 Jul 2019 13:59:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnFZcJRQdZzMYXvqodk=H45wEwCJt5evWa0YkM+P0pDtNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/30/19 12:45 PM, Nick Kralevich wrote:
> In glancing over the SELinux code, it appears userfaultfd file
> descriptors are not managed by SELinux. Am I perhaps misreading the
> kernel code and this is supported? Or is this a known issue? If it's a
> known issue, has there been any attempt to add SELinux userfaultfd
> file descriptor support?

I believe that is correct. commit 
cefdca0a86be517bc390fc4541e3674b8e7803b0 introduced a 
vm.unprivileged_userfaultfd sysctl that can be set to 0 to restrict use 
of userfaultfd to processes with CAP_SYS_PTRACE (hence SELinux 
sys_ptrace), but that only restricts the userfaultfd() system call 
itself, not subsequent operations on the returned file.  Controlling 
operations on the userfaultfd files would require addressing the more 
general problem of how anonymous inodes are used and handled in the 
kernel. Presently they are marked S_PRIVATE and exempted by the security 
framework because they have no per-instance state and a single anon 
inode is typically shared by many users.  Setting another label in the 
file security struct and using that instead for permission checks may be 
the only option, but that requires the callers of 
anon_inode_getfd/anon_inode_getfile to pass in additional information 
about the object being represented so we can label it meaningfully.
