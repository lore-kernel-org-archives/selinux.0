Return-Path: <SRS0=WW+a=AZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D95C433E3
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 20:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0079420657
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 20:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="RNwEhzeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGNU3s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgGNU3s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jul 2020 16:29:48 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C06C061755
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 13:29:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 6so13961749qtt.0
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 13:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ly1gHLo5HvX5ph1X7e39iRbi0Z899otuMlWttGnBZ1g=;
        b=RNwEhzeuthbYjenahcxQ61YhPZ781k941GVKunx2OCrKwiuG1Ih/x61ZvbkEuQTVwX
         3kGOUy+xjcGduEjqCdWhMK0eymRzPhvxXx4cMrx1Fta9UqRuo8Fk6M6mptuU/a9Jdsa7
         lrfMR0cCUO6vjySgTXlpUX6hzEbplFhKXGxk1Hyycabu2TMwMtRFOCwVBXFiBsmzWyTr
         YmiAcbW4V4oiB4CtSFnAYN8wXbA/CElCPIKp6faMcBruRO8AN/VKV8C1Hy6B/XLYtKP1
         bhpeiaTLvxKrV4mjhSTPxp5QGF4e3aKbbHef9jhgR9b5r4D5dG4bLW1n2qMPGjlzUJtl
         9PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ly1gHLo5HvX5ph1X7e39iRbi0Z899otuMlWttGnBZ1g=;
        b=hUQnNsOCjx6mgqzU3qfKOLIP43OIxU06DQifnrutd37/cqzsCfP9dQf05VAzwrrw07
         1cqIa35751DvLLxBw9+2b5CbM7KQhuBA37YCkDG66qF3hVgNQ4GsE/ulL+legybjr3/u
         7oMhgOaL34BD2MOv2XjOW8LEYWGngKOQfs5PMZKBa7uExyPDel+iE1UGHMVanlu+4Gve
         bFpJeJsVYXM9gBty9XEbkEvczBLNKws/MnNkBQmupA/ZnxlaIfZaUzAfS1jyPTftDbPZ
         o6wfs+jGTm+fe0t8oxvJX33wp85YFqHAdJtANW7n1wjFxubIKvot3YFKTh5g2ftkH+S1
         608A==
X-Gm-Message-State: AOAM530Z9mNA60kGw0j+rkVDORap3YowzC7zZu/2Ml7DETQ4XOCCUiXJ
        cgjmABpn2TGSxu43DgvCSnEsHsjjJAZPWA==
X-Google-Smtp-Source: ABdhPJx6l44JIzLA+H7zk7UAHJYTgvfU00vkFe0BfUee9TZyzH1FCVKBtVKVvalm6roOxcV5AF66Cg==
X-Received: by 2002:ac8:46d6:: with SMTP id h22mr6616371qto.296.1594758586519;
        Tue, 14 Jul 2020 13:29:46 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-100-181.hsd1.md.comcast.net. [69.250.100.181])
        by smtp.gmail.com with ESMTPSA id a25sm111009qtk.40.2020.07.14.13.29.45
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 13:29:45 -0700 (PDT)
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: Use sestatus if open
Date:   Tue, 14 Jul 2020 16:29:33 -0400
Message-Id: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
/selinux/status") introduced the selinux_status page mechanism, which
allows for mmap()'ing of selinux status state as a replacement for
avc_netlink.

The mechanism was initially intended for use by userspace object
managers which were calculating access decisions in-tree and did not
rely on the libselinux AVC implementation. In order to properly make use
of sestatus within avc_has_perm, the status mechanism needs to properly
set avc internals during status events; else, avc_enforcing is never
updated upon sestatus changes.

This commit moves the netlink notice logic out into convenience
functions, which are then called by the sestatus code. Since sestatus
uses netlink as a fallback, we can change the avc_netlink_check_nb()
call in avc_has_perm_noaudit to check the status page if it is
available. If it is not, we fall back to

Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
---
 libselinux/src/avc.c          |  2 +-
 libselinux/src/avc_internal.c | 71 ++++++++++++++++++++++-------------
 libselinux/src/avc_internal.h |  4 ++
 libselinux/src/sestatus.c     | 18 +++++++--
 4 files changed, 65 insertions(+), 30 deletions(-)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index b4648b2d..1fceac20 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -766,7 +766,7 @@ int avc_has_perm_noaudit(security_id_t ssid,
 		avd_init(avd);
 
 	if (!avc_using_threads && !avc_app_main_loop) {
-		(void)avc_netlink_check_nb();
+		(void)selinux_status_updated();
 	}
 
 	if (!aeref) {
diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 568a3d92..aee01a8a 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -53,6 +53,49 @@ int avc_enforcing = 1;
 int avc_setenforce = 0;
 int avc_netlink_trouble = 0;
 
+/* process setenforce events for netlink and sestatus */
+int avc_process_setenforce(int enforcing)
+{
+	int rc = 0;
+
+	avc_log(SELINUX_INFO,
+		"%s:  received setenforce notice (enforcing=%d)\n",
+		avc_prefix, enforcing);
+	if (avc_setenforce)
+		goto out;
+	avc_enforcing = enforcing;
+	if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
+		avc_log(SELINUX_ERROR,
+			"%s:  cache reset returned %d (errno %d)\n",
+			avc_prefix, rc, errno);
+		return rc;
+	}
+
+out:
+	return selinux_netlink_setenforce(enforcing);
+}
+
+/* process policyload events for netlink and sestatus */
+int avc_process_policyload(uint32_t seqno)
+{
+	int rc = 0;
+
+	avc_log(SELINUX_INFO,
+		"%s:  received policyload notice (seqno=%u)\n",
+		avc_prefix, seqno);
+	rc = avc_ss_reset(seqno);
+	if (rc < 0) {
+		avc_log(SELINUX_ERROR,
+			"%s:  cache reset returned %d (errno %d)\n",
+			avc_prefix, rc, errno);
+		return rc;
+	}
+
+	selinux_flush_class_cache();
+
+	return selinux_netlink_policyload(seqno);
+}
+
 /* netlink socket code */
 static int fd = -1;
 
@@ -177,20 +220,7 @@ static int avc_netlink_process(void *buf)
 
 	case SELNL_MSG_SETENFORCE:{
 		struct selnl_msg_setenforce *msg = NLMSG_DATA(nlh);
-		msg->val = !!msg->val;
-		avc_log(SELINUX_INFO,
-			"%s:  received setenforce notice (enforcing=%d)\n",
-			avc_prefix, msg->val);
-		if (avc_setenforce)
-			break;
-		avc_enforcing = msg->val;
-		if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
-			avc_log(SELINUX_ERROR,
-				"%s:  cache reset returned %d (errno %d)\n",
-				avc_prefix, rc, errno);
-			return rc;
-		}
-		rc = selinux_netlink_setenforce(msg->val);
+		rc = avc_process_setenforce(!!msg->val);
 		if (rc < 0)
 			return rc;
 		break;
@@ -198,18 +228,7 @@ static int avc_netlink_process(void *buf)
 
 	case SELNL_MSG_POLICYLOAD:{
 		struct selnl_msg_policyload *msg = NLMSG_DATA(nlh);
-		avc_log(SELINUX_INFO,
-			"%s:  received policyload notice (seqno=%u)\n",
-			avc_prefix, msg->seqno);
-		rc = avc_ss_reset(msg->seqno);
-		if (rc < 0) {
-			avc_log(SELINUX_ERROR,
-				"%s:  cache reset returned %d (errno %d)\n",
-				avc_prefix, rc, errno);
-			return rc;
-		}
-		selinux_flush_class_cache();
-		rc = selinux_netlink_policyload(msg->seqno);
+		rc = avc_process_policyload(msg->seqno);
 		if (rc < 0)
 			return rc;
 		break;
diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index 3f8a6bb1..da67affc 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -32,6 +32,10 @@ extern void (*avc_func_get_lock) (void *);
 extern void (*avc_func_release_lock) (void *);
 extern void (*avc_func_free_lock) (void *);
 
+/* selinux status processing for netlink and sestatus */
+extern int avc_process_setenforce(int enforcing);
+extern int avc_process_policyload(uint32_t seqno);
+
 static inline void set_callbacks(const struct avc_memory_callback *mem_cb,
 				 const struct avc_log_callback *log_cb,
 				 const struct avc_thread_callback *thread_cb,
diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index 86267ff8..4bd2086c 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -39,6 +39,7 @@ struct selinux_status_t
 static struct selinux_status_t *selinux_status = NULL;
 static int			selinux_status_fd;
 static uint32_t			last_seqno;
+static uint32_t			last_policyload;
 
 static uint32_t			fallback_sequence;
 static int			fallback_enforcing;
@@ -116,6 +117,15 @@ int selinux_status_updated(void)
 
 	if (last_seqno != curr_seqno)
 	{
+		if (avc_enforcing != !!selinux_status->enforcing) {
+			if (avc_process_setenforce(!!selinux_status->enforcing) < 0)
+				return -1;
+		}
+		if (last_policyload != selinux_status->policyload) {
+			if (avc_process_policyload(selinux_status->policyload) < 0)
+				return -1;
+			last_policyload = selinux_status->policyload;
+		}
 		last_seqno = curr_seqno;
 		result = 1;
 	}
@@ -131,7 +141,6 @@ int selinux_status_updated(void)
 int selinux_status_getenforce(void)
 {
 	uint32_t	seqno;
-	uint32_t	enforcing;
 
 	if (selinux_status == NULL) {
 		errno = EINVAL;
@@ -149,11 +158,11 @@ int selinux_status_getenforce(void)
 	do {
 		seqno = read_sequence(selinux_status);
 
-		enforcing = selinux_status->enforcing;
+		avc_enforcing = !!selinux_status->enforcing;
 
 	} while (seqno != read_sequence(selinux_status));
 
-	return enforcing ? 1 : 0;
+	return avc_enforcing;
 }
 
 /*
@@ -285,6 +294,9 @@ int selinux_status_open(int fallback)
 	return 0;
 
 error:
+	avc_log(SELINUX_WARNING,
+		"%s: could not open selinux status page: %d (%s)\n",
+		avc_prefix, errno, strerror(errno));
 	/*
 	 * If caller wants fallback routine, we try to provide
 	 * an equivalent functionality using existing netlink
-- 
2.27.0

