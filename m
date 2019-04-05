Return-Path: <SRS0=5WGn=SH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED99AC4360F
	for <selinux@archiver.kernel.org>; Fri,  5 Apr 2019 00:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6325217D4
	for <selinux@archiver.kernel.org>; Fri,  5 Apr 2019 00:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="dW+DdisZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfDEAcr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:32:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33391 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDEAcr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Apr 2019 20:32:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id k14so5573837qtb.0
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2019 17:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TBUv0xo52UgMQ0Qk761ocEUqlnjsbrtXW2shXfovCYQ=;
        b=dW+DdisZWiq0q0a0wIZ1v/8L0Oyov7ZDL+SS0cWKq+AtFV42+5vpp5sGgVWYIuUmaN
         hh7d0ewe9JxQ6qOK1vjaWAdV5JqX4YJ3gXgbyQ2FSyVrnFzHETw47sr1doW2MumzTtwq
         SCts8Gnc4xl5dTJ00Tq8cA7kWTvvez5lVC7WFi9KgMkXEM9v+ZSp46yJEIYHtqnbFIrl
         fVkFTNT9vSBUa2M9i6wIQSIzAxXyVscvhp001CUD9dS03gVvoia6861YVJd9bcqUtsDn
         /VYGvwFVb5E5FvAEoqg9PV93a94c/om9UMUuZVIb37AVFjFdIlXRz/CHN/dKj6o6idnA
         7i7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TBUv0xo52UgMQ0Qk761ocEUqlnjsbrtXW2shXfovCYQ=;
        b=l6dkrGEpvGRsIzFnI4TZBfPIxHI8xOit0H/dDvPAnsY6gcsn2QgF8BzwWaScg2FWZr
         K1PzL0MTENpghUhwxsTz+k9n73I+ISSrQmfoMY8z5UwDgO9Qxk7rjSaR5SYUD82naNeH
         DnIOEpl751vo9GRIGOGlf7Sj9JE+fyLrjAvx30M1x7AAVxBBDWlL6rbeRvc49rkpQNM+
         N0M6enmlyzI4IRpj8S8OD/WX8XxCb7VW21YoL0pRK5JFpoCTUFCbrXTOwjKDjCbv044f
         x+xxcEynAIrBMN6+oF2NdfFtho/BSluOiXoCLQKRUmy1ewdE3j0spKsoSAiA5SFgcOdt
         IJDA==
X-Gm-Message-State: APjAAAVQPg5TbkzFJxbXM9N2awWJo8lHSqIU+gw/rJc06sDlXRsALRxD
        jpBqsoBKgQF3RUYoqpaQ2aUD9SxsQuw=
X-Google-Smtp-Source: APXvYqye5Kzkrt45bL1w1pLjCrUnQvQy9O6As76pTHzHYrcxHXQzBOuCTaO186V57L+hKmB5g/VJmQ==
X-Received: by 2002:ac8:1876:: with SMTP id n51mr8251818qtk.234.1554424365139;
        Thu, 04 Apr 2019 17:32:45 -0700 (PDT)
Received: from localhost.localdomain (pool-71-121-242-40.bltmmd.fios.verizon.net. [71.121.242.40])
        by smtp.gmail.com with ESMTPSA id t34sm15964800qth.36.2019.04.04.17.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 17:32:44 -0700 (PDT)
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>
Subject: [PATCH] Add security_validatetrans support
Date:   Thu,  4 Apr 2019 17:32:33 -0700
Message-Id: <20190405003233.29183-1-joshua.brindle@crunchydata.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <CAGB+Vh5n3_+MvL_8XAvAV+L8cX_gO26yEp3ZJyzhhLURwXqV7A@mail.gmail.com>
References: <CAGB+Vh5n3_+MvL_8XAvAV+L8cX_gO26yEp3ZJyzhhLURwXqV7A@mail.gmail.com>
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
 libselinux/src/validatetrans.c                | 98 +++++++++++++++++++
 libselinux/utils/.gitignore                   |  1 +
 libselinux/utils/validatetrans.c              | 30 ++++++
 8 files changed, 158 insertions(+), 1 deletion(-)
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
index 00000000..1bb5df2d
--- /dev/null
+++ b/libselinux/src/validatetrans.c
@@ -0,0 +1,98 @@
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
+	bufsz = snprintf(NULL, 0, "%s %s %hu %s", scon, tcon, unmap_class(tclass), newcon);
+	if (bufsz > size) {
+		// This is going to be too large
+		goto out;
+	}
+	if (bufsz != snprintf(buf, size, "%s %s %hu %s", scon, tcon, unmap_class(tclass), newcon)) {
+		// It got truncated somehow
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
index 00000000..fa8541f6
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
+	return(ret);
+}
-- 
2.17.2

