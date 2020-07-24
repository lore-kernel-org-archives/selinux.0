Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B84AC433E1
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 14:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0894D2063A
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 14:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="I4fbwsem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGXOOJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgGXOOJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 10:14:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68763C0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 07:14:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 2so4599610qkf.10
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dt82aF1wjXqY0oqezwUaavlJN9LxnRwGSZy6Lb8kItY=;
        b=I4fbwsemVWIplfikGFivmmd2eimYsdY2tS/HthnzBeZnYU1Y0g6Xj6tk6Fnz5fMuf3
         zt72mlFRDcfSi63WgLuPmLGayhedNMZKSEe5rjVu/B0EuGY1JvhgdBYNvVhuGGpnxk5R
         kuxKlHThyYxO+YFS0aX8GgFhJk1MoyquZ0XrJoUfrIifcl/UewI4HG4buWCLcAZ7Oop6
         ZxUGLlEFrKL+vkTt6BxevAxD+xJVftmmYNr5m6crIUhMVXEtdwu5D5gYb271UJ9QTjo9
         45sttYqNQSse2jMFyEboEkrBPwpyMZN5qC4M96rUBbsSjMJmV2TL9pTQceKatv/rsX4V
         Eb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dt82aF1wjXqY0oqezwUaavlJN9LxnRwGSZy6Lb8kItY=;
        b=sPJ+wtAhXqR7BRsIg4J3p1ZENRKr3RFhy89YA0x77nJu3zyvLH6xxRXp8/xxbYJoWl
         vm0WIFyr02ycXsXLqGhPaHStr1EyoIfpDVZQ3VcBx19F3KVRxZfA7N9roey0h/hnH8eX
         5+ZVvHJhmWETLGEtl4BnbGIzbf8P8FV1mZAahzLwjI68hjXyVrWozZgiSDLEAYmdnRSq
         ICYepJNQmTJg/5riMInZkRewKKrZyKPVxSVTPUgzAyP41FtHuI6wQeUStB8LbXf0Lamt
         ScbqNoj6++4I1zx8qTH92rU0GQw6Htr28h9atyPuwpQH1VFYVY5RsooYIy8SD9qTzotf
         261A==
X-Gm-Message-State: AOAM530qmvn2DzEI3EWMfTmhpcAb+zksH3ruGVp6jvOR44CNj3PmSVfR
        0HCQ+9YZanBKjjJQTBrXdb56EB7g9Lid8A==
X-Google-Smtp-Source: ABdhPJzp+In9o/tlozs6guCLpQGYtstxRzaVxaC7MOHjCbUJr+TXlKgCM8PZSnGUrQwW5s3S2PRiuQ==
X-Received: by 2002:a37:b42:: with SMTP id 63mr10175302qkl.301.1595600046549;
        Fri, 24 Jul 2020 07:14:06 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-100-181.hsd1.md.comcast.net. [69.250.100.181])
        by smtp.gmail.com with ESMTPSA id q16sm6667917qkn.115.2020.07.24.07.14.05
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 07:14:05 -0700 (PDT)
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v4] libselinux: use kernel status page by default
Date:   Fri, 24 Jul 2020 10:13:48 -0400
Message-Id: <20200724141348.47590-1-mike.palmiotto@crunchydata.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
/selinux/status") introduced the sestatus mechanism, which allows for
mmap()'ing of the kernel status page as a replacement for avc_netlink.

The mechanism was initially intended for use by userspace object
managers which were calculating access decisions within their
application and did not rely on the libselinux AVC implementation. In
order to properly make use of sestatus within avc_has_perm(), the status
mechanism needs to properly set avc internals during status events;
else, avc_enforcing is never updated upon sestatus changes.

This commit introduces a new selinux_status_loop() function, which
replaces the default netlink-equivalent, avc_netlink_loop(). The
function watches the kernel status page until an error occurs, at which
point it will exit the thread. In the event that the status page cannot
be opened (on avc_open), the thread will continue to function as before
by using a fallback netlink socket.

This allows us to replace the call to avc_netlink_open() in
avc_init_internal() with a call to selinux_status_open() and remove the
avc_netlink_check_nb() call from the critical code path in
avc_has_perm_noaudit(), as well as selinux_check_access().

Userspace object managers that still need a netlink socket can call
avc_netlink_acquire_fd() to open open and/or obtain one.

Update the manpage to reflect the new avc_netlink_acquire_fd()
functionality.

Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
---
Testing:
  - dbus-daemon v1.12.8 on RHEL8.2
  - dbus-broker v22 on F32

Changelog:
  V2:
  - Added selinux_status_loop function for watcher threads.
  - Replaced avc_netlink_open with selinux_status_open.
  - Moved avc_netlink_open into avc_netlink_acquire_fd.
  - Replaced avc_netlink_check_nb() call in selinux_check_access with sestatus
  equivalent.
  - Updated manpage and mapfile.

  V3:
  - Made selinux_status_loop an internal function and got rid of manpage.
  - Got rid of superfluous selinux_status_close() in selinux_status_loop().
  - Got rid of avc_enforcing modification in selinux_status_getenforce().
  - Some style fixes.
  - Updated commit message subject line/details.

  V4:
  - Dropped mapfile changes.
  - Fixed indentation.

 libselinux/man/man3/avc_netlink_loop.3 |  8 +++
 libselinux/src/avc.c                   | 14 ++---
 libselinux/src/avc_internal.c          | 82 ++++++++++++++++++--------
 libselinux/src/avc_internal.h          |  7 +++
 libselinux/src/checkAccess.c           |  2 +-
 libselinux/src/sestatus.c              | 27 +++++++++
 6 files changed, 106 insertions(+), 34 deletions(-)

diff --git a/libselinux/man/man3/avc_netlink_loop.3 b/libselinux/man/man3/avc_netlink_loop.3
index c8268a12..f03d7813 100644
--- a/libselinux/man/man3/avc_netlink_loop.3
+++ b/libselinux/man/man3/avc_netlink_loop.3
@@ -54,6 +54,11 @@ closes the netlink socket.  This function is called automatically by
 returns the netlink socket descriptor number and informs the userspace AVC
 not to check the socket descriptor automatically on calls to
 .BR avc_has_perm (3).
+If no such socket descriptor exists,
+.BR avc_netlink_acquire_fd (3)
+will first call
+.BR avc_netlink_open (3)
+and then return the resulting fd.
 
 .BR avc_netlink_release_fd ()
 returns control of the netlink socket to the userspace AVC, re-enabling
@@ -78,6 +83,9 @@ with a return value return zero on success.  On error, \-1 is returned and
 .I errno
 is set appropriately.
 .
+.SH "AUTHOR"
+Originally KaiGai Kohei. Updated by Mike Palmiotto <mike.palmiotto@crunchydata.com>
+.
 .SH "SEE ALSO"
 .BR avc_open (3),
 .BR selinux_set_callback (3),
diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index b4648b2d..5f3b00cf 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -50,7 +50,7 @@ struct avc_callback_node {
 	struct avc_callback_node *next;
 };
 
-static void *avc_netlink_thread = NULL;
+static void *avc_status_thread = NULL;
 static void *avc_lock = NULL;
 static void *avc_log_lock = NULL;
 static struct avc_node *avc_node_freelist = NULL;
@@ -215,15 +215,15 @@ static int avc_init_internal(const char *prefix,
 		avc_enforcing = rc;
 	}
 
-	rc = avc_netlink_open(0);
+	rc = selinux_status_open(1);
 	if (rc < 0) {
 		avc_log(SELINUX_ERROR,
-			"%s:  can't open netlink socket: %d (%s)\n",
+			"%s: could not open selinux status page: %d (%s)\n",
 			avc_prefix, errno, strerror(errno));
 		goto out;
 	}
 	if (avc_using_threads) {
-		avc_netlink_thread = avc_create_thread(&avc_netlink_loop);
+		avc_status_thread = avc_create_thread(&selinux_status_loop);
 		avc_netlink_trouble = 0;
 	}
 	avc_running = 1;
@@ -558,8 +558,8 @@ void avc_destroy(void)
 	avc_get_lock(avc_lock);
 
 	if (avc_using_threads)
-		avc_stop_thread(avc_netlink_thread);
-	avc_netlink_close();
+		avc_stop_thread(avc_status_thread);
+	selinux_status_close();
 
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
 		node = avc_cache.slots[i];
@@ -766,7 +766,7 @@ int avc_has_perm_noaudit(security_id_t ssid,
 		avd_init(avd);
 
 	if (!avc_using_threads && !avc_app_main_loop) {
-		(void)avc_netlink_check_nb();
+		(void) selinux_status_updated();
 	}
 
 	if (!aeref) {
diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 568a3d92..4ef92452 100644
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
@@ -284,6 +303,17 @@ void avc_netlink_loop(void)
 
 int avc_netlink_acquire_fd(void)
 {
+	if (fd < 0) {
+		int rc = 0;
+		rc = avc_netlink_open(0);
+		if (rc < 0) {
+			avc_log(SELINUX_ERROR,
+				"%s: could not open netlink socket: %d (%s)\n",
+				avc_prefix, errno, strerror(errno));
+			return rc;
+		}
+	}
+
     avc_app_main_loop = 1;
 
     return fd;
diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index 3f8a6bb1..2dda6490 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -32,6 +32,13 @@ extern void (*avc_func_get_lock) (void *);
 extern void (*avc_func_release_lock) (void *);
 extern void (*avc_func_free_lock) (void *);
 
+/* selinux status processing for netlink and sestatus */
+extern int avc_process_setenforce(int enforcing);
+extern int avc_process_policyload(uint32_t seqno);
+
+/* watch selinux status page */
+extern void selinux_status_loop(void);
+
 static inline void set_callbacks(const struct avc_memory_callback *mem_cb,
 				 const struct avc_log_callback *log_cb,
 				 const struct avc_thread_callback *thread_cb,
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 3491fded..b337ea64 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -39,7 +39,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
 	if (rc < 0)
 		return rc;
 
-	(void) avc_netlink_check_nb();
+	(void) selinux_status_updated();
 
        sclass = string_to_security_class(class);
        if (sclass == 0) {
diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index 86267ff8..72733c2d 100644
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
+		if (avc_enforcing != (int) selinux_status->enforcing) {
+			if (avc_process_setenforce(selinux_status->enforcing) < 0)
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
@@ -316,6 +326,23 @@ error:
 	return -1;
 }
 
+/*
+ * selinux_status_loop
+ *
+ * Run routine for checking kernel status page in a listening thread.
+ * Falls back on netlink socket in the event of failure to open status page.
+ */
+void selinux_status_loop(void)
+{
+	/* Check kernel status page until error occurs */
+	while (selinux_status_updated() >= 0)
+		;
+
+	avc_log(SELINUX_ERROR,
+		"%s: status thread terminating due to error: %d (%s)\n",
+		avc_prefix, errno, strerror(errno));
+}
+
 /*
  * selinux_status_close
  *
-- 
2.27.0

