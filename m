Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D93ACEE6
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792201; cv=none; b=fHq42Kef7x8pFIdXvJ07qFcUJaot/uW/Iix7so3fBYPqNwdOxqJcpa2kSv4O76brBwwrnKFI276Xw2StwaB2bLw0uUmyQLGxoHwJQiRHgCzf3NsneswToxlaymcm81oNFQ8LClFkAFmQwi1SIfB2HkrjIXGhCWRsRCOYkmvn1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792201; c=relaxed/simple;
	bh=bZh37FBBn6exK/XwnzSwThjXC0FvLa7kdujNEJhSKPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g01TG6NLRV3Y///hFJ+066HCMCtJG5peMbIW+g4CheR3EtrvmDStOrfU6GUFvKHe+UpiThU8R+PJVjuCtV9t8m9HzIRc9jMlC3HXoZUNRozHeFhFL9UB/33/UTuZjTJbHOW4MTUg5mQ8qKfFpJnBw42j5UYxmFNzqBw7DKCG5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=JMfzLy0E; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="JMfzLy0E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YTL0Q9puqH/tAdM5ky4pq5c4GJ3OI1/aspkapzKoJWQ=; b=JMfzLy0EW6osysN51tvrGkG8q+
	M2+pHJJa92RGbuaoNkggqfgy3LWIWAKhBuobbo/vMT2rvyhXTzkoSkCq5ksvN2hAHnW7wWs6UP/kB
	MSn5GifhDoObOrBxPTBixkyLsFhKByXuhnczJvQt3MXludEcF0qclT3bbX7gZxOERHsXYVld0sYzJ
	NhKRUsez8fY4zQqMz3MmWr4XK6nhL1kEp8XZ5JPvflNHjMX3Izj49oNUireKiLjqn3Nz9+HMo3Cn+
	pL9YzgUkxcUgX9ZtBy7vKWMKntrB+PVAbxELCJtV7UxsuMm9mk6FN6EfKeaszpJjymVQS2e9/ui6f
	NFiQdxqQ==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11310 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wNd6o-0000000E48B-3weh;
	Thu, 14 May 2026 23:56:38 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH v3] libsemanage: make expand-check a proper boolean option
Date: Thu, 14 May 2026 23:56:31 +0300
Message-ID: <20260514205631.76858-1-kalevi@kolttonen.fi>
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

Make expand-check configuration option accept values
'true' and 'false' for consistency with the rest of
the boolean options. Preserve backwards compatibility
with old configuration file settings by still accepting
the values "1" and "0". Edit man page to reflect the changes.

Add missing <stdbool.h> include.

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 libsemanage/man/man5/semanage.conf.5 |  2 +-
 libsemanage/src/conf-parse.y         | 22 +++++++++++++---------
 libsemanage/src/semanage_conf.h      |  3 ++-
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index b22e65bd..74f0d34f 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -59,7 +59,7 @@ The target platform to generate policies for. Valid values are "selinux" and "xe
 .B expand-check
 Whether or not to check "neverallow" rules when executing all
 .BR semanage
-command. It can be set to either "0" (disabled) or "1" (enabled) and by default it is enabled. There might be a large
+command. It can be set to either "0" / "false" (disabled) or "1" / "true" (enabled) and by default it is enabled. There might be a large
 penalty in execution time if this option is enabled.
 
 .TP
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index b69ac75b..70691fa5 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -29,6 +29,7 @@
 
 #include <errno.h>
 #include <unistd.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -168,15 +169,18 @@ target_platform: TARGET_PLATFORM '=' ARG  {
         ;
 
 expand_check:   EXPAND_CHECK '=' ARG  {
-                        char *endptr;
-                        long value;
-                        errno = 0;
-                        value = strtol($3, &endptr, 10);
-                        if (*endptr != '\0' || errno != 0 || (value != 0 && value != 1))
-                                yyerror("expand-check can only be '1' or '0'");
-                        else
-                                current_conf->expand_check = value;
-                        free($3);
+	                if (strcasecmp($3, "true") == 0)
+		                current_conf->expand_check = true;
+			else if (strcmp($3, "1") == 0)
+		                current_conf->expand_check = true;
+			else if (strcasecmp($3, "false") == 0)
+		                current_conf->expand_check = false;
+			else if (strcmp($3, "0") == 0)
+		                current_conf->expand_check = false;
+			else {
+				yyerror("expand-check can only be 'true', '1', 'false' or '0'");
+			}
+			free($3);
                 }
         ;
 
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 2388faad..f9e330b7 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -21,6 +21,7 @@
 #define SEMANAGE_CONF_H
 
 #include <semanage/handle.h>
+#include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 
@@ -36,7 +37,7 @@ typedef struct semanage_conf {
 	int server_port;
 	int policyvers;		/* version for server generated policies */
 	int target_platform;
-	int expand_check;
+	bool expand_check;
 	int save_previous;
 	int save_linked;
 	int disable_genhomedircon;
-- 
2.54.0

