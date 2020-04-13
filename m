Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E3BC2BBFD
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 16:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD4820678
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 16:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbgDMQYl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:24:41 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:58335 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731510AbgDMQYk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Apr 2020 12:24:40 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5D86756460B
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 18:24:38 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] restorecond: add systemd user service
Date:   Mon, 13 Apr 2020 18:24:12 +0200
Message-Id: <20200413162413.1161803-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200413162413.1161803-1-nicolas.iooss@m4x.org>
References: <20200413162413.1161803-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Apr 13 18:24:38 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When running restorecond in user sessions using D-Bus activation,
restorecond's process is spawned in the CGroup of the D-Bus daemon:

    $ systemctl --user status
    [...]
       CGroup: /user.slice/user-1000.slice/user@1000.service
               ├─init.scope
               │ ├─1206 /usr/lib/systemd/systemd --user
               │ └─1208 (sd-pam)
               └─dbus.service
                 ├─1628 /usr/bin/dbus-daemon --session --address=systemd:
                 └─4570 /usr/sbin/restorecond -u

In order to separate it, introduce a systemd unit for
restorecond-started-as-user.

After this patch:

       CGroup: /user.slice/user-1000.slice/user@1000.service
               ├─restorecond-user.service
               │ └─2871 /usr/sbin/restorecond -u
               ├─init.scope
               │ ├─481 /usr/lib/systemd/systemd --user
               │ └─485 (sd-pam)
               └─dbus.service
                 └─2868 /usr/bin/dbus-daemon --session --address=systemd:

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 restorecond/Makefile                        |  2 ++
 restorecond/org.selinux.Restorecond.service |  1 +
 restorecond/restorecond-user.service        | 10 ++++++++++
 3 files changed, 13 insertions(+)
 create mode 100644 restorecond/restorecond-user.service

diff --git a/restorecond/Makefile b/restorecond/Makefile
index 50702c661aeb..501f89dfca57 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -50,6 +50,8 @@ install: all
 	install -m 644 org.selinux.Restorecond.service  $(DESTDIR)$(DBUSSERVICEDIR)/org.selinux.Restorecond.service
 	-mkdir -p $(DESTDIR)$(SYSTEMDDIR)/system
 	install -m 644 restorecond.service $(DESTDIR)$(SYSTEMDDIR)/system/
+	-mkdir -p $(DESTDIR)$(SYSTEMDDIR)/user
+	install -m 644 restorecond-user.service $(DESTDIR)$(SYSTEMDDIR)/user/
 relabel: install
 	/sbin/restorecon $(DESTDIR)$(SBINDIR)/restorecond 
 
diff --git a/restorecond/org.selinux.Restorecond.service b/restorecond/org.selinux.Restorecond.service
index 0ef5f0b5cdc5..55989a9cbbd0 100644
--- a/restorecond/org.selinux.Restorecond.service
+++ b/restorecond/org.selinux.Restorecond.service
@@ -1,3 +1,4 @@
 [D-BUS Service]
 Name=org.selinux.Restorecond
 Exec=/usr/sbin/restorecond -u
+SystemdService=restorecond-user.service
diff --git a/restorecond/restorecond-user.service b/restorecond/restorecond-user.service
new file mode 100644
index 000000000000..28ca770f94cb
--- /dev/null
+++ b/restorecond/restorecond-user.service
@@ -0,0 +1,10 @@
+[Unit]
+Description=Restorecon maintaining path file context (user service)
+Documentation=man:restorecond(8)
+ConditionPathExists=/etc/selinux/restorecond_user.conf
+ConditionSecurity=selinux
+
+[Service]
+Type=dbus
+BusName=org.selinux.Restorecond
+ExecStart=/usr/sbin/restorecond -u
-- 
2.26.0

