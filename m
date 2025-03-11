Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2AE22CBE9
	for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685384; cv=none; b=SwUoxhCdI6pzOKT216TL3opUbebNyKsf670QU1EFF5c4sLH6VtR1RmPRgvfMg/83KGg4Zm63bkHgGZVK9OARZnmo8nF1nP5L44wWKkJK0hnp+bvNqN+xDcfgJGVCJ9JoO9Ra+w0xf7XAFagT4yC0dRZmfGy6BuYqXKMmFi6C2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685384; c=relaxed/simple;
	bh=E94j+S3XqlR9fxhrBV37eYBDgAQcPQ+PJNqj0VWmtMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOL6PMC8l1rJhttV7cj6Awx0WJwEM74hw8S1QtSIRxrpFSrXXng8mqWrqDUQZYO4xBOxgie9Jr/0EbstygBon+DTqKqR4j/2hatS8N8IUL/n3KWyLbbjQbTWEXmdsk7U2R3wzvARD0xlt5hA9FZkSE2Ry1VCeIm3UorEv4UmD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hy12yUXi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hy12yUXi"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223f4c06e9fso86721835ad.1
        for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741685382; x=1742290182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/COamV3ex2L4IvVamgvlxhO7hc/WiGdp89BrGp5CMc=;
        b=Hy12yUXijHjjFxeQvdfeU8jGnrZWr0nT6Al7qaqd2I1MHO16in2x/9hU5RQRgkPAWZ
         FCimuruOzEc8ym/gTF9O9n5EZQhBxPtjXpqX7gDT5UetrSq8augkqkeEZMNRN6BbOp5y
         UExCpzgJH2hE0nA9WVqtlMENMqHSWLOqQHpLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685382; x=1742290182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/COamV3ex2L4IvVamgvlxhO7hc/WiGdp89BrGp5CMc=;
        b=Ar1y5B2Y6sjUlg0jHWkmWp7mHF9nebHh1ZAPOkU3FSVJ+pGeN/bclNhAE5yhtT9Acy
         rb8+t0jQh2jxN1vknkRC7MvyB4qq2CUm6QAwnVqifecmr5teqFQ6RIH51l54SO54TPAJ
         NZdDKSl3huN0yUMdTB0h+HUD/i6Ou3oiETwwuqMTfFi1eYrTTxno7S1YT7bUO0BmMDI/
         Mj6Rr6sUNICK7OlVEgy92XqzZRV0PBYccn6YcxEiQxK6u7W/szQbYN7TZQNmuWSt+rwq
         fkaBrFcA50kPlWQcZZP43Npqwhz4VfCT4oiTQ9oLovvWHtkxbSW1XmRhSLuWSmijFijF
         kEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI8GO9fXRZk3KLLNQuvyYVBBinj2qeO9eryzBqUWHImPXCHedE+uKNcI8yDaPYiKQlyrMUP6Xx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxv+qMQN7T9EARq/BfzupO3Iysfl8qG9AkXfocqjtemUHt5J1b
	ZLVRxqyPIuSfDvPfNmYZoP+3WPzx83i+kkMZh4O+JdZ1KybGHN+u7ITqt7sg
X-Gm-Gg: ASbGncvMPz7coyO9H6Lqtyx5/8WcSUsx4tiAwPJ24OYBRjriz/qr72Ns7zJWsElc35Z
	rOT4nK5kYsmyPpr8xX1SqalU+R4b86wZHPj86WNPgAkuDSs4nsScjYJxN/8jLVEWV1fTtTDPicF
	rDudZjChY2kAYT6J7JgIvQvG4uMqeQ/4JR3uvIEnGnTzYmPYykgQ1MOmbqXIPcs2gLph6qNpEn6
	r4gy3UMdFrvHuKkyvrkluvPSzawx2aV/oryxM6RZncimqHlwNNXMag6WSdAgIW+hGMUJm1po9cX
	T6XH6ABvbgcGUTf/zhla1CxpxNWtC5XWkPSHiMDmINpfcqYPED9+QTzztWJ7BskgLzY6wx3sWlZ
	XF7R5Ch3MSxwfE1EU
X-Google-Smtp-Source: AGHT+IHAfqM8qKTVhtn5ZLGlt6/DmYhW5Ei37GSB7zrDQAglu4GeJuJSYGVTMSx53NZxFQs1/PG0qg==
X-Received: by 2002:a17:902:d4ce:b0:224:3994:8a8c with SMTP id d9443c01a7336-22593d5ef24mr32439015ad.8.1741685382430;
        Tue, 11 Mar 2025 02:29:42 -0700 (PDT)
Received: from localhost (199.211.81.34.bc.googleusercontent.com. [34.81.211.199])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410aa5c58sm92997975ad.234.2025.03.11.02.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 02:29:41 -0700 (PDT)
From: Takaya Saeki <takayas@chromium.org>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	Nick Kralevich <nnk@google.com>,
	Jeffrey Vander Stoep <jeffv@google.com>,
	Junichi <uekawa@chromium.org>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	selinux@vger.kernel.org,
	Takaya Saeki <takayas@chromium.org>
Subject: [PATCH v2] selinux: support wildcard match in genfscon
Date: Tue, 11 Mar 2025 09:29:20 +0000
Message-ID: <20250311092920.1114210-1-takayas@chromium.org>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, genfscon only supports string prefix match to label files.
Thus, labeling numerous dynamic sysfs entries requires many specific
path rules. For example, labeling device paths such as
`/sys/devices/pci0000:00/0000:00:03.1/<...>/0000:04:00.1/wakeup`
requires listing all specific PCI paths, which is challenging to
maintain. While user-space restorecon can handle these paths with
regular expression rules, but relabeling thousands of paths under sysfs
after it is mounted is inefficient compared to using genfscon.

This commit adds wildcard match to support rules efficient but
expressive enough. This allows users to create fine-grained sysfs rules
without burden of listing specific paths. When multiple wildcard rules
match against a path, then the longest rule (determined by the length of
the rule string) will be applied. If multiple rules of the same length
match, the first matching rule encountered in the genfscon policy will
be applied. However, users are encouraged to write longer, more explicit
path rules to avoid relying on this behavior.

This change resulted in nice real-world performance improvements. For
example, boot times on test Android devices were reduced by 15%. This
improvement is due to the elimination of the "restorecon -R /sys" step
during boot, which takes more than two seconds in the worst case.

Signed-off-by: Takaya Saeki <takayas@chromium.org>
---
Changelog between v2 and v1
- Use given genfs rules by the userspace as is, instead of appending "*".
- Fix __security_genfs_sid hadn't checked caps of the given argument.
- Fix the wrong strncmp usage bug.

 security/selinux/include/policycap.h       |  1 +
 security/selinux/include/policycap_names.h |  1 +
 security/selinux/ss/services.c             | 20 ++++++++++++++++----
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index 079679fe7254..2b4014a826f0 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -15,6 +15,7 @@ enum {
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
 	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
 	POLICYDB_CAP_NETLINK_XPERM,
+	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index e080827408c4..1053f2c95ff3 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -18,6 +18,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"ioctl_skip_cloexec",
 	"userspace_initial_context",
 	"netlink_xperm",
+	"genfs_seclabel_wildcard",
 };
 /* clang-format on */
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8478842fbf9e..9f98c9dc71f6 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -48,6 +48,7 @@
 #include <linux/audit.h>
 #include <linux/vmalloc.h>
 #include <linux/lsm_hooks.h>
+#include <linux/parser.h>
 #include <net/netlabel.h>
 
 #include "flask.h"
@@ -2863,6 +2864,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 	struct genfs *genfs;
 	struct ocontext *c;
 	int cmp = 0;
+	bool wildcard = 0;
 
 	while (path[0] == '/' && path[1] == '/')
 		path++;
@@ -2879,11 +2881,21 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 	if (!genfs || cmp)
 		return -ENOENT;
 
+
+	wildcard = ebitmap_get_bit(&policy->policydb.policycaps,
+				   POLICYDB_CAP_GENFS_SECLABEL_WILDCARD);
 	for (c = genfs->head; c; c = c->next) {
-		size_t len = strlen(c->u.name);
-		if ((!c->v.sclass || sclass == c->v.sclass) &&
-		    (strncmp(c->u.name, path, len) == 0))
-			break;
+		if (!c->v.sclass || sclass == c->v.sclass) {
+			if (wildcard) {
+				if (match_wildcard(c->u.name, path))
+					break;
+			} else {
+				size_t len = strlen(c->u.name);
+
+				if ((strncmp(c->u.name, path, len)) == 0)
+					break;
+			}
+		}
 	}
 
 	if (!c)
-- 
2.49.0.rc1.451.g8f38331e32-goog

