Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059D9CCA47A
	for <selinux@archiver.kernel.org>; Tue, 14 Jun 2022 10:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353841AbiFNKUn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353999AbiFNKUm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 06:20:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B1F473B0
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 03:20:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u12so16191900eja.8
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vPxEEIZQ6+bg5HLSgefSYabNhEAPADjLC36hYzjMzgw=;
        b=G/qz1V56tHGk3BX8gS5LtSXwWMbjkz/QuWSl2IByKaECu6t2VHNlyyKjQQ0gfDQAMT
         gmP+Dv/6L6R7DxdLXQTrC4XhaLuly+o73nXEQaqz6cedtM9OHWVcBaifDYzTvFRf8jIb
         p25EnQBaxkWqWNC/UV8H8i46xLWuLtScKfBQJ8rd1ttLfuieF+7uHlY/00Tuqc7EA8Ml
         tocF1lXcbRCPGnxAHm8mzlRs/1GyaR4ufidg46IQ0A9/h9r5lnIY6j8cE9rPeqyvzjFS
         1U/FnRtKjZqRTkVz6DfyU2zBfd0CMECx3pklvrOhPRsqlQyLd4HjJgEGSwqxl0TUeCJJ
         JdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPxEEIZQ6+bg5HLSgefSYabNhEAPADjLC36hYzjMzgw=;
        b=yAD6yVPLf/0ZnzNQidxUMmz89q9F/NIQadC81jn/gFk0xnjqfxPL3v/FDICQ1YO2gK
         YTRpEMR7N4BnEJ07cf80oOxfPp5DCpOocvj4w/s94m3I3f650GufRK+ah20m/OpkCC6N
         vamfHwEBcaUAMwz5GyApQvJlbOPk6xAHKaU91P1Sy3rthh8xa+NsitOaRiMb3X72OqII
         fNSHNWhWUw7ByE6NI4wnG3H3qlHR2mxP6h6QsIl1qaWkRIy63pQfk63annvSlzVo9Lta
         11uPS9Uda1nufnZ2TliiipAqp+DN8np+FU+xkEAYaS4qOWIHWX2hSwvv3c3JYf6Qim+/
         Vwow==
X-Gm-Message-State: AOAM531V5xcD8B75gn8PLcl/c/fxPtYmzL9jz1a/RFfhxphXSIwBfECI
        /jT+c/MVTs5MDHNUnQnzb0bRCNLHA0k=
X-Google-Smtp-Source: AGRyM1tal5x8EhfbADb8ZuSVBVABPGiCnYQAIQRogn6bLU8CSATgmL7wvebn1DoUwKlrROOFmhBIlA==
X-Received: by 2002:a17:907:6294:b0:6e1:ea4:74a3 with SMTP id nd20-20020a170907629400b006e10ea474a3mr3601788ejc.168.1655202038890;
        Tue, 14 Jun 2022 03:20:38 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-087-232.77.1.pool.telefonica.de. [77.1.87.232])
        by smtp.gmail.com with ESMTPSA id gv17-20020a170906f11100b006febc1e9fc8sm4871186ejb.47.2022.06.14.03.20.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 03:20:38 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/4] watchkey: skip if CONFIG_WATCH_QUEUE not set
Date:   Tue, 14 Jun 2022 12:20:29 +0200
Message-Id: <20220614102029.13006-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614102029.13006-1-cgzones@googlemail.com>
References: <20220614102029.13006-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Debian does not set CONFIG_WATCH_QUEUE, whereby pipe2(2) returns ENOPKG
for the option O_NOTIFICATION_PIPE.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/watchkey/test       |  9 ++++++++-
 tests/watchkey/watchkey.c | 16 ++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/tests/watchkey/test b/tests/watchkey/test
index f61ff78..38cbb74 100755
--- a/tests/watchkey/test
+++ b/tests/watchkey/test
@@ -16,7 +16,14 @@ BEGIN {
         $v = " ";
     }
 
-    plan tests => 2;
+    $result = system "runcon -t test_watchkey_t $basedir/watchkey $v -c";
+    if ( $result ne 0 ) {
+        plan skip_all =>
+"pipe2(2) does not support O_NOTIFICATION_PIPE; CONFIG_WATCH_QUEUE probably not set";
+    }
+    else {
+        plan tests => 2;
+    }
 }
 
 $result = system "runcon -t test_watchkey_t $basedir/watchkey $v";
diff --git a/tests/watchkey/watchkey.c b/tests/watchkey/watchkey.c
index c7f3274..4feba42 100644
--- a/tests/watchkey/watchkey.c
+++ b/tests/watchkey/watchkey.c
@@ -27,8 +27,9 @@ static long keyctl_watch_key(int key, int watch_fd, int watch_id)
 static void print_usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-v]\n"
+		"usage:  %s [-cv]\n"
 		"Where:\n\t"
+		"-c  Check for availability.\n"
 		"-v  Print information.\n", progname);
 	exit(-1);
 }
@@ -37,10 +38,14 @@ int main(int argc, char **argv)
 {
 	int opt, fd, pipefd[2], result, save_errno;
 	char *context;
+	bool check = false;
 	bool verbose = false;
 
-	while ((opt = getopt(argc, argv, "v")) != -1) {
+	while ((opt = getopt(argc, argv, "cv")) != -1) {
 		switch (opt) {
+		case 'c':
+			check = true;
+			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -60,6 +65,13 @@ int main(int argc, char **argv)
 		free(context);
 	}
 
+	if (check) {
+		result = pipe2(pipefd, O_NOTIFICATION_PIPE);
+		if (!result || errno != ENOPKG)
+			exit(0);
+		exit(-1);
+	}
+
 	result = pipe2(pipefd, O_NOTIFICATION_PIPE);
 	if (result < 0) {
 		fprintf(stderr, "Failed to create pipe2(2): %s\n",
-- 
2.36.1

