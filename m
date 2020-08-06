Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1778AC433DF
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 18:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6331A206B5
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 18:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjS2c5OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgHFSfy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbgHFSex (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 14:34:53 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE6C061A13
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 11:34:41 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e5so23083154qth.5
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gOcQo9I1luiRmUv0GS/aPmFOnQlx6Ae6SiphJ0gJOMM=;
        b=jjS2c5OFlT97mFBUM/vrYWMSnwUEf16TxcggOr/ftn96Thz50dhCIsmdSClntlAt+B
         6FrjVlXN8rz1ec9l4q9GUCP7q5VrF/6ayX7dHQEH78BZoL6f4FFRjasssCE/RXCIcD6d
         e0QLRRfEgXql/3aSjAhZMjBETkhyPryo/AkScoji7xHRgOSkNr6AcW84CkUpndq386Dv
         MJec0obXN5lBjTj4X6+KwQsN4nLlnfRUk6Q6aGc7uo9WHBaUllDRlUyPrar3fciBQ+Dz
         yPW/BdP3D0bceokOkDGuA9LNH5dXLWrA9n8LjPG9dSn37jGz5sDbsvEgChW4NbRt7dn6
         6BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gOcQo9I1luiRmUv0GS/aPmFOnQlx6Ae6SiphJ0gJOMM=;
        b=LMEL0DfcTyDShV7EA7FL+e6x3dVoJyzqVWh/0OoPDaUs7+2Kle4ge71NvtS3XFMzCe
         c2S0Un9HcsOt2MsZv7m3UgObBwF1n62unUavPpLg1thjqBaiWXiBMqMe3r5eshuEklbf
         +7PzUO8UHn2VzBHjMu/CWSnW3HCixW9dhSoTOYvJ5T8f93TWdX/DLwt/w9dZ5VkaFD4g
         OyrsWKMpnFJ2Hp2gecCOyiG1CO7/rYGsIin+8kQ961Gv50fr36UMJqNtwSpMmQEvnP9Y
         DqOjruvb/vVyNe77bBKSVLjEbT3/g+OlGW3OkYCsurtXUl+c0XgUyWZkn0v/8vBewJWK
         YvXw==
X-Gm-Message-State: AOAM533ZxVcsUA/XK2QZUk9NZsebztexELsSJQk47RquIGMTHSRetoQ8
        1eB4Oyn1zBql42U4nsksUDs=
X-Google-Smtp-Source: ABdhPJyFD7OCJYxNJbn+8RcNitEH7EAybmU7VKn5bs8h6G8A9it2kv3gz10yQ9V2xy8QNDhE4ZieUw==
X-Received: by 2002:aed:36c7:: with SMTP id f65mr10582595qtb.39.1596738880691;
        Thu, 06 Aug 2020 11:34:40 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id q7sm4849239qkf.35.2020.08.06.11.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:34:40 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] scripts/selinux,selinux: update mdp to enable policy capabilities
Date:   Thu,  6 Aug 2020 14:34:18 -0400
Message-Id: <20200806183418.50128-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Presently mdp does not enable any SELinux policy capabilities
in the dummy policy it generates. Thus, policies derived from
it will by default lack various features commonly used in modern
policies such as open permission, extended socket classes, network
peer controls, etc.  Split the policy capability definitions out into
their own headers so that we can include them into mdp without pulling in
other kernel headers and extend mdp generate policycap statements for the
policy capabilities known to the kernel.  Policy authors may wish to
selectively remove some of these from the generated policy.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 scripts/selinux/mdp/mdp.c                  |  7 +++++++
 security/selinux/include/policycap.h       | 20 ++++++++++++++++++++
 security/selinux/include/policycap_names.h | 18 ++++++++++++++++++
 security/selinux/include/security.h        | 16 +---------------
 security/selinux/ss/services.c             | 12 +-----------
 5 files changed, 47 insertions(+), 26 deletions(-)
 create mode 100644 security/selinux/include/policycap.h
 create mode 100644 security/selinux/include/policycap_names.h

diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index 6ceb88eb9b59..105c1c31a316 100644
--- a/scripts/selinux/mdp/mdp.c
+++ b/scripts/selinux/mdp/mdp.c
@@ -35,6 +35,9 @@ struct security_class_mapping {
 
 #include "classmap.h"
 #include "initial_sid_to_string.h"
+#include "policycap_names.h"
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 
 int main(int argc, char *argv[])
 {
@@ -115,6 +118,10 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	/* enable all policy capabilities */
+	for (i = 0; i < ARRAY_SIZE(selinux_policycap_names); i++)
+		fprintf(fout, "policycap %s;\n", selinux_policycap_names[i]);
+
 	/* types, roles, and allows */
 	fprintf(fout, "type base_t;\n");
 	fprintf(fout, "role base_r;\n");
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
new file mode 100644
index 000000000000..2ec038efbb03
--- /dev/null
+++ b/security/selinux/include/policycap.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SELINUX_POLICYCAP_H_
+#define _SELINUX_POLICYCAP_H_
+
+/* Policy capabilities */
+enum {
+	POLICYDB_CAPABILITY_NETPEER,
+	POLICYDB_CAPABILITY_OPENPERM,
+	POLICYDB_CAPABILITY_EXTSOCKCLASS,
+	POLICYDB_CAPABILITY_ALWAYSNETWORK,
+	POLICYDB_CAPABILITY_CGROUPSECLABEL,
+	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
+	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
+	__POLICYDB_CAPABILITY_MAX
+};
+#define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
+
+extern const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
+
+#endif /* _SELINUX_POLICYCAP_H_ */
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
new file mode 100644
index 000000000000..b89289f092c9
--- /dev/null
+++ b/security/selinux/include/policycap_names.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SELINUX_POLICYCAP_NAMES_H_
+#define _SELINUX_POLICYCAP_NAMES_H_
+
+#include "policycap.h"
+
+/* Policy capability names */
+const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
+	"network_peer_controls",
+	"open_perms",
+	"extended_socket_class",
+	"always_check_network",
+	"cgroup_seclabel",
+	"nnp_nosuid_transition",
+	"genfs_seclabel_symlinks"
+};
+
+#endif /* _SELINUX_POLICYCAP_NAMES_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 7fa67bfb2f9f..c68ed2beadff 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -16,6 +16,7 @@
 #include <linux/refcount.h>
 #include <linux/workqueue.h>
 #include "flask.h"
+#include "policycap.h"
 
 #define SECSID_NULL			0x00000000 /* unspecified SID */
 #define SECSID_WILD			0xffffffff /* wildcard SID */
@@ -72,21 +73,6 @@ struct netlbl_lsm_secattr;
 
 extern int selinux_enabled_boot;
 
-/* Policy capabilities */
-enum {
-	POLICYDB_CAPABILITY_NETPEER,
-	POLICYDB_CAPABILITY_OPENPERM,
-	POLICYDB_CAPABILITY_EXTSOCKCLASS,
-	POLICYDB_CAPABILITY_ALWAYSNETWORK,
-	POLICYDB_CAPABILITY_CGROUPSECLABEL,
-	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
-	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
-	__POLICYDB_CAPABILITY_MAX
-};
-#define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
-
-extern const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
-
 /*
  * type_datum properties
  * available at the kernel policy version >= POLICYDB_VERSION_BOUNDARY
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 937cb0805dc6..394fda88c374 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -64,17 +64,7 @@
 #include "xfrm.h"
 #include "ebitmap.h"
 #include "audit.h"
-
-/* Policy capability names */
-const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
-	"network_peer_controls",
-	"open_perms",
-	"extended_socket_class",
-	"always_check_network",
-	"cgroup_seclabel",
-	"nnp_nosuid_transition",
-	"genfs_seclabel_symlinks"
-};
+#include "policycap_names.h"
 
 static struct selinux_ss selinux_ss;
 
-- 
2.25.1

