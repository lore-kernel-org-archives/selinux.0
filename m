Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52927274B28
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085060; cv=none; b=sLzw0WWI4PkRMVi/n63PV51t4kY211M6J9WAN87yBs4u/ki3VTZlHJSuomKCZEfX3K7GhLzPzeSFY83l7XoFR0D6Ua+igW7tINBL9oY/8foUNa1nmfXYtCveTC0zGYJ0q6xD2RbfuBQHSKOTmfDvcJ2Hk4mzY0vCzn5GmVOP0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085060; c=relaxed/simple;
	bh=133gOxUIgJpo+5a+A4n/ZIvFA8z45wUtzkFSdmHUivI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXT+XEB0wi/hHl3s4kbqL/ExSl4Iheb/HZ5hwplVbcQCywy8UpztwIJVkX7yyzsxRgVFx57Fo5ER+luog6Zk8xSvwP26vzW9Tyv6PGRjNlyg3qD/8TRphSu1sj1jagAwZYbQnBO/zmMdats6M3ytF05O6RuxFVLX0DfKbvfaLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=fITQrUnP; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="fITQrUnP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z90JQudf9fdDGF/qlpskhaVzYAQAOT+Px+j/Ik9P1pE=; b=fITQrUnPo9SGOmAw+EwyWk40+a
	xfZBD5lzZa/XxeK8Q2XUjHv0iFg74AoJH1hK6qQypcjFCjIeddeMtwwO/lwNoabfz6oejbyBjzlpm
	Qe90fNMAaM43ln14M9EGtnen8szz5C1Jao4i/yOAxxSDneXxgBFfW6VxnwS6+Jvp2H7n4aCt8yrZ6
	y+gR2DJ/C48hSJP5x6lgIDkZjv3cmd61CbXEb405gQfRRVCFgRekPRAKs9u5mP/Dy1P34E0RGTn4S
	HdzXQtkCkcfahVpp4QMf4bqNuBV3i48RDZo/Q5ID/YSYaKlp47Cqivk0JgjXEJwJI1XpURHREm4It
	Bogpup2Q==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11491 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKf9B-00000002PGJ-1dOu;
	Wed, 06 May 2026 19:30:53 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] libsemanage: use 'bool' for boolean options
Date: Wed,  6 May 2026 19:30:42 +0300
Message-ID: <20260506163042.83573-1-kalevi@kolttonen.fi>
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
---
 libsemanage/src/conf-parse.y    | 67 ++++++++++++++++++---------------
 libsemanage/src/semanage_conf.h | 20 +++++-----
 2 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index b69ac75b..4520ef91 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -132,9 +132,9 @@ compiler_dir:       COMPILER_DIR '=' ARG  {
 
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
@@ -195,9 +195,9 @@ file_mode:   FILE_MODE '=' ARG  {
 
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
@@ -208,9 +208,9 @@ save_previous:    SAVE_PREVIOUS '=' ARG {
 
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
@@ -220,9 +220,9 @@ save_linked:    SAVE_LINKED '=' ARG {
 
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
@@ -231,9 +231,9 @@ disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
 
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
@@ -272,9 +272,9 @@ bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
 
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
@@ -283,9 +283,9 @@ bzip_small:  BZIP_SMALL '=' ARG {
 
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
@@ -294,9 +294,9 @@ remove_hll:  REMOVE_HLL'=' ARG {
 
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
@@ -305,9 +305,9 @@ relabel_store:  RELABEL_STORE'=' ARG {
 
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
@@ -316,9 +316,9 @@ optimize_policy:  OPTIMIZE_POLICY '=' ARG {
 
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
@@ -398,26 +398,33 @@ static int semanage_conf_init(semanage_conf_t * conf)
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
index 2388faad..87e56e4c 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -37,19 +37,19 @@ typedef struct semanage_conf {
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

