Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8F6C636D3
	for <selinux@archiver.kernel.org>; Wed,  1 Feb 2023 13:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjBANP1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Feb 2023 08:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBANP0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Feb 2023 08:15:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E476A6F
        for <selinux@vger.kernel.org>; Wed,  1 Feb 2023 05:15:24 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z11so17658779ede.1
        for <selinux@vger.kernel.org>; Wed, 01 Feb 2023 05:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Olq0ySMp+yu7kNR0R7YXKakCfPJSnXgyl7zoWpK1APM=;
        b=akozT2tyFuPc2m0MzVIJzEpAzMNUe4lQ18mKoMp0qALqdXEq+6uolHsDOygUmdjU7+
         yeduOphO0LjcTd9JrtW0GjGVTDRz11/QXlUrLsIW9VPTHGOXIPnNvnbvs/WDFXjGMuiL
         XEl7V7rDk9AbYdlTdiTm4J5zm+NVFvc/HjC9T9qd9UmP9DYjAlXcVSU2tCCX2rvNuC3n
         HnHAmV+v8QLzdaeKeH6JkMDONmD1OAe23Ro9CqcnW+RdaV+rf76oUbzdBvi8x8fYK2Yx
         brOmPCkhczM8xbVhHdLEXy1weIuYdzj/jnzd1uqvvx0SYT+3ftbiL3YP7exdqWbCQd2A
         ygVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Olq0ySMp+yu7kNR0R7YXKakCfPJSnXgyl7zoWpK1APM=;
        b=B8MJMAVJkaqc4/e2mHwiLhkn8uYu3Bzxi5kjYnN9o99MZz89HtB/MRr3LdPiC1sGtm
         JtEHHQqqGLoHvUxWg+q2SZNfyLKEX91RNYSHV5DgHpP1qwd0XsFdXJWdRZN7zsv5NYZ3
         cFBT/7EF7MsXCJkfGYUo2B9Ow1d9NhFI3UgQKSwzMosX3nLI0v2NpS5tMHguHRN7TzGU
         pJvnrVTprcfmDrND5I2Oy0NdLEHrtvqluQSuT+T9RgtTBRRqfBBOws+XkEPXGCmEQyAD
         A6j0U5ZUFoMbk1/fIASkdsOM5iAi/92Ztk52pQlJAdfcDgtZ845y0G9ASOhWBrcC6KKV
         8PaQ==
X-Gm-Message-State: AO0yUKUOMwxQxRz/uGt/I5ixSjCR64TiBDzh9xALAnrnJvcV4QfK+wTV
        4zskG8u+8lAPYPg/TUAb7fg8OP2cqW5Ytg==
X-Google-Smtp-Source: AK7set+Pp0T+nPt6Nr0T01BARhDeSo5I0UC0vTvvCEenC2i0MXGZteB05bdCdLVTaj4BH189glQHyg==
X-Received: by 2002:a05:6402:e9b:b0:46c:a763:5889 with SMTP id h27-20020a0564020e9b00b0046ca7635889mr1945999eda.25.1675257323191;
        Wed, 01 Feb 2023 05:15:23 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-178-099.77.8.pool.telefonica.de. [77.8.178.99])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7c40f000000b0049f88f00f70sm8431978edq.7.2023.02.01.05.15.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 05:15:22 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/2] libselinux: add getpidprevcon
Date:   Wed,  1 Feb 2023 14:15:15 +0100
Message-Id: <20230201131516.19967-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230109170912.57887-1-cgzones@googlemail.com>
References: <20230109170912.57887-1-cgzones@googlemail.com>
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
v2:
   added new interfaces to libselinux.map
---
 libselinux/include/selinux/selinux.h    |  5 ++++
 libselinux/man/man3/getcon.3            | 10 ++++++++
 libselinux/man/man3/getpidprevcon.3     |  1 +
 libselinux/man/man3/getpidprevcon_raw.3 |  1 +
 libselinux/src/libselinux.map           |  6 +++++
 libselinux/src/procattr.c               | 18 ++++++++++++++
 libselinux/utils/.gitignore             |  1 +
 libselinux/utils/getpidprevcon.c        | 33 +++++++++++++++++++++++++
 8 files changed, 75 insertions(+)
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
index e7e394f3..1b4fe4b7 100644
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
@@ -125,6 +134,7 @@ will fail if it is not allowed by policy.
 .BR getcon_raw (),
 .BR getprevcon_raw (),
 .BR getpidcon_raw (),
+.BR getpidprevcon_raw (),
 .BR getpeercon_raw ()
 and
 .BR setcon_raw ()
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
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index 6e04eb61..5e00f45b 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -246,3 +246,9 @@ LIBSELINUX_3.4 {
     selinux_restorecon_get_skipped_errors;
     selinux_restorecon_parallel;
 } LIBSELINUX_1.0;
+
+LIBSELINUX_3.5 {
+  global:
+    getpidprevcon;
+    getpidprevcon_raw;
+} LIBSELINUX_3.4;
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
2.39.1

