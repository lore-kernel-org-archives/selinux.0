Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3063C43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 14:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9829720661
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 14:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfB0OCJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:02:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730392AbfB0OCJ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 27 Feb 2019 09:02:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2A148D3B8;
        Wed, 27 Feb 2019 14:02:08 +0000 (UTC)
Received: from workstation (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F092A19C7B;
        Wed, 27 Feb 2019 14:02:07 +0000 (UTC)
References: <CAJfZ7=n7c8s-uiGjD=FRMahRQBQANzSa5FbRKSov4w=EZj+f-w@mail.gmail.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Subject: Re: .desktop files installed by gui/
In-reply-to: <CAJfZ7=n7c8s-uiGjD=FRMahRQBQANzSa5FbRKSov4w=EZj+f-w@mail.gmail.com>
Date:   Wed, 27 Feb 2019 15:02:06 +0100
Message-ID: <pjdimx5l481.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 27 Feb 2019 14:02:08 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> Hello,
>
> Currently, gui/Makefile installs three .desktop files:
> * /usr/share/system-config-selinux/selinux-polgengui.desktop 
> (with
> "Exec=/usr/bin/selinux-polgengui")
> * /usr/share/system-config-selinux/sepolicy.desktop (with
> "Exec=/usr/bin/sepolicy gui")
> * /usr/share/system-config-selinux/system-config-selinux.desktop 
> (with
> Exec=/usr/bin/system-config-selinux)
>
> There are several issues about them:
> * The first one does not work because "make install" does not 
> create
> /usr/bin/selinux-polgengui. It creates
> /usr/share/system-config-selinux/polgengui.py instead.
> * The first two ones do not work on Arch Linux because the 
> commands
> they use need to be run as root in order to load.
> * None of them are seen by GNOME or XFCE, which look for 
> .desktop
> files in /usr/share/applications/. This has been reported for 
> Arch
> Linux on https://github.com/archlinuxhardened/selinux/issues/20.
>
> Are these files used by other distributions? Would it break 
> things if
> these files are moved to /usr/share/applications/ 

This is from Fedora policycoreutils.spec:

---
ln -sf /usr/share/system-config-selinux/polgengui.py 
%{buildroot}%{_bindir}/selinux-polgengui

desktop-file-install --dir %{buildroot}%{_datadir}/applications 
--add-category Settings \
    %{buildroot}%{_datadir}/system-config-selinux/system-config-selinux.desktop

desktop-file-install --dir %{buildroot}%{_datadir}/applications 
--add-category Settings \
    %{buildroot}%{_datadir}/system-config-selinux/sepolicy.desktop

desktop-file-install --dir %{buildroot}%{_datadir}/applications \
    %{buildroot}%{_datadir}/system-config-selinux/selinux-polgengui.desktop

rm -f 
%{buildroot}%{_datadir}/system-config-selinux/selinux-polgengui.desktop
rm -f 
%{buildroot}%{_datadir}/system-config-selinux/sepolicy.desktop
rm -f 
%{buildroot}%{_datadir}/system-config-selinux/system-config-selinux.desktop
---

It's been like that for more than 6 years already.

Given that it addresses almost all the described problems I can 
say that
your proposed changes won't break anything in Fedora.

> and if pkexec is
> introduced in order to run commands as root (ie.
> selinux-polgengui.desktop is changed to "Exec=/usr/bin/pkexec
> /usr/share/system-config-selinux/polgengui.py" and 
> sepolicy.desktop to
> "Exec=/usr/bin/pkexec /usr/bin/sepolicy gui")?
>

/usr/share/system-config-selinux/polgengui.py works without root 
on
Fedora.

sepolicy gui asks for privileges on "Action:
org.selinux.customized" which is decorated by
@slip.dbus.polkit.require_auth so I'm not sure if pkexec is really 
needed.




> Nicolas

