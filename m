Return-Path: <SRS0=FZ6t=4J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B63C35641
	for <selinux@archiver.kernel.org>; Fri, 21 Feb 2020 08:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EBA222C4
	for <selinux@archiver.kernel.org>; Fri, 21 Feb 2020 08:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqShV6yX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgBUIio (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:38:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38381 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbgBUIin (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Feb 2020 03:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582274322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ynt7DGShPGKxSR+R5MIScskIF0bvi8WU6KKmenAGGtc=;
        b=BqShV6yXsvAm+p3TSKl1QvMGc2sJw8wJN6/CQFaNbjClYkk6g5JBZaatuayxPQ/AXpKMPI
        W9/Dw0DWdjy1ZpmoXCtmBST5rK3ZlujXLAvIKbmITArnLAXBpu6YR7c8SzkqOhSf6iZaU2
        S2U6+bvfqbkWK2UHcg6PtpklYNMsmIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-m5aq-Sq_OPirjyuvZF1uBg-1; Fri, 21 Feb 2020 03:38:38 -0500
X-MC-Unique: m5aq-Sq_OPirjyuvZF1uBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 150BE13F5;
        Fri, 21 Feb 2020 08:38:37 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-205-44.brq.redhat.com [10.40.205.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BCCF5C1D8;
        Fri, 21 Feb 2020 08:38:34 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libselinux: deprecate security_compute_user(), update man pages
Date:   Fri, 21 Feb 2020 09:38:19 +0100
Message-Id: <20200221083819.1124890-1-plautrba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Stephen Smalley <sds@tycho.nsa.gov>

commit 1f89c4e7879fcf6da5d8d1b025dcc03371f30fc9 ("libselinux: Eliminate
use of security_compute_user()") eliminated the use of
security_compute_user() by get_ordered_context_list().  Deprecate
all use of security_compute_user() by updating the headers and man
pages and logging a warning message on any calls to it.  Remove
the example utility that called the interface. While here, also
fix the documentation of correct usage of the user argument to these
interfaces.

Fixes: https://github.com/SELinuxProject/selinux/issues/70
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Petr Lautrbach <plautrba@redhat.com>
---

It looks like the original email didn't get to the mailing list. Therefor=
e
I'm resending it for a broader audience.


 libselinux/include/selinux/selinux.h          |  8 +++-
 .../man/man3/get_ordered_context_list.3       | 24 +++++++++---
 libselinux/man/man3/security_compute_av.3     |  5 ++-
 libselinux/src/compute_user.c                 |  3 ++
 libselinux/utils/compute_user.c               | 38 -------------------
 5 files changed, 31 insertions(+), 47 deletions(-)
 delete mode 100644 libselinux/utils/compute_user.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
index 883d8b85742c..6a512b383325 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -246,8 +246,12 @@ extern int security_compute_member_raw(const char * =
scon,
 				       security_class_t tclass,
 				       char ** newcon);
=20
-/* Compute the set of reachable user contexts and set *con to refer to=20
-   the NULL-terminated array of contexts.  Caller must free via freecona=
ry. */
+/*
+ * Compute the set of reachable user contexts and set *con to refer to
+ * the NULL-terminated array of contexts.  Caller must free via freecona=
ry.
+ * These interfaces are deprecated.  Use get_ordered_context_list() or
+ * one of its variant interfaces instead.
+ */
 extern int security_compute_user(const char * scon,
 				 const char *username,
 				 char *** con);
diff --git a/libselinux/man/man3/get_ordered_context_list.3 b/libselinux/=
man/man3/get_ordered_context_list.3
index e084da406af1..3ed14a96879c 100644
--- a/libselinux/man/man3/get_ordered_context_list.3
+++ b/libselinux/man/man3/get_ordered_context_list.3
@@ -26,14 +26,28 @@ get_ordered_context_list, get_ordered_context_list_wi=
th_level, get_default_conte
 .BI "int get_default_type(const char *" role ", char **" type );
 .
 .SH "DESCRIPTION"
+
+This family of functions can be used to obtain either a prioritized list=
 of
+all reachable security contexts for a given SELinux user or a single def=
ault
+(highest priority) context for a given SELinux user for use by login-lik=
e
+programs.  These functions takes a SELinux user identity that must
+be defined in the SELinux policy as their input, not a Linux username.
+Most callers should typically first call
+.BR getseuserbyname(3)
+to look up the SELinux user identity and level for a given
+Linux username and then invoke one of
+.BR get_ordered_context_list_with_level ()
+or
+.BR get_default_context_with_level ()
+with the returned SELinux user and level as inputs.
+
 .BR get_ordered_context_list ()
-invokes the=20
-.BR security_compute_user (3)
-function to obtain the list of contexts for the specified
+obtains the list of contexts for the specified
+SELinux
 .I user
-that are reachable from the specified
+identity that are reachable from the specified
 .I fromcon
-context.  The function then orders the resulting list based on the globa=
l
+context based on the global
 .I \%/etc/selinux/{SELINUXTYPE}/contexts/default_contexts
 file and the per-user
 .I \%/etc/selinux/{SELINUXTYPE}/contexts/users/<username>
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/m=
an3/security_compute_av.3
index 3de1b0fe7f1b..efa4baf3304f 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -134,8 +134,9 @@ instance.
=20
 .BR security_compute_user ()
 is used to determine the set of user contexts that can be reached from a
-source context. It is mainly used by
-.BR get_ordered_context_list (3).
+source context. This function is deprecated; use
+.BR get_ordered_context_list (3)
+instead.
=20
 .BR security_validatetrans ()
 is used to determine if a transition from scon to newcon using tcon as t=
he object
diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.=
c
index 7b8812155750..e7da964ff46d 100644
--- a/libselinux/src/compute_user.c
+++ b/libselinux/src/compute_user.c
@@ -8,6 +8,7 @@
 #include "selinux_internal.h"
 #include "policy.h"
 #include <limits.h>
+#include "callbacks.h"
=20
 int security_compute_user_raw(const char * scon,
 			      const char *user, char *** con)
@@ -24,6 +25,8 @@ int security_compute_user_raw(const char * scon,
 		return -1;
 	}
=20
+	selinux_log(SELINUX_WARNING, "Direct use of security_compute_user() is =
deprecated, switch to get_ordered_context_list()\n");
+
 	snprintf(path, sizeof path, "%s/user", selinux_mnt);
 	fd =3D open(path, O_RDWR | O_CLOEXEC);
 	if (fd < 0)
diff --git a/libselinux/utils/compute_user.c b/libselinux/utils/compute_u=
ser.c
deleted file mode 100644
index 86d00a6eff1c..000000000000
--- a/libselinux/utils/compute_user.c
+++ /dev/null
@@ -1,38 +0,0 @@
-#include <unistd.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <ctype.h>
-#include <selinux/selinux.h>
-
-int main(int argc, char **argv)
-{
-	char **buf, **ptr;
-	int ret;
-
-	if (argc !=3D 3) {
-		fprintf(stderr, "usage:  %s context user\n", argv[0]);
-		exit(1);
-	}
-
-	ret =3D security_compute_user(argv[1], argv[2], &buf);
-	if (ret < 0) {
-		fprintf(stderr, "%s:  security_compute_user(%s,%s) failed\n",
-			argv[0], argv[1], argv[2]);
-		exit(2);
-	}
-
-	if (!buf[0]) {
-		printf("none\n");
-		exit(EXIT_SUCCESS);
-	}
-
-	for (ptr =3D buf; *ptr; ptr++) {
-		printf("%s\n", *ptr);
-	}
-	freeconary(buf);
-	exit(EXIT_SUCCESS);
-}
--=20
2.25.0

