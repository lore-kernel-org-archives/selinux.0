Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9055AC43381
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 16:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463CF20700
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 16:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZuJ+NSI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfBVQbM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:31:12 -0500
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:17047 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726757AbfBVQbM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 11:31:12 -0500
X-EEMSG-check-017: 236547060|USFB19PA13_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Feb 2019 16:31:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550853070; x=1582389070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pPckhgMWKf8VGkvWee5ARH/4TPBLOb0EBo5mwM+VMGY=;
  b=ZuJ+NSI1900DtdGWTQ8yDLGorZFbLVAv+vYEO1ZGfKs429Ui9qguqQ+d
   HuvU3NNROiIYrIb+lFypiaUb2JYRzHgFvJWGAZz9oLPSRdELA23t8HaOs
   FTgoKp2f45dsVuSPnVKb+jfmZFV7+ft4wHs2DS8qUsol6VZTabRu2utb4
   MbJmxrOyASpH7BY+pvuhe6fkQGUXA6oV8FnCDWaRwSG9EfyiE2jj1OfpA
   bBH0HZcvaq5ac2rLpZfRr/Wi4HDIXVv43DMizMENh0fMnBoJ6Wxac4qr+
   alkJt4FpFV3FY6IBn/2cRcCfrFCBeaTHbjcC042kte/k5FIP97lwyW0Qv
   w==;
X-IronPort-AV: E=Sophos;i="5.58,400,1544486400"; 
   d="scan'208";a="20798751"
IronPort-PHdr: =?us-ascii?q?9a23=3AHlxubhxsg1Bw/5/XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+8TIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsL4V7A0XS?=
 =?us-ascii?q?mp4bltRhHmlSwLMyc1/H/LhsB1iq9QvRCvqAFlw4PMYI+bKudwcK3ec90dSm?=
 =?us-ascii?q?VPUd1cWzBCD46mc4cCFfYNMfpeooLgp1UOtxy+BQy0Ce3y1j9HmGf23a0k3O?=
 =?us-ascii?q?QnDArIwQkgEMgKsHTQstr0NLoZXOeuzKbV1jXOdO9W2Dfh54jIdRAtu/eMXa?=
 =?us-ascii?q?lqfsbLxkkvEB3Fg0yWpIf4PD2VzvwAv3WU4udvT+6ii3MrpxtvrjWg2MsgkJ?=
 =?us-ascii?q?TFi4QIwV7e7yp52pw6JdigRU5+Zt6rDYVfujmBN4tzXsMiW2ZouDsmyrEeuZ?=
 =?us-ascii?q?60YiwKyJM/yh7DcfOHaYmI4g/4VOqLPTd5hG5qeLK4hxqo90iv1vb8WdWu3F?=
 =?us-ascii?q?ZPrypFlsHAtnEL1xPN9siKUuZx80iu1DqV1w3f9/tILV47mKbFMZIt36Y8lp?=
 =?us-ascii?q?8JvkTCGi/2ll/2jKiTdkg84ein9v/nb676pp6cK4B0igb+Pr4omsykG+s0KA?=
 =?us-ascii?q?cOX2+F+eikzr3s4VX5QKlWjv0xiqTZq47VJcAapq6/Hg9U3Z0u6wiwDzi4yt?=
 =?us-ascii?q?QUh3oHI0xfeBKBkYfpP0vCIPfiDfewm16siitkx+jaPr39BZXANmXMkLDkfb?=
 =?us-ascii?q?Z87U5cyRY8zdNF65JbELEBIfzzWlPqudPFEBA5PRK7w+D8CNpjyowSQ2SPAq?=
 =?us-ascii?q?uBOqPIrVCI/v4vI/WLZIINoDbyMeUl5/r1gH8hg1AdYK2p0YISaHC/GfRmOV?=
 =?us-ascii?q?uWbWDwjdcGFGdZ9jY5GfTjlVmqSTdOYzO3WKUm63cwD4f1I53EQ9WWnLGZ3C?=
 =?us-ascii?q?q9VqZTb2RCB0HERWzkbK2YSvwMb2SUOcYnnTsaA+vyA7Q93A2j4Vepg4FsKf?=
 =?us-ascii?q?DZr2hC7Z8=3D?=
X-IPAS-Result: =?us-ascii?q?A2BAAABnI3Bc/wHyM5BlHgEGBwaBUQkLAYFZKoE3ATInm?=
 =?us-ascii?q?EcBAQEBAQEGinCJU4UQgXsgGAGEQIQAIjQJDQEDAQEBAQEBAgFsKII6KYMVC?=
 =?us-ascii?q?wFGgVGCYz2BZg2sdTOFRIRpiAWEQxd4gQeBEY10Aol1EYZJgQZakSoJklQMG?=
 =?us-ascii?q?YFxiRyIAi2LMY1WhRY4gVYrCAIYCCEPgyeCKBcTbQECjTkhAzCBBQEBjwQBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Feb 2019 16:31:08 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1MGV73Z028212;
        Fri, 22 Feb 2019 11:31:07 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     dominick.grift@defensec.nl, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] libselinux: selinux_set_mapping: fix handling of unknown classes/perms
Date:   Fri, 22 Feb 2019 11:30:47 -0500
Message-Id: <20190222163047.10983-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The libselinux selinux_set_mapping() implementation was never updated
to handle unknown classes/permissions based on the policy handle_unknown
flag.  Update it and the internal mapping functions to gracefully
handle unknown classes/permissions.  Add a security_reject_unknown()
interface to expose the corresponding selinuxfs node and use it when
creating a mapping to decide whether to fail immediately or proceed.

This enables dbus-daemon and XSELinux, which use selinux_set_mapping(),
to continue working with the dummy policy or other policies that lack
their userspace class/permission definitions as long as the policy
was built with -U allow.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 moves the call to security_deny_unknown() inside of map_decision(),
thereby avoiding the overhead of calling it unless the caller has
set a mapping.

 libselinux/include/selinux/selinux.h |  5 +-
 libselinux/src/compute_av.c          | 14 ++++--
 libselinux/src/mapping.c             | 70 ++++++++++++++++++++++------
 libselinux/src/reject_unknown.c      | 40 ++++++++++++++++
 libselinux/src/selinux_internal.h    |  1 +
 5 files changed, 113 insertions(+), 17 deletions(-)
 create mode 100644 libselinux/src/reject_unknown.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 01201eee..a34d54fc 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -328,7 +328,10 @@ extern int security_getenforce(void);
 /* Set the enforce flag value. */
 extern int security_setenforce(int value);
 
-/* Get the behavior for undefined classes/permissions */
+/* Get the load-time behavior for undefined classes/permissions */
+extern int security_reject_unknown(void);
+
+/* Get the runtime behavior for undefined classes/permissions */
 extern int security_deny_unknown(void);
 
 /* Get the checkreqprot value */
diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
index 1d05e7b6..a47cffe9 100644
--- a/libselinux/src/compute_av.c
+++ b/libselinux/src/compute_av.c
@@ -20,6 +20,7 @@ int security_compute_av_flags_raw(const char * scon,
 	char *buf;
 	size_t len;
 	int fd, ret;
+	security_class_t kclass;
 
 	if (!selinux_mnt) {
 		errno = ENOENT;
@@ -38,8 +39,9 @@ int security_compute_av_flags_raw(const char * scon,
 		goto out;
 	}
 
+	kclass = unmap_class(tclass);
 	snprintf(buf, len, "%s %s %hu %x", scon, tcon,
-		 unmap_class(tclass), unmap_perm(tclass, requested));
+		 kclass, unmap_perm(tclass, requested));
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
@@ -60,8 +62,14 @@ int security_compute_av_flags_raw(const char * scon,
 	} else if (ret < 6)
 		avd->flags = 0;
 
-	/* If tclass invalid, kernel sets avd according to deny_unknown flag */
-	if (tclass != 0)
+	/*
+	 * If the tclass could not be mapped to a kernel class at all, the
+	 * kernel will have already set avd according to the
+	 * handle_unknown flag and we do not need to do anything further.
+	 * Otherwise, we must map the permissions within the returned
+	 * avd to the userspace permission values.
+	 */
+	if (kclass != 0)
 		map_decision(tclass, avd);
 
 	ret = 0;
diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
index f205804b..b450a5af 100644
--- a/libselinux/src/mapping.c
+++ b/libselinux/src/mapping.c
@@ -6,9 +6,12 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <selinux/selinux.h>
 #include <selinux/avc.h>
+#include "callbacks.h"
 #include "mapping.h"
+#include "selinux_internal.h"
 
 /*
  * Class and permission mappings
@@ -33,6 +36,9 @@ selinux_set_mapping(struct security_class_mapping *map)
 	size_t size = sizeof(struct selinux_mapping);
 	security_class_t i, j;
 	unsigned k;
+	bool print_unknown_handle = false;
+	bool reject = (security_reject_unknown() == 1);
+	bool deny = (security_deny_unknown() == 1);
 
 	free(current_mapping);
 	current_mapping = NULL;
@@ -62,8 +68,16 @@ selinux_set_mapping(struct security_class_mapping *map)
 		struct selinux_mapping *p_out = current_mapping + j;
 
 		p_out->value = string_to_security_class(p_in->name);
-		if (!p_out->value)
-			goto err2;
+		if (!p_out->value) {
+			selinux_log(SELINUX_INFO,
+				    "SELinux: Class %s not defined in policy.\n",
+				    p_in->name);
+			if (reject)
+				goto err2;
+			p_out->num_perms = 0;
+			print_unknown_handle = true;
+			continue;
+		}
 
 		k = 0;
 		while (p_in->perms[k]) {
@@ -74,13 +88,24 @@ selinux_set_mapping(struct security_class_mapping *map)
 			}
 			p_out->perms[k] = string_to_av_perm(p_out->value,
 							    p_in->perms[k]);
-			if (!p_out->perms[k])
-				goto err2;
+			if (!p_out->perms[k]) {
+				selinux_log(SELINUX_INFO,
+					    "SELinux:  Permission %s in class %s not defined in policy.\n",
+					    p_in->perms[k], p_in->name);
+				if (reject)
+					goto err2;
+				print_unknown_handle = true;
+			}
 			k++;
 		}
 		p_out->num_perms = k;
 	}
 
+	if (print_unknown_handle)
+		selinux_log(SELINUX_INFO,
+			    "SELinux: the above unknown classes and permissions will be %s\n",
+			    deny ? "denied" : "allowed");
+
 	/* Set the mapping size here so the above lookups are "raw" */
 	current_mapping_size = i;
 	return 0;
@@ -184,27 +209,46 @@ void
 map_decision(security_class_t tclass, struct av_decision *avd)
 {
 	if (tclass < current_mapping_size) {
-		unsigned i;
+		bool allow_unknown = (security_deny_unknown() == 0);
+		struct selinux_mapping *mapping = &current_mapping[tclass];
+		unsigned int i, n = mapping->num_perms;
 		access_vector_t result;
 
-		for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
-			if (avd->allowed & current_mapping[tclass].perms[i])
+		for (i = 0, result = 0; i < n; i++) {
+			if (avd->allowed & mapping->perms[i])
+				result |= 1<<i;
+			if (allow_unknown && !mapping->perms[i])
 				result |= 1<<i;
+		}
 		avd->allowed = result;
 
-		for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
-			if (avd->decided & current_mapping[tclass].perms[i])
+		for (i = 0, result = 0; i < n; i++) {
+			if (avd->decided & mapping->perms[i])
+				result |= 1<<i;
+			if (allow_unknown && !mapping->perms[i])
 				result |= 1<<i;
+		}
 		avd->decided = result;
 
-		for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
-			if (avd->auditallow & current_mapping[tclass].perms[i])
+		for (i = 0, result = 0; i < n; i++)
+			if (avd->auditallow & mapping->perms[i])
 				result |= 1<<i;
 		avd->auditallow = result;
 
-		for (i=0, result=0; i<current_mapping[tclass].num_perms; i++)
-			if (avd->auditdeny & current_mapping[tclass].perms[i])
+		for (i = 0, result = 0; i < n; i++) {
+			if (avd->auditdeny & mapping->perms[i])
 				result |= 1<<i;
+			if (!allow_unknown && !mapping->perms[i])
+				result |= 1<<i;
+		}
+
+		/*
+		 * Make sure we audit denials for any permission check
+		 * beyond the mapping->num_perms since this indicates
+		 * a bug in the object manager.
+		 */
+		for (; i < (sizeof(result)*8); i++)
+			result |= 1<<i;
 		avd->auditdeny = result;
 	}
 }
diff --git a/libselinux/src/reject_unknown.c b/libselinux/src/reject_unknown.c
new file mode 100644
index 00000000..5c1d3605
--- /dev/null
+++ b/libselinux/src/reject_unknown.c
@@ -0,0 +1,40 @@
+#include <unistd.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include "selinux_internal.h"
+#include "policy.h"
+#include <stdio.h>
+#include <limits.h>
+
+int security_reject_unknown(void)
+{
+	int fd, ret, reject_unknown = 0;
+	char path[PATH_MAX];
+	char buf[20];
+
+	if (!selinux_mnt) {
+		errno = ENOENT;
+		return -1;
+	}
+
+	snprintf(path, sizeof(path), "%s/reject_unknown", selinux_mnt);
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+
+	memset(buf, 0, sizeof(buf));
+	ret = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (ret < 0)
+		return -1;
+
+	if (sscanf(buf, "%d", &reject_unknown) != 1)
+		return -1;
+
+	return reject_unknown;
+}
+
+hidden_def(security_reject_unknown);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index dfc421cc..70b5025d 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -59,6 +59,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(security_getenforce)
     hidden_proto(security_setenforce)
     hidden_proto(security_deny_unknown)
+    hidden_proto(security_reject_unknown)
     hidden_proto(security_get_checkreqprot)
     hidden_proto(selinux_boolean_sub)
     hidden_proto(selinux_current_policy_path)
-- 
2.20.1

