Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663790;
	b=WZ6ogkdYrw9dKZcvEz7ssSDCaaNBbzGijE/2mFmK/DHABK7Y952FWn+2oNruXEZ+Thsw
	 63B0j3oewzQOTnYz+Q1JogNcfaqYD3iD6QYgpRiuMyXXarM3cPmsvl71375ibrbnDDKy6
	 AuFs0NdzM/6TmHuGSeWpLEuqqUIlXU9GtveOTBxLJEM61s811QdoQCmkzpxuBLertfrTM
	 Ymtg4v4b/O2lV72j+2JH86SVliR3kSKkQzl+c+6353H1eOpLtYCkI/QJw717EVgDNHmyo
	 +zauQyPZmYL1Oow4GJVeI5apDFAxinb668ytzVvBZ3K8PULsMZUGkVINwfzCvfjg7aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=nlJqiliYwjF9me4Qi8UI6w3ErLzIYrMl+wA4Rxlglw8=;
	b=IPfZXpS9z+pNmwYXiNdkYphx4FTpXayO5DoktZXqsNj4xxCwsxwpZ6rsrkCnvaAnLJVZ
	 zNZV7fSXWtlnvhwjutg4OjZQwIOz4X4ZqglPQmmy0LQ9Fa0uU1tXH+puz9XR3yBizSiT/
	 iZNRXsraJGPMJnxxufdjSZL2ADHCuFkC8JyOoP46Ogn3e4z+MYWeaPDXuCrym/Hrq9YkU
	 +7wTCiu+0j9/dAKko28mvBZTMNjO3MBfJPNUoDMzTg6bIPrvGGPlGohUVwlIg+aBBgR0n
	 oPGdg2xBcMJdsVaFcNA6KP89Ams2to/s05qIYgxZ4XpPx8K97fyvlGHbhwBktdi3KBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tweek.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MQ8gah9B;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C2606A681
	for <selinux@vger.kernel.org>; Thu, 26 Nov 2026 03:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 351C2606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MQ8gah9B
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-847e2926d94so12130306a34.0
        for <selinux@vger.kernel.org>; Wed, 25 Nov 2026 19:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795663789; x=1796268589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nlJqiliYwjF9me4Qi8UI6w3ErLzIYrMl+wA4Rxlglw8=;
        b=MQ8gah9BvN1Ql8+qNOicRDAoavfEOduZbIi9Nko/bna/hEIZsHU4Pla/CmHDXEyLzT
         eplfk4FEbvESK/5Er8vDN6lccCJ78R545fycHl4PqgCKt9gBOfybhQaqgpcu8wOFKGEU
         cAqehH4XWE+My9Wf5SteHo3kwWNzEEtNRXI+zqFCRUMnbnQ3RQEUgoz3LlkLAmdViXX0
         huL+0j6D/NQTFrh/WhNiN2EKYCBTxpOELKHoi9KMOt87n7X8RfTzNBfW1DcUMoMs58z5
         eJx1Qgox/OR02URNRpdaJZbldAFuHPMahFp6jN3xp3hHwqrXUHkq7BVK6zd6zreLlhFJ
         BhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663789; x=1796268589;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nlJqiliYwjF9me4Qi8UI6w3ErLzIYrMl+wA4Rxlglw8=;
        b=pEiUifdNkukuLveSVUacyKwcQsjuSNiTzgU9WgX8s4+cysew+J7ZOGvaxPfiIk/I7d
         CBvEO1L1UhF92ZC6sXqUzQnuVFwMqkfhbWOvonv0fzaNJTYT4GOhZJQwx6xs7SY4gVBe
         PE03gGAYAl64bm3ADJNV9cruDkGisZJg9u751iAFJPtwPDQG6Nzdyiew35s1h2TvWVua
         TQUa6M0dtuLWulWpx9VbVMqN5/oPWdok0xZJprBBz3j0B7zcwouPYHytwUBTJzboZ0x9
         eqpWE9BXOW0SyzriXKisEJ5FsxrjUZLus7SIkEO2NkFF72T2hjkzCn1X6zAJJalsUJuX
         +Idg==
X-Gm-Message-State: APuU4Z+OTHtzBe0mHi5/BGyXbR+XI+XLCoCpbt4OU8DBr4ZF6RbeAiZi
	G2SyRXpT8g/EH2nO8LqNfumBsrIUbwCxgSFmGSz5al3fuNvFAtb6d6WEJLlC03n0rR18DqKOQId
	1qKTzD6C7k4w0bcE1PV04sE1W7UAhKdvhuKck0jbKrmQ4b+qgQT/El0sga7XF0mhk9HH5lnWhTc
	3Ei/BJ4My9EpHBXw9smfTadVr1f9/KPOmu
X-Received: from ilej3-n2.prod.google.com ([2002:a05:6e02:6203:20b0:53b:299:42c1])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:1785:b0:543:50ad:baae
 with SMTP id 5614622812f47-57a0d817ea9mr23597628b6e.63.1795663788738; Wed, 25
 Nov 2026 19:29:48 -0800 (PST)
Date: Thu, 26 Nov 2026 14:29:22 +1100
In-Reply-To: <20261126032924.1868720-1-tweek@google.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126032924.1868720-1-tweek@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126032924.1868720-2-tweek@google.com>
Subject: [PATCH userspace 1/2] libsepol: align module_to_cil type/role set
 handling with expand.c
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	James Carter <jwcart2@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	"=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, Inseob Kim <inseob@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cil_print_attr_strs() converts module type_set and role_set structures
into CIL attributesets, but diverges from type_set_expand() and
role_set_expand() in libsepol/src/expand.c in several edge cases:

1. Negative-only type set ({ -t1 }, flags =3D=3D 0, empty positive set,
   non-empty negset): type_set_expand() evaluates (empty \ negset) as
   the empty set, whereas cil_print_attr_strs() omitted the "(and ...)"
   wrapper and emitted "(not (t1 ))", matching all types except t1.
   Notably, checkpolicy rejects "allow ~t1 ..." yet accepts
   "allow { -t1 } ...", causing monolithic checkpolicy to grant nothing
   while checkpolicy -C / semodule grants access to every type except
   t1.

2. Complemented negative-only or empty set (~{ -t1 } or flags =3D=3D
   TYPE_COMP / ROLE_COMP with an empty positive set): expand.c evaluates
   ~empty as all types/roles, whereas cil_print_attr_strs() emitted
   "(not (not (t1 )))" (matching only t1) or invalid "(not )".

3. TYPE_STAR with a non-empty negset (or extra flags/positive set):
   type_set_expand() selects all types not in negset and ignores the
   positive set and TYPE_COMP, whereas cil_print_attr_strs() emitted
   invalid CIL such as "(all)(not (t1 ))".

Update cil_print_attr_strs() to match expand.c semantics for all
combinations of STAR, COMP, positive, and negative sets, leaving the
attribute empty (no attributeset statement) when the resulting set is
empty so rules referencing it remain valid CIL (including inside
booleanif blocks) while expanding to no entries.

Add unit tests covering negative-only, complemented negative-only, and
star-with-negset conversion in libsepol/tests/test-module-to-cil.c.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libsepol/src/module_to_cil.c                  |  69 +++--
 libsepol/tests/libsepol-tests.c               |   2 +
 .../test-module-to-cil/typeset-comp.conf      |  24 ++
 .../policies/test-module-to-cil/typeset.conf  |  34 +++
 libsepol/tests/test-module-to-cil.c           | 268 ++++++++++++++++++
 libsepol/tests/test-module-to-cil.h           |  10 +
 6 files changed, 383 insertions(+), 24 deletions(-)
 create mode 100644 libsepol/tests/policies/test-module-to-cil/typeset-comp=
.conf
 create mode 100644 libsepol/tests/policies/test-module-to-cil/typeset.conf
 create mode 100644 libsepol/tests/test-module-to-cil.c
 create mode 100644 libsepol/tests/test-module-to-cil.h

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 50b29b2e..7d9f02de 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -852,15 +852,17 @@ static int cil_print_attr_strs(int indent, struct pol=
icydb *pdb, int is_type,
 			       void *set, char *attr_name)
 {
 	// CIL doesn't support anonymous positive/negative/complemented sets.  So
-	// instead we create a CIL type/roleattributeset that matches the set. If
-	// the set has a negative set, then convert it to is (P & !N), where P is
-	// the list of members in the positive set and N is the list of members
-	// in the negative set. Additionally, if the set is complemented, then wr=
ap
-	// the whole thing with a negation.
+	// instead we create a CIL type/roleattributeset that matches the set.
+	// Match expand.c semantics (type_set_expand() / role_set_expand()):
+	// - STAR selects all members except any in N (ignoring P and COMP).
+	// - Otherwise, if P is empty, (P & !N) is empty: emit (all) if COMP is
+	//   set, or leave the attribute empty otherwise.
+	// - Otherwise, emit P (or (P & !N) if N is non-empty), wrapped in
+	//   (not ...) if COMP is set.
=20
 	struct ebitmap_node *node;
 	struct ebitmap *pos, *neg;
-	uint32_t flags;
+	uint32_t flags, star_flag, comp_flag;
 	unsigned i;
 	struct type_set *ts;
 	struct role_set *rs;
@@ -876,6 +878,8 @@ static int cil_print_attr_strs(int indent, struct polic=
ydb *pdb, int is_type,
 		pos =3D &ts->types;
 		neg =3D &ts->negset;
 		flags =3D ts->flags;
+		star_flag =3D TYPE_STAR;
+		comp_flag =3D TYPE_COMP;
 		has_positive =3D pos && !ebitmap_is_empty(pos);
 		has_negative =3D neg && !ebitmap_is_empty(neg);
 	} else {
@@ -885,33 +889,54 @@ static int cil_print_attr_strs(int indent, struct pol=
icydb *pdb, int is_type,
 		pos =3D &rs->roles;
 		neg =3D NULL;
 		flags =3D rs->flags;
+		star_flag =3D ROLE_STAR;
+		comp_flag =3D ROLE_COMP;
 		has_positive =3D pos && !ebitmap_is_empty(pos);
 		has_negative =3D 0;
 	}
=20
 	cil_println(indent, "(%sattribute %s)", kind, attr_name);
-	cil_indent(indent);
-	cil_printf("(%sattributeset %s ", kind, attr_name);
=20
-	if (flags & TYPE_STAR) {
-		cil_printf("(all)");
+	if (flags & star_flag) {
+		cil_indent(indent);
+		if (has_negative) {
+			cil_printf("(%sattributeset %s (not (", kind,
+				   attr_name);
+			ebitmap_for_each_positive_bit(neg, node, i) {
+				cil_printf("%s ", val_to_name[i]);
+			}
+			cil_printf(")))\n");
+		} else {
+			cil_printf("(%sattributeset %s (all))\n", kind,
+				   attr_name);
+		}
+		return rc;
+	}
+
+	if (!has_positive) {
+		if (flags & comp_flag) {
+			cil_println(indent, "(%sattributeset %s (all))", kind,
+				    attr_name);
+		}
+		return rc;
 	}
=20
-	if (flags & TYPE_COMP) {
+	cil_indent(indent);
+	cil_printf("(%sattributeset %s ", kind, attr_name);
+
+	if (flags & comp_flag) {
 		cil_printf("(not ");
 	}
=20
-	if (has_positive && has_negative) {
+	if (has_negative) {
 		cil_printf("(and ");
 	}
=20
-	if (has_positive) {
-		cil_printf("(");
-		ebitmap_for_each_positive_bit(pos, node, i) {
-			cil_printf("%s ", val_to_name[i]);
-		}
-		cil_printf(") ");
+	cil_printf("(");
+	ebitmap_for_each_positive_bit(pos, node, i) {
+		cil_printf("%s ", val_to_name[i]);
 	}
+	cil_printf(") ");
=20
 	if (has_negative) {
 		cil_printf("(not (");
@@ -920,14 +945,10 @@ static int cil_print_attr_strs(int indent, struct pol=
icydb *pdb, int is_type,
 			cil_printf("%s ", val_to_name[i]);
 		}
=20
-		cil_printf("))");
-	}
-
-	if (has_positive && has_negative) {
-		cil_printf(")");
+		cil_printf(")))");
 	}
=20
-	if (flags & TYPE_COMP) {
+	if (flags & comp_flag) {
 		cil_printf(")");
 	}
=20
diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-test=
s.c
index 1b70be01..c2746b8e 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -26,6 +26,7 @@
 #include "test-downgrade.h"
 #include "test-neverallow.h"
 #include "test-kernel-to-cil.h"
+#include "test-module-to-cil.h"
 #include "test-ocontext.h"
=20
 #include <CUnit/Basic.h>
@@ -77,6 +78,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(downgrade);
 	DECLARE_SUITE(neverallow);
 	DECLARE_SUITE(kernel_to_cil);
+	DECLARE_SUITE(module_to_cil);
 	DECLARE_SUITE(ocontext);
=20
 	if (verbose)
diff --git a/libsepol/tests/policies/test-module-to-cil/typeset-comp.conf b=
/libsepol/tests/policies/test-module-to-cil/typeset-comp.conf
new file mode 100644
index 00000000..968ec7ac
--- /dev/null
+++ b/libsepol/tests/policies/test-module-to-cil/typeset-comp.conf
@@ -0,0 +1,24 @@
+class process
+
+sid kernel
+
+class process { transition fork }
+
+ifdef(`enable_mls',`
+sensitivity s0;
+dominance { s0 }
+category c0;
+level s0:c0;
+mlsconstrain process { transition } ( h1 dom h2 );
+')
+
+type type1;
+type type2;
+
+allow type1 self : process transition;
+neverallow ~{ -type1 } self : process fork;
+
+role sys_role;
+role sys_role types { type1 type2 };
+gen_user(sys_user,, sys_role, s0, s0)
+sid kernel gen_context(sys_user:sys_role:type1, s0)
diff --git a/libsepol/tests/policies/test-module-to-cil/typeset.conf b/libs=
epol/tests/policies/test-module-to-cil/typeset.conf
new file mode 100644
index 00000000..be48c632
--- /dev/null
+++ b/libsepol/tests/policies/test-module-to-cil/typeset.conf
@@ -0,0 +1,34 @@
+class process
+
+sid kernel
+
+class process { transition fork }
+
+ifdef(`enable_mls',`
+sensitivity s0;
+dominance { s0 }
+category c0;
+level s0:c0;
+mlsconstrain process { transition } ( h1 dom h2 );
+')
+
+type type1;
+type type2;
+
+bool test_bool false;
+
+allow type1 self : process transition;
+allow { -type1 } self : process transition;
+neverallow type2 self : process transition;
+
+allow type2 self : process fork;
+neverallow { -type1 } self : process fork;
+
+if (test_bool) {
+	allow { -type1 } self : process transition;
+}
+
+role sys_role;
+role sys_role types { type1 type2 };
+gen_user(sys_user,, sys_role, s0, s0)
+sid kernel gen_context(sys_user:sys_role:type1, s0)
diff --git a/libsepol/tests/test-module-to-cil.c b/libsepol/tests/test-modu=
le-to-cil.c
new file mode 100644
index 00000000..1d767058
--- /dev/null
+++ b/libsepol/tests/test-module-to-cil.c
@@ -0,0 +1,268 @@
+#include "test-module-to-cil.h"
+
+#include "helpers.h"
+
+#include <sepol/cil/cil.h>
+#include <sepol/module_to_cil.h>
+#include <sepol/policydb/expand.h>
+#include <sepol/policydb/link.h>
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+extern int mls;
+
+int module_to_cil_test_init(void)
+{
+	return 0;
+}
+
+int module_to_cil_test_cleanup(void)
+{
+	return 0;
+}
+
+static int quiet_cil_logs;
+
+static void test_cil_log_handler(int lvl, const char *msg)
+{
+	(void)lvl;
+	if (!quiet_cil_logs)
+		fprintf(stderr, "%s", msg);
+}
+
+static int compile_cil_buf(const char *buf, size_t len, const char *extra_=
cil,
+			   int quiet)
+{
+	cil_db_t *db =3D NULL;
+	sepol_policydb_t *pdb =3D NULL;
+	int rc;
+
+	quiet_cil_logs =3D quiet;
+	cil_set_log_handler(test_cil_log_handler);
+
+	cil_db_init(&db);
+	cil_set_mls(db, mls);
+
+	rc =3D cil_add_file(db, "test.cil", buf, len);
+	if (rc =3D=3D SEPOL_OK && extra_cil)
+		rc =3D cil_add_file(db, "extra.cil", extra_cil,
+				  strlen(extra_cil));
+	if (rc =3D=3D SEPOL_OK)
+		rc =3D cil_compile(db);
+	if (rc =3D=3D SEPOL_OK)
+		rc =3D cil_build_policydb(db, &pdb);
+
+	sepol_policydb_free(pdb);
+	cil_db_destroy(&db);
+	quiet_cil_logs =3D 0;
+
+	return rc;
+}
+
+static char *module_to_cil_buf(policydb_t *pdb, size_t *len)
+{
+	char *buf =3D NULL;
+	FILE *out;
+
+	/*
+	 * sepol_module_policydb_to_cil() overwrites pdb->name for POLICY_BASE
+	 * without freeing any existing name set by read_source_policy().
+	 */
+	free(pdb->name);
+	pdb->name =3D NULL;
+
+	out =3D open_memstream(&buf, len);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(out);
+	CU_ASSERT(sepol_module_policydb_to_cil(out, pdb, 1) =3D=3D 0);
+	CU_ASSERT_FATAL(fclose(out) =3D=3D 0);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(buf);
+
+	return buf;
+}
+
+static int has_cil_line_with(const char *buf, const char *prefix,
+			     const char *suffix)
+{
+	const char *line =3D buf;
+
+	while (line && *line) {
+		const char *nl =3D strchr(line, '\n');
+		size_t line_len =3D nl ? (size_t)(nl - line) : strlen(line);
+		size_t pre_len =3D strlen(prefix);
+		size_t suf_len =3D strlen(suffix);
+
+		if (line_len >=3D pre_len + suf_len &&
+		    strncmp(line, prefix, pre_len) =3D=3D 0 &&
+		    strncmp(line + line_len - suf_len, suffix, suf_len) =3D=3D 0)
+			return 1;
+
+		if (!nl)
+			break;
+		line =3D nl + 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Silence expected parser warnings when loading test policies that
+ * intentionally use negative-only type sets.
+ */
+static int load_policy_quiet(policydb_t *p, const char *policy_name)
+{
+	int saved_stderr, devnull, rc;
+
+	fflush(stderr);
+	saved_stderr =3D dup(STDERR_FILENO);
+	devnull =3D open("/dev/null", O_WRONLY);
+	if (saved_stderr >=3D 0 && devnull >=3D 0) {
+		if (dup2(devnull, STDERR_FILENO) < 0) {
+			close(saved_stderr);
+			saved_stderr =3D -1;
+		}
+	}
+	if (devnull >=3D 0)
+		close(devnull);
+
+	rc =3D test_load_policy(p, POLICY_BASE, mls, "test-module-to-cil",
+			      policy_name);
+
+	fflush(stderr);
+	if (saved_stderr >=3D 0) {
+		(void)dup2(saved_stderr, STDERR_FILENO);
+		close(saved_stderr);
+	}
+
+	return rc;
+}
+
+/*
+ * A type set with only negative types ({ -type1 }) and no flags expands t=
o
+ * the empty set in expand.c. module_to_cil must emit an empty attribute
+ * rather than (not (type1 )), matching expand.c for allow, neverallow, an=
d
+ * conditional rules.
+ */
+static void test_module_to_cil_negset_without_positive(void)
+{
+	policydb_t basemod, expanded;
+	char *buf =3D NULL;
+	size_t len =3D 0;
+
+	if (load_policy_quiet(&basemod, "typeset.conf"))
+		CU_FAIL_FATAL("Failed to load policy");
+
+	if (link_modules(NULL, &basemod, NULL, 0, 0))
+		CU_FAIL_FATAL("Failed to link base module");
+
+	if (policydb_init(&expanded))
+		CU_FAIL_FATAL("Failed to initialize policy");
+
+	CU_ASSERT(expand_module(NULL, &basemod, &expanded, 0, 1) =3D=3D 0);
+
+	buf =3D module_to_cil_buf(&basemod, &len);
+	CU_ASSERT_PTR_NULL(strstr(buf, "(typeattributeset "));
+	CU_ASSERT_PTR_NULL(strstr(buf, "(not (type1"));
+	CU_ASSERT(compile_cil_buf(buf, len, NULL, 0) =3D=3D SEPOL_OK);
+
+	free(buf);
+	policydb_destroy(&basemod);
+	policydb_destroy(&expanded);
+}
+
+/*
+ * A complemented negative-only type set (~{ -type1 }) expands to ~empty =
=3D all
+ * in expand.c. module_to_cil must emit (all) rather than (not (not (type1=
 ))).
+ */
+static void test_module_to_cil_comp_negset_without_positive(void)
+{
+	policydb_t basemod;
+	char *buf =3D NULL;
+	size_t len =3D 0;
+
+	if (load_policy_quiet(&basemod, "typeset-comp.conf"))
+		CU_FAIL_FATAL("Failed to load policy");
+
+	if (link_modules(NULL, &basemod, NULL, 0, 0))
+		CU_FAIL_FATAL("Failed to link base module");
+
+	buf =3D module_to_cil_buf(&basemod, &len);
+	CU_ASSERT(has_cil_line_with(buf, "(typeattributeset ", " (all))"));
+	CU_ASSERT_PTR_NULL(strstr(buf, "(not (not"));
+	CU_ASSERT(compile_cil_buf(buf, len, NULL, 0) =3D=3D SEPOL_OK);
+
+	/* ~{ -type1 } matches all types, including type2. */
+	CU_ASSERT(compile_cil_buf(buf, len,
+				  "(allow type2 self (process (fork)))",
+				  1) !=3D SEPOL_OK);
+
+	free(buf);
+	policydb_destroy(&basemod);
+}
+
+/*
+ * A type set with TYPE_STAR and a non-empty negset expands to all types
+ * except negset in expand.c. module_to_cil must emit (not (<negset>)) rat=
her
+ * than invalid "(all)(not (<negset>))".
+ */
+static void test_module_to_cil_star_with_negset(void)
+{
+	policydb_t basemod;
+	char *buf =3D NULL;
+	size_t len =3D 0;
+	avrule_t *na_rule;
+
+	if (load_policy_quiet(&basemod, "typeset-comp.conf"))
+		CU_FAIL_FATAL("Failed to load policy");
+
+	if (link_modules(NULL, &basemod, NULL, 0, 0))
+		CU_FAIL_FATAL("Failed to link base module");
+
+	na_rule =3D basemod.global->branch_list->avrules;
+	while (na_rule && na_rule->specified !=3D AVRULE_NEVERALLOW)
+		na_rule =3D na_rule->next;
+	CU_ASSERT_PTR_NOT_NULL_FATAL(na_rule);
+
+	/* Switch the neverallow's stypes from TYPE_COMP to TYPE_STAR + negset=3D=
{type1}. */
+	na_rule->stypes.flags =3D TYPE_STAR;
+
+	buf =3D module_to_cil_buf(&basemod, &len);
+	CU_ASSERT(has_cil_line_with(buf, "(typeattributeset ",
+				    " (not (type1 )))"));
+	CU_ASSERT_PTR_NULL(strstr(buf, "(all)(not"));
+
+	/* type1 is excluded by negset; type2 is matched by TYPE_STAR \ {type1}. =
*/
+	CU_ASSERT(compile_cil_buf(buf, len,
+				  "(allow type1 self (process (fork)))",
+				  0) =3D=3D SEPOL_OK);
+	CU_ASSERT(compile_cil_buf(buf, len,
+				  "(allow type2 self (process (fork)))",
+				  1) !=3D SEPOL_OK);
+
+	free(buf);
+	policydb_destroy(&basemod);
+}
+
+int module_to_cil_add_tests(CU_pSuite suite)
+{
+	if (NULL =3D=3D CU_add_test(suite, "module_to_cil_negset_without_positive=
",
+				test_module_to_cil_negset_without_positive)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	if (NULL =3D=3D
+	    CU_add_test(suite, "module_to_cil_comp_negset_without_positive",
+			test_module_to_cil_comp_negset_without_positive)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	if (NULL =3D=3D CU_add_test(suite, "module_to_cil_star_with_negset",
+				test_module_to_cil_star_with_negset)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	return 0;
+}
diff --git a/libsepol/tests/test-module-to-cil.h b/libsepol/tests/test-modu=
le-to-cil.h
new file mode 100644
index 00000000..0d20fd48
--- /dev/null
+++ b/libsepol/tests/test-module-to-cil.h
@@ -0,0 +1,10 @@
+#ifndef TEST_MODULE_TO_CIL_H__
+#define TEST_MODULE_TO_CIL_H__
+
+#include <CUnit/Basic.h>
+
+int module_to_cil_test_init(void);
+int module_to_cil_test_cleanup(void);
+int module_to_cil_add_tests(CU_pSuite suite);
+
+#endif
--=20
2.56.1.839.g22a8290db9-goog

