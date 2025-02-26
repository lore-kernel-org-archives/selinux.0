Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6766258CED
	for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560500; cv=none; b=c637p0zfaNDb2qsxrFi4lnq13t0y/Y/LXtxNkCi6SA5m4924WowAbI9T7iCWGPoDKpPTQmY2AsIo4F3qWZXmBJjwsk7K2ebAULKLY/jddtBOLqPteM33CcJPFU2qrUhlswV57JtPc+8kVzrcvdL0xqRtuyTh0uIOVeHMwJUFAP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560500; c=relaxed/simple;
	bh=0cZcp+mBurGssFT3Nto/Dhtox6k/M3LQSh04jcEpQ0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaZh5Fxgpmbv4SVksxdSVtJtvsQv91j6RcrOSzohckMYVjccI4XlqnaQ5GIHrag7NuD0/nMOBmVjiwW5IV1F0FAvPmCgOwrOUsDo3TvvtMy3Z81pYpzAdODdVdKb2gaZDfJYd06idMMWiMT85zERkpBR+Op+gEBrm3+dUsTPl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=TNJpLRJd; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="TNJpLRJd"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740560491;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnssgpErzA78GEy5ysCUyJIiD36lwPmnEvPYr/Qod8o=;
	b=TNJpLRJda9qUnvctEblRdxGdidDU1915Fk8Q+rZ2J95sWZdpV0SPOFdWN0nidTiuwgpWpx
	0wYogo9vuOpzIu2ryejvIoOZke2BZkqUp722SYVXpF6n/cVLMQSHGv3Y+6HnSK8ygxmuid
	6lWWzpj+RA2FK2XkBDNCShU+NzvBpgcof29zi1sSekt/rDZrfXVi3uv7YS8PDRlMroxD4i
	SF7QNJJrt8HRncNnob85LX11zlbZRxooiW+nda/K0KN+gAPjZgEJ2SV0E7AWX48Itt31lT
	02/pI+NlQasvHzVjCOlVcAqRcCi00Wdam50OLvJJDNJKQ/DESbfoucnpseVH/w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] libselinux: add restore option to modify user and role portions
Date: Wed, 26 Feb 2025 10:01:27 +0100
Message-ID: <20250226090127.25701-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250226090127.25701-1-cgoettsche@seltendoof.de>
References: <20250226090127.25701-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Useful for data of MCS separated applications, like containers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/restorecon.h |  6 ++
 libselinux/src/selinux_restorecon.c     | 77 +++++++++++++++++--------
 2 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index 5be6542c..0ccf73a6 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -128,6 +128,12 @@ extern int selinux_restorecon_parallel(const char *pathname,
  */
 #define SELINUX_RESTORECON_COUNT_ERRORS			0x20000
 
+/*
+ * In addition to the type component also change the user and
+ * role component of security contexts.
+ */
+#define SELINUX_RESTORECON_SET_USER_ROLE		0x40000
+
 /**
  * selinux_restorecon_set_sehandle - Set the global fc handle.
  * @hndl: specifies handle to set as the global fc handle.
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index ab1c5216..72242c90 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -76,6 +76,7 @@ struct rest_flags {
 	bool progress;
 	bool mass_relabel;
 	bool set_specctx;
+	bool set_user_role;
 	bool add_assoc;
 	bool recurse;
 	bool userealpath;
@@ -585,43 +586,65 @@ static void filespec_destroy(void)
 /*
  * Called if SELINUX_RESTORECON_SET_SPECFILE_CTX is not set to check if
  * the type components differ, updating newtypecon if so.
+ * Also update user and role components if
+ * SELINUX_RESTORECON_SET_USER_ROLE is set.
  */
-static int compare_types(const char *curcon, const char *newcon, char **newtypecon)
+static int compare_portions(const char *curcon, const char *newcon,
+			    bool set_user_role, char **newtypecon)
 {
-	int types_differ = 0;
-	context_t cona;
-	context_t conb;
+	context_t curctx;
+	context_t newctx;
+	bool update = false;
 	int rc = 0;
 
-	cona = context_new(curcon);
-	if (!cona) {
+	curctx = context_new(curcon);
+	if (!curctx) {
 		rc = -1;
 		goto out;
 	}
-	conb = context_new(newcon);
-	if (!conb) {
-		context_free(cona);
+	newctx = context_new(newcon);
+	if (!newctx) {
+		context_free(curctx);
 		rc = -1;
 		goto out;
 	}
 
-	types_differ = strcmp(context_type_get(cona), context_type_get(conb));
-	if (types_differ) {
-		rc |= context_user_set(conb, context_user_get(cona));
-		rc |= context_role_set(conb, context_role_get(cona));
-		rc |= context_range_set(conb, context_range_get(cona));
-		if (!rc) {
-			*newtypecon = strdup(context_str(conb));
-			if (!*newtypecon) {
-				rc = -1;
+	if (strcmp(context_type_get(curctx), context_type_get(newctx)) != 0) {
+		update = true;
+		rc = context_type_set(curctx, context_type_get(newctx));
+		if (rc)
+		    goto err;
+	}
+
+	if (set_user_role) {
+		if (strcmp(context_user_get(curctx), context_user_get(newctx)) != 0) {
+			update = true;
+			rc = context_user_set(curctx, context_user_get(newctx));
+			if (rc)
+				goto err;
+		}
+
+		if (strcmp(context_role_get(curctx), context_role_get(newctx)) != 0) {
+			update = true;
+			rc = context_role_set(curctx, context_role_get(newctx));
+			if (rc)
 				goto err;
-			}
 		}
 	}
 
+	if (update) {
+		*newtypecon = strdup(context_str(curctx));
+		if (!*newtypecon) {
+			rc = -1;
+			goto err;
+		}
+	} else {
+		*newtypecon = NULL;
+	}
+
 err:
-	context_free(cona);
-	context_free(conb);
+	context_free(curctx);
+	context_free(newctx);
 out:
 	return rc;
 }
@@ -631,7 +654,6 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 {
 	char *newcon = NULL;
 	char *curcon = NULL;
-	char *newtypecon = NULL;
 	int rc;
 	const char *lookup_path = pathname;
 
@@ -724,8 +746,13 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		}
 
 		if (!flags->set_specctx && curcon) {
-			/* If types different then update newcon. */
-			rc = compare_types(curcon, newcon, &newtypecon);
+			char *newtypecon;
+
+			/* If types are different then update newcon.
+			 * Also update if SELINUX_RESTORECON_SET_USER_ROLE
+			 * is set and user or role differs.
+			 */
+			rc = compare_portions(curcon, newcon, flags->set_user_role, &newtypecon);
 			if (rc)
 				goto err;
 
@@ -1025,6 +1052,8 @@ static int selinux_restorecon_common(const char *pathname_orig,
 		    SELINUX_RESTORECON_RECURSE) ? true : false;
 	state.flags.set_specctx = (restorecon_flags &
 		    SELINUX_RESTORECON_SET_SPECFILE_CTX) ? true : false;
+	state.flags.set_user_role = (restorecon_flags &
+		    SELINUX_RESTORECON_SET_USER_ROLE) ? true : false;
 	state.flags.userealpath = (restorecon_flags &
 		   SELINUX_RESTORECON_REALPATH) ? true : false;
 	state.flags.set_xdev = (restorecon_flags &
-- 
2.48.1

