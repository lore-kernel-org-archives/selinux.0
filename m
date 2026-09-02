Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7B4A99A9
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788370174; cv=none; b=Z8tt4qyTVmqaW4R1waCdV4hMITG+n+ILUjGAs17Noiy1b27co8fnzIc39H0+wQziJtepd9rnFuPaggqzXrfqg1M5rC7lCxxrUFbQRbNCqRO2kJE+a/yS6jnwpdPwgK9PG76gSk0JG9IEobAX8lyBQ0WW93+jVTaduj/xwkCtfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788370174; c=relaxed/simple;
	bh=qF/ECFOrvPwtKwCi+51aBIBTvBNtApZpVQA/3E/MciQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHQUUuPYYMDYATXMUZXh7qbvqDiaEcv+gx71mXiV8vENUoGUAqAB7Xs60r5E09B4sezhaw6WfhbdeBHlK8cvPgA6gShNq8NR3oag62T+w6RRbmD4bRL0bzkOq390ZVwQDTGld8kf+6BfRWevpXKw7NhIqt8t5q4P4YHsZpt4Hlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZfBXT5j; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZfBXT5j"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93900ed2925so130782185a.0
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788370172; x=1788974972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dsr6JG0WrM+wjczwo/RSY7gn8CagJiZf0WgBTPMxAH4=;
        b=eZfBXT5jqgM9EaARsxh7b6E6vK6REJn2ryuRVqeJfWRaRw+j51R8W4BCusMna/pSXH
         udLSXk5IS2O7vQ53ooR26xX5pVhAeb6g2YeWt3IQmTgvQ+TSP/eDg1WDPd7ecYYvtxav
         2oJQbkh2VJgtK5WsMnoBn2PfhCBsjBzwPvlJiLZdpp7vKtnh8S727NqLXxJbryVbjh5y
         c1ic7sLP+vV5LYyya4XoNWXzijJ9qu9ikJIhctJ7rRLlUBS0vxZOH50d7S9XJbadrwRB
         kK9adZLwVmJSsRPz81fmqnjJ1Xg5JndhjDm/V85CV8t6dD+fpIqD+kNs2SGi+6h7rI13
         8hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788370172; x=1788974972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dsr6JG0WrM+wjczwo/RSY7gn8CagJiZf0WgBTPMxAH4=;
        b=dleJq13WioVukLneTX4knmC/856tpSnefbV1x6NV6Wy3Tdj4wN2BT6BBAh3ac/gd7o
         QBHU6uP+kayDYPzUq1VDi3yO1s5pPxugppNUFMqsVW5GcgguR8yBJ8SqLIl5kCCwlgH4
         7LFMjcpks8wYWUBDUsz7MNq/KHl+Qc9mBux/Ny+RPlNtq0DQcrb2qKC9Cy/FKxqXI9b3
         3mOHyawP1qsSnarxBtjRbRqeHuwgX1q40gjhgsDTMyjtE4KjXwyEJa2QSGE92fwA64y1
         MDgofAhvNMazW7a1qEnW2gwEHFPecskaie22endR5DjTg9/HQT+HeoGx+eVF6LP+gPrj
         ssZg==
X-Gm-Message-State: AFuF++lp/nvrnpBXddsS3MN+CW8lkdEJBqObhFqe1KMyRKGdGNGQ3tDG
	ysg3vabfHMf0ybtPlTKAYRaaxPXH05IdCmQSubp76osLHf16bacbIelWjX9+Mg==
X-Gm-Gg: AR+sD12eBpW6+bHWuYQRWYL+JM2tUBPV2px2Bu0y6IOISCZ1LRa7T8SAbnzmzQYPkkr
	br5BrvGMAVpgEBByKtPaikF6FkbavF5UccKbCH7GauuXZinxeD4G3B9SPYHjgW9Y7gDke3aH8nX
	fyIJfn5UHv//pHHObSyvMtwljrI0NFE6PYbEo+I7BS2vo+Nsk0qpzgbBnGFHhITe9vRmwJ8sP2l
	4pGMLHwxmG2dwjlFR0JxwRwklu+/VeYCmTKlgDXW7hVjecl1QSr46fFmfni5gJg2bm0xsn23CAv
	JHyeylPG09vQWyVk4zIFEk+Qi2OOr6lQVLohEa2e2CLSe1bHdyWRdOoKtvHmmFqUJHM46AgqUiR
	rmmxeVMZ+Yj9CVzqlqWs7khV5Lf3z7wl3y4YCcxNpp5TGI1dH+c7BUT1r1QylMiH7wQEDZexoI1
	DHQ1+1JGL0W+MuMK9ANPJhNBOg3NkJA+fz4XCSFi35Y/LSnPFyVQOco3JPetY7xen6pj78Fv30p
	vQy5tK14LlOwkjoyNuUc2lSl/WHlSO3R9Ue/7Ky7ZXw878AKAVcLbJYoKrsrqSVSYb8TsyFzrk=
X-Received: by 2002:a05:620a:2a07:b0:92b:5408:b6be with SMTP id af79cd13be357-93960ef5bd8mr695878185a.23.1788370167251;
        Wed, 02 Sep 2026 10:29:27 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee24af5sm22970526d6.12.2026.09.02.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:29:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol,checkpolicy: validate devicetree paths
Date: Wed,  2 Sep 2026 13:29:14 -0400
Message-ID: <20260902172914.4065-1-stephen.smalley.work@gmail.com>
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
 checkpolicy/policy_define.c              |  20 +++--
 libsepol/include/sepol/policydb/dtpath.h | 104 +++++++++++++++++++++++
 libsepol/src/policydb_validate.c         |   3 +-
 3 files changed, 121 insertions(+), 6 deletions(-)
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
index 00000000..6b5f3d44
--- /dev/null
+++ b/libsepol/include/sepol/policydb/dtpath.h
@@ -0,0 +1,104 @@
+#ifndef _SEPOL_POLICYDB_DTPATH_H_
+#define _SEPOL_POLICYDB_DTPATH_H_
+
+#include <stdbool.h>
+#include <ctype.h>
+#include <string.h>
+
+static bool is_valid_dt_char(char c)
+{
+	return (isalnum((unsigned char)c) || c == ',' || c == '.' || c == '_' ||
+		c == '+' || c == '-');
+}
+
+static bool is_valid_dt_start_char(char c)
+{
+	return (isalpha((unsigned char)c) || c == '_');
+}
+
+/*
+ * Validates a devicetree pathname.
+ * Returns true if valid, false otherwise.
+ */
+static bool is_valid_dt_path(const char *path)
+{
+	const char *p = path;
+
+	while (*p != '\0') {
+		const char *segment_end = p;
+
+		if (*p == '/') {
+			p++;
+			/* Check for duplicate slashes (e.g., "//") or trailing slash */
+			if (*p == '/' || *p == '\0')
+				return false;
+		}
+
+		/* Locate the end of the current path segment (next '/' or end of string or optional ':') */
+		while (*segment_end != '\0' && *segment_end != '/' &&
+		       *segment_end != ':')
+			segment_end++;
+
+		/* Handle the optional parameter/option suffix (e.g., ":115200") at the absolute end */
+		if (*segment_end == ':') {
+			/* Options are only valid on the very last segment of the path */
+			if (strchr(segment_end + 1, '/') != NULL)
+				return false;
+
+			/* Ensure there is actually an option string following the colon */
+			if (*(segment_end + 1) == '\0')
+				return false;
+		}
+
+		/* Isolate node-name vs unit-address by looking for '@' */
+		const char *at_sign = NULL;
+		for (const char *i = p; i < segment_end; i++) {
+			if (*i == '@') {
+				at_sign = i;
+				break;
+			}
+		}
+
+		/* Determine boundaries for the node-name component */
+		const char *name_end = (at_sign) ? at_sign : segment_end;
+		size_t name_len = name_end - p;
+
+		/* Devicetree Spec rule: Node-name must be 1 to 31 characters long */
+		if (name_len < 1 || name_len > 31)
+			return false;
+
+		/* Devicetree Spec rule: First character must be [a-zA-Z_] */
+		if (!is_valid_dt_start_char(p[0]))
+			return false;
+
+		/* Validate remaining characters of the node-name */
+		for (size_t i = 1; i < name_len; i++) {
+			if (!is_valid_dt_char(p[i]))
+				return false;
+		}
+
+		/* Validate the unit-address section if '@' was present */
+		if (at_sign) {
+			const char *addr_start = at_sign + 1;
+			/* Unit address cannot be empty (e.g., "node@") */
+			if (addr_start == segment_end)
+				return false;
+			/* All characters in unit address must be valid DT characters */
+			for (const char *i = addr_start; i < segment_end; i++) {
+				if (!is_valid_dt_char(*i))
+					return false;
+			}
+		}
+
+		/* Break early if we hit the trailing options section delimiter ':' */
+		if (*segment_end == ':')
+			break;
+
+		/* Advance pointer to start of next segment or exit loop */
+		p = segment_end;
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

