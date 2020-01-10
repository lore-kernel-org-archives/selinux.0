Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6555DC282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B1C20721
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Hwy5r0X8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgAJOPT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:15:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34388 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgAJOPT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 09:15:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so1982801wrr.1
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 06:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jhL8cEzgjjKUmBvb+Of1Op8rH6xFhgDNA/Cb43u+API=;
        b=Hwy5r0X8bCLaRAr/FzEmSlq8Z1Dd7gRZs4LXK4jdmO35vMGvhqMKG2caGnR/6sDnTT
         HdeHC+EjmN3UItDZk66UvWeeFGCiOWPRiuKjw6vgj1B2G/5ww/OVjXuopwgwbhvR/nFd
         jYCRKdz7YJAELuQzCMgDBq/1IxryZbrnKSE14L0Xf+lvD8xZ46jHceRIKiusPSeZLZ32
         4sHprYzaa2Gw7/ABI+h30CvzcKYuIOU0ti3rZd01XdXA9UjJ6XPIJgIqel9ZmjLRxGVd
         HUeTncUpySOBc/23fFxRKPFzHU4VRZ+OpbE2RcLZ5wBXHREk9SJjSk7lNbcw6jfYgD8O
         FJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhL8cEzgjjKUmBvb+Of1Op8rH6xFhgDNA/Cb43u+API=;
        b=MRA7/hPsiR035CFl7TPt/MTXNjYmHmglZHnpesD5J8MwpAOGI8jwrxln/6KNK4eFrC
         iBUH7e7exPpvVQbM7NZ8JR6/x3oCDkrjh/a7KUV1nQLvQU3BqGclIjsxSNyGdsTDn+R9
         rGNhVTiI4j3AY3m5v3Zo+3VCrTSgwSFeIalTTedESPm52BHS8ETAW7UwLPn/eX9dyn9h
         dokr3KgDWhN5pVBk6SItntCPhdMYvgM9IjjmZ5G00jkKRYTgAuyEg/GJim70sUYj8mDb
         T6g4t3LnFqy4VYL9LyBJSP9E2ZHeFnWhd5YXqqBkSt7Lv9+3NHxN8wLuSIvu9h7BUlt9
         0kfw==
X-Gm-Message-State: APjAAAWgxKXVOB1SD6m9OoQLIifz1OkKjIxvb1JG4Myn+mdqRr7KIox9
        3XgZFF1raRnNCAK8ZHo408bTryoP
X-Google-Smtp-Source: APXvYqwdwflEJVbSBA/ssuPf0SpyM5XpIOLi/9+JFF2JWxklnvnKZNCHCv4Bl3pMo+d/7QeqwyPVtA==
X-Received: by 2002:adf:e78b:: with SMTP id n11mr3880607wrm.10.1578665717252;
        Fri, 10 Jan 2020 06:15:17 -0800 (PST)
Received: from desktopdebian.localdomain (x4d03413a.dyn.telefonica.de. [77.3.65.58])
        by smtp.gmail.com with ESMTPSA id q15sm2369509wrr.11.2020.01.10.06.15.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 06:15:16 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 2/3] libselinux: add security_is_policy_capabilty_enabled()
Date:   Fri, 10 Jan 2020 15:15:08 +0100
Message-Id: <20200110141509.21098-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.25.0.rc2
In-Reply-To: <20200110141509.21098-1-cgzones@googlemail.com>
References: <20200110141509.21098-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Allow userspace (e.g. object managers like systemd) to obtain the state of a policy capability via a library call.
---
 libselinux/include/selinux/selinux.h          |  3 +
 .../security_is_policy_capability_enabled.3   | 27 ++++++++
 libselinux/src/polcap.c                       | 64 +++++++++++++++++++
 libselinux/src/selinux_internal.h             |  1 +
 libselinux/src/selinuxswig_python_exception.i |  9 +++
 5 files changed, 104 insertions(+)
 create mode 100644 libselinux/man/man3/security_is_policy_capability_enabled.3
 create mode 100644 libselinux/src/polcap.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index fe46e681..b46f152d 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -354,6 +354,9 @@ extern int security_disable(void);
 /* Get the policy version number. */
 extern int security_policyvers(void);
 
+/* Get the state of a policy capability. */
+extern int security_is_policy_capability_enabled(const char *name);
+
 /* Get the boolean names */
 extern int security_get_boolean_names(char ***names, int *len);
 
diff --git a/libselinux/man/man3/security_is_policy_capability_enabled.3 b/libselinux/man/man3/security_is_policy_capability_enabled.3
new file mode 100644
index 00000000..18c53b67
--- /dev/null
+++ b/libselinux/man/man3/security_is_policy_capability_enabled.3
@@ -0,0 +1,27 @@
+.TH "security_is_policy_capability_enabled" "3" "9 January 2020" "cgzones@googlemail.com" "SELinux API documentation"
+.SH "NAME"
+security_is_policy_capability_enabled \- get the state of a SELinux policy
+capability
+.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int security_is_policy_capability_enabled(const char *" name ");"
+.
+.SH "DESCRIPTION"
+.BR security_is_policy_capability_enabled ()
+returns 1 if the SELinux policy capability with the given name is enabled,
+0 if it is disabled, and \-1 on error.
+.SH "NOTES"
+The parameter
+.IR name
+is case insensitive.
+
+If the the current kernel does not support the given policy capability \-1 is returned and
+.BR errno
+is set to
+.BR ENOTSUP
+\&.
+.
+.SH "SEE ALSO"
+.BR selinux "(8)"
diff --git a/libselinux/src/polcap.c b/libselinux/src/polcap.c
new file mode 100644
index 00000000..801231cf
--- /dev/null
+++ b/libselinux/src/polcap.c
@@ -0,0 +1,64 @@
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "policy.h"
+#include "selinux_internal.h"
+
+int security_is_policy_capability_enabled(const char *name)
+{
+	int fd, enabled;
+	ssize_t ret;
+	char path[PATH_MAX];
+	char buf[20];
+	DIR *polcapdir;
+	struct dirent *dentry;
+
+	if (!selinux_mnt) {
+		errno = ENOENT;
+		return -1;
+	}
+
+	snprintf(path, sizeof path, "%s/policy_capabilities", selinux_mnt);
+	polcapdir = opendir(path);
+	if (!polcapdir)
+		return -1;
+
+	while ((dentry = readdir(polcapdir)) != NULL) {
+		if (strcmp(dentry->d_name, ".") == 0 || strcmp(dentry->d_name, "..") == 0)
+			continue;
+
+		if (strcasecmp(name, dentry->d_name) != 0)
+			continue;
+
+		snprintf(path, sizeof path, "%s/policy_capabilities/%s", selinux_mnt, dentry->d_name);
+		fd = open(path, O_RDONLY | O_CLOEXEC);
+		if (fd < 0)
+		    goto err;
+
+		memset(buf, 0, sizeof buf);
+		ret = read(fd, buf, sizeof buf - 1);
+		close(fd);
+		if (ret < 0)
+			goto err;
+
+		if (sscanf(buf, "%d", &enabled) != 1)
+			goto err;
+
+		closedir(polcapdir);
+		return !!enabled;
+	}
+
+	if (errno == 0)
+		errno = ENOTSUP;
+err:
+	closedir(polcapdir);
+	return -1;
+}
+
+hidden_def(security_is_policy_capability_enabled)
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 8b4bed2f..7ca1c329 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -9,6 +9,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(security_disable)
     hidden_proto(security_policyvers)
     hidden_proto(security_load_policy)
+    hidden_proto(security_is_policy_capability_enabled)
     hidden_proto(security_get_boolean_active)
     hidden_proto(security_get_boolean_names)
     hidden_proto(security_set_boolean)
diff --git a/libselinux/src/selinuxswig_python_exception.i b/libselinux/src/selinuxswig_python_exception.i
index cf658259..bd107295 100644
--- a/libselinux/src/selinuxswig_python_exception.i
+++ b/libselinux/src/selinuxswig_python_exception.i
@@ -665,6 +665,15 @@
 }
 
 
+%exception security_is_policy_capability_enabled {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
 %exception security_get_boolean_names {
   $action
   if (result < 0) {
-- 
2.25.0.rc2

