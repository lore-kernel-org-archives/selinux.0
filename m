Return-Path: <SRS0=JJ8R=XP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91378C49ED7
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 12:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62533208C0
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 12:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="LSNFVk4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfITMfH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:35:07 -0400
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:15869 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfITMfG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Sep 2019 08:35:06 -0400
X-EEMSG-check-017: 10483359|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="10483359"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Sep 2019 12:35:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568982905; x=1600518905;
  h=to:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=V67GZW9pEuX57lPcMZ1EVdff3L7ZO3SKdkQkfKt3wCc=;
  b=LSNFVk4rRzcUhyQn53qZm9t76NoZtYLiC6vGr/ZY9HOd8G+yUPHiFF4u
   6Q65Fh64lopDkGfPii7jpLJlYqGKTSE2q77WsxNCavc1AVdn7wYOATeEh
   F8QqiK94qu3t6skn/D73ihrs0m1VH2S7TxW4UJwHcchVtzISYfBwgRbLN
   0UoS6txuHvK53mWbr8T7XPiu8+BAPV5KiuY8CJS3goJ2EmUSmJ07+Qyuc
   U406vxhQnxV8d/jwi95H85R7uMGjrkksK3Tp7zy/hhwkclVJcvMPZCPLB
   vuYzJ/+jGm/xTsxk5eSi4njr0mUEqN2Ku+kgCiJtGWDhyI7JwAhPEwIE+
   w==;
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="33124804"
IronPort-PHdr: =?us-ascii?q?9a23=3AUyTUrBWmSW7Zu3ggUnYHxE0l/3TV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbB2Dt8tkgFKBZ4jH8fUM07OQ7/m7HzZaqsvZ+DBaKdoQDk?=
 =?us-ascii?q?VD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs/xx?=
 =?us-ascii?q?fTvHdEZetayGN0KVmOmxrw+tq88IRs/ihNpf4t7dJMXbn/c68lUbFWETMqPn?=
 =?us-ascii?q?wv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qi?=
 =?us-ascii?q?mi4LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2?=
 =?us-ascii?q?dKQ8heVzZFAoihcYUBCeQPNvtco4XkuVcDqR6yCA+xD+3t1zBInGf707M63e?=
 =?us-ascii?q?o8Eg/I0gIvEN0Sv3rbt9j1KKUfXPqpwKXUwzjObfVb0ir95ojSdRAhpOmBU6?=
 =?us-ascii?q?9sccXP0UkvFx3KjlONooL4OjOazOANs2yF4OtgSOmijHUnpBxqojW02sctip?=
 =?us-ascii?q?XGhoISylze8yV525w6Kce3SE58f96pCZ1dvDyUOYtxR8MtWWBouCAix70dpZ?=
 =?us-ascii?q?G7fDYFx4k9yxHDbPyHdpCE4hbiVOaXPDd5i3xleLWihxa07Eev0PH8Vsiz0F?=
 =?us-ascii?q?ZMtCZFlcPMtn8V2x3T7ciHV+d9/lq61jmRzQzc9uZEIUUymKHGKJAh2qY9mo?=
 =?us-ascii?q?ccvEnMBCP7mFj6gLWIekgr5OSk8fnrb7P7rZGGLYB0kBvxMqE2l8y6BuQ3Lx?=
 =?us-ascii?q?YBUnCA+eS5yL3j5Ur5QKhWjvEukqnWrpTaJcMDq66lGQBVyIcj6wukDzu8zN?=
 =?us-ascii?q?QZnWUILFJCeB6diYjmJ0rOL+ziAfe6glSslC9nx/HAPrL/HpXANmXPnbjucL?=
 =?us-ascii?q?pn60NQ1RA/wc5Q6p5KEL0NPer/Wkrru9zZCh85PRa0w+HiCNhlzYMRRHmPD7?=
 =?us-ascii?q?SFMKLSrVCI5uUvL/OKZI8OojnxMfcl5/nwjXMhg18SYbGp3YcLaHC/BvlmOF?=
 =?us-ascii?q?uWYX7tgtcHDGcLsREzTPLliFKcSz5ffXWyULwm5jE9Fo2mCZ3PRoe3gLyOj2?=
 =?us-ascii?q?+HGchtS0RHDE2cWSPzeoGFXeocQDydL9UnkTEeU7WlDYg72kf9mhX9zu9cMu?=
 =?us-ascii?q?fM+iAe/anm3dxx6vybwQo+7hRoHs+d1CeLVGgykWQWEWxllJtjqFBwnw/QmZ?=
 =?us-ascii?q?NzhOZVQJkJtv4=3D?=
X-IPAS-Result: =?us-ascii?q?A2BMEQAdx4Rd/wHyM5BkHgEZDIFVgXQqbVMyKoQijxhNA?=
 =?us-ascii?q?QEBAQEBBosrjy2BewkBAQEBAQEBAQEbEgcBAgEBh0ojNAkOAgwBAQEEAQEBA?=
 =?us-ascii?q?QEFAwEBbIUtDII6KYJsJRV2AiYCXw0IAQEQgk8/AYF2FA+sJoEyhDsDAgGBC?=
 =?us-ascii?q?4M0gUMGgQwojAkYeIEHgTiGCgEBAQEBF4RSglgElgKXC4Isgi6EV41/BhuCN?=
 =?us-ascii?q?pZwj1aGV41EhTo4gVgrCAIYCCEPgydQEBSFQIUUhVskAzABC3oBAY42AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 20 Sep 2019 12:34:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8KCYt02010466
        for <selinux@vger.kernel.org>; Fri, 20 Sep 2019 08:34:56 -0400
To:     SELinux <selinux@vger.kernel.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Subject: SELinux-related talks at LSS NA
Message-ID: <395c19b5-608e-9ad6-c8d1-5920983275e9@tycho.nsa.gov>
Date:   Fri, 20 Sep 2019 08:34:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For those who couldn't attend, the slides and videos from LSS NA are 
available from 
https://events.linuxfoundation.org/events/linux-security-summit-north-america-2019/

Of particular relevance to the SELinux community are my Retrospective: 
26 Years of Flexible MAC talk [1][2], which sets SELinux in its context 
within our larger program of R&D into flexible MAC, and Paul's State of 
SELinux update [3][4].  There are a number of other talks that are 
likely to be of interest as well.

[1] 
https://static.sched.com/hosted_files/lssna19/e5/LSS2019-Retrospective-16-9.pdf
[2] https://www.youtube.com/watch?v=AKWFbxbsU3o
[3] 
https://static.sched.com/hosted_files/lssna19/9d/lss-state_of_selinux-pmoore-201908-r2.pdf
[4] https://www.youtube.com/watch?v=spepTDfYeBQ

