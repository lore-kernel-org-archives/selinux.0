Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F8AC43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 13:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B94214E0
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 13:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JlMkAVpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKLNIt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:08:49 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34035 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfKLNIt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 08:08:49 -0500
Received: by mail-vs1-f66.google.com with SMTP id y23so10740213vso.1
        for <selinux@vger.kernel.org>; Tue, 12 Nov 2019 05:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=L2w7atFrsx0eDAooyR/RhLB9kfjO37rVmN1+o5xPGC8=;
        b=JlMkAVppLw1DeWMl2wmFtMnRTumoEaR5tt6LjmaurezKgzf1NCGlcU17v4Y+jiQp8X
         QRPkCGd0ZfBfLY+XxeiwksGNKswEfkT6uviClAwsgBmaEnIeMyzfq7a4ddFQXEv1SLG/
         NQRc7NPiRVHFWvlZQYCKodFQyI0ZPK7sLrRQAW+fuu77lKkRqq8xDOUuHGKsgB4RuzS9
         ghnrcmvWGVmNaeaCY0RveijTFfSyuzoDmLGg8D/2xCYEDEHWXW1t4npLCs1H3f2O6dme
         kLioXWhhwtTqaFHXMbfdyS8frXL1Lnyg4JZhC7jZacfiyTnwfleUMxfSrkAHF0sB6iIJ
         DyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L2w7atFrsx0eDAooyR/RhLB9kfjO37rVmN1+o5xPGC8=;
        b=itOXw+HAS3wVqNgP9AjzGPcfj4cs9XBVF2Fd+gKRe0Ih9KJn7cXIEKwe5Hsh1wcAtd
         bEUZXt9zA6wOGApzTXlsErZb75c6+7LrcI4pjXH9ziELsiMTMw7N9njmRUbmc34VI834
         kEz8pvlS9FRCYPLEeD9zZxFi3ERldfK9lXhxH+28ijWi07P3wJpFJMzoNM4IA89tBKG6
         7VS1jl7gWdeaOiibSkQmj2ygU+Iken746gZTgAPEa8YbBuYP/Zuqm+zuHnwfQu+tFucJ
         jbwLtxcmbbzRxQ/4VZhId0J2fDMpOryu1Mh4cl1hYw6n6+dADbwrioGWHhNItUQfyT/n
         YQbw==
X-Gm-Message-State: APjAAAWXGvJImKPgXqseyPVdNk7z/KQcKgOyjstiPtNkfwj21IcguxVA
        qPhn8wNFrWz4LYlJebRVeruBzZ2w2/1HT3oEptJlQLYEQAg=
X-Google-Smtp-Source: APXvYqxvEL1jWXxPyQU/g3NIpJf37+kAqGaUjKStt2NntSiTPeAUuC8Xn5KoG783BESYIT0Ek1Bqqo96ryBAHY58AMs=
X-Received: by 2002:a67:e951:: with SMTP id p17mr22676323vso.112.1573564127217;
 Tue, 12 Nov 2019 05:08:47 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 12 Nov 2019 14:08:35 +0100
Message-ID: <CAJ2a_DdN4koR+9+5UvYSp8U0KGA8Gq_ND9qTdAu6b8yQYmy82A@mail.gmail.com>
Subject: How to see SELinux denials late at shutdown
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While trying to confine systemd-shutdown, I am unable to see any
SELinux denials late at shutdown.
I tested on Debian sid with systemd 242/243 and Linux 4.19.67-2/5.3.9-1.
The command line is: `BOOT_IMAGE=/boot/vmlinuz-5.3.0-2-amd64
root=UUID=0a22bd66-a082-4b76-b96b-ca5cff3ffdf6 ro security=selinux
console=ttyS0 console=tty0 log_buf_len=1M printk.devkmsg=on`.
When running poweroff or reboot, systemd-shutdown stalls but no denial
is printed.
With a script like [1] dmesg does not print any information.
In permissive mode the system powers off/reboots, but no denials are printed.
Trying to stop auditd/systemd-journald beforehand does not help.

Does the kernel itself shuts down the ring buffer, or can systemd
interfere somehow?



[1]: https://freedesktop.org/wiki/Software/systemd/Debugging/#shutdowncompleteseventually

Shutdown log from serial console:

Debian GNU/Linux bullseye/sid debian-test ttyS0

debian-test login: [   15.644442] audit: type=1305
audit(1573562456.536:57): audit_pid=0 old=394 auid=4294967295
ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
[   15.649464] audit: type=1131 audit(1573562456.540:58): pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
msg='unit=auditd comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success'
[   15.656430] audit: type=1131 audit(1573562456.548:59): pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
msg='unit=systemd-tmpfiles-setup comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   15.701848] audit: type=1131 audit(1573562456.592:60): pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
msg='unit=ifup@enp0s3 comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success'
[   15.712466] audit: type=1131 audit(1573562456.604:61): pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success'
[   15.720237] audit: type=1131 audit(1573562456.608:62): pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
msg='unit=systemd-modules-load comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   15.726141] audit: type=1131 audit(1573562456.616:63): pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
msg='unit=systemd-tmpfiles-setup-dev comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   15.731848] audit: type=1131 audit(1573562456.624:64): pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
msg='unit=systemd-sysusers comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   15.737084] audit: type=1131 audit(1573562456.628:65): pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
msg='unit=systemd-remount-fs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   15.745161] audit: type=1130 audit(1573562456.632:66): pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:systemd_t:s0
msg='unit=systemd-poweroff comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   15.866146] systemd-shutdown[1]: Syncing filesystems and block devices.
[   15.948678] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
[   15.998582] systemd-journald[263]: Received SIGTERM from PID 1
(systemd-shutdow).
[   16.103917] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
[   16.113594] systemd-shutdown[1]: Unmounting file systems.
[   16.116468] [484]: Remounting '/' read-only in with options
'seclabel,errors=remount-ro'.
[   16.119280] [484]: Failed to remount '/' read-only: Permission denied
[   16.121390] systemd-shutdown[1]: Not all file systems unmounted, 1 left.
[   16.122819] systemd-shutdown[1]: Deactivating swaps.
[   16.124065] systemd-shutdown[1]: All swaps deactivated.
[   16.125264] systemd-shutdown[1]: Detaching loop devices.
[   16.126533] systemd-shutdown[1]: All loop devices detached.
[   16.129193] systemd-shutdown[1]: Detaching DM devices.
[   16.130386] systemd-shutdown[1]: All DM devices detached.
[   16.131646] systemd-shutdown[1]: Unmounting file systems.
[   16.133535] [485]: Remounting '/' read-only in with options
'seclabel,errors=remount-ro'.
[   16.134932] [485]: Failed to remount '/' read-only: Permission denied
[   16.136708] systemd-shutdown[1]: Not all file systems unmounted, 1 left.
[   16.137917] systemd-shutdown[1]: Cannot finalize remaining file
systems, continuing.
[   16.140467] systemd-shutdown[1]: Failed to finalize  file systems, ignoring
[   16.142078] systemd-shutdown[1]: Syncing filesystems and block devices.
[   16.159309] systemd-shutdown[1]: Powering off.
[   16.160685] systemd-shutdown[1]: Failed to invoke reboot():
Operation not permitted
[   16.162408] systemd-shutdown[1]: Critical error while doing system
shutdown: Operation not permitted
