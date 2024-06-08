Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990612B95
	for <selinux@vger.kernel.org>; Sat,  8 Jun 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867419; cv=none; b=kZCGH2O/6/iC+QNCBsRSNM/m5cnc/lL/RHOwIUIcPGNXsTuwSkucNomTK4I6GJfsdZKLoyDcL1VLKpbm57clUTS0cdptwH714WnfVMmZrn/i/KJUF06ENuaSedBxWp2NYSXQuIGPPYyj7Kps7BxJVfHIHg/xUsOXJOUdiJxEYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867419; c=relaxed/simple;
	bh=wpMDQbTvH7uGALA/Pi87nvQeaHCH+KBj6JeNqN97ySc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZljQuVoftboliPqLy9eXAbnSee6KW8MYabGgluJ2hPKLmYVtZE0oACIs3dQkvVJB8jq3AqKfU1eOOjIZRFTT91hoiFOhGdJxDsqQgVXVVF9QyfyX9UUMOx+oPFj6fViWvwa8ZsVed/YsaDu0vFy+4GxvuebO8WNMz/Mg6GIYqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=HMSmsNSL; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="HMSmsNSL"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1717867415;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qwRs4vr2pOONLKoBThP6p/L6sGiNrBfO5ZGPqW7RtfU=;
	b=HMSmsNSLeby8ld8fi5PcI6WdOJeInu7m8Xyz9ZpEZjeuf/+paUCCFNmK0QFBvHKPFXzOUM
	GdTHSv31ivME1tgcXtShVNfxJ/6hlIRpPj9gcQooL7/x53n47buJ2Qe3zE5/wdu/olqdKt
	mwDSNrdqKiZP2ETm/GmlH5FmlIeXgUGds0cF10iV0IhEyux0fvskDPGxmW4tiSQvNnmizw
	sOE+kN+zSI8JUaJXYkdrJIHgV2kuiDSGTfXomnsEckfZyr197KNXbRSUCedJNGYEjZK/Jg
	hUdmVO4pV7b/VgnG9GnVphKb7CrAiMJQJwBcyG/jeng6AFv387lJkRQ91SYaQQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] tree-wide: fix misc typos
Date: Sat,  8 Jun 2024 19:23:32 +0200
Message-ID: <20240608172332.140336-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/sefcontext_compile.c | 2 +-
 libsepol/src/kernel_to_cil.c          | 4 ++--
 libsepol/src/kernel_to_conf.c         | 4 ++--
 secilc/docs/cil_reference_guide.md    | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 6c32172d..8677189e 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -189,7 +189,7 @@ static int write_binary_file(struct saved_data *data, int fd,
 		if (len != 1)
 			goto err;
 
-		/* original context strin (including nul) */
+		/* original context string (including nul) */
 		len = fwrite(context, sizeof(char), to_write, bin_file);
 		if (len != to_write)
 			goto err;
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index e20ba4af..f94cb245 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -303,7 +303,7 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 			goto exit;
 		}
 		if (*perms == '\0') {
-			ERR(NULL, "No permisisons in permission string");
+			ERR(NULL, "No permissions in permission string");
 			free(perms);
 			rc = -1;
 			goto exit;
@@ -1782,7 +1782,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 			goto exit;
 		}
 		if (*perms == '\0') {
-			ERR(NULL, "No permisisons in permission string");
+			ERR(NULL, "No permissions in permission string");
 			free(perms);
 			goto exit;
 		}
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 5860a513..ca91ffae 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -298,7 +298,7 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 			goto exit;
 		}
 		if (*perms == '\0') {
-			ERR(NULL, "No permisisons in permission string");
+			ERR(NULL, "No permissions in permission string");
 			free(perms);
 			rc = -1;
 			goto exit;
@@ -1748,7 +1748,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 			goto exit;
 		}
 		if (*permstring == '\0') {
-			ERR(NULL, "No permisisons in permission string");
+			ERR(NULL, "No permissions in permission string");
 			free(permstring);
 			goto exit;
 		}
diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_reference_guide.md
index d1d3ff16..5ae5a3a3 100644
--- a/secilc/docs/cil_reference_guide.md
+++ b/secilc/docs/cil_reference_guide.md
@@ -281,7 +281,7 @@ The number of `expr_set`'s in an `expr` is dependent on the statement type (ther
         (mlsconstrain (process (transition dyntransition))
             (or (and (eq h1 h2) (eq l1 l2)) (eq t1 mlstrustedsubject)))
 
-        ; The equivalent policy language mlsconstrain statememt is:
+        ; The equivalent policy language mlsconstrain statement is:
         ;mlsconstrain process { transition dyntransition }
         ;    ((h1 eq h2 and l1 eq l2) or t1 == mlstrustedsubject);
 
@@ -289,7 +289,7 @@ The number of `expr_set`'s in an `expr` is dependent on the statement type (ther
         (mlsconstrain (process (getsched getsession getpgid getcap getattr ptrace share))
             (or (dom l1 l2) (eq t1 mlstrustedsubject)))
 
-        ; The equivalent policy language mlsconstrain statememt is:
+        ; The equivalent policy language mlsconstrain statement is:
         ;mlsconstrain process { getsched getsession getpgid getcap getattr ptrace share }
         ;    (l1 dom l2 or t1 == mlstrustedsubject);
     ```
-- 
2.45.1

