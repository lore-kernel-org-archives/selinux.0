Return-Path: <SRS0=5WGn=SH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5A7C282CE
	for <selinux@archiver.kernel.org>; Fri,  5 Apr 2019 19:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB8A2171F
	for <selinux@archiver.kernel.org>; Fri,  5 Apr 2019 19:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="fmbaOXDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfDETBI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:01:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34808 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfDETBI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Apr 2019 15:01:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id n68so4493545qka.1
        for <selinux@vger.kernel.org>; Fri, 05 Apr 2019 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9uIwShLJ349LsFNWbdFIkwD2RF9c3A+Ilib8O1RyPd4=;
        b=fmbaOXDEUkXpGI9wFnHYVWxKt9nxAuL6oWHA1F/+SXK+zbYskzUBvbZq/5ejubbqMg
         XzitF56cvSQLTHqAe7qw04+mojqR+ejqeIm9gv1VOWHaikae+pnTSEy+rGxYZyrVaO/c
         2QxbrzmlBnPWcW45bfaLUjL5o6qVI+F5eM7sQLqt158QQPruApBwf/7Ut/jKpM09zNHM
         nIUgxFicN5MnW3FkZr0t+UhH0/Qhq536KtE7BH3vd2GSSfgaQkNhAa6GLXKatMcxt5Eo
         yEuZYXjvH11Ot1GKdCfAG2n8y731z9/2g+QJRkTSTEznHRuDwgP6c+Soorkvho0SyYKZ
         4B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9uIwShLJ349LsFNWbdFIkwD2RF9c3A+Ilib8O1RyPd4=;
        b=TiZr3Q13m/QKnAscL+85Q7Jv70EQ+GjTjrH/OArBnM9QsJIT8DOHnIR/ZrPhi7/oYj
         PnzTmr80wvm66lVZ31xX8KE93hTj+pBJ1zITWBFnJ/NuTGreUP05wzo2NSucopBN0+gL
         UxUu7OeZ82OLGTwygSF8+l7ogEzNMv4Woa6uRwye9ynzEoooVhPa6icCiWNajDDHlEOW
         wmVNLmye08+1eQjJ/GVdrWZHgPndG9bDm1sNbKMLq0y1O9O8O3xJF6PTkONq6UKGckLW
         Q4m+tZHTM+nSnObCREcrCkkexkbsVNTG9ILIG7x4BRZHPNYc3rxZToZVVlD+/hYkMbqg
         imRQ==
X-Gm-Message-State: APjAAAWASMpmZZTg+BpcAGghcB9kk+vMVpxtK4Q/PSvUh0Zts5PhxPOV
        lCqSvciHae8Z8X9ANVVtmIJqanTS1Vs=
X-Google-Smtp-Source: APXvYqxPr8in5+Pt6HvECbSEHQ3YoBME5Wh3JyFVkIoOcdowu4nUNIv5+8ShGGw+KUYo9g6aNbSPdA==
X-Received: by 2002:a37:a246:: with SMTP id l67mr11491105qke.237.1554490866877;
        Fri, 05 Apr 2019 12:01:06 -0700 (PDT)
Received: from localhost.localdomain (pool-71-121-242-40.bltmmd.fios.verizon.net. [71.121.242.40])
        by smtp.gmail.com with ESMTPSA id i24sm12060643qtm.3.2019.04.05.12.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 12:01:06 -0700 (PDT)
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>
Subject: [PATCH v5] Add security_validatetrans support
Date:   Fri,  5 Apr 2019 12:01:02 -0700
Message-Id: <20190405190102.13987-1-joshua.brindle@crunchydata.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <CAGB+Vh5ad2SBUcpY5bNzWRSfV5jjXiojy0aaYJXyzY9EqnVZdQ@mail.gmail.com>
References: <CAGB+Vh5ad2SBUcpY5bNzWRSfV5jjXiojy0aaYJXyzY9EqnVZdQ@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It seems validatetrans support was never added to libselinux, despite being added to
selinuxfs in kernel version 4.5

There is a utility to test, however the targeted policy has no validatetrans rules so some must be added:

$ cat validatetrans.cil
(mlsvalidatetrans db_table (and (or (or (or (eq l1 l2) (and (eq t3 unconfined_t) (domby l1 l2))) (and (eq t3 unconfined_t) (dom l1 l2))) (and (eq t3 unconfined_t) (incomp l1 l2))) (or (or (or (eq l1 h2) (and (eq t3 unconfined_t) (domby h1 h2))) (and (eq t3 unconfined_t) (dom h1 h2))) (and (eq t3 unconfined_t) (incomp h1 h2)))))

$ sudo semodule -i validatetrans.cil

$ ./validatetrans system_u:system_r:kernel_t:s0 system_u:system_r:init_t:s0:c0 db_table system_u:system_r: # invalid context here
opening /sys/fs/selinux/validatetrans
security_validatetrans returned -1 errno: Invalid argument

$ ./validatetrans system_u:system_r:kernel_t:s0 system_u:system_r:init_t:s0:c0 db_table system_u:system_r:init_t:s0
opening /sys/fs/selinux/validatetrans
security_validatetrans returned -1 errno: Operation not permitted

$ ./validatetrans system_u:system_r:kernel_t:s0 system_u:system_r:init_t:s0:c0 db_table system_u:system_r:unconfined_t:s0
opening /sys/fs/selinux/validatetrans
security_validatetrans returned 0 errno: Success

Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
---
 libselinux/include/selinux/selinux.h          | 13 +++
 libselinux/man/man3/security_compute_av.3     | 13 ++-
 libselinux/man/man3/security_validatetrans.c  |  1 +
 .../man/man3/security_validatetrans_raw.c     |  1 +
 libselinux/src/selinux_internal.h             |  2 +
 libselinux/src/validatetrans.c                | 94 +++++++++++++++++++
 libselinux/utils/.gitignore                   |  1 +
 libselinux/utils/validatetrans.c              | 30 ++++++
 8 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/man/man3/security_validatetrans.c
 create mode 100644 libselinux/man/man3/security_validatetrans_raw.c
 create mode 100644 libselinux/src/validatetrans.c
 create mode 100644 libselinux/utils/validatetrans.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index a34d54fc..f54f236b 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -255,6 +255,19 @@ extern int security_compute_user_raw(const char * scon,
 				     const char *username,
 				     char *** con);
 
+/* Validate a transition. This determines whether a transition from scon to newcon
+   using tcon as the target for object class tclass is valid in the loaded policy.
+   This checks against the mlsvalidatetrans and validatetrans constraints in the loaded policy.
+   Returns 0 if allowed and -1 if an error occured with errno set */
+extern int security_validatetrans(const char *scon,
+				  const char *tcon,
+				  security_class_t tclass,
+				  const char *newcon);
+extern int security_validatetrans_raw(const char *scon,
+				      const char *tcon,
+				      security_class_t tclass,
+				      const char *newcon);
+
 /* Load a policy configuration. */
 extern int security_load_policy(void *data, size_t len);
 
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index 2aade5fe..a7181bed 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -1,7 +1,7 @@
 .TH "security_compute_av" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
 .SH "NAME"
 security_compute_av, security_compute_av_flags, security_compute_create, security_compute_create_name, security_compute_relabel,
-security_compute_member, security_compute_user, security_get_initial_context \- query
+security_compute_member, security_compute_user, security_validatetrans, security_get_initial_context \- query
 the SELinux policy database in the kernel
 .
 .SH "SYNOPSIS"
@@ -35,6 +35,10 @@ the SELinux policy database in the kernel
 .sp
 .BI "int security_compute_user_raw(char *" scon ", const char *" username ", char ***" con );
 .sp
+.BI "int security_validatetrans(char *" scon ", const char *" tcon ", security_class_t "tclass ", char *" newcon );
+.sp
+.BI "int security_validatetrans_raw(char *" scon ", const char *" tcon ", security_class_t "tclass ", char *" newcon );
+.sp
 .BI "int security_get_initial_context(const char *" name ", char **" con );
 .sp
 .BI "int security_get_initial_context_raw(const char *" name ", char **" con );
@@ -100,6 +104,12 @@ is used to determine the set of user contexts that can be reached from a
 source context. It is mainly used by
 .BR get_ordered_context_list ().
 
+.BR security_validatetrans ()
+is used to determine if a transition from scon to newcon using tcon as the object
+is valid for object class tclass. This checks against the mlsvalidatetrans and
+validatetrans constraints in the loaded policy. Returns 0 if allowed, and -1
+if an error occured with errno set.
+
 .BR security_get_initial_context ()
 is used to get the context of a kernel initial security identifier specified by 
 .I name
@@ -111,6 +121,7 @@ is used to get the context of a kernel initial security identifier specified by
 .BR \%security_compute_relabel_raw (),
 .BR \%security_compute_member_raw (),
 .BR \%security_compute_user_raw ()
+.BR \%security_validatetrans_raw ()
 and
 .BR \%security_get_initial_context_raw ()
 behave identically to their non-raw counterparts but do not perform context
diff --git a/libselinux/man/man3/security_validatetrans.c b/libselinux/man/man3/security_validatetrans.c
new file mode 100644
index 00000000..a60bca4d
--- /dev/null
+++ b/libselinux/man/man3/security_validatetrans.c
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
diff --git a/libselinux/man/man3/security_validatetrans_raw.c b/libselinux/man/man3/security_validatetrans_raw.c
new file mode 100644
index 00000000..a60bca4d
--- /dev/null
+++ b/libselinux/man/man3/security_validatetrans_raw.c
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 70b5025d..acd59c7c 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -29,6 +29,8 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(security_compute_create_name_raw)
     hidden_proto(security_compute_member_raw)
     hidden_proto(security_compute_relabel_raw)
+    hidden_proto(security_validatetrans)
+    hidden_proto(security_validatetrans_raw)
     hidden_proto(is_selinux_enabled)
     hidden_proto(is_selinux_mls_enabled)
     hidden_proto(freecon)
diff --git a/libselinux/src/validatetrans.c b/libselinux/src/validatetrans.c
new file mode 100644
index 00000000..2aa300cf
--- /dev/null
+++ b/libselinux/src/validatetrans.c
@@ -0,0 +1,94 @@
+#include <unistd.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <limits.h>
+#include "selinux_internal.h"
+#include "policy.h"
+#include "mapping.h"
+
+int security_validatetrans_raw(const char *scon,
+			       const char *tcon,
+			       security_class_t tclass,
+			       const char *newcon)
+{
+	char path[PATH_MAX];
+	char *buf = NULL;
+	int size, bufsz;
+	int fd, ret = -1;
+	errno = ENOENT;
+
+	if (!selinux_mnt) {
+		return -1;
+	}
+
+	snprintf(path, sizeof path, "%s/validatetrans", selinux_mnt);
+	fd = open(path, O_WRONLY | O_CLOEXEC);
+	if (fd < 0) {
+		return -1;
+	}
+
+	errno = EINVAL;
+	size = selinux_page_size;
+	buf = malloc(size);
+	if (!buf) {
+		goto out;
+	}
+
+	bufsz = snprintf(buf, size, "%s %s %hu %s", scon, tcon, unmap_class(tclass), newcon);
+	if (bufsz >= size || bufsz < 0) {
+		// It got truncated or there was an encoding error
+		goto out;
+	}
+
+	// clear errno for write()
+	errno = 0;
+	ret = write(fd, buf, strlen(buf));
+	if (ret > 0) {
+		// The kernel returns the bytes written on success, not 0 as noted in the commit message
+		ret = 0;
+	}
+out:
+	free(buf);
+	close(fd);
+	return ret;
+}
+
+hidden_def(security_validatetrans_raw)
+
+int security_validatetrans(const char *scon,
+			   const char *tcon,
+			   security_class_t tclass,
+			   const char *newcon)
+{
+	int ret = -1;
+	char *rscon = NULL;
+	char *rtcon = NULL;
+	char *rnewcon = NULL;
+
+	if (selinux_trans_to_raw_context(scon, &rscon)) {
+		goto out;
+	}
+
+	if (selinux_trans_to_raw_context(tcon, &rtcon)) {
+		goto out;
+	}
+
+	if (selinux_trans_to_raw_context(newcon, &rnewcon)) {
+		goto out;
+	}
+
+	ret = security_validatetrans_raw(rscon, rtcon, tclass, rnewcon);
+
+out:
+	freecon(rnewcon);
+	freecon(rtcon);
+	freecon(rscon);
+
+	return ret;
+}
+
+hidden_def(security_validatetrans)
diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index 5cd01025..aba18a3c 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -25,3 +25,4 @@ setenforce
 setfilecon
 togglesebool
 selinux_check_access
+validatetrans
diff --git a/libselinux/utils/validatetrans.c b/libselinux/utils/validatetrans.c
new file mode 100644
index 00000000..1db33e66
--- /dev/null
+++ b/libselinux/utils/validatetrans.c
@@ -0,0 +1,30 @@
+#include <unistd.h>
+#include <sys/types.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <selinux/selinux.h>
+
+int main(int argc, char **argv)
+{
+	security_class_t tclass;
+	int ret;
+
+	if (argc != 5) {
+		fprintf(stderr, "usage:  %s scontext tcontext tclass newcontext\n",
+			argv[0]);
+		exit(1);
+	}
+
+	tclass = string_to_security_class(argv[3]);
+	if (!tclass) {
+		fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], argv[3]);
+		exit(2);
+	}
+
+	ret = security_validatetrans(argv[1], argv[2], tclass, argv[4]);
+	printf("security_validatetrans returned %d errno: %s\n", ret, strerror(errno));
+
+	return ret;
+}
-- 
2.17.2

