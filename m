Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5E143C69
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838559; cv=none; b=JGawukxpQ+J0pdLPbKfd5knjHiriZxlA8FvkwxT+bCdTDunQMFgmVBYjr9r7g2L0GZNSfhIL19ORTmfrYJe62cGXak1uq+0RPRhiViGkx5v8s7HYt6nupnVKVK7l+hiEV1xSfpksjaNXX6m1wBz6G93KTXH2ue4tMxzASD5IgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838559; c=relaxed/simple;
	bh=Zoa574i6oHKg3whz40fQdn8DViKj/1gZTSt8JbcBLMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKn3ddkV7dnk31hHWOgyr3cBqPuGeRoQUHAYSj/+bg2cmOI9UYpPSvJ9nkQpz7oljVwxl/vcAVcA95duD8E9HHQeDJnEOB/3ADyZRJYruwiNW2xdQsXMnwrb8rui+jWvta70VvUQXwiZ6ZCrUEOb68CCw81J1n8zQ/Ts+S58JoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Um0xnFqQ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um0xnFqQ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f8b10b807fso74308296d6.1
        for <selinux@vger.kernel.org>; Wed, 21 May 2025 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747838556; x=1748443356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7jpHQ0Fhcmm+lzs8uaf9PO+pEmUFzuK4+CfIBX6mOo=;
        b=Um0xnFqQpx3Re7KTH/PkxyDAjkKkUWO+RAFIg9wDvGb5DWRwZCQYWCAlGXZ4COeywG
         bFO5IpdfBwjAIgaHvvL0J96cAAbXEfS1vnyDDG2WUwS5wkswmh3sF0p2MgifubXxlNtV
         nvmPPKBGsV92NsIivqF2sHEnfJzh2SmP5eR7Rcwfdfb5D8qGcBs8LU2I+8VsqED5c/Ae
         SsNMy4Do1Z7B4vzRy4FGGwQMLU1FrlV5+T16uYLyHD9A+lHcL7sKxMVtm/ZpX80NbsgC
         20E8KZaotM8FU+Aol73OK6/y/Gbd805Ml2d4jnPdgUP5mnZDz8Gh82Je4Dzc/OOD9zzs
         0ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747838556; x=1748443356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7jpHQ0Fhcmm+lzs8uaf9PO+pEmUFzuK4+CfIBX6mOo=;
        b=ejcCm5U57hlNoh5U3XGzmBro5QLASALb5kcp53Pl0t+9lELYtW7Oq5HNOoza9dEz/P
         ZeDbLO92sr+51DNG+yJ8p5hdro3R7KJ42iUDU7NJ7ZbxKYri3/ywnvn21gzo6gQqp3tg
         f2jWpv+odc8eJtqaRtEpgbtYS4QnCNlqMy+p/tiGUlf/gGPIZnHTl4s2OUlsZ13ZE0iD
         7nKcHb1PHwS6y8MpqDkbz71LUWGTcGtDuZzV09Syg4ikG0RCNW3149j4mbhlLG22KYVg
         6uMXM5j0Elbd9CpSP7LAm8n5XP58QtWtf07bixhwaORO7atYL6Z4wIfP4I4x9ODkzCYE
         VPkQ==
X-Gm-Message-State: AOJu0YygGe0fQZlyG0bMYZwPzXYa++LmvHNtX7EKv5wOjo8gvOmEZrXZ
	mQB+PeVtspFZDMwdtf55h2wD3imUn94b4ky/4MQx8sb84hLPY1U88JY2MFtJGA==
X-Gm-Gg: ASbGncsUNwl4NUA+cgfGRHOyhQfl19pHgtaKdUKHUtQ0xEFZ5IJTLR6Fp3RTLddPzX8
	IhiB80KPSO7C13ZBqL2boDHGVlsXAgFrORKUuN0IEEHW1QmrMYEDhTAwE+JOd7PRcS95ZrQUL4e
	v83YQKAZPpyeaPC6Lmyq/hh186c4RhCk4uZrcTHeUHuczNqfHiHZ04eZ4mLVq8Wcv1w6gs4OZQG
	dEJ51OC0AiUz09MsX/JchfZBNhSOyi01x3hnQBuauv72V/ZJnuiPRi2Qro82P04Xhuw8Y8BvuyT
	OxTeTfR9S16zU1f19MuuKr5QYW6vrbayjOEzvoA+EBKqHZewBejGUI1BVCmXtPk6jwBI3R4kHG2
	GhrCsfDfw6sIK1H5YxfJHvNtN/Ric/H6GjM5tqIVPPfu5Y0cmFxse8A==
X-Google-Smtp-Source: AGHT+IGpDg4bu2Iz0Qo32x07eObTPKOYfZnChzMEHLRQM5E+EdXoU8CALzYzrpjiCUz8iiKhrByPJQ==
X-Received: by 2002:a05:6214:14ec:b0:6f8:c23c:5257 with SMTP id 6a1803df08f44-6f8c23c82b2mr203272536d6.11.1747838555771;
        Wed, 21 May 2025 07:42:35 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b0987570sm86275176d6.121.2025.05.21.07.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:42:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/2] selinux: introduce neveraudit types
Date: Wed, 21 May 2025 10:41:23 -0400
Message-ID: <20250521144123.199370-2-stephen.smalley.work@gmail.com>
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
logic, allowing all permissions and not auditing any permissions.

This change just introduces the basic support but does not yet
further optimize the AVC or hook function logic when a type
is both a permissive type and a dontaudit type.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 eliminates all references to "unconfined".

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
index 7becf3808818..9b3b64ea6790 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1153,6 +1153,14 @@ void security_compute_av(u32 ssid,
 	if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
 		avd->flags |= AVD_FLAGS_PERMISSIVE;
 
+	/* neveraudit domain? */
+	if (ebitmap_get_bit(&policydb->neveraudit_map, scontext->type))
+		avd->flags |= AVD_FLAGS_NEVERAUDIT;
+
+	/* both permissive and neveraudit => allow */
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
+	/* both permissive and neveraudit => allow */
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

