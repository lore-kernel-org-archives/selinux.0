Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D41C433DB
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 21:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0C022D05
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 21:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbhAMVui (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 16:50:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729206AbhAMVt2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 16:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610574480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=64/cELlUGmGm4wKYYVGBTgS7IeQcpibCsKEslQmvlD8=;
        b=EHgokiEcLIrzXLa1S6myB/pKAoXJcNVZZEjgiD0uVqN+3lu6OSnyNVuNnXZ2+YizS2uARQ
        WEyrsyxNlUBCRrnU1wvFbUX4iwWVylolu6kOw1ZWlbzqfKrRFSNw5XI4iBhDWOxAU5e4/b
        7C0LHsPHVL6//il9cy/QvtTnsmti1Dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-4YTTazZTPBealbnbApk-zw-1; Wed, 13 Jan 2021 16:44:11 -0500
X-MC-Unique: 4YTTazZTPBealbnbApk-zw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70E73802B42
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 21:44:10 +0000 (UTC)
Received: from localhost (unknown [10.40.193.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DE4A10016F6
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 21:44:09 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: can't unmount /sys/fs/selinux
Date:   Wed, 13 Jan 2021 22:44:09 +0100
Message-ID: <87wnwga4wm.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

we have few tests which uses `umount /sys/fs/selinux` trick to check how
userspace works in SELinux "disabled" environment. But it's not possible
with the current master:

    # umount /sys/fs/selinux
    umount: /sys/fs/selinux: target is busy.

    # lsof /sys/fs/selinux
    COMMAND      PID     USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
    systemd        1     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
    systemd        1     root   55r   REG   0,21        0   19 /sys/fs/selinux/status
    systemd-u    875     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
    systemd-u    875     root    6r   REG   0,21        0   19 /sys/fs/selinux/status
    dbus-brok   1116     dbus  mem    REG   0,21        0   19 /sys/fs/selinux/status
    dbus-brok   1116     dbus    5r   REG   0,21        0   19 /sys/fs/selinux/status
    systemd-l   1134     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
    systemd-l   1134     root    4r   REG   0,21        0   19 /sys/fs/selinux/status
    systemd     1643     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
    systemd     1643     root   28r   REG   0,21        0   19 /sys/fs/selinux/status
    (sd-pam)    1645     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
    ...
    sshd      218874     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
    sshd      218874     root    3r   REG   0,21        0   19 /sys/fs/selinux/status
    sshd      218880 plautrba  mem    REG   0,21        0   19 /sys/fs/selinux/status
    sshd      218880 plautrba    3r   REG   0,21        0   19 /sys/fs/selinux/status

It seems to be caused by commit 05bdc03130d7 ("libselinux: use kernel
status page by default") which replaced avc_netlink_open() in
avc_init_internal() with selinux_status_open()

In case of sshd process, /sys/fs/selinux/status seems to be mapped by
selinux_check_access() which is called from pam_selinux and it's left
open as there's no selinux_status_close() in selinux_check_access().
The similar situations probably happen in systemd and dbus.

So is it expected? Is it a bug? Do we need to change other components so
that they would call selinux_status_close() when they use check access?

Petr

