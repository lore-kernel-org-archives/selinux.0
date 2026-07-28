Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B334143A7E9
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244215; cv=none; b=oVH6vyMSPdWn6ImDgxL4vUO8jZY9zM9h0yJnpp8CCS0sIstSkPeSxeP+ET93j2SQsfM5iM/hjvuSginwyUMDdEspbrFgFh9aDvNMOcK87ydPpaDHFrZXgLU9iqf7Y6R1Ai5Sgq2dbcx8n7e/HwJqH6yMskK3YAA1o+sH47ESUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244215; c=relaxed/simple;
	bh=tVND82L0rN5cPtG1aZRkaVJauzU3CPHYKcUBWSeEN5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uLElc0WwWkxeCr0JjEF5WuiS6eF1XBVabNkF9Va9bHC4fgtu/zYIm/0YTDYXBebTD9R3l+tNmnZfuwjzPayjFykezIHIke0JcQmA6QKfAgff2glWIIqYd/ZqsSKmNlXrCr8DL10uTvVAaJbc3boV4GJdEdf7cYbwFMyc3sXSDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXgaO9H+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXgaO9H+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785244212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8RTWWOzBqrIKSnbSC+yglDgPuB8XrjBV5TrKTlFuGGw=;
	b=gXgaO9H+t4FG2PXzM3YMw17WnDktAoVR8E0OZd5n97Qyh4axBEfy8zlVNOkDFjr3NzC7xW
	ZP0R+KXeDszlbOL6i1BtRXNCCEas+GZ4ZlGZ0TJDPztybk4OZsEbBTuwBXB2tgZaoo0ajR
	S+VkdqfNc4KsZYI7I6ELerCD3dmtwXk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-el5PnW2dPi6oC874abhdog-1; Tue,
 28 Jul 2026 09:10:11 -0400
X-MC-Unique: el5PnW2dPi6oC874abhdog-1
X-Mimecast-MFC-AGG-ID: el5PnW2dPi6oC874abhdog_1785244210
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 343701956061
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 13:10:10 +0000 (UTC)
Received: from akkohli-thinkpadt14sgen2i.rmtde.csb (unknown [10.44.33.215])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C507414
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 13:10:09 +0000 (UTC)
From: Akhil Kohli <akkohli@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] semodule-utils: add bad-data tests for sefcontext_compile
Date: Tue, 28 Jul 2026 15:10:07 +0200
Message-ID: <20260728131007.2588686-1-akkohli@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Extend the bad-data harness to validate file contexts after packaging:
wrong field count and NUL bytes are rejected by sefcontext_compile, invalid
contexts are rejected with -p, and unpackage'd .pp file contexts are
checked the same way.

Adds 7 sefcontext_compile test steps on top of the semodule_package
harness. Adds bad_mls.mod.fc fixture. Preserve errexit restoration
(set -e after rc=$?) in shared helpers.

Signed-off-by: Akhil Kohli <akkohli@redhat.com>
---
 .../fixtures/file_contexts/bad_mls.mod.fc     |   1 +
 semodule-utils/tests/bad-data/run.sh          | 227 +++++++++++++++++-
 2 files changed, 223 insertions(+), 5 deletions(-)
 create mode 100644 semodule-utils/tests/bad-data/fixtures/file_contexts/bad_mls.mod.fc

diff --git a/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_mls.mod.fc b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_mls.mod.fc
new file mode 100644
index 00000000..1913faaa
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_mls.mod.fc
@@ -0,0 +1 @@
+/usr/bin/bad_mls	--	system_u:object_r:test_good_exec_t:s0:c999
diff --git a/semodule-utils/tests/bad-data/run.sh b/semodule-utils/tests/bad-data/run.sh
index 7c9f7c7d..1c7d8f51 100755
--- a/semodule-utils/tests/bad-data/run.sh
+++ b/semodule-utils/tests/bad-data/run.sh
@@ -1,9 +1,10 @@
 #!/bin/sh
 #
-# Bad-data tests for semodule_package in the modular policy packaging pipeline.
-# Covers packaging path edge cases (-m/-f) and documents deferred rejection of bad
-# .mod.fc content (enforced later by sefcontext_compile).
-# Unreadable -m/-f cases skip when run as root; CI runs this script as non-root.
+# Bad-data tests for semodule_package and sefcontext_compile in the modular
+# policy packaging pipeline. Covers packaging path edge cases (-m/-f), documents
+# deferred rejection of bad .mod.fc content at packaging time, and validates
+# labeling through sefcontext_compile. Unreadable -m/-f cases skip when run as
+# root; CI runs this script as non-root.
 #
 
 set -u
@@ -29,6 +30,8 @@ CHECKMODULE=${CHECKMODULE:-checkmodule}
 # Modular TE for MCS/MLS builds (checkmodule -M -m).
 CHECKMODULE_MOD_FLAGS=${CHECKMODULE_MOD_FLAGS:--M -m}
 SEMODULE_PACKAGE=${SEMODULE_PACKAGE:-semodule_package}
+SEMODULE_UNPACKAGE=${SEMODULE_UNPACKAGE:-semodule_unpackage}
+SEFCONTEXT_COMPILE=${SEFCONTEXT_COMPILE:-sefcontext_compile}
 
 GOOD_TE="${FIXTURES}/modules/good.te"
 GOOD_MOD="${OUTDIR}/test_good.mod"
@@ -250,6 +253,161 @@ expect_package_fail_unreadable_fc() {
 	pass "${desc} (rejected as expected, rc=${rc})"
 }
 
+find_policy_file() {
+	if [ -n "${POLICY_FILE:-}" ] && [ -f "${POLICY_FILE}" ]; then
+		echo "${POLICY_FILE}"
+		return 0
+	fi
+
+	# Prefer the active policy store (SELINUXTYPE); fall back to targeted, then any
+	# installed policy.* (POLICY_FILE overrides all of this).
+	selinuxtype=targeted
+	if [ -r /etc/selinux/config ]; then
+		selinuxtype=$(grep -E '^[[:space:]]*SELINUXTYPE=' /etc/selinux/config 2>/dev/null \
+			| tail -1 | cut -d= -f2- | tr -d ' "')
+		[ -n "${selinuxtype}" ] || selinuxtype=targeted
+	fi
+
+	# shellcheck disable=SC2086
+	set -- /etc/selinux/"${selinuxtype}"/policy/policy.*
+	if [ -f "$1" ]; then
+		echo "$1"
+		return 0
+	fi
+
+	for policy in /etc/selinux/*/policy/policy.*; do
+		[ -f "${policy}" ] || continue
+		echo "${policy}"
+		return 0
+	done
+
+	return 1
+}
+
+expect_sefcontext_pass() {
+	desc="$1"
+	outname="$2"
+	fc="$3"
+	policy="${4:-}"
+
+	outbin="${OUTDIR}/${outname}.bin"
+	stderr="${OUTDIR}/${outname}.err"
+
+	echo "==== POSITIVE (expect sefcontext_compile success): ${desc}"
+	rm -f "${outbin}"
+
+	set +e
+	if [ -n "${policy}" ]; then
+		"${SEFCONTEXT_COMPILE}" -p "${policy}" -o "${outbin}" "${fc}" \
+			2>"${stderr}"
+	else
+		"${SEFCONTEXT_COMPILE}" -o "${outbin}" "${fc}" 2>"${stderr}"
+	fi
+	rc=$?
+	set -e
+
+	if [ "${rc}" -ne 0 ]; then
+		cat "${stderr}" >&2
+		die "${desc}: expected exit 0, got rc=${rc}"
+		return 0
+	fi
+	if [ ! -s "${outbin}" ]; then
+		die "${desc}: expected non-empty ${outbin}"
+		return 0
+	fi
+
+	pass "${desc} (sefcontext_compile succeeded)"
+}
+
+expect_sefcontext_fail() {
+	desc="$1"
+	pattern="$2"
+	outname="$3"
+	fc="$4"
+	policy="${5:-}"
+
+	outbin="${OUTDIR}/${outname}.bin"
+	stderr="${OUTDIR}/${outname}.err"
+
+	echo "==== NEGATIVE (expect sefcontext_compile failure): ${desc}"
+	rm -f "${outbin}"
+
+	set +e
+	if [ -n "${policy}" ]; then
+		"${SEFCONTEXT_COMPILE}" -p "${policy}" -o "${outbin}" "${fc}" \
+			2>"${stderr}"
+	else
+		"${SEFCONTEXT_COMPILE}" -o "${outbin}" "${fc}" 2>"${stderr}"
+	fi
+	rc=$?
+	set -e
+
+	if [ "${rc}" -eq 0 ]; then
+		die "${desc}: expected non-zero exit, got rc=0"
+		return 0
+	fi
+	if [ -f "${outbin}" ] && [ -s "${outbin}" ]; then
+		die "${desc}: did not expect successful ${outbin}"
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
+expect_sefcontext_fail_or_skip_no_policy() {
+	desc="$1"
+	pattern="$2"
+	outname="$3"
+	fc="$4"
+
+	policy=$(find_policy_file) || policy=
+	if [ -z "${policy}" ]; then
+		echo "==== SKIP (no binary policy for -p validation): ${desc}"
+		echo "Set POLICY_FILE= to enable this check."
+		PASS=$((PASS + 1))
+		echo ""
+		return 0
+	fi
+
+	expect_sefcontext_fail "${desc}" "${pattern}" "${outname}" "${fc}" \
+		"${policy}"
+}
+
+expect_sefcontext_pass_deferred() {
+	desc="$1"
+	outname="$2"
+	fc="$3"
+
+	outbin="${OUTDIR}/${outname}.bin"
+	stderr="${OUTDIR}/${outname}.err"
+
+	echo "==== DOCUMENT (sefcontext_compile accepts input; complements packaging deferral): ${desc}"
+	rm -f "${outbin}"
+
+	set +e
+	"${SEFCONTEXT_COMPILE}" -o "${outbin}" "${fc}" 2>"${stderr}"
+	rc=$?
+	set -e
+
+	if [ "${rc}" -ne 0 ]; then
+		cat "${stderr}" >&2
+		die "${desc}: expected exit 0 at compile stage, got rc=${rc}"
+		return 0
+	fi
+	if [ ! -s "${outbin}" ]; then
+		die "${desc}: expected non-empty ${outbin} at compile stage"
+		return 0
+	fi
+
+	pass "${desc} (sefcontext_compile exit 0; complements packaging deferral)"
+}
+
 build_good_mod
 
 # Ephemeral path fixtures for packaging path tests.
@@ -258,7 +416,7 @@ ln -sf /nonexistent/test_good.mod.fc "${OUTDIR}/broken_symlink.mod.fc"
 printf '' > "${OUTDIR}/empty.mod.fc"
 
 # NUL byte inside path column (packaging accepts; sefcontext_compile rejects).
-printf '/bin/foo\x00bar\t--\tsystem_u:object_r:test_good_exec_t:s0\n' \
+printf '/bin/foo\000bar\t--\tsystem_u:object_r:test_good_exec_t:s0\n' \
 	> "${OUTDIR}/nul_bytes.mod.fc"
 
 GOOD_FC="${FIXTURES}/file_contexts/good.mod.fc"
@@ -347,6 +505,65 @@ expect_package_pass_deferred \
 	empty_fc \
 	-m "${GOOD_MOD}" -f "${OUTDIR}/empty.mod.fc"
 
+# --- sefcontext_compile / unpackage validation ---
+expect_sefcontext_pass \
+	"control good .mod.fc through sefcontext_compile" \
+	good_fc \
+	"${GOOD_FC}"
+
+expect_sefcontext_fail \
+	"wrong field count in .mod.fc (after packaging)" \
+	"missing fields|process_file failed" \
+	sefcontext_bad_fields \
+	"${FIXTURES}/file_contexts/bad_fields.mod.fc"
+
+expect_sefcontext_fail \
+	"NUL byte in .mod.fc path field (after packaging)" \
+	"missing fields|process_file failed" \
+	sefcontext_nul_bytes \
+	"${OUTDIR}/nul_bytes.mod.fc"
+
+expect_sefcontext_fail_or_skip_no_policy \
+	"invalid SELinux context requires policy validation (-p)" \
+	"invalid context|malformed context|process_file failed" \
+	sefcontext_bad_context \
+	"${FIXTURES}/file_contexts/bad_context.mod.fc"
+
+expect_sefcontext_pass_deferred \
+	"empty .mod.fc file through sefcontext_compile" \
+	sefcontext_empty_fc \
+	"${OUTDIR}/empty.mod.fc"
+
+expect_sefcontext_fail_or_skip_no_policy \
+	"invalid MLS context requires policy validation (-p)" \
+	"invalid context|malformed context|process_file failed" \
+	sefcontext_bad_mls \
+	"${FIXTURES}/file_contexts/bad_mls.mod.fc"
+
+BAD_PP="${OUTDIR}/bad_context.pp"
+EXTRACTED_MOD="${OUTDIR}/extracted.mod"
+EXTRACTED_FC="${OUTDIR}/extracted.fc"
+
+echo "==== Setup: extract file contexts from packaged module with invalid context"
+rm -f "${EXTRACTED_MOD}" "${EXTRACTED_FC}"
+set +e
+"${SEMODULE_UNPACKAGE}" "${BAD_PP}" "${EXTRACTED_MOD}" "${EXTRACTED_FC}" \
+	2>"${OUTDIR}/unpackage.err"
+rc=$?
+set -e
+if [ "${rc}" -ne 0 ] || [ ! -s "${EXTRACTED_FC}" ]; then
+	die "unpackage setup: could not extract .fc from ${BAD_PP}"
+	cat "${OUTDIR}/unpackage.err" >&2
+else
+	echo "==== unpackage setup succeeded"
+	echo ""
+	expect_sefcontext_fail_or_skip_no_policy \
+		"invalid context from unpackage'd .pp file contexts" \
+		"invalid context|malformed context|process_file failed" \
+		unpackaged_bad_context \
+		"${EXTRACTED_FC}"
+fi
+
 echo "========================================"
 echo "Results: ${PASS} passed, ${FAIL} failed"
 if [ "${FAIL}" -ne 0 ]; then
-- 
2.55.0

