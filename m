Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A69FCCA47F
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 12:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348482AbiFOM1Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348494AbiFOM1W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 08:27:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E71427E1
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 05:27:20 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fu3so22876102ejc.7
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7VNzrf9N9on0pZw/ulEe0+iUxUxkUUrBsRi9ypBHtK4=;
        b=h48I6NpzstMGT/Lx7Uzik6RBIqZ3zPz+O2dXjfMzWMoc74Qq6p3QDAX132/5uNiElC
         sVJ4qiWODN8Igq8BknBiYzA/SDpuN8xt0PNWhO4Ix7feS/ztCPMTNTFrQ2Uw1ERAwSkh
         5Ww1tJqOIq2GtWmhD6Mdm8k/u4Q3ia9RHEdB4Gh/YTIzm0cU+K+IF6R0LVg8uwAaVXlI
         VS/GKkubJ46qOiWOMGqki7FgpL+RtF126wyqNv05aVglEAwJ7o87WN5rKbETe+1ggrEO
         pmJs08nEB5KI5rQwT/6XCoshJoqRFDQpKmrWY7fhjdi3/mXq6YmHfQG/dNpKTyOWiMPV
         tNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VNzrf9N9on0pZw/ulEe0+iUxUxkUUrBsRi9ypBHtK4=;
        b=5oLzzV63LBXHWbAi6527FwbZDgciIjE+sYezlcJC/yHKk3qbOAtMZkiGiQsGBIfrD5
         p8X4vZtYsWVaMMOaK40zvWGc/ZyhIA8O60vSbaXuC3ZZ6IckuIYxbkYiFfxX3JtTnhqE
         6ra5RBSxqVK6D88LQfGliVZohqqoLTFxHgEgHkEtWMUHARbQCIf8BZXtu9gyF36El5tD
         Cuva7zeTdBb7SdpYoeXz1r+kWn3r8JssAmpodt6mD9wlbQfm480iAYOvhMjb4jZDylnC
         6kRTirEiClpGZsSDjppmYoCRE3BinersezZ+SEYWQzUZKsiZKxYoXVfTSKatsToykn10
         d/vw==
X-Gm-Message-State: AOAM530iYyaFuM0ppzkIGNSeFYuPeHEGgEm2njpNw50cgSbQE+96JavZ
        3D3Q0NjYw6o4417B8ARhhtZpVs6Z1CU=
X-Google-Smtp-Source: AGRyM1siUAk/PaqJ+OMhfb379P0GTMTacFqsNF8PL4MEOkkwtuIfImKWpE908wIqLTkl6Ri9NtkXrA==
X-Received: by 2002:a17:907:1629:b0:70c:7beb:52 with SMTP id hb41-20020a170907162900b0070c7beb0052mr8398974ejc.440.1655296039299;
        Wed, 15 Jun 2022 05:27:19 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-151-196.77.3.pool.telefonica.de. [77.3.151.196])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402028900b0042dd3bf1403sm9190336edv.54.2022.06.15.05.27.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 05:27:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 4/4] watchkey: skip if CONFIG_WATCH_QUEUE not set
Date:   Wed, 15 Jun 2022 14:27:11 +0200
Message-Id: <20220615122711.9895-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615122711.9895-1-cgzones@googlemail.com>
References: <20220614102029.13006-1-cgzones@googlemail.com>
 <20220615122711.9895-1-cgzones@googlemail.com>
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
v2:
   return ENOPKG when availability check fails
---
 tests/watchkey/test       | 11 ++++++++++-
 tests/watchkey/watchkey.c | 16 ++++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tests/watchkey/test b/tests/watchkey/test
index f61ff78..3faba51 100755
--- a/tests/watchkey/test
+++ b/tests/watchkey/test
@@ -16,7 +16,16 @@ BEGIN {
         $v = " ";
     }
 
-    plan tests => 2;
+    $result = system "runcon -t test_watchkey_t $basedir/watchkey $v -c";
+
+    # check if O_NOTIFICATION_PIPE is supported - ENOPKG
+    if ( $result >> 8 eq 65 ) {
+        plan skip_all =>
+"pipe2(2) does not support O_NOTIFICATION_PIPE; CONFIG_WATCH_QUEUE probably not set";
+    }
+    else {
+        plan tests => 2;
+    }
 }
 
 $result = system "runcon -t test_watchkey_t $basedir/watchkey $v";
diff --git a/tests/watchkey/watchkey.c b/tests/watchkey/watchkey.c
index c7f3274..c5db313 100644
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
+		exit(ENOPKG);
+	}
+
 	result = pipe2(pipefd, O_NOTIFICATION_PIPE);
 	if (result < 0) {
 		fprintf(stderr, "Failed to create pipe2(2): %s\n",
-- 
2.36.1

