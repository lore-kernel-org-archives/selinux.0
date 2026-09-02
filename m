Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F5385D61
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357820; cv=none; b=lHBKU3kT3aWvikjVeTFGl0x8kvKfFl+rnoSJYZ1I5JspgnysTunhEgci7MV2O+PbHCKpp1rCpTFureOkHjgLi8dT3rG8R4wVTBLPx72ORc+7fEHkixNjgmp3celj95WsbcuXmXuIS2k/zQVBScyyTWhrccupJ8nqfrU+IbMPNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357820; c=relaxed/simple;
	bh=WxLH/FzWU7a5q2YIlv78HI1Y+8yxIhBJYoAEHbLthIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmMzGVMtamt39R8Ga3bnJxtLJyMBL/FLerP7pdrn5uhfXZNaQe9s6dOovtnol55DjAsGiO68rdkxRuZh0aEMZ4t9C7nEnNyJxswjajDZMaY+RMVtev/X29s1j1d1mXu4Co4k5NfVreCtFWDNZ3VlaTS3BD7KCFu5mhJLrumhdZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDzP9mXq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDzP9mXq"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-910317dc2e9so2095416d6.3
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357817; x=1788962617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LGtq8UTIxttpp6EceL/28ZTFjNZOF84gWrhgtj3mQog=;
        b=VDzP9mXqaV9570eygxk088B03ET+Uti+xxcfxa3cYdVHksEDRACyzTRWQWB/AT2ozH
         J710Em4gjM+gweNVzdVEI28knMmPwHAAKp1RyuEsg5fxrKkdIqt5ihkGCOyIwP1p3mlL
         2laQ4CItB7WLwzx0MZ0pPdsHGtByaaXQHdo1Sh2UGD47DNfP3GiF2Y9S6nJ6fmBg7Pd+
         nbJMgVlpgu/wbgOMDE5phofessLpGpm72g9zqSJTc2BLC27+rBipfa2oj0QtsNyomtXz
         SXFZsd/BGmLEkGuPnZDB+gynOukXVbetOZNhFgRRYYpnJ7rWunYP60FVBSQ+eZaEQRyx
         9www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357817; x=1788962617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LGtq8UTIxttpp6EceL/28ZTFjNZOF84gWrhgtj3mQog=;
        b=aSvZnSxH/BtPD5UJhJxXDeMVmFMCpz+Kfe33ytyVn1evim8MQdcNQSg7/b5HRs6M8X
         NeTd6q2eE8XSPS3oHhupI/mhzL4IEz5hV7ItOR/RE77FD+muZCvB2usEjvjG7o90kPPz
         bhfxIBLHvjwm7MK1mAb6Ke0VVTaj0ks6/xpFTudM7n02+IoYplPsAbfjUuEa1Qg0O1Ov
         EblQ4UTnDTq4s2jBSHGflS3pyNZmHU4Pl44sszBwFB+pjjDvMOCCPt1Ft8AsMmbEQcEL
         nxrHK6Zl4h+NhehElx62OIm+lEtZThq04f+KIEdbIdeuTgsZmUc/TS5eR+1WOI3pj1jo
         CHBg==
X-Gm-Message-State: AFuF++lI2f0GYLmaL4643Mo7L9I/8iDgNNh6nMQbqBRV8wVYCstmUOot
	R/L3FCMQ+11X6DQ/GZKzNOzoXjVpilTywkyR+VjJR4MGLNBUeJYMhTfu3ettIA==
X-Gm-Gg: AYBFou2PKpER+Nve4r6Q0or0/k/F0BVV6ifN3oTIngj/QXyBP2cKT6fK43/KwjWrAcW
	XNKyBCXrBjf+ujOhoineSxkfVXSZN9pIyaVseeLfJJ+j0OtLvRqE7I8Erq9W8mrDvebpEtALwmX
	mC1NGfoChilVY0qu20/Uo8pjHL0hGTxqlrliGPra2dTwvH9xiScrUtKKroNc8XjNMxxO4TtAMBk
	H2zyL1DJ1gFxETipUO6BfPeIFnhTHvsw+4Y9PORRQ4KYtnLb5lC7KZuv2i01YHQk+8bF+W/+NgJ
	Q93/x4hdXYIga2NZOfOggKhNt49vCR3MTJrgdZwFiM67+i46ZRGgYgqq9n7JpFbNp7L/WB/Fv4C
	QtHf8WoJ0VRL19oz02MrFvSl4bvyKV8EmKXtggPuDGms4tDY/h4o+WrvZFHuRTxTka7kzaX2RM8
	iWFfKNyhYOExC6aSYEPvsfczVQ6qCh2qnjocnoJLYAQtwnG2N9W2MWaLKD23FN6AADBeL871dUJ
	Txdkl8Nr7uWS7QOhXVs4h63HfTQhBRbZBKB6CA6ppTuW17vPzEt0WWKgxu9u4z3
X-Received: by 2002:a05:6214:5507:b0:90c:4fdd:c6ef with SMTP id 6a1803df08f44-90eab4476d2mr73648106d6.15.1788357812318;
        Wed, 02 Sep 2026 07:03:32 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee316f7sm18790446d6.19.2026.09.02.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:03:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 4/9] libsemanage: read the active store through the fallback list
Date: Wed,  2 Sep 2026 10:02:06 -0400
Message-ID: <20260902140211.53084-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
References: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
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
index dae9d003..a930dac1 100644
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

