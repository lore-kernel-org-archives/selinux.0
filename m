Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64DDC433FE
	for <selinux@archiver.kernel.org>; Thu,  5 May 2022 17:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382892AbiEERsa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 May 2022 13:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383036AbiEERsY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 May 2022 13:48:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7995DBFE
        for <selinux@vger.kernel.org>; Thu,  5 May 2022 10:44:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k27so6057911edk.4
        for <selinux@vger.kernel.org>; Thu, 05 May 2022 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPBieDaIeSqSyXTnXmssaaoiP34ed6CgKN0A2Uoz0B8=;
        b=XycFOQilXjBXC1tEoPpHUGZb1b77rClEUZ60r0k9XdKncHBTLZKrxhDHhBLWEy3S5s
         vBazeHVhTzKAX6J6JflgsxfkMfQT+EPki6MQFikdoUtbhPdM0cdpPzEpexGQWEVBRk6h
         UCb8ddXzx7/+neoSDhN87nCGilq3LSq6GiN0XnRwfFghvrGlpeh37DCJVm+XfMJc9y7D
         xSSUHSLzC4j8h4mFUXcWgzwAf+sUtAQGtYf6/a7E5D4KPxCP1xZtT+esn2tRyzQYheS0
         qgad+zefSMlmcHsPzyHBR+QmOU3DYpmt1RTRpbuEhvxKsVMLL+8cMPDQg+4KBBY3qyaX
         cfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPBieDaIeSqSyXTnXmssaaoiP34ed6CgKN0A2Uoz0B8=;
        b=mIFwHPw0jifsJlLKhgOBRzi/ww2pDfJXVerS9lhpnknas3jn3euW216Gv5keb5dB3+
         13neTlNvRaRo2bVuaQcYMrUD2sEKXm0rvbjyJxG6/UTEv6kgQjPQ3t3/Js+rn5UvqNoO
         wx0ABf+mS8rq5hbyfD5K0jMhDdC/Ywxvi7S4DD2MitS+BekfSvEdW0QJCaDSLeFW+0wv
         wFYW1DbiAH8LoNEAoA8O22KgQvgi2TdVmRhsMs4NmTFItYqDREgxXTomp5l1YfbMPzPO
         mqBqU6vYHIhOSCi9W9RFvH4xxUILWreFwBXpmOZIiRdOccNsqbxqUljI2j8mKGGTtNyz
         jn6A==
X-Gm-Message-State: AOAM532AKkyh9Zb3OhfwLTxJO5oYGVbrT9GQwtXZBF+jsPmJjMJT5dS4
        PdtAziKXxfdV74bgYWPUN5mXKUGV0dw=
X-Google-Smtp-Source: ABdhPJxL+P6dYVlQKoSprYFkwGYzWQ5qj5ZQETswFmEovo1nTxVsghqEHrVb6zpJGjMpIUGKhtOHTA==
X-Received: by 2002:a05:6402:1850:b0:425:f2e2:2594 with SMTP id v16-20020a056402185000b00425f2e22594mr31483024edy.3.1651772664189;
        Thu, 05 May 2022 10:44:24 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-152-226.77.1.pool.telefonica.de. [77.1.152.226])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906014d00b006f4c4330c49sm1027908ejh.57.2022.05.05.10.44.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 10:44:23 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH] libselinux: emulate O_PATH support in fgetfilecon/fsetfilecon
Date:   Thu,  5 May 2022 19:44:20 +0200
Message-Id: <20220505174420.24537-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Operating on a file descriptor avoids TOCTOU issues and one opened via
O_PATH avoids the requirement of having read access to the file.  Since
Linux does not natively support file descriptors opened via O_PATH in
fgetxattr(2) and at least glibc and musl does not emulate O_PATH support
in their implementations, fgetfilecon(3) and fsetfilecon(3) also do not
currently support file descriptors opened with O_PATH.

Inspired by CVE-2013-4392: https://github.com/systemd/systemd/pull/8583
Implementation adapted from: https://android.googlesource.com/platform/bionic/+/2825f10b7f61558c264231a536cf3affc0d84204%5E%21/

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/getfilecon.3 |  4 +++-
 libselinux/man/man3/setfilecon.3 |  4 +++-
 libselinux/src/fgetfilecon.c     | 28 +++++++++++++++++++++++++---
 libselinux/src/fsetfilecon.c     | 23 ++++++++++++++++++++++-
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/libselinux/man/man3/getfilecon.3 b/libselinux/man/man3/getfilecon.3
index 5bb575b5..c3e92ba1 100644
--- a/libselinux/man/man3/getfilecon.3
+++ b/libselinux/man/man3/getfilecon.3
@@ -33,7 +33,9 @@ is identical to
 .BR getfilecon (),
 only the open file pointed to by filedes (as returned by
 .BR open (2))
-is interrogated in place of path.
+is interrogated in place of path.  Since libselinux 3.4 a file opened via
+.I O_PATH
+is supported.
 
 .BR getfilecon_raw (),
 .BR lgetfilecon_raw ()
diff --git a/libselinux/man/man3/setfilecon.3 b/libselinux/man/man3/setfilecon.3
index 0e9a383f..61f9a806 100644
--- a/libselinux/man/man3/setfilecon.3
+++ b/libselinux/man/man3/setfilecon.3
@@ -29,7 +29,9 @@ link itself has it's context set, not the file that it refers to.
 is identical to setfilecon, only the open file pointed to by filedes (as
 returned by
 .BR open (2))
-has it's context set in place of path.
+has it's context set in place of path.  Since libselinux 3.4 a file opened via
+.I O_PATH
+is supported.
 
 .BR setfilecon_raw (),
 .BR lsetfilecon_raw (),
diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.c
index 8c748f8a..baf38ec1 100644
--- a/libselinux/src/fgetfilecon.c
+++ b/libselinux/src/fgetfilecon.c
@@ -3,10 +3,32 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <stdio.h>
 #include <sys/xattr.h>
 #include "selinux_internal.h"
 #include "policy.h"
 
+static ssize_t fgetxattr_wrapper(int fd, const char *name, void *value, size_t size) {
+	char buf[40];
+	int fd_flag, saved_errno = errno;
+	ssize_t ret;
+
+	ret = fgetxattr(fd, name, value, size);
+	if (ret != -1 || errno != EBADF)
+		return ret;
+
+	/* Emulate O_PATH support */
+	fd_flag = fcntl(fd, F_GETFL);
+	if (fd_flag == -1 || (fd_flag & O_PATH) == 0) {
+		errno = EBADF;
+		return -1;
+	}
+
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
+	errno = saved_errno;
+	return getxattr(buf, name, value, size);
+}
+
 int fgetfilecon_raw(int fd, char ** context)
 {
 	char *buf;
@@ -19,11 +41,11 @@ int fgetfilecon_raw(int fd, char ** context)
 		return -1;
 	memset(buf, 0, size);
 
-	ret = fgetxattr(fd, XATTR_NAME_SELINUX, buf, size - 1);
+	ret = fgetxattr_wrapper(fd, XATTR_NAME_SELINUX, buf, size - 1);
 	if (ret < 0 && errno == ERANGE) {
 		char *newbuf;
 
-		size = fgetxattr(fd, XATTR_NAME_SELINUX, NULL, 0);
+		size = fgetxattr_wrapper(fd, XATTR_NAME_SELINUX, NULL, 0);
 		if (size < 0)
 			goto out;
 
@@ -34,7 +56,7 @@ int fgetfilecon_raw(int fd, char ** context)
 
 		buf = newbuf;
 		memset(buf, 0, size);
-		ret = fgetxattr(fd, XATTR_NAME_SELINUX, buf, size - 1);
+		ret = fgetxattr_wrapper(fd, XATTR_NAME_SELINUX, buf, size - 1);
 	}
       out:
 	if (ret == 0) {
diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon.c
index 5cf34e3f..be821c7a 100644
--- a/libselinux/src/fsetfilecon.c
+++ b/libselinux/src/fsetfilecon.c
@@ -3,13 +3,34 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <stdio.h>
 #include <sys/xattr.h>
 #include "selinux_internal.h"
 #include "policy.h"
 
+static int fsetxattr_wrapper(int fd, const char* name, const void* value, size_t size, int flags) {
+	char buf[40];
+	int rc, fd_flag, saved_errno = errno;
+
+	rc = fsetxattr(fd, name, value, size, flags);
+	if (rc == 0 || errno != EBADF)
+		return rc;
+
+	/* Emulate O_PATH support */
+	fd_flag = fcntl(fd, F_GETFL);
+	if (fd_flag == -1 || (fd_flag & O_PATH) == 0) {
+		errno = EBADF;
+		return -1;
+	}
+
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
+	errno = saved_errno;
+	return setxattr(buf, name, value, size, flags);
+}
+
 int fsetfilecon_raw(int fd, const char * context)
 {
-	int rc = fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(context) + 1,
+	int rc = fsetxattr_wrapper(fd, XATTR_NAME_SELINUX, context, strlen(context) + 1,
 			 0);
 	if (rc < 0 && errno == ENOTSUP) {
 		char * ccontext = NULL;
-- 
2.36.0

