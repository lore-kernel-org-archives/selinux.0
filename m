Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96F8C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BBB20651
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 14:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="GT9i28hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfBVOmx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:42:53 -0500
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:51855 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfBVOmw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 09:42:52 -0500
X-EEMSG-check-017: 823820359|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,400,1544486400"; 
   d="scan'208";a="823820359"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Feb 2019 14:42:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550846523; x=1582382523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xshq6IpAe7pHr6iOgln1SfrMXtuQDxLsWFtLFn+hAa0=;
  b=GT9i28hdeaQPU9M0rIFcWdjDjmCK8nYtFD+RtxMjhNg931iMaEj4ho86
   oB9/jNALBo5ChAs4kOjOVO8KlID7eBdQgXtTLEa2K4unMHvB0twQo8ZCb
   LQROTJhraCOje9QlGnjBmkg5c8RC/UL80O3KwJ6f0qfGLT6YKbMp9LSPU
   gCuT5qOrbguVbK9Xq93dMWeIzNRos+QeMd7xG3MQp3IcVVeVjh4MNK6kR
   0VpZ8sGioRFO2pIuvBAxfJOrDh16+FfE0vZZcjsEhyF5C9S0jHE3g+0nV
   cGpIGm0K9ltsmqDfXqhMoxQJBGIUNUmI2vuTYftsB6ZVJgs/pOgCLN2m7
   A==;
X-IronPort-AV: E=Sophos;i="5.58,400,1544486400"; 
   d="scan'208";a="24217538"
IronPort-PHdr: =?us-ascii?q?9a23=3AeOTWzhMWaT5XBnX41F4l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0Ivn+rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr86Qz?=
 =?us-ascii?q?Si67pgRgHuhikJKjU19HjbhtJsgK5eph+quh5xzJPOYIyNNPRwYL7Tc90ZS2?=
 =?us-ascii?q?RGUclfWDdMDp+/YoYVE+YMJ/pUo5X7qlATrRW+Hw6sBOb3xzFVmn/5w7U60+?=
 =?us-ascii?q?Q/HgHAwQcuAtcOv27QrNXxKqgTUf2+wa7TzTredPNbwiv96YjUfRAhpvGAR7?=
 =?us-ascii?q?RwcdHLxkU1GAPFiUuQpJXjMjiI1eoNq3CW4/dvWO+gkWIqqxx9riKxysojlI?=
 =?us-ascii?q?XFnJ8Zx1bZ/itj2ok1P8e3SEtjbN6hF5tfqj+VOpNtQsMnX2FooCE6yqAauZ?=
 =?us-ascii?q?KjfCgF1pAnxxnHZvybaYeI+BPjVPuKITtimHJkeK6whxa18US6zO3zStK030?=
 =?us-ascii?q?pQoipAk9nMsmgB1x3V6seZVvtw5lqt1DmA2gzJ6uxIPFo4mbTUJpI/2LI8i4?=
 =?us-ascii?q?IfsUHZES/3nEX2grWWdkIh+uWw8OTof67mq4SAN450lg7+MqMulta5AeQjKA?=
 =?us-ascii?q?cCRWeb+eOi1LH75032XK1KjuEqkqneqJ3aPtoUpqq4Aw9Tz4Yi5A2yDymp0N?=
 =?us-ascii?q?sGh3kLNlFFdwydj4jvJV7OJOr0DfClg1SjiD1r3ezJPqX9ApXRKXjOiKrufb?=
 =?us-ascii?q?F4605dzgozzMxQ55FOBrEOOvLzW0HxtMDDAxAkLQO0zfjoCNNm1owARW2DGK?=
 =?us-ascii?q?mZMKfKu1+S+u0vO/WMZJMSuDvlM/gq/ePujXsilF8FZ6apwJ8XZGm9HvRhJE?=
 =?us-ascii?q?WZe2Tjjs0dHmcNuwptBNDt3UWLTDp7f3+vW+c54TYhBcStCoKQaJqqhem6wC?=
 =?us-ascii?q?qjHpBQLltDA1SIHGagI56IQN8QeSmSJYlniTVCWr+/HdxynSqyvRP3nuI0Zt?=
 =?us-ascii?q?Hf/TcV4Ne5jNU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BKAACrCHBc/wHyM5BlHgEGBwaBUQkLAYFZKoFqJ5hAA?=
 =?us-ascii?q?QEBAQEBBopwiVOFEIF7IBgBhECEACI0CQ0BAwEBAQEBAQIBbCiCOimDFQsBR?=
 =?us-ascii?q?oFRgmM9gWYNrGczhUSEaogFhEMXeIEHgRGNcwKJdRGGSYEGWpEqCZJUDBmBc?=
 =?us-ascii?q?YkciAEBLYsxjVaFFjiBVisIAhgIIQ+DJ4IoF4EAAQKNOSEDMIEFAQGPBAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 22 Feb 2019 14:42:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1MEfwMn020880;
        Fri, 22 Feb 2019 09:41:59 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     dominick.grift@defensec.nl, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: selinux_set_mapping: fix handling of unknown classes/perms
Date:   Fri, 22 Feb 2019 09:41:39 -0500
Message-Id: <20190222144139.8396-1-sds@tycho.nsa.gov>
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
 libselinux/include/selinux/selinux.h |  5 +-
 libselinux/src/compute_av.c          | 16 +++++--
 libselinux/src/mapping.c             | 71 ++++++++++++++++++++++------
 libselinux/src/mapping.h             |  4 +-
 libselinux/src/reject_unknown.c      | 40 ++++++++++++++++
 libselinux/src/selinux_internal.h    |  1 +
 6 files changed, 117 insertions(+), 20 deletions(-)
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
index 1d05e7b6..d5741637 100644
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
@@ -60,9 +62,15 @@ int security_compute_av_flags_raw(const char * scon,
 	} else if (ret < 6)
 		avd->flags = 0;
 
-	/* If tclass invalid, kernel sets avd according to deny_unknown flag */
-	if (tclass != 0)
-		map_decision(tclass, avd);
+	/*
+	 * If the tclass could not be mapped to a kernel class at all, the
+	 * kernel will have already set avd according to the
+	 * handle_unknown flag and we do not need to do anything further.
+	 * Otherwise, we must map the permissions within the returned
+	 * avd to the userspace permission values.
+	 */
+	if (kclass != 0)
+		map_decision(tclass, avd, !security_deny_unknown());
 
 	ret = 0;
       out2:
diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
index f205804b..892f887e 100644
--- a/libselinux/src/mapping.c
+++ b/libselinux/src/mapping.c
@@ -8,7 +8,9 @@
 #include <stdarg.h>
 #include <selinux/selinux.h>
 #include <selinux/avc.h>
+#include "callbacks.h"
 #include "mapping.h"
+#include "selinux_internal.h"
 
 /*
  * Class and permission mappings
@@ -33,6 +35,9 @@ selinux_set_mapping(struct security_class_mapping *map)
 	size_t size = sizeof(struct selinux_mapping);
 	security_class_t i, j;
 	unsigned k;
+	bool print_unknown_handle = false;
+	bool reject = (security_reject_unknown() == 1);
+	bool deny = (security_deny_unknown() == 1);
 
 	free(current_mapping);
 	current_mapping = NULL;
@@ -62,8 +67,16 @@ selinux_set_mapping(struct security_class_mapping *map)
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
@@ -74,13 +87,24 @@ selinux_set_mapping(struct security_class_mapping *map)
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
@@ -181,30 +205,49 @@ map_perm(security_class_t tclass, access_vector_t kperm)
 }
 
 void
-map_decision(security_class_t tclass, struct av_decision *avd)
+map_decision(security_class_t tclass, struct av_decision *avd,
+	     bool allow_unknown)
 {
 	if (tclass < current_mapping_size) {
-		unsigned i;
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
diff --git a/libselinux/src/mapping.h b/libselinux/src/mapping.h
index 22a4ccaf..12ebb89f 100644
--- a/libselinux/src/mapping.h
+++ b/libselinux/src/mapping.h
@@ -7,6 +7,7 @@
 #define _SELINUX_MAPPING_H_
 
 #include <selinux/selinux.h>
+#include <stdbool.h>
 
 /*
  * Get real, kernel values from mapped values
@@ -29,6 +30,7 @@ extern access_vector_t
 map_perm(security_class_t tclass, access_vector_t kperm);
 
 extern void
-map_decision(security_class_t tclass, struct av_decision *avd);
+map_decision(security_class_t tclass, struct av_decision *avd,
+	     bool allow_unknown);
 
 #endif				/* _SELINUX_MAPPING_H_ */
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

