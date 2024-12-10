Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B36F78F5B
	for <selinux@vger.kernel.org>; Tue, 10 Dec 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831794; cv=none; b=Xa6d0D9Lq5Vyd26gSbKPIAVWJQtqz9nqowQL15K134fYJs3TBYjXDuogtQsRuWPJRLvmHZrQU1sn4+neH96tBVaezWbBF4O5g9Q6MltRWFGtEr5f/95jVtRJgTCBXdaQrHnIquXkYoMuhnqo08Wq2xTpLrq7Qo8jwusB5TWdJZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831794; c=relaxed/simple;
	bh=6IJhs5D+pQBhrm0/2/gy9MjorbR1R14BqnXWIlCnjpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WL2spf5xz+2/CA3y9x8qCDMXNHE0bGVNWRKTWeU1//Qu3LHAgaNFQ6EhBNNApuQoKmVXYowcpM8PVgHm+IGKrAnrpHXQpuiq/tOHuIJwNPie4IaFW4AErytr6x66vyrnMGVyKmnJzwF7gaMWROT5qjGDC7ewYFVX9WVawBOJdRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OVla2nyO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OVla2nyO"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2164b1f05caso20875885ad.3
        for <selinux@vger.kernel.org>; Tue, 10 Dec 2024 03:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733831791; x=1734436591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cSsVyssvQqcZkG1D/ux0IaAuMEZoArTBKOM8w+/CUo=;
        b=OVla2nyO5nSw1DgqWLYrUexEilYcrVhDPlmRbJOyIW8Bthe5R4LvUNCQIkjnQXml3z
         13Ec8IBF6fzy5gP0xEbc2ClmAW7eIJvtcSrz5TZuaG3szeMTUGzpHTDY7ohRXEj8jmWY
         XX4pvyU0l0wtNcOgmURn/QeeL+SYBkJrKeXNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733831791; x=1734436591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cSsVyssvQqcZkG1D/ux0IaAuMEZoArTBKOM8w+/CUo=;
        b=ufYUa8iwrpA/IMAVunBd6ZJCF1zl9KT+8H9BNt7k84YJhTB/HFYnjacmhYanN+wsqi
         68spdB6qmg/uyER/OqWayvV+jRuytkdTEnq/Ch/Z4ykkyt0x+4Jfdz5lnH4955BifGdu
         Is/0MZ/9cKu8NiJMIMqsBpHGgyOEis2mluGaYwZA9ZjiW5uW9oQRGZqyq8AzLNKJffcx
         BVgXwnnXhl46uASMv/qW7qnDwsVAhlf7ffX0Qi5cYCa1fzkJR/eccUbnpvzOqIG5zScr
         HsWNsLC4KkZl7QrCxI3aSj95T3viY0iZ1YfLLQqnE4amueUJRT0NHzeplePTlOMognPy
         Ge8A==
X-Forwarded-Encrypted: i=1; AJvYcCXdF4LVB6kJ02FrRKuRyXRy7otVdsxyyOU/77z7IrHfgZHNbBMiEWcPzu0Yb1api55qs6JrPn+f@vger.kernel.org
X-Gm-Message-State: AOJu0YwLUiBEG9ziUfeeK2NGl6wBeA1MIRgS4KPCDj5PDg6szLs9mLpG
	KXgHAejDnS6/qruwDUG7gcIoCIDhms+xVnZq0vSlrgS6vOU/GRbJ1sURdBcW
X-Gm-Gg: ASbGncttUWt7iQpSGTE3vAsi+ilj4CX8+qZ73GELDUuZnoLGpFJ3gf/xZbfWZixG55u
	zcaW4Jptfs6m1rdtPBhEm5AOYTVqgHvIhBAzXLhJ37qb6cc2HyZE4uRStvUzoIwh9Su8xG4FpEx
	QY3kVbs2JQYbOGcUra8ryK5z4VP2UCwmtzzOCRPpsozaXmP42RGOYYv8pUD9D0TViBqQA2dm2yZ
	1ZwtW/VG+NJOeTTouNXVbsh1y05eOqSlsrgRVtOohlh/jWkOA==
X-Google-Smtp-Source: AGHT+IGi08WpSoUt59QhwzFZFOgo53ta/N31pHJdZXnOPrBaj/898VKq+DVAuSNHKVKDJkqMPslTMA==
X-Received: by 2002:a17:902:f650:b0:216:2af7:a2a3 with SMTP id d9443c01a7336-2162af7a6a0mr235676395ad.53.1733831791630;
        Tue, 10 Dec 2024 03:56:31 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:b888:50d6:77cb:486e])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-216688a6dffsm19423875ad.113.2024.12.10.03.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:56:31 -0800 (PST)
From: Takaya Saeki <takayas@chromium.org>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	Nick Kralevich <nnk@google.com>,
	Jeffrey Vander Stoep <jeffv@google.com>,
	Junichi <uekawa@chromium.org>,
	selinux@vger.kernel.org,
	Takaya Saeki <takayas@chromium.org>
Subject: [PATCH] selinux: support wildcard match in genfscon
Date: Tue, 10 Dec 2024 20:55:51 +0900
Message-ID: <20241210115551.1225204-1-takayas@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
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
This patch is based on the RFC:
https://lore.kernel.org/selinux/CAH9xa6ct0Zf+vg6H6aN9aYzsAPjq8dYM7aF5Sw2eD31cFQ9BZA@mail.gmail.com/T/#t
 security/selinux/include/policycap.h       |  1 +
 security/selinux/include/policycap_names.h |  1 +
 security/selinux/include/security.h        |  6 +++
 security/selinux/ss/policydb.c             | 56 ++++++++++++++++++----
 security/selinux/ss/services.c             | 13 +++--
 5 files changed, 66 insertions(+), 11 deletions(-)

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
index e080827408c4..17e5c51f3cf4 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -18,6 +18,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"ioctl_skip_cloexec",
 	"userspace_initial_context",
 	"netlink_xperm",
+	"genfs_wildcard",
 };
 /* clang-format on */
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index c7f2731abd03..ccd80fb037d5 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -201,6 +201,12 @@ static inline bool selinux_policycap_netlink_xperm(void)
 		selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
 }
 
+static inline bool selinux_policycap_genfs_seclabel_wildcard(void)
+{
+	return READ_ONCE(
+		selinux_state.policycap[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]);
+}
+
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 383f3ae82a73..959e98fae3d5 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1090,29 +1090,59 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
  * binary representation file.
  */
 
-static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
+static int entry_read(char **bufp, gfp_t flags, void *fp, u32 entry_len,
+		      u32 buf_len)
 {
 	int rc;
-	char *str;
+	char *buf;
 
-	if ((len == 0) || (len == (u32)-1))
+	if ((buf_len == 0) || (buf_len == (u32)-1) || (buf_len < entry_len))
 		return -EINVAL;
 
-	str = kmalloc(len + 1, flags | __GFP_NOWARN);
-	if (!str)
+	buf = kmalloc(buf_len, flags | __GFP_NOWARN);
+	if (!buf)
 		return -ENOMEM;
 
-	rc = next_entry(str, fp, len);
+	rc = next_entry(buf, fp, entry_len);
 	if (rc) {
-		kfree(str);
+		kfree(buf);
 		return rc;
 	}
 
+	*bufp = buf;
+	return 0;
+}
+
+static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
+{
+	int rc;
+	char *str;
+
+	rc = entry_read(&str, flags, fp, len, len + 1);
+	if (rc)
+		return rc;
+
 	str[len] = '\0';
 	*strp = str;
 	return 0;
 }
 
+static int str_read_with_padding(char **strp, gfp_t flags, void *fp, u32 len,
+				 char padding)
+{
+	int rc;
+	char *str;
+
+	rc = entry_read(&str, flags, fp, len, len + 2);
+	if (rc)
+		return rc;
+
+	str[len] = padding;
+	str[len + 1] = '\0';
+	*strp = str;
+	return 0;
+}
+
 static int perm_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
@@ -2193,7 +2223,17 @@ static int genfs_read(struct policydb *p, void *fp)
 			if (!newc)
 				goto out;
 
-			rc = str_read(&newc->u.name, GFP_KERNEL, fp, len);
+			if (ebitmap_get_bit(
+				    &p->policycaps,
+				    POLICYDB_CAP_GENFS_SECLABEL_WILDCARD))
+				/* Append a wildcard '*' to make it a wildcard pattern */
+				rc = str_read_with_padding(&newc->u.name,
+							   GFP_KERNEL, fp, len,
+							   '*');
+			else
+				/* Prefix pattern */
+				rc = str_read(&newc->u.name, GFP_KERNEL, fp,
+					      len);
 			if (rc)
 				goto out;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 971c45d576ba..da4d22220fe8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -48,6 +48,7 @@
 #include <linux/audit.h>
 #include <linux/vmalloc.h>
 #include <linux/lsm_hooks.h>
+#include <linux/parser.h>
 #include <net/netlabel.h>
 
 #include "flask.h"
@@ -2861,9 +2862,15 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 
 	for (c = genfs->head; c; c = c->next) {
 		size_t len = strlen(c->u.name);
-		if ((!c->v.sclass || sclass == c->v.sclass) &&
-		    (strncmp(c->u.name, path, len) == 0))
-			break;
+		if (selinux_policycap_genfs_seclabel_wildcard()) {
+			if ((!c->v.sclass || sclass == c->v.sclass) &&
+			    (match_wildcard(c->u.name, path)))
+				break;
+		} else {
+			if ((!c->v.sclass || sclass == c->v.sclass) &&
+			    (strncmp(c->u.name, path, len)))
+				break;
+		}
 	}
 
 	if (!c)
-- 
2.47.0.338.g60cca15819-goog

