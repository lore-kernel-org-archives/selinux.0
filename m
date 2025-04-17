Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940810E4
	for <selinux@vger.kernel.org>; Thu, 17 Apr 2025 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744856191; cv=pass; b=pNAbtPPlwVCoVL5qhmWpZPPX03p83d++EXS5xo1cdxyy5iHAsk56Y95cNmjDsrnVPBHTBL/GYyfEClwZ0eB/kqJB8sLdOYkNjSn0MY0ZDniKeqQtj2UKQ26ntO6IPlcv5+bWLF+vQkIhtjdbPzYEgAwNCdQfahOhTkYwR67HrCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744856191; c=relaxed/simple;
	bh=Ej/y/eZUtKyTuYugSM1lArEr1CzE8v7JHwkaSMRaHy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiRU66LmzyK2ea541nifBT0duQAAUn+fu9rEQB2/kIFpNU/nwsvMiPtl7I4tklfYtCE8v/9LWkyTnrDj6AeI36uR1QNJiM4KjfsZKCzL/Aa4tDg/zaCDAnFFraBfRVgVBbX+xVhoclt5pzJM+nDd5pyT78hvMb109hSd4qvdjLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com; spf=pass smtp.mailfrom=midstall.com; dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b=RBFtczuB; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midstall.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b="RBFtczuB"
ARC-Seal: i=1; a=rsa-sha256; t=1744856187; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U+zCNGPObkWgF7DUwJ2Wi3xnVrJ5z/u3stkKDT2U5cw79hxpr1XMHJyBg8fRHIulJgh95NGjzy9gzVQ+9cb2bw7e5z5f1V6BbOODIRyqu9l+PcVg+eCk5CNSCBNzLCt9b6jOHZKvwVhT5qeZdEooeF+iGWt1jHn877U6XZWM7/4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744856187; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J5nFYYTK0O5U59tSJv6ZKf5maQFmQjV4zwiBNuRbC2A=; 
	b=Ab0k57nkf71rz4Mj3P+xuGv3JC+0I9U1wFuK7Ss2nV3sNZaI2QVlFlX2OSSdlUp0PB2mE6M1vuZDv3MAjw1ehLQOgmwp8Zi7pv9qcSDaHufgXgLWriY86bS7OnDg/ZwQ9yyQYJnZzJnXA/Y0ftgFvujEcS104ZS844gaZ36zge8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=midstall.com;
	spf=pass  smtp.mailfrom=tristan.ross@midstall.com;
	dmarc=pass header.from=<tristan.ross@midstall.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744856187;
	s=zmail; d=midstall.com; i=tristan.ross@midstall.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=J5nFYYTK0O5U59tSJv6ZKf5maQFmQjV4zwiBNuRbC2A=;
	b=RBFtczuBfUAbrYfrhYaHt5xXe/PJDiIapz5qZXinNuKQIi0gItWxrOJ5ktoHRxBV
	z/GPe2qaE+MqRoQBoioupa/n0prNUJZWhU+CEFVGu+v5oZrIveCrsbT81bpjNlf98LF
	CdXkVeWXSfk+To41DQyrd4M2iJtC2j9WJ2akx6xc=
Received: by mx.zohomail.com with SMTPS id 1744856184714521.5490781232393;
	Wed, 16 Apr 2025 19:16:24 -0700 (PDT)
From: Tristan Ross <tristan.ross@midstall.com>
To: selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: [PATCH 1/2] libsemanage: add semanage_handle_create_with_path
Date: Wed, 16 Apr 2025 19:16:10 -0700
Message-ID: <20250417021611.45594-1-tristan.ross@midstall.com>
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

