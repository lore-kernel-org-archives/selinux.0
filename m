Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C75CC433F5
	for <selinux@archiver.kernel.org>; Tue,  1 Mar 2022 17:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiCARzV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiCARzU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Mar 2022 12:55:20 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6AF38D8F
        for <selinux@vger.kernel.org>; Tue,  1 Mar 2022 09:54:38 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id d84so13525986qke.8
        for <selinux@vger.kernel.org>; Tue, 01 Mar 2022 09:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bG8PGCTb9G1VKb39yybGw3y6xGk7AdaQ3Mf3kTMrsY4=;
        b=IwJQw7oyvjGGO1o4q9fpvRcMrj7ud8fmDYOor5YozwpI9Qr18Gi448ippMECDUICg+
         u/b9g3oKPmJzIk2+E7lBivMRnxKykWZT68dPdbmA/52D3fKk2zUyKUFsJr4tIvc3aXbb
         UP3MIu5GG+IhbivpudtXC6JPD3/aazFWzpecnjF79Na+0+ahKvjxp8vE+y1CX0AO9uM3
         V9gpoN1ow30mex69oCdNRC8dmAPCjYpjY3evGfg+z5K8s8v02/0lAc0r7UYYMTBOQoAN
         V55P2SnZL/E1VwLxkWP8dO2yJk8qH5f3Uo9DsDLduImwRlf0w2fyymKCHUYr1TyjDG69
         Mshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=bG8PGCTb9G1VKb39yybGw3y6xGk7AdaQ3Mf3kTMrsY4=;
        b=A7ZIRzYvOyH2xYC2tF3QrR0/lPoptjGHOJOL3yIZRXXk3W4D4SYUiwAAc4YP8oHh1+
         wvQ+2PxkzNg7Bh3N+YVC6Nm1QubpeYyPr0uzCfwVbDbMpjUCa8soWEvxxFUuMQcit8kr
         ReJoUvoJmlgiq3W+Vb6lnsMXyEJmLNBsNOO07ZtaXJtbmUV6NmfU5Yo9/ZTTPpGtnx3n
         9xU8rb3HiOLwRC3a3P8d7XUNlAJkG3qODMrQzQXhm/w1O3SFZYYa8NP4BgjI7iQByRp0
         C5DmOwZWMjsEhyMi/U2CeS0lc6Uo6cpgFyoF2c+237c3At4kE81iHXURl55x5FQBRolS
         aUPw==
X-Gm-Message-State: AOAM530rZQ//dfeCY/lpkMhJebC8m2ZVP4FPAhowFrtNguwzQJdpZD2T
        Aw9bTONooiWHmfROdbP3Mkw4B1tO9o0c
X-Google-Smtp-Source: ABdhPJyDn5kj7IMyIfZhLHiVJ+R+PLl2sIi2k/BEuUYfjY88k+pOpq7CNAGw8CIHejpzxTg58QdU+w==
X-Received: by 2002:a05:620a:7e7:b0:646:92cd:5bf5 with SMTP id k7-20020a05620a07e700b0064692cd5bf5mr14531488qkk.383.1646157277350;
        Tue, 01 Mar 2022 09:54:37 -0800 (PST)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id t28-20020a05620a005c00b00662fb1899d2sm3441948qkt.0.2022.03.01.09.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 09:54:36 -0800 (PST)
Subject: [PATCH] selinux: shorten the policy capability enum names
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Tue, 01 Mar 2022 12:54:36 -0500
Message-ID: <164615727605.32677.11271643808590060552.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The SELinux policy capability enum names are rather long and follow
the "POLICYDB_CAPABILITY_XXX format".  While the "POLICYDB_" prefix
is helpful in tying the enums to other SELinux policy constants,
macros, etc. there is no reason why we need to spell out
"CAPABILITY" completely.  Shorten "CAPABILITY" to "CAP" in order to
make things a bit shorter and cleaner.

Moving forward, the SELinux policy capability enum names should
follow the "POLICYDB_CAP_XXX" format.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ima.c                     |    4 ++--
 security/selinux/include/policycap.h       |   22 +++++++++++-----------
 security/selinux/include/policycap_names.h |    2 +-
 security/selinux/include/security.h        |   18 +++++++++---------
 security/selinux/selinuxfs.c               |    2 +-
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index 727c4e43219d..fded01981a39 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -29,7 +29,7 @@ static char *selinux_ima_collect_state(struct selinux_state *state)
 	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
 
 	len = strlen(on);
-	for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++)
+	for (i = 0; i < __POLICYDB_CAP_MAX; i++)
 		buf_len += strlen(selinux_policycap_names[i]) + len;
 
 	buf = kzalloc(buf_len, GFP_KERNEL);
@@ -54,7 +54,7 @@ static char *selinux_ima_collect_state(struct selinux_state *state)
 	rc = strlcat(buf, checkreqprot_get(state) ? on : off, buf_len);
 	WARN_ON(rc >= buf_len);
 
-	for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
+	for (i = 0; i < __POLICYDB_CAP_MAX; i++) {
 		rc = strlcat(buf, selinux_policycap_names[i], buf_len);
 		WARN_ON(rc >= buf_len);
 
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index a9e572ca4fd9..2680aa21205c 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -4,18 +4,18 @@
 
 /* Policy capabilities */
 enum {
-	POLICYDB_CAPABILITY_NETPEER,
-	POLICYDB_CAPABILITY_OPENPERM,
-	POLICYDB_CAPABILITY_EXTSOCKCLASS,
-	POLICYDB_CAPABILITY_ALWAYSNETWORK,
-	POLICYDB_CAPABILITY_CGROUPSECLABEL,
-	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
-	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
-	POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC,
-	__POLICYDB_CAPABILITY_MAX
+	POLICYDB_CAP_NETPEER,
+	POLICYDB_CAP_OPENPERM,
+	POLICYDB_CAP_EXTSOCKCLASS,
+	POLICYDB_CAP_ALWAYSNETWORK,
+	POLICYDB_CAP_CGROUPSECLABEL,
+	POLICYDB_CAP_NNP_NOSUID_TRANSITION,
+	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
+	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
+	__POLICYDB_CAP_MAX
 };
-#define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
+#define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
 
-extern const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
+extern const char *selinux_policycap_names[__POLICYDB_CAP_MAX];
 
 #endif /* _SELINUX_POLICYCAP_H_ */
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index ebd64afe1def..100da7d043db 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -5,7 +5,7 @@
 #include "policycap.h"
 
 /* Policy capability names */
-const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
+const char *selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"network_peer_controls",
 	"open_perms",
 	"extended_socket_class",
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 84f42fa8012f..ace4bd13e808 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -96,7 +96,7 @@ struct selinux_state {
 #endif
 	bool checkreqprot;
 	bool initialized;
-	bool policycap[__POLICYDB_CAPABILITY_MAX];
+	bool policycap[__POLICYDB_CAP_MAX];
 
 	struct page *status_page;
 	struct mutex status_lock;
@@ -174,56 +174,56 @@ static inline bool selinux_policycap_netpeer(void)
 {
 	struct selinux_state *state = &selinux_state;
 
-	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_NETPEER]);
+	return READ_ONCE(state->policycap[POLICYDB_CAP_NETPEER]);
 }
 
 static inline bool selinux_policycap_openperm(void)
 {
 	struct selinux_state *state = &selinux_state;
 
-	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_OPENPERM]);
+	return READ_ONCE(state->policycap[POLICYDB_CAP_OPENPERM]);
 }
 
 static inline bool selinux_policycap_extsockclass(void)
 {
 	struct selinux_state *state = &selinux_state;
 
-	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_EXTSOCKCLASS]);
+	return READ_ONCE(state->policycap[POLICYDB_CAP_EXTSOCKCLASS]);
 }
 
 static inline bool selinux_policycap_alwaysnetwork(void)
 {
 	struct selinux_state *state = &selinux_state;
 
-	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_ALWAYSNETWORK]);
+	return READ_ONCE(state->policycap[POLICYDB_CAP_ALWAYSNETWORK]);
 }
 
 static inline bool selinux_policycap_cgroupseclabel(void)
 {
 	struct selinux_state *state = &selinux_state;
 
-	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_CGROUPSECLABEL]);
+	return READ_ONCE(state->policycap[POLICYDB_CAP_CGROUPSECLABEL]);
 }
 
 static inline bool selinux_policycap_nnp_nosuid_transition(void)
 {
 	struct selinux_state *state = &selinux_state;
 
-	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION]);
+	return READ_ONCE(state->policycap[POLICYDB_CAP_NNP_NOSUID_TRANSITION]);
 }
 
 static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 {
 	struct selinux_state *state = &selinux_state;
 
-	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS]);
+	return READ_ONCE(state->policycap[POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]);
 }
 
 static inline bool selinux_policycap_ioctl_skip_cloexec(void)
 {
 	struct selinux_state *state = &selinux_state;
 
-	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC]);
+	return READ_ONCE(state->policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
 }
 
 struct selinux_policy_convert_data;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f2f6203e0fff..097c6d866ec4 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1983,7 +1983,7 @@ static int sel_make_policycap(struct selinux_fs_info *fsi)
 	struct dentry *dentry = NULL;
 	struct inode *inode = NULL;
 
-	for (iter = 0; iter <= POLICYDB_CAPABILITY_MAX; iter++) {
+	for (iter = 0; iter <= POLICYDB_CAP_MAX; iter++) {
 		if (iter < ARRAY_SIZE(selinux_policycap_names))
 			dentry = d_alloc_name(fsi->policycap_dir,
 					      selinux_policycap_names[iter]);

