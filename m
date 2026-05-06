Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4617D34B1A6
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778097521; cv=none; b=WDLLrQzbyTjeIQNpqM4RI/7o3oR3RWDn3OlkYBpr6Ukm6Jb9aSMmLjn/qj6kbLQff2YteRzeIltc+VC6o9hFEXMuBMjZU6oe2TqbsfnOuox7++R2RC70ExfFmPuprTF5+nFKXPN+j6PeFiw3Kh7gN8v1Ok36wN8HbQfU93oI4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778097521; c=relaxed/simple;
	bh=O0fPl+7CBNlKRf7wULIntJDpCRPoyZfjJLdyaY1LvVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NNiKy7MW1VMEvmy6qf602vCe0C8Pv8N5JdOm1wVC60ZEhvy4+50Bo0lcnp8u76yYarS538JZFMy+PZX0OTprpZECOQxk7vaiygNLrGE2wbIg3KHRLehihqJRP+AY0uBgtpAorRZ3baF/EEbrkuko70IE55m9IvILt+7vdDV6plo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=bwG8SqYr; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="bwG8SqYr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5UP2jIQ414+HrDwKlKTj8JNnRoIWLg8IgU2FLEVmXYg=; b=bwG8SqYruYlpySNZXwI4WT1PuI
	Qo3lRJqXj1bq0jCD4235rYLuiZ0zN3J52jpWD+ha86nMJVz5VzWpiI+UCRbbGhXFygc9mEcqKuYi3
	Z1XSMMyjZQZJ7RP2ezjF26JHZVNY3J/jDRrsOmGUPqpvyzuLlgjWPfbXX5FRv/O51+vk+c/aUYFo6
	yvLAuC93nkLCYMR9m00FZEHpCk/l4a6fKOMrLwFLftTL+txIv5+qSC1VzhqiJA9F84/7era+MDSrU
	hG6/OHYQzrdgZckQMtKPWP2W5vxXa9zYs5mIHbzlqRmTFGmAmOv+T/IV4G8Pl2mf5JiKGPtYk73bj
	gNBHQ5Ng==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11730 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKiOE-00000003p1C-1plw;
	Wed, 06 May 2026 22:58:38 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH v2] libsemanage: make expand-check a proper boolean option
Date: Wed,  6 May 2026 22:58:34 +0300
Message-ID: <20260506195834.19-1-kalevi@kolttonen.fi>
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
the values "1" and "0".

Add missing <stdbool.h> include.

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 libsemanage/src/conf-parse.y    | 22 +++++++++++++---------
 libsemanage/src/semanage_conf.h |  3 ++-
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index b69ac75b..3cd2b7a9 100644
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
+				yyerror("expand-check can only be 'true' or 'false'");
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

