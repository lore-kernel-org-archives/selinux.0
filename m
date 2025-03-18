Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5631E5210
	for <selinux@vger.kernel.org>; Tue, 18 Mar 2025 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286713; cv=none; b=ZIe51tJz1JFvKOh17Lwp5uumY7glpsEpBCuvnHsFxI443QHrIgzvKGbDNANep5gYNvqbSrCz/OFhCrAx8N+xR8o+JJaPv8m4xegkHsV4AJSDgcuULk/utXJXbtAor6Kp0zmjZxuPoXiqiSCoaXbjfRTV5hT18K+LLBfiSkMkI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286713; c=relaxed/simple;
	bh=a75DmpNf3xS8rT6Xwr5v8teA7nZPlrMGWX5gIHwTAZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZTU+wQPgouS+ob3pCh/IbMJNpSRKFVt9KgfbUW46wi4uTiFWt2kpDqSRwicwHyq/3Csnh9EuMLsc4utGKUdvzXTxRihsbyNEyolbl2jm0z4kA2xV318Ri7EC94vmQpCz1WRCldS3rokSA673aE3LrjFAMRoy4NSSGE8uQ8PpOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H6P8RQgd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H6P8RQgd"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22409077c06so133134435ad.1
        for <selinux@vger.kernel.org>; Tue, 18 Mar 2025 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742286711; x=1742891511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufiC/5hV83+z5vmS4gQxs6pyrv+X+r+pDrT89hjCjPw=;
        b=H6P8RQgdGSMDIp1fMx+/ktWWcc23w2/5+5n8uroYdFPRnaC1vHWhiWpp9XLhFe4BVw
         CSsZwtFskN/DPRGTEK45FUn7GGXKBsP414Ta/bLXGVbUiic25Je0uQepbFfvbbvrfqTo
         xxFc0gp8UCdUsixQPhzCLxeP247g/wl6nfzXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742286711; x=1742891511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufiC/5hV83+z5vmS4gQxs6pyrv+X+r+pDrT89hjCjPw=;
        b=veCcwQ+Z7e7f+k50Na1vYhNCBFaES7bHsZs4yPGBd5RLLx3sHq+/SqPJeA8zZm1JtL
         /gdVy86GUswzf0lC8L8xSKkySx60T5D5H1ReFLMTgbWopNc45Ewj+0ZhizwCauDsoeLf
         dnjLSub6G0TOmfPZSXN3KoL/nXInba22o4r1UCcLbRVCbv9pNk4ISF0Aitamolg66kRo
         aEETdezbxL8x0KSckIEcehl/bPhURIZUxIznCWZRNjR+4/rF9dWVymtwZDXJ+eTA7WXW
         UoWmk8wCXwUQqkNiVWJAu0Vk91Wfote30XurizpXMZE8l4fDuHzPI8GDtRZGeQaakSHT
         yt2A==
X-Forwarded-Encrypted: i=1; AJvYcCVxCyN3VEFBUcA0vOHY0IWY91uHCGhfIKF94DccyZqtVW/jBbM9f7fq8syhQ37TatxlXSkth0Qg@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXf/o8awn0tT9dJJBsvGYa5pi/XVKYWP8MSw+h35nXHPsM3iu
	tRBb0JwZ0s2XNASGOyMWyYEkPq7YaR80vqEitCuomufzoiD5GGe6TzhD1Cf1KGBW+JVPiEn7Kw=
	=
X-Gm-Gg: ASbGncsAVHGhBJDQiNEO3XbYMCKo/KCdD6lrsu6kC+Lubes6mbqbhjAbcEnvIKHw6SU
	J6wZFPKFYRb/v83cZ9GRUnjJ/2LWmIBM75gx5pPZD9TkgXB3++aeWOCvXJ3CWN7cEx9X0w5Pwcz
	u9xh9tCif3DFztfbdxwz/r0fth/xwz9748WBDDNiYOeq2DLio7v84RmF9c010DwWmL43lBmUwhh
	oef5buYLjxhBKaGcdbNT34BeI5lTBo46LKq6HAlb0VBWnM0F9WtPEkjhWZoAlvQx4/cE8Me1Iyz
	6uTCnBIGdG4w0P1sdh0H8GOZEXC9OAsFiU5nmW5vS5usZPapH+KOEIne4UDNdhTL7p5K3RenlDK
	uInA=
X-Google-Smtp-Source: AGHT+IHmk3Viy3W+VYVYWq4BDTMLHwB49OQOWnxKFIn4dQ6co3eSLfUAG06M5GopVUpr1xTdvdZauQ==
X-Received: by 2002:a05:6a00:21d6:b0:736:520a:58f9 with SMTP id d2e1a72fcca58-7372242e8a6mr13981517b3a.17.1742286711023;
        Tue, 18 Mar 2025 01:31:51 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73711578a67sm8932464b3a.78.2025.03.18.01.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 01:31:50 -0700 (PDT)
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
Subject: [PATCH v3] selinux: support wildcard match in genfscon
Date: Tue, 18 Mar 2025 08:31:39 +0000
Message-ID: <20250318083139.1515253-1-takayas@chromium.org>
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
regular expression rules, relabeling thousands of paths under sysfs
after it is mounted is inefficient compared to using genfscon.

This commit adds wildcard matching to genfscon to make rules more
efficient and expressive. This new behavior is enabled by
genfs_seclabel_wildcard capability. With this capability, genfscon does
wildcard matching instead of prefix matching. When multiple wildcard
rules match against a path, then the longest rule (determined by the
length of the rule string) will be applied. If multiple rules of the
same length match, the first matching rule encountered in the given
genfscon policy will be applied. Users are encouraged to write longer,
more explicit path rules to avoid relying on this behavior.

This change resulted in nice real-world performance improvements. For
example, boot times on test Android devices were reduced by 15%. This
improvement is due to the elimination of the "restorecon -R /sys" step
during boot, which takes more than two seconds in the worst case.

Signed-off-by: Takaya Saeki <takayas@chromium.org>
---
Changelog between v3 and v2
- Cosmetic changes
- Mention the new capability in the commit message.

Changelog between v2 and v1
- Use given genfs rules by the userspace as is, instead of appending "*".
- Fix __security_genfs_sid hadn't checked caps of the given argument.
- Fix the wrong strncmp usage bug.

 security/selinux/include/policycap.h       |  1 +
 security/selinux/include/policycap_names.h |  1 +
 security/selinux/ss/services.c             | 19 +++++++++++++++----
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index bd402d3fd3ae..7405154e6c42 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -16,6 +16,7 @@ enum {
 	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
 	POLICYDB_CAP_NETLINK_XPERM,
 	POLICYDB_CAP_NETIF_WILDCARD,
+	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index ac1342d6d5bb..d8962fcf2ff9 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -19,6 +19,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"userspace_initial_context",
 	"netlink_xperm",
 	"netif_wildcard",
+	"genfs_seclabel_wildcard",
 };
 /* clang-format on */
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e431772c6168..5af2fc6a5062 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -49,6 +49,7 @@
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
 #include <linux/lsm_hooks.h>
+#include <linux/parser.h>
 #include <net/netlabel.h>
 
 #include "flask.h"
@@ -2872,6 +2873,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 	struct genfs *genfs;
 	struct ocontext *c;
 	int cmp = 0;
+	bool wildcard;
 
 	while (path[0] == '/' && path[1] == '/')
 		path++;
@@ -2888,11 +2890,20 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 	if (!genfs || cmp)
 		return -ENOENT;
 
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

