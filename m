Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F611AB52F
	for <selinux@vger.kernel.org>; Thu, 17 Apr 2025 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744855830; cv=pass; b=KHvBYCtP6VutCn9HmAqr/eHaYcKzJ2bBvquMP8AKBNrzBuS+oyF8BwtX68yYZ2N+o2G6mThrS6d3aUJg5BYLJW02+imjpvvgGFDEzsAY7k57o7lEp8nhy5Vo/jR+9mEpGnKOm6zNhjAYeBoX7+pLu7IlhKfGhWkrsJNmwjL8XBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744855830; c=relaxed/simple;
	bh=loL6F8Psg+Qoyy0GjQG2xDssyKqkHgjuR4jeQJWk0f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9CA+kCMiaSvt1CbAEEh31sHbCEmZi4EYEVldSzv7fBZ+vUsz4PjfDzy9FrB4Rnvpdd2PXeyaAeGxvgaP0g63I1/+qhiI5Qg22iH7/HrOeywSHVtbM1BP3dMWEsyhIsvaaRPPIY+F+chJOA+WaZVgdo00I4BGKkX+I6KyK0CfBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com; spf=pass smtp.mailfrom=midstall.com; dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b=HYUZEDMi; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midstall.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b="HYUZEDMi"
ARC-Seal: i=1; a=rsa-sha256; t=1744855824; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aaWDpEuxjE1b4XY+ImVIxoyLZuWeR9wBP4dpLZ2GOL3AgT6BYouadvNNMrFg5G0nWRGSMDAfA6GzDU9ay0uWYUZUwsstUzu6qkweT9X3H1+eKRmccKbgxF6YQGe8zVyW0lQNe7sY8DRLYvLY66AtHCsCw3No0kDG0HN9IrhslpY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744855824; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/NC5HRApEINUrtYjRyk9eN6B3fphxK+Yq8EhR9Yaz54=; 
	b=egI1pMWUiQ/L4E4BqhIGO/65urI24GOTGR/yuvI1rH7uSrNgLXGc47fOwDCZXHDpT7ytPjxP5M3JwpC9JcGtYjEYnWittnIYENd5INjnY+c/aywt8gChtt6ENN7xTuDI4DIZLvgUq7FZMCAh6C/otZz24kWmmj6EB8kzLtrTJ40=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=midstall.com;
	spf=pass  smtp.mailfrom=tristan.ross@midstall.com;
	dmarc=pass header.from=<tristan.ross@midstall.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744855824;
	s=zmail; d=midstall.com; i=tristan.ross@midstall.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/NC5HRApEINUrtYjRyk9eN6B3fphxK+Yq8EhR9Yaz54=;
	b=HYUZEDMi6f+dCF8/J3YO4lXVaRff/5lhCmCxKM9fp0+hFxAmNEOE2dDCqd0MdFS+
	3JQgxG8Cc4ZzfWC2eTd3D0EmrRE2TE7GIoeaVZm/XXeSEPHzuLBHe6z78w2yFKtINlP
	X7z8JysBxMxRqOMl9lgNrlGg88I4DUe+hWNRKb7k=
Received: by mx.zohomail.com with SMTPS id 1744855821259945.3317974238502;
	Wed, 16 Apr 2025 19:10:21 -0700 (PDT)
From: Tristan Ross <tristan.ross@midstall.com>
To: selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: [PATCH] libsemanage: add relabel_store config option
Date: Wed, 16 Apr 2025 19:10:00 -0700
Message-ID: <20250417020959.43450-2-tristan.ross@midstall.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <CAP+JOzQtrLx8bS6_jb7pRaFzm=PXr9hm=Quy15qCMTFyHd8j9w@mail.gmail.com>
References: <CAP+JOzQtrLx8bS6_jb7pRaFzm=PXr9hm=Quy15qCMTFyHd8j9w@mail.gmail.com>
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

Signed-off-by: Tristan Ross <tristan.ross@midstall.com>
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

