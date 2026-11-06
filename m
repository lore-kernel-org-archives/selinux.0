Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968527;
	b=qsaJ4PLjewAk1z8XqCqvtyttO51UomAxhLuCNgh1bXDoIqiRKUexDf9Qmb48qA9EiMZr
	 XOCqeEoQDkHOZwcpnUxfwS4R4YhzmVIkAV9FjfZGzvyJzhBK3GWjjYEq7xZRCdxhNv9Kk
	 IIBFL3ulDFKzImMTzVS3SVK+SKs7lRMKqtmgYFXquhlV2mRFzU7G470txlMCQ+Uuvki53
	 pHEm3mioOdQDFxS7Z2zjoaRsS/iVYoqflLuftDk45YBnhN1HFUa05DHM1uvoILwp23EAO
	 WIxv/fYGpcu5C9h+oJpt2EU7rRWa12U3Yh3ktJWgpzm+8HPGtqrN1mDzqW1YXSs72Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968527;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9z3LzQ60tKwXUZNgZjaGmpRIsxPds6NeaPEg04ZWLro=;
	b=H/v9MmRA13lCrBQcWzekGnAO1MNhPEJiYbA6z9MppoFHoIy4ApJuS2UjrZhCS+wfkVoP
	 hsivEVtKJPI58I+3bo+77mw5VCKNlGLqXv50oxGLeR1Ksitw1T69tTX1pCRbylO4KOtUH
	 SQcMEA9xN/Z19MtuzaMUVMrtpxZHe+Mr7/4Uh7TcwBjkVX4h2KBNQdhjCJ8yPTQuAVYx7
	 9cbD2BAP60H4htsDK9ALhPX7whImyDYx4ohC15A/QU3znZWv/GOT/xdqJ5uDvKewACtsH
	 Wgmb2AFCErd1AottdlMfudcAnqWEU2Kmv1URvzCQKc21l3eM3jtYtzWKhUvujEHQNIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b="Oiq/PFgu";
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0E606A32C
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44D0E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=Oiq/PFgu
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968524;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9z3LzQ60tKwXUZNgZjaGmpRIsxPds6NeaPEg04ZWLro=;
	b=Oiq/PFgu0kMvZmEizDS4dxlsh7N8DCojn4ZlVJjBGyTLHnBryojsG8B64QI26ekQjl1Xpn
	ykfVxz0FlsBL/QSgWX2T9GcZlu3m7q7ep9+UI7/K3utFSdxHiBUfLWdZFN+3D9K5WlYHA6
	L/lXm4qTaQYcOpzDCw3rYsOJThexKaH1Kuvd9BioR4a9MTB5GTu/linSihb+f3QsZa8UIx
	CBcyatkHgpwmlxJe185R3w3+sWdKTu2n9eOVHx50SOEB30l7KpK+jo6aM78UamRJ/Vur/X
	Feiz9YI/heYuIXWbqDe+uP1Ek50e5OXembwCiJ+DD6vFluPv/Kp2jy3ZHdaLtQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 05/16] checkpolicy: order IPv4 node contexts by network-order mask
Date: Fri,  6 Nov 2026 13:34:58 +0100
Message-ID: <20261106123510.76727-4-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-1-cgoettsche@seltendoof.de>
References: <20261106123510.76727-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

insert_ipv4_node() keeps node contexts sorted from the most to the least
specific mask, but compares u.node.mask, which holds the mask in network
byte order, as a host integer. On little-endian hosts a non-contiguous
mask therefore sorts by its byte-swapped value: of

    nodecon 10.0.0.0 255.0.255.0 ...
    nodecon 10.0.0.0 255.255.0.0 ...

the 255.0.255.0 entry is stored first, so the kernel matches 10.0.0.1
against it, while big-endian hosts, secilc, and libsepol's own policy
writers (node_data_cmp()) order 255.255.0.0 first. Contiguous masks
order alike either way.

Convert the masks to host byte order before comparing them, matching the
network-order comparison the IPv6 variant performs with memcmp(), and
add a regression test for the example above.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c                   |  3 +-
 libsepol/tests/libsepol-tests.c               |  2 +
 .../policies/test-ocontext/nodecon-order.conf | 28 ++++++++++
 libsepol/tests/test-ocontext.c                | 54 +++++++++++++++++++
 libsepol/tests/test-ocontext.h                | 10 ++++
 5 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 libsepol/tests/policies/test-ocontext/nodecon-order.conf
 create mode 100644 libsepol/tests/test-ocontext.c
 create mode 100644 libsepol/tests/test-ocontext.h

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 7e6d157f..28ad816b 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -5568,7 +5568,8 @@ static int insert_ipv4_node(ocontext_t *newc)
 			return -1;
 		}
 
-		if (newc->u.node.mask > c->u.node.mask)
+		/* The addresses and masks are stored in network byte order. */
+		if (be32toh(newc->u.node.mask) > be32toh(c->u.node.mask))
 			break;
 	}
 
diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index 2b758cad..1b70be01 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -26,6 +26,7 @@
 #include "test-downgrade.h"
 #include "test-neverallow.h"
 #include "test-kernel-to-cil.h"
+#include "test-ocontext.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -76,6 +77,7 @@ static bool do_tests(int interactive, int verbose)
 	DECLARE_SUITE(downgrade);
 	DECLARE_SUITE(neverallow);
 	DECLARE_SUITE(kernel_to_cil);
+	DECLARE_SUITE(ocontext);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsepol/tests/policies/test-ocontext/nodecon-order.conf b/libsepol/tests/policies/test-ocontext/nodecon-order.conf
new file mode 100644
index 00000000..4b368f62
--- /dev/null
+++ b/libsepol/tests/policies/test-ocontext/nodecon-order.conf
@@ -0,0 +1,28 @@
+class process
+
+sid kernel
+
+class process { transition }
+
+ifdef(`enable_mls',`
+sensitivity s0;
+dominance { s0 }
+category c0;
+level s0:c0;
+
+mlsconstrain process { transition } ( h1 dom h2 );
+')
+
+type sys_isid;
+type node_a_t;
+type node_b_t;
+allow sys_isid self : process transition;
+role sys_role;
+role sys_role types { sys_isid node_a_t node_b_t };
+gen_user(sys_user,, sys_role, s0, s0 - s0:c0)
+sid kernel gen_context(sys_user:sys_role:sys_isid, s0)
+
+# Neither mask contains the other; the one with the greater value in network
+# byte order (255.255.0.0) must come first regardless of the host's byte order.
+nodecon 10.0.0.0 255.0.255.0 gen_context(sys_user:sys_role:node_b_t, s0)
+nodecon 10.0.0.0 255.255.0.0 gen_context(sys_user:sys_role:node_a_t, s0)
diff --git a/libsepol/tests/test-ocontext.c b/libsepol/tests/test-ocontext.c
new file mode 100644
index 00000000..e9c58ed6
--- /dev/null
+++ b/libsepol/tests/test-ocontext.c
@@ -0,0 +1,54 @@
+#include "test-ocontext.h"
+
+#include "helpers.h"
+
+#include <arpa/inet.h>
+
+extern int mls;
+
+int ocontext_test_init(void)
+{
+	return 0;
+}
+
+int ocontext_test_cleanup(void)
+{
+	return 0;
+}
+
+/*
+ * IPv4 node contexts are ordered from the most to the least specific mask.
+ * The masks are stored in network byte order, so they must be compared as
+ * such, also on little-endian hosts and for non-contiguous masks.
+ */
+static void test_ocontext_nodecon_order(void)
+{
+	policydb_t p;
+	const ocontext_t *c;
+
+	if (test_load_policy(&p, POLICY_BASE, mls, "test-ocontext",
+			     "nodecon-order.conf"))
+		CU_FAIL_FATAL("Failed to load policy");
+
+	c = p.ocontexts[OCON_NODE];
+	CU_ASSERT_PTR_NOT_NULL_FATAL(c);
+	CU_ASSERT_EQUAL(c->u.node.mask, htonl(0xffff0000));
+
+	c = c->next;
+	CU_ASSERT_PTR_NOT_NULL_FATAL(c);
+	CU_ASSERT_EQUAL(c->u.node.mask, htonl(0xff00ff00));
+
+	CU_ASSERT_PTR_NULL(c->next);
+
+	policydb_destroy(&p);
+}
+
+int ocontext_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "ocontext_nodecon_order",
+				test_ocontext_nodecon_order)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	return 0;
+}
diff --git a/libsepol/tests/test-ocontext.h b/libsepol/tests/test-ocontext.h
new file mode 100644
index 00000000..c83f3f70
--- /dev/null
+++ b/libsepol/tests/test-ocontext.h
@@ -0,0 +1,10 @@
+#ifndef TEST_OCONTEXT_H__
+#define TEST_OCONTEXT_H__
+
+#include <CUnit/Basic.h>
+
+int ocontext_test_init(void);
+int ocontext_test_cleanup(void);
+int ocontext_add_tests(CU_pSuite suite);
+
+#endif
-- 
2.55.0

