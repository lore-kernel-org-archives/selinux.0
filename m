Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A041643B
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415381; cv=none; b=LtVqi+B8ptvGJmcPNyICt7NiIMhanbuUqaSsWVolsmC/c+qh6PYJXXI+PouEKoIDWTQc/KgkNFULjWpbIw5263FQPbvW4wCFs0qJaPqAL6OHW1uebCdNJOq06wdbfHPW/PURuVwhoyZ4KYfF3CJCudZ//qPm6TmKo9v64KccAC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415381; c=relaxed/simple;
	bh=xMWhgcPT3kvZpk6AY+UyEbhwP6pGLxGus03D7BK9Dog=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A9E70XEKt8JluAtsR03ztztvMAVIh9UsEBiOBZ325NpjBRls2IPXIwaFzR2R14ojj+4B32opguiuglqAiRnPmwZHHF3TZWV9ZFCUqhF6k0xjGhZlgjUz4Z9skscDSvy++PvkanAhsYrQ4kSG0aVKE+Oj4ZuEbNT3RORhaaNRt/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVE56CB+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVE56CB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785415378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0iXZAo5NgDdckQMxBHenlr7jlIpTsEIDEd1IZbRmCL0=;
	b=DVE56CB+kZ0TEAuWQ4Ri8eqeVbE5dSf2BPG4M12AchkeqgX8n5ReTi22vPdah20zFjWP/P
	8RokbXNFlTeQ9lVzIsxAa3UmXYghLuefVyTGakvTi+HFcOVOd9XQ9HangrcCz0QqTtOjt2
	vgqbNmaw01bLRBqx+mKAGA7vIROStUU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-BVBZcp2GNZq_Fx8-7fggKA-1; Thu,
 30 Jul 2026 08:42:56 -0400
X-MC-Unique: BVBZcp2GNZq_Fx8-7fggKA-1
X-Mimecast-MFC-AGG-ID: BVBZcp2GNZq_Fx8-7fggKA_1785415376
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0BCC1944D31
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 12:42:55 +0000 (UTC)
Received: from akkohli-thinkpadt14sgen2i.rmtde.csb (unknown [10.44.33.215])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3ACAC180049F
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 12:42:54 +0000 (UTC)
From: Akhil Kohli <akkohli@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] semodule-utils: add bad-data tests for link/expand neverallow
Date: Thu, 30 Jul 2026 14:42:51 +0200
Message-ID: <20260730124253.3282686-1-akkohli@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add link/expand bad-data tests for neverallow and neverallowxperm
enforcement at semodule_expand: cross-module base violations, same-module
neverallow conflicts, and checkmodule deferral document tests.

Adapt same-module neverallowxperm for libsepol 3.11 (enforced at expand)
while still passing on older userspace where enforcement is deferred.
Refactor link/expand helpers through run_link_expand().

Add a cross-module require test: link rejects a consumer module when a
required type is only declared in a separate provider module.

Signed-off-by: Akhil Kohli <akkohli@redhat.com>
---
 .../bad-data/fixtures/base/minimal_base.conf  |  15 +
 .../bad-data/fixtures/modules/module_a.te     |   8 +
 .../bad-data/fixtures/modules/module_b.te     |   8 +
 .../fixtures/modules/neverallow_good.te       |   8 +
 .../fixtures/modules/neverallow_self.te       |  10 +
 .../fixtures/modules/neverallow_violator.te   |   8 +
 .../fixtures/modules/neverallow_xperm_self.te |  11 +
 .../modules/neverallow_xperm_violator.te      |   9 +
 semodule-utils/tests/bad-data/run.sh          | 342 +++++++++++++++++-
 9 files changed, 414 insertions(+), 5 deletions(-)
 create mode 100644 semodule-utils/tests/bad-data/fixtures/base/minimal_base.conf
 create mode 100644 semodule-utils/tests/bad-data/fixtures/modules/module_a.te
 create mode 100644 semodule-utils/tests/bad-data/fixtures/modules/module_b.te
 create mode 100644 semodule-utils/tests/bad-data/fixtures/modules/neverallow_good.te
 create mode 100644 semodule-utils/tests/bad-data/fixtures/modules/neverallow_self.te
 create mode 100644 semodule-utils/tests/bad-data/fixtures/modules/neverallow_violator.te
 create mode 100644 semodule-utils/tests/bad-data/fixtures/modules/neverallow_xperm_self.te
 create mode 100644 semodule-utils/tests/bad-data/fixtures/modules/neverallow_xperm_violator.te

diff --git a/semodule-utils/tests/bad-data/fixtures/base/minimal_base.conf b/semodule-utils/tests/bad-data/fixtures/base/minimal_base.conf
new file mode 100644
index 00000000..4e058c77
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/base/minimal_base.conf
@@ -0,0 +1,15 @@
+# Base .conf: bare class declaration, then permission block (checkmodule requires both).
+class file
+sid kernel
+class file { read write ioctl }
+
+type base_t;
+
+allow base_t base_t : file read;
+neverallow base_t base_t : file write;
+neverallowxperm base_t base_t : file ioctl 0x1000;
+
+role object_r;
+role object_r types { base_t };
+user user_u roles { object_r };
+sid kernel user_u:object_r:base_t
diff --git a/semodule-utils/tests/bad-data/fixtures/modules/module_a.te b/semodule-utils/tests/bad-data/fixtures/modules/module_a.te
new file mode 100644
index 00000000..04d16238
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/modules/module_a.te
@@ -0,0 +1,8 @@
+module module_a 1.0;
+
+require {
+	type other_t;
+	class file { read };
+}
+
+allow other_t other_t : file read;
diff --git a/semodule-utils/tests/bad-data/fixtures/modules/module_b.te b/semodule-utils/tests/bad-data/fixtures/modules/module_b.te
new file mode 100644
index 00000000..2b8caed7
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/modules/module_b.te
@@ -0,0 +1,8 @@
+module module_b 1.0;
+
+require {
+	class file { read };
+}
+
+type other_t;
+allow other_t other_t : file read;
diff --git a/semodule-utils/tests/bad-data/fixtures/modules/neverallow_good.te b/semodule-utils/tests/bad-data/fixtures/modules/neverallow_good.te
new file mode 100644
index 00000000..f9850b8b
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/modules/neverallow_good.te
@@ -0,0 +1,8 @@
+module neverallow_good 1.0;
+
+require {
+	type base_t;
+	class file { read };
+}
+
+allow base_t base_t : file read;
diff --git a/semodule-utils/tests/bad-data/fixtures/modules/neverallow_self.te b/semodule-utils/tests/bad-data/fixtures/modules/neverallow_self.te
new file mode 100644
index 00000000..255fb391
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/modules/neverallow_self.te
@@ -0,0 +1,10 @@
+module neverallow_self 1.0;
+
+require {
+	class file { read write };
+}
+
+type foo_t;
+
+allow foo_t foo_t : file { read write };
+neverallow foo_t foo_t : file write;
diff --git a/semodule-utils/tests/bad-data/fixtures/modules/neverallow_violator.te b/semodule-utils/tests/bad-data/fixtures/modules/neverallow_violator.te
new file mode 100644
index 00000000..fb8aade4
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/modules/neverallow_violator.te
@@ -0,0 +1,8 @@
+module neverallow_violator 1.0;
+
+require {
+	type base_t;
+	class file { read write };
+}
+
+allow base_t base_t : file write;
diff --git a/semodule-utils/tests/bad-data/fixtures/modules/neverallow_xperm_self.te b/semodule-utils/tests/bad-data/fixtures/modules/neverallow_xperm_self.te
new file mode 100644
index 00000000..965f86af
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/modules/neverallow_xperm_self.te
@@ -0,0 +1,11 @@
+module neverallow_xperm_self 1.0;
+
+require {
+	class file { read write ioctl };
+}
+
+type foo_t;
+
+allow foo_t foo_t : file ioctl;
+allowxperm foo_t foo_t : file ioctl 0x2000;
+neverallowxperm foo_t foo_t : file ioctl 0x2000;
diff --git a/semodule-utils/tests/bad-data/fixtures/modules/neverallow_xperm_violator.te b/semodule-utils/tests/bad-data/fixtures/modules/neverallow_xperm_violator.te
new file mode 100644
index 00000000..7dbf889f
--- /dev/null
+++ b/semodule-utils/tests/bad-data/fixtures/modules/neverallow_xperm_violator.te
@@ -0,0 +1,9 @@
+module neverallow_xperm_violator 1.0;
+
+require {
+	type base_t;
+	class file { read write ioctl };
+}
+
+allow base_t base_t : file ioctl;
+allowxperm base_t base_t : file ioctl 0x1000;
diff --git a/semodule-utils/tests/bad-data/run.sh b/semodule-utils/tests/bad-data/run.sh
index 1c7d8f51..d3f89691 100755
--- a/semodule-utils/tests/bad-data/run.sh
+++ b/semodule-utils/tests/bad-data/run.sh
@@ -1,10 +1,11 @@
 #!/bin/sh
 #
-# Bad-data tests for semodule_package and sefcontext_compile in the modular
-# policy packaging pipeline. Covers packaging path edge cases (-m/-f), documents
-# deferred rejection of bad .mod.fc content at packaging time, and validates
-# labeling through sefcontext_compile. Unreadable -m/-f cases skip when run as
-# root; CI runs this script as non-root.
+# Bad-data tests for semodule_package, sefcontext_compile, and
+# semodule_link/semodule_expand in the modular policy packaging pipeline.
+# Covers packaging path edge cases (-m/-f), documents deferred rejection of bad
+# .mod.fc content at packaging time, validates labeling through sefcontext_compile,
+# and exercises neverallow enforcement at link/expand. Unreadable -m/-f cases skip
+# when run as root; CI runs this script as non-root.
 #
 
 set -u
@@ -32,6 +33,8 @@ CHECKMODULE_MOD_FLAGS=${CHECKMODULE_MOD_FLAGS:--M -m}
 SEMODULE_PACKAGE=${SEMODULE_PACKAGE:-semodule_package}
 SEMODULE_UNPACKAGE=${SEMODULE_UNPACKAGE:-semodule_unpackage}
 SEFCONTEXT_COMPILE=${SEFCONTEXT_COMPILE:-sefcontext_compile}
+SEMODULE_LINK=${SEMODULE_LINK:-semodule_link}
+SEMODULE_EXPAND=${SEMODULE_EXPAND:-semodule_expand}
 
 GOOD_TE="${FIXTURES}/modules/good.te"
 GOOD_MOD="${OUTDIR}/test_good.mod"
@@ -408,6 +411,229 @@ expect_sefcontext_pass_deferred() {
 	pass "${desc} (sefcontext_compile exit 0; complements packaging deferral)"
 }
 
+build_loadable_package() {
+	te="$1"
+	mod="$2"
+	pp="$3"
+
+	set +e
+	# Non-MLS modular build to match fixtures/base/minimal_base.conf.
+	"${CHECKMODULE}" -m -o "${mod}" "${te}" 2>"${mod}.err"
+	rc=$?
+	set -e
+	if [ "${rc}" -ne 0 ]; then
+		echo "FAIL: checkmodule could not build ${te}" >&2
+		cat "${mod}.err" >&2
+		exit 1
+	fi
+
+	set +e
+	"${SEMODULE_PACKAGE}" -o "${pp}" -m "${mod}" 2>"${pp}.err"
+	rc=$?
+	set -e
+	if [ "${rc}" -ne 0 ]; then
+		echo "FAIL: semodule_package could not build ${pp}" >&2
+		cat "${pp}.err" >&2
+		exit 1
+	fi
+}
+
+expect_checkmodule_pass() {
+	desc="$1"
+	te="$2"
+	mod="${OUTDIR}/$(basename "${te}" .te).mod"
+
+	echo "==== DOCUMENT (checkmodule accepts module; enforcement deferred to expand): ${desc}"
+	rm -f "${mod}" "${mod}.err"
+
+	set +e
+	"${CHECKMODULE}" -m -o "${mod}" "${te}" 2>"${mod}.err"
+	rc=$?
+	set -e
+	if [ "${rc}" -ne 0 ]; then
+		cat "${mod}.err" >&2
+		die "${desc}: expected checkmodule success, got rc=${rc}"
+		return 0
+	fi
+	if [ ! -s "${mod}" ]; then
+		die "${desc}: expected non-empty ${mod}"
+		return 0
+	fi
+
+	pass "${desc} (checkmodule exit 0, .mod created)"
+}
+
+# Sets LINK_EXPAND_LINK_RC and LINK_EXPAND_EXPAND_RC (-1 if expand not run).
+run_link_expand() {
+	link_out="$1"
+	expand_out="$2"
+	base_pp="$3"
+	shift 3
+
+	rm -f "${link_out}" "${expand_out}" "${link_out}.err" "${expand_out}.err"
+
+	set +e
+	"${SEMODULE_LINK}" -o "${link_out}" "${base_pp}" "$@" \
+		2>"${link_out}.err"
+	LINK_EXPAND_LINK_RC=$?
+	set -e
+	if [ "${LINK_EXPAND_LINK_RC}" -ne 0 ]; then
+		cat "${link_out}.err" >&2
+		LINK_EXPAND_EXPAND_RC=-1
+		return 0
+	fi
+
+	set +e
+	"${SEMODULE_EXPAND}" "${link_out}" "${expand_out}" \
+		2>"${expand_out}.err"
+	LINK_EXPAND_EXPAND_RC=$?
+	set -e
+	if [ "${LINK_EXPAND_EXPAND_RC}" -ne 0 ]; then
+		cat "${expand_out}.err" >&2
+	fi
+}
+
+expect_link_expand_pass() {
+	desc="$1"
+	link_out="$2"
+	expand_out="$3"
+	base_pp="$4"
+	shift 4
+
+	echo "==== POSITIVE (expect link + expand success): ${desc}"
+	run_link_expand "${link_out}" "${expand_out}" "${base_pp}" "$@"
+	if [ "${LINK_EXPAND_LINK_RC}" -ne 0 ]; then
+		die "${desc}: semodule_link failed, rc=${LINK_EXPAND_LINK_RC}"
+		return 0
+	fi
+	if [ "${LINK_EXPAND_EXPAND_RC}" -ne 0 ]; then
+		die "${desc}: semodule_expand failed, rc=${LINK_EXPAND_EXPAND_RC}"
+		return 0
+	fi
+	if [ ! -s "${expand_out}" ]; then
+		die "${desc}: expected non-empty ${expand_out}"
+		return 0
+	fi
+
+	pass "${desc} (link and expand succeeded)"
+}
+
+expect_link_expand_fail() {
+	desc="$1"
+	pattern="$2"
+	link_out="$3"
+	expand_out="$4"
+	base_pp="$5"
+	shift 5
+
+	echo "==== NEGATIVE (expect neverallow failure at expand): ${desc}"
+	run_link_expand "${link_out}" "${expand_out}" "${base_pp}" "$@"
+	if [ "${LINK_EXPAND_LINK_RC}" -ne 0 ]; then
+		die "${desc}: expected semodule_link success before expand, rc=${LINK_EXPAND_LINK_RC}"
+		return 0
+	fi
+	if [ "${LINK_EXPAND_EXPAND_RC}" -eq 0 ]; then
+		die "${desc}: expected semodule_expand failure, got rc=0"
+		return 0
+	fi
+	if ! grep -Eq "${pattern}" "${expand_out}.err"; then
+		echo "FAIL: stderr did not match /${pattern}/" >&2
+		cat "${expand_out}.err" >&2
+		FAIL=$((FAIL + 1))
+		return 0
+	fi
+
+	pass "${desc} (expand failed on neverallow as expected, rc=${LINK_EXPAND_EXPAND_RC})"
+}
+
+# Same-module neverallowxperm: enforced at expand on libsepol 3.11+, deferred on older userspace.
+expect_link_expand_fail_or_deferred() {
+	desc="$1"
+	pattern="$2"
+	link_out="$3"
+	expand_out="$4"
+	base_pp="$5"
+	shift 5
+
+	echo "==== NEGATIVE or DOCUMENT (same-module neverallowxperm at expand): ${desc}"
+	run_link_expand "${link_out}" "${expand_out}" "${base_pp}" "$@"
+	if [ "${LINK_EXPAND_LINK_RC}" -ne 0 ]; then
+		die "${desc}: expected semodule_link success, rc=${LINK_EXPAND_LINK_RC}"
+		return 0
+	fi
+	if [ "${LINK_EXPAND_EXPAND_RC}" -eq 0 ]; then
+		if [ ! -s "${expand_out}" ]; then
+			die "${desc}: expected non-empty ${expand_out} when expand deferred"
+			return 0
+		fi
+		pass "${desc} (link and expand succeeded; enforcement deferred on this userspace)"
+		return 0
+	fi
+	if ! grep -Eq "${pattern}" "${expand_out}.err"; then
+		echo "FAIL: stderr did not match /${pattern}/" >&2
+		cat "${expand_out}.err" >&2
+		FAIL=$((FAIL + 1))
+		return 0
+	fi
+
+	pass "${desc} (expand failed on neverallowxperm as expected, rc=${LINK_EXPAND_EXPAND_RC})"
+}
+
+build_base_package() {
+	base_conf="$1"
+	base_mod="$2"
+	base_pp="$3"
+
+	set +e
+	"${CHECKMODULE}" -o "${base_mod}" "${base_conf}" 2>"${base_mod}.err"
+	rc=$?
+	set -e
+	if [ "${rc}" -ne 0 ]; then
+		echo "FAIL: checkmodule could not build base from ${base_conf}" >&2
+		cat "${base_mod}.err" >&2
+		exit 1
+	fi
+
+	set +e
+	"${SEMODULE_PACKAGE}" -o "${base_pp}" -m "${base_mod}" 2>"${base_pp}.err"
+	rc=$?
+	set -e
+	if [ "${rc}" -ne 0 ]; then
+		echo "FAIL: semodule_package could not build ${base_pp}" >&2
+		cat "${base_pp}.err" >&2
+		exit 1
+	fi
+}
+
+expect_link_fail() {
+	desc="$1"
+	pattern="$2"
+	link_out="$3"
+	base_pp="$4"
+	shift 4
+
+	echo "==== NEGATIVE (expect semodule_link failure): ${desc}"
+	rm -f "${link_out}" "${link_out}.err"
+
+	set +e
+	"${SEMODULE_LINK}" -o "${link_out}" "${base_pp}" "$@" \
+		2>"${link_out}.err"
+	rc=$?
+	set -e
+	if [ "${rc}" -eq 0 ]; then
+		die "${desc}: expected semodule_link failure, got rc=0"
+		return 0
+	fi
+	if ! grep -Eq "${pattern}" "${link_out}.err"; then
+		echo "FAIL: stderr did not match /${pattern}/" >&2
+		cat "${link_out}.err" >&2
+		FAIL=$((FAIL + 1))
+		return 0
+	fi
+
+	pass "${desc} (link failed on unmet require as expected, rc=${rc})"
+}
+
 build_good_mod
 
 # Ephemeral path fixtures for packaging path tests.
@@ -564,6 +790,112 @@ else
 		"${EXTRACTED_FC}"
 fi
 
+# --- semodule_link / semodule_expand neverallow ---
+BASE_CONF="${FIXTURES}/base/minimal_base.conf"
+BASE_MOD="${OUTDIR}/minimal_base.mod"
+BASE_PP="${OUTDIR}/minimal_base.pp"
+GOOD_LOADABLE_MOD="${OUTDIR}/neverallow_good.mod"
+GOOD_LOADABLE_PP="${OUTDIR}/neverallow_good.pp"
+VIOLATOR_MOD="${OUTDIR}/neverallow_violator.mod"
+VIOLATOR_PP="${OUTDIR}/neverallow_violator.pp"
+SELF_MOD="${OUTDIR}/neverallow_self.mod"
+SELF_PP="${OUTDIR}/neverallow_self.pp"
+XPERM_VIOLATOR_MOD="${OUTDIR}/neverallow_xperm_violator.mod"
+XPERM_VIOLATOR_PP="${OUTDIR}/neverallow_xperm_violator.pp"
+XPERM_SELF_MOD="${OUTDIR}/neverallow_xperm_self.mod"
+XPERM_SELF_PP="${OUTDIR}/neverallow_xperm_self.pp"
+
+echo "==== Setup: build minimal base and loadable module packages (non-MLS)"
+build_base_package "${BASE_CONF}" "${BASE_MOD}" "${BASE_PP}"
+build_loadable_package "${FIXTURES}/modules/neverallow_good.te" \
+	"${GOOD_LOADABLE_MOD}" "${GOOD_LOADABLE_PP}"
+build_loadable_package "${FIXTURES}/modules/neverallow_violator.te" \
+	"${VIOLATOR_MOD}" "${VIOLATOR_PP}"
+build_loadable_package "${FIXTURES}/modules/neverallow_self.te" \
+	"${SELF_MOD}" "${SELF_PP}"
+build_loadable_package "${FIXTURES}/modules/neverallow_xperm_violator.te" \
+	"${XPERM_VIOLATOR_MOD}" "${XPERM_VIOLATOR_PP}"
+build_loadable_package "${FIXTURES}/modules/neverallow_xperm_self.te" \
+	"${XPERM_SELF_MOD}" "${XPERM_SELF_PP}"
+echo ""
+
+expect_checkmodule_pass \
+	"neverallow module passes checkmodule before expand rejects it" \
+	"${FIXTURES}/modules/neverallow_self.te"
+
+expect_checkmodule_pass \
+	"neverallowxperm module passes checkmodule before link/expand" \
+	"${FIXTURES}/modules/neverallow_xperm_self.te"
+
+expect_link_expand_pass \
+	"control base + good module link and expand" \
+	"${OUTDIR}/link_good.pp" \
+	"${OUTDIR}/expand_good.bin" \
+	"${BASE_PP}" \
+	"${GOOD_LOADABLE_PP}"
+
+expect_link_expand_fail \
+	"loadable module violates base neverallow on expand" \
+	"neverallow violated|neverallow failures occurred" \
+	"${OUTDIR}/link_violator.pp" \
+	"${OUTDIR}/expand_violator.bin" \
+	"${BASE_PP}" \
+	"${VIOLATOR_PP}"
+
+expect_link_expand_fail \
+	"same-module neverallow violated on expand" \
+	"neverallow violated|neverallow failures occurred" \
+	"${OUTDIR}/link_self.pp" \
+	"${OUTDIR}/expand_self.bin" \
+	"${BASE_PP}" \
+	"${SELF_PP}"
+
+expect_link_expand_fail \
+	"loadable module violates base neverallowxperm on expand" \
+	"neverallowxperm|neverallow failures occurred" \
+	"${OUTDIR}/link_xperm_violator.pp" \
+	"${OUTDIR}/expand_xperm_violator.bin" \
+	"${BASE_PP}" \
+	"${XPERM_VIOLATOR_PP}"
+
+expect_link_expand_fail_or_deferred \
+	"same-module neverallowxperm violated on expand" \
+	"neverallowxperm|neverallow failures occurred" \
+	"${OUTDIR}/link_xperm_self.pp" \
+	"${OUTDIR}/expand_xperm_self.bin" \
+	"${BASE_PP}" \
+	"${XPERM_SELF_PP}"
+
+# --- cross-module require (§2c.9) ---
+REQUIRE_CONSUMER_MOD="${OUTDIR}/module_a.mod"
+REQUIRE_CONSUMER_PP="${OUTDIR}/module_a.pp"
+REQUIRE_PROVIDER_MOD="${OUTDIR}/module_b.mod"
+REQUIRE_PROVIDER_PP="${OUTDIR}/module_b.pp"
+
+build_loadable_package "${FIXTURES}/modules/module_a.te" \
+	"${REQUIRE_CONSUMER_MOD}" "${REQUIRE_CONSUMER_PP}"
+build_loadable_package "${FIXTURES}/modules/module_b.te" \
+	"${REQUIRE_PROVIDER_MOD}" "${REQUIRE_PROVIDER_PP}"
+
+expect_checkmodule_pass \
+	"consumer module passes checkmodule before link rejects missing require" \
+	"${FIXTURES}/modules/module_a.te"
+
+expect_link_fail \
+	"module requires type only declared in another module" \
+	"requirements were not met|global requirements" \
+	"${OUTDIR}/link_require_consumer.pp" \
+	"${BASE_PP}" \
+	"${REQUIRE_CONSUMER_PP}"
+
+expect_link_expand_pass \
+	"consumer and provider modules link and expand together" \
+	"${OUTDIR}/link_require_both.pp" \
+	"${OUTDIR}/expand_require_both.bin" \
+	"${BASE_PP}" \
+	"${REQUIRE_CONSUMER_PP}" \
+	"${REQUIRE_PROVIDER_PP}"
+
 echo "========================================"
 echo "Results: ${PASS} passed, ${FAIL} failed"
 if [ "${FAIL}" -ne 0 ]; then
-- 
2.55.0

