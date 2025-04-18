Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5915222592
	for <selinux@vger.kernel.org>; Fri, 18 Apr 2025 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744999987; cv=pass; b=R7jc7AwFefVwEjgf2L9lXxxQGuXnTAY2rmGIoMmaJ9uP2QNSPafhE660HA2S2vqwNaB236ylGaG5Pk4XpoOfSL9Y+orGb0LRT8agoLn283Wqe9fSbMAFDLsjdTMpWTJAIca9njtrxEY8f4ZAv1JVY8oLDiiIMpx8D2/SkUdhutk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744999987; c=relaxed/simple;
	bh=EkDBxr4fvxZ1f9gplJjkK1Sf4PXC1m5jvz19H2j9ZHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2hkwBrteOPUYzRLxFO1NDl8Uf8zXiKTfYOkhiWqX1F7UYxOd+hMIB11lSviA4FcKbZXCZ1p5j/hQP5MdmUp5XkJcIfFOhDwswK+2/gNkN72RUmb9eenNo7qr6SmXA9qURRoaSRiZPXrNIVlZomvcSR9gVtmJ/Foz+6AgqNtx+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com; spf=pass smtp.mailfrom=midstall.com; dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b=JYieins8; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midstall.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b="JYieins8"
ARC-Seal: i=1; a=rsa-sha256; t=1744999983; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z1abxqgji1UqFNOaMMMcbig+PsZ5+AvgScQQno88nW7aai9qjs1OJ4wOQdCGjpeT0qvRRoXVdnb2lOgNFNnREwefb4FWi7ff468Or6Y7XPFNeAAtLXFkxNlvWGNJor/DTdHBjxrc/S2XYTXDoXWwyRXiYbsOL45x7+zCicscqWs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744999983; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DbcM0g2kWR1zPdQ1Rcatpgp9NhNK9AYoFX8TkX5STEY=; 
	b=eZ14JkvOh9xE+EtlhCE/NpI7KUXR2zszr/8UyYmDnX9EMKTBhkjbZEvei2EzgAZEQe9O/0ghXDzP4ne70R7cIqMyPB+PcOBHGc9j+Utr9UXGm8Y3A1KXXzHglD9Kd2hUdDca3e5kktQVnd1Q/0tjLqaeYcduzv9eEhUFUIFfexY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=midstall.com;
	spf=pass  smtp.mailfrom=tristan.ross@midstall.com;
	dmarc=pass header.from=<tristan.ross@midstall.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744999982;
	s=zmail; d=midstall.com; i=tristan.ross@midstall.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DbcM0g2kWR1zPdQ1Rcatpgp9NhNK9AYoFX8TkX5STEY=;
	b=JYieins82der1HCgx8RYLTv+z63kyLR6MGLv+I1mmISlTTve141IWqjDJ6GIoBfl
	83O0ECu8GUfGoDqHpKBCcLhIzlYH0CgY35UPq6dzA4WWTUsOR1RFBWhpe8eQ9qq4nFt
	R7wn0oezROCmQV7Tewqa0IlDKu8iHG85vLxCY+9w=
Received: by mx.zohomail.com with SMTPS id 174499998024090.0229847234798;
	Fri, 18 Apr 2025 11:13:00 -0700 (PDT)
From: Tristan Ross <tristan.ross@midstall.com>
To: selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: [PATCH 1/2] libsemanage: add semanage_handle_create_with_path
Date: Fri, 18 Apr 2025 11:12:55 -0700
Message-ID: <20250418181256.98701-1-tristan.ross@midstall.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <87bjsvzy6k.fsf@redhat.com>
References: <87bjsvzy6k.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Adds "semanage_handle_create_with_path" to create an semanage handle
with a config file from a specific path. This is useful for baking
SELinux policy generation into a Nix derivation.

Signed-off-by: Tristan Ross <tristan.ross@midstall.com>
---
 libsemanage/include/semanage/handle.h |  6 +++++-
 libsemanage/src/handle.c              | 26 +++++++++++++++++++-------
 libsemanage/src/libsemanage.map       |  4 ++++
 3 files changed, 28 insertions(+), 8 deletions(-)

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
index c8214b26..8d7d8b05 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -350,3 +350,7 @@ LIBSEMANAGE_3.4 {
     semanage_module_compute_checksum;
     semanage_set_check_ext_changes;
 } LIBSEMANAGE_1.1;
+
+LIBSEMANAGE_3.9 {
+    semanage_handle_create_with_path;
+} LIBSEMANAGE_3.4;
-- 
2.47.2

