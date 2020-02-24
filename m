Return-Path: <SRS0=m/sx=4M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07013C35671
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 12:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15652072D
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 12:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPYR2LGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBXMrZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:47:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52693 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726778AbgBXMrZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Feb 2020 07:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582548443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GMQE4zlqUKx3i7N3YA9qerkI2W8Zkz5+lpO+AEl+WnY=;
        b=ZPYR2LGxc3d2oQQw1lvHIPTsYlZPaqyhd8UIHjAhK2BAM1wvlNPsDfOnYz1YuweXd6lZbU
        YupZG+J37/DAoEpijcILf54IGIvq7nNIr+XRK37Sp8TiRLXRXP7wHy2Ss2mCBVAi1QAnfd
        mVEmB8MIfCml+kBSMf+tOdfDRi/CBSM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-6hI6g12cMsah-TlUliS62w-1; Mon, 24 Feb 2020 07:47:16 -0500
X-MC-Unique: 6hI6g12cMsah-TlUliS62w-1
Received: by mail-wr1-f71.google.com with SMTP id w6so5540884wrm.16
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2020 04:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GMQE4zlqUKx3i7N3YA9qerkI2W8Zkz5+lpO+AEl+WnY=;
        b=HNOeiqYnEK2AoXvpUENAhvFR1Y3a9DWuK0++YVw9CHjEWN9hztq00xskBfHjfHOg2D
         kgGgbLmLNw/WRR2xFdbBr5gRcXo264NodwpdV+LqUvNVovJnAPwNXG9Fg63vkV7D2smO
         cGNBFcFAgLmeY2mhok+Bm2O2R3Fwd1I5nnpW+WiUwQuv5uzk/OuPbbGV6nDUCxhdiJGb
         GfDRuq/+VOGhHoE7RLM5C2xxXdpo3eWwt8pthNuY9lBMvDTWB67XzZhCZiylza+mgypp
         A77sZqBeS6rwlsQEhrVEY9ITUwlnI6p6VAMHi6KfCVng9h/G220iKQwyih2IZdxgFEGq
         YE2w==
X-Gm-Message-State: APjAAAXYGjIo4RciwmHoZro5vSIBO2sciYCOBJJp5hTi898NQdPZ4bGM
        coA5dga+AbZP2GN+8FLRT4TgDkxmelzaSbHtaahmv5dtnwULrsw9nd4BufLrfwiozFoqkXORBGb
        ufqH9wCrGKsPz4/K+sg==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr21880174wma.31.1582548434955;
        Mon, 24 Feb 2020 04:47:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqzv7pHYHdQGybknMIt8ne1YuNstjMx4ve2F10lwWk0Wac9Rixw3lcyeU7kNSq6J5OAzRsVC6w==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr21880158wma.31.1582548434660;
        Mon, 24 Feb 2020 04:47:14 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z133sm18580708wmb.7.2020.02.24.04.47.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 04:47:13 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/sctp: fix setting of the SCTP_EVENTS sockopt
Date:   Mon, 24 Feb 2020 13:47:10 +0100
Message-Id: <20200224124710.156385-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

First, the setting of SCTP_EVENTS socket option in sctp_server.c is
completely wrong -- it assumes little-endian byte order and uses a plain
int instead of the dedicated sctp_event_subscribe struct.

Second, the usage in sctp_peeloff_server.c is correct, but it may lead
to errors when the SCTP header definitions are newer than what the
kernel supports. In such case the size of struct sctp_event_subscribe
may be higher than the kernel's version and the setsockopt(2) may fail
with -EINVAL due to the 'optlen > sizeof(struct sctp_event_subscribe)'
check in net/sctp/socket.c:sctp_setsockopt_events().

To fix this, introduce a common function that does what the
sctp_peeloff_server's set_subscr_events() did, but also truncates the
optlen to only those fields that we use.

Fixes: c38b57ffdac4 ("selinux-testsuite: Add SCTP test support")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/sctp/sctp_common.c         | 20 ++++++++++++++++++++
 tests/sctp/sctp_common.h         |  1 +
 tests/sctp/sctp_peeloff_server.c | 28 ++++++++--------------------
 tests/sctp/sctp_server.c         |  2 +-
 4 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/tests/sctp/sctp_common.c b/tests/sctp/sctp_common.c
index 100ab22..089af2a 100644
--- a/tests/sctp/sctp_common.c
+++ b/tests/sctp/sctp_common.c
@@ -1,5 +1,8 @@
 #include "sctp_common.h"
 
+#define member_size(type, member) sizeof(((type *)0)->member)
+#define sizeof_up_to(type, member) (offsetof(type, member) + member_size(type, member))
+
 void print_context(int fd, char *text)
 {
 	char *context;
@@ -99,3 +102,20 @@ void print_ip_option(int fd, bool ipv4, char *text)
 		printf("%s No IP Options set\n", text);
 	}
 }
+
+int set_subscr_events(int fd, int data_io, int association)
+{
+	struct sctp_event_subscribe subscr_events;
+
+	memset(&subscr_events, 0, sizeof(subscr_events));
+	subscr_events.sctp_data_io_event = data_io;
+	subscr_events.sctp_association_event = association;
+
+	/*
+	 * Truncate optlen to just the fields we touch to avoid errors when
+	 * the uapi headers are newer than the running kernel.
+	 */
+	return setsockopt(fd, IPPROTO_SCTP, SCTP_EVENTS, &subscr_events,
+			  sizeof_up_to(struct sctp_event_subscribe,
+				       sctp_association_event));
+}
diff --git a/tests/sctp/sctp_common.h b/tests/sctp/sctp_common.h
index d5c1397..351ee37 100644
--- a/tests/sctp/sctp_common.h
+++ b/tests/sctp/sctp_common.h
@@ -25,3 +25,4 @@ void print_context(int fd, char *text);
 void print_addr_info(struct sockaddr *sin, char *text);
 char *get_ip_option(int fd, bool ipv4, socklen_t *opt_len);
 void print_ip_option(int fd, bool ipv4, char *text);
+int set_subscr_events(int fd, int data_io, int association);
diff --git a/tests/sctp/sctp_peeloff_server.c b/tests/sctp/sctp_peeloff_server.c
index 4a5110a..093c6c0 100644
--- a/tests/sctp/sctp_peeloff_server.c
+++ b/tests/sctp/sctp_peeloff_server.c
@@ -16,24 +16,6 @@ static void usage(char *progname)
 	exit(1);
 }
 
-static void set_subscr_events(int fd, int value)
-{
-	int result;
-	struct sctp_event_subscribe subscr_events;
-
-	memset(&subscr_events, 0, sizeof(subscr_events));
-	subscr_events.sctp_association_event = value;
-	/* subscr_events.sctp_data_io_event = value; */
-
-	result = setsockopt(fd, IPPROTO_SCTP, SCTP_EVENTS,
-			    &subscr_events, sizeof(subscr_events));
-	if (result < 0) {
-		perror("Server setsockopt: SCTP_EVENTS");
-		close(fd);
-		exit(1);
-	}
-}
-
 static sctp_assoc_t handle_event(void *buf)
 {
 	union sctp_notification *snp = buf;
@@ -166,7 +148,13 @@ int main(int argc, char **argv)
 	}
 
 	do {
-		set_subscr_events(sock, 1); /* Get assoc_id for sctp_peeloff() */
+		/* Get assoc_id for sctp_peeloff() */
+		result = set_subscr_events(sock, 0, 1);
+		if (result < 0) {
+			perror("Server setsockopt: SCTP_EVENTS");
+			close(sock);
+			exit(1);
+		}
 		sinlen = sizeof(sin);
 		flags = 0;
 
@@ -192,7 +180,7 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			/* No more notifications */
-			set_subscr_events(sock, 0);
+			set_subscr_events(sock, 0, 0);
 
 			peeloff_sk = sctp_peeloff(sock, assoc_id);
 			if (peeloff_sk < 0) {
diff --git a/tests/sctp/sctp_server.c b/tests/sctp/sctp_server.c
index 4659ed1..7f2cd20 100644
--- a/tests/sctp/sctp_server.c
+++ b/tests/sctp/sctp_server.c
@@ -134,7 +134,7 @@ int main(int argc, char **argv)
 	}
 
 	/* Enables sctp_data_io_events for sctp_recvmsg(3) for assoc_id. */
-	result = setsockopt(sock, SOL_SCTP, SCTP_EVENTS, &on, sizeof(on));
+	result = set_subscr_events(sock, on, 0);
 	if (result < 0) {
 		perror("Server setsockopt: SCTP_EVENTS");
 		close(sock);
-- 
2.24.1

