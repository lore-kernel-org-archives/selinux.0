Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03271A0739
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334644; cv=none; b=e0uLfmvAtaq7krKKsy/QOtpgCDYtYt47a4VqfNdRH/BxJ/seiTL/rnN+0o+jByMz6LavLa4IYZTybr+ejHsVVildzW2aXyjIr8Wq5TH1Eu5uiBiVVhG3ILafZaGrLCl3KngDP1mYfg174IJY7hpYLs0u7uuTOPG+hQOWmtZYMcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334644; c=relaxed/simple;
	bh=ZbyLeGCSbngFiWA0hTedladW9hdyVCIFS/FvutSfTpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGlKcN1iYOXfCFPFvGFBB3+Jkt/liZ31wYiELy11Gq0YvwRrEoQ6Ga0WtjVeT6ek1cTNMCKYDUkVNw2wzooA+zd862Bg9mvCjAZnUd/m1NUQKzU67hPBzQ/DTzEsHOS1OJGs+dOT79MPgUV7hnsGS70QIVp25JE1xJJoKY+apsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=G6k0nmof; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="G6k0nmof"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334637;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJ6B3YFncbxVbxIYFO2omBl/KcuEbZxwzNm+I9LQSzU=;
	b=G6k0nmofmSHxWaRgTVs3Rb2IWhMs5g88VZwriIySCJJ6yDdShskZDjuiCtrYXV94VBTNfj
	/fghJm2eCCAvHU4eHj/gcYEtj7qT5hyvoErGoyOPX+8EiuYnc0f+BW36miUJWlpfuOk7Gm
	vvjbS8riHwgseS2Tv2PKA/OlOZDGvEu1alh27WVDV5JbcGlEpUSQa/J6a7ApOpLXQuR7b8
	+jbwfl6H7GdqCnHFE3rBtMjlIxNkW+x9+cSgrl8KkgXY2Ka3ex9TpcCXPGkhSgc+6O2k9Z
	WVuu6YRck+t4luzHtUSiY3Rqy9FmsZhy0TjDktQ8FyvBIOwx82nh0BxUvqm9/Q==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 26/47] libsemanage: more strict value parsing
Date: Mon, 11 Nov 2024 15:16:45 +0100
Message-ID: <20241111141706.38039-26-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

Be more strict when parsing values from semanage.conf, especially
numeric ones.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/conf-parse.y | 44 ++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 9c806fdd..83aa3402 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -26,6 +26,7 @@
 #include <selinux/selinux.h>
 #include <semanage/handle.h>
 
+#include <errno.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -139,13 +140,15 @@ ignore_module_cache:	IGNORE_MODULE_CACHE '=' ARG  {
         ;
 
 version:        VERSION '=' ARG  {
-                        current_conf->policyvers = atoi($3);
+                        char *endptr;
+                        long value;
+                        errno = 0;
+                        value = strtol($3, &endptr, 10);
+                        if (*endptr != '\0' || errno != 0 || value < sepol_policy_kern_vers_min() || value > sepol_policy_kern_vers_max())
+                                yyerror("policy-version must be a valid policy version");
+                        else
+                                current_conf->policyvers = value;
                         free($3);
-                        if (current_conf->policyvers < sepol_policy_kern_vers_min() ||
-                            current_conf->policyvers > sepol_policy_kern_vers_max()) {
-                                parse_errors++;
-                                YYABORT;
-                        }
                 }
         ;
 
@@ -162,13 +165,27 @@ target_platform: TARGET_PLATFORM '=' ARG  {
         ;
 
 expand_check:   EXPAND_CHECK '=' ARG  {
-                        current_conf->expand_check = atoi($3);
+                        char *endptr;
+                        long value;
+                        errno = 0;
+                        value = strtol($3, &endptr, 10);
+                        if (*endptr != '\0' || errno != 0 || (value != 0 && value != 1))
+                                yyerror("expand-check can only be '1' or '0'");
+                        else
+                                current_conf->expand_check = value;
                         free($3);
                 }
         ;
 
 file_mode:   FILE_MODE '=' ARG  {
-                        current_conf->file_mode = strtoul($3, NULL, 8);
+                        char *endptr;
+                        long value;
+                        errno = 0;
+                        value = strtol($3, &endptr, 8);
+                        if (*endptr != '\0' || errno != 0 || value < 0 || value > 0777)
+                                yyerror("file-mode must be a valid permission mode");
+                        else
+                                current_conf->file_mode = value;
                         free($3);
                 }
         ;
@@ -239,12 +256,15 @@ handle_unknown: HANDLE_UNKNOWN '=' ARG {
  }
 
 bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
-	int blocksize = atoi($3);
-	free($3);
-	if (blocksize > 9)
+	char *endptr;
+	long value;
+	errno = 0;
+	value = strtol($3, &endptr, 10);
+	if (*endptr != '\0' || errno != 0 || value < 0 || value > 9)
 		yyerror("bzip-blocksize can only be in the range 0-9");
 	else
-		current_conf->bzip_blocksize = blocksize;
+		current_conf->bzip_blocksize = value;
+	free($3);
 }
 
 bzip_small:  BZIP_SMALL '=' ARG {
-- 
2.45.2

