Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197740;
	b=u8p7t8+YrZ6svVUB5apdkZ4xXr0dBTnTQ9PLef5o3VjVVXMpR2DwEMtSrQQu9jqG8pbN
	 HnNlKaZHeIz8Buzmy74C7xXwaKaOL1VhcjOwHcc6dj1Id30oEMPIvrxjCV6gmOPuVl/Cj
	 8VZJpKyzQVX3U3Fze76aztWQjysHAfQec0XGpFTeBir2J7MHTXDXg9139TFsMg/Uhep/4
	 nF+Yqh/aq4dYDdx8nkloBh52mlns8LFsmYxyz1CGpvS5RG+loAQVXXxNdHQF4cFiuN9Dp
	 c/9tfgNHsEG5qPIInx6oRJT7obW4kX0+0b7OEr3i44FUp/csbJqBiPVarvXU03BI+NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=udBVGt1f0rdgV+ftbUwRQljhoY0dVY7qXVOJUis5ULQ=;
	b=reNQr+lbcKGaq+714MnEBmD4O1SLxl3XUfDVfGjkpgTOTywGr/MXNnpGPRW86tFU8Vn0
	 abY97zHkJf+giqk/zhWXju8d5OB5NIFngOaOnR6Mwo1OKzPEzjf4THJzi4SbquXuxtKl7
	 MPIWymNm65OJaRe3ngkHxY4N7wyd0tH4j3YwhOdG5NGSGvyth6Q/6v20FZtn0mIuspnPS
	 Tbx/KrCHxuan3fidl+1DODajFHwiLAXLgMATKTWs1D7PWTMRUE9Gy/R0tz96tJOIoTFsZ
	 Y5YVebmqvJwUEPnfyK9zElpVF/VsdBh6mkk3GzeCNQyK6o4DTbfPROmjkVWWVShoiWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="RN0+4/Nu";
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0969606A31D
	for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 14:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0969606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RN0+4/Nu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93c5b7f5bfaso217463085a.1
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197739; x=1793802539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=udBVGt1f0rdgV+ftbUwRQljhoY0dVY7qXVOJUis5ULQ=;
        b=RN0+4/Nu9zuXrl1eZ1WSYsqnSw6Ig1dJ48FXjlhCfe2mAW7xH2IDzRieKYWFJ/E6B5
         r8TPrFkUDWUKWSKeaJXelGm4sSI/6oKHIjOyoDkkOT6Z8XY4lw428xgYwZ8Ztr6tPqxf
         NBXvhAFg5HKMFzuLrWq7cJR7eWotnWycr7WaO00qmt+cX2H5ZoNeOtZFp3xGmnu6N1KE
         LXoWdkwRF8IzGp5NmMTO+ep7NoUAN6/dltMCYh9LtOC7VUonG3hzsydJ49JvTJh+aV/M
         28jxsoGU2dejsdCYcsYoW8ecKKc0LfPAkRyqvVPf4YfweLbc/gOTKL+UzskZS/b6aDh6
         +Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197739; x=1793802539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=udBVGt1f0rdgV+ftbUwRQljhoY0dVY7qXVOJUis5ULQ=;
        b=0eTiGkcb0ea9Ts7ueTKdCqIqAvRfR5V44pUCdyDVAi5pl4ShNhhke79g5ytTosx9M/
         xOjXWoMzy0O8LgMFW3zLHc2C8l9/hidYAm2aP89Rp11/gy2gnwjAq4tViXbprgrob4T0
         CDHdc4Z4i3PxexM3PSHNao8QZP+IoXNiER0VH5SdmDlX+5/3bzhuy0Q0ZGVQVhMe+hOh
         LqDSOBg7hTkdIHNdpn3QXLl/Up6q2IQrcBYTUOqFCwl0D6VBh8ekVt5ddA+r/ut8GjBg
         qY8uiMx5VGxcOuXEjZsKheLO2PJYwAn/JDjnGymBCPLwd4pRt39WzN2h729wu4PKjJpP
         O9Og==
X-Gm-Message-State: AFq9FYL+g/jRM4w9jBIkgJ1poP65MZC9FrSpevUgLXj4hQJTBtzurK2H
	dFDYgdY08K3QWyWHKm5kpZQIjF2Uq5K9agV4e00anciaMbelmxWnB7NxNgMBNMPo
X-Gm-Gg: AYBFou1BGDFid02k13eoLWQQO/RnqDQiW1N6Qw74A8eDqURVRTNCL7StqYH20d/rqiG
	IB0V48bS7c19nDKAIHlGquUpyPHZhvgR+Fy5tN5veUjBq+WbQe0FCYKc7ojdw/Bvkm9WD4KWpVq
	Znd3VihCGQ12r8Xw0h6zQBFBjb8zGYVS5eWDpfwrhV12gJMsyp6e0NDPt28fe2JU0219ilY4Ipr
	UvbODEgrMzQDKQaRCdtRie33byYhN4gAdFQ3cYb4gkYxznPgRx+5FsbwXhTlNB4eTRHddoap+vp
	wQ44OxaObsMDnDT36/GaC+5UE9t3HTpQdg+swCvoQiMPiRbYkey4kX2F43JCDB8LuWvTuugw6Cw
	lkpKo/DXZ7mnvxOktJM5s2+SSJJ0FNQ/Ly6vJz3couQtDJkCtyhJap+IhW6Wh3tGd0+h8si7mNC
	0VHh4pejX0R/4MCER+latdnWLLr/S+rfCs0CVh/daGMZclouOgqVppCKp8/t3ua0HhYiN3bchrp
	Rq8IZHt9vO2YTnsIpKICcYc9kKrkxPaFGKgC8dL+dfwQbFbJssiJzDL8PXU7H6hem+X435coCy+
	De0WoGqqYTO868qgOBHUcpIGVPXIbYrHM1D61JRAgZ/v2WfavjYOiEjUu2TDgTwuR6eEeGjmHk/
	LpsIXhBxKkorPfy2Ze5Q4nAMdSeKz0WonGm7DHF3gW0NhkA7gLXcDy1oYMCpvsC9MRjFL6aS/Zr
	1gXvONkIgCBVejne86TSxLXqvzZ3yEA5LWW8a2iARFr+78Qb4bKsY=
X-Received: by 2002:a05:620a:691a:b0:944:204:7e28 with SMTP id af79cd13be357-9440aa39538mr263478385a.22.1793197738673;
        Wed, 28 Oct 2026 07:28:58 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f05ae2f3sm1276791885a.5.2026.10.28.07.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:28:58 -0700 (PDT)
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
Subject: [PATCH 1/2] libsemanage: add path substitution helpers
Date: Wed, 28 Oct 2026 10:28:42 -0400
Message-ID: <20261028142843.130002-1-stephen.smalley.work@gmail.com>
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
  and wildcard rules are skipped with a warning
- semanage_path_subs_apply() rewrites a path according to the first
  matching rule, matching on whole path components only
- semanage_path_subs_canonicalize() applies the local rules first and
  passes the result through the distribution rules, like the
  selabel_file backend does when looking up file contexts

No functional change yet; a follow-up commit uses these helpers in
genhomedircon.

The module is covered by CUnit tests (libsemanage/tests/test_path_subs.c).

Signed-off-by: Eugenij Safonov <ja.safonau@protonmail.com>
---
 libsemanage/src/path_subs.c           | 178 +++++++++++++++++
 libsemanage/src/path_subs.h           |  61 ++++++
 libsemanage/tests/libsemanage-tests.c |   2 +
 libsemanage/tests/test_path_subs.c    | 266 ++++++++++++++++++++++++++
 libsemanage/tests/test_path_subs.h    |  30 +++
 5 files changed, 537 insertions(+)
 create mode 100644 libsemanage/src/path_subs.c
 create mode 100644 libsemanage/src/path_subs.h
 create mode 100644 libsemanage/tests/test_path_subs.c
 create mode 100644 libsemanage/tests/test_path_subs.h

diff --git a/libsemanage/src/path_subs.c b/libsemanage/src/path_subs.c
new file mode 100644
index 00000000..eacfe375
--- /dev/null
+++ b/libsemanage/src/path_subs.c
@@ -0,0 +1,178 @@
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
+/* reverse the list in place */
+static void reverse_rules(semanage_path_subs_t **rules)
+{
+	semanage_path_subs_t *prev = NULL, *next;
+
+	while (*rules) {
+		next = (*rules)->next;
+		(*rules)->next = prev;
+		prev = *rules;
+		*rules = next;
+	}
+	*rules = prev;
+}
+
+int semanage_path_subs_load(semanage_handle_t *sh, const char *path,
+			    semanage_path_subs_t **rules)
+{
+	FILE *fp = NULL;
+	char *line = NULL, *alias, *orig, *ptr;
+	size_t buff_len = 0;
+	ssize_t len;
+	semanage_path_subs_t *rule;
+
+	*rules = NULL;
+
+	fp = fopen(path, "re");
+	if (!fp)
+		return errno == ENOENT ? 0 : -1;
+
+	while ((len = getline(&line, &buff_len, fp)) > 0) {
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
+		if (strchr(alias, '*')) {
+			WARN(sh,
+			     "%s: skipping wildcard substitution rule "
+			     "\"%s %s\": unsupported for this use",
+			     path, alias, orig);
+			continue;
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
+		rule->next = *rules;
+		*rules = rule;
+	}
+
+	free(line);
+	fclose(fp);
+
+	/* Reverse the list so that the first matching rule in the file
+	 * wins, mirroring the selabel_file backend of libselinux. */
+	reverse_rules(rules);
+
+	return 0;
+
+err:
+	free(line);
+	fclose(fp);
+	semanage_path_subs_free(rules);
+	return -1;
+}
+
+char *semanage_path_subs_apply(const semanage_path_subs_t *rules,
+			       const char *path)
+{
+	size_t alias_len, skip;
+	char *result;
+
+	for (; rules; rules = rules->next) {
+		alias_len = strlen(rules->alias);
+		if (strncmp(path, rules->alias, alias_len) != 0)
+			continue;
+		if (path[alias_len] != '/' && path[alias_len] != '\0')
+			continue;
+
+		skip = alias_len;
+		/* avoid a double slash when the original is "/" */
+		if (path[alias_len] == '/' && strcmp(rules->original, "/") == 0)
+			skip++;
+		if (asprintf(&result, "%s%s", rules->original, path + skip) < 0)
+			return NULL;
+		return result;
+	}
+
+	return NULL;
+}
+
+char *semanage_path_subs_canonicalize(const semanage_path_subs_t *local,
+				      const semanage_path_subs_t *dist,
+				      const char *path)
+{
+	char *local_result, *result;
+
+	local_result = semanage_path_subs_apply(local, path);
+	if (!local_result)
+		return semanage_path_subs_apply(dist, path);
+
+	result = semanage_path_subs_apply(dist, local_result);
+	if (result) {
+		free(local_result);
+		return result;
+	}
+
+	return local_result;
+}
diff --git a/libsemanage/src/path_subs.h b/libsemanage/src/path_subs.h
new file mode 100644
index 00000000..864d755c
--- /dev/null
+++ b/libsemanage/src/path_subs.h
@@ -0,0 +1,61 @@
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
+/* Path substitution rules from file_contexts.subs(5): paths under
+ * "alias" are looked up by libselinux as paths under "original". */
+typedef struct semanage_path_subs {
+	char *alias;
+	char *original;
+	struct semanage_path_subs *next;
+} semanage_path_subs_t;
+
+void semanage_path_subs_free(semanage_path_subs_t **rules);
+
+/* Load path substitution rules from a file_contexts.subs(5)-format
+ * file ("alias original" per line, '#' comments).  A missing file is
+ * not an error and yields an empty list.  Wildcard rules (a '*' in
+ * the alias) are skipped with a warning: they cannot be applied to
+ * the path prefixes handled here.  Returns 0 on success, -1 on
+ * error. */
+int semanage_path_subs_load(semanage_handle_t *sh, const char *path,
+			    semanage_path_subs_t **rules);
+
+/* Rewrite "path" according to the first matching rule in "rules",
+ * using the same whole-path-component prefix matching as libselinux's
+ * selabel_file backend.  Returns a malloc'd canonical path, or NULL
+ * when no rule matches or on error. */
+char *semanage_path_subs_apply(const semanage_path_subs_t *rules,
+			       const char *path);
+
+/* Canonicalize "path" through the path substitution rules, mirroring
+ * libselinux's selabel_file backend: local rules are applied first
+ * and the result is then passed through the distribution rules.
+ * Returns a malloc'd canonical path, or NULL when no rule matches or
+ * on error. */
+char *semanage_path_subs_canonicalize(const semanage_path_subs_t *local,
+				      const semanage_path_subs_t *dist,
+				      const char *path);
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
index 00000000..910c3bb7
--- /dev/null
+++ b/libsemanage/tests/test_path_subs.c
@@ -0,0 +1,266 @@
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
+void test_path_subs_apply(void);
+void test_path_subs_canonicalize(void);
+
+static const char *const subs_file = "./test-path-subs.subs";
+
+/* helper: write a subs file and load it */
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
+	char *result = semanage_path_subs_apply(rules, path);
+
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
+	char *result = semanage_path_subs_canonicalize(local, dist, path);
+
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
+	free_rules(&rules);
+
+	/* multiple rules, first line first in the list so it wins on
+	 * duplicate aliases (mirrors libselinux) */
+	rules = load_rules("/a /b\n/c /d\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	CU_ASSERT_STRING_EQUAL(rules->alias, "/a");
+	CU_ASSERT_STRING_EQUAL(rules->original, "/b");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules->next);
+	CU_ASSERT_STRING_EQUAL(rules->next->alias, "/c");
+	CU_ASSERT_STRING_EQUAL(rules->next->original, "/d");
+	CU_ASSERT_PTR_NULL(rules->next->next);
+	free_rules(&rules);
+
+	/* wildcard rules are skipped */
+	rules = load_rules("/w*/homes /home\n/foo /bar\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	CU_ASSERT_PTR_NULL(rules->next);
+	CU_ASSERT_STRING_EQUAL(rules->alias, "/foo");
+	free_rules(&rules);
+
+	/* lines without an original are skipped */
+	rules = load_rules("/foo\n/bar /baz\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	CU_ASSERT_PTR_NULL(rules->next);
+	CU_ASSERT_STRING_EQUAL(rules->alias, "/bar");
+	free_rules(&rules);
+
+	unlink(subs_file);
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
+	/* first matching rule in the file wins */
+	rules = load_rules("/a /b\n/a /c\n");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	assert_apply(rules, "/a/one", "/b/one");
+	free_rules(&rules);
+
+	/* original "/" must not produce a double slash */
+	rules = load_rules("/var /");
+	CU_ASSERT_PTR_NOT_NULL_FATAL(rules);
+	assert_apply(rules, "/var/home", "/home");
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

