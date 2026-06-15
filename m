Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3283F8249
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541592; cv=none; b=Qprh82fOTqAVV4GE6bns26vKQ+rEdQGGwNRkI/5Wswc0lISU1A6c+WVwEBqKBGiqn+plHLIRRp+WfZie33P6tDxLfKWX8w0LGdNmnGXJb76Hh6xxzertaDzQeaV8UUnlWXQL2Kur6DqKwz1hDY1xAf/xVPuLONIy+c10Nbd3ZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541592; c=relaxed/simple;
	bh=jLf5rDhS1KnKGu1+4KYMS5j5NPPXo+iSfCewmgzJEiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFJtgmfxH69KIxicueLAlG8L/6HMB/uZL1CRoXt/ZkbuH2OEb0VS/8kL8xsRtwG8LxsHeflBK9+nqgEiMLYawAKztXtzLwBB7b3D1R/amTLClrqFo2Z9eD+/zSgY1MTt7UZ5rkMl4tR6VjBO/Fm0U+AZ+/gjZbuhcUh1PTZ+v6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=e+EugLZ9; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="e+EugLZ9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0IPlKHPqGYOVnuT5Q3AwxnXKtJdJbV4KgvszLE7VP8w=; b=e+EugLZ9f0zSrzq+nijzyfUC5V
	n///VLcV6EOOe4n2X7Dttn8hYUOtBAaekU7SvoXUyUrHWax6qKA9OKeEkQW2KEkL9x3JgKIa8XrA/
	/v+kvKty+20R/bxuxIHiI11nJ3uwMwuqWFE+u9ema9WXYO0fCg9ZOMX98epSyz3iTEfXXpu1mKVBJ
	7zJGVp2qRn1sazlWjv88SMeHrdOXkBbeilzr5TxF5oyU8VfPqwEZ29haS5TcTGJglKqI/d1anzEY8
	kC1O/uN1gf72yrb10m3fivPFjjiwa186MuZCf1MQpETxtiec8EL33wOSsQMJ5R5iSol/9VBghc2y6
	72GecjxQ==;
Received: from [87.95.76.183] (port=4306 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wZALd-0000000DINy-369p;
	Mon, 15 Jun 2026 19:39:41 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] mcstrans: use sig_atomic_t and bool instead of int
Date: Mon, 15 Jun 2026 19:39:37 +0300
Message-ID: <20260615163937.38919-1-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Use sig_atomic_t to be async signal safe. Use bool instead
of int to make boolean intent clearer.

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 mcstrans/src/mcstransd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index 2d07b3af..5bdaadb7 100644
--- a/mcstrans/src/mcstransd.c
+++ b/mcstrans/src/mcstransd.c
@@ -2,6 +2,7 @@
 #include <errno.h>
 #include <poll.h>
 #include <signal.h>
+#include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -56,7 +57,7 @@
 
 static int sockfd = -1; /* socket we are listening on */
 
-static volatile int restart_daemon = 0;
+static volatile sig_atomic_t restart_daemon = false;
 static void cleanup_exit(int ret) __attribute__((noreturn));
 static void cleanup_exit(int ret)
 {
@@ -421,7 +422,7 @@ static void process_connections(void)
 				syslog(LOG_ERR,
 				       "No color information will be available");
 			}
-			restart_daemon = 0;
+			restart_daemon = false;
 		}
 
 		ret = poll(ufds, nfds, -1);
@@ -450,7 +451,7 @@ static void sigterm_handler(int UNUSED(sig))
 
 static void sighup_handler(int UNUSED(sig))
 {
-	restart_daemon = 1;
+	restart_daemon = true;
 }
 
 static void initialize(void)
@@ -551,11 +552,11 @@ static void usage(char *program)
 int main(int argc, char *argv[])
 {
 	int opt;
-	int do_fork = 1;
+	bool do_fork = true;
 	while ((opt = getopt(argc, argv, "hf")) > 0) {
 		switch (opt) {
 		case 'f':
-			do_fork = 0;
+			do_fork = false;
 			break;
 		case 'h':
 			usage(argv[0]);
-- 
2.54.0

