Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A514408014
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679357; cv=none; b=PA13bnUOTW8wNCwdlETVE3x1p4KoUjgrep0iGcfg5pUoWTouiTXophK+BkuyAlR7WYHZFrz4G5ARQSFiH4PHKZWc6pUpiFarO2q5u0/UxHJBD5nXV1HBwAOY7KuE+yUNQ/tYab/0RQXTyDElQ560AuN4DqKX/iYKN5ilGaxjcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679357; c=relaxed/simple;
	bh=3jsLHBg0iGXbIYvfJ+PgoofoW1JYBBGwMDQzXj4VhdA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BPZrOUzo7ktVtDqzpIu3Wl0q5dyxYFXTdzq2n6ZLPoSU7ZGH+X4TLCN8JCnlJDuGKWsRihlKmZsb+r98TVsS5bEhe/7wd1+a7NVR2o3jL6EEBjXhYqPheLrMqM4qA59Urb7npQhuQ9CspDSEeWGhK+V1ajNoRDC5ns97hcUyX5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BA7lHAZ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BA7lHAZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783679354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5ZrfX6yERdBakSlYft17QMyJQeGAjDw7aAJfNyPWZC0=;
	b=BA7lHAZ6Asym3OG39uswGZ78TyMiN6qvmXlm3/RNk+toGHQVg7DODuTWbEbPzI9rph2M4w
	MoAIPaQed+J12THoyRgqYEGzHm4bbKpCYqfJVatpwvv3DkgJzdhQijqvT22W/Aorj83PbJ
	v6riLHKLx/sTNlzHDKpGcJNk4cLEIdE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-qV4P6OOvPHuGKOF95Rx8mw-1; Fri,
 10 Jul 2026 06:29:10 -0400
X-MC-Unique: qV4P6OOvPHuGKOF95Rx8mw-1
X-Mimecast-MFC-AGG-ID: qV4P6OOvPHuGKOF95Rx8mw_1783679349
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D2C118005AA
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 10:29:09 +0000 (UTC)
Received: from akkohli-thinkpadt14sgen2i.rmtde.csb (unknown [10.44.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DCF930001BE
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 10:29:08 +0000 (UTC)
From: Akhil Kohli <akkohli@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] checkpolicy: add bad data protection tests
Date: Fri, 10 Jul 2026 12:29:06 +0200
Message-ID: <20260710102906.3059833-1-akkohli@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add test_checkmodule_negative.sh and .te fixtures for  bad-data protection (missing/bad-path and corrupted .te inputs).

Signed-off-by: Akhil Kohli <akkohli@redhat.com>
---
 checkpolicy/Makefile                          |   3 +-
 checkpolicy/tests/negative/bad_module_line.te |   5 +
 checkpolicy/tests/negative/bad_require.te     |   5 +
 checkpolicy/tests/negative/bad_syntax.te      |   8 +
 checkpolicy/tests/negative/dup_module.te      |   6 +
 checkpolicy/tests/negative/good_module.te     |   8 +
 .../tests/negative/invalid_module_version.te  |   5 +
 checkpolicy/tests/negative/unknown_class.te   |   7 +
 checkpolicy/tests/negative/unknown_perm.te    |   8 +
 checkpolicy/tests/negative/unknown_type.te    |   8 +
 .../tests/test_checkmodule_negative.sh        | 178 ++++++++++++++++++
 11 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 checkpolicy/tests/negative/bad_module_line.te
 create mode 100644 checkpolicy/tests/negative/bad_require.te
 create mode 100644 checkpolicy/tests/negative/bad_syntax.te
 create mode 100644 checkpolicy/tests/negative/dup_module.te
 create mode 100644 checkpolicy/tests/negative/good_module.te
 create mode 100644 checkpolicy/tests/negative/invalid_module_version.te
 create mode 100644 checkpolicy/tests/negative/unknown_class.te
 create mode 100644 checkpolicy/tests/negative/unknown_perm.te
 create mode 100644 checkpolicy/tests/negative/unknown_type.te
 create mode 100755 checkpolicy/tests/test_checkmodule_negative.sh

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 0055f495..e59ad63a 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -51,8 +51,9 @@ lex.yy.c: policy_scan.l y.tab.c
 	$(LEX) policy_scan.l
 
 .PHONY: test
-test: checkpolicy
+test: checkpolicy checkmodule
 	./tests/test_roundtrip.sh
+	./tests/test_checkmodule_negative.sh
 
 # helper target for fuzzing
 checkobjects: $(CHECKOBJS)
diff --git a/checkpolicy/tests/negative/bad_module_line.te b/checkpolicy/tests/negative/bad_module_line.te
new file mode 100644
index 00000000..587df2e1
--- /dev/null
+++ b/checkpolicy/tests/negative/bad_module_line.te
@@ -0,0 +1,5 @@
+module bad module name 1.0 garbage;
+
+require {
+	type foo_t;
+}
diff --git a/checkpolicy/tests/negative/bad_require.te b/checkpolicy/tests/negative/bad_require.te
new file mode 100644
index 00000000..a45df4f4
--- /dev/null
+++ b/checkpolicy/tests/negative/bad_require.te
@@ -0,0 +1,5 @@
+module bad_require 1.0;
+
+require {
+	garbage_token foo_t;
+}
diff --git a/checkpolicy/tests/negative/bad_syntax.te b/checkpolicy/tests/negative/bad_syntax.te
new file mode 100644
index 00000000..20605201
--- /dev/null
+++ b/checkpolicy/tests/negative/bad_syntax.te
@@ -0,0 +1,8 @@
+module bad_syntax 1.0;
+
+require {
+	type foo_t;
+	class file { read };
+}
+
+allow foo_t foo_t:file {
diff --git a/checkpolicy/tests/negative/dup_module.te b/checkpolicy/tests/negative/dup_module.te
new file mode 100644
index 00000000..beefff72
--- /dev/null
+++ b/checkpolicy/tests/negative/dup_module.te
@@ -0,0 +1,6 @@
+module dup_module 1.0;
+module dup_module 1.0;
+
+require {
+	type foo_t;
+}
diff --git a/checkpolicy/tests/negative/good_module.te b/checkpolicy/tests/negative/good_module.te
new file mode 100644
index 00000000..b9c9982f
--- /dev/null
+++ b/checkpolicy/tests/negative/good_module.te
@@ -0,0 +1,8 @@
+module good_module 1.0;
+
+require {
+	type foo_t, bar_t;
+	class file { read write };
+}
+
+allow foo_t bar_t:file read;
diff --git a/checkpolicy/tests/negative/invalid_module_version.te b/checkpolicy/tests/negative/invalid_module_version.te
new file mode 100644
index 00000000..d18b7639
--- /dev/null
+++ b/checkpolicy/tests/negative/invalid_module_version.te
@@ -0,0 +1,5 @@
+module invalid_module_version;
+
+require {
+	type foo_t;
+}
diff --git a/checkpolicy/tests/negative/unknown_class.te b/checkpolicy/tests/negative/unknown_class.te
new file mode 100644
index 00000000..825e0413
--- /dev/null
+++ b/checkpolicy/tests/negative/unknown_class.te
@@ -0,0 +1,7 @@
+module unknown_class 1.0;
+
+require {
+	type foo_t;
+}
+
+allow foo_t self:not_a_class read;
diff --git a/checkpolicy/tests/negative/unknown_perm.te b/checkpolicy/tests/negative/unknown_perm.te
new file mode 100644
index 00000000..f4efbb54
--- /dev/null
+++ b/checkpolicy/tests/negative/unknown_perm.te
@@ -0,0 +1,8 @@
+module unknown_perm 1.0;
+
+require {
+	type foo_t, bar_t;
+	class file { read };
+}
+
+allow foo_t bar_t:file circular_ref;
diff --git a/checkpolicy/tests/negative/unknown_type.te b/checkpolicy/tests/negative/unknown_type.te
new file mode 100644
index 00000000..62360e04
--- /dev/null
+++ b/checkpolicy/tests/negative/unknown_type.te
@@ -0,0 +1,8 @@
+module unknown_type 1.0;
+
+require {
+	type foo_t;
+	class file { read };
+}
+
+allow foo_t undeclared_t:file read;
diff --git a/checkpolicy/tests/test_checkmodule_negative.sh b/checkpolicy/tests/test_checkmodule_negative.sh
new file mode 100755
index 00000000..0619d597
--- /dev/null
+++ b/checkpolicy/tests/test_checkmodule_negative.sh
@@ -0,0 +1,178 @@
+#!/bin/sh
+#
+# Negative / bad-data tests for checkmodule on module (.te) inputs.
+# Matches the RHIVOS modular compile path: checkmodule -M -m <input> -o <module>.mod
+#
+
+set -eu
+
+BASEDIR=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
+NEGDIR="${BASEDIR}/negative"
+CHECKMODULE="${BASEDIR}/../checkmodule"
+OUTDIR=$(mktemp -d "${TMPDIR:-/tmp}/checkmodule-negative.XXXXXX")
+PASS=0
+FAIL=0
+
+cleanup() {
+	rm -rf "${OUTDIR}"
+}
+trap cleanup EXIT
+
+mod_name_from_fixture() {
+	basename "$1" .te
+}
+
+expect_pass() {
+	desc="$1"
+	fixture="$2"
+	modname=$(mod_name_from_fixture "${fixture}")
+	outmod="${OUTDIR}/${modname}.mod"
+	stderr="${OUTDIR}/${modname}.err"
+
+	echo "==== POSITIVE (expect checkmodule success): ${desc}"
+	rm -f "${outmod}"
+
+	set +e
+	"${CHECKMODULE}" -M -m -o "${outmod}" "${NEGDIR}/${fixture}" 2>"${stderr}"
+	rc=$?
+	set -e
+
+	if [ "${rc}" -ne 0 ]; then
+		echo "FAIL: expected success (rc=0), got rc=${rc}" >&2
+		cat "${stderr}" >&2
+		FAIL=$((FAIL + 1))
+		return 1
+	fi
+	if [ ! -s "${outmod}" ]; then
+		echo "FAIL: expected non-empty ${outmod}" >&2
+		FAIL=$((FAIL + 1))
+		return 1
+	fi
+
+	echo "==== ${desc} success"
+	PASS=$((PASS + 1))
+	echo ""
+}
+
+expect_fail() {
+	desc="$1"
+	pattern="$2"
+	outname="${3:-fail}"
+	shift 3
+
+	outmod="${OUTDIR}/${outname}.mod"
+	stderr="${OUTDIR}/${outname}.err"
+
+	echo "==== NEGATIVE (expect checkmodule error): ${desc}"
+	rm -f "${outmod}"
+
+	set +e
+	"${CHECKMODULE}" -M -m "$@" -o "${outmod}" 2>"${stderr}"
+	rc=$?
+	set -e
+
+	if [ "${rc}" -eq 0 ]; then
+		echo "FAIL: expected non-zero exit, got rc=0" >&2
+		FAIL=$((FAIL + 1))
+		return 1
+	fi
+	if [ -f "${outmod}" ]; then
+		echo "FAIL: did not expect output module ${outmod}" >&2
+		FAIL=$((FAIL + 1))
+		return 1
+	fi
+	if ! grep -Eq "${pattern}" "${stderr}"; then
+		echo "FAIL: stderr did not match /${pattern}/" >&2
+		cat "${stderr}" >&2
+		FAIL=$((FAIL + 1))
+		return 1
+	fi
+
+	echo "==== ${desc}: rejected as expected"
+	PASS=$((PASS + 1))
+	echo ""
+}
+
+expect_fail_unreadable() {
+	desc="unreadable .te file"
+	fixture="${OUTDIR}/unreadable.te"
+	outmod="${OUTDIR}/unreadable.mod"
+	stderr="${OUTDIR}/unreadable.err"
+
+	echo "==== NEGATIVE (expect checkmodule error): ${desc}"
+	if [ "$(id -u)" -eq 0 ]; then
+		echo "SKIP: root can read mode 000 files; unreadable check is non-root only"
+		PASS=$((PASS + 1))
+		echo ""
+		return 0
+	fi
+
+	rm -f "${outmod}"
+
+	set +e
+	"${CHECKMODULE}" -M -m -o "${outmod}" "${fixture}" 2>"${stderr}"
+	rc=$?
+	set -e
+
+	if [ "${rc}" -eq 0 ]; then
+		echo "FAIL: expected non-zero exit, got rc=0" >&2
+		FAIL=$((FAIL + 1))
+		return 1
+	fi
+	if [ -f "${outmod}" ]; then
+		echo "FAIL: did not expect output module ${outmod}" >&2
+		FAIL=$((FAIL + 1))
+		return 1
+	fi
+	if ! grep -Eq 'unable to open|Permission denied' "${stderr}"; then
+		echo "FAIL: stderr did not mention unable to open or Permission denied" >&2
+		cat "${stderr}" >&2
+		FAIL=$((FAIL + 1))
+		return 1
+	fi
+
+	echo "==== ${desc}: rejected as expected"
+	PASS=$((PASS + 1))
+	echo ""
+}
+
+# Ephemeral fixtures for path-based cases.
+ln -sf /nonexistent/path "${OUTDIR}/broken_symlink.te"
+cat > "${OUTDIR}/unreadable.te" <<'EOF'
+module unreadable 1.0;
+
+require {
+	type foo_t;
+}
+EOF
+chmod 000 "${OUTDIR}/unreadable.te"
+
+# Control fixture: valid module compiles and produces .mod output.
+expect_pass "good_module.te" "good_module.te"
+
+# Corrupted .te sections (PDF #2).
+expect_fail "bad_syntax.te" "syntax error" "bad_syntax" "${NEGDIR}/bad_syntax.te"
+expect_fail "unknown_perm.te" "permission circular_ref is not defined" "unknown_perm" "${NEGDIR}/unknown_perm.te"
+expect_fail "unknown_type.te" "unknown type undeclared_t" "unknown_type" "${NEGDIR}/unknown_type.te"
+expect_fail "unknown_class.te" "unknown class not_a_class" "unknown_class" "${NEGDIR}/unknown_class.te"
+expect_fail "bad_module_line.te" "syntax error" "bad_module_line" "${NEGDIR}/bad_module_line.te"
+expect_fail "bad_require.te" "syntax error" "bad_require" "${NEGDIR}/bad_require.te"
+expect_fail "invalid_module_version.te" "syntax error" "invalid_module_version" "${NEGDIR}/invalid_module_version.te"
+expect_fail "dup_module.te" "syntax error" "dup_module" "${NEGDIR}/dup_module.te"
+
+# Missing / bad-path .te inputs (PDF #1).
+expect_fail "missing .te path" "unable to open" "missing_path" "${OUTDIR}/does_not_exist.te"
+expect_fail "directory instead of .te file" "input in flex scanner failed" "directory_input" "${NEGDIR}"
+expect_fail "broken symlink to .te" "unable to open" "broken_symlink" "${OUTDIR}/broken_symlink.te"
+expect_fail_unreadable
+expect_fail "empty .te path argument" "unable to open" "empty_path" ""
+
+# CLI edge cases.
+expect_fail "checkmodule with no input file" "unable to open policy.conf" "no_input"
+expect_fail "checkmodule -o name mismatch" "Module name good_module is different" "name_mismatch" \
+	-o "${OUTDIR}/wrong_name.mod" "${NEGDIR}/good_module.te"
+
+echo "checkmodule negative tests: ${PASS} passed, ${FAIL} failed"
+if [ "${FAIL}" -ne 0 ]; then
+	exit 1
+fi
-- 
2.55.0

