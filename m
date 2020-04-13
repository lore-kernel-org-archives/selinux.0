Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3DCC2BA2B
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 16:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AAAE20692
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 16:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbgDMQYn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:24:43 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:46175 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731510AbgDMQYm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Apr 2020 12:24:42 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2057F5613B7
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 18:24:40 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] restorecond/user: handle SIGTERM properly
Date:   Mon, 13 Apr 2020 18:24:13 +0200
Message-Id: <20200413162413.1161803-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200413162413.1161803-1-nicolas.iooss@m4x.org>
References: <20200413162413.1161803-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Apr 13 18:24:40 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When restorecond starts, it installs a SIGTERM handler in order to exit
cleanly (by removing its PID file). When restorecond --user starts,
there is no PID file, and g_main_loop_run() does not stop when master_fd
is closed. This leads to an unkillable service, which is an issue.

Fix this by overriding the handler for SIGTERM in restorecond --user.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 restorecond/user.c | 54 +++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/restorecond/user.c b/restorecond/user.c
index f940fd4e6678..a24b8407b048 100644
--- a/restorecond/user.c
+++ b/restorecond/user.c
@@ -46,6 +46,7 @@
 #include "restorecond.h"
 #include "stringslist.h"
 #include <glib.h>
+#include <glib-unix.h>
 
 static int local_lock_fd = -1;
 
@@ -250,35 +251,54 @@ static void end_local_server(void) {
 	local_lock_fd = -1;
 }
 
+static int sigterm_handler(gpointer user_data)
+{
+	GMainLoop *loop = user_data;
+
+	if (debug_mode)
+		g_print("Received SIGTERM, exiting\n");
+	g_main_loop_quit(loop);
+	return FALSE;
+}
+
+
 int server(int master_fd, const char *watch_file) {
-    GMainLoop *loop;
+	GMainLoop *loop;
 
-    loop = g_main_loop_new (NULL, FALSE);
+	loop = g_main_loop_new (NULL, FALSE);
 
 #ifdef HAVE_DBUS
-    if (dbus_server(loop) != 0)
+	if (dbus_server(loop) != 0)
 #endif /* HAVE_DBUS */
-	    if (local_server())
-		    goto end;
+		if (local_server())
+			goto end;
 
-    read_config(master_fd, watch_file);
+	read_config(master_fd, watch_file);
 
-    if (watch_list_isempty()) goto end;
+	if (watch_list_isempty())
+		goto end;
 
-    set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
+	set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
 
-    GIOChannel *c = g_io_channel_unix_new(master_fd);
+	GIOChannel *c = g_io_channel_unix_new(master_fd);
 
-    g_io_add_watch_full( c,
-			 G_PRIORITY_HIGH,
-			 G_IO_IN|G_IO_ERR|G_IO_HUP,
-			 io_channel_callback, NULL, NULL);
+	g_io_add_watch_full(c,
+			    G_PRIORITY_HIGH,
+			    G_IO_IN|G_IO_ERR|G_IO_HUP,
+			    io_channel_callback, NULL, NULL);
 
-    g_main_loop_run (loop);
+	/* Handle SIGTERM */
+	g_unix_signal_add_full(G_PRIORITY_DEFAULT,
+			       SIGTERM,
+			       sigterm_handler,
+			       loop,
+			       NULL);
+
+	g_main_loop_run (loop);
 
 end:
-    end_local_server();
-    g_main_loop_unref (loop);
-    return 0;
+	end_local_server();
+	g_main_loop_unref (loop);
+	return 0;
 }
 
-- 
2.26.0

