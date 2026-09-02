Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0A2931ED
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356768; cv=none; b=joeGEiDNQYWR6tIF1j67gxg4SIRY9VTTI0JqG/nOH8wzRTnSO3g82tfOWKM/s2f9ZyaZG772JfeZuHB+Exw+Ju8GRJ1e/PDWZ/SE6EkzT6GBNxwWRv+LZHV/w+5EwvQbY6vsXUjodIUMasy9B5i33DocMbLyCLhh6K4JDMYuXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356768; c=relaxed/simple;
	bh=VvcH5ndhggc9Au10c6UDdDI0f+GdIn070imvSjVv3bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+iL+YAr1I+1xYG06mz9eUOr/eF73Xo2YHCbPBt5+d+Sl5HyWUguV19ggzyr4G3sPymY/MTjk1fAd9CYZFc3zcS/9HqeO7TOVL3uyopxHMjEvJT31/V+RpQ3DQLcR/TN19Q8eSVRe3Dguj6w6AT9nrnwiuGGObLNInO0rPRZgeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pocvHxCZ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pocvHxCZ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53016020b2fso15593071cf.0
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356765; x=1788961565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=89+lhXKPX1zgC2N3vnTFqcOyjM1yWoYj+z84CqkDJuY=;
        b=pocvHxCZioD+N21j7nc+OaXZOmXGbtfp2j5M4LqBtfMHASVTUdAiDsgfe2cERNMAG5
         juBo30JDTWVUW5A2bkk9cuqxKj4q7nk+/vuDVGnTUJUeMf4wGs2y36AYYVNpHUFEdGUf
         ZcF3YeC0Kvpc8svDZ8JewxJpeIZiRVuF8h2g1x5BeHRCipHylNQmmHtNhrq/y6oiC13s
         LQN+hpPSL6spgoogKPcWyTkUZgTBIt72eS+9WDlWyV1g0D8FulvV60w7Kw/moz/CSJPO
         8X4h5QAlf5gkCGjZPIXByvRt7RVf8LJwbiVAjaKnfcAeAnE/nOTbGLhoRqzMZKyb7Wb5
         3Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356765; x=1788961565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=89+lhXKPX1zgC2N3vnTFqcOyjM1yWoYj+z84CqkDJuY=;
        b=OY/wqgFiOvJ0r6B3ztaFm3utKji9J0BcGatX/im2rH8784mKOOfT+LVNNTUbpXCbLs
         RUe8vxEyToofo75CsZL9AyHFnoTXGiKaXy7h6WWcHSo8WQ6NNtqI0Q1kYUeDIXsFIxm8
         RzL2B2vfWdq1WQdAkE2Rb5UHc+KciOHcB6aAfsLK9d5zOyKgG2AXd7UAHQQWSV9jq+eh
         aqvhM2WN4N7SMmt4sdWeMHDJIfOk2xhl5fWgAGU6zy+SXqETJWH63WS9pSyGceJTNbwa
         7fhpoQr2QxCUSpKKPzrm8D8YOT138yrYksuvKxpWpMEj9Jhjul+zMSeYY2IyEJDMF/Cd
         7vHw==
X-Gm-Message-State: AFuF++mIasjMqJVnNgQ6Eyu5XQ4Xk8Bf+4Ddvs7LUsrF4tGsfSzP3sPM
	BYswE8ZEocWzka26M/W4IskaQ/EEivX9WgL8kXpOh1ep8edIaj7VToL1Eb5zvQ==
X-Gm-Gg: AR+sD137lc+j5XshOlfuFunjz0fWFqlCDTKPJrzFPw8jfYv2Z4JO1fhqbjE4GbMIplp
	ZOXjEtdLdtkLsOZnh3WEN2k5Ya6dQfm4L8ej+ON7HejDX4KBEAPezzdkvSCYl0BcxwqUy4IYDfT
	wESDKoNHugVJx9h/qHyY44lwDL6NaV0REtCmNH1DLX7dAxUYVJkYBy4WViG92GhJytEI/pZ5/g4
	hPJH4ynyPRtmWGrNJtKaH2Th30hQlN2odWkY193VxFIXddqzl3UfxSwWQIoWXTGNRPjsxlTNM7+
	w/yPrVer3ujd//aHJGO/y0hz5rMQnJvh39bDfIoNQQwlucfXAFmbFUA1V0kYl2r3dYWPYx796mG
	qVGMZwmDt+k8eOw8XGYQeUooGkYMzwOh8aFC49zqJHqV210DZsGh7SYw84qlsfMaPNlkapt5WS9
	8YtZAoRkLggp3tcIPcJEuLbQZdOTfEiW0Re2kH7iozXtbj6gy12PPgeQoa/AzQmcOLXZldhcs0g
	QXahp8nSlrJpljfpqPv/H+aXH7N5qOS2o9wfE3lxXhOaIi88tVyLy3smcn4SbwD/w==
X-Received: by 2002:a05:622a:4c0f:b0:530:256c:3718 with SMTP id d75a77b69052e-53036d5178bmr62362511cf.38.1788356761780;
        Wed, 02 Sep 2026 06:46:01 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5303325af1esm18686011cf.29.2026.09.02.06.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:46:01 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 4/9] libsemanage: read the active store through the fallback list
Date: Wed,  2 Sep 2026 09:33:12 -0400
Message-ID: <20260902133316.51981-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
References: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file-backed dbase objects semanage_direct_connect() sets up take a
read path (used by semanage <object> -l and by the modify path to seed
the transaction) and a write path (always in the sandbox). Update the
read side to use semanage_path_read() so a missing
/var/lib/selinux/<type>/active/<file> falls back to the corresponding
path in a ro-store-root.

Do the same for the disable_dontaudit check, semanage_read_policydb()
(policydb-based dbases), the commit_num read in
semanage_direct_get_serial(), and the read-access check in
semanage_store_access_check(); the write-access and lock checks in the
latter still target the writable store and are handled separately.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c     | 59 ++++++++++++++++++++------------
 libsemanage/src/semanage_store.c |  9 ++---
 2 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index e2e3a66b..fce571c2 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -163,14 +163,16 @@ int semanage_direct_connect(semanage_handle_t *sh)
 	/* Object databases: local modifications */
 	if (user_base_file_dbase_init(
 		    sh,
-		    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_USERS_BASE_LOCAL),
+		    semanage_path_read(SEMANAGE_ACTIVE,
+				       SEMANAGE_USERS_BASE_LOCAL),
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_BASE_LOCAL),
 		    semanage_user_base_dbase_local(sh)) < 0)
 		goto err;
 
 	if (user_extra_file_dbase_init(
 		    sh,
-		    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_USERS_EXTRA_LOCAL),
+		    semanage_path_read(SEMANAGE_ACTIVE,
+				       SEMANAGE_USERS_EXTRA_LOCAL),
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LOCAL),
 		    semanage_user_extra_dbase_local(sh)) < 0)
 		goto err;
@@ -181,58 +183,69 @@ int semanage_direct_connect(semanage_handle_t *sh)
 		goto err;
 
 	if (port_file_dbase_init(
-		    sh, semanage_path(SEMANAGE_ACTIVE, SEMANAGE_PORTS_LOCAL),
+		    sh,
+		    semanage_path_read(SEMANAGE_ACTIVE, SEMANAGE_PORTS_LOCAL),
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_PORTS_LOCAL),
 		    semanage_port_dbase_local(sh)) < 0)
 		goto err;
 
-	if (iface_file_dbase_init(
-		    sh,
-		    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_INTERFACES_LOCAL),
-		    semanage_path(SEMANAGE_TMP, SEMANAGE_INTERFACES_LOCAL),
-		    semanage_iface_dbase_local(sh)) < 0)
+	if (iface_file_dbase_init(sh,
+				  semanage_path_read(SEMANAGE_ACTIVE,
+						     SEMANAGE_INTERFACES_LOCAL),
+				  semanage_path(SEMANAGE_TMP,
+						SEMANAGE_INTERFACES_LOCAL),
+				  semanage_iface_dbase_local(sh)) < 0)
 		goto err;
 
-	if (bool_file_dbase_init(
-		    sh, semanage_path(SEMANAGE_ACTIVE, SEMANAGE_BOOLEANS_LOCAL),
-		    semanage_path(SEMANAGE_TMP, SEMANAGE_BOOLEANS_LOCAL),
-		    semanage_bool_dbase_local(sh)) < 0)
+	if (bool_file_dbase_init(sh,
+				 semanage_path_read(SEMANAGE_ACTIVE,
+						    SEMANAGE_BOOLEANS_LOCAL),
+				 semanage_path(SEMANAGE_TMP,
+					       SEMANAGE_BOOLEANS_LOCAL),
+				 semanage_bool_dbase_local(sh)) < 0)
 		goto err;
 
 	if (fcontext_file_dbase_init(
-		    sh, semanage_path(SEMANAGE_ACTIVE, SEMANAGE_STORE_FC_LOCAL),
+		    sh,
+		    semanage_path_read(SEMANAGE_ACTIVE,
+				       SEMANAGE_STORE_FC_LOCAL),
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
 		    semanage_fcontext_dbase_local(sh)) < 0)
 		goto err;
 
 	if (fcontext_file_dbase_init(
 		    sh,
-		    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_STORE_FC_HOMEDIRS),
+		    semanage_path_read(SEMANAGE_ACTIVE,
+				       SEMANAGE_STORE_FC_HOMEDIRS),
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_HOMEDIRS),
 		    semanage_fcontext_dbase_homedirs(sh)) < 0)
 		goto err;
 
 	if (seuser_file_dbase_init(
-		    sh, semanage_path(SEMANAGE_ACTIVE, SEMANAGE_SEUSERS_LOCAL),
+		    sh,
+		    semanage_path_read(SEMANAGE_ACTIVE, SEMANAGE_SEUSERS_LOCAL),
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LOCAL),
 		    semanage_seuser_dbase_local(sh)) < 0)
 		goto err;
 
 	if (node_file_dbase_init(
-		    sh, semanage_path(SEMANAGE_ACTIVE, SEMANAGE_NODES_LOCAL),
+		    sh,
+		    semanage_path_read(SEMANAGE_ACTIVE, SEMANAGE_NODES_LOCAL),
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_NODES_LOCAL),
 		    semanage_node_dbase_local(sh)) < 0)
 		goto err;
 
 	if (ibpkey_file_dbase_init(
-		    sh, semanage_path(SEMANAGE_ACTIVE, SEMANAGE_IBPKEYS_LOCAL),
+		    sh,
+		    semanage_path_read(SEMANAGE_ACTIVE, SEMANAGE_IBPKEYS_LOCAL),
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_IBPKEYS_LOCAL),
 		    semanage_ibpkey_dbase_local(sh)) < 0)
 		goto err;
 
 	if (ibendport_file_dbase_init(
 		    sh,
-		    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_IBENDPORTS_LOCAL),
+		    semanage_path_read(SEMANAGE_ACTIVE,
+				       SEMANAGE_IBENDPORTS_LOCAL),
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_IBENDPORTS_LOCAL),
 		    semanage_ibendport_dbase_local(sh)) < 0)
 		goto err;
@@ -243,7 +256,8 @@ int semanage_direct_connect(semanage_handle_t *sh)
 		goto err;
 
 	if (user_extra_file_dbase_init(
-		    sh, semanage_path(SEMANAGE_ACTIVE, SEMANAGE_USERS_EXTRA),
+		    sh,
+		    semanage_path_read(SEMANAGE_ACTIVE, SEMANAGE_USERS_EXTRA),
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA),
 		    semanage_user_extra_dbase_policy(sh)) < 0)
 		goto err;
@@ -271,13 +285,14 @@ int semanage_direct_connect(semanage_handle_t *sh)
 		goto err;
 
 	if (fcontext_file_dbase_init(
-		    sh, semanage_path(SEMANAGE_ACTIVE, SEMANAGE_STORE_FC),
+		    sh, semanage_path_read(SEMANAGE_ACTIVE, SEMANAGE_STORE_FC),
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
 		    semanage_fcontext_dbase_policy(sh)) < 0)
 		goto err;
 
 	if (seuser_file_dbase_init(
-		    sh, semanage_path(SEMANAGE_ACTIVE, SEMANAGE_STORE_SEUSERS),
+		    sh,
+		    semanage_path_read(SEMANAGE_ACTIVE, SEMANAGE_STORE_SEUSERS),
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
 		    semanage_seuser_dbase_policy(sh)) < 0)
 		goto err;
@@ -290,7 +305,7 @@ int semanage_direct_connect(semanage_handle_t *sh)
 		goto err;
 
 	/* set the disable dontaudit value */
-	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_DISABLE_DONTAUDIT);
+	path = semanage_path_read(SEMANAGE_ACTIVE, SEMANAGE_DISABLE_DONTAUDIT);
 
 	if (stat(path, &sb) == 0)
 		sepol_set_disable_dontaudit(sh->sepolh, 1);
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index a9b471a2..7f7cd7d2 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -746,7 +746,7 @@ int semanage_store_access_check(void)
 	int rc = -1;
 
 	/* read access on active store */
-	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
+	path = semanage_path_read(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
 	if (access(path, R_OK | X_OK) != 0)
 		goto out;
 
@@ -2158,8 +2158,8 @@ int semanage_direct_get_serial(semanage_handle_t *sh)
 		commit_filename =
 			semanage_path(SEMANAGE_TMP, SEMANAGE_COMMIT_NUM_FILE);
 	} else {
-		commit_filename = semanage_path(SEMANAGE_ACTIVE,
-						SEMANAGE_COMMIT_NUM_FILE);
+		commit_filename = semanage_path_read(SEMANAGE_ACTIVE,
+						     SEMANAGE_COMMIT_NUM_FILE);
 	}
 
 	if ((fd = open(commit_filename, O_RDONLY | O_CLOEXEC)) == -1) {
@@ -2239,7 +2239,8 @@ int semanage_read_policydb(semanage_handle_t *sh, sepol_policydb_t *in,
 	struct sepol_policy_file *pf = NULL;
 	FILE *infile = NULL;
 
-	if ((kernel_filename = semanage_path(SEMANAGE_ACTIVE, file)) == NULL) {
+	if ((kernel_filename = semanage_path_read(SEMANAGE_ACTIVE, file)) ==
+	    NULL) {
 		goto cleanup;
 	}
 	if ((infile = fopen(kernel_filename, "re")) == NULL) {
-- 
2.55.0

