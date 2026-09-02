Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205F357A25
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373762; cv=none; b=IggqReZys99uJLqTUCcLJMI1Ak9aAaYgG26oF8D0w82aOFqH2HEU5Xv5+BxO2cMfAaVfCS40LppjAIzeyfTIu6sqE4GUP87jXEoX9P2eaxPvbWZPVyEKm8vouDC8wZXux/kaXkg4nUJEA15QetD6bjf2gRBCspsa9F02cazC1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373762; c=relaxed/simple;
	bh=1kWjAAMCWaCLntsSE5I57VdVMvqSxqttvsDrle+7AnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5aMUw6zubYRh7DqtppOAVgfitR15ZWx33IsmbWXtJJQ9WjWXnyUZOdAJ0IpaDG6U1TVidxE/a96ze/ZbC/NO6o8tdCUU9B/K6m8VTGoDpYkIPI6ohBAj7xqZJj0rg5wB5x3/uw50e5BJR+OFpU2dqSSlk8S9f0YRMllLNUw30o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sde6d+5u; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sde6d+5u"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9390f8a1c9eso117758385a.3
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373760; x=1788978560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=goJfuvtX+HavV+DfCisgfizj3tAZtoLjZF2CgZIIykk=;
        b=Sde6d+5uDBNN1lgLl8fUludhr2TpAodTs2hsdW/9RdIVwcffD/Ccf9VC0vvhx9UQHN
         0LsyGFDh5pNJ8eWFvOSNDEGDYX6uERTiAUi5q9+ICGzFoD+wFNQsBjHyjsQwROFaWc+y
         WNks3VroBMheUwK0CPPGhfAqDQQHwe/x32/5++OQ7O2GGDk8/KnHtop6KtRa7+8Xx0A2
         3uoc5/gMuH3weUl6A9tnXhnk7RlJSa7ixwfnvJmVJ5dBVfzS8AcelTF8v+fH/mMk2+FY
         wkn8f0qN0ksz35QeehXlKa9CIpqnemZlA3+XGWKH80LHgdBdYiGjPCafSFypv8OoHIXs
         WndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373760; x=1788978560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=goJfuvtX+HavV+DfCisgfizj3tAZtoLjZF2CgZIIykk=;
        b=E5Oq/SmI2tPcp/38lOT7o44aZTw4lGXsrkCeXOfZO7MuE7ufaLrc646g9gTNzyF9NC
         +76U9EflW36pO5TyQp4xrFxK2j9IILoAJkP+JvB5X+m88TlSH8eqHKz2r3OvYpasixGp
         NF4g8Cl06m7q8tWtwQNk8fhz9V32d1dH0p0OWG8b3Y+QhMIvLe10Z3gm6tfm88VM7i7X
         Axw2wUysGjGdCvtq9EINQY0VoeMk6L1tayPwW2eJdZrdr3R5PYmTjsO5tfzQN+rlKE4v
         P1eZr+2E3RC6lYo7xhOEt68yJLxjO3KFtnWE1AHk3KGvronlEDH1oUKEH4vPuRVPkpPA
         wnwQ==
X-Gm-Message-State: AFuF++mcwaQQDRvgUXvDpvNJg0iz/RiTcmmtlljXnZ2mPe4c0DT6yR3D
	jNBXVdaUhljeUHXNyZXvJnkC2H4b21oUTrkmX7M7Z4jlUQKLDBvrBXRN0WU+dg==
X-Gm-Gg: AYBFou1l5V75CRN6dAaH4+uUoZJlpJ45DLxu1DcA06MhTdSPYUQHz2konfG1nGmyt4e
	dAGdEn58dmcShTsO6i73baEk8J91maVmM4rhhOldvu1+jofw8EggaRE1YPfFBTkut1rzrsPDsJ2
	+coFNQXB4ohemdpYQNVJUE9ROD8DVZdE+oSEv4w3Cff4L4n30Cx1N0lpEw0QuUAiyMF0O58/X40
	b3kQbIw+AkNKtGRs0aA9tm+QemI+prTPqdAERq5myUWRD29ZPsKxWGFNY3nYKQMbRh2IoufPKnv
	jHu1vYXdL8JyUJUDKriv8o6jAZtlsd7BDOdr+fauFizQiyMs6j60aj6LJ7TIBeFRWr81vsuxyGk
	mbEFETdfctlJ6pAlMptXaekKzjKFeb/Kv9HdjXTWWQi1LAXWuB1oK1E2co9S3j4NAMjtG7JGUdd
	5xlRQntKvphPw95rkFivgnhAvenxm6rxghXVNqsdxmFsUOt95tind0qUuWU/RgJfG2ier6NwnY4
	d1ZebM8Wk1QKGinB673Dh+lmonvkIczWbNgQif+lZ39DnpwyRn7SehIBcHHK2mBnMwkBDLZyXQ=
X-Received: by 2002:a05:620a:2f7:b0:936:9525:e952 with SMTP id af79cd13be357-93961016c42mr608088385a.41.1788373759694;
        Wed, 02 Sep 2026 11:29:19 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f359ffbsm266830585a.28.2026.09.02.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:29:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3] libsepol,checkpolicy: validate devicetree paths
Date: Wed,  2 Sep 2026 14:28:04 -0400
Message-ID: <20260902182803.9789-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devicetreecon paths have their own validity rules specified by:
https://devicetree-specification.readthedocs.io/en/latest/index.html

libsepol was (correctly) preventing them from embedding control
characters but checkpolicy was not. Provide helpers for validating
devicetree paths according to the specification and use them in
checkpolicy and libsepol to reject invalid devicetree paths.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3 makes the helper functions inline to avoid creating duplicates
for source files that include the header, adds one more validity
check to the helper, and fixes a memory leak on the error path.

 checkpolicy/policy_define.c              |  21 +++--
 libsepol/include/sepol/policydb/dtpath.h | 100 +++++++++++++++++++++++
 libsepol/src/policydb_validate.c         |   3 +-
 3 files changed, 118 insertions(+), 6 deletions(-)
 create mode 100644 libsepol/include/sepol/policydb/dtpath.h

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 1984c52f..c0f546a1 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -54,6 +54,7 @@
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/hierarchy.h>
 #include <sepol/policydb/polcaps.h>
+#include <sepol/policydb/dtpath.h>
 #include "queue.h"
 #include "module_compiler.h"
 #include "policy_define.h"
@@ -5136,6 +5137,7 @@ bad:
 int define_devicetree_context(void)
 {
 	ocontext_t *newc, *c, *l, *head;
+	char *path;
 
 	if (policydbp->target_platform != SEPOL_TARGET_XEN) {
 		yyerror("devicetreecon not supported for target");
@@ -5148,17 +5150,26 @@ int define_devicetree_context(void)
 		return 0;
 	}
 
+	path = (char *)queue_remove(id_queue);
+	if (!path) {
+		yyerror("Missing devicetreepath");
+		return -1;
+	}
+
+	if (!is_valid_dt_path(path)) {
+		yyerror2("invalid devicetreecon path \"%s\"", path);
+		free(path);
+		return -1;
+	}
+
 	newc = calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
+		free(path);
 		return -1;
 	}
 
-	newc->u.name = (char *)queue_remove(id_queue);
-	if (!newc->u.name) {
-		free(newc);
-		return -1;
-	}
+	newc->u.name = path;
 
 	if (parse_security_context(&newc->context[0])) {
 		free(newc->u.name);
diff --git a/libsepol/include/sepol/policydb/dtpath.h b/libsepol/include/sepol/policydb/dtpath.h
new file mode 100644
index 00000000..a554412e
--- /dev/null
+++ b/libsepol/include/sepol/policydb/dtpath.h
@@ -0,0 +1,100 @@
+#ifndef _SEPOL_POLICYDB_DTPATH_H_
+#define _SEPOL_POLICYDB_DTPATH_H_
+
+#include <stdbool.h>
+#include <ctype.h>
+#include <string.h>
+
+/*
+ * Allowed characters in a devicetree node-name / unit-address,
+ * per the Devicetree Specification: [0-9a-zA-Z,._+-]
+ */
+static inline bool is_valid_dt_char(char c)
+{
+	return isalnum((unsigned char)c) || c == ',' || c == '.' || c == '_' ||
+	       c == '+' || c == '-';
+}
+
+/*
+ * is_valid_devicetree_path - validate a devicetree node path
+ * @path: NUL-terminated path string, e.g. "/soc/uart@10000000"
+ *
+ * Rules enforced (per the Devicetree Specification):
+ *   - path must be non-NULL and non-empty
+ *   - path must start with '/'
+ *   - "/" (root) alone is valid
+ *   - path must not end with '/' unless it is exactly "/"
+ *   - no empty segments (i.e. "//" is invalid)
+ *   - each segment is "node-name" or "node-name@unit-address"
+ *   - node-name: 1-31 characters from [0-9a-zA-Z,._+-]
+ *   - unit-address (if present): 1+ characters from [0-9a-zA-Z,._+-]
+ *   - at most one '@' per segment
+ *
+ * Returns true if the path is well-formed, false otherwise.
+ */
+static inline bool is_valid_dt_path(const char *path)
+{
+	if (path == NULL || path[0] == '\0')
+		return false;
+
+	if (path[0] != '/')
+		return false;
+
+	/* Root node alone is valid */
+	if (strcmp(path, "/") == 0)
+		return true;
+
+	/* No trailing slash allowed (except for root, handled above) */
+	size_t len = strlen(path);
+	if (path[len - 1] == '/')
+		return false;
+
+	const char *seg_start = path + 1; /* skip leading '/' */
+
+	while (*seg_start != '\0') {
+		const char *seg_end = strchr(seg_start, '/');
+		size_t seg_len = seg_end ? (size_t)(seg_end - seg_start) :
+					   strlen(seg_start);
+
+		if (seg_len == 0)
+			return false; /* empty segment, e.g. from "//" */
+
+		const char *at = memchr(seg_start, '@', seg_len);
+		size_t name_len = at ? (size_t)(at - seg_start) : seg_len;
+
+		/* node-name must be 1-31 characters */
+		if (name_len == 0 || name_len > 31)
+			return false;
+
+		/* node-name must start with a lower or uppercase character */
+		if (!isalpha((unsigned char)seg_start[0]))
+			return false;
+
+		for (size_t i = 0; i < name_len; i++) {
+			if (!is_valid_dt_char(seg_start[i]))
+				return false;
+		}
+
+		if (at) {
+			const char *addr_start = at + 1;
+			size_t addr_len = seg_len - name_len - 1;
+
+			if (addr_len == 0)
+				return false; /* '@' with nothing after it */
+
+			for (size_t i = 0; i < addr_len; i++) {
+				/* also rejects a second '@' in the same segment */
+				if (!is_valid_dt_char(addr_start[i]))
+					return false;
+			}
+		}
+
+		if (!seg_end)
+			break;
+		seg_start = seg_end + 1;
+	}
+
+	return true;
+}
+
+#endif /* _SEPOL_POLICYDB_DTPATH_H_ */
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 34182e8e..c60001c9 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -5,6 +5,7 @@
 #include <sepol/policydb/polcaps.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
+#include <sepol/policydb/dtpath.h>
 
 #include "debug.h"
 #include "private.h"
@@ -1613,7 +1614,7 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 						goto bad;
 					break;
 				case OCON_XEN_DEVICETREE:
-					if (validate_string_field(octx->u.name))
+					if (!is_valid_dt_path(octx->u.name))
 						goto bad;
 					break;
 				}
-- 
2.55.0

