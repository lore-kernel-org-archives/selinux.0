Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438BC3CB54F
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406730; cv=none; b=q0IB1QnrYVzBKL/+rmeDx1xOGoNWSltK1jrqn1b1HRgXmfIznscQtyvujBB6riK6gwvFWoqafbb3G+nVRMxPnDQ2OYzz4l/y9646qRDa43Hr0Oz/qQ4V205050FPsymA/JfdCTHMSIc2f05/RDGU3/D6SPPjVpofB0bGWkzLfxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406730; c=relaxed/simple;
	bh=M7VQvzY12lRaBTlh0vyyiPxLpqG+DiSeluv6Ec/fkyE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHWdf1IYv9RPHhLBVQSrtT9oQeI0LWifqhNwUWMCYQES1a/4E1Jg5nr1D3FcebIm/VCnWau+E6rL/axT8hJTIQDz6cNfDe4EtMZfg+xSHpkjag4ySwkGmWCMroWICgDj+TgkFLVrWBIn+Q4EYHGd3RTPbVnUBihC23gQb8XKGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJ765LrL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJ765LrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785406728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBZ/R0iI6wf+GwLjMCUgRqXzolre4xd1CQiOsn3N/3I=;
	b=GJ765LrLPMPz1F1mRChLrgKjw5oXlxy67pgFMkL659T2B74MabsQ5XYz8t29Lou2cwuuD0
	kHNTTGCgp6/wySoG+CGJW7zmCbUUkz4NrHH55qRJ3DXSclb/cKSVvCrXGY5Ao79gwDadk9
	AaWJ2arFaIqJRvmj0vYeeniSqbsk+VY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-_KfGHHu7O_GyYsczLy06cQ-1; Thu,
 30 Jul 2026 06:18:46 -0400
X-MC-Unique: _KfGHHu7O_GyYsczLy06cQ-1
X-Mimecast-MFC-AGG-ID: _KfGHHu7O_GyYsczLy06cQ_1785406725
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8D221800358
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:18:45 +0000 (UTC)
Received: from akkohli-thinkpadt14sgen2i.rmtde.csb (unknown [10.44.33.215])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 040C2414
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:18:44 +0000 (UTC)
From: Akhil Kohli <akkohli@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v4 1/2] checkpolicy: extend bad-data tests for type, role, and user errors
Date: Thu, 30 Jul 2026 12:18:39 +0200
Message-ID: <20260730101840.3224405-2-akkohli@redhat.com>
In-Reply-To: <20260730101840.3224405-1-akkohli@redhat.com>
References: <20260730101840.3224405-1-akkohli@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Add negative .te fixtures for duplicate type/attribute declarations,
type/attribute name conflicts, invalid type names, and malformed role
and user stanzas. Run checkmodule negative tests as non-root in CI so
the unreadable .te case is exercised outside root-only skips.

Signed-off-by: Akhil Kohli <akkohli@redhat.com>
---
 .github/workflows/run_tests.yml               | 11 ++++++++++
 checkpolicy/tests/negative/bad_role.te        | 13 +++++++++++
 checkpolicy/tests/negative/bad_user.te        | 15 +++++++++++++
 checkpolicy/tests/negative/dup_attribute.te   | 13 +++++++++++
 checkpolicy/tests/negative/dup_type.te        | 11 ++++++++++
 .../tests/negative/invalid_type_name.te       |  9 ++++++++
 .../tests/negative/type_attr_conflict.te      | 10 +++++++++
 .../tests/test_checkmodule_negative.sh        | 22 ++++++++++++++++++-
 8 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 checkpolicy/tests/negative/bad_role.te
 create mode 100644 checkpolicy/tests/negative/bad_user.te
 create mode 100644 checkpolicy/tests/negative/dup_attribute.te
 create mode 100644 checkpolicy/tests/negative/dup_type.te
 create mode 100644 checkpolicy/tests/negative/invalid_type_name.te
 create mode 100644 checkpolicy/tests/negative/type_attr_conflict.te

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index 4322ddff..8e9afa10 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -95,6 +95,17 @@ jobs:
           echo "::endgroup::"
         fi
 
+        # checkmodule bad-data: unreadable .te needs non-root (root reads mode 000).
+        if [ "${{ matrix.python-ruby-version.other }}" != "sanitizers" ] ; then
+          echo "::group::checkpolicy bad-data (non-root)"
+          sudo useradd -m -s /usr/sbin/nologin bad-data-test 2>/dev/null || true
+          chmod -R a+rX .
+          sudo runuser -u bad-data-test -- env PATH="$PATH" LD_LIBRARY_PATH="$LD_LIBRARY_PATH" \
+            ./checkpolicy/tests/test_checkmodule_negative.sh
+          sudo userdel -r bad-data-test 2>/dev/null || true
+          echo "::endgroup::"
+        fi
+
         if [ "${{ matrix.python-ruby-version.other }}" != "sanitizers" ] ; then
             # Test Python and Ruby wrappers
             echo "::group::Test Python and Ruby wrappers"
diff --git a/checkpolicy/tests/negative/bad_role.te b/checkpolicy/tests/negative/bad_role.te
new file mode 100644
index 00000000..90a2c8c6
--- /dev/null
+++ b/checkpolicy/tests/negative/bad_role.te
@@ -0,0 +1,13 @@
+module bad_role 1.0;
+
+require {
+	type foo_t;
+	class file { read };
+}
+
+# Empty type list after "types" (fails at ';').
+role bad_role_r types ;
+
+type foo_t;
+
+allow foo_t foo_t:file read;
diff --git a/checkpolicy/tests/negative/bad_user.te b/checkpolicy/tests/negative/bad_user.te
new file mode 100644
index 00000000..b0ee8648
--- /dev/null
+++ b/checkpolicy/tests/negative/bad_user.te
@@ -0,0 +1,15 @@
+module bad_user 1.0;
+
+# Modular .te needs require before decls like user/role; without it
+# checkmodule fails at "user" instead of the garbage_token below.
+require {
+	type foo_t;
+	class file { read };
+}
+
+# Junk where "roles { ... }" should be.
+user bad_user_u garbage_token;
+
+type foo_t;
+
+allow foo_t foo_t:file read;
diff --git a/checkpolicy/tests/negative/dup_attribute.te b/checkpolicy/tests/negative/dup_attribute.te
new file mode 100644
index 00000000..24014d0b
--- /dev/null
+++ b/checkpolicy/tests/negative/dup_attribute.te
@@ -0,0 +1,13 @@
+module dup_attribute 1.0;
+
+require {
+	type foo_t;
+	class file { read };
+}
+
+attribute bar_attr;
+attribute bar_attr;
+
+type foo_t;
+
+allow foo_t foo_t:file read;
diff --git a/checkpolicy/tests/negative/dup_type.te b/checkpolicy/tests/negative/dup_type.te
new file mode 100644
index 00000000..2961dd0a
--- /dev/null
+++ b/checkpolicy/tests/negative/dup_type.te
@@ -0,0 +1,11 @@
+module dup_type 1.0;
+
+require {
+	type foo_t;
+	class file { read };
+}
+
+type foo_t;
+type foo_t;
+
+allow foo_t foo_t:file read;
diff --git a/checkpolicy/tests/negative/invalid_type_name.te b/checkpolicy/tests/negative/invalid_type_name.te
new file mode 100644
index 00000000..6fe14fbb
--- /dev/null
+++ b/checkpolicy/tests/negative/invalid_type_name.te
@@ -0,0 +1,9 @@
+module invalid_type_name 1.0;
+
+require {
+	class file { read };
+}
+
+type 1bad;
+
+allow 1bad 1bad:file read;
diff --git a/checkpolicy/tests/negative/type_attr_conflict.te b/checkpolicy/tests/negative/type_attr_conflict.te
new file mode 100644
index 00000000..160cd386
--- /dev/null
+++ b/checkpolicy/tests/negative/type_attr_conflict.te
@@ -0,0 +1,10 @@
+module type_attr_conflict 1.0;
+
+require {
+	class file { read };
+}
+
+type shared_id;
+attribute shared_id;
+
+allow shared_id shared_id:file read;
diff --git a/checkpolicy/tests/test_checkmodule_negative.sh b/checkpolicy/tests/test_checkmodule_negative.sh
index a5f49f3b..dcbb3f04 100755
--- a/checkpolicy/tests/test_checkmodule_negative.sh
+++ b/checkpolicy/tests/test_checkmodule_negative.sh
@@ -6,8 +6,19 @@
 
 set -eu
 
-BASEDIR=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
+# Prefer an absolute script dir, but keep a relative dirname when cd fails.
+# Non-root CI inherits the repo as CWD; absolute cd under /home/runner/work
+# can fail for bad-data-test even when relative paths work.
+BASEDIR=$(dirname -- "$0")
+ABS_BASEDIR=$(CDPATH= cd -- "${BASEDIR}" 2>/dev/null && pwd) || ABS_BASEDIR=
+if [ -n "${ABS_BASEDIR}" ]; then
+	BASEDIR="${ABS_BASEDIR}"
+fi
 NEGDIR="${BASEDIR}/negative"
+if [ ! -d "${NEGDIR}" ]; then
+	echo "FAIL: cannot resolve negative fixtures (\$0=$0 BASEDIR=${BASEDIR})" >&2
+	exit 1
+fi
 CHECKMODULE="${BASEDIR}/../checkmodule"
 OUTDIR=$(mktemp -d "${TMPDIR:-/tmp}/checkmodule-negative.XXXXXX")
 PASS=0
@@ -159,6 +170,15 @@ expect_fail "bad_module_line.te" "syntax error" "bad_module_line" "${NEGDIR}/bad
 expect_fail "bad_require.te" "syntax error" "bad_require" "${NEGDIR}/bad_require.te"
 expect_fail "invalid_module_version.te" "syntax error" "invalid_module_version" "${NEGDIR}/invalid_module_version.te"
 expect_fail "dup_module.te" "syntax error" "dup_module" "${NEGDIR}/dup_module.te"
+expect_fail "dup_type.te" "Duplicate declaration of type" "dup_type" "${NEGDIR}/dup_type.te"
+expect_fail "dup_attribute.te" "Duplicate declaration of type" "dup_attribute" \
+	"${NEGDIR}/dup_attribute.te"
+expect_fail "type_attr_conflict.te" "Duplicate declaration of type" "type_attr_conflict" \
+	"${NEGDIR}/type_attr_conflict.te"
+expect_fail "invalid_type_name.te" "syntax error" "invalid_type_name" \
+	"${NEGDIR}/invalid_type_name.te"
+expect_fail "bad_role.te" "syntax error" "bad_role" "${NEGDIR}/bad_role.te"
+expect_fail "bad_user.te" "garbage_token" "bad_user" "${NEGDIR}/bad_user.te"
 
 # Missing / bad-path .te inputs (PDF #1).
 expect_fail "missing .te path" "unable to open" "missing_path" "${OUTDIR}/does_not_exist.te"
-- 
2.55.0

