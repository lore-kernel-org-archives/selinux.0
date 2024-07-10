Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0963A5
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720579239; cv=none; b=BLrtLHZDIm2zwJpXfdiRO6je7EYIHEUyAuIgud4Rz7hDBzuisxgmJNgWe2Du6KS8kgmFnRdnEcZj2oGXZtXh4TVhJtxWqB9SSr3jJkI9xNeE9rhholRNQdoQp01RuMCMX/lVoyC9hyghJd7FG02id6YL2fKdcXbyoAFA24fRl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720579239; c=relaxed/simple;
	bh=2AvR8m5tlJdoUV2JTF6IApusCit2OBqY3kr/eyt7Jcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYk/EvIn1h/Xj2mq2Bt8UVXSZEUTbgGF65IYj4TevmRK6GNetg4SWpy6K5dNGLZMdpZ+dgHUhc3TUzvZ4kPLI/gMHa1seZ2Z74DCVL5ODIye7yWITdQIJ0k6yCGG6QEMem/Pkbo7Cp89H/t15VGMwjPiALOjbRN179sPIKNVbfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IciTlTd+; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IciTlTd+"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8102bbc95d1so1950138241.2
        for <selinux@vger.kernel.org>; Tue, 09 Jul 2024 19:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720579237; x=1721184037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JXzjgZ9jf8gN4J2OksWazhibeYmvyVAS4VYQ5WPo5T0=;
        b=IciTlTd+rzhZSji6debqoFOFGT4IcY42LLnJPlfzcMDmBRAWZU/tjyMGpn5xOlq4VR
         RKh4N5IL7wDwnV2oph2dlTRTgcv+79Scuh8O3Pd+8cWOZ2yJVDixy223DKcC3vcCewYN
         /YCp0uIeBYPXp65Z150Zo4z4c346925UO2tiKT2cuZwuLzL8hP8rfx7iZYjDQ6PTbxux
         PTLBrqP3YgWQyrjA2LMJS2nHZ5p13/6iLYTjL7pu6kz6chSWchzVoOzJUFdpa2oAbbxI
         rYDtrRrIit3rbPvyEOjCcAtyMgz5iO/Y8Nbo4K8nWvTLOn9Vys7KBND5POTB4pbj0LZr
         vRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720579237; x=1721184037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXzjgZ9jf8gN4J2OksWazhibeYmvyVAS4VYQ5WPo5T0=;
        b=cRagIvlegLdMRJrqgP6HqQib71jMwjHonV4wFJJ+391kMsm6IbuSO7CkwDo06KrNOk
         xGQPKLE6PEQ9LQawbCaoSbcdJqnGDJeAvmjxZ17AnP9z1dfoN55WL9JaarriopWSLWbZ
         2Rvai5WTIwB4p0is9qwD9nPxYYRsNC0OTc26p1UCRHTm8Ue3SKlIKuZMAvyMZwJ1nsF+
         ZfOF4p5MuwHFvifWvS3IOVzl3rhxT8w2hmljnIBxoJX+pLUJlHX15xxB1+mdIK6VDVxr
         YPgXnXUFLhzvquNJZqL05+hPe8mBfStZtvZmbGR2FqvzmJC6Mwv4KPcpnAp/pQ7ItSJ7
         Bzrg==
X-Forwarded-Encrypted: i=1; AJvYcCXdGpg0noG48imeeyJRC1ckmRaFBjG5757bzNcUQ0nABlbTZZ1rbFbgJcXHYv8e/Ev9Gqsw44Vx2fVii2P1PVKODeCBhlkJXQ==
X-Gm-Message-State: AOJu0YyJ91N/stYKgHQTxZXOGxJyTB3oeBZ9BF2bToJajynwAjdRJv3n
	UT+f72NpHtocyo1Hha/ohJPYAirQyo0rYJD18MWrbGxjUcXD6+jsFClsl8jJQZbhzAEYHOeLpoU
	=
X-Google-Smtp-Source: AGHT+IGxPuDoq1FuOdsmjR08Ndpl9eovmorJHL9lMPDxClqfBzJ6mqscdsZR6WQCKOObYnuEYUgYGg==
X-Received: by 2002:a67:e7c6:0:b0:48f:b1d3:4890 with SMTP id ada2fe7eead31-4903222ee34mr5304152137.31.1720579236545;
        Tue, 09 Jul 2024 19:40:36 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b512e0sm16423111cf.45.2024.07.09.19.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 19:40:36 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM implementation hook
Date: Tue,  9 Jul 2024 22:40:30 -0400
Message-ID: <20240710024029.669314-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7289; i=paul@paul-moore.com; h=from:subject; bh=2AvR8m5tlJdoUV2JTF6IApusCit2OBqY3kr/eyt7Jcs=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBmjfSdxuYEFMvxZ6C9SCn0weqZxvdzwFyc+g8jR FGqbnWwluuJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZo30nQAKCRDqIPLalzeJ c4ReD/90b4YsRjGTi4WIh9Fwt6zy9m3PU/FGkAlds7z4rU+W6QNb5cNAGybz/v8/qDYJBpVsj7V jGQ+w6sV8oLZ5lMsu5hVmL1wflZV8GRcVJawCbZYiRuDZzrgnhD9P7ZPbKKDy4CVx3aZORqbuG1 JitYW/VfHD7CWsfmjb3/U+3FRqpbsuzsN0v6aHwcUK/W2FXzdiXkyw1zQRuAUOGZJezzAxD8OPJ dHVhVi9k3o9myXhKrQyYYz8YSL01VuMdwq8RDSyyY21jTXjjB3kj/Vb9u2yCiVNn29rwnjkfrkd SX5JNxGTwK8P4VXicHJ9A4PKMYvXvqnxsm2oHKvZYhj9lBdOoHDddu6d096WWGRh1UcTTi+dVar P+YglMKG0IMQba4ZrwigzDj3Y1FWB0Q8QEj8uV+kIcKhuZa9W01BsuPx6cfwcDxPD+HOtHZ9u/5 rarKyNKAG7nfU8YAxjtnHY+szzlMBB3POTM72ku6qwnIDr+JNGozXXVTL48ntOnbMr0vmc5Fxn/ mU8RhGQ+Ferga3QyUkw2hXDEch42npiDRMwVsyacJ7slEyu8QgjmE7yaC6huQOQE2P2S7BaG4jY 69XBGKOG9f8swWAz3veJNGjcKc/AORzDK0+gx55dShqTHTLkK8m6ZHsQlPQzZxuvDzWXjd+yeD1 l4QKGVZ27kOEQIQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM framework has an existing inode_free_security() hook which
is used by LSMs that manage state associated with an inode, but
due to the use of RCU to protect the inode, special care must be
taken to ensure that the LSMs do not fully release the inode state
until it is safe from a RCU perspective.

This patch implements a new inode_free_security_rcu() implementation
hook which is called when it is safe to free the LSM's internal inode
state.  Unfortunately, this new hook does not have access to the inode
itself as it may already be released, so the existing
inode_free_security() hook is retained for those LSMs which require
access to the inode.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hook_defs.h     |  1 +
 security/integrity/ima/ima.h      |  2 +-
 security/integrity/ima/ima_iint.c | 20 ++++++++------------
 security/integrity/ima/ima_main.c |  2 +-
 security/landlock/fs.c            |  9 ++++++---
 security/security.c               | 26 +++++++++++++-------------
 6 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8fd87f823d3a..abe6b0ef892a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -114,6 +114,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
 	 unsigned int obj_type)
 LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
+LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *)
 LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
 	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
 	 int *xattr_count)
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3e568126cd48..e2a2e4c7eab6 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -223,7 +223,7 @@ static inline void ima_inode_set_iint(const struct inode *inode,
 
 struct ima_iint_cache *ima_iint_find(struct inode *inode);
 struct ima_iint_cache *ima_inode_get(struct inode *inode);
-void ima_inode_free(struct inode *inode);
+void ima_inode_free_rcu(void *inode_sec);
 void __init ima_iintcache_init(void);
 
 extern const int read_idmap[];
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index e23412a2c56b..54480df90bdc 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -109,22 +109,18 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
 }
 
 /**
- * ima_inode_free - Called on inode free
- * @inode: Pointer to the inode
+ * ima_inode_free_rcu - Called to free an inode via a RCU callback
+ * @inode_sec: The inode::i_security pointer
  *
- * Free the iint associated with an inode.
+ * Free the IMA data associated with an inode.
  */
-void ima_inode_free(struct inode *inode)
+void ima_inode_free_rcu(void *inode_sec)
 {
-	struct ima_iint_cache *iint;
+	struct ima_iint_cache **iint_p = inode_sec + ima_blob_sizes.lbs_inode;
 
-	if (!IS_IMA(inode))
-		return;
-
-	iint = ima_iint_find(inode);
-	ima_inode_set_iint(inode, NULL);
-
-	ima_iint_free(iint);
+	/* *iint_p should be NULL if !IS_IMA(inode) */
+	if (*iint_p)
+		ima_iint_free(*iint_p);
 }
 
 static void ima_iint_init_once(void *foo)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..5b3394864b21 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1193,7 +1193,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
 #endif
-	LSM_HOOK_INIT(inode_free_security, ima_inode_free),
+	LSM_HOOK_INIT(inode_free_security_rcu, ima_inode_free_rcu),
 };
 
 static const struct lsm_id ima_lsmid = {
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 22d8b7c28074..f583f8cec345 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1198,13 +1198,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 
 /* Inode hooks */
 
-static void hook_inode_free_security(struct inode *const inode)
+static void hook_inode_free_security_rcu(void *inode_sec)
 {
+	struct landlock_inode_security *lisec;
+
 	/*
 	 * All inodes must already have been untied from their object by
 	 * release_inode() or hook_sb_delete().
 	 */
-	WARN_ON_ONCE(landlock_inode(inode)->object);
+	lisec = inode_sec + landlock_blob_sizes.lbs_inode;
+	WARN_ON_ONCE(lisec->object);
 }
 
 /* Super-block hooks */
@@ -1628,7 +1631,7 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
-	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
+	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
 
 	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
 	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
diff --git a/security/security.c b/security/security.c
index b52e81ac5526..bc6805f7332e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1596,9 +1596,8 @@ int security_inode_alloc(struct inode *inode)
 
 static void inode_free_by_rcu(struct rcu_head *head)
 {
-	/*
-	 * The rcu head is at the start of the inode blob
-	 */
+	/* The rcu head is at the start of the inode blob */
+	call_void_hook(inode_free_security_rcu, head);
 	kmem_cache_free(lsm_inode_cache, head);
 }
 
@@ -1606,20 +1605,21 @@ static void inode_free_by_rcu(struct rcu_head *head)
  * security_inode_free() - Free an inode's LSM blob
  * @inode: the inode
  *
- * Deallocate the inode security structure and set @inode->i_security to NULL.
+ * Release any LSM resources associated with @inode, although due to the
+ * inode's RCU protections it is possible that the resources will not be
+ * fully released until after the current RCU grace period has elapsed.
+ *
+ * It is important for LSMs to note that despite being present in a call to
+ * security_inode_free(), @inode may still be referenced in a VFS path walk
+ * and calls to security_inode_permission() may be made during, or after,
+ * a call to security_inode_free().  For this reason the inode->i_security
+ * field is released via a call_rcu() callback and any LSMs which need to
+ * retain inode state for use in security_inode_permission() should only
+ * release that state in the inode_free_security_rcu() LSM hook callback.
  */
 void security_inode_free(struct inode *inode)
 {
 	call_void_hook(inode_free_security, inode);
-	/*
-	 * The inode may still be referenced in a path walk and
-	 * a call to security_inode_permission() can be made
-	 * after inode_free_security() is called. Ideally, the VFS
-	 * wouldn't do this, but fixing that is a much harder
-	 * job. For now, simply free the i_security via RCU, and
-	 * leave the current inode->i_security pointer intact.
-	 * The inode will be freed after the RCU grace period too.
-	 */
 	if (inode->i_security)
 		call_rcu((struct rcu_head *)inode->i_security,
 			 inode_free_by_rcu);
-- 
2.45.2

