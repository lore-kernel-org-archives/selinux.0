Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D18C34031
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 21:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716362173E
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 21:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="SZWg09IS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgBRV2e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:28:34 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:5855 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgBRV2d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 16:28:33 -0500
X-EEMSG-check-017: 59786891|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,458,1574121600"; 
   d="scan'208";a="59786891"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 21:28:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582061310; x=1613597310;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=McU9lxNu+3dv3P6CJhlJ38zX+H4ilQWyAy9iGBg+Uwo=;
  b=SZWg09ISnhyLPRw+UxK9eibC7AmPTlF2+yRW5YVjA+PRtbIdWBUrTkGr
   Bt70JHwXxDb8GadOa7dwo9Xyhy9G0s/sPNHgAhg1koRCZ/wF4jYUjBo7v
   qN0G0WnIcZrRIqV/3Wn57hzhye4SiulXCpQaYGTPFoWZcwyKzTmLLGTH3
   4efzFbExLJuyRxYkWfuPm9jgY+9t91FOE/XavO0e3PJOnS+LZcwKUx+wl
   QIwVCLsMUyfF85aJv2IGBOsJeDKXwNp0FyXGsqdgaR462zuk1XxRMX8xO
   xmoqKobTZxM3sLYVivw0Gl6F+7SyVOqtSvgxx7nXB1Y9GclyJSP6jL4JH
   w==;
X-IronPort-AV: E=Sophos;i="5.70,458,1574121600"; 
   d="scan'208";a="39256958"
IronPort-PHdr: =?us-ascii?q?9a23=3A0+/iMR+xl0uhFv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B31ewcTK2v8tzYMVDF4r011RmVBNmdtKIP0reO+4nbGkU+or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCeybL9oLhi7rgrdutQWjId+N6081g?=
 =?us-ascii?q?bHrnxUdutZwm9lOUidlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q6FGATo/K2?=
 =?us-ascii?q?w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWT?=
 =?us-ascii?q?mn8qxmRgPkhDsBOjUk/m7XkMhwh79FrhynqRJ03orYbJibOfd6e6/Qe84RS2?=
 =?us-ascii?q?hcUcZLTyFPAp2yYZYBAeQCOuhXoIbzqkASoRa9HwSgGPnixiNUinLwwKY00/?=
 =?us-ascii?q?4hEQbD3AE4AtwOrGrbrM31NKgMV+C+0bTGzTDZYPNS3Tfy9ojJeQ0mrPGXQL?=
 =?us-ascii?q?1watHcyVUvFgzZjlWQrpbpPzWO1usXqWSb4O1gVfy2hmMhtgp/rD+vxsI2hY?=
 =?us-ascii?q?nIgIIY0l/E9SRlwIY1ON23U1R3bsKjEJtVsSyRKoh4Qts6Tm11tys3xacKtJ?=
 =?us-ascii?q?6mcCQQ1pgqyADTZ+aaf4WO/xntTvyeIS1ii3JgYL+/ghGy/lW+xeDkTcm01U?=
 =?us-ascii?q?pKrjJCktnRqnABzxzT5daDSvt65kqhxSyA1xrS6uFZOkA4j6vbK5gvwr43jZ?=
 =?us-ascii?q?ocr1jMEjXqmET2kKCWdkIk9vKu6+v7ebXpuoWQN4p1igH6Kqgum8q/DvokMg?=
 =?us-ascii?q?UWQmSW9uux2Kfj8EHkWrlGkPI7nrfDvJzHPcgbo7S2Aw5R0oYt8Ra/CDKm3c?=
 =?us-ascii?q?wDnXYaN1JIYw6Hjoj1NFHOJ/D0F/G/g0+2nztxyPDGOaPhDo3XLnffiLfhYa?=
 =?us-ascii?q?p960lExQorydBQ/Y9UCq0bIP3oQED8r8bYAQEkPAy02ennFM9x2Z8ZWWKKGq?=
 =?us-ascii?q?WZKr/dsUeU5uIzJOmBfJQVtyj5K/gk4f7ukHA4lEQDfammw5QXcmq0Hvd4LE?=
 =?us-ascii?q?WDZ3rjnNMBHX0NvgokQ+y5wGGFBCVeY3e0QrIU+D42EsSlAJ3FS4Trh6aOjw?=
 =?us-ascii?q?mhGZgDXXxLElCBFz/TcoyAX/odIHaJLtRJji0PVb/nTZQokx6pqlmpmPJcMu?=
 =?us-ascii?q?PI93hA5trY399v6riWzkA/?=
X-IPAS-Result: =?us-ascii?q?A2BzAABHVkxe/wHyM5BdCRwBAQEBAQcBAREBBAQBAYFpB?=
 =?us-ascii?q?QEBCwEBgXuBGFQBIBIqjReGXAEBAQEBAQaLJ4onhSiBewkBAQEBAQEBAQEbE?=
 =?us-ascii?q?AwEAQGDe0WCKTYHDgIQAQEBBQEBAQEBBQMBAWyFNwxCARABgWcpgzsBRkkBg?=
 =?us-ascii?q?QeCZz8BglYlD68FhUqDb4E4BoE4AYdFhHh5gQeBETaDG4JkAoE5dAKFJASNX?=
 =?us-ascii?q?gqKMHyWdoJFglCEf4lhhR0MHIJJmFwBLZAMhyuOTIV8ATGBWCsIAhgIIQ87g?=
 =?us-ascii?q?mxQGA2OKBiBBAEFgkaKcSMDMIcHhyEPF4E8XwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Feb 2020 21:28:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01ILRRoN197181;
        Tue, 18 Feb 2020 16:27:27 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH] libselinux: deprecate security_compute_user(), update man pages
Date:   Tue, 18 Feb 2020 16:29:26 -0500
Message-Id: <20200218212926.11754-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

commit <insert-hash-here-when-it-gets-merged> ("libselinux: Eliminate
use of security_compute_user()") eliminated the use of
security_compute_user() by get_ordered_context_list().  Deprecate
all use of security_compute_user() by updating the headers and man
pages and logging a warning message on any calls to it.  Remove
the example utility that called the interface. While here, also
fix the documentation of correct usage of the user argument to these
interfaces.

Fixes: https://github.com/SELinuxProject/selinux/issues/70
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
This will get updated with the actual commit hash before merging.

 libselinux/include/selinux/selinux.h          |  8 +++-
 .../man/man3/get_ordered_context_list.3       | 24 +++++++++---
 libselinux/man/man3/security_compute_av.3     |  5 ++-
 libselinux/src/compute_user.c                 |  3 ++
 libselinux/utils/compute_user.c               | 38 -------------------
 5 files changed, 31 insertions(+), 47 deletions(-)
 delete mode 100644 libselinux/utils/compute_user.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 7922d96b70c7..17d473208dc1 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -246,8 +246,12 @@ extern int security_compute_member_raw(const char * scon,
 				       security_class_t tclass,
 				       char ** newcon);
 
-/* Compute the set of reachable user contexts and set *con to refer to 
-   the NULL-terminated array of contexts.  Caller must free via freeconary. */
+/*
+ * Compute the set of reachable user contexts and set *con to refer to
+ * the NULL-terminated array of contexts.  Caller must free via freeconary.
+ * These interfaces are deprecated.  Use get_ordered_context_list() or
+ * one of its variant interfaces instead.
+ */
 extern int security_compute_user(const char * scon,
 				 const char *username,
 				 char *** con);
diff --git a/libselinux/man/man3/get_ordered_context_list.3 b/libselinux/man/man3/get_ordered_context_list.3
index e084da406af1..3ed14a96879c 100644
--- a/libselinux/man/man3/get_ordered_context_list.3
+++ b/libselinux/man/man3/get_ordered_context_list.3
@@ -26,14 +26,28 @@ get_ordered_context_list, get_ordered_context_list_with_level, get_default_conte
 .BI "int get_default_type(const char *" role ", char **" type );
 .
 .SH "DESCRIPTION"
+
+This family of functions can be used to obtain either a prioritized list of
+all reachable security contexts for a given SELinux user or a single default
+(highest priority) context for a given SELinux user for use by login-like
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
-invokes the 
-.BR security_compute_user (3)
-function to obtain the list of contexts for the specified
+obtains the list of contexts for the specified
+SELinux
 .I user
-that are reachable from the specified
+identity that are reachable from the specified
 .I fromcon
-context.  The function then orders the resulting list based on the global
+context based on the global
 .I \%/etc/selinux/{SELINUXTYPE}/contexts/default_contexts
 file and the per-user
 .I \%/etc/selinux/{SELINUXTYPE}/contexts/users/<username>
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index 3de1b0fe7f1b..efa4baf3304f 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -134,8 +134,9 @@ instance.
 
 .BR security_compute_user ()
 is used to determine the set of user contexts that can be reached from a
-source context. It is mainly used by
-.BR get_ordered_context_list (3).
+source context. This function is deprecated; use
+.BR get_ordered_context_list (3)
+instead.
 
 .BR security_validatetrans ()
 is used to determine if a transition from scon to newcon using tcon as the object
diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
index 7b8812155750..e7da964ff46d 100644
--- a/libselinux/src/compute_user.c
+++ b/libselinux/src/compute_user.c
@@ -8,6 +8,7 @@
 #include "selinux_internal.h"
 #include "policy.h"
 #include <limits.h>
+#include "callbacks.h"
 
 int security_compute_user_raw(const char * scon,
 			      const char *user, char *** con)
@@ -24,6 +25,8 @@ int security_compute_user_raw(const char * scon,
 		return -1;
 	}
 
+	selinux_log(SELINUX_WARNING, "Direct use of security_compute_user() is deprecated, switch to get_ordered_context_list()\n");
+
 	snprintf(path, sizeof path, "%s/user", selinux_mnt);
 	fd = open(path, O_RDWR | O_CLOEXEC);
 	if (fd < 0)
diff --git a/libselinux/utils/compute_user.c b/libselinux/utils/compute_user.c
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
-	if (argc != 3) {
-		fprintf(stderr, "usage:  %s context user\n", argv[0]);
-		exit(1);
-	}
-
-	ret = security_compute_user(argv[1], argv[2], &buf);
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
-	for (ptr = buf; *ptr; ptr++) {
-		printf("%s\n", *ptr);
-	}
-	freeconary(buf);
-	exit(EXIT_SUCCESS);
-}
-- 
2.24.1

