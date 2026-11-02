Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627254;
	b=OeqEIjGRSlnTR6rWcasgAO6aJmYHNCT6O4KPD6pEEspaf4PtSieGvxHfMbTxKsmQRT41
	 0RzITrTCTLNBDfPe1UWrI3J0PRhQZFWCIlJUVHYZnnkSKgDrw4Brqm1xStZp5rLp4Hx4P
	 qJiPrY4UVkg+seAaXMlyp66vgzhSnVRFHvk1X59UL6ibNRD6ifUT5LSsV2S+V+3GRU9YK
	 VIgAyWDEU8rB6PcIpGLuSNZLELyOhnQqysq0Bo6jJlnTCbkK9W1W++ZHCZVtzeZ4iPv1M
	 8JZyQWS5EzrolH6uY3MCUM0HsJf52rVAm3P0oZJjtMVwd/X5noRQG6aEW4hyushb88Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wkNJ8pZCxaJY6eWCAMUF/mv76gDWb9gjTZiNgvsjgg8=;
	b=uOIJSDCa6gXfcczwqPG0x5j2mmtuvAPNKKIEPPlWFfj9Ek6RiSN+G9DQK8asTHYjy9pJ
	 qFPVCZCgLod3DG9qyigu+dPR6yXdY7WamKSQXOndA+IyJpAHcJznQA2tgi85sIayT3ThF
	 edNGxsgAQkd2jwzaVJG+OuuRd5nLrDfsrcH39usCwrBG7S1nFOzJKFWhqqB30YEFEZAiC
	 DmdVOdw5dchR4Qve0m9Md3gqfLl1PPW1LPDUOxSReuBGVkmO/i51DMZQEClwRjFSAupf/
	 MwUP51Ekwskavjedn8lagrP1N51Ydn5zjaIvekznQa2zZGMoZ2JO+5nFaV6X8B/UqJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qIt7GXjC;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE1606A324
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 13:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BDE1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qIt7GXjC
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-537548b811aso24918961cf.3
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 05:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793627252; x=1794232052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wkNJ8pZCxaJY6eWCAMUF/mv76gDWb9gjTZiNgvsjgg8=;
        b=qIt7GXjCQViy2uxkGIspFww0G3nKOFeAjwzgAjBnW+oA3AelWJnv1k+Oz7NIO3ZO4g
         6x34sO/NdwcLwev0IX5PL//2k4dPSdyVYHQnRlP4xw2Jh6ifKIu7O0cdJ5C1GPI3joxV
         iiCORKT8oToGmOlBy1YI8P4kMLKrSgGBWBsiLnqblz9WWJEWHZ6cHoVkP3afvVytenFN
         r7/FfMxPXEZ27BzuQvDW0v4jMYMMB7FS25vst7+XQa2dc4FIkSxlYQyi8I673I4RMbht
         bFdLoFoj2899PZBEpaS73yF0+gMQpMqlUiebsF/Zy+pXxzbPJgxaDeu9PwsDZnXTGXNE
         hWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627252; x=1794232052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wkNJ8pZCxaJY6eWCAMUF/mv76gDWb9gjTZiNgvsjgg8=;
        b=F3A+by9AZDrzksxRFOX43iBghDcHvD1MNhTq9t42XvE2JrFFjcR4mbMbK9GWctJhGa
         HPeJtkYElmG5HJHoNB/Mz/1OPIeGarHbLM6y5J3TpP20cHKeWqDCj+pwqquEJKlM1jYn
         SOLJezXwkXjQTfUS/z33tiIBHiLrl32mWrqp0P1ET5RI3dBijwhG3vFE5QOro/CuLbyZ
         9t7Wy/OLFZJXNpXx1MiUjGkHIX40FyYbu+ztH2IFmzh+7OAHEABHNZRSIKdk2ez3peyf
         +UH/mXDjGaRDrV9XoeDH4mq8p2Pm3ZasrMNOqbtF5QiDS7qsKswU0IdU3VPgU6jGardG
         v0uA==
X-Gm-Message-State: AFq9FYLbCr1ZFTW4RzPeQJxw8ZooSsmRuMHItk4XY1OQxW75QLVJcP2c
	Fs8eL2Lxd4IM2UmdcZ2bZv5pXw7TcIw4qWo8kTDoBedJH//nu9jPhfbgV6R+pzBZ
X-Gm-Gg: AYBFou0PCL2L+S11jbpAd0ksbxsaKWdUQuZd0G+cHA4xiD0IrgoaZWiFLkBWcIQ75WW
	8Iswpy1K5LYPaS/4UvLzXeHbYRa9tqLNxqne8zP1u0F9cneABRswp96DGKboTt7AhwWCoqD8zXU
	EBUp+u00WUYgH+tJqCnbFqFsCFUdXP26UATg0rgcgzEKa/hHxQYQN9AnGQn4eQRMDWRMw2R73R9
	fF6fe3SCOeaf5z0e/IAPAWwwOoyLYAOPMJfA7d2L/RG5aTVZqo0Hfw9XbnvSQsfv4SD57+kg0m+
	EBmwum77PVLn9SbVW+6JWb4Wn5mzXIO19ySDtTFyyq0SvrIvbGhxEJ1QtrYtk9O9bl8rSCBvBWr
	rpmas+JVCfZt2EGxDaIhWj3uiJl3WPyjknmQpmqEOz3yDgKqfoWXrum902j8eN+Xl2OvyodhPdW
	j7e3IWLcuMgUrrBcB6TzGmDdZQtHz+W7eMUgKvHa+JIeBYwS11llVb2xQid2cpfK5RV3i2PRYq0
	42bm4byaNJ9oB5BmF+2G95NU5Ms7io7LdLLTmB/NdFPtSiV+CqJZxnzoM0/HL6qdtfvvQtZN/DL
	I2pIcy1cfVOefyVd+p3PbziAQATdmKE8UmMOKVnJbE9jQc9SMtVMqOnapmZIzgvzWPVaFSh4RT3
	OS6Tp4biMEi6s7lNdlhUk0uYfHy+IGyVevOK0XcVSmhQdILMQZpJSqJYUcAaM+TMNHoiCI/sQ/z
	0iC9w+t8gg43iwCoC8qeOziWym9MNu03CLNzu51LWAgcVgBV89dyo=
X-Received: by 2002:a05:620a:26aa:b0:93f:3bb5:545c with SMTP id af79cd13be357-944216b6c87mr1435042485a.18.1793627251772;
        Mon, 02 Nov 2026 05:47:31 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94424e79d0bsm837009285a.0.2026.11.02.05.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:47:31 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Eugenij Safonov <ja.safonau@protonmail.com>
Subject: [PATCH v3 1/2] libsemanage: add path substitution helpers
Date: Mon,  2 Nov 2026 08:47:16 -0500
Message-ID: <20261102134718.1825-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eugenij Safonov <ja.safonau@protonmail.com>

Add an internal module for handling path substitution rules from
file_contexts.subs(5), mirroring the selabel_file backend of
libselinux:

- semanage_path_subs_load() parses a substitution file ("alias
  original" per line, '#' comments); a missing file is not an error,
  and a '*' in the alias is a single-component wildcard that must
  span a whole path component
- semanage_path_subs_apply() rewrites a path according to the last
  matching rule in the file, matching whole path components, with
  '*' matching a single component
- semanage_path_subs_canonicalize() applies the local rules first and
  passes the result through the distribution rules

No functional change yet; a follow-up commit uses these helpers in
genhomedircon.

The module is covered by CUnit tests (libsemanage/tests/test_path_subs.c).

Signed-off-by: Eugenij Safonov <ja.safonau@protonmail.com>
---
 libsemanage/src/path_subs.c           | 253 +++++++++++++++++
 libsemanage/src/path_subs.h           |  71 +++++
 libsemanage/tests/libsemanage-tests.c |   2 +
 libsemanage/tests/test_path_subs.c    | 373 ++++++++++++++++++++++++++
 libsemanage/tests/test_path_subs.h    |  30 +++
 5 files changed, 729 insertions(+)
 create mode 100644 libsemanage/src/path_subs.c
 create mode 100644 libsemanage/src/path_subs.h
 create mode 100644 libsemanage/tests/test_path_subs.c
 create mode 100644 libsemanage/tests/test_path_subs.h

diff --git a/libsemanage/src/path_subs.c b/libsemanage/src/path_subs.c
new file mode 100644
index 00000000..395f5fc3
--- /dev/null
+++ b/libsemanage/src/path_subs.c
@@ -0,0 +1,253 @@
+/* Authors: Eugenij Safonov <ja.safonau@protonmail.com>
+ *
+ * Copyright (C) 2026
+ *
+ *  This library is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU Lesser General Public License as
+ *  published by the Free Software Foundation; either version 2.1 of the
+ *  License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ *  02110-1301  USA
+ */
+
+#include "path_subs.h"
+
+#include "debug.h"
+
+#include <ctype.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+/* The rules are kept in reverse file order so that a plain scan
+ * yields the last matching rule in the file. */
+
+void semanage_path_subs_free(semanage_path_subs_t **rules)
+{
+	semanage_path_subs_t *next;
+
+	while (*rules) {
+		next = (*rules)->next;
+		free((*rules)->alias);
+		free((*rules)->original);
+		free(*rules);
+		*rules = next;
+	}
+}
+
+int semanage_path_subs_load_file(semanage_handle_t *sh, FILE *fp,
+				 const char *path, semanage_path_subs_t **rules)
+{
+	char *line = NULL, *alias, *orig, *ptr;
+	size_t buff_len = 0;
+	ssize_t len;
+	semanage_path_subs_t *rule;
+
+	*rules = NULL;
+
+	while ((len = getline(&line, &buff_len, fp)) > 0) {
+		size_t alias_len, plen;
+		bool has_wild;
+
+		alias = line;
+		while (*alias && isspace((unsigned char)*alias))
+			alias++;
+		if (*alias == '#')
+			continue;
+		ptr = alias;
+		while (*ptr && !isspace((unsigned char)*ptr))
+			ptr++;
+		if (*ptr)
+			*ptr++ = '\0';
+		if (!*alias)
+			continue;
+
+		orig = ptr;
+		while (*orig && isspace((unsigned char)*orig))
+			orig++;
+		ptr = orig;
+		while (*ptr && !isspace((unsigned char)*ptr))
+			ptr++;
+		*ptr = '\0';
+		if (!*orig)
+			continue;
+
+		/* A '*' in the alias is a single-component wildcard and
+		 * must span a whole path component; plen is the length
+		 * of the literal prefix before the first '*'. */
+		alias_len = strlen(alias);
+		plen = alias_len;
+		has_wild = false;
+		for (size_t j = 0; j < alias_len; j++) {
+			if (alias[j] != '*')
+				continue;
+			if ((j > 0 && alias[j - 1] != '/') ||
+			    (alias[j + 1] != '/' && alias[j + 1] != '\0')) {
+				ERR(sh,
+				    "%s: '*' in substitution source '%s' is not a whole path component",
+				    path, alias);
+				goto err;
+			}
+			if (!has_wild)
+				plen = j;
+			has_wild = true;
+		}
+
+		rule = calloc(1, sizeof(*rule));
+		if (!rule)
+			goto err;
+		rule->alias = strdup(alias);
+		rule->original = strdup(orig);
+		if (!rule->alias || !rule->original) {
+			free(rule->alias);
+			free(rule->original);
+			free(rule);
+			goto err;
+		}
+		rule->alias_len = alias_len;
+		rule->plen = plen;
+		rule->has_wild = has_wild;
+		rule->next = *rules;
+		*rules = rule;
+	}
+
+	if (ferror(fp)) {
+		ERR(sh, "%s: error while reading substitution rules", path);
+		goto err;
+	}
+
+	free(line);
+
+	return 0;
+
+err:
+	free(line);
+	semanage_path_subs_free(rules);
+	return -1;
+}
+
+int semanage_path_subs_load(semanage_handle_t *sh, const char *path,
+			    semanage_path_subs_t **rules)
+{
+	FILE *fp;
+	int rc;
+
+	*rules = NULL;
+
+	fp = fopen(path, "re");
+	if (!fp)
+		return errno == ENOENT ? 0 : -1;
+
+	rc = semanage_path_subs_load_file(sh, fp, path, rules);
+
+	fclose(fp);
+
+	return rc;
+}
+
+/* Match "path" against the wildcard part of "rule"; the literal
+ * prefix before the first '*' has already been checked by the caller.
+ * Sets *matched to the length of the matched source prefix. */
+static bool match_wild(const semanage_path_subs_t *rule, const char *path,
+		       size_t *matched)
+{
+	const char *pat = rule->alias + rule->plen;
+	const char *in = path + rule->plen;
+	bool trailing_wild = false;
+
+	while (*pat) {
+		if (pat[0] == '*' && (pat == rule->alias || pat[-1] == '/') &&
+		    (pat[1] == '/' || pat[1] == '\0')) {
+			/* Consume one non-empty component of the input. */
+			if (*in == '/' || *in == '\0')
+				return false;
+			while (*in && *in != '/')
+				in++;
+			trailing_wild = (pat[1] == '\0');
+			pat++;
+		} else if (*pat == *in) {
+			trailing_wild = false;
+			pat++;
+			in++;
+		} else
+			return false;
+	}
+
+	if (trailing_wild) {
+		if (*in != '/')
+			return false;
+	} else if (*in != '/' && *in != '\0')
+		return false;
+
+	*matched = (size_t)(in - path);
+	return true;
+}
+
+int semanage_path_subs_apply(const semanage_path_subs_t *rules,
+			     const char *path, char **result)
+{
+	size_t skip;
+	char *out;
+
+	*result = NULL;
+
+	for (; rules; rules = rules->next) {
+		if (strncmp(path, rules->alias, rules->plen) != 0)
+			continue;
+
+		if (!rules->has_wild) {
+			if (path[rules->alias_len] != '/' &&
+			    path[rules->alias_len] != '\0')
+				continue;
+			skip = rules->alias_len;
+		} else if (!match_wild(rules, path, &skip))
+			continue;
+
+		if (path[skip] == '/' && strcmp(rules->original, "/") == 0)
+			/* avoid a double slash when the original is "/" */
+			skip++;
+		if (asprintf(&out, "%s%s", rules->original, path + skip) < 0)
+			return -1;
+
+		*result = out;
+		return 0;
+	}
+
+	return 0;
+}
+
+int semanage_path_subs_canonicalize(const semanage_path_subs_t *local,
+				    const semanage_path_subs_t *dist,
+				    const char *path, char **result)
+{
+	char *local_result;
+	int rc;
+
+	*result = NULL;
+
+	rc = semanage_path_subs_apply(local, path, &local_result);
+	if (rc < 0)
+		return -1;
+
+	if (!local_result)
+		return semanage_path_subs_apply(dist, path, result);
+
+	rc = semanage_path_subs_apply(dist, local_result, result);
+	if (rc < 0 || *result) {
+		free(local_result);
+		return rc;
+	}
+
+	/* no distribution rule applies to the local result */
+	*result = local_result;
+	return 0;
+}
diff --git a/libsemanage/src/path_subs.h b/libsemanage/src/path_subs.h
new file mode 100644
index 00000000..d64edde7
--- /dev/null
+++ b/libsemanage/src/path_subs.h
@@ -0,0 +1,71 @@
+/* Authors: Eugenij Safonov <ja.safonau@protonmail.com>
+ *
+ * Copyright (C) 2026
+ *
+ *  This library is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU Lesser General Public License as
+ *  published by the Free Software Foundation; either version 2.1 of the
+ *  License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ *  02110-1301  USA
+ */
+
+#ifndef SEMANAGE_PATH_SUBS_H
+#define SEMANAGE_PATH_SUBS_H
+
+#include <semanage/handle.h>
+
+#include <stdbool.h>
+#include <stdio.h>
+
+/* Path substitution rules from file_contexts.subs(5): paths under
+ * "alias" are looked up by libselinux as paths under "original". */
+typedef struct semanage_path_subs {
+	char *alias;
+	size_t alias_len; /* length of alias */
+	size_t plen; /* prefix up to first wildcard, == alias_len if none */
+	bool has_wild; /* alias contains one or more '*' whole-component wildcards */
+	char *original;
+	struct semanage_path_subs *next;
+} semanage_path_subs_t;
+
+void semanage_path_subs_free(semanage_path_subs_t **rules);
+
+/* Load path substitution rules from a file_contexts.subs(5)-format
+ * file ("alias original" per line, '#' comments).  A missing file is
+ * not an error and yields an empty list.  A '*' in the alias is a
+ * single-component wildcard and must span a whole path component.
+ * Returns 0 on success, -1 on error. */
+int semanage_path_subs_load(semanage_handle_t *sh, const char *path,
+			    semanage_path_subs_t **rules);
+
+/* Same, from an already opened stream.  The stream is left open. */
+int semanage_path_subs_load_file(semanage_handle_t *sh, FILE *fp,
+				 const char *path,
+				 semanage_path_subs_t **rules);
+
+/* Rewrite "path" according to the rules, matching whole path
+ * components, with '*' matching a single component and the last
+ * matching rule in the file winning.  On success returns 0 and sets
+ * *result to a malloc'd rewritten path, or to NULL when no rule
+ * matches.  Returns -1 on error. */
+int semanage_path_subs_apply(const semanage_path_subs_t *rules,
+			     const char *path, char **result);
+
+/* Canonicalize "path" by applying the local rules first and passing
+ * the result through the distribution rules.  On success returns 0
+ * and sets *result to a malloc'd canonical path, or to NULL when no
+ * rule matches.  Returns -1 on error. */
+int semanage_path_subs_canonicalize(const semanage_path_subs_t *local,
+				    const semanage_path_subs_t *dist,
+				    const char *path, char **result);
+
+#endif
diff --git a/libsemanage/tests/libsemanage-tests.c b/libsemanage/tests/libsemanage-tests.c
index f02efa51..1d2a90fe 100644
--- a/libsemanage/tests/libsemanage-tests.c
+++ b/libsemanage/tests/libsemanage-tests.c
@@ -30,6 +30,7 @@
 #include "test_port.h"
 #include "test_user.h"
 #include "test_other.h"
+#include "test_path_subs.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -82,6 +83,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(port);
 	DECLARE_SUITE(user);
 	DECLARE_SUITE(other);
+	DECLARE_SUITE(path_subs);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsemanage/tests/test_path_subs.c b/libsemanage/tests/test_path_subs.c
new file mode 100644
index 00000000..dc3314c7
--- /dev/null
+++ b/libsemanage/tests/test_path_subs.c
@@ -0,0 +1,373 @@
+/* Authors: Eugenij Safonov <ja.safonau@protonmail.com>
+ *
+ * Copyright (C) 2026
+ *
+ *  This library is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU Lesser General Public License as
+ *  published by the Free Software Foundation; either version 2.1 of the
+ *  License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ *  02110-1301  USA
+ */
+
+/*  The purpose of this file is to provide unit tests of the functions in:
+ *
+ *  libsemanage/src/path_subs.c
+ *
+ */
+
+#include "path_subs.h"
+
+#include "utilities.h"
+#include "test_path_subs.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+/* path_subs.h */
+void test_path_subs_load(void);
+void test_path_subs_load_file(void);
+void test_path_subs_apply(void);
+void test_path_subs_canonicalize(void);
+
+static const char *const subs_file = "./test-path-subs.subs";
+
+/* helper: write a subs file and load it (fails the test on error) */
+static semanage_path_subs_t *load_rules(const char *content)
+{
+	FILE *fp = fopen(subs_file, "w");
+	semanage_path_subs_t *rules = NULL;
+
+	if (!fp)
+		return NULL;
+	fputs(content, fp);
+	fclose(fp);
+
+	if (semanage_path_subs_load(sh, subs_file, &rules) < 0)
+		return NULL;
+
+	return rules;
+}
+
+static void free_rules(semanage_path_subs_t **rules)
+{
+	semanage_path_subs_free(rules);
+	unlink(subs_file);
+}
+
+/* helper: assert that applying "rules" to "path" yields "expected" */
+static void assert_apply(const semanage_path_subs_t *rules, const char *path,
+			 const char *expected)
+{
+	char *result = NULL;
+	int rc = semanage_path_subs_apply(rules, path, &result);
+
+	CU_ASSERT_EQUAL(rc, 0);
+	if (expected) {
+		CU_ASSERT_PTR_NOT_NULL_FATAL(result);
+		CU_ASSERT_STRING_EQUAL(result, expected);
+	} else {
+		CU_ASSERT_PTR_NULL(result);
+	}
+
+	free(result);
+}
+
+/* helper: assert that canonicalizing through local+dist rules yields
+ * "expected" */
+static void assert_canonicalize(const semanage_path_subs_t *local,
+				const semanage_path_subs_t *dist,
+				const char *path, const char *expected)
+{
+	char *result = NULL;
+	int rc = semanage_path_subs_canonicalize(local, dist, path, &result);
+
+	CU_ASSERT_EQUAL(rc, 0);
+	if (expected) {
+		CU_ASSERT_PTR_NOT_NULL_FATAL(result);
+		CU_ASSERT_STRING_EQUAL(result, expected);
+	} else {
+		CU_ASSERT_PTR_NULL(result);
+	}
+
+	free(result);
+}
+
+int path_subs_test_init(void)
+{
+	return 0;
+}
+
+int path_subs_test_cleanup(void)
+{
+	return 0;
+}
+
+int path_subs_add_tests(CU_pSuite suite)
+{
+	CU_add_test(suite, "semanage_path_subs_load", test_path_subs_load);
+	CU_add_test(suite, "semanage_path_subs_load_file",
+		    test_path_subs_load_file);
+	CU_add_test(suite, "semanage_path_subs_apply", test_path_subs_apply);
+	CU_add_test(suite, "semanage_path_subs_canonicalize",
+		    test_path_subs_canonicalize);
+
+	return 0;
+}
+
+/* Function semanage_path_subs_load */
+void test_path_subs_load(void)
+{
+	semanage_path_subs_t *rules = NULL;
+	FILE *fp;
+
+	setup_handle(SH_HANDLE);
+
+	/* missing file is not an error */
+	unlink(subs_file);
+	CU_ASSERT(semanage_path_subs_load(sh, subs_file, &rules) == 0);
+	CU_ASSERT_PTR_NULL(rules);
+
+	/* empty file yields no rules and no error */
+	fp = fopen(subs_file, "w");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(fp);
+	fclose(fp);
+	CU_ASSERT(semanage_path_subs_load(sh, subs_file, &rules) == 0);
+	CU_ASSERT_PTR_NULL(rules);
+	unlink(subs_file);
+
+	/* file with only comments and blank lines */
+	rules = load_rules("# comment\n\n   \n");
+	CU_ASSERT_PTR_NULL(rules);
+
+	/* comments and blank lines are ignored, arbitrary whitespace
+	 * between alias and original is accepted */
+	rules = load_rules("# comment\n\n   \n\t/foo\t /bar\n# another\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	CU_ASSERT_PTR_NULL(rules->next);
+	CU_ASSERT_STRING_EQUAL(rules->alias, "/foo");
+	CU_ASSERT_STRING_EQUAL(rules->original, "/bar");
+	CU_ASSERT_EQUAL(rules->alias_len, strlen("/foo"));
+	CU_ASSERT_EQUAL(rules->plen, strlen("/foo"));
+	CU_ASSERT_FALSE(rules->has_wild);
+	free_rules(&rules);
+
+	/* rules are kept in reverse file order so the last matching
+	 * rule in the file wins */
+	rules = load_rules("/a /b\n/c /d\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	CU_ASSERT_STRING_EQUAL(rules->alias, "/c");
+	CU_ASSERT_STRING_EQUAL(rules->original, "/d");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules->next);
+	CU_ASSERT_STRING_EQUAL(rules->next->alias, "/a");
+	CU_ASSERT_STRING_EQUAL(rules->next->original, "/b");
+	CU_ASSERT_PTR_NULL(rules->next->next);
+	free_rules(&rules);
+
+	/* whole-component wildcards are loaded */
+	rules = load_rules("/var/lib/extensions/* /\n/foo /bar\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	CU_ASSERT_STRING_EQUAL(rules->alias, "/foo");
+	CU_ASSERT_STRING_EQUAL(rules->original, "/bar");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules->next);
+	CU_ASSERT_STRING_EQUAL(rules->next->alias, "/var/lib/extensions/*");
+	CU_ASSERT_STRING_EQUAL(rules->next->original, "/");
+	CU_ASSERT_EQUAL(rules->next->plen, strlen("/var/lib/extensions/*") - 1);
+	CU_ASSERT_TRUE(rules->next->has_wild);
+	CU_ASSERT_PTR_NULL(rules->next->next);
+	free_rules(&rules);
+
+	/* a '*' that is not a whole path component is a load error */
+	{
+		FILE *fp2;
+
+		unlink(subs_file);
+		fp2 = fopen(subs_file, "w");
+		CU_ASSERT_PTR_NOT_NULL_FATAL(fp2);
+		fputs("/w*x/homes /home\n", fp2);
+		fclose(fp2);
+		rules = (void *)1;
+		CU_ASSERT(semanage_path_subs_load(sh, subs_file, &rules) < 0);
+		CU_ASSERT_PTR_NULL(rules);
+		unlink(subs_file);
+	}
+
+	/* lines without an original are skipped */
+	rules = load_rules("/foo\n/bar /baz\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	CU_ASSERT_PTR_NULL(rules->next);
+	CU_ASSERT_STRING_EQUAL(rules->alias, "/bar");
+	CU_ASSERT_STRING_EQUAL(rules->original, "/baz");
+	free_rules(&rules);
+
+	unlink(subs_file);
+	cleanup_handle(SH_HANDLE);
+}
+
+/* Function semanage_path_subs_load_file */
+void test_path_subs_load_file(void)
+{
+	semanage_path_subs_t *rules = NULL;
+	FILE *fp;
+
+	setup_handle(SH_HANDLE);
+
+	/* load from an already opened stream */
+	{
+		static char empty[] = "# comment\n\n";
+
+		fp = fmemopen(empty, sizeof(empty) - 1, "r");
+		CU_ASSERT_PTR_NOT_NULL_FATAL(fp);
+		CU_ASSERT(semanage_path_subs_load_file(sh, fp, "<memory>",
+						       &rules) == 0);
+		CU_ASSERT_PTR_NULL(rules);
+		fclose(fp);
+	}
+
+	{
+		static char content[] = "/var/home /home\n";
+
+		fp = fmemopen(content, sizeof(content) - 1, "r");
+		CU_ASSERT_PTR_NOT_NULL_FATAL(fp);
+		CU_ASSERT(semanage_path_subs_load_file(sh, fp, "<memory>",
+						       &rules) == 0);
+		CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+		CU_ASSERT_STRING_EQUAL(rules->alias, "/var/home");
+		CU_ASSERT_STRING_EQUAL(rules->original, "/home");
+		semanage_path_subs_free(&rules);
+		fclose(fp);
+	}
+
+	cleanup_handle(SH_HANDLE);
+}
+
+/* Function semanage_path_subs_apply */
+void test_path_subs_apply(void)
+{
+	semanage_path_subs_t *rules;
+
+	setup_handle(SH_HANDLE);
+
+	rules = load_rules("/var/home /home\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+
+	/* exact alias */
+	assert_apply(rules, "/var/home", "/home");
+	/* subdirectory */
+	assert_apply(rules, "/var/home/user", "/home/user");
+	/* whole path component only: /var/homex is not under /var/home */
+	assert_apply(rules, "/var/homex", NULL);
+	assert_apply(rules, "/var/homex/user", NULL);
+	/* unrelated path */
+	assert_apply(rules, "/srv/home", NULL);
+
+	free_rules(&rules);
+
+	/* empty rule list */
+	rules = NULL;
+	assert_apply(rules, "/var/home", NULL);
+
+	/* the last matching rule in the file wins */
+	rules = load_rules("/a /b\n/a /c\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	assert_apply(rules, "/a/one", "/c/one");
+	free_rules(&rules);
+
+	/* original "/" must not produce a double slash */
+	rules = load_rules("/var /\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	assert_apply(rules, "/var/home", "/home");
+	free_rules(&rules);
+
+	/* a '*' matches exactly one whole path component */
+	rules = load_rules("/*/homes /home\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	assert_apply(rules, "/w/homes", "/home");
+	assert_apply(rules, "/xyz/homes", "/home");
+	assert_apply(rules, "/w/x/homes", NULL); /* two components */
+	assert_apply(rules, "/homes", NULL); /* missing component */
+	assert_apply(rules, "/w/homesx", NULL); /* partial component */
+	free_rules(&rules);
+
+	/* a trailing '*' requires a further '/' after the matched
+	 * component, so the entry remaps the contents of each named
+	 * directory but not the directory itself */
+	rules = load_rules("/var/lib/extensions/* /\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	assert_apply(rules, "/var/lib/extensions/foo/usr", "/usr");
+	assert_apply(rules, "/var/lib/extensions/foo/etc/foo.conf",
+		     "/etc/foo.conf");
+	assert_apply(rules, "/var/lib/extensions/foo", NULL);
+	assert_apply(rules, "/var/lib/extensions", NULL);
+	free_rules(&rules);
+
+	/* multiple '*' components */
+	rules = load_rules("/sys/*/*/conf /etc/conf\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	assert_apply(rules, "/sys/a/b/conf", "/etc/conf");
+	assert_apply(rules, "/sys/a/conf", NULL);
+	free_rules(&rules);
+
+	cleanup_handle(SH_HANDLE);
+}
+
+/* Function semanage_path_subs_canonicalize */
+void test_path_subs_canonicalize(void)
+{
+	semanage_path_subs_t *local = NULL, *dist = NULL;
+
+	setup_handle(SH_HANDLE);
+
+	/* no rules at all */
+	assert_canonicalize(NULL, NULL, "/var/home/user", NULL);
+
+	/* distribution rule only */
+	dist = load_rules("/var/home /home\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(dist);
+	assert_canonicalize(NULL, dist, "/var/home/user", "/home/user");
+	assert_canonicalize(NULL, dist, "/srv/user", NULL);
+
+	/* local rule only */
+	local = load_rules("/srv/homes /var/home\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(local);
+	assert_canonicalize(local, NULL, "/srv/homes/user", "/var/home/user");
+
+	/* local rule result is passed through the distribution rules */
+	assert_canonicalize(local, dist, "/srv/homes/user", "/home/user");
+
+	/* local match with no distribution match keeps the local result */
+	free_rules(&dist);
+	dist = load_rules("/other /elsewhere\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(dist);
+	assert_canonicalize(local, dist, "/srv/homes/user", "/var/home/user");
+
+	/* local rule shadows the distribution rule for matching paths */
+	free_rules(&local);
+	local = load_rules("/var/home /export/home\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(local);
+	assert_canonicalize(local, dist, "/var/home/user", "/export/home/user");
+
+	/* wildcard local rule chained into a distribution rule */
+	free_rules(&local);
+	free_rules(&dist);
+	local = load_rules("/srv/* /var/home\n");
+	dist = load_rules("/var/home /home\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(local);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(dist);
+	assert_canonicalize(local, dist, "/srv/alice/docs", "/home/docs");
+
+	free_rules(&local);
+	free_rules(&dist);
+
+	cleanup_handle(SH_HANDLE);
+}
diff --git a/libsemanage/tests/test_path_subs.h b/libsemanage/tests/test_path_subs.h
new file mode 100644
index 00000000..4e92ebd4
--- /dev/null
+++ b/libsemanage/tests/test_path_subs.h
@@ -0,0 +1,30 @@
+/* Authors: Eugenij Safonov <ja.safonau@protonmail.com>
+ *
+ * Copyright (C) 2026
+ *
+ *  This library is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU Lesser General Public License as
+ *  published by the Free Software Foundation; either version 2.1 of the
+ *  License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ *  02110-1301  USA
+ */
+
+#ifndef __TEST_PATH_SUBS_H__
+#define __TEST_PATH_SUBS_H__
+
+#include <CUnit/Basic.h>
+
+int path_subs_test_init(void);
+int path_subs_test_cleanup(void);
+int path_subs_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.56.0

