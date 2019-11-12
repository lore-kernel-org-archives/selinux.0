Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9EBC43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1D421872
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 16:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="MoPaPCnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfKLQkO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:40:14 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:42805 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLQkO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 11:40:14 -0500
X-EEMSG-check-017: 26206337|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,297,1569283200"; 
   d="scan'208";a="26206337"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Nov 2019 16:40:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573576811; x=1605112811;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=oTNMgvJqGFPdEjVtztnIzk8yE5BL2c1soQtjpy0cSTg=;
  b=MoPaPCnYjkRm/1ifNRm19G7LmqIn2F8MdlRCcHuopMjpQUirQIAWBodu
   4mjDlNBHH+HUQvFJrykQAK+ljdgocW6+BWdyltDjOniG18/oYq44A5baG
   PLotPq/p9i1q9RB+hnxpUdGh7woQfM7ye2TaAwqrEazj57RYU1CKLBfaV
   O8kQArH72ohE/oJO7mg3Sy4M/74zdrYp/gIX+FMS4DpCxt14M1TGumatI
   EJAMnPPXkBD0LS5rEc7y+7t7p3kcWld9aze7RIgNzB60wRLlhq3F5JrHy
   uoyGl8cV6hwaoW6U41OwSoKX8XIHJ6oSAedGDa2T9k/VnE/bfN4On78eR
   A==;
X-IronPort-AV: E=Sophos;i="5.68,297,1569283200"; 
   d="scan'208";a="29999898"
IronPort-PHdr: =?us-ascii?q?9a23=3AfgvqiRQbIqkfTQCVka7WrTyrkdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zZByN2/xhgRfzUJnB7Loc0qyK6vumADZRqsfY+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLq8Uan49vJqk1xx?=
 =?us-ascii?q?fUv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/2/Nisx0kalVvhSvqRJiyILQeY2YOv5zcqbbcNgHR2?=
 =?us-ascii?q?ROQ9xRWjRcDI2iYYsBD+kPM+hWoIbypVQBsRSwCBKwBO7s0DJEmmP60KM43u?=
 =?us-ascii?q?knDArI3BYgH9ULsHnMsdv1KLkdUfi1zKbWyzXIcu5Y2TLn54jMdhAuv/GNVq?=
 =?us-ascii?q?93fMrK1EYvDBjIjkmQqIP5PzOV0f4Bs26A7+V6T+6vhGknqx9orzWp28wihI?=
 =?us-ascii?q?7JhocPxVDF8yV02Ig1JcemR0FlfNGrDoBQtyKGN4txWsMuWWZouDw1yrAApJ?=
 =?us-ascii?q?W1fzAKxYw6yxPQZPGLaYiF7g/5WOqPLjp0mmhpdK+5ih2v60av0Pf8WdOx0F?=
 =?us-ascii?q?tSqypFlcTDuW4V2hzI78iHVuN9/kC82TaTzwzT6v9LIUQzlafDN54u2KQwlp?=
 =?us-ascii?q?sOsUTYBCP2hEX3g7OWdkUj4OSo7fjoYq76qZOGMo90iwX+Prwvmsy5H+s4Lh?=
 =?us-ascii?q?ADU3WU9OmzzrHu/VD1TK9UgvA5jKXVqo3WKdwepqGjAg9V1ogj6wy4DzejyN?=
 =?us-ascii?q?kYhmQILEledRKbj4nmJ1HOIPfiAfe5mFSjii1nx//BPr3/GpnNNGTMkK/9fb?=
 =?us-ascii?q?Zh7E5R0BY8zd9e5pJTDLEOPunzV1T+tNzfCR85PAi0zPjiCNpn14MeXXiDDb?=
 =?us-ascii?q?OeMKPXqVWI/P4gI/GQZI8JvzbwM+Ml6ODqjX84n18dYKao0IAJaHC3APtmOV?=
 =?us-ascii?q?+VYXnyjdcbF2cFoA4+QPbtiF2YXj4AL0q1Cok8/DAgFIOvC7Ds2Jyxm7eB0W?=
 =?us-ascii?q?/vFZJEYWZLEXiDFnDnc4iBUvYILimVJ5kl2icJUbmnVp8Jyx6jrkn5xqBhI+?=
 =?us-ascii?q?6S/TcX5rz5090g3PHejRE/83RPCs2Z12ycBzVvknggWy493Kc5p1d0jFiEz/?=
 =?us-ascii?q?4r0LRjCdVP6qYRAU8BPpnGwrk/UIH/?=
X-IPAS-Result: =?us-ascii?q?A2BxAgAB38pd/wHyM5BmGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0LGxVMoRTjwdUBoERJYlmkUMJAQEBAQEBAQEBLQcBAgEBgUyCL0UCg?=
 =?us-ascii?q?h0kOBMCDgEBAQQBAQEBAQUDAQFshTcMgjspgm4BBSMPAQVRCxgCAhIBEwICV?=
 =?us-ascii?q?wYBDAgBAYJfPwGCUiUPrziBMoF8g1KDNYFCBoEOKIwUGHiBB4ERJwyCMS4+g?=
 =?us-ascii?q?mIEgicCgkaCXgSNDAuJfnOWCIIvgjaEYYkuhHkGG4I9jBaLJo5HiDaTUSKBW?=
 =?us-ascii?q?CsIAhgIIQ+DKE8RFJBCF4hkhV0jA4E1AQGOGQ0XgTxeAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Nov 2019 16:40:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xACGe8of024170;
        Tue, 12 Nov 2019 11:40:08 -0500
Subject: Re: How to see SELinux denials late at shutdown
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <CAJ2a_DdN4koR+9+5UvYSp8U0KGA8Gq_ND9qTdAu6b8yQYmy82A@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <069d698d-9067-fc90-e666-b35d919df2ee@tycho.nsa.gov>
Date:   Tue, 12 Nov 2019 11:40:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAJ2a_DdN4koR+9+5UvYSp8U0KGA8Gq_ND9qTdAu6b8yQYmy82A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/12/19 8:08 AM, Christian Göttsche wrote:
> While trying to confine systemd-shutdown, I am unable to see any
> SELinux denials late at shutdown.
> I tested on Debian sid with systemd 242/243 and Linux 4.19.67-2/5.3.9-1.
> The command line is: `BOOT_IMAGE=/boot/vmlinuz-5.3.0-2-amd64
> root=UUID=0a22bd66-a082-4b76-b96b-ca5cff3ffdf6 ro security=selinux
> console=ttyS0 console=tty0 log_buf_len=1M printk.devkmsg=on`.
> When running poweroff or reboot, systemd-shutdown stalls but no denial
> is printed.
> With a script like [1] dmesg does not print any information.
> In permissive mode the system powers off/reboots, but no denials are printed.
> Trying to stop auditd/systemd-journald beforehand does not help.
> 
> Does the kernel itself shuts down the ring buffer, or can systemd
> interfere somehow?

systemd could be setting the console loglevel 
(SYSLOG_ACTION_CONSOLE_LEVEL) or disabling console logging altogether 
(SYSLOG_ACTION_CONSOLE_OFF).  Not sure why it would however.

Android had a nice facility for capturing kernel log messages after a 
reboot, originally via /proc/last_kmsg and later via 
/sys/fs/pstore/console-ramoops, but I don't think the Linux distros 
provide any equivalent.

> 
> 
> 
> [1]: https://freedesktop.org/wiki/Software/systemd/Debugging/#shutdowncompleteseventually
> 
> Shutdown log from serial console:
> 
> Debian GNU/Linux bullseye/sid debian-test ttyS0
> 
> debian-test login: [   15.644442] audit: type=1305
> audit(1573562456.536:57): audit_pid=0 old=394 auid=4294967295
> ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
> [   15.649464] audit: type=1131 audit(1573562456.540:58): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
> msg='unit=auditd comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> [   15.656430] audit: type=1131 audit(1573562456.548:59): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
> msg='unit=systemd-tmpfiles-setup comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> res=success'
> [   15.701848] audit: type=1131 audit(1573562456.592:60): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
> msg='unit=ifup@enp0s3 comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> [   15.712466] audit: type=1131 audit(1573562456.604:61): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
> msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd"
> hostname=? addr=? terminal=? res=success'
> [   15.720237] audit: type=1131 audit(1573562456.608:62): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
> msg='unit=systemd-modules-load comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> res=success'
> [   15.726141] audit: type=1131 audit(1573562456.616:63): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
> msg='unit=systemd-tmpfiles-setup-dev comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> res=success'
> [   15.731848] audit: type=1131 audit(1573562456.624:64): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
> msg='unit=systemd-sysusers comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> res=success'
> [   15.737084] audit: type=1131 audit(1573562456.628:65): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
> msg='unit=systemd-remount-fs comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> res=success'
> [   15.745161] audit: type=1130 audit(1573562456.632:66): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
> msg='unit=systemd-poweroff comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> res=success'
> [   15.866146] systemd-shutdown[1]: Syncing filesystems and block devices.
> [   15.948678] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
> [   15.998582] systemd-journald[263]: Received SIGTERM from PID 1
> (systemd-shutdow).
> [   16.103917] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
> [   16.113594] systemd-shutdown[1]: Unmounting file systems.
> [   16.116468] [484]: Remounting '/' read-only in with options
> 'seclabel,errors=remount-ro'.
> [   16.119280] [484]: Failed to remount '/' read-only: Permission denied
> [   16.121390] systemd-shutdown[1]: Not all file systems unmounted, 1 left.
> [   16.122819] systemd-shutdown[1]: Deactivating swaps.
> [   16.124065] systemd-shutdown[1]: All swaps deactivated.
> [   16.125264] systemd-shutdown[1]: Detaching loop devices.
> [   16.126533] systemd-shutdown[1]: All loop devices detached.
> [   16.129193] systemd-shutdown[1]: Detaching DM devices.
> [   16.130386] systemd-shutdown[1]: All DM devices detached.
> [   16.131646] systemd-shutdown[1]: Unmounting file systems.
> [   16.133535] [485]: Remounting '/' read-only in with options
> 'seclabel,errors=remount-ro'.
> [   16.134932] [485]: Failed to remount '/' read-only: Permission denied
> [   16.136708] systemd-shutdown[1]: Not all file systems unmounted, 1 left.
> [   16.137917] systemd-shutdown[1]: Cannot finalize remaining file
> systems, continuing.
> [   16.140467] systemd-shutdown[1]: Failed to finalize  file systems, ignoring
> [   16.142078] systemd-shutdown[1]: Syncing filesystems and block devices.
> [   16.159309] systemd-shutdown[1]: Powering off.
> [   16.160685] systemd-shutdown[1]: Failed to invoke reboot():
> Operation not permitted
> [   16.162408] systemd-shutdown[1]: Critical error while doing system
> shutdown: Operation not permitted
> 

