Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AFA267B9F
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396543; cv=pass; b=A+xfztd1tev2fUPgtd9NHxO0S+zgsgtbC1gumyegNxuVD+SumYPBXlFG09kGHRWpdbJR09VGMHMPISsOtQJ+aTdGngRMgp0DkC+J+C3+NpNG5XVOEAFycYIYbsZiD9NaucSe90+swJmUy5dqoxKcl2qHiGITS6RXZSxBqBUtqyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396543; c=relaxed/simple;
	bh=WkVfxxST9Yv0qrXbaImsNkqNrHyWlOxC66TmBpA6enY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuhksmVmg6Y5VNm5sSKyP/unoLtmb1uQjj2oZibsz+lHfC/SRNCD3cVSx8MDmn32317KBywTNR6iEoRuOlyDPxtdPvyAaMdkVU89xowDDm+8NR8djNwuuKCmkDt1TS94JFHkM/ya7lDD2gVMT7252uuk+mvGt2S37vLtTVlNvjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com; spf=pass smtp.mailfrom=midstall.com; dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b=UC+vS9VL; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midstall.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b="UC+vS9VL"
ARC-Seal: i=1; a=rsa-sha256; t=1744396537; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FfUrCIwV3V3YtKb2vowMXntF4cmqMCmBQGoYHP3z4Q0a1qjAABHdBDqwhnEaadzvvc81j2aIjtHa6bWflfCYbweAa3Kv2+jO3dE30nbaPu/yNrdk3X0AJkZhukSJ2blfWLEdXZXnQnhIwWUYCi2F80TjIGvnNMHvVBVJWAvFiA4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744396537; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=I+KNv3pnioiboTqY/M5PjvJMyyaTqO6iN4lZqti2nF0=; 
	b=e2uP+RjNMZlXdejw1ABt4FDY1xkGXxdKdOOmhF6gLu8g/pgEWDU+30tzxNVk8/psDxep3Bp8rTe4n+2yZ60VfbXO2Wuc41Jc0kn+6Y9sRdLHZ/mx3c2639FRQkqxOdI8zXslkOoY7PCGeF7NBW0bi9no58znbAz9S5ol2gN1ZBE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=midstall.com;
	spf=pass  smtp.mailfrom=tristan.ross@midstall.com;
	dmarc=pass header.from=<tristan.ross@midstall.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744396537;
	s=zmail; d=midstall.com; i=tristan.ross@midstall.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=I+KNv3pnioiboTqY/M5PjvJMyyaTqO6iN4lZqti2nF0=;
	b=UC+vS9VL8vD2gekPYP2rXUzC4YwG+nbhKU3PMnxos5dg82HaN4/dP27OYf4Zi55b
	J2cCrvKWpKqE66rAoA/2kJ+PZhFOLRJpmCQppu3Z6vsf+thZ809QJsfnfJ4C2WmugCg
	NePEpGT1nJSvyIbMsE0HJn4jIWKMts1UU5DRxROo=
Received: by mx.zohomail.com with SMTPS id 1744396534694725.693681986056;
	Fri, 11 Apr 2025 11:35:34 -0700 (PDT)
From: Tristan Ross <tristan.ross@midstall.com>
To: selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: [PATCH] libsemanage: add restorecon config option
Date: Fri, 11 Apr 2025 11:35:32 -0700
Message-ID: <20250411183532.42053-1-tristan.ross@midstall.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This flag allows for enabling or disabling automatic restorecon that
semodule invokes. By default, we have it enabled to produce the same
behavior as before. On NixOS, we need this as we're "baking" the module
installation into a squashfs image and we cannot run restorecon inside
the builder.
---
 libsemanage/src/conf-parse.y     | 15 ++++++++++++++-
 libsemanage/src/conf-scan.l      |  1 +
 libsemanage/src/semanage_conf.h  |  1 +
 libsemanage/src/semanage_store.c |  7 +++++--
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index e1fc9f4f..a44e4593 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -63,7 +63,7 @@ static int parse_errors;
 
 %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_POLICY MULTIPLE_DECLS
 %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
-%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
+%token BZIP_BLOCKSIZE BZIP_SMALL RESTORECON REMOVE_HLL
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
 %token <s> ARG
@@ -97,6 +97,7 @@ single_opt:     module_store
 	|	bzip_blocksize
 	|	bzip_small
 	|	remove_hll
+	|	restorecon
 	|	optimize_policy
 	|	multiple_decls
         ;
@@ -291,6 +292,17 @@ remove_hll:  REMOVE_HLL'=' ARG {
 	free($3);
 }
 
+restorecon:  RESTORECON'=' ARG {
+	if (strcasecmp($3, "false") == 0) {
+		current_conf->restorecon = 0;
+	} else if (strcasecmp($3, "true") == 0) {
+		current_conf->restorecon = 1;
+	} else {
+		yyerror("restorecon can only be 'true' or 'false'");
+	}
+	free($3);
+}
+
 optimize_policy:  OPTIMIZE_POLICY '=' ARG {
 	if (strcasecmp($3, "false") == 0) {
 		current_conf->optimize_policy = 0;
@@ -400,6 +412,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	conf->bzip_small = 0;
 	conf->ignore_module_cache = 0;
 	conf->remove_hll = 0;
+	conf->restorecon = 1;
 	conf->optimize_policy = 1;
 	conf->multiple_decls = 1;
 
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index 64433f7b..a180f01f 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
 bzip-blocksize	return BZIP_BLOCKSIZE;
 bzip-small	return BZIP_SMALL;
 remove-hll	return REMOVE_HLL;
+restorecon	return RESTORECON;
 optimize-policy return OPTIMIZE_POLICY;
 multiple-decls return MULTIPLE_DECLS;
 "[load_policy]"   return LOAD_POLICY_START;
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 5db08f0c..ef4534f8 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -49,6 +49,7 @@ typedef struct semanage_conf {
 	int ignore_module_cache;
 	int optimize_policy;
 	int multiple_decls;
+	int restorecon;
 	char *ignoredirs;	/* ";" separated of list for genhomedircon to ignore */
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 307f27f9..dee8b5e7 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1823,8 +1823,11 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 
       cleanup:
 	semanage_release_active_lock(sh);
-	sehandle = selinux_restorecon_default_handle();
-	selinux_restorecon_set_sehandle(sehandle);
+
+	if (sh->conf->restorecon) {
+		sehandle = selinux_restorecon_default_handle();
+		selinux_restorecon_set_sehandle(sehandle);
+	}
 	return retval;
 }
 
-- 
2.47.2

