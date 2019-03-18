Return-Path: <SRS0=cHrg=RV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF222C43381
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 21:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C5D2133D
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 21:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCRVJn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:09:43 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:46400 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfCRVJn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Mar 2019 17:09:43 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 87EDB56007D
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2019 22:09:39 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] restorecond: use /run instead of /var/run
Date:   Mon, 18 Mar 2019 22:09:13 +0100
Message-Id: <20190318210913.2392-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Mar 18 22:09:39 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On most distributions, /var/run is a symbolic link to /run so using
/var/run or /run lead to the same result. Nevertheless systemd started
to warn about using /var/run in a service file, logging entries such as:

    /usr/lib/systemd/system/restorecond.service:8: PIDFile= references
    path below legacy directory /var/run/, updating
    /var/run/restorecond.pid → /run/restorecond.pid; please update the
    unit file accordingly.

Switch to /run in order to follow this advice.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 restorecond/restorecond.c       | 4 ++--
 restorecond/restorecond.conf    | 2 +-
 restorecond/restorecond.init    | 2 +-
 restorecond/restorecond.service | 2 +-
 restorecond/utmpwatcher.c       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
index 7b984b298f79..d5f70fc2e2c1 100644
--- a/restorecond/restorecond.c
+++ b/restorecond/restorecond.c
@@ -84,7 +84,7 @@ static void done(void) {
 	selabel_close(r_opts.hnd);
 }
 
-static const char *pidfile = "/var/run/restorecond.pid";
+static const char *pidfile = "/run/restorecond.pid";
 
 static int write_pid_file(void)
 {
@@ -217,7 +217,7 @@ int main(int argc, char **argv)
 	write_pid_file();
 
 	while (watch(master_fd, watch_file) == 0) {
-	};
+	}
 
 	watch_list_free(master_fd);
 	close(master_fd);
diff --git a/restorecond/restorecond.conf b/restorecond/restorecond.conf
index c64e74758d2f..1a61ece384d7 100644
--- a/restorecond/restorecond.conf
+++ b/restorecond/restorecond.conf
@@ -2,7 +2,7 @@
 /etc/resolv.conf
 /etc/samba/secrets.tdb
 /etc/updatedb.conf
-/var/run/utmp
+/run/utmp
 /var/log/wtmp
 /root/*
 /root/.ssh/*
diff --git a/restorecond/restorecond.init b/restorecond/restorecond.init
index 775c52b0ce7c..c1cbb247fa91 100644
--- a/restorecond/restorecond.init
+++ b/restorecond/restorecond.init
@@ -9,7 +9,7 @@
 #
 # processname: /usr/sbin/restorecond
 # config: /etc/selinux/restorecond.conf 
-# pidfile: /var/run/restorecond.pid
+# pidfile: /run/restorecond.pid
 #
 # Return values according to LSB for all commands but status:
 # 0 - success
diff --git a/restorecond/restorecond.service b/restorecond/restorecond.service
index 0511a1c740ac..6bce99d39735 100644
--- a/restorecond/restorecond.service
+++ b/restorecond/restorecond.service
@@ -6,7 +6,7 @@ ConditionSecurity=selinux
 [Service]
 Type=forking
 ExecStart=/usr/sbin/restorecond
-PIDFile=/var/run/restorecond.pid
+PIDFile=/run/restorecond.pid
 
 [Install]
 WantedBy=multi-user.target
diff --git a/restorecond/utmpwatcher.c b/restorecond/utmpwatcher.c
index 62ad2e98aff3..8660520370de 100644
--- a/restorecond/utmpwatcher.c
+++ b/restorecond/utmpwatcher.c
@@ -49,7 +49,7 @@ unsigned int utmpwatcher_handle(int inotify_fd, int wd)
 {
 	int changed = 0;
 	struct utmp u;
-	const char *utmp_path = "/var/run/utmp";
+	const char *utmp_path = "/run/utmp";
 	struct stringsList *prev_utmp_ptr = utmp_ptr;
 	if (wd != utmp_wd)
 		return -1;
-- 
2.20.1

