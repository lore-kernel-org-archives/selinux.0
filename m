Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA314B950
	for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 04:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744778719; cv=pass; b=GouedKz/8LU7C/g56O68FKe6Td84+5SH60mIG+ofjs316UORgl3gJi3BtjPlGVZer7RLf8q0MPtWTn8uJzqwKPODfKjkWrYNdv0oumGMr3cIqaotMWLJXQpC6ZEST8NlDnTkdL4PrJRweXnAhe8TGmGMH99be8zmZb7O6rVo8D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744778719; c=relaxed/simple;
	bh=paS6vfyT4DHVNoue77GXzhRJvgjAR0vBbQ+HHAhbizI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6FaNYY+jnKOoZxHcd/D01eKPbBbN5xgFOvOSsjp3pZySovwkJT4ke+61ePpi+uTyyoZxDnMTbB1My/Xi/zNxMxAspBORnjKeBzI0zoUrprEmz+4n2VNpxXnX8/3dQWWzusdcHO85D77s3cn6kJMe6ACurGqZd6zoGPRvD+lg04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com; spf=pass smtp.mailfrom=midstall.com; dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b=WY6/gYrl; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midstall.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b="WY6/gYrl"
ARC-Seal: i=1; a=rsa-sha256; t=1744778714; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UYy4RFuOAnmU594U9xxqLBAjK6osrGm5n3VOVmqNk/KhqRI/7Na0n5YkBnBu/hM5QFX/o4iORmHAQb54ex7oLQ0LfeEPYS6G8jmu1LZ1Ta5GShKT9hTQk7yVf4IPcVYe0OMVkpcONbB6FQjM/Ow+nynfWq2jBWcyGd7PA7hyVqA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744778714; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/oQhvHriIfsuqW/L25GnO38iXI0f8OpCDU4cLBvfGWs=; 
	b=fo5iUfM8dtK6CHBtYSGNLxrpC4yWlzc045MuU3Jw5MeJKazxRvDMiE5YJr5+Z40QT+koc/Cf4v8Gz2XEHnVtMQO68ZM2fELVoI9mAKa/EnwreV1ORBL64xm6eN/Ft33k/qjMyFTXvBYYMo54zOmso7qbaM4M+GVbEBbMHjXX/W8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=midstall.com;
	spf=pass  smtp.mailfrom=tristan.ross@midstall.com;
	dmarc=pass header.from=<tristan.ross@midstall.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744778714;
	s=zmail; d=midstall.com; i=tristan.ross@midstall.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/oQhvHriIfsuqW/L25GnO38iXI0f8OpCDU4cLBvfGWs=;
	b=WY6/gYrlJ5Dbw4uxfsnot1LK+S0A/k5FQ15dWS10UDg9OdurwLdwd+N545SU4/JV
	HMb4N4TI3NTHDyFkKmjooWZqQtRGXCZdgbjsBSCCCd3sKv6xBrc/EFEoaK7tua4w/Mu
	ZHoK+Da7r6ivsQhatKiIFLbKbd+kT+bZ110ymlcQ=
Received: by mx.zohomail.com with SMTPS id 1744778712976660.9847338723104;
	Tue, 15 Apr 2025 21:45:12 -0700 (PDT)
From: Tristan Ross <tristan.ross@midstall.com>
To: selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: [PATCH] libsemanage: add relabel_store config option
Date: Tue, 15 Apr 2025 21:45:01 -0700
Message-ID: <20250416044501.28631-1-tristan.ross@midstall.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <CAJ2a_DcSrGUFktCNhDBop_EtS-mO4Jgt8r6XMCq+DO-C4K_ZOA@mail.gmail.com>
References: <CAJ2a_DcSrGUFktCNhDBop_EtS-mO4Jgt8r6XMCq+DO-C4K_ZOA@mail.gmail.com>
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
index e1fc9f4f..b69ac75b 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -63,7 +63,7 @@ static int parse_errors;
 
 %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_POLICY MULTIPLE_DECLS
 %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
-%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
+%token BZIP_BLOCKSIZE BZIP_SMALL RELABEL_STORE REMOVE_HLL
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
 %token <s> ARG
@@ -97,6 +97,7 @@ single_opt:     module_store
 	|	bzip_blocksize
 	|	bzip_small
 	|	remove_hll
+	|	relabel_store
 	|	optimize_policy
 	|	multiple_decls
         ;
@@ -291,6 +292,17 @@ remove_hll:  REMOVE_HLL'=' ARG {
 	free($3);
 }
 
+relabel_store:  RELABEL_STORE'=' ARG {
+	if (strcasecmp($3, "false") == 0) {
+		current_conf->relabel_store = 0;
+	} else if (strcasecmp($3, "true") == 0) {
+		current_conf->relabel_store = 1;
+	} else {
+		yyerror("relabel_store can only be 'true' or 'false'");
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
+	conf->relabel_store = 1;
 	conf->optimize_policy = 1;
 	conf->multiple_decls = 1;
 
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index 64433f7b..c592fb63 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
 bzip-blocksize	return BZIP_BLOCKSIZE;
 bzip-small	return BZIP_SMALL;
 remove-hll	return REMOVE_HLL;
+relabel_store	return RELABEL_STORE;
 optimize-policy return OPTIMIZE_POLICY;
 multiple-decls return MULTIPLE_DECLS;
 "[load_policy]"   return LOAD_POLICY_START;
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 5db08f0c..2388faad 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -49,6 +49,7 @@ typedef struct semanage_conf {
 	int ignore_module_cache;
 	int optimize_policy;
 	int multiple_decls;
+	int relabel_store;
 	char *ignoredirs;	/* ";" separated of list for genhomedircon to ignore */
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 307f27f9..1731c5e8 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1823,8 +1823,11 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 
       cleanup:
 	semanage_release_active_lock(sh);
-	sehandle = selinux_restorecon_default_handle();
-	selinux_restorecon_set_sehandle(sehandle);
+
+	if (sh->conf->relabel_store) {
+		sehandle = selinux_restorecon_default_handle();
+		selinux_restorecon_set_sehandle(sehandle);
+	}
 	return retval;
 }
 
-- 
2.47.2

