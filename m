Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4210C43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 16:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF152196E
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 16:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="PyzYYrqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfKLQtT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:49:19 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:4595 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLQtT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 11:49:19 -0500
X-EEMSG-check-017: 49610455|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,297,1569283200"; 
   d="scan'208";a="49610455"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Nov 2019 16:49:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573577358; x=1605113358;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=QDumeDyUzs2uZUEu0pgSTHSSqyYVAlZ7vZPp00oQr7k=;
  b=PyzYYrqeLLlsR+xaAwhAFx6HrPYDHa4fxRlgYEEy5GcnP+pGgKErM8mM
   s6Bq82SooksNFGI138CVwuqdrjE5nbXy5AuPZ3IszfHqUCWeh7Fdc+AQj
   pYkJ+wHEc2DRT5uXdpof1uODy9RU3Brif0qdNnKQ9bn/i2fQvKiPpwcS2
   qG47MCIOuoW96JDqIuUTo/Z+K+Mwk8mAlFKSABCe+OW76eF1Z4HOOWZWi
   Q7ukqfz6syzzFOMTfQK4n7yCR9DzUZKShX1bLGnqmHL2Wo6wRzgwTBZeo
   mAHc1mQR92u1zcjWCDt8IYiPY2SZtx32wLF8B2Wfb6YYUMbJFXhyKx3a6
   g==;
X-IronPort-AV: E=Sophos;i="5.68,297,1569283200"; 
   d="scan'208";a="35400680"
IronPort-PHdr: =?us-ascii?q?9a23=3AlzOfLBE14hu+G5BVArhF551GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yp8SwAkXT6L1XgUPTWs2DsrQY0rGQ6vqxEj1Zqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmssAndqM0bjYRmJ6os1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMODAj8GHTl8d+kqRVrhy8rBB72oLZboWYOP94c6jAf90VWH?=
 =?us-ascii?q?BBU95MWSJBHI28YYgBAeQPMulXrYbyu1QAoACiBQSvHu7j1iNEi3H00KA8zu?=
 =?us-ascii?q?8vERvG3AslH98WrXrUsMv6NL8SUe+ryqnD0CjNb/ZM1jf57IjHbBAgquyLUL?=
 =?us-ascii?q?JrbMXR0lIiFx/Fj1qMqYzlOCmZ1uIWs2eB9eZgWuWvi3A+pgx3vzOhyMAsio?=
 =?us-ascii?q?zTiYIUzFDJ7St5wJwrKtKmVUF0f8WkEJhMtyGdL4t6WMQiQ3tnuCs817YIuo?=
 =?us-ascii?q?a7cTAXxJkoyBPTcfyKf5WS7h79W+udPy10iG9jdbminRi961Kgxff5VsSs1V?=
 =?us-ascii?q?ZKqTdKncfUu3AW0hzT9tCHSvxg/ke9wTqP1x7c6uVDIU0siarUMYQhwr8tlp?=
 =?us-ascii?q?oIq0jDAi/3l1n2jK+RbEkk/PSn6//7bbn8o5+cNot0hhn/MqQohMO/Hfw1Ph?=
 =?us-ascii?q?UBUmWU4+ix1KDv8VfnTLhFkPE6iLTVvIjfJcsBp665BwFV0pwk6xa6Fzqmy8?=
 =?us-ascii?q?kXnWIcIVJZeBOIk4jpO1bULPD+FvewmU6gkDhsx/DYJrHhGInCLmDfkLf9er?=
 =?us-ascii?q?Zw81JTyAUyzNBY4ZJbFKoBLen8Wk/2s9zYARs5PBKxw+n9CdV90pkSVn6IAq?=
 =?us-ascii?q?+cKKnSq0OH5vozI+mQY48YoC39JOYh5/7vi385hFAccLK33ZsYdn+4BO5qI0?=
 =?us-ascii?q?aHbnr2hNcOD2MKshA5TOzwh13RGQJUMl2yRaMn+jAyDrWJk5vfXYutjfTV1y?=
 =?us-ascii?q?ipGZtbfUhJDVeDFXrtfoSAHfwLbXTWatRslj0CSKiJVYAsz1etuRX8xr4hKf?=
 =?us-ascii?q?DbqQMCspe278R4/+3ek1kJ8DVwC8mMmzWWQ3pcgnIDRzhw2rt250N61AHQgu?=
 =?us-ascii?q?BDn/VEGIkLtLtyWQAgOMuZlL13?=
X-IPAS-Result: =?us-ascii?q?A2BQBwCt4cpd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?CxsVTKEU48HVAaBNolmkUMJAQEBAQEBAQEBLQcBAgEBgUyCL0UCgh0kOBMCD?=
 =?us-ascii?q?gEBAQQBAQEBAQUDAQFshTcMgjspgm4BBSMPAQVRCxgCAhIBEwICVwYBDAgBA?=
 =?us-ascii?q?YJfPwGCUiUPrz+BMoF8hwaBQgaBDiiMFBh4gQeBESeCPS4+gmIEgicCgkaCX?=
 =?us-ascii?q?gSNDAuJfnOWCIIvgjaEYYkuF4RiBhuCPS+LZ4smjkeINpNRIoFYKwgCGAghD?=
 =?us-ascii?q?4MoTxEUkEIXiGSFXSMDgTUBAY4ZDReBPF4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Nov 2019 16:49:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xACGnEZa024270;
        Tue, 12 Nov 2019 11:49:14 -0500
Subject: Re: How to see SELinux denials late at shutdown
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <CAJ2a_DdN4koR+9+5UvYSp8U0KGA8Gq_ND9qTdAu6b8yQYmy82A@mail.gmail.com>
 <069d698d-9067-fc90-e666-b35d919df2ee@tycho.nsa.gov>
Message-ID: <c2dea4c1-d67b-d872-284f-acde6e9ba58a@tycho.nsa.gov>
Date:   Tue, 12 Nov 2019 11:49:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <069d698d-9067-fc90-e666-b35d919df2ee@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/12/19 11:40 AM, Stephen Smalley wrote:
> On 11/12/19 8:08 AM, Christian Göttsche wrote:
>> While trying to confine systemd-shutdown, I am unable to see any
>> SELinux denials late at shutdown.
>> I tested on Debian sid with systemd 242/243 and Linux 4.19.67-2/5.3.9-1.
>> The command line is: `BOOT_IMAGE=/boot/vmlinuz-5.3.0-2-amd64
>> root=UUID=0a22bd66-a082-4b76-b96b-ca5cff3ffdf6 ro security=selinux
>> console=ttyS0 console=tty0 log_buf_len=1M printk.devkmsg=on`.
>> When running poweroff or reboot, systemd-shutdown stalls but no denial
>> is printed.
>> With a script like [1] dmesg does not print any information.
>> In permissive mode the system powers off/reboots, but no denials are 
>> printed.
>> Trying to stop auditd/systemd-journald beforehand does not help.
>>
>> Does the kernel itself shuts down the ring buffer, or can systemd
>> interfere somehow?
> 
> systemd could be setting the console loglevel 
> (SYSLOG_ACTION_CONSOLE_LEVEL) or disabling console logging altogether 
> (SYSLOG_ACTION_CONSOLE_OFF).  Not sure why it would however.
> 
> Android had a nice facility for capturing kernel log messages after a 
> reboot, originally via /proc/last_kmsg and later via 
> /sys/fs/pstore/console-ramoops, but I don't think the Linux distros 
> provide any equivalent.

I've seen lossage of SELinux avc denials due to the printk or audit 
ratelimits in the past, FWIW, but you are supposed to then get a notice 
that there were lost records...

> 
>>
>>
>>
>> [1]: 
>> https://freedesktop.org/wiki/Software/systemd/Debugging/#shutdowncompleteseventually 
>>
>>
>> Shutdown log from serial console:
>>
>> Debian GNU/Linux bullseye/sid debian-test ttyS0
>>
>> debian-test login: [   15.644442] audit: type=1305
>> audit(1573562456.536:57): audit_pid=0 old=394 auid=4294967295
>> ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
>> [   15.649464] audit: type=1131 audit(1573562456.540:58): pid=1 uid=0
>> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
>> msg='unit=auditd comm="systemd" exe="/usr/lib/systemd/systemd"
>> hostname=? addr=? terminal=? res=success'
>> [   15.656430] audit: type=1131 audit(1573562456.548:59): pid=1 uid=0
>> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
>> msg='unit=systemd-tmpfiles-setup comm="systemd"
>> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
>> res=success'
>> [   15.701848] audit: type=1131 audit(1573562456.592:60): pid=1 uid=0
>> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
>> msg='unit=ifup@enp0s3 comm="systemd" exe="/usr/lib/systemd/systemd"
>> hostname=? addr=? terminal=? res=success'
>> [   15.712466] audit: type=1131 audit(1573562456.604:61): pid=1 uid=0
>> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
>> msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd"
>> hostname=? addr=? terminal=? res=success'
>> [   15.720237] audit: type=1131 audit(1573562456.608:62): pid=1 uid=0
>> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
>> msg='unit=systemd-modules-load comm="systemd"
>> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
>> res=success'
>> [   15.726141] audit: type=1131 audit(1573562456.616:63): pid=1 uid=0
>> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
>> msg='unit=systemd-tmpfiles-setup-dev comm="systemd"
>> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
>> res=success'
>> [   15.731848] audit: type=1131 audit(1573562456.624:64): pid=1 uid=0
>> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
>> msg='unit=systemd-sysusers comm="systemd"
>> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
>> res=success'
>> [   15.737084] audit: type=1131 audit(1573562456.628:65): pid=1 uid=0
>> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
>> msg='unit=systemd-remount-fs comm="systemd"
>> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
>> res=success'
>> [   15.745161] audit: type=1130 audit(1573562456.632:66): pid=1 uid=0
>> auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
>> msg='unit=systemd-poweroff comm="systemd"
>> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
>> res=success'
>> [   15.866146] systemd-shutdown[1]: Syncing filesystems and block 
>> devices.
>> [   15.948678] systemd-shutdown[1]: Sending SIGTERM to remaining 
>> processes...
>> [   15.998582] systemd-journald[263]: Received SIGTERM from PID 1
>> (systemd-shutdow).
>> [   16.103917] systemd-shutdown[1]: Sending SIGKILL to remaining 
>> processes...
>> [   16.113594] systemd-shutdown[1]: Unmounting file systems.
>> [   16.116468] [484]: Remounting '/' read-only in with options
>> 'seclabel,errors=remount-ro'.
>> [   16.119280] [484]: Failed to remount '/' read-only: Permission denied
>> [   16.121390] systemd-shutdown[1]: Not all file systems unmounted, 1 
>> left.
>> [   16.122819] systemd-shutdown[1]: Deactivating swaps.
>> [   16.124065] systemd-shutdown[1]: All swaps deactivated.
>> [   16.125264] systemd-shutdown[1]: Detaching loop devices.
>> [   16.126533] systemd-shutdown[1]: All loop devices detached.
>> [   16.129193] systemd-shutdown[1]: Detaching DM devices.
>> [   16.130386] systemd-shutdown[1]: All DM devices detached.
>> [   16.131646] systemd-shutdown[1]: Unmounting file systems.
>> [   16.133535] [485]: Remounting '/' read-only in with options
>> 'seclabel,errors=remount-ro'.
>> [   16.134932] [485]: Failed to remount '/' read-only: Permission denied
>> [   16.136708] systemd-shutdown[1]: Not all file systems unmounted, 1 
>> left.
>> [   16.137917] systemd-shutdown[1]: Cannot finalize remaining file
>> systems, continuing.
>> [   16.140467] systemd-shutdown[1]: Failed to finalize  file systems, 
>> ignoring
>> [   16.142078] systemd-shutdown[1]: Syncing filesystems and block 
>> devices.
>> [   16.159309] systemd-shutdown[1]: Powering off.
>> [   16.160685] systemd-shutdown[1]: Failed to invoke reboot():
>> Operation not permitted
>> [   16.162408] systemd-shutdown[1]: Critical error while doing system
>> shutdown: Operation not permitted
>>
> 

