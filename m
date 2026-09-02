Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E66736CDE0
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371398; cv=none; b=ppeNb3X+xBft9V0eseIFXEs+0XEROyyjCvepRxjQWgTyvQsVtpzySmYoeqL39Zo8yrVPr6vPZy5do27oejr2eFl9A5evFhsVvwLTzqrmgiKQmOLZRn0HV+pguOMekbY40oeNmp2FkqzMU6hqj4j/qh5eVEPi01xfRXFKt0hw3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371398; c=relaxed/simple;
	bh=KC1bdffKEm7Y9te216/pjpv/QGm8Hg29YLo1ddQc45A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phelB96wLDhFA8IaTeXueTq79K8uezcN6FoFVc2S0HDnxWHUpgnJVjsdUeQjdL5OM2v3SQgwTjNR6UVM/0gO5gsr3Vcg6t19NJ75d9fgdJCTHzjX9PH8A9kgMpLTeqtJbUE8sbtQbXZSTcdLGV3HKS04sWvdIqbCDT2PN3tQsDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxTx8etj; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxTx8etj"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90e828b309eso16245466d6.1
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788371395; x=1788976195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9mqu+t3WBqe+1c33ZE/jdC2uRUd7SQO+IjHGC0K+PpU=;
        b=IxTx8etjliW/N37zbQrZbSC434s0jMp7oEN+vbNWmc55DwEL88RifnF2u5nlJKcLXH
         pHtNX+izJTD72aFY5l6zLAPH4PDiazNhE8JyZ8Ol7L00Gr3TYtVnjPsTOblrvXOwADu7
         7yNPqzUS2YmQ/lA2dBa04s3kTcqwwbLYGJYOOBAvvDT4BxDWDxodn0vonFjZ4uQKu3Fx
         UO2J9SMnjBn279Rq6g6DAe8iyl14BQ6unAcN7UUKwv5ibg/W5IIXxoTmjrwSUcRSE8yh
         XoRunxHs3Y0Ps1UFD/yviwp7vQzC+RuhD/WiZXkO/LDhOrCzzVzZQhi2Uum6j6Qdj/Oj
         6B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371395; x=1788976195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9mqu+t3WBqe+1c33ZE/jdC2uRUd7SQO+IjHGC0K+PpU=;
        b=C981c2MnYbGIkXces+tFpY4Chis4Itz+x/SnbueCVstFG0dJCIz6rZ4SsazT2x2LPP
         lI1QPAF5SkFNsaUSTayh+DI1OtWLJyy0wFYmwWUZfgAL4cKMOwKZkNJRNstKJSc6Ii0N
         PDCkCxQdC5Z8U/PUB64JSesN0jHqd8mtpR6TCUbT0fPfA4F+NS2vZT8Agrx9h2PkDX4K
         Y8PjwylqNWqvFjMmlS4r4NI+CGn5tzmToRk3uoZwvObiFLOu1y3xslPEluHXth0eNPNp
         I4BuzLqtYO/UcZKRgUtMTcWlYC9ut7773yOsxaYk/ybpruKfadFMJKjcOI1gv0F3+sVi
         Oi1Q==
X-Gm-Message-State: AFuF++kQpiVTsfu2lfPomaeSe6W8L7Fnc9HXDXazM0IZKquynwBFmcG9
	5k+JysOAZ0/z4wtVqutjvwqfAYId7vyo4ItUoRaIaSi3EpnHXT7m0i6wnuBn8A==
X-Gm-Gg: AYBFou1Ewn0o4YYrQEH6XWP7H2M3CSHFOmt6dqS3cZKnlpkUeNA5Gyxx1EflvZiXzus
	W7crZM8qoCCjLnnjZhPfnv9otnDfzl5jc6fJpI/MgmvEq90/VTnNQVDIh650HxCAr39xlYNvjmq
	0Yv8o0oUvc/w4oQsht9ZR1En4dS1ZI+NKMnPxG9DD0bRUv0T24G0iRIf3NV7PI+bkgs44LAe9SZ
	jedgIPpg7WplUvhIz7JR5oiUYZY9HGEin5eVB8EcymbZDWyyQr6yaZ2o1wwZAHLDJYj8uqmvrPo
	pMrD+8FVSJMDo4c4FhfC42neZCCbQ43ufNs0G8HP1HojxgDh9+JqzDUxlp7yot92Z05IG0Q885e
	CfmU/oULu6qIj6jkBcNB8YAxqOOeNfnyUDromsQWiG+h97d+yBlceZjg26T1ZJIsCYAU8pbfXn8
	BJmrHom3hjHSCeNqxror5iWvI8rgr+8KRJsMDqWEQKYlIr8XUBXMy0LYc/rZBWnsWWpxczluj37
	egOwfDA9I69G0CoB7CSj5fIXQ9l2V4rbyFdIQ5gcnM+72ZNID9f75WgyvHP+Jc4
X-Received: by 2002:a05:6214:434a:b0:8cc:d29:9f73 with SMTP id 6a1803df08f44-90ebab8fb94mr103781106d6.21.1788371395004;
        Wed, 02 Sep 2026 10:49:55 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee06d30sm23966626d6.6.2026.09.02.10.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:49:54 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libsepol,checkpolicy: validate devicetree paths
Date: Wed,  2 Sep 2026 13:49:11 -0400
Message-ID: <20260902174910.7591-2-stephen.smalley.work@gmail.com>
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
v2 fixes an error in the validation logic.

 checkpolicy/policy_define.c              | 20 +++--
 libsepol/include/sepol/policydb/dtpath.h | 96 ++++++++++++++++++++++++
 libsepol/src/policydb_validate.c         |  3 +-
 3 files changed, 113 insertions(+), 6 deletions(-)
 create mode 100644 libsepol/include/sepol/policydb/dtpath.h

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 1984c52f..b40acf64 100644
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
@@ -5148,17 +5150,25 @@ int define_devicetree_context(void)
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
index 00000000..862b345c
--- /dev/null
+++ b/libsepol/include/sepol/policydb/dtpath.h
@@ -0,0 +1,96 @@
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
+static bool is_valid_dt_char(char c)
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
+static bool is_valid_dt_path(const char *path)
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

