Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB777C433EF
	for <selinux@archiver.kernel.org>; Tue,  7 Jun 2022 18:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349390AbiFGSHk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 14:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350093AbiFGSAo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 14:00:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9057014A275
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 10:42:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h23so25610008ejj.12
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oiBX+N7jeOmedVooI0HTGYBk9+ijeeN65OwrH+rkuEU=;
        b=daOzXS76sYSMik4B3ODlkbi32bhSTzihP5hgD2eeseHRJLqgle2RK1PFV1zez6ygl2
         0bwDrVvgJXlPoEHjNypPY0J5t8Voe2l6ZiGcOiajl3EjJNDtpMKFPTlw71cud4SE0J46
         qcAbSk2T3dWGCscNU6nVmxEH+HVJxSubAqiaqvud8xcIcR0neEcpn9qNuliRpTT6nfhC
         z7+MbhnCnS+th7X2G2P79fAfJXMHcUiVo8nbfuK32E842DRpUFfpr1TL7v+e/MaHmcSh
         p94mUTw5D87RoraP91e+ovypSdZ5AMEqqYvGCoAvC/AEsyYOIE/ojvD5BCJMm1Vqpx4Y
         Nb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oiBX+N7jeOmedVooI0HTGYBk9+ijeeN65OwrH+rkuEU=;
        b=G8rNx8DLRcGQHj88xt8xN4Dw7gZCF248UTAElezfWWwoCunpItpAyD1YlXU9kZixD6
         T0iGrpdp2j4xx66+mjD18a0CDKeIQN9KI3qdXfqdtNDOV1kGyjb1+U9G7LzfngJXiN38
         flvya+XDgWs4PjY7BLM6B8gzYKpd44ZIfwAjLxAgNwUzlSX6zK22SkofipHlMTI7GC7q
         2WnjTqqmY852I5c6MWFcCwQdFqAhN9tfqLfJEr+d1722n9e5G1uGu8WmOE4q9+muoEfz
         5rCNu0PoLPmKqRwnKWpTQIhf4V7JfGdOgoHN/B/9L1Cg/kvStF4mT0mu/xM6nZwlNG16
         +puQ==
X-Gm-Message-State: AOAM533inUb3HFZ3MVpa9najXY0/JRZMO3ZNX77OjcMOK5hBGGABumeY
        175itZzIq1yD7p7ugRMCzMUoTKyBe2Y=
X-Google-Smtp-Source: ABdhPJyuibTKOC2IPhdwnDojb4uxvzlXDJ+FTfl+4/NM3IciD6UrILlo92+3ss6z8WcNMjf+/6jp0Q==
X-Received: by 2002:a17:907:9721:b0:70c:65e7:2aa5 with SMTP id jg33-20020a170907972100b0070c65e72aa5mr24520424ejc.132.1654623756674;
        Tue, 07 Jun 2022 10:42:36 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-054-039.77.8.pool.telefonica.de. [77.8.54.39])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906600900b006fec8e5b8a9sm7962591ejj.152.2022.06.07.10.42.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:42:36 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 1/3] libsepol: export initial SIDs
Date:   Tue,  7 Jun 2022 19:41:43 +0200
Message-Id: <20220607174145.51330-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Export initial SIDs, so they can be used for example in checkpolicy.

Add helper functions for name lookup.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/initialsids.h | 89 +++++++++++++++++++
 libsepol/include/sepol/policydb/policydb.h    |  2 +-
 libsepol/src/kernel_to_cil.c                  |  1 +
 libsepol/src/kernel_to_common.h               | 53 -----------
 libsepol/src/kernel_to_conf.c                 |  1 +
 libsepol/src/module_to_cil.c                  |  1 +
 6 files changed, 93 insertions(+), 54 deletions(-)
 create mode 100644 libsepol/include/sepol/policydb/initialsids.h

diff --git a/libsepol/include/sepol/policydb/initialsids.h b/libsepol/include/sepol/policydb/initialsids.h
new file mode 100644
index 00000000..7b2fe021
--- /dev/null
+++ b/libsepol/include/sepol/policydb/initialsids.h
@@ -0,0 +1,89 @@
+#ifndef _SEPOL_POLICYDB_INITIALSIDS_H_
+#define _SEPOL_POLICYDB_INITIALSIDS_H_
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+// initial sid names aren't actually stored in the pp files, need to a have
+// a mapping, taken from the linux kernel
+static const char * const selinux_sid_to_str[] = {
+	"null",
+	"kernel",
+	"security",
+	"unlabeled",
+	"fs",
+	"file",
+	"file_labels",
+	"init",
+	"any_socket",
+	"port",
+	"netif",
+	"netmsg",
+	"node",
+	"igmp_packet",
+	"icmp_socket",
+	"tcp_socket",
+	"sysctl_modprobe",
+	"sysctl",
+	"sysctl_fs",
+	"sysctl_kernel",
+	"sysctl_net",
+	"sysctl_net_unix",
+	"sysctl_vm",
+	"sysctl_dev",
+	"kmod",
+	"policy",
+	"scmp_packet",
+	"devnull",
+};
+
+#define SELINUX_SID_SZ (sizeof(selinux_sid_to_str)/sizeof(selinux_sid_to_str[0]))
+
+static inline unsigned int selinux_str_to_sid(const char *name)
+{
+	unsigned i;
+
+	for (i = 1; i < SELINUX_SID_SZ; i++) {
+		if (strcmp(name, selinux_sid_to_str[i]) == 0)
+			return i;
+	}
+
+	return 0;
+}
+
+static const char * const xen_sid_to_str[] = {
+	"null",
+	"xen",
+	"dom0",
+	"domio",
+	"domxen",
+	"unlabeled",
+	"security",
+	"ioport",
+	"iomem",
+	"irq",
+	"device",
+	"domU",
+	"domDM",
+};
+
+#define XEN_SID_SZ (sizeof(xen_sid_to_str)/sizeof(xen_sid_to_str[0]))
+
+static inline unsigned int xen_str_to_sid(const char *name)
+{
+	unsigned i;
+
+	for (i = 1; i < XEN_SID_SZ; i++) {
+		if (strcmp(name, xen_sid_to_str[i]) == 0)
+			return i;
+	}
+
+	return 0;
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif				/* _SEPOL_POLICYDB_INITIALSIDS_H_ */
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index de0068a6..2ce4da5d 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -340,7 +340,7 @@ typedef struct range_trans_rule {
  */
 typedef struct ocontext {
 	union {
-		char *name;	/* name of initial SID, fs, netif, fstype, path */
+		char *name;	/* name of initial SID (not saved in binary policy), fs, netif, fstype, path */
 		struct {
 			uint8_t protocol;
 			uint16_t low_port;
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 9128ac55..42251684 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -20,6 +20,7 @@
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/hashtab.h>
+#include <sepol/policydb/initialsids.h>
 #include <sepol/policydb/polcaps.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index 159c4289..5e8482bf 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -10,59 +10,6 @@
 #define DEFAULT_LEVEL "systemlow"
 #define DEFAULT_OBJECT "object_r"
 
-// initial sid names aren't actually stored in the pp files, need to a have
-// a mapping, taken from the linux kernel
-static const char * const selinux_sid_to_str[] = {
-	"null",
-	"kernel",
-	"security",
-	"unlabeled",
-	"fs",
-	"file",
-	"file_labels",
-	"init",
-	"any_socket",
-	"port",
-	"netif",
-	"netmsg",
-	"node",
-	"igmp_packet",
-	"icmp_socket",
-	"tcp_socket",
-	"sysctl_modprobe",
-	"sysctl",
-	"sysctl_fs",
-	"sysctl_kernel",
-	"sysctl_net",
-	"sysctl_net_unix",
-	"sysctl_vm",
-	"sysctl_dev",
-	"kmod",
-	"policy",
-	"scmp_packet",
-	"devnull",
-};
-
-#define SELINUX_SID_SZ (sizeof(selinux_sid_to_str)/sizeof(selinux_sid_to_str[0]))
-
-static const char * const xen_sid_to_str[] = {
-	"null",
-	"xen",
-	"dom0",
-	"domio",
-	"domxen",
-	"unlabeled",
-	"security",
-	"ioport",
-	"iomem",
-	"irq",
-	"device",
-	"domU",
-	"domDM",
-};
-
-#define XEN_SID_SZ (sizeof(xen_sid_to_str)/sizeof(xen_sid_to_str[0]))
-
 static const uint32_t avtab_flavors[] = {
 	AVTAB_ALLOWED,
 	AVTAB_AUDITALLOW,
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 63dffd9b..51a8270d 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -19,6 +19,7 @@
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/hashtab.h>
+#include <sepol/policydb/initialsids.h>
 #include <sepol/policydb/polcaps.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index b35bf055..1945b369 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -47,6 +47,7 @@
 #include <sepol/module_to_cil.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/hashtab.h>
+#include <sepol/policydb/initialsids.h>
 #include <sepol/policydb/polcaps.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
-- 
2.36.1

