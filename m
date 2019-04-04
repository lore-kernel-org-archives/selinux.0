Return-Path: <SRS0=gAxo=SG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DC5C4360F
	for <selinux@archiver.kernel.org>; Thu,  4 Apr 2019 15:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2A22082E
	for <selinux@archiver.kernel.org>; Thu,  4 Apr 2019 15:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="D7dO9Tb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfDDPhA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:37:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35970 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDPhA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Apr 2019 11:37:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id k130so1915572qke.3
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2019 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1Vy/JunH3u981fMJFbKh6JUIOSwd599n1FJTCjZ0Wpk=;
        b=D7dO9Tb1gSNiCfS+R/ysF/GFl0EJC6sau4SepPPe+QSrlRAqA/LAk9mzhdncqA1qpi
         srWOtrLODasyuXLXbeHp64wGicuMoJH8mNvqLzkqtL4FSoIaS0+Y1cuHtv9/FvS8+Edx
         ytCtQdnAOzs5thP215evGOvK57cYje4fh5pftlq5hMajyR1YcEpvByhKqfIZg5lfTt4U
         8SBakOMSVnJDvjLdj6/InekGx1vz8+wjaGcvYivIXs7ziDt4dbzdB+4PUTztuT7B0uTw
         XiOzIEK2YJluEkB2TMpHO/et7t4h+B+5y4LIJfqnpzM9pZWgowu5EaPHGomgf4vSsJbv
         wKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Vy/JunH3u981fMJFbKh6JUIOSwd599n1FJTCjZ0Wpk=;
        b=r66/jLD5GmHEsDs30NLryHamhyWbJKeTcDsm2I6VS47xeBISfLhvoANHcv6MagxpkC
         y1okoj3ByK6p9ReUQSNQYeKc7WmHnWFzhNdm1DDAa2fxMzWdDDcb6XLBBj59/bjS0kxD
         Y0Eg6xtYjRkyaXadalA/vc543aaJiT9FKKFwzPXTSYfAsIfJsx2B8DMqtp60VI/jFqXH
         8gEuWN0N6fC6M6AEMKTP9jJ9BKGZTOx9P0FgvjCK7LSYCjqty7QSC9EgIkZVpOXFeqcV
         HcIwT/g/e868bf3Pgi9HNLjUTfVkM7ukJADzh7AWUX/NisEDkrleVnYWdg8Q9dqL5vki
         DoBQ==
X-Gm-Message-State: APjAAAW1K7kvhKpV/TuyS/bvcm+8vRJrd8GYThsUbGk2LqqjNBBml2hj
        29rqE4JcTRU1QaivQcungc0rymZ71U4=
X-Google-Smtp-Source: APXvYqw6po8vNZbvFCoQAmbC7VHYXn+geb1H9EYrJqfoMpTgL1RZCQOBlIg8Fh4GUMS8/OvggtCN9w==
X-Received: by 2002:a37:c203:: with SMTP id i3mr5474361qkm.295.1554392218518;
        Thu, 04 Apr 2019 08:36:58 -0700 (PDT)
Received: from localhost.localdomain (pool-71-121-242-40.bltmmd.fios.verizon.net. [71.121.242.40])
        by smtp.gmail.com with ESMTPSA id z8sm12735852qth.62.2019.04.04.08.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 08:36:57 -0700 (PDT)
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>
Subject: [PATCH] Add security_validatetrans support
Date:   Thu,  4 Apr 2019 08:36:54 -0700
Message-Id: <20190404153654.32122-1-joshua.brindle@crunchydata.com>
X-Mailer: git-send-email 2.17.2
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It seems validatetrans support was never added to libselinux, despite being added to
selinuxfs in kernel version 4.5

Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
---
 libselinux/include/selinux/selinux.h          | 13 +++
 libselinux/man/man3/security_compute_av.3     | 13 ++-
 libselinux/man/man3/security_validatetrans.c  |  1 +
 .../man/man3/security_validatetrans_raw.c     |  1 +
 libselinux/src/selinux_internal.h             |  2 +
 libselinux/src/validatetrans.c                | 80 +++++++++++++++++++
 6 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/man/man3/security_validatetrans.c
 create mode 100644 libselinux/man/man3/security_validatetrans_raw.c
 create mode 100644 libselinux/src/validatetrans.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index a34d54fc..948028ea 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -255,6 +255,19 @@ extern int security_compute_user_raw(const char * scon,
 				     const char *username,
 				     char *** con);
 
+/* Validate a transition. This determines whether a transition from scon to newcon
+   using tcon as the target for object class tclass is valid in the loaded policy.
+   This checks against the mlsvalidatetrans and validatetrans constraints in the loaded policy.
+   Returns 0 if allowed, -EPERM if denied, and -1 if an error occured */
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
index 2aade5fe..e03960bc 100644
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
+validatetrans constraints in the loaded policy. Returns 0 if allowed, -EPERM if denied, 
+and -1 if an error occured
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
index 00000000..86bfaa30
--- /dev/null
+++ b/libselinux/src/validatetrans.c
@@ -0,0 +1,80 @@
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
+	char *buf;
+	size_t size;
+	int fd, ret;
+
+	if (!selinux_mnt) {
+		errno = ENOENT;
+		return -1;
+	}
+
+	snprintf(path, sizeof path, "%s/validatetrans", selinux_mnt);
+	fd = open(path, O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+
+	size = selinux_page_size;
+	buf = malloc(size);
+	if (!buf) {
+		ret = -1;
+		goto out;
+	}
+	snprintf(buf, size, "%s %s %hu %s", scon, tcon, unmap_class(tclass), newcon);
+
+	ret = write(fd, buf, strlen(buf));
+	free(buf);
+out:
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
-- 
2.17.2

