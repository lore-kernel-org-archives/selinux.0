Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5C21255A
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781457363; cv=none; b=eoeCzxXde7/EzvN/1YYyOjfo2lbV0VL+nbqRVpEHyIANTe5XOaKMsBIjJPvwoyyH8nwkW3E+GU/4Vh4ipZ8I3iQvzXtF3dwCbOh3EF5B1eT/nkEw+vSXVCPcHu2KfNlK2cP12PwMhDBaWtEZ/S7J0fYjeahsJBMACPvJPQ8mN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781457363; c=relaxed/simple;
	bh=GZGvyShMY+JTJU/JYr5eUePM+hi9afOnr3rWOGBJyaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2Xri25+z09IZp7XHQw+JlDIOjC3I2d+JhJumdgTtgGm2ncAPeJTgABe1C8znwp/j34s4yIvM4VFc3YHllBeh98ofoo361/Q5vmo17AJzYNrp8xIfgZ80hm6nSaQYsgsCqt2YtgtQ5jf4f3YibHEqv/X3o5w6NF+Qd+tDhyR1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=fvJaXmlW; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="fvJaXmlW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4Oac/bpFz6hdLK++zmygMYwyV1dYmHtlGhaIf64RZVk=; b=fvJaXmlWzAZwPfRRzCa9O0LaJg
	VQDdckX9kFGPiBGy2ortVVvze2qKL2bgNHu3uXqtGwfOyev8m6vJFf+cYCNABUOidVMxKXWUm4O8j
	pTkDpalN4S2nCvP/FZnrFKHxhowkvYjQiCHMBzlVJCcDgARWB/TbH2LEF2I67pNMt7pgp+7X2Rqjq
	9j8Q1khh0TzZ486YTUgOmK31l84fvImYkEbd3IInIvi3AEytds/tRiL9brMuMrIXhhNzX4wBs0lqh
	CHyu0cULuADQ/jXs6SvuqcJOXlanuQOwlGHTEnbzk4dBbFor1QkgQghHMnD92MmI5EtIeno1qXoA+
	vtTrHHGA==;
Received: from [87.95.76.183] (port=4457 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYoRD-00000008rUA-1PLn;
	Sun, 14 Jun 2026 20:15:59 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] mcstrans: use bool instead of int
Date: Sun, 14 Jun 2026 20:15:48 +0300
Message-ID: <20260614171548.21200-1-kalevi@kolttonen.fi>
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

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 mcstrans/src/mcstransd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index 2d07b3af..f413e50e 100644
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
+static volatile bool restart_daemon = false;
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

