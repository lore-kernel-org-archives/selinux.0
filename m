Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668432DFA31
	for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 04:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779040; cv=pass; b=Q3ZCTkRkWG03T8S1b5rxwNHK6w8XYqZIaEHXpUQRQJvp0hCWMfTaPGwLu19gOuGHtZoHbEXptnHk0GkT98tAXCLA12ZuUUX9Q2Oz5Ytcz48KhTRB/peQFF+Dco72idahf5wa8o1BNoKpSRnLfX56AOBlIUnM1PzCTAsFUmDcRf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779040; c=relaxed/simple;
	bh=+QMGHLRhgnHHukgHwqmhIljLQQL6kaPY07vAS6FfLmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLjdfcXVGHgEUAaaETur8lK0Qmz/04JSVKzV0AyAq62Ncb0kiJY0LjFkk72vObda8QaqGZ50kU0vVbgDAS+0lYm9dmfexPcJg/77RW8CpBU6w8KJChLPAv1nlBTeViw2LPaFna6vMC9Wuou0ZXvsRPPVzgr6U/5/YSS3cw6wo+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com; spf=pass smtp.mailfrom=midstall.com; dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b=bUz/9Lmy; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midstall.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b="bUz/9Lmy"
ARC-Seal: i=1; a=rsa-sha256; t=1744779035; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XCoZ2NZQ0uH5i5Pd5AIDwAX+i7/zv909Uy0grvJJtCHr6YL95hXEOl4l+gjVdhSENKTufQ6T9iHk9nuHU07LBWmgihJrEUHLf8d6ZSjbnhJOF2PqrUyPgJh5cy99fSLjprvk4PJR27srR5I+xSJKISytFrlQYlD1+KXheyegqoY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744779035; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OASwA4mgXp9jgvED6i5lAR5I+5Wu+uxkqkvtsLolEIM=; 
	b=cImWieEbpE86f5jw+iGgfReu5Ye86JHHW9t5y7JRfp43FiEgStjC6RdNjfKBLcPcC3aebaMjYspZ4nIw320cX0D+BWqmeNKCZZVa2AhYEAsaQ9PUbHIetW/GP9E8Avzeq3yGlDSLnmvUTA/PPZwvmawOS+W9oSoaSWJykV9b5e4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=midstall.com;
	spf=pass  smtp.mailfrom=tristan.ross@midstall.com;
	dmarc=pass header.from=<tristan.ross@midstall.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744779035;
	s=zmail; d=midstall.com; i=tristan.ross@midstall.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OASwA4mgXp9jgvED6i5lAR5I+5Wu+uxkqkvtsLolEIM=;
	b=bUz/9LmyDgo46zmyJtlqNsJrBus9Fotp/lqRsFTey6CSq392wmtkX4YUu0+R3kvh
	VisH1fWTCXmgrIn0eVxVlryhuKosBD/Cp7cZQDtIqWLuz36NOmXlq1swgvcOyvo7DNb
	1Y0ieCmLfJpBY9eWibVHWABYZ8GPSs6cgu6RqHsw=
Received: by mx.zohomail.com with SMTPS id 17447790341731014.8366079047153;
	Tue, 15 Apr 2025 21:50:34 -0700 (PDT)
From: Tristan Ross <tristan.ross@midstall.com>
To: selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: [PATCH 1/2] libsemanage: add semanage_handle_create_with_path
Date: Tue, 15 Apr 2025 21:50:11 -0700
Message-ID: <20250416045011.29923-2-tristan.ross@midstall.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <CAJ2a_Df2p03otFfJ7wpGJ_izTw8SGAKr5vztFf0XxnnVypKFnw@mail.gmail.com>
References: <CAJ2a_Df2p03otFfJ7wpGJ_izTw8SGAKr5vztFf0XxnnVypKFnw@mail.gmail.com>
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
index c8214b26..5dab7bf7 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -350,3 +350,7 @@ LIBSEMANAGE_3.4 {
     semanage_module_compute_checksum;
     semanage_set_check_ext_changes;
 } LIBSEMANAGE_1.1;
+
+LIBSEMANAGE_3.5 {
+    semanage_handle_create_with_path;
+} LIBSEMANAGE_3.4;
-- 
2.47.2

