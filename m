Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5738B123
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165931; cv=none; b=V8+LeMZ0rP3cMZx6AjRKjmSsrCFdBda7Q+pFw9hLJFcQOt+iDfHQEc7c7eKesRnWFJVSoEvp4BwcWwawibkVjDEAVzFzgZq6J2zopbFKQmlL8KuracD+r3sV9cTxjcV2rHEKaPAKPa0fwECGY1zx+L5tk2qgcPzev2aW+S6UW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165931; c=relaxed/simple;
	bh=vy+6+G85/W9GHYnoyVsFNAjYDq453kp2bJZDBGnIHnE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWClxOLAFeeSfyx+Lc5S716cGLb9gR1RcTibwmJcSqzRWzW+uMYkvrOoodH+koK/XpZUmgPn9EDLmTz/bcfBOH/1OfLSEni5mSlKDFkdikUtA8C5LbgnKdiu3zjdyDyS/ZWQq/eGKjpSOzjnbi/8LutgsQyodJFAdbH6eO68Fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aemiliYb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aemiliYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785165929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqihcZPaYG1Mh2GjrECcBHEu1uFGRggRbdf1g6AYH2Q=;
	b=aemiliYbgbZWci3grJBZ3oCflWsfC8Kske23TSX59KNZUEZV9zNPyBqb8skDrsbqgEom4i
	+sn4OCcTTR0qmbXA02ykdXHhNpKlWPz4f3fLKH5QFotLyjQ1W0H1tV/g32DQE2Ocp/YYTa
	0BYON8hg9rFrbvwMvcmeJ/9NvoPqdi0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-jMU_4s40MMqACtOvx669pQ-1; Mon,
 27 Jul 2026 11:25:25 -0400
X-MC-Unique: jMU_4s40MMqACtOvx669pQ-1
X-Mimecast-MFC-AGG-ID: jMU_4s40MMqACtOvx669pQ_1785165924
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B35FA180075D
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 15:25:24 +0000 (UTC)
Received: from akkohli-thinkpadt14sgen2i.rmtde.csb (unknown [10.44.33.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C778A18001E6
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 15:25:23 +0000 (UTC)
From: Akhil Kohli <akkohli@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/2] checkpolicy: add robustness tests for large policy inputs
Date: Mon, 27 Jul 2026 17:25:17 +0200
Message-ID: <20260727152518.2495266-3-akkohli@redhat.com>
In-Reply-To: <20260727152518.2495266-1-akkohli@redhat.com>
References: <20260727152518.2495266-1-akkohli@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add expect_robust to the checkmodule negative harness so oversized
generated .te and .conf sources are exercised without crashing or
hanging. Also cover a module with a large attribute membership set.

Fixtures are generated at runtime to keep the repository small. Test
size is tunable via LARGE_TE_ALLOWS, LARGE_CONF_ALLOWS,
HUGE_ATTR_TYPES, and BAD_DATA_STRESS.

Also fix expect_* to return 0 after counting a failure so set -e
does not stop the suite early. Same bug affected the older cases;
exit status is still non-zero when FAIL != 0.

Signed-off-by: Akhil Kohli <akkohli@redhat.com>
---
 .../tests/test_checkmodule_negative.sh        | 178 +++++++++++++++++-
 1 file changed, 170 insertions(+), 8 deletions(-)

diff --git a/checkpolicy/tests/test_checkmodule_negative.sh b/checkpolicy/tests/test_checkmodule_negative.sh
index 6d289a4c..ed7202f5 100755
--- a/checkpolicy/tests/test_checkmodule_negative.sh
+++ b/checkpolicy/tests/test_checkmodule_negative.sh
@@ -3,16 +3,30 @@
 # Negative / bad-data tests for checkmodule on module (.te) inputs.
 # Matches the modular policy compile path: checkmodule -M -m <input> -o <module>.mod
 #
+# §11 size / resource limits: generated fixtures; scale via LARGE_TE_ALLOWS,
+# LARGE_CONF_ALLOWS, HUGE_ATTR_TYPES, or BAD_DATA_STRESS=1 for heavier runs.
+#
 
 set -eu
 
 BASEDIR=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
 NEGDIR="${BASEDIR}/negative"
 CHECKMODULE="${BASEDIR}/../checkmodule"
+CHECKPOLICY="${BASEDIR}/../checkpolicy"
 OUTDIR=$(mktemp -d "${TMPDIR:-/tmp}/checkmodule-negative.XXXXXX")
 PASS=0
 FAIL=0
 
+LARGE_TE_ALLOWS="${LARGE_TE_ALLOWS:-5000}"
+LARGE_CONF_ALLOWS="${LARGE_CONF_ALLOWS:-5000}"
+HUGE_ATTR_TYPES="${HUGE_ATTR_TYPES:-2000}"
+
+if [ "${BAD_DATA_STRESS:-0}" = "1" ]; then
+	LARGE_TE_ALLOWS=10000
+	LARGE_CONF_ALLOWS=10000
+	HUGE_ATTR_TYPES=5000
+fi
+
 cleanup() {
 	rm -rf "${OUTDIR}"
 }
@@ -41,12 +55,12 @@ expect_pass() {
 		echo "FAIL: expected success (rc=0), got rc=${rc}" >&2
 		cat "${stderr}" >&2
 		FAIL=$((FAIL + 1))
-		return 1
+		return 0
 	fi
 	if [ ! -s "${outmod}" ]; then
 		echo "FAIL: expected non-empty ${outmod}" >&2
 		FAIL=$((FAIL + 1))
-		return 1
+		return 0
 	fi
 
 	echo "==== ${desc} success"
@@ -74,18 +88,18 @@ expect_fail() {
 	if [ "${rc}" -eq 0 ]; then
 		echo "FAIL: expected non-zero exit, got rc=0" >&2
 		FAIL=$((FAIL + 1))
-		return 1
+		return 0
 	fi
 	if [ -f "${outmod}" ]; then
 		echo "FAIL: did not expect output module ${outmod}" >&2
 		FAIL=$((FAIL + 1))
-		return 1
+		return 0
 	fi
 	if ! grep -Eq "${pattern}" "${stderr}"; then
 		echo "FAIL: stderr did not match /${pattern}/" >&2
 		cat "${stderr}" >&2
 		FAIL=$((FAIL + 1))
-		return 1
+		return 0
 	fi
 
 	echo "==== ${desc}: rejected as expected"
@@ -117,18 +131,18 @@ expect_fail_unreadable() {
 	if [ "${rc}" -eq 0 ]; then
 		echo "FAIL: expected non-zero exit, got rc=0" >&2
 		FAIL=$((FAIL + 1))
-		return 1
+		return 0
 	fi
 	if [ -f "${outmod}" ]; then
 		echo "FAIL: did not expect output module ${outmod}" >&2
 		FAIL=$((FAIL + 1))
-		return 1
+		return 0
 	fi
 	if ! grep -Eq 'unable to open|Permission denied' "${stderr}"; then
 		echo "FAIL: stderr did not mention unable to open or Permission denied" >&2
 		cat "${stderr}" >&2
 		FAIL=$((FAIL + 1))
-		return 1
+		return 0
 	fi
 
 	echo "==== ${desc}: rejected as expected"
@@ -136,6 +150,138 @@ expect_fail_unreadable() {
 	echo ""
 }
 
+robust_exit_is_crash() {
+	rc="$1"
+
+	# Fatal signals: SEGV (139), ABRT (134), ILL (132), BUS (135), FPE (136).
+	case "${rc}" in
+	132|134|135|136|139)
+		return 0
+		;;
+	esac
+	return 1
+}
+
+expect_robust() {
+	desc="$1"
+	timeout_sec="$2"
+	outartifact="$3"
+	shift 3
+
+	tag=$(echo "${desc}" | tr ' /.' '___')
+	stderr="${OUTDIR}/${tag}.err"
+
+	echo "==== ROBUST (expect no crash/hang): ${desc}"
+	rm -f "${outartifact}"
+
+	if ! command -v timeout >/dev/null 2>&1; then
+		echo "FAIL: timeout(1) required for robustness tests" >&2
+		FAIL=$((FAIL + 1))
+		return 0
+	fi
+
+	set +e
+	timeout "${timeout_sec}" "$@" 2>"${stderr}"
+	rc=$?
+	set -e
+
+	if [ "${rc}" -eq 124 ]; then
+		echo "FAIL: timed out after ${timeout_sec}s" >&2
+		FAIL=$((FAIL + 1))
+		return 0
+	fi
+	if robust_exit_is_crash "${rc}"; then
+		echo "FAIL: crashed with rc=${rc}" >&2
+		cat "${stderr}" >&2
+		FAIL=$((FAIL + 1))
+		return 0
+	fi
+	if [ "${rc}" -eq 0 ]; then
+		if [ ! -s "${outartifact}" ]; then
+			echo "FAIL: expected non-empty ${outartifact} on success" >&2
+			cat "${stderr}" >&2
+			FAIL=$((FAIL + 1))
+			return 0
+		fi
+		echo "==== ${desc}: finished (rc=0, output produced)"
+	else
+		if [ -f "${outartifact}" ]; then
+			echo "FAIL: did not expect output ${outartifact} on rc=${rc}" >&2
+			cat "${stderr}" >&2
+			FAIL=$((FAIL + 1))
+			return 0
+		fi
+		echo "==== ${desc}: finished safely (rc=${rc}, no output)"
+	fi
+	PASS=$((PASS + 1))
+	echo ""
+}
+
+generate_large_module_te() {
+	outte="$1"
+	count="$2"
+
+	{
+		echo 'module large_module 1.0;'
+		echo 'require {'
+		echo '	type a_t, b_t;'
+		echo '	class file { read };'
+		echo '}'
+		i=0
+		while [ "${i}" -lt "${count}" ]; do
+			echo 'allow a_t b_t:file read;'
+			i=$((i + 1))
+		done
+	} > "${outte}"
+}
+
+generate_large_conf() {
+	outconf="$1"
+	count="$2"
+
+	{
+		echo '# handle_unknown deny'
+		echo 'class CLASS1'
+		echo 'sid kernel'
+		echo 'class CLASS1 { PERM1 }'
+		echo 'type TYPE1;'
+		echo 'type TYPE2;'
+		i=0
+		while [ "${i}" -lt "${count}" ]; do
+			echo 'allow TYPE1 TYPE2:CLASS1 { PERM1 };'
+			i=$((i + 1))
+		done
+		echo 'role ROLE1;'
+		echo 'role ROLE1 types { TYPE1 };'
+		echo 'user USER1 roles { ROLE1 };'
+		echo 'sid kernel USER1:ROLE1:TYPE1'
+	} > "${outconf}"
+}
+
+generate_huge_attr_te() {
+	outte="$1"
+	count="$2"
+
+	{
+		echo 'module huge_attr 1.0;'
+		echo 'require {'
+		echo '	class file { read };'
+		i=0
+		while [ "${i}" -lt "${count}" ]; do
+			echo "	type a${i}_t;"
+			i=$((i + 1))
+		done
+		echo '}'
+		echo 'attribute big_attr;'
+		i=0
+		while [ "${i}" -lt "${count}" ]; do
+			echo "typeattribute a${i}_t big_attr;"
+			i=$((i + 1))
+		done
+		echo 'allow a0_t a1_t:file read;'
+	} > "${outte}"
+}
+
 # Ephemeral fixtures for path-based cases.
 ln -sf /nonexistent/path "${OUTDIR}/broken_symlink.te"
 cat > "${OUTDIR}/unreadable.te" <<'EOF'
@@ -181,6 +327,22 @@ expect_fail "checkmodule with no input file" "unable to open policy.conf" "no_in
 expect_fail "checkmodule -o name mismatch" "Module name good_module is different" "name_mismatch" \
 	-o "${OUTDIR}/wrong_name.mod" "${NEGDIR}/good_module.te"
 
+# §11 size / resource limits (hypothesis §6 item 11).
+generate_large_module_te "${OUTDIR}/large_module.te" "${LARGE_TE_ALLOWS}"
+expect_robust "11.1 very large .te module (${LARGE_TE_ALLOWS} allow rules)" 120 \
+	"${OUTDIR}/large_module.mod" \
+	"${CHECKMODULE}" -M -m -o "${OUTDIR}/large_module.mod" "${OUTDIR}/large_module.te"
+
+generate_large_conf "${OUTDIR}/large.conf" "${LARGE_CONF_ALLOWS}"
+expect_robust "11.1 very large .conf policy (${LARGE_CONF_ALLOWS} allow rules)" 120 \
+	"${OUTDIR}/large.bin" \
+	"${CHECKPOLICY}" -E -o "${OUTDIR}/large.bin" "${OUTDIR}/large.conf"
+
+generate_huge_attr_te "${OUTDIR}/huge_attr.te" "${HUGE_ATTR_TYPES}"
+expect_robust "11.2 huge attribute set (${HUGE_ATTR_TYPES} types)" 120 \
+	"${OUTDIR}/huge_attr.mod" \
+	"${CHECKMODULE}" -M -m -o "${OUTDIR}/huge_attr.mod" "${OUTDIR}/huge_attr.te"
+
 echo "checkmodule negative tests: ${PASS} passed, ${FAIL} failed"
 if [ "${FAIL}" -ne 0 ]; then
 	exit 1
-- 
2.55.0

