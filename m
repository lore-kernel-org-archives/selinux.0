Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC7EC433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 18:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A40220657
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 18:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHRSQm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:16:42 -0400
Received: from smtp-auth.no-ip.com ([8.23.224.60]:16221 "EHLO
        out.smtp-auth.no-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRSQm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 14:16:42 -0400
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2020 14:16:42 EDT
X-No-IP: flyn.org@noip-smtp
X-Report-Spam-To: abuse@no-ip.com
Received: from www.flyn.org (unknown [137.26.240.243])
        (Authenticated sender: flyn.org@noip-smtp)
        by smtp-auth.no-ip.com (Postfix) with ESMTPA id B9CE3853
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 11:11:23 -0700 (PDT)
Received: from imp.flyn.org (localhost [127.0.0.1])
        by www.flyn.org (Postfix) with ESMTP id C57092600101
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 14:11:22 -0400 (EDT)
Received: by imp.flyn.org (Postfix, from userid 1101)
        id 013AD2D800B4; Tue, 18 Aug 2020 13:11:21 -0500 (CDT)
Date:   Tue, 18 Aug 2020 13:11:20 -0500
From:   "W. Michael Petullo" <mike@flyn.org>
To:     selinux@vger.kernel.org
Subject: Working to enable SELinux on OpenWrt
Message-ID: <20200818181120.GA748671@imp.flyn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I am working with Thomas Petazzoni and the OpenWrt community to add
SELinux support to OpenWrt. OpenWrt is a Linux distribution tailored
for running routers and similar devices.

	https://github.com/openwrt/openwrt/pull/3207
	https://github.com/openwrt/packages/pull/10664

I am interested in enabling KERNEL_SECURITY_SELINUX_DEVELOP, which I
believe to be necessary if I am to enable and disable SELinux enforcement
at runtime. However, it seems that enabling this option in the kernel
causes the system to hang:

[...]
[    1.668419] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.675189] Waiting for root device PARTUUID=4ba37c2a-02...
[    2.100751] tsc: Refined TSC clocksource calibration: 1995.376 MHz
[    2.113719] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x39863c423f0, max_idle_ns: 881590675958 ns
[    2.122334] clocksource: Switched to clocksource tsc

It is not clear to me whether the kernel or the init process is
hanging. Things boot fine when KERNEL_SECURITY_SELINUX_DEVELOP=n.

I have tried a number of kernel command line parameters, thinking perhaps
SELinux is preventing the use of the console. This has not yet helped.

The OpenWrt init is available at:

	https://git.openwrt.org/?p=project/procd.git,

and it now includes a commit from Thomas that calls
selinux_init_load_policy().

Does anyone have any idea what might be causing this hang? Is there
a user-space requirement to finish the boot process when
KERNEL_SECURITY_SELINUX_DEVELOP=y?

I would also very much appreciate any comments on the two GitHub merge
requests above. I think OpenWrt would provide a compelling use case for
SELinux, and thus I (along with Thomas) have invested a fair amount of
time trying to get this accepted by the OpenWrt team.

-- 
Mike

:wq
