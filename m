Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103064BC032
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446594; cv=none; b=AvROXd+OItx3+wh7rJaUHFznAtEbBpNQF1rFOCOnaK9WLsqv4tz9PLQMxnggpIkDZMVdmPLi8rebMVaTqiy1yYj9/MqcfAIy/mbTRUdtmElj9dHJBdoigjXGGmiR8sJ1KBK/DFl5D8aZh049yHxnxM72E+9XR1g5ag9i9KlgfQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446594; c=relaxed/simple;
	bh=WxLH/FzWU7a5q2YIlv78HI1Y+8yxIhBJYoAEHbLthIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3Gk/d7mwr635AJKG5xJfz2wj508rqfoAXZD8seuSfjSb+CnpZU3rVg+fTLnlHvA2yei2HcXLquWj29ktlA6J5EYWmkY6/wA9rNIF8EI9EXBaitIRcpaVXYTrKhBPn6Cm9h/+FW+qW1Pqd+X2a4SF/01JEPW9K0C9kD1IPOMvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qBLwQFft; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBLwQFft"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5304310b3e0so13328841cf.3
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446586; x=1789051386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LGtq8UTIxttpp6EceL/28ZTFjNZOF84gWrhgtj3mQog=;
        b=qBLwQFftuq2g+u2vzf4/aAk0JWmDO5Mlk7FwEynJrjkltjvOFZ2mng35ei1PfHvNpn
         jkPx2Te98iVP3Wh7Atys+G7Pd2xafBARWWQs50WubS1ff8A8rgZrha1LbxST3q1R5fN5
         E6cWsv5jIwtFshmbCzqB7H5RcpRyRtNUL77+3nCAxGzEhGeA8S6DJ/fKqPFSHVhvvVlm
         1nLAySDcuOmggTKMG6/hlCEwDIi/cMBr2cWwd7GVwxld/Y4Dt+5KIsHzhJXNcQc4LF+Q
         vburG7SC//i/Msp+MO31EsYVEKaL6eJitz2goqe8jc909oFRYd/pu9f1WgtIMwN74FYx
         QAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446586; x=1789051386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LGtq8UTIxttpp6EceL/28ZTFjNZOF84gWrhgtj3mQog=;
        b=UnUsxvXRpw4eNEKRPHQG1v747nMuAjqtJ4rnEs0PQryEgTRRubi/AldiwsT2hfCXHl
         LQRdu7+3lgm1WyW0ZS9LvJhATQYnFQAtfg9ITcWednQhbijvRNaIt5CQtXWSQTMRSIiG
         Ly+yVRkdLlh3BEu52n+HmBbzlYvn7cwY8vwo9j4eVZDgNdXepVtL8xPP/hsxwHBOodLo
         nCWX0IaaHKcQEKdLNCi7h/bGVtlow121NYDX68YPUBngxUVHAgUjIG/Ggzy+UjCGiVOM
         y5VE2roeXb3jTRs9xX956nRkD8v5Lj0YtErfzzx6uk42gIKFyA3AMzogZJCJOSPw66fB
         1tOA==
X-Gm-Message-State: AFuF++nmUaTJ7ekGLd4GnsIY4FmKz/jWOxWjT6W5c0sYNOW7QOOpkcne
	2Hm2RnHYE2eTnFGcdbct6vlV+MH4KClE9PejaAC+XyOz/EHZAvvYlcNm1cLz+Q==
X-Gm-Gg: AYBFou3mjc7TalUx12HfIDFF8miSqkq/kmI+6t+1wV3Dt/3H8IL2iEnT0VmPINIdAcF
	MEfr4QyDYbZeB4tSYxSwFUU3wm38kZRb25i/I1wVufvFBVe3TAE5yiZMF50BsOx1KBiqyesk0xZ
	BB7pQpd0aVWKm1bM5fiB0mILavKE9lrghYKAioDoT4J7KyZuhikq0CesCKoKnfscQqGVb4zH52f
	Mk5HuWhEKm4opzB/uqoLqAsFRxr5ql8cQzqdkhmC9Aax3zyG1dU2bGZ+w2leq40e648leBPbfLt
	rnidBVsc55JxT2N80CeU4mgzYsbGhNToKvzTKZpIfPq+HFoXr6Kh/Ennq9BmMD5LGE5hAWGoviU
	X0Q3YAu4XEkWS3tkyWyrS34Ldebr1ySc3kkrC4CRm5QSdbOdTLnCHU0T1TTQLm9vbjfuWG4u5vq
	WtIqxWRnW0gLaI+X3QUAwMLm+BIR7u+2KZsbhmM8/se1FpBajFp1miAuAXjDGf/wHLwX4U0UUAX
	PsS/isuFMwJGNozjWLj7rCQWzVUz4PhryH6Cyxkzd4dmqoBBEcvjgCbeXajr07wqcYOfxVFoKQC
	03Qz0DeJE40=
X-Received: by 2002:ac8:5e10:0:b0:52f:b0f9:e4f2 with SMTP id d75a77b69052e-53036b97d24mr143986091cf.1.1788446586425;
        Thu, 03 Sep 2026 07:43:06 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff0e44sm44115851cf.5.2026.09.03.07.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:43:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	cahu@suse.de,
	bigon@debian.org,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 4/9] libsemanage: read the active store through the fallback list
Date: Thu,  3 Sep 2026 10:34:29 -0400
Message-ID: <20260903143433.19810-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
References: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
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

