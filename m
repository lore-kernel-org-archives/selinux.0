Return-Path: <SRS0=WW+a=AZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B86CC433E4
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 20:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2151020657
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 20:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="x6GjLKPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGNU3t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgGNU3t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jul 2020 16:29:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEBCC061755
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 13:29:49 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id u12so13896130qth.12
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ly1gHLo5HvX5ph1X7e39iRbi0Z899otuMlWttGnBZ1g=;
        b=x6GjLKPOyH1FdX1y1nMmkav4dweEVT6vJ68odUl7yeGivtgfUrDfrgtSzgPXh4jqq+
         G0EihMtWOcDZtLUup8c+rn62PYxoDW0lUwUku5hwVhQYvjaQXuBg+Z5/uEAt+orx0kHh
         EWSeNOZNmAYMJwxRKySi9sKmiARdIBJfE12unpP/lFFfBGU6HS1JCCFTX8spbZQfZuBx
         Wajpy7weIE7R5kXw/bRHpkRBRtpbr4KvQ3CzKaYHhKZlR/t/C+Fd59I8s8fcX3HBJROs
         AdEB3gmT+8lybFAJo7c+ukskjYV2WMzC8cmdG+CrbCUdxyBhopE5PGTEoEdQ4ZqY/6l5
         Tyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ly1gHLo5HvX5ph1X7e39iRbi0Z899otuMlWttGnBZ1g=;
        b=juuTKo0J0kb0bjzVAuSe8E75j5i7uv2f22FUdf4iAzxmYo2zvPeytRf4YOcX/iAGBN
         eE93zx7T+sappqQL2X+OS/faY8qdiZS5hrUDjm3jXJ2YCcwBQzGEgDQuUI7/BdkQaRFW
         eXoROvTnSXDu8PY0UrfERTh1vXC8efiYIRQZZjnljcmpQRYS8dlXPz6JXqzltU0EVgW8
         2TkDxTOkjxwzNoZxd2n8/K3r9I8Ys7TGG9azM/C9G9NtYoxSTUGnEctnE42jPxO6taN5
         Q/4ZR5aD9cj57VGZAn5Jg2WZd2r80+iORTGIOfsUk1VTOSXWRb3ZvZmfMfVTXw07bPF5
         GxeQ==
X-Gm-Message-State: AOAM532QtrEH/k/ih/04JBgEEK57J1QJ3Rq47ngXselmXmzPAawfHuun
        +hDKcoXp6KHS8XuPQ0df7oSJ0zGPflHdpA==
X-Google-Smtp-Source: ABdhPJygJCaop6lUj7yX+gxTsorN7xJuohAsi2DRs6XS6gGbZX/eDjOeNhW0zL0TP5BFSr9zozKGwg==
X-Received: by 2002:ac8:2f33:: with SMTP id j48mr6789604qta.157.1594758587985;
        Tue, 14 Jul 2020 13:29:47 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-100-181.hsd1.md.comcast.net. [69.250.100.181])
        by smtp.gmail.com with ESMTPSA id a25sm111009qtk.40.2020.07.14.13.29.46
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 13:29:47 -0700 (PDT)
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: Use sestatus if open
Date:   Tue, 14 Jul 2020 16:29:34 -0400
Message-Id: <20200714202934.42424-2-mike.palmiotto@crunchydata.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
References: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
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

