Return-Path: <SRS0=c9VK=PQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5659FC43387
	for <selinux@archiver.kernel.org>; Tue,  8 Jan 2019 13:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1450A206BB
	for <selinux@archiver.kernel.org>; Tue,  8 Jan 2019 13:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ptde2qnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfAHNqV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:46:21 -0500
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:12793 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfAHNqV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jan 2019 08:46:21 -0500
X-EEMSG-check-017: 190820184|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jan 2019 13:46:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1546955178; x=1578491178;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uCTUNSUF6+y5NnYmx2jjiM4+p8+7Qn203urRZFR/5TY=;
  b=ptde2qnCpTJMSZV/ptnhllylE+7DWyaQws5eTq9TVXGJs6HSI2nUPdec
   1YmhvEBVs2wPfAOdM6FMZlYyBmJfIdTpnHwHZOiI5sDKKXz3pwBJ4B+zs
   mdim0Xj3Ns5VRoWM+MM+LSdb5E3tLbQHRwe4CoMqF3Tfj3D9cdMXEC/+Q
   6Ajn2nl0dhFGDwWqb/hSNi7/EkzxPUVI5M9q4oYwGzBdOuXyFwc/XU/3c
   VXD9/M6RGWwQxggHkWiApkfyzGJajXKAwg/QP7rDwHGWJuPuU4x894u/p
   Z0aXjL6fcrWm6qgH6n4TnrTSFEJzAD2RDiFBAoxXhg7LIA9dzc5YaK9bs
   w==;
X-IronPort-AV: E=Sophos;i="5.56,454,1539648000"; 
   d="scan'208";a="19310880"
IronPort-PHdr: =?us-ascii?q?9a23=3A+k9KehERr61/wLoZWEoHdp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ78oMmwAkXT6L1XgUPTWs2DsrQY07qQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDmwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/Vj?=
 =?us-ascii?q?q476dvVRTmliEJOTAk+23Tk8B8kb5XrBenqhdiwYDbfZuVOeJ+cK3DYN0US2?=
 =?us-ascii?q?lPUMFeWCJOGY6wc4gCAvAdMetCs4Xxu10Dpga+Cwm2A+PvzydFiGLq3aIky+?=
 =?us-ascii?q?QhER/J3Ao9FNwTtXTbttH1NKMMXuG10aLFyi7DYO5N2Trm9IjJcgwuofGLXb?=
 =?us-ascii?q?5qd8rR0lMgGxnKjlWXt4zoJjWY3fkDvWic6upvT+Ovi2g/pgF+oziv2scsip?=
 =?us-ascii?q?TSiY4P1l/E8iB5zYAoLtO7UE52ecOoHZRfui2AN4Z6X9kuT39ntSok0LEKpJ?=
 =?us-ascii?q?i2dzUQxps93R7QcfmHfpCN4hLkSemePy91hGlgeLKjnxay9lWgyvHkWsm0zl?=
 =?us-ascii?q?lKqi1Fn8HQtn8XzRzT69WHSuBn8ke92TeAywDT6uZeLUAyiaXbMIIuzqQ1lp?=
 =?us-ascii?q?oStUTPBi72mEPog6+Kbkgo5+el5uv9brjmu5OQLZF4hw7gPqg0h8CzGeE4PR?=
 =?us-ascii?q?IPX2if9+S8zrrj/UjhTbVRk/I2ibLUsIzaJMsHpq65BBVZ0oA46xmlFTum39?=
 =?us-ascii?q?MYnWcfIFJfZB2Hl5TpO03JIP3gFvewnVCskDZtx/DbMbzsGYvNLnfdn7f7Z7?=
 =?us-ascii?q?p96FBTyBA1zd9B45JYELYBIOj8Why5iNuNFRI9Mgqp0875B9hnkIATQ2SCBu?=
 =?us-ascii?q?meKqyBn0WP47cUP+SUZIIT8A34Ivwh6u+m2WQ1gncBbKKp2t0Rc3n+EfN4dR?=
 =?us-ascii?q?bKKUHwi8sMRD9Z9jE1S/bn3RjbCTM=3D?=
X-IPAS-Result: =?us-ascii?q?A2CkAgDqqDRc/wHyM5BiHQEBBQEHBQGBVAUBCwGBWilmT?=
 =?us-ascii?q?zMnmAVMAQEBAQEBBophiUKGfSAQCAGDekaCFCI3Bg0BAwEBAQEBAQIBbBwMg?=
 =?us-ascii?q?jopgxULAUaBUYJjPwGBdA0PqCEzhC0BgROEZwWHfoRBF3iBB4ERhGaBSgKHQ?=
 =?us-ascii?q?AKJT4YegQCQegmHGIpUDBiRdS2ORY04IkKBFCsIAhgIIQ+DJ4InFxODOIpxI?=
 =?us-ascii?q?QMwgQUBAYoVAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Jan 2019 13:46:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x08DkGYJ028921;
        Tue, 8 Jan 2019 08:46:16 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     jwcart2@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] libsemanage: set selinux policy root around calls to selinux_boolean_sub
Date:   Tue,  8 Jan 2019 08:48:22 -0500
Message-Id: <20190108134822.13184-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As reported in #109, semodule -p /path/to/policyroot -s minimum -n -B
tries to use /etc/selinux/targeted/booleans.subs_dist.  This is because
it invokes the libselinux selinux_boolean_sub() interface, which uses
the active/installed policy files rather than the libsemanage ones.

Switch the selinux policy root around the selinux_boolean_sub() call
to incorporate the semanage root as a prefix and to use the specified
policy store as a suffix so that the correct booleans.subs_dist file
(if any) is used.

The underlying bug is that booleans.subs_dist is not itself managed
via libsemanage. If it was managed and therefore lived within the
policy store, then libsemanage could access the appropriate
booleans.subs_dist file without using the libselinux interface at all,
and thus would not need to modify the selinux policy root.  Moving
booleans.subs_dist to a managed file is deferred to a future change.

Test:
dnf install selinux-policy-minimum selinux-policy-targeted
cd / && tar cf - etc/selinux var/lib/selinux | (cd ~/policy-root; tar xvpf -)
strace semodule -p ~/policy-root -s minimum -n -B

Before:
openat(AT_FDCWD, "/etc/selinux/targeted/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5

After:
openat(AT_FDCWD, "/home/sds/policy-root/etc/selinux/minimum/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5

Fixes https://github.com/SELinuxProject/selinux/issues/109

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 skips setting of the policy root if they already match, introduces a
hidden prototype and definition for internal callers of semanage_root(),
and tests that selinux_policy_root() is non-NULL before strdup'ing it.
 libsemanage/src/boolean_record.c  | 54 +++++++++++++++++++++++++++++--
 libsemanage/src/handle.c          |  2 ++
 libsemanage/src/handle_internal.h |  9 +++---
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/libsemanage/src/boolean_record.c b/libsemanage/src/boolean_record.c
index 665c0223..c234094e 100644
--- a/libsemanage/src/boolean_record.c
+++ b/libsemanage/src/boolean_record.c
@@ -6,7 +6,9 @@
  * Implements: record_key_t (Database Record Key)
  */
 
+#include <string.h>
 #include <sepol/boolean_record.h>
+#include "handle_internal.h"
 
 typedef sepol_bool_t semanage_bool_t;
 typedef sepol_bool_key_t semanage_bool_key_t;
@@ -84,10 +86,58 @@ hidden_def(semanage_bool_get_name)
 int semanage_bool_set_name(semanage_handle_t * handle,
 			   semanage_bool_t * boolean, const char *name)
 {
-	int rc;
-	char *subname = selinux_boolean_sub(name);
+	int rc = -1;
+	const char *prefix = semanage_root();
+	const char *storename = handle->conf->store_path;
+	const char *selinux_root = selinux_policy_root();
+	char *oldroot;
+	char *olddir;
+	char *subname = NULL;
+	char *newroot = NULL;
+	char *end;
+
+	if (!selinux_root)
+		return -1;
+
+	oldroot = strdup(selinux_root);
+	if (!oldroot)
+		return -1;
+	olddir = strdup(oldroot);
+	if (!olddir)
+		goto out;
+	end = strrchr(olddir, '/');
+	if (!end)
+		goto out;
+	end++;
+	*end = '\0';
+	rc = asprintf(&newroot, "%s%s%s", prefix, olddir, storename);
+	if (rc < 0)
+		goto out;
+
+	if (strcmp(oldroot, newroot)) {
+		rc = selinux_set_policy_root(newroot);
+		if (rc)
+			goto out;
+	}
+
+	subname = selinux_boolean_sub(name);
+	if (!subname) {
+		rc = -1;
+		goto out;
+	}
+
+	if (strcmp(oldroot, newroot)) {
+		rc = selinux_set_policy_root(oldroot);
+		if (rc)
+			goto out;
+	}
+
 	rc = sepol_bool_set_name(handle->sepolh, boolean, subname);
+out:
 	free(subname);
+	free(oldroot);
+	free(olddir);
+	free(newroot);
 	return rc;
 }
 
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index a6567bd4..e5109aef 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -58,6 +58,8 @@ const char * semanage_root(void)
 	return private_semanage_root;
 }
 
+hidden_def(semanage_root);
+
 semanage_handle_t *semanage_handle_create(void)
 {
 	semanage_handle_t *sh = NULL;
diff --git a/libsemanage/src/handle_internal.h b/libsemanage/src/handle_internal.h
index 66ce2708..d4b4d9c7 100644
--- a/libsemanage/src/handle_internal.h
+++ b/libsemanage/src/handle_internal.h
@@ -5,8 +5,9 @@
 #include "dso.h"
 
 hidden_proto(semanage_begin_transaction)
-    hidden_proto(semanage_handle_destroy)
-    hidden_proto(semanage_reload_policy)
-    hidden_proto(semanage_access_check)
-    hidden_proto(semanage_set_root)
+hidden_proto(semanage_handle_destroy)
+hidden_proto(semanage_reload_policy)
+hidden_proto(semanage_access_check)
+hidden_proto(semanage_set_root)
+hidden_proto(semanage_root)
 #endif
-- 
2.20.1

