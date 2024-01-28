Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59891095A
	for <selinux@vger.kernel.org>; Sun, 28 Jan 2024 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706436128; cv=none; b=aWucisSk//Ioo2gL20kCLVrjpAoWisa0R0t78ViGePcSSShWudhvtkUwodH1J6dY9TodEI1voCQtEvfUDRUzXyK9KChrvfNvUa3ey8F5961Vkw23Qt4LMz9WI2b98GBAb1hSeuSL4EW57k7/rzt3VkC1/Xb8jpGUwSnWBe+Tn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706436128; c=relaxed/simple;
	bh=Gj7at0lrqyG9Yes15ee0KV99RXTi+vIrxzXPZoPkhck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SCB0EiGAn7hRhlJn/9IyC6fTzFmP+im4HknS/fE9wKyYss9vDWHd7LtBVQKQeFwuKC3oMGYO/Ao8WgMwjkeBl8nt8QWXDooGZa8fvWdtTGw2BVxO1pDV9BlofJ+hKMhKVBgszvUVNOzqbpNDQbO3tlV3WfK85i7XSQM8wV0DSZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+2dAKTn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+2dAKTn"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6de24201aa6so15053b3a.2
        for <selinux@vger.kernel.org>; Sun, 28 Jan 2024 02:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706436126; x=1707040926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hKila1Tmoahg1A/pGs0f1XVaF7s0KuE5wPWWqSVvGrs=;
        b=O+2dAKTnWHDUs/XWQPJuYdzNnRjaT/inDsTy5xtPAtXIAjQEedgZs7tF7oyYs8ZVZW
         CmY954Qr1bCWn/5dY84UT9+HGpolUCWW+c8nCJhjo1VSQiaqrrrDa5qDVHiDM0L1ybGh
         UsfystOO3adhL+SDeDYIFvCsw26cjw2CtfDF33VmpEHFQ6cEmpUCRooZ2VJebIjTK0aU
         eNbwPiaRhX5zLOQLNZ29QGtbNrFVc3FEfIHCb30NqFj7yYyxbQ38FmGDPoKxmF7uib0j
         xs2j2uqEmTQBjS8FCHe5S3W+1lTMb32HjAxuPIcXIIWSfLLt3mQEKPL+JFGzdTrW4rri
         R4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706436126; x=1707040926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKila1Tmoahg1A/pGs0f1XVaF7s0KuE5wPWWqSVvGrs=;
        b=DzPIJk1/EBQOSLKOBS3NQNUmVAJLV5obVA5q17bZe/XfoYN3mW7NZ7Qx7+xgMR6njF
         PCi91S3SYyQlJ/gvXxJylNmd0/oB/2DuumZiLnJWLes7EWA4RDdQvqjiV+qkt2Uxn7nk
         RJlLEEU6WoI3dDH6xGv7xIe5w4ocUsw514x2f470ba2/ObnOVJQzB/MAkzXrwBaRa24z
         LiBTsoUk2T5rpIM9iuyGmFTQyYa1IWRx7L04vzdbHFZZREM+YT7AuotVB6zJr7zVpNpt
         Se9yaHFANH/m2K4QhKyVWBiGVf5vnipS9OSArHU0KEQT9U2Pbt0wDBbUyDVuW4KCh3/8
         73xg==
X-Gm-Message-State: AOJu0YwI86MquE2vcGd0zXVK67AFc4BDzOlHI43JvFlEg9ACLgTc/Zi5
	wMSUNQcpj65TlIxQTQx/VDE8O1IKH8b+X1JrKiU6uuF2cg4kA9iW
X-Google-Smtp-Source: AGHT+IHjNJEImonBVgSG/sp6EkpnF8D0NuHimw0vZ08y10sd7Pcss6QCyieFJoAXFCHHif0Fj3NOCA==
X-Received: by 2002:a17:902:76cb:b0:1d4:bcfa:2b0e with SMTP id j11-20020a17090276cb00b001d4bcfa2b0emr1666097plt.93.1706436125806;
        Sun, 28 Jan 2024 02:02:05 -0800 (PST)
Received: from eagle-5590.. ([45.248.77.173])
        by smtp.gmail.com with ESMTPSA id li12-20020a170903294c00b001d741873e4bsm3487831plb.95.2024.01.28.02.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 02:02:05 -0800 (PST)
From: Ronald Monthero <debug.penguin32@gmail.com>
To: paul@paul-moore.com
Cc: selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	cgzones@googlemail.com,
	omosnace@redhat.com,
	Ronald Monthero <debug.penguin32@gmail.com>
Subject: [PATCH] selinux: Use kfree_sensitive for certain code paths of security
Date: Sun, 28 Jan 2024 20:00:35 +1000
Message-Id: <20240128100035.82170-1-debug.penguin32@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As with kfree_sensitive() it does kfree() and memzero_explicit()
internally to clear sensitive data. The patch includes some of
the code paths to free data such as keys, hash table and
scontext and tcontext of selinux, which would benefit
from kfree_sensitive() to replace kfree()

Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
---
 security/selinux/avc.c            |  4 ++--
 security/selinux/ima.c            |  2 +-
 security/selinux/selinuxfs.c      | 16 ++++++++--------
 security/selinux/ss/conditional.c |  4 ++--
 security/selinux/ss/hashtab.c     |  2 +-
 security/selinux/ss/policydb.c    |  6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 32eb67fb3e42..c6d7f52a11c1 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -723,8 +723,8 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
 
 	trace_selinux_audited(sad, scontext, tcontext, tclass);
-	kfree(tcontext);
-	kfree(scontext);
+	kfree_sensitive(tcontext);
+	kfree_sensitive(scontext);
 
 	/* in case of invalid context report also the actual context string */
 	rc = security_sid_to_context_inval(sad->ssid, &scontext,
diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index aa34da9b0aeb..b5d923d272a0 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -86,7 +86,7 @@ void selinux_ima_measure_state_locked(void)
 				  state_str, strlen(state_str), false,
 				  NULL, 0);
 
-	kfree(state_str);
+	kfree_sensitive(state_str);
 
 	/*
 	 * Measure SELinux policy only after initialization is completed.
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 6c596ae7fef9..6c2490dbfaa6 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -183,7 +183,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 	}
 	length = count;
 out:
-	kfree(page);
+	kfree_sensitive(page);
 	return length;
 }
 #else
@@ -299,7 +299,7 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 	}
 
 out:
-	kfree(page);
+	kfree_sensitive(page);
 	return length;
 }
 
@@ -725,7 +725,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	selinux_ima_measure_state();
 
 out:
-	kfree(page);
+	kfree_sensitive(page);
 	return length;
 }
 static const struct file_operations sel_checkreqprot_ops = {
@@ -1290,7 +1290,7 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 
 out:
 	mutex_unlock(&selinux_state.policy_mutex);
-	kfree(page);
+	kfree_sensitive(page);
 	return length;
 }
 
@@ -1342,7 +1342,7 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 
 out:
 	mutex_unlock(&selinux_state.policy_mutex);
-	kfree(page);
+	kfree_sensitive(page);
 	return length;
 }
 
@@ -1481,7 +1481,7 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 
 	ret = count;
 out:
-	kfree(page);
+	kfree_sensitive(page);
 	return ret;
 }
 
@@ -1831,7 +1831,7 @@ static int sel_make_perm_files(struct selinux_policy *newpolicy,
 out:
 	for (i = 0; i < nperms; i++)
 		kfree(perms[i]);
-	kfree(perms);
+	kfree_sensitive(perms);
 	return rc;
 }
 
@@ -1900,7 +1900,7 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
 out:
 	for (i = 0; i < nclasses; i++)
 		kfree(classes[i]);
-	kfree(classes);
+	kfree_sensitive(classes);
 	return rc;
 }
 
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 81ff676f209a..51409a74eb74 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -176,8 +176,8 @@ int cond_init_bool_indexes(struct policydb *p)
 
 int cond_destroy_bool(void *key, void *datum, void *p)
 {
-	kfree(key);
-	kfree(datum);
+	kfree_sensitive(key);
+	kfree_sensitive(datum);
 	return 0;
 }
 
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index c05d8346a94a..73b867fa4726 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -79,7 +79,7 @@ void hashtab_destroy(struct hashtab *h)
 		h->htable[i] = NULL;
 	}
 
-	kfree(h->htable);
+	kfree_sensitive(h->htable);
 	h->htable = NULL;
 }
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 595a435ea9c8..fd58a6a1ef8f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -179,8 +179,8 @@ static const struct policydb_compat_info *policydb_lookup_compat(unsigned int ve
 
 static int perm_destroy(void *key, void *datum, void *p)
 {
-	kfree(key);
-	kfree(datum);
+	kfree_sensitive(key);
+	kfree_sensitive(datum);
 	return 0;
 }
 
@@ -369,7 +369,7 @@ static void ocontext_destroy(struct ocontext *c, unsigned int i)
 	if (i == OCON_ISID || i == OCON_FS ||
 	    i == OCON_NETIF || i == OCON_FSUSE)
 		kfree(c->u.name);
-	kfree(c);
+	kfree_sensitive(c);
 }
 
 /*
-- 
2.34.1

