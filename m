Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40E3A0B24
	for <selinux@vger.kernel.org>; Wed,  7 Jan 2026 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767823050; cv=none; b=PF4ctCwHMkY55739yuq7MI2A/6Bb+6qZO9Z1ab402F4gBrJjx/oBB7lZFm6r3uLZ5sX4crrkrTt4c0kjVCtwqPC5B98DhNFoY2rWIICby9+j8lTLplzjr/YjQhXOqPPMOweSYg6C7hpZ78CIr9InNPWMsKhfJEbLBb/wt1nKVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767823050; c=relaxed/simple;
	bh=ld5g/Yka5kCmy1RwGWjxucQKx6vp95FWEEfSX2SPFjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEf2wsFOi1mYRLD+Imt7EgnjJ/g/xGw2R1pKBHn2bkw249V1YyxuFXIftqr8xLBlfA7uCMR8xcmdwFoHyE+Qn+UoKr03KJLetfaNOl9jFcH4pi++772C+Ies/73Yx2eLXvejecVYAlIW+R570aAceQRlznCKTHhidVOa1fJOzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKl9wBIp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKl9wBIp"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a12ebe4b74so27089215ad.0
        for <selinux@vger.kernel.org>; Wed, 07 Jan 2026 13:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767823048; x=1768427848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzMqE7Ukm/1nTuofeGks9ReACaQl0a93GIw32CsPM2M=;
        b=RKl9wBIpwtXKGCZUHgo0BFouFv6Z6aAM/CuS7UKmcj95Dsq7mCUZhU3GowDJfq3n/6
         wvlF3cFLeQCziKb8A9iyoukpO+SYhLUb+Pp/v8wUiMY44u8Mp/JtSOeJVt6RsFI3VyNO
         MV6JMJvkYGRTnEUOyetXRXari8uq8910U8N97sAhnMGifnRW2+dWfUJokeegMr4H1rGn
         7p1OmHkBfAn3g4pDqUbDOHjniklAvHtteo8tGOz9rZW6+5FAmNbKd7RJBTRVb6tkBu3H
         VzsY/cp8XKh8TBnI39Kz21piBP/+VoCUbcFavHNKheLQwonJR2mph5hdV60j/jtSSlj2
         T+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767823048; x=1768427848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nzMqE7Ukm/1nTuofeGks9ReACaQl0a93GIw32CsPM2M=;
        b=eabM3P8SsW2/bRjs76DYQrzlQUch6fdIqqgfInAONQvXyJfhvx92hKXT1ZQH6jsXS5
         MLTQsxyhoF4TNYTOpOL7SGvZpO7ZoQEDSgrfn8X4Y2DXZss2/sRPHwLYWObNsU/bcbYX
         Wzjg5osjwpDz4iTLLcyRYYFPfoQ8JGdma1n1q1RIM51owKKIvjZiHh/SWRFKsQ3RDaxd
         yCbaMO8m0K3k5in3LO++1cDUohDeuNMo5qYLa730bu7xbX1T3PPUGvDCEcUcyJeB6xMe
         EwOzYr6ENwybMmwHJjOj9av3bNdxaWMgzaO2wPiXepTp49POx0nxVZtXiV7q1VwT8mv/
         BexA==
X-Forwarded-Encrypted: i=1; AJvYcCXGESQiVQiFJhf+6P6vPr5WExD1RZaunNt+gQV58PlJbm8FdPbzb+s06dD6CYlZXghlnmnn3U09@vger.kernel.org
X-Gm-Message-State: AOJu0YzHzSqyyPkr9HsdQV8k0GTjltdUInJV96NzLYCrLSvg9GJyUaBH
	K95k/QlnDmHYe3zk2n17qMA7YPzvbBPtIrzXUWKaLPeNe01sBxOJAwSpA98sfQPi
X-Gm-Gg: AY/fxX4Kw9JnYb4zn9ANszWrlp+W5oilTvEfzHTFmJcQME2uaiRj59ouMtLz4Hd/ph2
	iYAfwcUv4PR8QiejeyJZMTkUvKxaWj/eUqgnLxcAFZEUh+h2YaPXI1aMYlkeAseOahJIadlkIkP
	YWBIshDaKuNYu4eyv4Ah7qUZnCB4M4Q/XFWTmGr+zMPEzxp5s90UtT5Jf9z0w3FGjFC+dEaQH6w
	kzB67A1uc2GDed7wRztNu2RjfNZH6ppCF5/Tp7cTcRlX7zqIaJ/EDQXbR1uDWytzjXwd6BOC2ac
	aodPBTds8Fq9T5PvtliNJngQEXOVLWZC0gjhzyltXUfdQ8wKIlLbif/fyQSKsbKd++No7kXzhOj
	+F6ZTcZthsy87zdwscr85zKTCnytgFLQDKEeLq1Sr8ruIfSRRX5zCGks4ZIwqt9R1CJXZCHYTAk
	qBGJ/VQ8bnLufk0aqQ1tPiqbTtpD63PmIg8C6F0TZaDI6JgwNP6R8=
X-Google-Smtp-Source: AGHT+IGxTopweeKWfvBMX7POnVAWvKalFESWcSVAYjlWWWdte8AeGCD1/aFGyKy2QdvEv0F9P4eMxw==
X-Received: by 2002:a17:902:f691:b0:295:596f:8507 with SMTP id d9443c01a7336-2a3ee340ca1mr40711735ad.0.1767823048345;
        Wed, 07 Jan 2026 13:57:28 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:982:6040::1b51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a311sm60005345ad.19.2026.01.07.13.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 13:57:27 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: serge@hallyn.com
Cc: foster.ryan.r@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	selinux@vger.kernel.org
Subject: [PATCH v6] security: Add KUnit tests for kuid_root_in_ns and vfsuid_root_in_currentns
Date: Wed,  7 Jan 2026 13:51:28 -0800
Message-ID: <20260107215725.105822-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aV15rKEt3rvW3hBK@mail.hallyn.com>
References: <aV15rKEt3rvW3hBK@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Here's v6 with both fixes combined. The Dec 29 version you have in caps-next 
is correct for the namespace config - v6 keeps that and adds the KUNIT=y 
dependency to fix the Intel CI build error.

Changes in v6:
- Namespace config: all three namespaces are independent children of 
  init_user_ns (same as Dec 29 you reviewed)
  
- Build fix: depends on KUNIT=y prevents link errors when KUNIT=m

The Dec 30 patch accidentally reverted the namespace fix when I was adding the 
KUNIT=y part. This v6 has both fixes working together.

Thanks, Ryan

Add comprehensive KUnit tests for the namespace-related capability
functions that Serge Hallyn refactored in commit 9891d2f79a9f
("Clarify the rootid_owns_currentns").

The tests verify:
- Basic functionality: UID 0 in init namespace, invalid vfsuid,
  non-zero UIDs
- Actual namespace traversal: Creating user namespaces with different
  UID mappings where uid 0 maps to different kuids (e.g., 1000, 2000,
  3000)
- Hierarchy traversal: Testing multiple nested namespaces to verify
  correct namespace hierarchy traversal

This addresses the feedback to "test the actual functionality" by
creating real user namespaces with different values for the
namespace's uid 0, rather than just basic input validation.

The test file is included at the end of commoncap.c when
CONFIG_SECURITY_COMMONCAP_KUNIT_TEST is enabled, following the
standard kernel pattern (e.g., scsi_lib.c, ext4/mballoc.c). This
allows tests to access static functions in the same compilation unit
without modifying production code based on test configuration.

The tests require CONFIG_USER_NS to be enabled since they rely on user
namespace mapping functionality. The Kconfig dependency ensures the
tests only build when this requirement is met.

All 7 tests pass:
- test_vfsuid_root_in_currentns_init_ns
- test_vfsuid_root_in_currentns_invalid
- test_vfsuid_root_in_currentns_nonzero
- test_kuid_root_in_ns_init_ns_uid0
- test_kuid_root_in_ns_init_ns_nonzero
- test_kuid_root_in_ns_with_mapping
- test_kuid_root_in_ns_with_different_mappings

Updated MAINTAINER capabilities to include commoncap test

Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>
---
 MAINTAINERS               |   1 +
 security/Kconfig          |  17 +++
 security/commoncap.c      |   4 +
 security/commoncap_test.c | 288 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 310 insertions(+)
 create mode 100644 security/commoncap_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c0030e126fc8..6f162c736dfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5682,6 +5682,7 @@ F:	include/trace/events/capability.h
 F:	include/uapi/linux/capability.h
 F:	kernel/capability.c
 F:	security/commoncap.c
+F:	security/commoncap_test.c
 
 CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
 M:	Kevin Tsai <ktsai@capellamicro.com>
diff --git a/security/Kconfig b/security/Kconfig
index 285f284dfcac..6a4393fce9a1 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -284,6 +284,23 @@ config LSM
 
 	  If unsure, leave this as the default.
 
+config SECURITY_COMMONCAP_KUNIT_TEST
+	bool "Build KUnit tests for commoncap" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && USER_NS
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the commoncap KUnit tests.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (https://testanything.org/). Only useful for kernel devs
+	  running KUnit test harness and are not for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 source "security/Kconfig.hardening"
 
 endmenu
diff --git a/security/commoncap.c b/security/commoncap.c
index 8a23dfab7fac..3399535808fe 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1521,3 +1521,7 @@ DEFINE_LSM(capability) = {
 };
 
 #endif /* CONFIG_SECURITY */
+
+#ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
+#include "commoncap_test.c"
+#endif
diff --git a/security/commoncap_test.c b/security/commoncap_test.c
new file mode 100644
index 000000000000..e9b278be37f1
--- /dev/null
+++ b/security/commoncap_test.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * KUnit tests for commoncap.c security functions
+ *
+ * Tests for security-critical functions in the capability subsystem,
+ * particularly namespace-related capability checks.
+ */
+
+#include <kunit/test.h>
+#include <linux/user_namespace.h>
+#include <linux/uidgid.h>
+#include <linux/cred.h>
+#include <linux/mnt_idmapping.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/refcount.h>
+
+#ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
+
+/* Functions are static in commoncap.c, but we can call them since we're
+ * included in the same compilation unit when tests are enabled.
+ */
+
+/**
+ * test_vfsuid_root_in_currentns_init_ns - Test vfsuid_root_in_currentns with init ns
+ *
+ * Verifies that UID 0 in the init namespace correctly owns the current
+ * namespace when running in init_user_ns.
+ *
+ * @test: KUnit test context
+ */
+static void test_vfsuid_root_in_currentns_init_ns(struct kunit *test)
+{
+	vfsuid_t vfsuid;
+	kuid_t kuid;
+
+	/* Create UID 0 in init namespace */
+	kuid = KUIDT_INIT(0);
+	vfsuid = VFSUIDT_INIT(kuid);
+
+	/* In init namespace, UID 0 should own current namespace */
+	KUNIT_EXPECT_TRUE(test, vfsuid_root_in_currentns(vfsuid));
+}
+
+/**
+ * test_vfsuid_root_in_currentns_invalid - Test vfsuid_root_in_currentns with invalid vfsuid
+ *
+ * Verifies that an invalid vfsuid correctly returns false.
+ *
+ * @test: KUnit test context
+ */
+static void test_vfsuid_root_in_currentns_invalid(struct kunit *test)
+{
+	vfsuid_t invalid_vfsuid;
+
+	/* Use the predefined invalid vfsuid */
+	invalid_vfsuid = INVALID_VFSUID;
+
+	/* Invalid vfsuid should return false */
+	KUNIT_EXPECT_FALSE(test, vfsuid_root_in_currentns(invalid_vfsuid));
+}
+
+/**
+ * test_vfsuid_root_in_currentns_nonzero - Test vfsuid_root_in_currentns with non-zero UID
+ *
+ * Verifies that a non-zero UID correctly returns false.
+ *
+ * @test: KUnit test context
+ */
+static void test_vfsuid_root_in_currentns_nonzero(struct kunit *test)
+{
+	vfsuid_t vfsuid;
+	kuid_t kuid;
+
+	/* Create a non-zero UID */
+	kuid = KUIDT_INIT(1000);
+	vfsuid = VFSUIDT_INIT(kuid);
+
+	/* Non-zero UID should return false */
+	KUNIT_EXPECT_FALSE(test, vfsuid_root_in_currentns(vfsuid));
+}
+
+/**
+ * test_kuid_root_in_ns_init_ns_uid0 - Test kuid_root_in_ns with init namespace and UID 0
+ *
+ * Verifies that kuid_root_in_ns correctly identifies UID 0 in init namespace.
+ * This tests the core namespace traversal logic. In init namespace, UID 0
+ * maps to itself, so it should own the namespace.
+ *
+ * @test: KUnit test context
+ */
+static void test_kuid_root_in_ns_init_ns_uid0(struct kunit *test)
+{
+	kuid_t kuid;
+	struct user_namespace *init_ns;
+
+	kuid = KUIDT_INIT(0);
+	init_ns = &init_user_ns;
+
+	/* UID 0 should own init namespace */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(kuid, init_ns));
+}
+
+/**
+ * test_kuid_root_in_ns_init_ns_nonzero - Test kuid_root_in_ns with init namespace and non-zero UID
+ *
+ * Verifies that kuid_root_in_ns correctly rejects non-zero UIDs in init namespace.
+ * Only UID 0 should own a namespace.
+ *
+ * @test: KUnit test context
+ */
+static void test_kuid_root_in_ns_init_ns_nonzero(struct kunit *test)
+{
+	kuid_t kuid;
+	struct user_namespace *init_ns;
+
+	kuid = KUIDT_INIT(1000);
+	init_ns = &init_user_ns;
+
+	/* Non-zero UID should not own namespace */
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(kuid, init_ns));
+}
+
+/**
+ * create_test_user_ns_with_mapping - Create a mock user namespace with UID mapping
+ *
+ * Creates a minimal user namespace structure for testing where uid 0 in the
+ * namespace maps to a specific kuid in the parent namespace.
+ *
+ * @test: KUnit test context
+ * @parent_ns: Parent namespace (typically init_user_ns)
+ * @mapped_kuid: The kuid that uid 0 in this namespace maps to in parent
+ *
+ * Returns: Pointer to allocated namespace, or NULL on failure
+ */
+static struct user_namespace *create_test_user_ns_with_mapping(struct kunit *test,
+								 struct user_namespace *parent_ns,
+								 kuid_t mapped_kuid)
+{
+	struct user_namespace *ns;
+	struct uid_gid_extent extent;
+
+	/* Allocate a test namespace - use kzalloc to zero all fields */
+	ns = kunit_kzalloc(test, sizeof(*ns), GFP_KERNEL);
+	if (!ns)
+		return NULL;
+
+	/* Initialize basic namespace structure fields */
+	ns->parent = parent_ns;
+	ns->level = parent_ns ? parent_ns->level + 1 : 0;
+	ns->owner = mapped_kuid;
+	ns->group = KGIDT_INIT(0);
+
+	/* Initialize ns_common structure */
+	refcount_set(&ns->ns.__ns_ref, 1);
+	ns->ns.inum = 0; /* Mock inum */
+
+	/* Set up uid mapping: uid 0 in this namespace maps to mapped_kuid in parent
+	 * Format: first (uid in ns) : lower_first (kuid in parent) : count
+	 * So: uid 0 in ns -> kuid mapped_kuid in parent
+	 * This means from_kuid(ns, mapped_kuid) returns 0
+	 */
+	extent.first = 0;                              /* uid 0 in this namespace */
+	extent.lower_first = __kuid_val(mapped_kuid);  /* maps to this kuid in parent */
+	extent.count = 1;
+
+	ns->uid_map.extent[0] = extent;
+	ns->uid_map.nr_extents = 1;
+
+	/* Set up gid mapping: gid 0 maps to gid 0 in parent (simplified) */
+	extent.first = 0;
+	extent.lower_first = 0;
+	extent.count = 1;
+
+	ns->gid_map.extent[0] = extent;
+	ns->gid_map.nr_extents = 1;
+
+	return ns;
+}
+
+/**
+ * test_kuid_root_in_ns_with_mapping - Test kuid_root_in_ns with namespace where uid 0
+ *				       maps to different kuid
+ *
+ * Creates a user namespace where uid 0 maps to kuid 1000 in the parent namespace.
+ * Verifies that kuid_root_in_ns correctly identifies kuid 1000 as owning the namespace.
+ *
+ * Note: kuid_root_in_ns walks up the namespace hierarchy, so it checks the current
+ * namespace first, then parent, then parent's parent, etc. So:
+ * - kuid 1000 owns test_ns because from_kuid(test_ns, 1000) == 0
+ * - kuid 0 also owns test_ns because from_kuid(init_user_ns, 0) == 0
+ *   (checked in parent)
+ *
+ * This tests the actual functionality as requested: creating namespaces with
+ * different values for the namespace's uid 0.
+ *
+ * @test: KUnit test context
+ */
+static void test_kuid_root_in_ns_with_mapping(struct kunit *test)
+{
+	struct user_namespace *test_ns;
+	struct user_namespace *parent_ns;
+	kuid_t mapped_kuid, other_kuid;
+
+	parent_ns = &init_user_ns;
+	mapped_kuid = KUIDT_INIT(1000);
+	other_kuid = KUIDT_INIT(2000);
+
+	test_ns = create_test_user_ns_with_mapping(test, parent_ns, mapped_kuid);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_ns);
+
+	/* kuid 1000 should own test_ns because it maps to uid 0 in test_ns */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(mapped_kuid, test_ns));
+
+	/* kuid 0 should also own test_ns (checked via parent init_user_ns) */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), test_ns));
+
+	/* Other kuids should not own test_ns */
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(other_kuid, test_ns));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(500), test_ns));
+}
+
+/**
+ * test_kuid_root_in_ns_with_different_mappings - Test with multiple namespaces
+ *
+ * Creates multiple user namespaces with different UID mappings to verify
+ * that kuid_root_in_ns correctly distinguishes between namespaces.
+ *
+ * Each namespace maps uid 0 to a different kuid, and we verify that each
+ * kuid only owns its corresponding namespace (plus kuid 0 owns all via
+ * init_user_ns parent).
+ *
+ * @test: KUnit test context
+ */
+static void test_kuid_root_in_ns_with_different_mappings(struct kunit *test)
+{
+	struct user_namespace *ns1, *ns2, *ns3;
+
+	/* Create three independent namespaces, each mapping uid 0 to different kuids */
+	ns1 = create_test_user_ns_with_mapping(test, &init_user_ns, KUIDT_INIT(1000));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns1);
+
+	ns2 = create_test_user_ns_with_mapping(test, &init_user_ns, KUIDT_INIT(2000));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns2);
+
+	ns3 = create_test_user_ns_with_mapping(test, &init_user_ns, KUIDT_INIT(3000));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns3);
+
+	/* Test ns1: kuid 1000 owns it, kuid 0 owns it (via parent), others do not */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(1000), ns1));
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), ns1));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(2000), ns1));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(3000), ns1));
+
+	/* Test ns2: kuid 2000 owns it, kuid 0 owns it (via parent), others do not */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(2000), ns2));
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), ns2));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(1000), ns2));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(3000), ns2));
+
+	/* Test ns3: kuid 3000 owns it, kuid 0 owns it (via parent), others do not */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(3000), ns3));
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), ns3));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(1000), ns3));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(2000), ns3));
+}
+
+static struct kunit_case commoncap_test_cases[] = {
+	KUNIT_CASE(test_vfsuid_root_in_currentns_init_ns),
+	KUNIT_CASE(test_vfsuid_root_in_currentns_invalid),
+	KUNIT_CASE(test_vfsuid_root_in_currentns_nonzero),
+	KUNIT_CASE(test_kuid_root_in_ns_init_ns_uid0),
+	KUNIT_CASE(test_kuid_root_in_ns_init_ns_nonzero),
+	KUNIT_CASE(test_kuid_root_in_ns_with_mapping),
+	KUNIT_CASE(test_kuid_root_in_ns_with_different_mappings),
+	{}
+};
+
+static struct kunit_suite commoncap_test_suite = {
+	.name = "commoncap",
+	.test_cases = commoncap_test_cases,
+};
+
+kunit_test_suite(commoncap_test_suite);
+
+MODULE_LICENSE("GPL");
+
+#endif /* CONFIG_SECURITY_COMMONCAP_KUNIT_TEST */
-- 
2.52.0

