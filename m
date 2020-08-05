Return-Path: <SRS0=Kca8=BP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CC6C433DF
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 19:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3462076E
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 19:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="aSNiT6I5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgHETuS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgHETuK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 15:50:10 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A610EC0617A4
        for <selinux@vger.kernel.org>; Wed,  5 Aug 2020 12:43:24 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s16so34586324qtn.7
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2020 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CUSg+XOAmXesE/FYtAj8DPDKidJWXdHAGZ4sAihF4vU=;
        b=aSNiT6I5xnXVT4yrOhTvyHbhBuRm0syfsUHAxkq+idvZOnkKuxnF6Nynt7VhFknfvx
         h+KjOUhMUI2MQWQ4weUT/81MphDtxLou7YA836LFZiqTvp5uNuM9FWxTWKKCkI0b01Or
         ALRqKBhkVKMsJMQkaSWo6i5ARX19QBw4UcU9lAtZ/OMaDv8r2g+wjTF/+rrpKMcRuANm
         CE1Tjd/q2rvWjhV+H/xcmCCecWwTSIrJEp8/9o7dIZmkTujRsvrU8ZiL8COKcpZDCRIo
         vbwpuS6CqL9/jlLYYphUZ9CFQlp7sfSIvbtVpvzlyiZtyPP61zxkIGv4oIblyVlVN9W0
         iVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CUSg+XOAmXesE/FYtAj8DPDKidJWXdHAGZ4sAihF4vU=;
        b=A5bxggoVLOn90YXikBGD60F0lVJRRNYXsoRyQ2zoW3AgTboIJbFXRIdGIZoVLF1/Db
         /2ApuRDqKOGB9eDvQZ1agZf5/V4hqfRgN0CPxqjLPNpQfOMB+wU3kPPIllvn9oyh+Hi1
         lR8BQnukBnUzen7SB+kl9agLehMhIksljcMgTG03KYeIbyRUxsnDSPfiSJQ5vSJSx8jB
         U3APCX/fzrmSdnmaQCJrJA1KeSX8m2tchAmXRoC+3Jonoexj1DipYQtaaDQ8AF7Tv9na
         WQxJeS7IdkQxAIrcEEfUsRGZ1KUg+CQV8Q++OEpBy1i0jC08h3r0QOQhguKdjNkRHoiz
         4AyA==
X-Gm-Message-State: AOAM533vhy4HJUYZX9mLjUoziPxcS7TVcCEoe2qNcjLLzgqO8tdXlamf
        ZXyjczmyFOFIWaS9QMvHCnciqZnuR3eCGQ==
X-Google-Smtp-Source: ABdhPJyTY/TVF7YhjcEWmlFyLSSexS3oTwS67tYhlM583o97q7wcT5aFrTklpNaoNVCxmDEBgBmi/w==
X-Received: by 2002:ac8:1382:: with SMTP id h2mr5219732qtj.228.1596656602977;
        Wed, 05 Aug 2020 12:43:22 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-100-181.hsd1.md.comcast.net. [69.250.100.181])
        by smtp.gmail.com with ESMTPSA id g4sm2257248qka.25.2020.08.05.12.43.21
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2020 12:43:21 -0700 (PDT)
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v6] libselinux: use kernel status page by default
Date:   Wed,  5 Aug 2020 15:43:12 -0400
Message-Id: <20200805194312.7188-1-mike.palmiotto@crunchydata.com>
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

  V6:
  - Got rid of selinux_status references in manpage.
  - Updated avc_open manpage.
  - Updated manpage references.

 libselinux/man/man3/avc_init.3            | 51 ++++++++++++--
 libselinux/man/man3/avc_netlink_loop.3    |  8 +++
 libselinux/man/man3/avc_open.3            | 36 +++++++++-
 libselinux/man/man3/selinux_status_open.3 | 13 ++--
 libselinux/src/avc.c                      | 15 ++---
 libselinux/src/avc_internal.c             | 82 ++++++++++++++++-------
 libselinux/src/avc_internal.h             |  4 ++
 libselinux/src/checkAccess.c              |  2 +-
 libselinux/src/sestatus.c                 | 24 +++++++
 9 files changed, 184 insertions(+), 51 deletions(-)

diff --git a/libselinux/man/man3/avc_init.3 b/libselinux/man/man3/avc_init.3
index e26c3be6..a5dc7c93 100644
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
 
@@ -153,14 +155,49 @@ callback should destroy
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
 
-In the default single-threaded mode, the userspace AVC checks for new netlink messages at the start of each permission query.  If threading and locking callbacks are passed to
 .BR avc_init ()
-however, a dedicated thread will be started to listen on the netlink socket.  This may increase performance and will ensure that log messages are generated immediately rather than at the time of the next permission query.
+calls
+.BR selinux_status_open (3)
+to initialize the selinux status state. If successfully initialized, the userspace AVC will default to single-threaded mode and ignore the
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
+.B setenforce
+events will change the effective enforcing state used within the AVC, and
+.B policyload
+events will result in a cache flush.
+.
+.SH "NETLINK NOTIFICATION"
+In the event that the kernel status page is not successfully
+.BR mmap (2)'ed
+the AVC will default to the netlink fallback mechanism, which opens a netlink socket for receiving status updates.
+.B setenforce
+and
+.B policyload
+events will have the same results as for the status page implementation, but all status update checks will now require a system call.
+
+By default,
+.BR avc_open (3)
+does not set threading or locking callbacks. In the fallback case, the userspace AVC checks for new netlink messages at the start of each permission query. If threading and locking callbacks are passed to
+.BR avc_init (),
+a dedicated thread will be started to listen on the netlink socket.  This may increase performance in the absence of the status page and will ensure that log messages are generated immediately rather than at the time of the next permission query.
 .
 .SH "RETURN VALUE"
 Functions with a return value return zero on success.  On error, \-1 is returned and
@@ -192,5 +229,7 @@ Eamon Walsh <ewalsh@tycho.nsa.gov>
 .
 .SH "SEE ALSO"
 .BR avc_open (3),
+.BR selinux_status_open (3),
+.BR selinux_status_updated (3),
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
diff --git a/libselinux/man/man3/avc_open.3 b/libselinux/man/man3/avc_open.3
index 5b275a8e..3090dd50 100644
--- a/libselinux/man/man3/avc_open.3
+++ b/libselinux/man/man3/avc_open.3
@@ -46,10 +46,37 @@ include the following:
 .B AVC_OPT_SETENFORCE
 This option forces the userspace AVC into enforcing mode if the option value is non-NULL; permissive mode otherwise.  The system enforcing mode will be ignored.
 .
-.SH "NETLINK NOTIFICATION"
-Beginning with version 2.6.4, the Linux kernel supports SELinux status change notification via netlink.  Two message types are currently implemented, indicating changes to the enforcing mode and to the loaded policy in the kernel, respectively.  The userspace AVC listens for these messages and takes the appropriate action, modifying the behavior of
+.SH "KERNEL STATUS PAGE"
+Linux kernel version 2.6.37 supports the SELinux kernel status page, enabling userspace applications to
+.BR mmap (2)
+SELinux status state in read-only mode to avoid system calls during the cache hit code path.
+
+.BR avc_open ()
+calls
+.BR selinux_status_open (3)
+to initialize the selinux status state.
+
 .BR avc_has_perm (3)
-to reflect the current enforcing mode and flushing the cache on receipt of a policy load notification.  Audit messages are produced when netlink notifications are processed.
+and
+.BR selinux_check_access (3)
+both check for status updates through calls to
+.BR selinux_status_updated (3)
+at the start of each permission query and take the appropriate action.
+
+Two status types are currently implemented.
+.B setenforce
+events will change the effective enforcing state used within the AVC, and
+.B policyload
+events will result in a cache flush.
+.
+.SH "NETLINK NOTIFICATION"
+In the event that the kernel status page is not successfully
+.BR mmap (2)'ed
+the AVC will default to the netlink fallback mechanism, which opens a netlink socket for receiving status updates.
+.B setenforce
+and
+.B policyload
+events will have the same results as for the status page implementation, but all status update checks will now require a system call.
 .
 .SH "RETURN VALUE"
 Functions with a return value return zero on success.  On error, \-1 is returned and
@@ -61,9 +88,12 @@ Eamon Walsh <ewalsh@tycho.nsa.gov>
 .
 .SH "SEE ALSO"
 .BR selinux (8),
+.BR selinux_check_access (3),
 .BR avc_has_perm (3),
 .BR avc_context_to_sid (3),
 .BR avc_cache_stats (3),
 .BR avc_add_callback (3),
+.BR selinux_status_open (3),
+.BR selinux_status_updated (3),
 .BR selinux_set_callback (3),
 .BR security_compute_av (3)
diff --git a/libselinux/man/man3/selinux_status_open.3 b/libselinux/man/man3/selinux_status_open.3
index 2d44be57..5c9da2f6 100644
--- a/libselinux/man/man3/selinux_status_open.3
+++ b/libselinux/man/man3/selinux_status_open.3
@@ -48,7 +48,7 @@ Set 1 on the
 argument to handle a case of older kernels without kernel status page support.
 In this case, this function tries to open a netlink socket using
 .BR avc_netlink_open (3)
-and overwrite corresponding callbacks ( setenforce and policyload).
+and overwrite corresponding callbacks (setenforce and policyload).
 Thus, we need to pay attention to the interaction with these interfaces,
 when fallback mode is enabled.
 .sp
@@ -57,9 +57,14 @@ unmap the kernel status page and close its file descriptor, or close the
 netlink socket if fallbacked.
 .sp
 .BR selinux_status_updated ()
-informs us whether something has been updated since the last call.
-It returns 0 if nothing was happened, however, 1 if something has been
-updated in this duration, or \-1 on error.
+processes status update events. There are two kinds of status updates.
+.B setenforce
+events will change the effective enforcing state used within the AVC, and
+.B policyload
+events will result in a cache flush.
+
+This function returns 0 if there have been no updates since the last call,
+1 if there have been updates since the last call, or \-1 on error.
 .sp
 .BR selinux_status_getenforce ()
 returns 0 if SELinux is running in permissive mode, 1 if enforcing mode,
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

