Return-Path: <SRS0=eFyr=Q4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1195DC43381
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 20:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63362081B
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 20:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfBUUbZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:31:25 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:37266 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUUbZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Feb 2019 15:31:25 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A11425613AC
        for <selinux@vger.kernel.org>; Thu, 21 Feb 2019 21:31:22 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id g1so46002059otj.11
        for <selinux@vger.kernel.org>; Thu, 21 Feb 2019 12:31:22 -0800 (PST)
X-Gm-Message-State: AHQUAuaJ8Gz8nyIc5HMtYo3Svb/vcHx2DhD+QtNNjGnT627kibYhovqI
        m1zsGWdjjC7cTaCP/gwHFkHm4+sexsk65o/iaPM=
X-Google-Smtp-Source: AHgI3IYrxap2EJDjoXlnJVql7X8B4ie1ajORJynFjqHXME6j9fRcsX+Jfolq21rIPTigd2qbsIXGeEoiAXgAkn9TU3I=
X-Received: by 2002:a05:6830:125a:: with SMTP id s26mr339542otp.74.1550781081617;
 Thu, 21 Feb 2019 12:31:21 -0800 (PST)
MIME-Version: 1.0
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 21 Feb 2019 21:31:10 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=n7c8s-uiGjD=FRMahRQBQANzSa5FbRKSov4w=EZj+f-w@mail.gmail.com>
Message-ID: <CAJfZ7=n7c8s-uiGjD=FRMahRQBQANzSa5FbRKSov4w=EZj+f-w@mail.gmail.com>
Subject: .desktop files installed by gui/
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Feb 21 21:31:23 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

Currently, gui/Makefile installs three .desktop files:
* /usr/share/system-config-selinux/selinux-polgengui.desktop (with
"Exec=/usr/bin/selinux-polgengui")
* /usr/share/system-config-selinux/sepolicy.desktop (with
"Exec=/usr/bin/sepolicy gui")
* /usr/share/system-config-selinux/system-config-selinux.desktop (with
Exec=/usr/bin/system-config-selinux)

There are several issues about them:
* The first one does not work because "make install" does not create
/usr/bin/selinux-polgengui. It creates
/usr/share/system-config-selinux/polgengui.py instead.
* The first two ones do not work on Arch Linux because the commands
they use need to be run as root in order to load.
* None of them are seen by GNOME or XFCE, which look for .desktop
files in /usr/share/applications/. This has been reported for Arch
Linux on https://github.com/archlinuxhardened/selinux/issues/20.

Are these files used by other distributions? Would it break things if
these files are moved to /usr/share/applications/ and if pkexec is
introduced in order to run commands as root (ie.
selinux-polgengui.desktop is changed to "Exec=/usr/bin/pkexec
/usr/share/system-config-selinux/polgengui.py" and sepolicy.desktop to
"Exec=/usr/bin/pkexec /usr/bin/sepolicy gui")?

Nicolas

