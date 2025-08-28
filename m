Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4743314B6
	for <selinux@vger.kernel.org>; Thu, 28 Aug 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400719; cv=none; b=nMbRbYIUBbFy5v5/F/b/5GB1KXvQtJDXW7lAe71CoK7AwERPkarGG4sPYZ2k+dD1aEargsFkUhHPIHtyR1TFHNejie1yZNQkOBuGQ7i4IQpQmiVN9ZIPelROfivrz/LUlU57emiXuxWv8ZU/8m/PkLNiMj3YWquJDw+Cupo85HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400719; c=relaxed/simple;
	bh=pQO9z0tEBY64mlun9YfNdxymZfGAFb6no7D8RyO2jKQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WYiUkRNBFtS7oig8VUyhrrGJUOgbUwC/W94MyZhs02PvBpse6gf2N2+asfuXAEpTYSpDe0CEJG1HCkINl8sYdDZF7sXcwEGKedsYTsKg2QVhsxR3xJQWOcEfJSC+kCve6NqtjFwo1Xp225qv8+YHMrYPcDV7/0scchifwhZqN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0sPZb8Su; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0sPZb8Su"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3f1ebcf0863so6882135ab.2
        for <selinux@vger.kernel.org>; Thu, 28 Aug 2025 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756400717; x=1757005517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NwlC+3sVgl3ZYVMW8MzPRdf263gPHPgpekAc5vsCAUA=;
        b=0sPZb8Sui7q07X8ICOhxVfsDxNCe96PXIqs3mR/duWCIhTrGNcTMRDHnSPwIqczO34
         ug0/Fz1vEQO4+JoRh1F7M1E0vqMmwyoqXC5fIoRki4yc0vJweS0jT1hglMXnEhJ09K/7
         teYG02/a4xWmmLApoNUkXrn+PZNOt34BpMKbVd/a/QrjjkGbePirffRt+qGupq88XiK5
         oqnNUnQAaxniULZCG74laABYKKP89qM80h+6W+WCjobAKbH5kz1YEoxXi08lj9pFrgTc
         sC1gfWF6H/HG5uytqsNJqLXF42w1acfB3nxbX36qan8TVFfqnaGkOvetwJc8VSLRRKMB
         k/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400717; x=1757005517;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NwlC+3sVgl3ZYVMW8MzPRdf263gPHPgpekAc5vsCAUA=;
        b=L0FfrA7pBkttSyOUuZDrpIKqzu0OwI+utIBQLhEXIg3gfeqb4MuCmAUiKAfENUZeXm
         7+fS5k2anb9zPjizlCjXO2pJ3xrO+zcKXNLFEYb3BvW4/cZ8F3Z3F/BrE9KKMrkkiuX4
         gDVnDk7zLe+g8QcQGr1DYVeFKVyQN3XX1XcCeKvSJgYjJ/JCEBNPXRMkiiH+3/I28IOH
         erFlouxdNDEcXSoA5NNCbVXkKbsP9SnYKzTaQPrEZCNGTEumPm41zQ+z3IlvdgV5DL+D
         cckFkQkNsIWrXprU+ZKLRTILiFUnq0dQjPSaYkXsy48hk6MEIfte1G5YxjZO9smfbYnf
         kb7A==
X-Forwarded-Encrypted: i=1; AJvYcCUz63YIKDpV0UPbloe8tyESJM6G/wWJ3oGJk3co6zE4ge5JKZH0SbdS0BqvOe90Cwo0JcDeE5D3@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFd4RTuuEJy0AyjbZGkN1MseEXjP96UWxgMWzdh/qAMrlTjqO
	7VoOua9CUDVUSvYmO8CxLh0VxmvolWlSe83dholvqYd79VL4T5QbSdxMGrDtx3KVnxcpJrHmLUp
	WtrzBtZepUw==
X-Google-Smtp-Source: AGHT+IHeiB/g7MoC5hM/j8DBEbOtJU9Ex8jsCFI82tiPNrrJrvmh8yZ7CWP4grphw1E3V9ys9bZWpuFo6tOK
X-Received: from jaa8.prod.google.com ([2002:a05:6638:ae08:b0:50d:183b:437b])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:2288:b0:3ee:a3ff:96ad
 with SMTP id e9e14a558f8ab-3eea3ff97a8mr137085645ab.14.1756400716745; Thu, 28
 Aug 2025 10:05:16 -0700 (PDT)
Date: Thu, 28 Aug 2025 17:05:01 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828170503.2323187-1-nkapron@google.com>
Subject: [PATCH v3] libsepol: Support functionfs_seclabel policycap
From: Neill Kapron <nkapron@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: Neill Kapron <nkapron@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This adds the necessary userspace pieces to support the
functionfs_seclabel policycap which enables per-file labels in
functionfs and the ability for userspace to apply the labels.

With the policycap disabled, legacy behaviors are maintained and
per-file labeling is disallowed.

Signed-off-by: Neill Kapron <nkapron@google.com>

Changes since v2:
- Sending as separate patches
---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 0835ea21..bbaebf1a 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -19,6 +19,7 @@ enum {
 	POLICYDB_CAP_NETLINK_XPERM,
 	POLICYDB_CAP_NETIF_WILDCARD,
 	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
+	POLICYDB_CAP_FUNCTIONFS_SECLABEL,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 7ac0ae7c..83eb6143 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -18,6 +18,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX + 1] = {
 	[POLICYDB_CAP_NETLINK_XPERM]			= "netlink_xperm",
 	[POLICYDB_CAP_NETIF_WILDCARD]			= "netif_wildcard",
 	[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]		= "genfs_seclabel_wildcard",
+	[POLICYDB_CAP_FUNCTIONFS_SECLABEL]		= "functionfs_seclabel",
 };
 
 int sepol_polcap_getnum(const char *name)
-- 
2.51.0.318.gd7df087d1a-goog

