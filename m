Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86D3C433E0
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 17:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C4E2245C
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 17:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="jaf8ZX8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbgGaRZz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbgGaRZy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 13:25:54 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B291C061574
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 10:25:54 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id s15so10017365qvv.7
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SEKGZkhDK5t1TuIPUKisnIrG+1KpvSe+eNVBLkgbwYs=;
        b=jaf8ZX8kf5pfB1e4tWp23AlocGrwxL+0/DWJGC4yzpERhcvfLfL4OtTzyZBf9OzDyI
         DPZhio+keTGBIGQO2naWLdSjEqWXib3b/dSEa/oLOlpP+6u297FsiOo8adWdV7z5Pytj
         pzDeQZYtHGyFVvA1zTiTlBY4z3lm8nJLbWeH83f5K/LZieWyKEe6v3OO7WiCd2lOcCjx
         IczrAzrcZ9wKOvYO4QZbA8Fuw+s7x+66hS62pCtErkiY4LwxSvKhgOtGdmi18mFx+0j1
         fDkHtuQILkpA+OifCytXxa54HLNcMFN22UbJPO4xlmv2SODuBYiVNztlw44t5F/0F8oH
         qf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SEKGZkhDK5t1TuIPUKisnIrG+1KpvSe+eNVBLkgbwYs=;
        b=eOP/EjSjfuiQnvX/6SCaBId02KQvC4zq5+NAhdmWL4f0pBIEkKfEatnbXyO79U1AlO
         L0NjPXRBhvvJzk2zvShlEA8vuZesrLZz/PzzCkQn12CraJkm5q3mQMymj/ia4LDjvIsm
         07xUhtvze0YltDcHdlKhunGZlVad87KwEMVbqNoCnw2s0egXGqfFG9UKYK308WNqJRoy
         liEegb3/eogF6hro8jJv/PEnjiFxcIv7+Bt6dsj4a/oqRbiTV5yYJYFrhdnHlLPWs5lK
         PxjxgpndDGOSDJepOcR5Ik1l4Poar0sBsOYDi/cfgoqvZqEK5bsnriYgev0aDx5U4lsU
         JR2g==
X-Gm-Message-State: AOAM532M4rcYuYbir84E/j5duygVnZl2qS5WgC2VtKVhq2zgatghIo5U
        ZwsRDzflYMo/mWeEddBUPnNCvikC49Zc2Q==
X-Google-Smtp-Source: ABdhPJz6NyGN8hIawGIUeJSOU7FzAVZ5o6g4xNybNmXYyKN75+QRfP7acNJ14HwPpSLbcjxxdK2EQQ==
X-Received: by 2002:a0c:83e6:: with SMTP id k93mr5019236qva.112.1596216352676;
        Fri, 31 Jul 2020 10:25:52 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-100-181.hsd1.md.comcast.net. [69.250.100.181])
        by smtp.gmail.com with ESMTPSA id a6sm9159377qka.5.2020.07.31.10.25.50
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 10:25:51 -0700 (PDT)
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v5] libselinux: use kernel status page by default
Date:   Fri, 31 Jul 2020 13:25:38 -0400
Message-Id: <20200731172538.13393-1-mike.palmiotto@crunchydata.com>
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

The mechanism was initially intended for userspace object managers that
were calculating access decisions within their application and did not
rely on the libselinux AVC implementation. In order to properly make use
of sestatus within avc_has_perm(), the status mechanism needs to
properly set avc internals during status events; else, avc_enforcing is
never updated upon sestatus changes.

This commit gets rid of the default avc_netlink_open() in
avc_init_internal(), replacing it with selinux_status_open(). In the
event that the kernel status page cannot be mapped, the netlink fallback
will be used. By default, avc_has_perm_noaudit() and
selinux_check_access() will now attempt to read the kernel status page,
which removes a system call from two critical code paths.

Since the AVC thread create/stop callbacks were intended to avoid a
system call in the critical code path, they no longer need to be created
by default. In the event that the kernel status page is successfully
mapped, threads will not be created. Threads will still be
created/stopped for the sestatus fallback codepaths.

Userspace object managers that still need a netlink socket can call
avc_netlink_acquire_fd() to open and/or obtain one.

Update the manpage to reflect the new avc_netlink_acquire_fd()
functionality.

Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
---
 libselinux/man/man3/avc_init.3            | 75 +++++++++++++++++++--
 libselinux/man/man3/avc_netlink_loop.3    |  8 +++
 libselinux/man/man3/selinux_status_open.3 |  6 +-
 libselinux/src/avc.c                      | 15 ++---
 libselinux/src/avc_internal.c             | 82 ++++++++++++++++-------
 libselinux/src/avc_internal.h             |  4 ++
 libselinux/src/checkAccess.c              |  2 +-
 libselinux/src/sestatus.c                 | 24 +++++++
 8 files changed, 171 insertions(+), 45 deletions(-)

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

  V5:
  - Fixed thread spin by removing thread callbacks on successful selinux_status_open.
  - Added thread callbacks to netlink fallback.
  - More manpage updates.
  
diff --git a/libselinux/man/man3/avc_init.3 b/libselinux/man/man3/avc_init.3
index e26c3be6..656d7e24 100644
--- a/libselinux/man/man3/avc_init.3
+++ b/libselinux/man/man3/avc_init.3
@@ -117,6 +117,8 @@ argument, which does not return under normal conditions.  The
 callback should cancel the running thread referenced by 
 .IR thread .
 By default, threading is not used; see 
+.B KERNEL STATUS PAGE
+and
 .B NETLINK NOTIFICATION
 below.
 
@@ -153,14 +155,74 @@ callback should destroy
 .IR lock ,
 freeing any resources associated with it.  The default behavior is not to perform any locking.  Note that undefined behavior may result if threading is used without appropriate locking.
 .
-.SH "NETLINK NOTIFICATION"
-Beginning with version 2.6.4, the Linux kernel supports SELinux status change notification via netlink.  Two message types are currently implemented, indicating changes to the enforcing mode and to the loaded policy in the kernel, respectively.  The userspace AVC listens for these messages and takes the appropriate action, modifying the behavior of
-.BR avc_has_perm (3)
-to reflect the current enforcing mode and flushing the cache on receipt of a policy load notification.  Audit messages are produced when netlink notifications are processed.
+.SH "KERNEL STATUS PAGE"
+Linux kernel version 2.6.37 supports the SELinux kernel status page, enabling userspace applications to
+.BR mmap (2)
+SELinux status state in read-only mode to avoid system calls during the cache hit code path.
+
+Status state is stored in the
+.B selinux_status
+pointer to the
+.B selinux_status_t
+struct.
+
+.RS
+.ta 4n 10n 24n
+.nf
+
+struct selinux_status_t
+{
+	uint32_t	version;	/* version number of this structure */
+	uint32_t	sequence;	/* sequence number of seqlock logic */
+	uint32_t	enforcing;	/* current setting of enforcing mode */
+	uint32_t	policyload;	/* times of policy reloaded */
+	uint32_t	deny_unknown;	/* current setting of deny_unknown */
+	/* version > 0 support above status */
+} __attribute((packed));
+.fi
+.ta
+.RE
 
-In the default single-threaded mode, the userspace AVC checks for new netlink messages at the start of each permission query.  If threading and locking callbacks are passed to
 .BR avc_init ()
-however, a dedicated thread will be started to listen on the netlink socket.  This may increase performance and will ensure that log messages are generated immediately rather than at the time of the next permission query.
+calls
+.BR selinux_status_open (3)
+to initialize
+.B selinux_status.
+If successfully initialized, the userspace AVC will default to single-threaded mode and ignore the
+.B func_create_thread
+and
+.B func_stop_thread
+callbacks. All callbacks set via
+.BR selinux_set_callback (3)
+will still be honored.
+
+.BR avc_has_perm (3)
+and
+.BR selinux_check_access (3)
+both check for status updates through calls to
+.BR selinux_status_updated (3)
+at the start of each permission query and take the appropriate action.
+
+Two status types are currently implemented.
+.B avc_process_setenforce
+will process changes to the enforcing mode by changing the effective enforcing state used with the AVC, and
+.B avc_process_policyload
+will process changes to the kernel loaded policy by flushing the cache.
+.
+.SH "NETLINK NOTIFICATION"
+In the event that the kernel status page is not successfully
+.BR mmap (3)'ed
+into
+.B selinux_status,
+the AVC will default to the netlink fallback mechanism.
+
+By default,
+.BR avc_open (3)
+does not set threading or locking callbacks. In this case, the userspace AVC checks for new netlink messages at the start of each permission query. If threading and locking callbacks are passed to
+.BR avc_init (),
+a dedicated thread will be started to listen on the netlink socket.  This may increase performance in the absense of
+.B selinux_status
+and will ensure that log messages are generated immediately rather than at the time of the next permission query.
 .
 .SH "RETURN VALUE"
 Functions with a return value return zero on success.  On error, \-1 is returned and
@@ -192,5 +254,6 @@ Eamon Walsh <ewalsh@tycho.nsa.gov>
 .
 .SH "SEE ALSO"
 .BR avc_open (3),
+.BR selinux_status_open (3),
 .BR selinux_set_callback (3),
 .BR selinux (8)
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
diff --git a/libselinux/man/man3/selinux_status_open.3 b/libselinux/man/man3/selinux_status_open.3
index 2d44be57..8525e271 100644
--- a/libselinux/man/man3/selinux_status_open.3
+++ b/libselinux/man/man3/selinux_status_open.3
@@ -57,7 +57,11 @@ unmap the kernel status page and close its file descriptor, or close the
 netlink socket if fallbacked.
 .sp
 .BR selinux_status_updated ()
-informs us whether something has been updated since the last call.
+processes status update events. There are two kinds of status updates.
+.B avc_process_setenforce
+handles any changes in Enforcing state, and
+.B avc_process_policyload
+handles changes to the kernel loaded policy.
 It returns 0 if nothing was happened, however, 1 if something has been
 updated in this duration, or \-1 on error.
 .sp
diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index b4648b2d..8314d7ba 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -50,7 +50,6 @@ struct avc_callback_node {
 	struct avc_callback_node *next;
 };
 
-static void *avc_netlink_thread = NULL;
 static void *avc_lock = NULL;
 static void *avc_log_lock = NULL;
 static struct avc_node *avc_node_freelist = NULL;
@@ -215,17 +214,13 @@ static int avc_init_internal(const char *prefix,
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
-	if (avc_using_threads) {
-		avc_netlink_thread = avc_create_thread(&avc_netlink_loop);
-		avc_netlink_trouble = 0;
-	}
 	avc_running = 1;
       out:
 	return rc;
@@ -557,9 +552,7 @@ void avc_destroy(void)
 
 	avc_get_lock(avc_lock);
 
-	if (avc_using_threads)
-		avc_stop_thread(avc_netlink_thread);
-	avc_netlink_close();
+	selinux_status_close();
 
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
 		node = avc_cache.slots[i];
@@ -766,7 +759,7 @@ int avc_has_perm_noaudit(security_id_t ssid,
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
index 86267ff8..814e86ee 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -39,11 +39,14 @@ struct selinux_status_t
 static struct selinux_status_t *selinux_status = NULL;
 static int			selinux_status_fd;
 static uint32_t			last_seqno;
+static uint32_t			last_policyload;
 
 static uint32_t			fallback_sequence;
 static int			fallback_enforcing;
 static int			fallback_policyload;
 
+static void			*fallback_netlink_thread = NULL;
+
 /*
  * read_sequence
  *
@@ -116,6 +119,15 @@ int selinux_status_updated(void)
 
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
@@ -282,6 +294,9 @@ int selinux_status_open(int fallback)
 	selinux_status_fd = fd;
 	last_seqno = (uint32_t)(-1);
 
+	/* No need to use avc threads if the kernel status page is available */
+	avc_using_threads = 0;
+
 	return 0;
 
 error:
@@ -305,6 +320,12 @@ error:
 		selinux_status_fd = avc_netlink_acquire_fd();
 		last_seqno = (uint32_t)(-1);
 
+		if (avc_using_threads)
+		{
+			fallback_netlink_thread = avc_create_thread(&avc_netlink_loop);
+			avc_netlink_trouble = 0;
+		}
+
 		fallback_sequence = 0;
 		fallback_enforcing = security_getenforce();
 		fallback_policyload = 0;
@@ -333,6 +354,9 @@ void selinux_status_close(void)
 	/* fallback-mode */
 	if (selinux_status == MAP_FAILED)
 	{
+		if (avc_using_threads)
+			avc_stop_thread(fallback_netlink_thread);
+
 		avc_netlink_release_fd();
 		avc_netlink_close();
 		selinux_status = NULL;
-- 
2.27.0

