Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D2310779
	for <selinux@vger.kernel.org>; Wed, 27 Aug 2025 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333367; cv=none; b=ocXhOhGMosHCQsY+7rfRPRy68OOMlr6pykHqPeXg7xayuyXRwStN8nmlccNS4yVhLl4U/HiJme/QmWAiNv91H45Qj7CVa3TjUQilWArVIgC1nZt8jLZJ6yN0/sAjCZ5ocHgb1splliYS86FJDNeYbCuPfMgsCjxhFRiuNhfnzt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333367; c=relaxed/simple;
	bh=+626KgpfrJ+FogqMQ8fyiAgAJgp9+vpE4BpVHswrI+4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PU8PtGaJ6OuJ2E+R3+pzGXsifxxpRWjVmuiP2GCo3nC2HSvPpL11oZ+JpGFgwYKu04IVC5UmHBlYiTkmRJsLInJdIysNNxwGZ6K1Ox4YPGE69+N6heIfimZ32gjpIMUMtiMEESnKt0yOxexS+g9UOlOfsVlskNyq+Dvc71LnnCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVbfkhct; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVbfkhct"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3eea931c037so9533525ab.0
        for <selinux@vger.kernel.org>; Wed, 27 Aug 2025 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756333365; x=1756938165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QRpuOHUSK85pD9q1UCfsgWeV3fHjpk944owcc57Z0q8=;
        b=XVbfkhct6vdhevQFW3alDJOz9Wlp+fEi72bEtewV3GMdUiR3CmVdUgmoMuV3IUc3VK
         +zTGXiBxijkLMh1iQGAl/i/5mP8Gk6YZPtALmbacDzdWLpExXysdDORRNNcmMXr7s+KR
         ijxRoOjxwiJJGjJyLDbbT6s/gfXJw91WYpsJpqL352UeDxhCzbOfiW+6hSHBift1lwJo
         2jb9QQyM9p5fsUuDWvh5DBzPe5sFw7fa9XvRBQRhIo3hayFdx2lzwwkNEYio5PWdyXmW
         LsxoCGDDmmGv6Hkwltux+vhSa/PQzHooAT4jdJH1bOLCEIgUTiCzFYwG29iOMr16/pQa
         xzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756333365; x=1756938165;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRpuOHUSK85pD9q1UCfsgWeV3fHjpk944owcc57Z0q8=;
        b=OJzDGLvRMR9WCE8juBCgdMRPgpF6iVJIxWgzdKpZhy+y2/RTZ7K2f20zdhobGeqcd+
         72McBXfOShWfebZrMB/QkoQg3lSNqmvXMPpbJLJmagk2mbF1/cGHpw+zu9V/Tcuy9KW1
         L/VHFlAKqNsZVXlUX/bn2+IDFCNgag5FDXui/aMobiMIv1WrIh55Cj8GlwCYwTMfU91f
         mOkq8ruY3vRjzRtHxDw+83ZVKCZKcsd6NhBsfcv08S2bz48nppEm8Z6Llm3m/Dym/Ttj
         PxpXNhLAgeUGPBGZ8tnwZhWGLvb2J410SoKln5ZKaGjwTc7lkHY1GO4Vem3kPA0HZVHI
         G67g==
X-Forwarded-Encrypted: i=1; AJvYcCUgL1BPZlwSMjteNy3IUfBa8FW5DOYmCkBWpL2Jo6ULKA+M+yqJOAxy4PUBpVzHJyxziLQ06EB/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7MZypfgdVeHX9qSs68OmBaqBwIsmMseRDDRBzoq08V9IKMUH
	JEUCStT/Ab6feor/CMsCKDIyTu87JFy08AhjGUAIIerdYSnCoTWqjwZTlslOUQX7Fhd/HXOwEwz
	TaDDYcG1krA==
X-Google-Smtp-Source: AGHT+IF/dsncTx9pRy3JGAb5S1g0KuTjPUJJ9aYqA7rq42Lm8oxywmAYxoJnsNPFUm6Yu0fJ/ZUFICxo9wGv
X-Received: from jabfa12.prod.google.com ([2002:a05:6638:618c:b0:503:6331:8c2])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:3cc9:b0:3ef:ae37:528c
 with SMTP id e9e14a558f8ab-3efae375302mr68853255ab.17.1756333364995; Wed, 27
 Aug 2025 15:22:44 -0700 (PDT)
Date: Wed, 27 Aug 2025 22:22:20 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250827222224.1648500-1-nkapron@google.com>
Subject: [PATCH v2 1/2] selinux: enable per-file labeling for functionfs
From: Neill Kapron <nkapron@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: Neill Kapron <nkapron@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch adds support for genfscon per-file labeling of functionfs
files as well as support for userspace to apply labels after new
functionfs endpoints are created.

This allows for separate labels and therefore access control on a
per-endpoint basis. An example use case would be for the default
endpoint EP0 used as a restricted control endpoint, and additional
usb endpoints to be used by other more permissive domains.

It should be noted that if there are multiple functionfs mounts on a
system, genfs file labels will apply to all mounts, and therefore will not
likely be as useful as the userspace relabeling portion of this patch -
the addition to selinux_is_genfs_special_handling().

This patch introduces the functionfs_seclabel policycap to maintain
existing functionfs genfscon behavior unless explicitly enabled.

Signed-off-by: Neill Kapron <nkapron@google.com>

Changes since v1:
- Add functionfs_seclabel policycap
- Move new functionality to the end of existing lists
---
 security/selinux/hooks.c                   | 8 ++++++--
 security/selinux/include/policycap.h       | 1 +
 security/selinux/include/policycap_names.h | 1 +
 security/selinux/include/security.h        | 6 ++++++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e474cd7398ef..333bb6cba25e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -476,7 +476,9 @@ static int selinux_is_genfs_special_handling(struct super_block *sb)
 		!strcmp(sb->s_type->name, "rootfs") ||
 		(selinux_policycap_cgroupseclabel() &&
 		 (!strcmp(sb->s_type->name, "cgroup") ||
-		  !strcmp(sb->s_type->name, "cgroup2")));
+		  !strcmp(sb->s_type->name, "cgroup2"))) ||
+		(selinux_policycap_functionfs_seclabel() &&
+		 !strcmp(sb->s_type->name, "functionfs"));
 }
 
 static int selinux_is_sblabel_mnt(struct super_block *sb)
@@ -741,7 +743,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	    !strcmp(sb->s_type->name, "binder") ||
 	    !strcmp(sb->s_type->name, "bpf") ||
 	    !strcmp(sb->s_type->name, "pstore") ||
-	    !strcmp(sb->s_type->name, "securityfs"))
+	    !strcmp(sb->s_type->name, "securityfs") ||
+	    (selinux_policycap_functionfs_seclabel() &&
+	     strcmp(sb->s_type->name, "functionfs")))
 		sbsec->flags |= SE_SBGENFS;
 
 	if (!strcmp(sb->s_type->name, "sysfs") ||
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index 7405154e6c42..135a969f873c 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -17,6 +17,7 @@ enum {
 	POLICYDB_CAP_NETLINK_XPERM,
 	POLICYDB_CAP_NETIF_WILDCARD,
 	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
+	POLICYDB_CAP_FUNCTIONFS_SECLABEL,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index d8962fcf2ff9..ff8882887651 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -20,6 +20,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"netlink_xperm",
 	"netif_wildcard",
 	"genfs_seclabel_wildcard",
+	"functionfs_seclabel",
 };
 /* clang-format on */
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 7f19972f7922..0f954a40d3fc 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -203,6 +203,12 @@ static inline bool selinux_policycap_netlink_xperm(void)
 		selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
 }
 
+static inline bool selinux_policycap_functionfs_seclabel(void)
+{
+	return READ_ONCE(
+		selinux_state.policycap[POLICYDB_CAP_FUNCTIONFS_SECLABEL]);
+}
+
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
-- 
2.51.0.318.gd7df087d1a-goog

