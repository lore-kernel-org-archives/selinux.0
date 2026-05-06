Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C733E35F
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778097515; cv=none; b=QGPt9NO0dwp5yhVr5pWzR6T/1X6M+vg7RSxPTRh/ukcGT7ixu9dUGZNKWMekq+jIJhrwXBafxxPRcV+puqufxMXLVwp8eVmU8cuVOriK9ptcssDtqgurq6/gs9ykBPLh/L7W3Y1zqR6cd2LXJsdBLRiUpWa+JwkfhQKt5/MuClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778097515; c=relaxed/simple;
	bh=6L0K3U7/ZCkybMi7JxqzMEEolAw8VJxHKcZzxhDmJ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2B/FtVdR0WTOo5FqFJgAj9RlymSHtvl5ZmR5C3i7SrI3bxP9hegVvmA9N1tiM/jDDBcLihXsldK+wgzdNZtPkfb/PHiKZN4XcJ2ZQ9YJWdlhSM1Cf6coiY3smvFPpNjdUFgHOGOO/u1/6w+EbQcvUGGessNh74ZqHoMfnutfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=dyLd+4O1; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="dyLd+4O1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ao8bwuvmF1X81cmV+szgppuvC6++XaeSANQ/Hi/R6vQ=; b=dyLd+4O16OFFLjtb8ZzNoew/vO
	7S6RuApqCMdQtIim8lpLQP50B/APh5vPxVlFGb5QmgeETaoqBaEZtoQd+nO7w0jIqVD25u5Se8Gx1
	6B0HHeiGHdc4veDlDdSjTLBt5kxpIp4Vnt0/MlOxgTEDqQ8CiQbBsJpBsSk//NKd011NmihRvWV83
	bSqIQiyN3qd3EaDiGqoJFGeP1g4nZJqbpUGHbCTBTOod1A2oorkSNI2n2u/N2TU6LkSyP7G5VmI3y
	ZuB+q5tfU6IcLIuRw7Qe2XfSzjNh3xUB4eC3RGUI0A9Nm0w/5Oy0zlYJdtSRXO18F4P+eD+7k667o
	/2HAsyRg==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11722 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKiO1-00000003oxi-3vgy;
	Wed, 06 May 2026 22:58:26 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH v2] libsemanage: use 'bool' for boolean options
Date: Wed,  6 May 2026 22:58:18 +0300
Message-ID: <20260506195818.93622-1-kalevi@kolttonen.fi>
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

Use 'bool' for boolean options. Check strdup() failures.
Add explicit 'conf->disable_genhomedircon = false' default
initialization.

Add missing <stdbool.h> include.

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 libsemanage/src/conf-parse.y    | 68 ++++++++++++++++++---------------
 libsemanage/src/semanage_conf.h | 21 +++++-----
 2 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index b69ac75b..0f10546e 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -29,6 +29,7 @@
 
 #include <errno.h>
 #include <unistd.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -132,9 +133,9 @@ compiler_dir:       COMPILER_DIR '=' ARG  {
 
 ignore_module_cache:	IGNORE_MODULE_CACHE '=' ARG  {
 							if (strcasecmp($3, "true") == 0)
-								current_conf->ignore_module_cache = 1;
+								current_conf->ignore_module_cache = true;
 							else if (strcasecmp($3, "false") == 0)
-								current_conf->ignore_module_cache = 0;
+								current_conf->ignore_module_cache = false;
 							else {
 								yyerror("disable-caching can only be 'true' or 'false'");
 							}
@@ -195,9 +196,9 @@ file_mode:   FILE_MODE '=' ARG  {
 
 save_previous:    SAVE_PREVIOUS '=' ARG {
 	                if (strcasecmp($3, "true") == 0)
-		                current_conf->save_previous = 1;
+		                current_conf->save_previous = true;
 			else if (strcasecmp($3, "false") == 0)
-				current_conf->save_previous = 0;
+				current_conf->save_previous = false;
 			else {
 				yyerror("save-previous can only be 'true' or 'false'");
 			}
@@ -208,9 +209,9 @@ save_previous:    SAVE_PREVIOUS '=' ARG {
 
 save_linked:    SAVE_LINKED '=' ARG {
 	                if (strcasecmp($3, "true") == 0)
-		                current_conf->save_linked = 1;
+		                current_conf->save_linked = true;
 			else if (strcasecmp($3, "false") == 0)
-				current_conf->save_linked = 0;
+				current_conf->save_linked = false;
 			else {
 				yyerror("save-linked can only be 'true' or 'false'");
 			}
@@ -220,9 +221,9 @@ save_linked:    SAVE_LINKED '=' ARG {
 
 disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
 	if (strcasecmp($3, "false") == 0) {
-		current_conf->disable_genhomedircon = 0;
+		current_conf->disable_genhomedircon = false;
 	} else if (strcasecmp($3, "true") == 0) {
-		current_conf->disable_genhomedircon = 1;
+		current_conf->disable_genhomedircon = true;
 	} else {
 		yyerror("disable-genhomedircon can only be 'true' or 'false'");
 	}
@@ -231,9 +232,9 @@ disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
 
 usepasswd: USEPASSWD '=' ARG {
 	if (strcasecmp($3, "false") == 0) {
-		current_conf->usepasswd = 0;
+		current_conf->usepasswd = false;
 	} else if (strcasecmp($3, "true") == 0) {
-		current_conf->usepasswd = 1;
+		current_conf->usepasswd = true;
 	} else {
 		yyerror("usepasswd can only be 'true' or 'false'");
 	}
@@ -272,9 +273,9 @@ bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
 
 bzip_small:  BZIP_SMALL '=' ARG {
 	if (strcasecmp($3, "false") == 0) {
-		current_conf->bzip_small = 0;
+		current_conf->bzip_small = false;
 	} else if (strcasecmp($3, "true") == 0) {
-		current_conf->bzip_small = 1;
+		current_conf->bzip_small = true;
 	} else {
 		yyerror("bzip-small can only be 'true' or 'false'");
 	}
@@ -283,9 +284,9 @@ bzip_small:  BZIP_SMALL '=' ARG {
 
 remove_hll:  REMOVE_HLL'=' ARG {
 	if (strcasecmp($3, "false") == 0) {
-		current_conf->remove_hll = 0;
+		current_conf->remove_hll = false;
 	} else if (strcasecmp($3, "true") == 0) {
-		current_conf->remove_hll = 1;
+		current_conf->remove_hll = true;
 	} else {
 		yyerror("remove-hll can only be 'true' or 'false'");
 	}
@@ -294,9 +295,9 @@ remove_hll:  REMOVE_HLL'=' ARG {
 
 relabel_store:  RELABEL_STORE'=' ARG {
 	if (strcasecmp($3, "false") == 0) {
-		current_conf->relabel_store = 0;
+		current_conf->relabel_store = false;
 	} else if (strcasecmp($3, "true") == 0) {
-		current_conf->relabel_store = 1;
+		current_conf->relabel_store = true;
 	} else {
 		yyerror("relabel_store can only be 'true' or 'false'");
 	}
@@ -305,9 +306,9 @@ relabel_store:  RELABEL_STORE'=' ARG {
 
 optimize_policy:  OPTIMIZE_POLICY '=' ARG {
 	if (strcasecmp($3, "false") == 0) {
-		current_conf->optimize_policy = 0;
+		current_conf->optimize_policy = false;
 	} else if (strcasecmp($3, "true") == 0) {
-		current_conf->optimize_policy = 1;
+		current_conf->optimize_policy = true;
 	} else {
 		yyerror("optimize-policy can only be 'true' or 'false'");
 	}
@@ -316,9 +317,9 @@ optimize_policy:  OPTIMIZE_POLICY '=' ARG {
 
 multiple_decls:  MULTIPLE_DECLS '=' ARG {
 	if (strcasecmp($3, "false") == 0) {
-		current_conf->multiple_decls = 0;
+		current_conf->multiple_decls = false;
 	} else if (strcasecmp($3, "true") == 0) {
-		current_conf->multiple_decls = 1;
+		current_conf->multiple_decls = true;
 	} else {
 		yyerror("multiple-decls can only be 'true' or 'false'");
 	}
@@ -398,26 +399,33 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	const char *policy_root = selinux_policy_root();
 	if (policy_root != NULL) {
 		conf->store_path = strdup(semanage_basename(policy_root));
+		if (!conf->store_path)
+			return -1;
 	}
 	conf->ignoredirs = NULL;
 	conf->store_root_path = strdup("/var/lib/selinux");
+	if (!conf->store_root_path)
+		return -1;
 	conf->compiler_directory_path = strdup("/usr/libexec/selinux/hll");
+	if (!conf->compiler_directory_path)
+		return -1;
 	conf->policyvers = sepol_policy_kern_vers_max();
 	conf->target_platform = SEPOL_TARGET_SELINUX;
 	conf->expand_check = 1;
 	conf->handle_unknown = -1;
-	conf->usepasswd = 1;
+	conf->usepasswd = true;
 	conf->file_mode = 0644;
 	conf->bzip_blocksize = 9;
-	conf->bzip_small = 0;
-	conf->ignore_module_cache = 0;
-	conf->remove_hll = 0;
-	conf->relabel_store = 1;
-	conf->optimize_policy = 1;
-	conf->multiple_decls = 1;
-
-	conf->save_previous = 0;
-	conf->save_linked = 0;
+	conf->bzip_small = false;
+	conf->ignore_module_cache = false;
+	conf->remove_hll = false;
+	conf->relabel_store = true;
+	conf->optimize_policy = true;
+	conf->multiple_decls = true;
+
+	conf->save_previous = false;
+	conf->save_linked = false;
+	conf->disable_genhomedircon = false;
 
 	if (!conf->store_path ||
 	    !conf->store_root_path ||
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 2388faad..4df9b195 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -21,6 +21,7 @@
 #define SEMANAGE_CONF_H
 
 #include <semanage/handle.h>
+#include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 
@@ -37,19 +38,19 @@ typedef struct semanage_conf {
 	int policyvers;		/* version for server generated policies */
 	int target_platform;
 	int expand_check;
-	int save_previous;
-	int save_linked;
-	int disable_genhomedircon;
-	int usepasswd;
+	bool save_previous;
+	bool save_linked;
+	bool disable_genhomedircon;
+	bool usepasswd;
 	int handle_unknown;
 	mode_t file_mode;
 	int bzip_blocksize;
-	int bzip_small;
-	int remove_hll;
-	int ignore_module_cache;
-	int optimize_policy;
-	int multiple_decls;
-	int relabel_store;
+	bool bzip_small;
+	bool remove_hll;
+	bool ignore_module_cache;
+	bool optimize_policy;
+	bool multiple_decls;
+	bool relabel_store;
 	char *ignoredirs;	/* ";" separated of list for genhomedircon to ignore */
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
-- 
2.54.0

