Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FEC1891AA
	for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525018; cv=none; b=sd+YKo4dGppk87JJ+meJlfK4Ufhg91jhMbuWksOYi5/DOWvnqm73alNW+UlWXn5GRfA/v/WQAMM3U9t6EuEL2VyzF50JTk15/YNCwc5kK11FP5zpLQvFLI8T301Xo18m+HpMq7S8EBReTUJ9KpR9tYXtfaxp+e2PkdWDbErzNLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525018; c=relaxed/simple;
	bh=Qpg+RYJ5TnHFwwPX+X5PZBRiAKYjXKbQ1jQOg4tB1IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g6+p7BV0GHLuQ5YHjb1536uH1LVfc10AAQON719rh53A9a9SJpEhVGw+VqroRd66VCDwhNx9R5yFYNSyq/XjwTjAQmwZWwtVgEkDJYhoi7Yk8INs6A1Bs30EDRDvy3Fp6FFbAlUpfU0eLXrto83o3QhmQuhmSP1Qf8R8JkxuAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG4XqCTe; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG4XqCTe"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so10180836d6.2
        for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745525015; x=1746129815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4nQLgqMS/4cTbEHeHVCuH4mVb52e687sQUMx9+gwYw4=;
        b=GG4XqCTeTmxmKl+evifIZ6A/H4forGLEJ8UQxw4W+jWt+Ajl/20SrEaxFb9r3jSLf2
         At0Jpy8KAa0vD1JZT/NqDd9PZD8GCJPrt4OdlvmR/ly8sYk1YMSr2E5cPIaRXj5y0nNF
         jwS279xctEih5nKPRabNbgDPcW9F3M09EBQFhjZMQUs0DBDiXVGlCw0br53ecsXKJjmn
         PAsI5Wu3FMtOzFZQPjOPPLAxHFvg9bEmowul2Z9TILwFz4UDDUATu4PMcauNrYJzTuZa
         tzzAbtW7br7mINslhZwa310/c9TJdrmCZDg5uXHnOvJTk2SVBR6YQTv7+1Z8hXgkoAZC
         xvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745525015; x=1746129815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nQLgqMS/4cTbEHeHVCuH4mVb52e687sQUMx9+gwYw4=;
        b=L4fQmxLE73Ay1HzflNT00hYhyx0cw2jnojE6KvAJ9URJmLtbySY3LIgLZL3kFPBqtL
         RMC3onAQQ7FciMdbiYvoFGMSABXN3BK3Qu/P9VA+CJH60kB4VkyRcyGRFWdquyXCb3YU
         Sx60gj/JxHynEFpfnEBV9Ij1NELBRN0nODaZedkmgnvyFmqtvIBmGiJeEBcAEX6GxMQo
         9E6ddCpJAXsv9jnHoO3HFaVIs+Eyrg9PweF4fipp685MD7gbu/kJ+ITBANAtPpHB0uHw
         MkefKgXnp6YLIpVwcupZxJO3GqJjQ6OpKIcvBs5woXJNZe7Vhen1R3HIrMneAVrUzh70
         0J1A==
X-Gm-Message-State: AOJu0YwZ6uvIZ529rM2Kgywhwrl0D9iCYMP3wopT2EjjRVfi7+Ya9g9J
	KxZ4pcM8tST31F/xO+N0u5j6vrSpfXH1KVaDR2njg04j7Om7E+YJSaRpT6h5
X-Gm-Gg: ASbGncuDHcdiLLGKTaHFt1A+Ae1OREnr15+N24vfpScnzn6a83RzHFKjhN+bq7V+fqs
	FdmDmkMMHWdq8ANbMy6tXDl+GZQVxWaAzf/JOBMprHdgI6H1zoPJQB+Q2pc4KnAw3bBYEf34l/z
	xNcQdJmNtxt7zTKiYSp3FsZ8qhJd1EEHG053vtGTpsNMNBG8YrS3ItSk1ZiIHVogwKzdXOK5EfK
	K4lAz1Rcvp+KwEc2e/oXOcF9wvUtAdoEK2H5FuuuC65T/5gjPE+E7OjiNGmEoOENNYjSl+AQG0S
	YPLpzsIhPQ0giFULWL+lboYykXWTIEmxp2We5WKvPBbN4Q1RHdG/k9bbKtJ6ATiFyPz4w9PXXXZ
	qzgcpsccRfUGq0JqzvV19bc1/BQxKs/ycbtyX0re0vPdlroGxYL6S8dSmlFVw13V1wpO4
X-Google-Smtp-Source: AGHT+IG4VwAQA2RaL/pOwvHjJhJT5PD0khTLe3gXD3FyH0YnzIs0OEyFEf1ReBteR6ic9YQYiBX+yw==
X-Received: by 2002:ad4:4ee5:0:b0:6e8:955b:141e with SMTP id 6a1803df08f44-6f4c954dfb0mr16888506d6.21.1745525014929;
        Thu, 24 Apr 2025 13:03:34 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c08ef572sm13304196d6.23.2025.04.24.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:03:34 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH] selinux: introduce unconfined as a first class concept
Date: Thu, 24 Apr 2025 16:03:10 -0400
Message-ID: <20250424200310.2409-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce unconfined as a first class concept to SELinux. Previously,
SELinux had no such concept and unconfined domains were solely defined
by policy.

Advantages of elevating to a first class concept:
1. Explicit allow rules for unconfined domains can be omitted, shrinking
the policy.
2. The kernel can leverage this knowledge to further optimize checking on
unconfined processes.

Disadvantages:
1. Yet another juicy target for exploit writers, similar to permissive
types.
2. Requires a new policy version/format and bitmap.

This change just introduces the basic support but does not yet
leverage it to optimize the AVC or hook function logic.

Link: https://lore.kernel.org/selinux/20250424185213.17910-1-stephen.smalley.work@gmail.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/include/security.h |  4 +++-
 security/selinux/ss/policydb.c      | 19 +++++++++++++++++++
 security/selinux/ss/policydb.h      |  2 ++
 security/selinux/ss/services.c      | 12 ++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 278c144c22d6..ea7caac3eae1 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -47,10 +47,11 @@
 #define POLICYDB_VERSION_GLBLUB		     32
 #define POLICYDB_VERSION_COMP_FTRANS	     33 /* compressed filename transitions */
 #define POLICYDB_VERSION_COND_XPERMS	     34 /* extended permissions in conditional policies */
+#define POLICYDB_VERSION_UNCONFINED	     35 /* unconfined types */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX POLICYDB_VERSION_COND_XPERMS
+#define POLICYDB_VERSION_MAX POLICYDB_VERSION_UNCONFINED
 
 /* Mask for just the mount related flags */
 #define SE_MNTMASK 0x0f
@@ -260,6 +261,7 @@ struct extended_perms {
 
 /* definitions of av_decision.flags */
 #define AVD_FLAGS_PERMISSIVE 0x0001
+#define AVD_FLAGS_UNCONFINED 0x0002
 
 void security_compute_av(u32 ssid, u32 tsid, u16 tclass,
 			 struct av_decision *avd,
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 9ea971943713..ce1c999da613 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -160,6 +160,11 @@ static const struct policydb_compat_info policydb_compat[] = {
 		.sym_num = SYM_NUM,
 		.ocon_num = OCON_NUM,
 	},
+	{
+		.version = POLICYDB_VERSION_UNCONFINED,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM,
+	},
 };
 
 static const struct policydb_compat_info *
@@ -531,6 +536,7 @@ static void policydb_init(struct policydb *p)
 	ebitmap_init(&p->filename_trans_ttypes);
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
+	ebitmap_init(&p->unconfined_map);
 }
 
 /*
@@ -852,6 +858,7 @@ void policydb_destroy(struct policydb *p)
 	ebitmap_destroy(&p->filename_trans_ttypes);
 	ebitmap_destroy(&p->policycaps);
 	ebitmap_destroy(&p->permissive_map);
+	ebitmap_destroy(&p->unconfined_map);
 }
 
 /*
@@ -2538,6 +2545,12 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 			goto bad;
 	}
 
+	if (p->policyvers >= POLICYDB_VERSION_UNCONFINED) {
+		rc = ebitmap_read(&p->unconfined_map, fp);
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
 
+	if (p->policyvers >= POLICYDB_VERSION_UNCONFINED) {
+		rc = ebitmap_write(&p->unconfined_map, fp);
+		if (rc)
+			return rc;
+	}
+
 	num_syms = info->sym_num;
 	for (i = 0; i < num_syms; i++) {
 		struct policy_data pd;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 25650224b6e7..fe4a60ee8159 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -300,6 +300,8 @@ struct policydb {
 
 	struct ebitmap permissive_map;
 
+	struct ebitmap unconfined_map;
+
 	/* length of this policy when it was loaded */
 	size_t len;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7becf3808818..558db693f37f 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1153,6 +1153,12 @@ void security_compute_av(u32 ssid,
 	if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
 		avd->flags |= AVD_FLAGS_PERMISSIVE;
 
+	/* unconfined domain? */
+	if (ebitmap_get_bit(&policydb->unconfined_map, scontext->type)) {
+		avd->flags |= AVD_FLAGS_UNCONFINED;
+		goto allow;
+	}
+
 	tcontext = sidtab_search(sidtab, tsid);
 	if (!tcontext) {
 		pr_err("SELinux: %s:  unrecognized SID %d\n",
@@ -1208,6 +1214,12 @@ void security_compute_av_user(u32 ssid,
 	if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
 		avd->flags |= AVD_FLAGS_PERMISSIVE;
 
+	/* unconfined domain? */
+	if (ebitmap_get_bit(&policydb->unconfined_map, scontext->type)) {
+		avd->flags |= AVD_FLAGS_UNCONFINED;
+		goto allow;
+	}
+
 	tcontext = sidtab_search(sidtab, tsid);
 	if (!tcontext) {
 		pr_err("SELinux: %s:  unrecognized SID %d\n",
-- 
2.49.0

