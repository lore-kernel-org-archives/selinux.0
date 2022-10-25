Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC1DFA3740
	for <selinux@archiver.kernel.org>; Tue, 25 Oct 2022 11:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiJYLYc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Oct 2022 07:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiJYLYb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Oct 2022 07:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3FC24948
        for <selinux@vger.kernel.org>; Tue, 25 Oct 2022 04:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666697068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f7EIviJxfeV5Wz2eCRQ/jlfa3sqau6UaiJfVokLU0Uc=;
        b=hIwd4+EunsMVmmtunJ0YeD1c1rcTN0oaoAwaJzfxAVC+oqdsR8VJsXCoKuF58SDByhmRtS
        VPP6YPzfUkZS3lTpyRnrS7PgxahtxlCqSEot/dAogH4JFtfGZQDZq3x+LtntZrSKv2ivOo
        EOMOq/GpZ37vU6YvV9zB33x3Z1V/fH0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-w8Bee9PaP0SyE7SG8a6yGg-1; Tue, 25 Oct 2022 07:24:27 -0400
X-MC-Unique: w8Bee9PaP0SyE7SG8a6yGg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AF7D3815D20
        for <selinux@vger.kernel.org>; Tue, 25 Oct 2022 11:24:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-192-215.brq.redhat.com [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69B60492B0A;
        Tue, 25 Oct 2022 11:24:26 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libselinux: Drop '\n' from avc_log() messages
Date:   Tue, 25 Oct 2022 13:24:16 +0200
Message-Id: <20221025112416.652021-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The main set_selinux_callback() consumers, such as systemd, dbus-broker,
and shadow-utils, expect messages to end without a newline. The default
log handler in libselinux has been updated to add a newline to messages
printed to stderr.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/man/man3/selinux_set_callback.3 |  3 +++
 libselinux/src/avc.c                       | 16 ++++++-------
 libselinux/src/avc_internal.c              | 26 +++++++++++-----------
 libselinux/src/callbacks.c                 |  6 +++++
 4 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/libselinux/man/man3/selinux_set_callback.3 b/libselinux/man/man3/selinux_set_callback.3
index 75f49b06d836..124754a1854b 100644
--- a/libselinux/man/man3/selinux_set_callback.3
+++ b/libselinux/man/man3/selinux_set_callback.3
@@ -122,6 +122,9 @@ None.
 .SH "ERRORS"
 None.
 .
+.SH "NOTES"
+Log messages don't end with a newline.
+.
 .SH "AUTHOR"
 Eamon Walsh <ewalsh@tycho.nsa.gov>
 .
diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 8d5983a2fe0c..e4f7f64fa913 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -175,7 +175,7 @@ static int avc_init_internal(const char *prefix,
 	rc = sidtab_init(&avc_sidtab);
 	if (rc) {
 		avc_log(SELINUX_ERROR,
-			"%s:  unable to initialize SID table\n",
+			"%s:  unable to initialize SID table",
 			avc_prefix);
 		goto out;
 	}
@@ -183,7 +183,7 @@ static int avc_init_internal(const char *prefix,
 	avc_audit_buf = (char *)avc_malloc(AVC_AUDIT_BUFSIZE);
 	if (!avc_audit_buf) {
 		avc_log(SELINUX_ERROR,
-			"%s:  unable to allocate audit buffer\n",
+			"%s:  unable to allocate audit buffer",
 			avc_prefix);
 		rc = -1;
 		goto out;
@@ -193,7 +193,7 @@ static int avc_init_internal(const char *prefix,
 		new = avc_malloc(sizeof(*new));
 		if (!new) {
 			avc_log(SELINUX_WARNING,
-				"%s:  warning: only got %d av entries\n",
+				"%s:  warning: only got %d av entries",
 				avc_prefix, i);
 			break;
 		}
@@ -206,7 +206,7 @@ static int avc_init_internal(const char *prefix,
 		rc = security_getenforce();
 		if (rc < 0) {
 			avc_log(SELINUX_ERROR,
-				"%s:  could not determine enforcing mode: %m\n",
+				"%s:  could not determine enforcing mode: %m",
 				avc_prefix);
 			goto out;
 		}
@@ -216,7 +216,7 @@ static int avc_init_internal(const char *prefix,
 	rc = selinux_status_open(0);
 	if (rc < 0) {
 		avc_log(SELINUX_ERROR,
-			"%s: could not open selinux status page: %d (%m)\n",
+			"%s: could not open selinux status page: %d (%m)",
 			avc_prefix, errno);
 		goto out;
 	}
@@ -292,7 +292,7 @@ void avc_av_stats(void)
 	avc_release_lock(avc_lock);
 
 	avc_log(SELINUX_INFO, "%s:  %u AV entries and %d/%d buckets used, "
-		"longest chain length %d\n", avc_prefix,
+		"longest chain length %d", avc_prefix,
 		avc_cache.active_nodes,
 		slots_used, AVC_CACHE_SLOTS, max_chain_len);
 }
@@ -473,7 +473,7 @@ static int avc_insert(security_id_t ssid, security_id_t tsid,
 
 	if (ae->avd.seqno < avc_cache.latest_notif) {
 		avc_log(SELINUX_WARNING,
-			"%s:  seqno %u < latest_notif %u\n", avc_prefix,
+			"%s:  seqno %u < latest_notif %u", avc_prefix,
 			ae->avd.seqno, avc_cache.latest_notif);
 		errno = EAGAIN;
 		rc = -1;
@@ -613,7 +613,7 @@ static int avc_ratelimit(void)
 		avc_release_lock(ratelimit_lock);
 		if (lost) {
 			avc_log(SELINUX_WARNING,
-				"%s:  %d messages suppressed.\n", avc_prefix,
+				"%s:  %d messages suppressed.", avc_prefix,
 				lost);
 		}
 		rc = 1;
diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 71a1357bc564..a5d24b16d063 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -66,7 +66,7 @@ int avc_process_setenforce(int enforcing)
 	avc_enforcing = enforcing;
 	if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
 		avc_log(SELINUX_ERROR,
-			"%s:  cache reset returned %d (errno %d)\n",
+			"%s:  cache reset returned %d (errno %d)",
 			avc_prefix, rc, errno);
 		return rc;
 	}
@@ -86,7 +86,7 @@ int avc_process_policyload(uint32_t seqno)
 	rc = avc_ss_reset(seqno);
 	if (rc < 0) {
 		avc_log(SELINUX_ERROR,
-			"%s:  cache reset returned %d (errno %d)\n",
+			"%s:  cache reset returned %d (errno %d)",
 			avc_prefix, rc, errno);
 		return rc;
 	}
@@ -157,7 +157,7 @@ static int avc_netlink_receive(void *buf, unsigned buflen, int blocking)
 		return -1;
 	}
 	else if (rc < 1) {
-		avc_log(SELINUX_ERROR, "%s:  netlink poll: error %d\n",
+		avc_log(SELINUX_ERROR, "%s:  netlink poll: error %d",
 			avc_prefix, errno);
 		return rc;
 	}
@@ -169,21 +169,21 @@ static int avc_netlink_receive(void *buf, unsigned buflen, int blocking)
 
 	if (nladdrlen != sizeof nladdr) {
 		avc_log(SELINUX_WARNING,
-			"%s:  warning: netlink address truncated, len %u?\n",
+			"%s:  warning: netlink address truncated, len %u?",
 			avc_prefix, nladdrlen);
 		return -1;
 	}
 
 	if (nladdr.nl_pid) {
 		avc_log(SELINUX_WARNING,
-			"%s:  warning: received spoofed netlink packet from: %u\n",
+			"%s:  warning: received spoofed netlink packet from: %u",
 			avc_prefix, nladdr.nl_pid);
 		return -1;
 	}
 
 	if (rc == 0) {
 		avc_log(SELINUX_WARNING,
-			"%s:  warning: received EOF on netlink socket\n",
+			"%s:  warning: received EOF on netlink socket",
 			avc_prefix);
 		errno = EBADFD;
 		return -1;
@@ -191,7 +191,7 @@ static int avc_netlink_receive(void *buf, unsigned buflen, int blocking)
 
 	if (nlh->nlmsg_flags & MSG_TRUNC || nlh->nlmsg_len > (unsigned)rc) {
 		avc_log(SELINUX_WARNING,
-			"%s:  warning: incomplete netlink message\n",
+			"%s:  warning: incomplete netlink message",
 			avc_prefix);
 		return -1;
 	}
@@ -214,7 +214,7 @@ static int avc_netlink_process(void *buf)
 
 		errno = -err->error;
 		avc_log(SELINUX_ERROR,
-			"%s:  netlink error: %d\n", avc_prefix, errno);
+			"%s:  netlink error: %d", avc_prefix, errno);
 		return -1;
 	}
 
@@ -236,7 +236,7 @@ static int avc_netlink_process(void *buf)
 
 	default:
 		avc_log(SELINUX_WARNING,
-			"%s:  warning: unknown netlink message %d\n",
+			"%s:  warning: unknown netlink message %d",
 			avc_prefix, nlh->nlmsg_type);
 	}
 	return 0;
@@ -257,7 +257,7 @@ int avc_netlink_check_nb(void)
 				continue;
 			else {
 				avc_log(SELINUX_ERROR,
-					"%s:  netlink recvfrom: error %d\n",
+					"%s:  netlink recvfrom: error %d",
 					avc_prefix, errno);
 				return rc;
 			}
@@ -282,7 +282,7 @@ void avc_netlink_loop(void)
 				continue;
 			else {
 				avc_log(SELINUX_ERROR,
-					"%s:  netlink recvfrom: error %d\n",
+					"%s:  netlink recvfrom: error %d",
 					avc_prefix, errno);
 				break;
 			}
@@ -297,7 +297,7 @@ void avc_netlink_loop(void)
 	fd = -1;
 	avc_netlink_trouble = 1;
 	avc_log(SELINUX_ERROR,
-		"%s:  netlink thread: errors encountered, terminating\n",
+		"%s:  netlink thread: errors encountered, terminating",
 		avc_prefix);
 }
 
@@ -308,7 +308,7 @@ int avc_netlink_acquire_fd(void)
 		rc = avc_netlink_open(0);
 		if (rc < 0) {
 			avc_log(SELINUX_ERROR,
-				"%s: could not open netlink socket: %d (%m)\n",
+				"%s: could not open netlink socket: %d (%m)",
 				avc_prefix, errno);
 			return rc;
 		}
diff --git a/libselinux/src/callbacks.c b/libselinux/src/callbacks.c
index 469c4055f4d7..6850df5fdfe0 100644
--- a/libselinux/src/callbacks.c
+++ b/libselinux/src/callbacks.c
@@ -21,6 +21,12 @@ default_selinux_log(int type __attribute__((unused)), const char *fmt, ...)
 	va_start(ap, fmt);
 	rc = vfprintf(stderr, fmt, ap);
 	va_end(ap);
+	if (rc > 0) {
+		if (fputc('\n', stderr) != EOF)
+			rc++;
+		else
+			rc = EOF;
+	}
 	return rc;
 }
 
-- 
2.37.3

