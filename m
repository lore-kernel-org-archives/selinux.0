Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466603998BE
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555399; cv=none; b=bYZp7X9yRxZnesMvPyDjNYjoOmtG2CsB5qFJLXyQoV89GFAClsREAt7IK3oL0n3HOvzw/clOEt3dJY3tG/MP+lpuLcq08drE86FI48LVG7b+P7j2NzrLC5v+JH0wUa5KY4cYrG4DjLvHzKoVJVFHaOfc7uqebrt+8v0L2rGVrqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555399; c=relaxed/simple;
	bh=EA5d/4A2l5wLgBk3SH06walSUOrhxLiDQrmc0QmtdGg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tlxOj67anDEnuMbGMy0U2zzwWMTqPJC3UnXCBVgzogeUzCJptR3ajo7MClU4A69YiIB4+WU45bpJq82jvy1G8RZSP78vxzfuz1RBJXXTxoFETRTZhZlpf0vn9MAHcaxPPR5G1GW+nRKiQn+EOIItsLTEik7V6WFwRWGywubgT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ih1XZfxy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ih1XZfxy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784555395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yL0zPmhiHRQNY/x400PGejjC8Zi7QJ9Np7M4CdFUkJs=;
	b=ih1XZfxyP20XxEXU5EqG6b1G/V0533TXfH1FNsgLQllCAfMzr8c3jrvyoB54Z5gMH/5msb
	tvg4i4amgGf7ptFOSnPHN7xqTkflDzDVD6ZSTg0r5269C0zwd9c9Jf3P4yeqKOgHLZC0uQ
	1bOKBebqOcXTLZQTB8m3r/0oyxXBg1E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-Ohg-RQtdML2Dg3OGDGd8xg-1; Mon,
 20 Jul 2026 09:49:44 -0400
X-MC-Unique: Ohg-RQtdML2Dg3OGDGd8xg-1
X-Mimecast-MFC-AGG-ID: Ohg-RQtdML2Dg3OGDGd8xg_1784555383
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F42E1955F03
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 13:49:43 +0000 (UTC)
Received: from akkohli-thinkpadt14sgen2i.rmtde.csb (unknown [10.44.33.215])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97076158C
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 13:49:42 +0000 (UTC)
From: Akhil Kohli <akkohli@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] semodule-utils: add bad-data tests for semodule_package
Date: Mon, 20 Jul 2026 15:49:40 +0200
Message-ID: <20260720134940.2192826-1-akkohli@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Add tests/bad-data/run.sh and fixtures for semodule_package bad-data
protection: input path validation for -m and -f (missing paths, directories,
broken symlinks, unreadable files, empty arguments) and malformed .mod.fc
content at packaging time. Wire the driver into semodule-utils make test.
Semantic validation of bad file contexts is deferred to sefcontext_compile.

Run the harness as a non-root user in GitHub Actions so unreadable -m/-f
inputs are exercised in CI. Semantic validation of bad file contexts is
deferred to sefcontext_compile

Signed-off-by: Akhil Kohli <akkohli@redhat.com>
---
 .github/workflows/run_tests.yml               |  10 +
 semodule-utils/Makefile                       |   1 +
 .../fixtures/file_contexts/bad_context.mod.fc |   1 +
 .../fixtures/file_contexts/bad_fields.mod.fc  |   1 +
 .../fixtures/file_contexts/good.mod.fc        |   1 +
 .../tests/bad-data/fixtures/modules/good.te   |   8 +
 semodule-utils/tests/bad-data/run.sh          | 344 ++++++++++++++++++
 7 files changed, 366 insertions(+)
 create mode 100644 semodule-utils/tests/bad-data/fixtures/file_contexts/bad_context.mod.fc
 create mode 100644 semodule-utils/tests/bad-data/fixtures/file_contexts/bad_fields.mod.fc
 create mode 100644 semodule-utils/tests/bad-data/fixtures/file_contexts/good.mod.fc
 create mode 100644 semodule-utils/tests/bad-data/fixtures/modules/good.te
 create mode 100755 semodule-utils/tests/bad-data/run.sh

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index f4aa1a4c..11b95a9c 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -82,6 +82,16 @@ jobs:
         eval make test $EXPLICIT_MAKE_VARS
         echo "::endgroup::"
 
+        # semodule_package bad-data: unreadable -m/-f inputs need non-root (root reads mode 000).
+        if [ "${{ matrix.python-ruby-version.other }}" != "sanitizers" ] ; then
+          echo "::group::semodule-utils bad-data (non-root)"
+          sudo useradd -m -s /usr/sbin/nologin bad-data-test 2>/dev/null || true
+          sudo runuser -u bad-data-test -- env PATH="$PATH" LD_LIBRARY_PATH="$LD_LIBRARY_PATH" \
+            ./semodule-utils/tests/bad-data/run.sh
+          sudo userdel -r bad-data-test 2>/dev/null || true
+          echo "::endgroup::"
+        fi
+
         if [ "${{ matrix.python-ruby-version.other }}" != "sanitizers" ] ; then
             # Test Python and Ruby wrappers
             echo "::group::Test Python and Ruby wrappers"
diff --git a/semodule-utils/Makefile b/semodule-utils/Makefile
index 81c97af0..4a902146 100644
--- a/semodule-utils/Makefile
+++ b/semodule-utils/Makefile
@@ -6,3 +6,4 @@ all install relabel clean:
 	done
 
 test:
+	./tests/bad-data/run.sh
diff --git a/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_context.mod.fc b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_context.mod.fc
new file mode 100644
index 00000000..06aec43e
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_context.mod.fc
@@ -0,0 +1 @@
+/usr/bin/bad	not_a_valid_selinux_context
diff --git a/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_fields.mod.fc b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_fields.mod.fc
new file mode 100644
index 00000000..13821d61
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_fields.mod.fc
@@ -0,0 +1 @@
+only_one_field_on_this_line
diff --git a/semodule-utils/tests/bad-data/fixtures/file_contexts/good.mod.fc b/semodule-utils/tests/bad-data/fixtures/file_contexts/good.mod.fc
new file mode 100644
index 00000000..12b26cae
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/file_contexts/good.mod.fc
@@ -0,0 +1 @@
+/usr/bin/test_good	--	system_u:object_r:test_good_exec_t:s0
diff --git a/semodule-utils/tests/bad-data/fixtures/modules/good.te b/semodule-utils/tests/bad-data/fixtures/modules/good.te
new file mode 100644
index 00000000..a079aed6
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/modules/good.te
@@ -0,0 +1,8 @@
+module test_good 1.0;
+
+require {
+	type test_good_t;
+	class file { read };
+}
+
+allow test_good_t self:file read;
diff --git a/semodule-utils/tests/bad-data/run.sh b/semodule-utils/tests/bad-data/run.sh
new file mode 100755
index 00000000..0456bb4f
--- /dev/null
+++ b/semodule-utils/tests/bad-data/run.sh
@@ -0,0 +1,344 @@
+#!/bin/sh
+#
+# Bad-data tests for semodule_package in the modular policy packaging pipeline.
+# Covers packaging path edge cases (-m/-f) and documents deferred rejection of bad
+# .mod.fc content (enforced later by sefcontext_compile on the Bucket D branch).
+# Unreadable -m/-f cases skip when run as root; CI runs this script as non-root.
+#
+
+set -u
+
+BASEDIR=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
+FIXTURES="${BASEDIR}/fixtures"
+OUTDIR=$(mktemp -d "${TMPDIR:-/tmp}/semodule-package-bad-data.XXXXXX")
+PASS=0
+FAIL=0
+
+CHECKMODULE=${CHECKMODULE:-checkmodule}
+# Modular TE for MCS/MLS builds (matches RHIVOS checkmodule -M -m).
+CHECKMODULE_MOD_FLAGS=${CHECKMODULE_MOD_FLAGS:--M -m}
+SEMODULE_PACKAGE=${SEMODULE_PACKAGE:-semodule_package}
+
+GOOD_TE="${FIXTURES}/modules/good.te"
+GOOD_MOD="${OUTDIR}/test_good.mod"
+
+cleanup() {
+	rm -rf "${OUTDIR}"
+}
+trap cleanup EXIT
+
+die() {
+	echo "FAIL: $*" >&2
+	FAIL=$((FAIL + 1))
+}
+
+pass() {
+	echo "==== $*"
+	PASS=$((PASS + 1))
+	echo ""
+}
+
+build_good_mod() {
+	echo "==== Setup: build control module ${GOOD_MOD} from good.te"
+	rm -f "${GOOD_MOD}"
+
+	set +e
+	# shellcheck disable=SC2086
+	"${CHECKMODULE}" ${CHECKMODULE_MOD_FLAGS} -o "${GOOD_MOD}" "${GOOD_TE}" \
+		2>"${OUTDIR}/build_good.err"
+	rc=$?
+	set -e
+
+	if [ "${rc}" -ne 0 ]; then
+		echo "FAIL: could not build control module from ${GOOD_TE}" >&2
+		cat "${OUTDIR}/build_good.err" >&2
+		exit 1
+	fi
+	if [ ! -s "${GOOD_MOD}" ]; then
+		echo "FAIL: ${GOOD_MOD} is empty" >&2
+		exit 1
+	fi
+	echo ""
+}
+
+expect_package_pass() {
+	desc="$1"
+	outname="$2"
+	shift 2
+
+	outpp="${OUTDIR}/${outname}.pp"
+	stderr="${OUTDIR}/${outname}.err"
+
+	echo "==== POSITIVE (expect semodule_package success): ${desc}"
+	rm -f "${outpp}"
+
+	set +e
+	"${SEMODULE_PACKAGE}" -o "${outpp}" "$@" 2>"${stderr}"
+	rc=$?
+	set -e
+
+	if [ "${rc}" -ne 0 ]; then
+		echo "stderr:" >&2
+		cat "${stderr}" >&2
+		die "${desc}: expected exit 0, got rc=${rc}"
+		return 0
+	fi
+	if [ ! -s "${outpp}" ]; then
+		die "${desc}: expected non-empty ${outpp}"
+		return 0
+	fi
+
+	pass "${desc} (exit 0, .pp created)"
+}
+
+expect_package_pass_deferred() {
+	desc="$1"
+	outname="$2"
+	shift 2
+
+	outpp="${OUTDIR}/${outname}.pp"
+	stderr="${OUTDIR}/${outname}.err"
+
+	echo "==== DOCUMENT (semodule_package accepts input; validate in sefcontext_compile): ${desc}"
+	rm -f "${outpp}"
+
+	set +e
+	"${SEMODULE_PACKAGE}" -o "${outpp}" "$@" 2>"${stderr}"
+	rc=$?
+	set -e
+
+	if [ "${rc}" -ne 0 ]; then
+		echo "stderr:" >&2
+		cat "${stderr}" >&2
+		die "${desc}: expected exit 0 at packaging stage, got rc=${rc}"
+		return 0
+	fi
+	if [ ! -s "${outpp}" ]; then
+		die "${desc}: expected non-empty ${outpp} at packaging stage"
+		return 0
+	fi
+
+	pass "${desc} (packaging exit 0; labeling validation deferred to sefcontext_compile)"
+}
+
+expect_package_fail() {
+	desc="$1"
+	pattern="$2"
+	outname="$3"
+	shift 3
+
+	outpp="${OUTDIR}/${outname}.pp"
+	stderr="${OUTDIR}/${outname}.err"
+
+	echo "==== NEGATIVE (expect semodule_package failure): ${desc}"
+	rm -f "${outpp}"
+
+	set +e
+	"${SEMODULE_PACKAGE}" -o "${outpp}" "$@" 2>"${stderr}"
+	rc=$?
+	set -e
+
+	if [ "${rc}" -eq 0 ]; then
+		die "${desc}: expected non-zero exit, got rc=0"
+		return 0
+	fi
+	if [ -f "${outpp}" ]; then
+		die "${desc}: did not expect output ${outpp}"
+		return 0
+	fi
+	if ! grep -Eq "${pattern}" "${stderr}"; then
+		echo "FAIL: stderr did not match /${pattern}/" >&2
+		cat "${stderr}" >&2
+		FAIL=$((FAIL + 1))
+		return 0
+	fi
+
+	pass "${desc} (rejected as expected, rc=${rc})"
+}
+
+expect_package_fail_unreadable() {
+	desc="unreadable -m file"
+	mod="${OUTDIR}/unreadable.mod"
+	outpp="${OUTDIR}/unreadable.pp"
+	stderr="${OUTDIR}/unreadable.err"
+
+	echo "==== NEGATIVE (expect semodule_package failure): ${desc}"
+	if [ "$(id -u)" -eq 0 ]; then
+		echo "SKIP: root can read mode 000 files; unreadable check is non-root only"
+		PASS=$((PASS + 1))
+		echo ""
+		return 0
+	fi
+
+	rm -f "${outpp}"
+	cp "${GOOD_MOD}" "${mod}"
+	chmod 000 "${mod}"
+
+	set +e
+	"${SEMODULE_PACKAGE}" -o "${outpp}" -m "${mod}" 2>"${stderr}"
+	rc=$?
+	set -e
+
+	if [ "${rc}" -eq 0 ]; then
+		die "${desc}: expected non-zero exit, got rc=0"
+		return 0
+	fi
+	if [ -f "${outpp}" ]; then
+		die "${desc}: did not expect output ${outpp}"
+		return 0
+	fi
+	if ! grep -Eq 'Permission denied|Could not open|Failed to open' "${stderr}"; then
+		echo "FAIL: stderr did not mention permission or open failure" >&2
+		cat "${stderr}" >&2
+		FAIL=$((FAIL + 1))
+		return 0
+	fi
+
+	pass "${desc} (rejected as expected, rc=${rc})"
+}
+
+expect_package_fail_unreadable_fc() {
+	desc="unreadable -f file"
+	fc="${OUTDIR}/unreadable.mod.fc"
+	outpp="${OUTDIR}/unreadable_fc.pp"
+	stderr="${OUTDIR}/unreadable_fc.err"
+
+	echo "==== NEGATIVE (expect semodule_package failure): ${desc}"
+	if [ "$(id -u)" -eq 0 ]; then
+		echo "SKIP: root can read mode 000 files; unreadable check is non-root only"
+		PASS=$((PASS + 1))
+		echo ""
+		return 0
+	fi
+
+	rm -f "${outpp}"
+	cp "${GOOD_FC}" "${fc}"
+	chmod 000 "${fc}"
+
+	set +e
+	"${SEMODULE_PACKAGE}" -o "${outpp}" -m "${GOOD_MOD}" -f "${fc}" \
+		2>"${stderr}"
+	rc=$?
+	set -e
+
+	if [ "${rc}" -eq 0 ]; then
+		die "${desc}: expected non-zero exit, got rc=0"
+		return 0
+	fi
+	if [ -f "${outpp}" ]; then
+		die "${desc}: did not expect output ${outpp}"
+		return 0
+	fi
+	if ! grep -Eq 'Permission denied|Could not open|Failed to open' "${stderr}"; then
+		echo "FAIL: stderr did not mention permission or open failure" >&2
+		cat "${stderr}" >&2
+		FAIL=$((FAIL + 1))
+		return 0
+	fi
+
+	pass "${desc} (rejected as expected, rc=${rc})"
+}
+
+build_good_mod
+
+# Ephemeral path fixtures for packaging path tests.
+ln -sf /nonexistent/test_good.mod "${OUTDIR}/broken_symlink.mod"
+ln -sf /nonexistent/test_good.mod.fc "${OUTDIR}/broken_symlink.mod.fc"
+printf '' > "${OUTDIR}/empty.mod.fc"
+
+# NUL byte inside path column (packaging accepts; sefcontext_compile rejects).
+printf '/bin/foo\x00bar\t--\tsystem_u:object_r:test_good_exec_t:s0\n' \
+	> "${OUTDIR}/nul_bytes.mod.fc"
+
+GOOD_FC="${FIXTURES}/file_contexts/good.mod.fc"
+
+# --- semodule_package input paths ---
+expect_package_pass \
+	"control good .mod without file contexts" \
+	good_mod \
+	-m "${GOOD_MOD}"
+
+expect_package_pass \
+	"control good .mod with good .mod.fc" \
+	good_mod_fc \
+	-m "${GOOD_MOD}" -f "${GOOD_FC}"
+
+expect_package_fail \
+	"missing -m path" \
+	"Could not open|Failed to open" \
+	missing_mod \
+	-m "${OUTDIR}/does_not_exist.mod"
+
+expect_package_fail \
+	"missing -f path" \
+	"Failed to open|Could not open" \
+	missing_fc \
+	-m "${GOOD_MOD}" -f "${OUTDIR}/does_not_exist.mod.fc"
+
+expect_package_fail \
+	"directory instead of -m file" \
+	"Error while reading policy module|Could not open" \
+	directory_mod \
+	-m "${BASEDIR}"
+
+expect_package_fail \
+	"broken symlink for -m" \
+	"Could not open|Failed to open|No such file" \
+	symlink_mod \
+	-m "${OUTDIR}/broken_symlink.mod"
+
+expect_package_fail_unreadable
+
+expect_package_fail \
+	"empty -m path argument" \
+	"Could not open|Failed to open" \
+	empty_mod \
+	-m ""
+
+expect_package_fail \
+	"directory instead of -f file" \
+	"Permission denied|Failed to mmap|Failed to open|Could not open" \
+	directory_fc \
+	-m "${GOOD_MOD}" -f "${BASEDIR}"
+
+expect_package_fail \
+	"broken symlink for -f" \
+	"Could not open|Failed to open|No such file" \
+	symlink_fc \
+	-m "${GOOD_MOD}" -f "${OUTDIR}/broken_symlink.mod.fc"
+
+expect_package_fail_unreadable_fc
+
+expect_package_fail \
+	"empty -f path argument" \
+	"Could not open|Failed to open" \
+	empty_fc_arg \
+	-m "${GOOD_MOD}" -f ""
+
+# --- bad .mod.fc at packaging time ---
+expect_package_pass_deferred \
+	"invalid SELinux context in .mod.fc" \
+	bad_context \
+	-m "${GOOD_MOD}" -f "${FIXTURES}/file_contexts/bad_context.mod.fc"
+
+expect_package_pass_deferred \
+	"wrong field count in .mod.fc" \
+	bad_fields \
+	-m "${GOOD_MOD}" -f "${FIXTURES}/file_contexts/bad_fields.mod.fc"
+
+expect_package_pass_deferred \
+	"NUL byte in .mod.fc path field" \
+	nul_bytes \
+	-m "${GOOD_MOD}" -f "${OUTDIR}/nul_bytes.mod.fc"
+
+expect_package_pass_deferred \
+	"empty .mod.fc file" \
+	empty_fc \
+	-m "${GOOD_MOD}" -f "${OUTDIR}/empty.mod.fc"
+
+echo "========================================"
+echo "Results: ${PASS} passed, ${FAIL} failed"
+if [ "${FAIL}" -ne 0 ]; then
+	exit 1
+fi
+exit 0
-- 
2.55.0

