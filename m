Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6BE4A64F8
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362122; cv=none; b=gHcdaHZnQi/toSW8xvxu9jqVcNDR+zOF7IhCaSU6wwhec7btFME8hisDSlqEo4NScwz+GnSsEuIn3zz8yXL/frGpL6W1U6mmeq4lRM2wCc810sEeLGLzyjaLksvNhta9oRJxbbKmEhVI65hnOjsxa6xeuoL01cPDmpXdYJr0ofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362122; c=relaxed/simple;
	bh=WxLH/FzWU7a5q2YIlv78HI1Y+8yxIhBJYoAEHbLthIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dinzWWRbv0KL84yVRWpPQCtbrIO9TTO37kmaU+qkI3Uz9EPZBD4jeeBasAF3IKykZAHxtVG6F14x/pTm4+/2knDd88uN8f95Hnq/vJMqgSoPhgACJ0ocFX/92QKnp1+BnEOLQm2FBHrDNL4NQzxj+6GLcZcSh7BPVVFl5hY+IoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlY4LhUN; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlY4LhUN"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9309d4ea213so140479385a.1
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362119; x=1788966919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LGtq8UTIxttpp6EceL/28ZTFjNZOF84gWrhgtj3mQog=;
        b=AlY4LhUN3TPmr4Q78Af2WqOXcD+7cdPG5+7Yh8jEW+yuxTwzqX0zP23IUNh4fT0iJD
         Q0z+vtV8ClU2s/W5u72U4WzGVixNKnENuV08DKL+Y7gOlfeFeJlt8mD1+xcHFkvPkEWf
         fT2TJDC6oWZqAdsfmrfMsiTea8PY/Wcf8FTqeYIW956FRGHYidOHOGsPWtWurXB4NF7s
         ff4JVTEIfG5CUOkvBjB2Hfp7KGaZN/DzjQZJ+QcqX7YGKVCPKcVd7Gu8QwBX3PI3Mz74
         OorpGaKNh2hQFybMWsX3uS73w/bk4+wX3XTJE5CsbHAOC1i5t2JoFKA/O7q3AYvlXFI2
         +vZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362119; x=1788966919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LGtq8UTIxttpp6EceL/28ZTFjNZOF84gWrhgtj3mQog=;
        b=cHhDR37VACrNcjXk9N7WFYzCtODf+0OEczn4khys/1SF1p7bbwCFcCIbYXVivJXCpD
         PbgdgIL3e+8gGxn1Z5LQ7h50ywDp6lkM86gztW+o6URrSzPbP9ExDyxExtnyixnfMCaI
         IQ++2at4tueCJUiczZP/l7Gm9OIre2QbUL8EYfs+9k9iPbqudYgoQMQVyWc7X8CHB5pL
         QSuxS8S7FfMc0h2emd6NL3Hfi3X+D2Sm+wQIptvbjgz1O6rfVvCu6mKr23GYKwUE8hTT
         erda+5iwp/f0/2J0BVM2kVbmMr/m5gWi0svahEgSFm67g+1hNF+POgFNfW7VIXwgzbAs
         3H3w==
X-Gm-Message-State: AFuF++nF8eooX7vEi1/ylbe63bA1Bx3KfEL8kyGr65uK4sLcBC9OyJOw
	aiTnT3vpkGN0eED7UklgPh8igDSPCHIa3blKP6Sl7vm1xCBQ+n/lOYpXlsZr0w==
X-Gm-Gg: AR+sD10ynOlzhUpXskA4urG6elXP5MzsfM4Gu0+mQtQDh4NmNs4OWV8HFWAwEx0cPqY
	yeMIOYeYcI851wI2pLlR0yw4ACVwOwc2k91imB4U0za0VEnOFhmm0vH5COejPiE4oZMiBWAxfr+
	WPARzq/JVooLip8XPyJHUh/wUG+bIdhaw9UrC5dgemQ/Kod6uoWF3seDRTQmxzmYXkP2/sQ9GNe
	E0jRbD+feX1qoVMpcDjVmJ90t+4Hsmt/a94YsmkhiPwPJrLa7DOe8HA5bJRUcK0VvRB9HVJklyg
	QYlZDgdjXnCeAqOequN58A7553+frBs8tz0xQP3upgF3jnxadTKnjLT3hVYX+91mq4GfkAVvFTA
	L5Sz+IuJEiYcMNKlx93+ppt79Tk6iFWQVl0hWGohMHpSY4f8BisKmDzeNe4h+akLtZ2hCI1rZsA
	HSFRAXXs2RzJ1gIaxuBRuRGK9Pa5d+NPHBW5J7zq4jGLUaLWlYqLzqsrJ80FzZwP5HYfmnLNKeZ
	XTci1sxmCVKH41OgstX/VSbtX++y6eD0FCH4kJXihpxbspXC6Csc9Sb6TaZpOCD
X-Received: by 2002:a05:620a:27cf:b0:930:f723:35f5 with SMTP id af79cd13be357-93960f15dbemr732863985a.20.1788362119088;
        Wed, 02 Sep 2026 08:15:19 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f17eefdsm229299885a.11.2026.09.02.08.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:15:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 4/9] libsemanage: read the active store through the fallback list
Date: Wed,  2 Sep 2026 11:14:01 -0400
Message-ID: <20260902151406.54168-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
References: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
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

