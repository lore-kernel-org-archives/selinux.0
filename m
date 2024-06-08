Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3E15EA2
	for <selinux@vger.kernel.org>; Sat,  8 Jun 2024 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867641; cv=none; b=qNJFlkYtVDBF7PC6LWhzFWyYA2j/Z9dn7R1dXfrAR0GtVomCht7Oj0EdRtbCU0xRwKFeZDk7BKMg2JAwa/ttlxPUCduVhc2uqmPKcDs1t0ed9on3F0eTcktlyAu85AXOYl62h21yEFxHdM5DyjZrk49m8pg2A2PFvNjYIP8M7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867641; c=relaxed/simple;
	bh=+nAtKmNWtc01Nz6HAoP04Zpt+jRD9jSlCHS+7h6dx0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BonH1SjuY/8prAqznzv87oPzlEVDOAUOJA/3LX3iOgGNo7f9pdFeD1Ju52pWOJNhb46EpztRZ3mfZD3rvZU0upnekAQ9+ZRdR1jTh7Nc+h4wrBucGLL7H9D1D9ttm9O2on8olPpibKgT2Qdwr8QCsCKXqwYiEflj0b21TFqy8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=R4itgVbl; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="R4itgVbl"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1717867081;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WhYBVpDJZZ3zgi+kDDYqAFKCcir/u+FPGgbLKdp/cPw=;
	b=R4itgVblYqAXLgJBvVQ6dO5Nt4rVKJCmMWqhJ0VsOf6alPBtP/sRd9VtkxUYXsZLfzETii
	PM0cZbnbLlXS3LDg19uPSK77JyjilVuIXRVRKil0XyDNUSil0zXV7UaDjAWJq3vzX/IrP2
	VXkSxgh5WGl+B4pS8Q6Lo/DJUQt4Y7V1QQp3A/qDAzJsiq/P/4+0PAVqSbI2Lx4cMPwjcS
	xpMWLzUvO89gcicsva4SzD1S4rlSZ0jzjkAcXWFLtomVr06Spx2uqCd2yd1qVfw0kKWLJD
	SCzy0FbHyMdccoNfS1nwSAquQyy97Ss86vP4rEY/vAHW/bG8xI3baJFT925f2A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsepol: contify function pointer arrays
Date: Sat,  8 Jun 2024 19:17:39 +0200
Message-ID: <20240608171739.135501-1-cgoettsche@seltendoof.de>
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

These function pointers are never modified.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/link.c          | 4 ++--
 libsepol/src/module_to_cil.c | 8 ++++----
 libsepol/src/write.c         | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index b8272308..048d742e 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -749,7 +749,7 @@ static int cat_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	return 0;
 }
 
-static int (*copy_callback_f[SYM_NUM]) (hashtab_key_t key,
+static int (*const copy_callback_f[SYM_NUM]) (hashtab_key_t key,
 					hashtab_datum_t datum, void *datap) = {
 NULL, class_copy_callback, role_copy_callback, type_copy_callback,
 	    user_copy_callback, bool_copy_callback, sens_copy_callback,
@@ -1215,7 +1215,7 @@ static int user_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 	return -1;
 }
 
-static int (*fix_callback_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
+static int (*const fix_callback_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
 				       void *datap) = {
 NULL, NULL, role_fix_callback, type_fix_callback, user_fix_callback,
 	    NULL, NULL, NULL};
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 3b3480bf..2dbf137e 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2951,8 +2951,8 @@ static int ocontexts_to_cil(struct policydb *pdb)
 	int rc = -1;
 	int ocon;
 
-	static int (**ocon_funcs)(struct policydb *pdb, struct ocontext *ocon);
-	static int (*ocon_selinux_funcs[OCON_NUM])(struct policydb *pdb, struct ocontext *ocon) = {
+	static int (*const *ocon_funcs)(struct policydb *pdb, struct ocontext *ocon);
+	static int (*const ocon_selinux_funcs[OCON_NUM])(struct policydb *pdb, struct ocontext *ocon) = {
 		ocontext_selinux_isid_to_cil,
 		ocontext_selinux_fs_to_cil,
 		ocontext_selinux_port_to_cil,
@@ -2963,7 +2963,7 @@ static int ocontexts_to_cil(struct policydb *pdb)
 		ocontext_selinux_ibpkey_to_cil,
 		ocontext_selinux_ibendport_to_cil,
 	};
-	static int (*ocon_xen_funcs[OCON_NUM])(struct policydb *pdb, struct ocontext *ocon) = {
+	static int (*const ocon_xen_funcs[OCON_NUM])(struct policydb *pdb, struct ocontext *ocon) = {
 		ocontext_xen_isid_to_cil,
 		ocontext_xen_pirq_to_cil,
 		ocontext_xen_ioport_to_cil,
@@ -3404,7 +3404,7 @@ exit:
 }
 
 
-static int (*func_to_cil[SYM_NUM])(int indent, struct policydb *pdb, struct avrule_block *block, struct stack *decl_stack, char *key, void *datum, int scope) = {
+static int (*const func_to_cil[SYM_NUM])(int indent, struct policydb *pdb, struct avrule_block *block, struct stack *decl_stack, char *key, void *datum, int scope) = {
 	NULL,	// commons, only stored in the global symtab, handled elsewhere
 	class_to_cil,
 	role_to_cil,
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index f8cd9e1d..a52e2e82 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1344,7 +1344,7 @@ static int user_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	return POLICYDB_SUCCESS;
 }
 
-static int (*write_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
+static int (*const write_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
 				void *datap) = {
 common_write, class_write, role_write, type_write, user_write,
 	    cond_write_bool, sens_write, cat_write,};
-- 
2.45.1

