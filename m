Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90526F450
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744397998; cv=pass; b=B0cgnH3jG975Hah0ElTmgmJzteSDGNQadFNTQtAi+lV5TJ3nwiCdxcs31yBjQotD/WQVlYWVPcRotsHCOF1RFjy5TGZarhaWdIbdDquKzWjJUt9pYAlWeiYpSw0Ubm7QoBKAUWOHweIt3YFUq8IDNj8nEAIIJVyM1CqNPaiedFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744397998; c=relaxed/simple;
	bh=RJ3x3YFm2c9H1B1UDIHmGIP5/Tlq85TSnyCPyOAXkwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrttRD7goFTu5Sz1yim0ZwFd6tFUtCow8S6HKohZGUvBVSRTimsSlKdnGN4eAsSOUzP1OynBwpvdibEQXNR7ovyMWVyg1qc/cPXWtxb0DQUH0cUgMEegIEBiqutzlGY0QynGVRcmNEEUc2/DFdpKpbjgHj4Xdf6Py6DpjgpQ9z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com; spf=pass smtp.mailfrom=midstall.com; dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b=Qa/GzUIC; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midstall.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b="Qa/GzUIC"
ARC-Seal: i=1; a=rsa-sha256; t=1744397993; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S4JWY4MKSIVfQMZ7bH0HHjbS2a2bxSQAMKiAO0vGnyMKsqtnJg4xq7G6lt52oqn2XK6HYaGtOX+2fh2ZJEyjxC45YzWfiN1banYqfiXWArTuk16oDUk4HyccbF78h4Q4Lzz+imga2BOOunYvG+omm6bjgjhLCUX+bFtWELySxx8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744397993; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JGTU7ijbv1g5JR/EdcGYifNpXL3LglCree2CN2qbLNM=; 
	b=O4Qhxg1pQWMoX1YcqrLdVHrHrOmltoccOwTQ+HlkIk3i+oWoBd5ZlCmsvHwIBQ6GmrYWpDnOrGpII5Z7ZQXMw3anEmQohuJPVqetxQlb1EPjGkWISMQ5U3VI8RpQ8k6hsKlW8k4zaTiH+TkpcYQUxkmtkKSLbyYy81Ku9giSS70=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=midstall.com;
	spf=pass  smtp.mailfrom=tristan.ross@midstall.com;
	dmarc=pass header.from=<tristan.ross@midstall.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744397993;
	s=zmail; d=midstall.com; i=tristan.ross@midstall.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JGTU7ijbv1g5JR/EdcGYifNpXL3LglCree2CN2qbLNM=;
	b=Qa/GzUICicp4xR6MI/XPSg8FYf+bJYcobjv7Jj8W14O4WJ2Pj0jGz6HMt3o/YDLa
	IRvDYpP7/KEtsps+T5NYAGews2YFKhsKJf+IlQEjN3ZouY3GcgWZlryKLV1MzM7IObi
	iTZkEoJk3aizuiZi4JAmEX7rkGK4dT8HG5qmreJ8=
Received: by mx.zohomail.com with SMTPS id 1744397991737582.7021581835177;
	Fri, 11 Apr 2025 11:59:51 -0700 (PDT)
From: Tristan Ross <tristan.ross@midstall.com>
To: selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: [PATCH 1/2] libsemanage: add semanage_handle_create_with_path
Date: Fri, 11 Apr 2025 11:59:29 -0700
Message-ID: <20250411185929.47912-2-tristan.ross@midstall.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

---
 libsemanage/include/semanage/handle.h |  6 +++++-
 libsemanage/src/handle.c              | 26 +++++++++++++++++++-------
 libsemanage/src/libsemanage.map       |  1 +
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index a5ea31de..601cd9ee 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -30,7 +30,11 @@
 struct semanage_handle;
 typedef struct semanage_handle semanage_handle_t;
 
-/* Create and return a semanage handle.
+/* Create and return a semanage handle with a specific config path.
+   The handle is initially in the disconnected state. */
+semanage_handle_t *semanage_handle_create_with_path(const char *conf_name);
+
+/* Create and return a semanage handle with the default config path.
    The handle is initially in the disconnected state. */
 extern semanage_handle_t *semanage_handle_create(void);
 
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index faea0606..ca57702a 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -59,19 +59,14 @@ const char * semanage_root(void)
 	return private_semanage_root;
 }
 
-
-semanage_handle_t *semanage_handle_create(void)
+semanage_handle_t *semanage_handle_create_with_path(const char *conf_name)
 {
 	semanage_handle_t *sh = NULL;
-	char *conf_name = NULL;
 
 	/* Allocate handle */
 	if ((sh = calloc(1, sizeof(semanage_handle_t))) == NULL)
 		goto err;
 
-	if ((conf_name = semanage_conf_path()) == NULL)
-		goto err;
-
 	if ((sh->conf = semanage_conf_parse(conf_name)) == NULL)
 		goto err;
 
@@ -106,13 +101,30 @@ semanage_handle_t *semanage_handle_create(void)
 	sh->msg_callback = semanage_msg_default_handler;
 	sh->msg_callback_arg = NULL;
 
+	return sh;
+
+      err:
+	semanage_handle_destroy(sh);
+	return NULL;
+}
+
+semanage_handle_t *semanage_handle_create(void)
+{
+	semanage_handle_t *sh = NULL;
+	char *conf_name = NULL;
+
+	if ((conf_name = semanage_conf_path()) == NULL)
+		goto err;
+
+	if ((sh = semanage_handle_create_with_path(conf_name)) == NULL)
+		goto err;
+
 	free(conf_name);
 
 	return sh;
 
       err:
 	free(conf_name);
-	semanage_handle_destroy(sh);
 	return NULL;
 }
 
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index c8214b26..02c615ac 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -347,6 +347,7 @@ LIBSEMANAGE_1.1 {
 } LIBSEMANAGE_1.0;
 
 LIBSEMANAGE_3.4 {
+    semanage_handle_create_with_path;
     semanage_module_compute_checksum;
     semanage_set_check_ext_changes;
 } LIBSEMANAGE_1.1;
-- 
2.47.2

