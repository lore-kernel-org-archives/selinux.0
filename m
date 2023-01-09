Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32590C5479D
	for <selinux@archiver.kernel.org>; Mon,  9 Jan 2023 17:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjAIRLP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbjAIRKk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Jan 2023 12:10:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D14F4FD6F
        for <selinux@vger.kernel.org>; Mon,  9 Jan 2023 09:09:25 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fy8so21725969ejc.13
        for <selinux@vger.kernel.org>; Mon, 09 Jan 2023 09:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sD7mrY9Cg/mtzmNIALeRYulY+OKEJ52wK5K/ChqI52o=;
        b=g7UklN7bsXDCOBizxkqFk9ItFM8zYzJ+v5XN4/2Dc9EMg9DNVsR4stsPyZlKjvz4rY
         pFQl5Ms/9wIE8YMHPHHPGjYjzbbg+IhUxgvwEqQ9TraXxtNjWWB5Jzo+g+1y828mbJb0
         u3Ly8i8fpnzXPRoVnsstA1fvuEsYpUatwOwEOpa5U+3EFcK0R+9MWZd+D3bwPnKfzZCx
         mrgur0FJu8zf8qJKUd9zjuMPJFjeEK0CpfyPNkQDnyVk753x22CYhwFJIHWiTlK+8F9U
         cHKTajiyz57n6sG9M+ehf1dLV3jFmodeurwaKhEM27j/8lamLLsA6J08KNoXcAVC9Z4k
         yl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sD7mrY9Cg/mtzmNIALeRYulY+OKEJ52wK5K/ChqI52o=;
        b=Ufp7mdbGkJt37TZoUzF7FRqkhVo9eBqmfL8kcHMB2OyjOZR6lL6qShEryYO9hNJPMD
         mFwIjoOI0+l7mUDNNR8XERfTHgMapa0bAFETJJgXWES7j/C1nVm+MqG5em/QMtcrph+0
         Y5sAfwD0dQ7+MkX/CVuQVjn7WWpmABxDQfelct27zti7iNU0BnKqlggazFCTEgPCGecz
         IEwzMaqpomidTAP/KgmSp91YeQlDehT6x3BOW4hRZjsr1CVLXgFYQviie92P6CcJIylS
         QHOyo42ixvfnwVy1YvnfqJg47x6da535HNM5jhlJ5EbsYH3yB4A9OOPrXy4XkFSCon4r
         gPVQ==
X-Gm-Message-State: AFqh2krOHGfQd3SIB9hS0FTzeHJM2WHggRzm0JAPwmvCkbB9Jj/B2dzO
        2oYb1pU5B+NnB8/po3GHoNAxogbdtsI=
X-Google-Smtp-Source: AMrXdXt5y787mcmK+IqsuuEEYvE1qX/IZnnrtZ/4job+CRrHEqgJnCVnqoNVJTV87s9/hhVUtw9fUA==
X-Received: by 2002:a17:906:a1c5:b0:7c1:2529:b25e with SMTP id bx5-20020a170906a1c500b007c12529b25emr54753622ejb.43.1673284163522;
        Mon, 09 Jan 2023 09:09:23 -0800 (PST)
Received: from dlaptop.localdomain (dynamic-077-008-132-214.77.8.pool.telefonica.de. [77.8.132.214])
        by smtp.gmail.com with ESMTPSA id z20-20020a1709067e5400b00809e33ba33dsm3971471ejr.19.2023.01.09.09.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:09:23 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libselinux: add getpidprevcon
Date:   Mon,  9 Jan 2023 18:09:12 +0100
Message-Id: <20230109170912.57887-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the public interfaces getpidprevcon(3) and getpidprevcon_raw(3), and
the utility getpidprevcon to gather the previous context before the last
exec of a given process.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/selinux.h    |  5 ++++
 libselinux/man/man3/getcon.3            |  9 +++++++
 libselinux/man/man3/getpidprevcon.3     |  1 +
 libselinux/man/man3/getpidprevcon_raw.3 |  1 +
 libselinux/src/procattr.c               | 18 ++++++++++++++
 libselinux/utils/.gitignore             |  1 +
 libselinux/utils/getpidprevcon.c        | 33 +++++++++++++++++++++++++
 7 files changed, 68 insertions(+)
 create mode 100644 libselinux/man/man3/getpidprevcon.3
 create mode 100644 libselinux/man/man3/getpidprevcon_raw.3
 create mode 100644 libselinux/utils/getpidprevcon.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 47af9953..a0948853 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -54,6 +54,11 @@ extern int getpidcon_raw(pid_t pid, char ** con);
 extern int getprevcon(char ** con);
 extern int getprevcon_raw(char ** con);
 
+/* Get previous context (prior to last exec) of process identified by pid, and
+   set *con to refer to it.  Caller must free via freecon. */
+extern int getpidprevcon(pid_t pid, char ** con);
+extern int getpidprevcon_raw(pid_t pid, char ** con);
+
 /* Get exec context, and set *con to refer to it.
    Sets *con to NULL if no exec context has been set, i.e. using default.
    If non-NULL, caller must free via freecon. */
diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
index e7e394f3..38da958b 100644
--- a/libselinux/man/man3/getcon.3
+++ b/libselinux/man/man3/getcon.3
@@ -23,6 +23,10 @@ setcon \- set current security context of a process
 .sp
 .BI "int getpidcon_raw(pid_t " pid ", char **" context );
 .sp
+.BI "int getpidprevcon(pid_t " pid ", char **" context );
+.sp
+.BI "int getpidprevcon_raw(pid_t " pid ", char **" context );
+.sp
 .BI "int getpeercon(int " fd ", char **" context );
 .sp
 .BI "int getpeercon_raw(int " fd ", char **" context );
@@ -50,6 +54,11 @@ same as getcon but gets the context before the last exec.
 returns the process context for the specified PID, which must be free'd with
 .BR freecon ().
 
+.TP
+.BR getpidprevcon ()
+returns the process context before the last exec for the specified PID, which must be free'd with
+.BR freecon ().
+
 .TP
 .BR getpeercon ()
 retrieves the context of the peer socket, which must be free'd with
diff --git a/libselinux/man/man3/getpidprevcon.3 b/libselinux/man/man3/getpidprevcon.3
new file mode 100644
index 00000000..1210b5a0
--- /dev/null
+++ b/libselinux/man/man3/getpidprevcon.3
@@ -0,0 +1 @@
+.so man3/getcon.3
diff --git a/libselinux/man/man3/getpidprevcon_raw.3 b/libselinux/man/man3/getpidprevcon_raw.3
new file mode 100644
index 00000000..1210b5a0
--- /dev/null
+++ b/libselinux/man/man3/getpidprevcon_raw.3
@@ -0,0 +1 @@
+.so man3/getcon.3
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 6f4cfb82..b7a93a2b 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -300,3 +300,21 @@ int getpidcon(pid_t pid, char **c)
 	}
 	return getprocattrcon(c, pid, "current", NULL);
 }
+
+int getpidprevcon_raw(pid_t pid, char **c)
+{
+        if (pid <= 0) {
+                errno = EINVAL;
+                return -1;
+        }
+        return getprocattrcon_raw(c, pid, "prev", NULL);
+}
+
+int getpidprevcon(pid_t pid, char **c)
+{
+        if (pid <= 0) {
+                errno = EINVAL;
+                return -1;
+        }
+        return getprocattrcon(c, pid, "prev", NULL);
+}
diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index 3ef34374..b19b94a8 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -9,6 +9,7 @@ getdefaultcon
 getenforce
 getfilecon
 getpidcon
+getpidprevcon
 getsebool
 getseuser
 matchpathcon
diff --git a/libselinux/utils/getpidprevcon.c b/libselinux/utils/getpidprevcon.c
new file mode 100644
index 00000000..662ad500
--- /dev/null
+++ b/libselinux/utils/getpidprevcon.c
@@ -0,0 +1,33 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <selinux/selinux.h>
+
+int main(int argc, char **argv)
+{
+	pid_t pid;
+	char *buf;
+	int rc;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage:  %s pid\n", argv[0]);
+		exit(1);
+	}
+
+	if (sscanf(argv[1], "%d", &pid) != 1) {
+		fprintf(stderr, "%s:  invalid pid %s\n", argv[0], argv[1]);
+		exit(2);
+	}
+
+	rc = getpidprevcon(pid, &buf);
+	if (rc < 0) {
+		fprintf(stderr, "%s:  getpidprevcon() failed:  %s\n", argv[0], strerror(errno));
+		exit(3);
+	}
+
+	printf("%s\n", buf);
+	freecon(buf);
+	exit(EXIT_SUCCESS);
+}
-- 
2.39.0

