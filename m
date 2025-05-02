Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627628E7
	for <selinux@vger.kernel.org>; Fri,  2 May 2025 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746205529; cv=none; b=KDHWTEN7JJ90DA2Rko11Mfuvpq7QUIosIrdjFp2g5AW5GziA9o2wFJbD3HXIn/HADd4TJIaUxRxkWwScrntKHJ33d34AT3mHdUGk26Ko/J7EyormK+r9g83vLoCjO5aUHfS/8fqorTL6y/hgVx7FDdzrObFj45ZmRNzP/D7H2q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746205529; c=relaxed/simple;
	bh=5KBl3n2p2s4icX0CqwRvx/hXD1tN8h+WrqCnvEeB8tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDgb7BQPFCEViJ5jdf8mOxoNg960GWP8927fD3auRv6vT8QH7qbDyKjScWpxuDS6VyZOdqjjBUrdO1o9gNkTd5o9HV+COHQEi/WKFSReolSwXBSxgu+3gd+MW1Rldlivk4sIMzdmJA9+lSe3kQfL6r2MMQDrVmC3VTnZIbonUfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdS4j/Nr; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdS4j/Nr"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c560c55bc1so268709385a.1
        for <selinux@vger.kernel.org>; Fri, 02 May 2025 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746205526; x=1746810326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OdSXBJ/5iPy86tmUyvj6FFLH3pWdxGRYltcWSP/nPU=;
        b=cdS4j/Nr0oK0RHJlIGgHFtD+GVLxJP4jEKH4TSaQu6/Kkp35fzSrDxXvJy2nb8Duub
         o1wYpjoNc6Oso0tplhw/RkbPbluHNvqkksT21H+q3ZqgXDbsXcF77+g5LUU+02sxj6+2
         GP0D/plcHU0ptoCyX50WmEoHWhfzZzw9CmCfbnJJGGmUb70uduPrQpSk3C0vXcvqWDd/
         cqQcG2rTS/7sboo1HefvA8C/VmKPYj/zYNqEwwinrSif4qmu8gAVCasxaaBuhMB7ALzs
         uzPv6F9nHaAzE+5qd3CHQvpVT68IMGU0ysVz+UH0Q6JFttW7p+WcEmlAIgW8/sDxbyjC
         qB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746205526; x=1746810326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OdSXBJ/5iPy86tmUyvj6FFLH3pWdxGRYltcWSP/nPU=;
        b=ZN3hYatAbxHAktuLcXwxPsea2VVLCoAZzKFq3P+Uqf79TlMnll3x9hVElBHvkDIslK
         LTeFTMgGAvkpTFgUCzkEQazaB7SF+fNR6P556OG/QzffX0y8TbTSE81PD6dkI4nPWl1w
         9t9c3EKubvkOYbxx4iBOsuWjsWlMXgpDGwfNdAmltsPrP4o3c6U4yuvhJPaJ/DkHJ+VG
         kGhK0+dXB0cupuDrIyNXH7qJAafgMVMKgnKLN0cgxrVWU5+8a6gdyDr/l6snv1kM3vL3
         GXs8fZEIJ8Cv1mfR3bc4TsNAR06WdI1Yp1RSS5OyzkTmTkVRJgWMi0S8cJ6ZjE/TjXl2
         jVew==
X-Gm-Message-State: AOJu0YyLvnU3pJShVqczPpglaF8jDTIAqdPUA6ngeRSrxFHW1TGQLByS
	Nttgl5oL2sASVESfQv6hggbPF3psgAQodEjf+hAciEH4l4U8YfDWGmkxPw==
X-Gm-Gg: ASbGncsXgHvWqt1nfOYRFvnoPx1T/dj/s16/bBUXg/KlEXOIb2SAHSV01LD8bp3/JHo
	ZCZMD/Woe75OgtILaHsn+gLr0QHTb0J5eDmBSxvzzurw9iBwHeo1UUEnJOw7/LVItc7H05iMTYh
	8zLwg0I9r27T6Oh9+eDKQwLYLCGj7sfBPFgBmVyxgTkjH1b9sWrSFn40MMDnC+VbrHj5x6gtWNR
	ATcv46euwM4egIAum7BJY+jltIZK0QUYL1tpOiiXlwBxtpylLpF8z4Y5CSTMekoUcI4P69cwkN6
	lZTPjLWUne20dGhJJnOCrkOwn1HByQggSCddI0oST7tb4TlNG5abwN/WoxP2Bx6atOWjQf2czs8
	IDpNOOkpuSVcY91SbbKWxxHvIQXg4IetW0GGqKL1eUPwhjhZ3bTzCLcUgVwvkgQ5mQiDb
X-Google-Smtp-Source: AGHT+IEGAW2+wYbCMmoz2mlofcau8o+ZuO52YssCZRxEqYFZ2OYIMtne1NY7Yub/mZQpr7/I+q8UTQ==
X-Received: by 2002:a05:620a:2a16:b0:7c5:4b6a:d862 with SMTP id af79cd13be357-7cad5b4d28cmr397589085a.33.1746205525616;
        Fri, 02 May 2025 10:05:25 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad242b66dsm207358085a.86.2025.05.02.10.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 10:05:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] selinux: introduce neveraudit types
Date: Fri,  2 May 2025 13:04:50 -0400
Message-ID: <20250502170450.27160-2-stephen.smalley.work@gmail.com>
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

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
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

