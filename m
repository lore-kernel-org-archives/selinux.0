Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70F3314C3
	for <selinux@vger.kernel.org>; Thu, 28 Aug 2025 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400611; cv=none; b=blr2Zrk5N/s2JBgro6h2Yh/5whjaauB3h3ANH48ezy5gUv+4HKGU6vTtY/pp9sb84fUNL7zE6gGORs/Ic4Pt+P+kxQ60XJE0Gd8ANU0bo1miq5x9YJFCfLZgqqgUvPpiMzK8yYhxDE6OlNKUqW7Vcc/ar3OacdCDfySp6fjlkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400611; c=relaxed/simple;
	bh=3353bcpIGRIGbopE0B7L6BZQvKmk3n9SpqVWvTWaITw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tewnIU4pT12K0sigGyp/wfRM41rcxK0zO9GFO5G11D8JLsmyk9BjnSLB8+f5fUzoGtn1eb+z86sNbgLTb4Wsg8Iy/B2Gj6pB8YtfZQQmhwWo119E1CsitPAaXThIaPCpWqBTc/3N6z7WJk/kStuH2/BgNhHUIN52dLi+m4+kPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TsuqjLxN; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TsuqjLxN"
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ed0f07fca2so13990825ab.0
        for <selinux@vger.kernel.org>; Thu, 28 Aug 2025 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756400609; x=1757005409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6KzRF6YcVTWHiQGyl40pENYDHMMfDUIGfTEGKzKBlf8=;
        b=TsuqjLxNc+XpRp217F/nOUPW5ZrDYHl/O9RWQuXr2iCOjIgiwTcOM/Hs2kC8ceMNzq
         lwQJ/rAawjpqzxTR2FKe69kCrqjpdx7BdWghFC+FL/PuLKyh/vrG+NODoRElhQQqEfvL
         jY/VeVJ1G2aU0MTFRznIjUMftDYdOdOCPHsvRi+PaiNzx4GyuWQsTnM/h6Z1vXSPsJ3G
         qQnMIAFHAk7J1tYLSaOlhFPZXIYc70au/V7R6cLBg+DdCkM9Sjf2debIbKvsbEHgmkWe
         Gmwb0JZlXtPw3rvZY9cTg3kStpF5s70iUZqqCDWEZSYrcx5oJ3L4/IYtGceengdWcoRh
         Fu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400609; x=1757005409;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KzRF6YcVTWHiQGyl40pENYDHMMfDUIGfTEGKzKBlf8=;
        b=Et2hQgu283GcOmJa4TomBDLefK8tlEA+vwmF+bPUyaUCPuJsbDFvB14Z9h+LwbAK2i
         4sZ4s2j3bDAyfsb/Bv8flsyaRmgXiuG22+FVIi3CGBkfBAt4Ru0Y2dNt6OSH/KNGNTAd
         Fxr5EFPaam6EjZ4r/xsTYew77+tZpE1ql3/L8ZQ52CiUdveZK27xZQnVRwfNeix2BK6S
         jTyqeBtNAeMHo3WjwP37kol+BfspGf/ER78NPPyr1A7+NuYHeE+sbZelox7MgQ5/hV/o
         vdJhCP2TcMvRU9V7NDirWqXNhLOc0w9B09BC2XTXGI8YL0SzSiwwui9sY7NsSD+QCQ7x
         oFmw==
X-Forwarded-Encrypted: i=1; AJvYcCVaRW0ZQeQhMwqlYH06OikUCSix9gfRla4+CiN9bYdEzz4O01ldaDRwlWgc5fD9ckJy9ji8+b17@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYV7u6/wzGYz6TAi48AayBHxGDQA1uwcBLAyebExMDH2vA+to
	EnVbUX2lugN9B1iB2rDDbyhrfXiZ8Iyr4TGEIwQJYQ23cafSyJVAEvVL4/OfDfMYpd9Pw9Vj1sC
	zwU45O93fmQ==
X-Google-Smtp-Source: AGHT+IEQiVHUwF8AvivRZCGJJp+vt2CPWY9JRHr/WC0Avk2OOCHmNzfShFLjZYRcOHRMqt0VFH4+jSbSqylg
X-Received: from jabkq6.prod.google.com ([2002:a05:6638:9006:b0:50d:6b6b:f5d8])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:1c0b:b0:3f1:a201:1b29
 with SMTP id e9e14a558f8ab-3f1a2011c32mr30017745ab.27.1756400608604; Thu, 28
 Aug 2025 10:03:28 -0700 (PDT)
Date: Thu, 28 Aug 2025 17:03:15 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828170317.2322582-1-nkapron@google.com>
Subject: [PATCH v3] selinux: enable per-file labeling for functionfs
From: Neill Kapron <nkapron@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: Neill Kapron <nkapron@google.com>, kernel-team@android.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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

Changes since v2:
- Sending as separate patches
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

