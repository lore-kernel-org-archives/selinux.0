Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4763D3334
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785191576; cv=none; b=jvKws++AfdcUX4ZqP5iO4sdiqjsJ0IzmI0dTTcCT3lTgFY/rENG3Ng1jLOJaaQM+eQ3zbkZqko4u6Y6UiC3TZ5HsqQ/NSpUuVw8xhk/hpucs9gzmoactXJ9h5V5tyLAxc9JLvhBsTMyql84Hac+AHWHdkiPFL3VFgLacrvlnt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785191576; c=relaxed/simple;
	bh=v+rZ0IvakFU7JFWGEdy/A890voM0+TdXJklLt+Evl6k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGmkp5q+oCJhx3CV09lfFMlXrxnB1J8hYMygHczSO7ok6Hw3YX39uqdVaEeTUg7hcPNRX/wHVmwxNpbbkd1flPS+LdcWvcLMWbQTAHHekEXLLvwNkocN0Cr3u/dSTOSVlO2ynsblLgxR/E3xxHk5cDB3BPrRkF16bW0jiBGWTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cj/yqHml; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cj/yqHml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785191573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23gsVHA/s8JqB67T4+dRhmSC7yIczEatbnfw7bopHJY=;
	b=cj/yqHmleD9Jg5moZFVdd2bmT/uOCO1tqH3Rg6qerdOH0RW57tvHqXIqfTDgI9AiJo9j8b
	LRPpybvqgmHMWsDhjPsmuvvpsJDF8BcJG428+WYopoeKd9TH8XYZuwCg/AZ6ytgie3xjBj
	O1xxeczCPWbpLCXSJV1kVna9S/41mo8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-8uvB5IYoPOmIXnSFGYfl9g-1; Mon,
 27 Jul 2026 18:32:47 -0400
X-MC-Unique: 8uvB5IYoPOmIXnSFGYfl9g-1
X-Mimecast-MFC-AGG-ID: 8uvB5IYoPOmIXnSFGYfl9g_1785191566
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 879361954B27
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 22:32:46 +0000 (UTC)
Received: from akkohli-thinkpadt14sgen2i.rmtde.csb (unknown [10.44.33.215])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8DFD30010D1
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 22:32:45 +0000 (UTC)
From: Akhil Kohli <akkohli@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2 1/2] checkpolicy: extend bad-data tests for type, role, and user errors
Date: Tue, 28 Jul 2026 00:32:41 +0200
Message-ID: <20260727223242.2507658-2-akkohli@redhat.com>
In-Reply-To: <20260727223242.2507658-1-akkohli@redhat.com>
References: <20260727223242.2507658-1-akkohli@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add negative .te fixtures for duplicate type/attribute declarations,
type/attribute name conflicts, invalid type names, and malformed role
and user stanzas. Run checkmodule negative tests as non-root in CI so
the unreadable .te case is exercised outside root-only skips.

Signed-off-by: Akhil Kohli <akkohli@redhat.com>
---
 .github/workflows/run_tests.yml                  | 11 +++++++++++
 checkpolicy/tests/negative/bad_role.te           | 12 ++++++++++++
 checkpolicy/tests/negative/bad_user.te           |  3 +++
 checkpolicy/tests/negative/dup_attribute.te      | 13 +++++++++++++
 checkpolicy/tests/negative/dup_type.te           | 11 +++++++++++
 checkpolicy/tests/negative/invalid_type_name.te  |  9 +++++++++
 checkpolicy/tests/negative/type_attr_conflict.te | 10 ++++++++++
 checkpolicy/tests/test_checkmodule_negative.sh   |  9 +++++++++
 8 files changed, 78 insertions(+)
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
index 00000000..3aae2719
--- /dev/null
+++ b/checkpolicy/tests/negative/bad_role.te
@@ -0,0 +1,12 @@
+module bad_role 1.0;
+
+require {
+	type foo_t;
+	class file { read };
+}
+
+role bad_role_r types ;
+
+type foo_t;
+
+allow foo_t foo_t:file read;
diff --git a/checkpolicy/tests/negative/bad_user.te b/checkpolicy/tests/negative/bad_user.te
new file mode 100644
index 00000000..e7460dd7
--- /dev/null
+++ b/checkpolicy/tests/negative/bad_user.te
@@ -0,0 +1,3 @@
+module bad_user 1.0;
+
+user bad_user_u garbage_token;
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
index a5f49f3b..6d289a4c 100755
--- a/checkpolicy/tests/test_checkmodule_negative.sh
+++ b/checkpolicy/tests/test_checkmodule_negative.sh
@@ -159,6 +159,15 @@ expect_fail "bad_module_line.te" "syntax error" "bad_module_line" "${NEGDIR}/bad
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
+expect_fail "bad_user.te" "syntax error" "bad_user" "${NEGDIR}/bad_user.te"
 
 # Missing / bad-path .te inputs (PDF #1).
 expect_fail "missing .te path" "unable to open" "missing_path" "${OUTDIR}/does_not_exist.te"
-- 
2.55.0

