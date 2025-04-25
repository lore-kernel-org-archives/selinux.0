Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C11A08AF
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745584741; cv=none; b=DNt7eRF1pnRCzIBpaM3hW0p8gLjq/kWBfh6fodfVPLDeMhKwPqgBMTO5jYstGb86adQnfQd2NIil9PBstkPNNAnM1YZXMGfNvgST535E828QV+zvzPISod2e6Noc3Gm5A3pZ+6CmU8Gp+O7AsfDu5qmc3KwyjWEO+9yb1FQal+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745584741; c=relaxed/simple;
	bh=Y/SzORF7WZr68s5n1uWUmtvBwwsRnyP6sN+8cPEguBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g64Vmg+f4Sj7vd7SMNNYmvrx+eZ4kfNEq4pZGeGDVLtBX8GmLmAtDzcI5r9J5/URfotmkFa+G5bZb/icH84PBYTLmPaUhu/dMYAti9gkuVZE13SqiOFe1SFxa7DqBsCywZIdnuCuXhmK336KHpQBK8BRZGUQvwW/HVMKCsGo7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2H5tGG9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2H5tGG9"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c59e7039eeso311988685a.2
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745584738; x=1746189538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cn8H0G2tYJawSeJ9Bc9daIlqGvtHTnVqzDRrrgRXw5Q=;
        b=i2H5tGG92t8e/0AP9cfl5wDOM6NIqu0CL9291SX3FVe44JtxWw7qkB6lOLgnORqX/O
         yO5gqlzMYCRAuUIfyHVtmUEhxWWIcBZN8FiS0C+TYFtqVH99TeEK6N805n/ZzAveiIBL
         lwR3bZ9Qyd6hFnAAaJ1UFdGR3JZfYuUO5ExgQdOY6bII8EGmQYjuSrCTx1fH/Q8OqyvN
         hxYFFVmbdvYk1Wb6bQEhS+yKBnBLOb7z675jKU4iNccQBNIF/IxTP+X2FWoDRBkty7vx
         kCf00rfHsCIAt5FLV4MddYP+vGpZvfsvHqEj3nWVokILWrsvSEJI0XaKn8xvtxthS9TX
         Gugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745584738; x=1746189538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cn8H0G2tYJawSeJ9Bc9daIlqGvtHTnVqzDRrrgRXw5Q=;
        b=U7i1eWy3DrQ/FwT37PZGgjIJYPxqT/7v2vXaJTyQ1GFqJNQ7bhMLAQwQabmM9tj4+p
         1xUTur5K87J3dvl6rIFVNF4yn6sm/E6U7IiE6q2c6d4iAbhsGMw5Xc/mEOKJ/a06mztW
         EZI2h5G3UqnLzpaBmCl020scXx5PxGaMM6D2Tr1ymqPfloSXXM95A/4EK7k6e3T0DEBV
         mzswcODlax0aMgc8OXwl6SJiug7uPst5skH5s1LnA1zgF1wpCr2UL0Nj1ZH09m2O30rZ
         TqiFDaLnbi4uDDh6qksWd5XB0sMtFDn90tlysephqWbP7olwR4UaW5s6uIe1+uuDrdta
         YuVQ==
X-Gm-Message-State: AOJu0Ywbd+uhu2InsFqZVcDUYvUOzM+3U4UuIKdzYgTdrYQ95viB2XxU
	vZy9JIv7sjPkqvfN7W/sHwpd1Uru2dH8YM46GPpxKRSL3bN74iBtLZXkO7mg
X-Gm-Gg: ASbGncuUtnMqjNJe26kaY5lWQv7jY26WnJ7tLP92BW1HNB5OkurdsaKpgvvNZ6Kk/yg
	LLLFM13uwm6gIWqnPs3qaz/qWgunxPckMtpker6CPy1RLOtrKS7yNlEf3l0OraHVKXJMiI/4gM5
	TnmoX7k/4/cllROHuZRlv3s30CSEx8znRe4Jphy8sAwRuDYEQv/Gtk8Ez37B2voa+QoVjyEBdIk
	/GtkEQhwtZIyuAhb1jfGlIAN6QWE1DW2zdHRFP+lYnXu+U1Hr+EYe8k2y1anix9BXPFkcyHibQy
	Cd0qhRwUTYgjU1NvnYW5shwiqOocwLob8yr+9yJCjqyudDa32Z8S2hql48tkyt0crv29SkNVEgP
	L/6J1WFa8MISzd+Wm7NlfkLWW4cyr7qbQ9tatHPCeSGDYY88ZxqC6szF2/LGWAKxvCEAP
X-Google-Smtp-Source: AGHT+IGzBih9/8t1bUoTx57JR7QnwDMasT82J0WqE/PZKtaStl6xMbwzZiVClQ5D25hzMwdiI7A/QQ==
X-Received: by 2002:a05:620a:bc8:b0:7c9:55c5:76f4 with SMTP id af79cd13be357-7c9606dc468mr352684785a.13.1745584737704;
        Fri, 25 Apr 2025 05:38:57 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958ea08c8sm213643285a.103.2025.04.25.05.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:38:57 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH] selinux: introduce neveraudit types
Date: Fri, 25 Apr 2025 08:37:20 -0400
Message-ID: <20250425123719.5984-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce neveraudit types i.e. types that should never trigger
audit messages. This allows the AVC to skip all audit-related
processing for such types. Note that neveraudit differs from
dontaudit not only wrt being applied for all checks with a given
source type but also in that it disables all auditing, not just
permission denials.

When a type is both a permissive type and a neveraudit type,
the security server can short-circuit the security_compute_av()
logic, rendering the type equivalent to an unconfined type.

This change just introduces the basic support but does not yet
further optimize the AVC or hook function logic when a type
is both a permissive type and a dontaudit type.

Link: https://lore.kernel.org/selinux/20250424200310.2409-2-stephen.smalley.work@gmail.com/

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
If this seems viable/preferable to the unconfined types patch, then
I will update the userspace patches, but it would just be a global
renaming from unconfined to neveraudit.

 security/selinux/include/avc.h      |  4 ++++
 security/selinux/include/security.h |  4 +++-
 security/selinux/ss/policydb.c      | 19 +++++++++++++++++++
 security/selinux/ss/policydb.h      |  2 ++
 security/selinux/ss/services.c      | 20 ++++++++++++++++++++
 5 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 281f40103663..01b5167fee1a 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -65,6 +65,10 @@ static inline u32 avc_audit_required(u32 requested, struct av_decision *avd,
 				     int result, u32 auditdeny, u32 *deniedp)
 {
 	u32 denied, audited;
+
+	if (avd->flags & AVD_FLAGS_NEVERAUDIT)
+		return 0;
+
 	denied = requested & ~avd->allowed;
 	if (unlikely(denied)) {
 		audited = denied & avd->auditdeny;
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 278c144c22d6..8201e6a3ac0f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -47,10 +47,11 @@
 #define POLICYDB_VERSION_GLBLUB		     32
 #define POLICYDB_VERSION_COMP_FTRANS	     33 /* compressed filename transitions */
 #define POLICYDB_VERSION_COND_XPERMS	     34 /* extended permissions in conditional policies */
+#define POLICYDB_VERSION_NEVERAUDIT	     35 /* neveraudit types */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX POLICYDB_VERSION_COND_XPERMS
+#define POLICYDB_VERSION_MAX POLICYDB_VERSION_NEVERAUDIT
 
 /* Mask for just the mount related flags */
 #define SE_MNTMASK 0x0f
@@ -260,6 +261,7 @@ struct extended_perms {
 
 /* definitions of av_decision.flags */
 #define AVD_FLAGS_PERMISSIVE 0x0001
+#define AVD_FLAGS_NEVERAUDIT  0x0002
 
 void security_compute_av(u32 ssid, u32 tsid, u16 tclass,
 			 struct av_decision *avd,
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 9ea971943713..91df3db6a88c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -160,6 +160,11 @@ static const struct policydb_compat_info policydb_compat[] = {
 		.sym_num = SYM_NUM,
 		.ocon_num = OCON_NUM,
 	},
+	{
+		.version = POLICYDB_VERSION_NEVERAUDIT,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM,
+	},
 };
 
 static const struct policydb_compat_info *
@@ -531,6 +536,7 @@ static void policydb_init(struct policydb *p)
 	ebitmap_init(&p->filename_trans_ttypes);
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
+	ebitmap_init(&p->neveraudit_map);
 }
 
 /*
@@ -852,6 +858,7 @@ void policydb_destroy(struct policydb *p)
 	ebitmap_destroy(&p->filename_trans_ttypes);
 	ebitmap_destroy(&p->policycaps);
 	ebitmap_destroy(&p->permissive_map);
+	ebitmap_destroy(&p->neveraudit_map);
 }
 
 /*
@@ -2538,6 +2545,12 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 			goto bad;
 	}
 
+	if (p->policyvers >= POLICYDB_VERSION_NEVERAUDIT) {
+		rc = ebitmap_read(&p->neveraudit_map, fp);
+		if (rc)
+			goto bad;
+	}
+
 	rc = -EINVAL;
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
@@ -3723,6 +3736,12 @@ int policydb_write(struct policydb *p, struct policy_file *fp)
 			return rc;
 	}
 
+	if (p->policyvers >= POLICYDB_VERSION_NEVERAUDIT) {
+		rc = ebitmap_write(&p->neveraudit_map, fp);
+		if (rc)
+			return rc;
+	}
+
 	num_syms = info->sym_num;
 	for (i = 0; i < num_syms; i++) {
 		struct policy_data pd;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 25650224b6e7..89a180b1742f 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -300,6 +300,8 @@ struct policydb {
 
 	struct ebitmap permissive_map;
 
+	struct ebitmap neveraudit_map;
+
 	/* length of this policy when it was loaded */
 	size_t len;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7becf3808818..1c9b38c016e2 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1153,6 +1153,14 @@ void security_compute_av(u32 ssid,
 	if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
 		avd->flags |= AVD_FLAGS_PERMISSIVE;
 
+	/* neveraudit domain? */
+	if (ebitmap_get_bit(&policydb->neveraudit_map, scontext->type))
+		avd->flags |= AVD_FLAGS_NEVERAUDIT;
+
+	/* both permissive and neveraudit => unconfined */
+	if (avd->flags == (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERAUDIT))
+		goto allow;
+
 	tcontext = sidtab_search(sidtab, tsid);
 	if (!tcontext) {
 		pr_err("SELinux: %s:  unrecognized SID %d\n",
@@ -1172,6 +1180,8 @@ void security_compute_av(u32 ssid,
 		     policydb->allow_unknown);
 out:
 	rcu_read_unlock();
+	if (avd->flags & AVD_FLAGS_NEVERAUDIT)
+		avd->auditallow = avd->auditdeny = 0;
 	return;
 allow:
 	avd->allowed = 0xffffffff;
@@ -1208,6 +1218,14 @@ void security_compute_av_user(u32 ssid,
 	if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
 		avd->flags |= AVD_FLAGS_PERMISSIVE;
 
+	/* neveraudit domain? */
+	if (ebitmap_get_bit(&policydb->neveraudit_map, scontext->type))
+		avd->flags |= AVD_FLAGS_NEVERAUDIT;
+
+	/* both permissive and neveraudit => unconfined */
+	if (avd->flags == (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERAUDIT))
+		goto allow;
+
 	tcontext = sidtab_search(sidtab, tsid);
 	if (!tcontext) {
 		pr_err("SELinux: %s:  unrecognized SID %d\n",
@@ -1225,6 +1243,8 @@ void security_compute_av_user(u32 ssid,
 				  NULL);
  out:
 	rcu_read_unlock();
+	if (avd->flags & AVD_FLAGS_NEVERAUDIT)
+		avd->auditallow = avd->auditdeny = 0;
 	return;
 allow:
 	avd->allowed = 0xffffffff;
-- 
2.49.0

