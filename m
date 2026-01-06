Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F71CDFD5;
	Tue,  6 Jan 2026 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767734034; cv=none; b=QTTCGQrQbXF3vpJSXFZFXFevXyaafYG3ldpBrZNTlUXGOoYtRn0hzfRBMLziKUhBaO9Kb1ydODg+L47/lQXjNxhaw4z/H91xm+3NlSE5LJhg25ItwpZBahFpcWrqy+9Ku3WWRxzDrpfZ8T4oac7Kh/ZaWcdnppr/YQpJgCA1C+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767734034; c=relaxed/simple;
	bh=0lEV6ajBs4Gpk9qB2yBKOeU84h21WjTzJM9EQ0H9M0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBTawPFAVB79UdRiTRcHzeGCFrkOFGPvOYxs9JAbaYL/SbkmTVzu3KC3K7Iq8zFcMs2HUCNrCPGtir9om/ap7U8tvE9UVCCxr6sygYtejTEFIIaIMO2ae1GUglge2OTyGkqcy+RSXF1ijFul96bLEQ9aA7oiftEZ5slTuKXSGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=3GoO97Jv; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="3GoO97Jv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1767733676; bh=0lEV6ajBs4Gpk9qB2yBKOeU84h21WjTzJM9EQ0H9M0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=3GoO97JvagvpmKKSDq2j3120LxfxD79TpqP8nooOVv352tyBdMwckTVAMb5ZyOgKZ
	 76dhdqk39CWq5FdmvVJMdDC5ZauMCipBuh/jKChDrA86h2bqhmzogaZ3FemCUA6ruV
	 a0VlhlcQaeND4DN33VDfiLt/bUViPiszhI9CeYV+zAtTu4j36EvdEcm3nnbJwQ3Fca
	 dDxfZUkK8O5Web+G3XFfjRaLIQv38GOZt3ou0FRwuTTkF4zlZLS6HB43Mj5JgDE1GK
	 QwNpCtdZRqkRjEqloIN3O6kFb/Aq6tPBtLF4DaVFpuLE6+kI8FDwu5+07xV7rgUenK
	 ++ZRpqWGvvetg==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 3B3976B2; Tue,  6 Jan 2026 15:07:56 -0600 (CST)
Date: Tue, 6 Jan 2026 15:07:56 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Ryan Foster <foster.ryan.r@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	paul@paul-moore.com, selinux@vger.kernel.org, serge@hallyn.com
Subject: Re: [PATCH v5] security: Add KUnit tests for kuid_root_in_ns and
 vfsuid_root_in_currentns
Message-ID: <aV15rKEt3rvW3hBK@mail.hallyn.com>
References: <20251110143748.4144288-1-foster.ryan.r@gmail.com>
 <20251230151450.196371-1-foster.ryan.r@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230151450.196371-1-foster.ryan.r@gmail.com>

On Tue, Dec 30, 2025 at 07:13:09AM -0800, Ryan Foster wrote:
> Hi all,
> Sorry for the spam, this aims to fix both issues. Attempted to reproduce
> CI config build locally.
> Thanks, Ryan
> ---
> 
> Add comprehensive KUnit tests for the namespace-related capability
> functions that Serge Hallyn refactored in commit 9891d2f79a9f
> ("Clarify the rootid_owns_currentns").
> 
> The tests verify:
> - Basic functionality: UID 0 in init namespace, invalid vfsuid,
>   non-zero UIDs
> - Actual namespace traversal: Creating user namespaces with different
>   UID mappings where uid 0 maps to different kuids (e.g., 1000, 2000,
>   3000)
> - Hierarchy traversal: Testing multiple nested namespaces to verify
>   correct namespace hierarchy traversal
> 
> This addresses the feedback to "test the actual functionality" by
> creating real user namespaces with different values for the
> namespace's uid 0, rather than just basic input validation.
> 
> The test file is included at the end of commoncap.c when
> CONFIG_SECURITY_COMMONCAP_KUNIT_TEST is enabled, following the
> standard kernel pattern (e.g., scsi_lib.c, ext4/mballoc.c). This
> allows tests to access static functions in the same compilation unit
> without modifying production code based on test configuration.
> 
> The tests require CONFIG_USER_NS to be enabled since they rely on user
> namespace mapping functionality. The Kconfig dependency ensures the
> tests only build when this requirement is met.
> 
> All 7 tests pass:
> - test_vfsuid_root_in_currentns_init_ns
> - test_vfsuid_root_in_currentns_invalid
> - test_vfsuid_root_in_currentns_nonzero
> - test_kuid_root_in_ns_init_ns_uid0
> - test_kuid_root_in_ns_init_ns_nonzero
> - test_kuid_root_in_ns_with_mapping
> - test_kuid_root_in_ns_with_different_mappings
> 
> Updated MAINTAINER capabilities to include commoncap test
> 
> Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>

I've applied this one to #caps-next.  I note that there is another v5
which was sent the next day, but this patch seemed more correct.
Although I did prefer the commit message in the other one.  Please
let me know if I should switch them, although if so, then I think
you need a v6, because the ns3 test seemed broken in the other one.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

Thanks,
-serge

> ---
>  MAINTAINERS               |   1 +
>  security/Kconfig          |  17 +++
>  security/commoncap.c      |   4 +
>  security/commoncap_test.c | 290 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 312 insertions(+)
>  create mode 100644 security/commoncap_test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0030e126fc8..6f162c736dfb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5682,6 +5682,7 @@ F:	include/trace/events/capability.h
>  F:	include/uapi/linux/capability.h
>  F:	kernel/capability.c
>  F:	security/commoncap.c
> +F:	security/commoncap_test.c
>  
>  CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
>  M:	Kevin Tsai <ktsai@capellamicro.com>
> diff --git a/security/Kconfig b/security/Kconfig
> index 285f284dfcac..6a4393fce9a1 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -284,6 +284,23 @@ config LSM
>  
>  	  If unsure, leave this as the default.
>  
> +config SECURITY_COMMONCAP_KUNIT_TEST
> +	bool "Build KUnit tests for commoncap" if !KUNIT_ALL_TESTS
> +	depends on KUNIT=y && USER_NS
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the commoncap KUnit tests.
> +
> +	  KUnit tests run during boot and output the results to the debug log
> +	  in TAP format (https://testanything.org/). Only useful for kernel devs
> +	  running KUnit test harness and are not for inclusion into a
> +	  production build.
> +
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  source "security/Kconfig.hardening"
>  
>  endmenu
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 8a23dfab7fac..3399535808fe 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1521,3 +1521,7 @@ DEFINE_LSM(capability) = {
>  };
>  
>  #endif /* CONFIG_SECURITY */
> +
> +#ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
> +#include "commoncap_test.c"
> +#endif
> diff --git a/security/commoncap_test.c b/security/commoncap_test.c
> new file mode 100644
> index 000000000000..1088364a54e6
> --- /dev/null
> +++ b/security/commoncap_test.c
> @@ -0,0 +1,290 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * KUnit tests for commoncap.c security functions
> + *
> + * Tests for security-critical functions in the capability subsystem,
> + * particularly namespace-related capability checks.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/user_namespace.h>
> +#include <linux/uidgid.h>
> +#include <linux/cred.h>
> +#include <linux/mnt_idmapping.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/refcount.h>
> +
> +#ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
> +
> +/* Functions are static in commoncap.c, but we can call them since we're
> + * included in the same compilation unit when tests are enabled.
> + */
> +
> +/**
> + * test_vfsuid_root_in_currentns_init_ns - Test vfsuid_root_in_currentns with init ns
> + *
> + * Verifies that UID 0 in the init namespace correctly owns the current
> + * namespace when running in init_user_ns.
> + *
> + * @test: KUnit test context
> + */
> +static void test_vfsuid_root_in_currentns_init_ns(struct kunit *test)
> +{
> +	vfsuid_t vfsuid;
> +	kuid_t kuid;
> +
> +	/* Create UID 0 in init namespace */
> +	kuid = KUIDT_INIT(0);
> +	vfsuid = VFSUIDT_INIT(kuid);
> +
> +	/* In init namespace, UID 0 should own current namespace */
> +	KUNIT_EXPECT_TRUE(test, vfsuid_root_in_currentns(vfsuid));
> +}
> +
> +/**
> + * test_vfsuid_root_in_currentns_invalid - Test vfsuid_root_in_currentns with invalid vfsuid
> + *
> + * Verifies that an invalid vfsuid correctly returns false.
> + *
> + * @test: KUnit test context
> + */
> +static void test_vfsuid_root_in_currentns_invalid(struct kunit *test)
> +{
> +	vfsuid_t invalid_vfsuid;
> +
> +	/* Use the predefined invalid vfsuid */
> +	invalid_vfsuid = INVALID_VFSUID;
> +
> +	/* Invalid vfsuid should return false */
> +	KUNIT_EXPECT_FALSE(test, vfsuid_root_in_currentns(invalid_vfsuid));
> +}
> +
> +/**
> + * test_vfsuid_root_in_currentns_nonzero - Test vfsuid_root_in_currentns with non-zero UID
> + *
> + * Verifies that a non-zero UID correctly returns false.
> + *
> + * @test: KUnit test context
> + */
> +static void test_vfsuid_root_in_currentns_nonzero(struct kunit *test)
> +{
> +	vfsuid_t vfsuid;
> +	kuid_t kuid;
> +
> +	/* Create a non-zero UID */
> +	kuid = KUIDT_INIT(1000);
> +	vfsuid = VFSUIDT_INIT(kuid);
> +
> +	/* Non-zero UID should return false */
> +	KUNIT_EXPECT_FALSE(test, vfsuid_root_in_currentns(vfsuid));
> +}
> +
> +/**
> + * test_kuid_root_in_ns_init_ns_uid0 - Test kuid_root_in_ns with init namespace and UID 0
> + *
> + * Verifies that kuid_root_in_ns correctly identifies UID 0 in init namespace.
> + * This tests the core namespace traversal logic. In init namespace, UID 0
> + * maps to itself, so it should own the namespace.
> + *
> + * @test: KUnit test context
> + */
> +static void test_kuid_root_in_ns_init_ns_uid0(struct kunit *test)
> +{
> +	kuid_t kuid;
> +	struct user_namespace *init_ns;
> +
> +	kuid = KUIDT_INIT(0);
> +	init_ns = &init_user_ns;
> +
> +	/* UID 0 should own init namespace */
> +	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(kuid, init_ns));
> +}
> +
> +/**
> + * test_kuid_root_in_ns_init_ns_nonzero - Test kuid_root_in_ns with init namespace and non-zero UID
> + *
> + * Verifies that kuid_root_in_ns correctly rejects non-zero UIDs in init namespace.
> + * Only UID 0 should own a namespace.
> + *
> + * @test: KUnit test context
> + */
> +static void test_kuid_root_in_ns_init_ns_nonzero(struct kunit *test)
> +{
> +	kuid_t kuid;
> +	struct user_namespace *init_ns;
> +
> +	kuid = KUIDT_INIT(1000);
> +	init_ns = &init_user_ns;
> +
> +	/* Non-zero UID should not own namespace */
> +	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(kuid, init_ns));
> +}
> +
> +/**
> + * create_test_user_ns_with_mapping - Create a mock user namespace with UID mapping
> + *
> + * Creates a minimal user namespace structure for testing where uid 0 in the
> + * namespace maps to a specific kuid in the parent namespace.
> + *
> + * @test: KUnit test context
> + * @parent_ns: Parent namespace (typically init_user_ns)
> + * @mapped_kuid: The kuid that uid 0 in this namespace maps to in parent
> + *
> + * Returns: Pointer to allocated namespace, or NULL on failure
> + */
> +static struct user_namespace *create_test_user_ns_with_mapping(struct kunit *test,
> +								 struct user_namespace *parent_ns,
> +								 kuid_t mapped_kuid)
> +{
> +	struct user_namespace *ns;
> +	struct uid_gid_extent extent;
> +
> +	/* Allocate a test namespace - use kzalloc to zero all fields */
> +	ns = kunit_kzalloc(test, sizeof(*ns), GFP_KERNEL);
> +	if (!ns)
> +		return NULL;
> +
> +	/* Initialize basic namespace structure fields */
> +	ns->parent = parent_ns;
> +	ns->level = parent_ns ? parent_ns->level + 1 : 0;
> +	ns->owner = mapped_kuid;
> +	ns->group = KGIDT_INIT(0);
> +
> +	/* Initialize ns_common structure */
> +	refcount_set(&ns->ns.__ns_ref, 1);
> +	ns->ns.inum = 0; /* Mock inum */
> +
> +	/* Set up uid mapping: uid 0 in this namespace maps to mapped_kuid in parent
> +	 * Format: first (uid in ns) : lower_first (kuid in parent) : count
> +	 * So: uid 0 in ns -> kuid mapped_kuid in parent
> +	 * This means from_kuid(ns, mapped_kuid) returns 0
> +	 */
> +	extent.first = 0;                              /* uid 0 in this namespace */
> +	extent.lower_first = __kuid_val(mapped_kuid);  /* maps to this kuid in parent */
> +	extent.count = 1;
> +
> +	ns->uid_map.extent[0] = extent;
> +	ns->uid_map.nr_extents = 1;
> +
> +	/* Set up gid mapping: gid 0 maps to gid 0 in parent (simplified) */
> +	extent.first = 0;
> +	extent.lower_first = 0;
> +	extent.count = 1;
> +
> +	ns->gid_map.extent[0] = extent;
> +	ns->gid_map.nr_extents = 1;
> +
> +	return ns;
> +}
> +
> +/**
> + * test_kuid_root_in_ns_with_mapping - Test kuid_root_in_ns with namespace where uid 0
> + *				       maps to different kuid
> + *
> + * Creates a user namespace where uid 0 maps to kuid 1000 in the parent namespace.
> + * Verifies that kuid_root_in_ns correctly identifies kuid 1000 as owning the namespace.
> + *
> + * Note: kuid_root_in_ns walks up the namespace hierarchy, so it checks the current
> + * namespace first, then parent, then parent's parent, etc. So:
> + * - kuid 1000 owns test_ns because from_kuid(test_ns, 1000) == 0
> + * - kuid 0 also owns test_ns because from_kuid(init_user_ns, 0) == 0
> + *   (checked in parent)
> + *
> + * This tests the actual functionality as requested: creating namespaces with
> + * different values for the namespace's uid 0.
> + *
> + * @test: KUnit test context
> + */
> +static void test_kuid_root_in_ns_with_mapping(struct kunit *test)
> +{
> +	struct user_namespace *test_ns;
> +	struct user_namespace *parent_ns;
> +	kuid_t mapped_kuid, other_kuid;
> +
> +	parent_ns = &init_user_ns;
> +	mapped_kuid = KUIDT_INIT(1000);
> +	other_kuid = KUIDT_INIT(2000);
> +
> +	test_ns = create_test_user_ns_with_mapping(test, parent_ns, mapped_kuid);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_ns);
> +
> +	/* kuid 1000 should own test_ns because it maps to uid 0 in test_ns */
> +	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(mapped_kuid, test_ns));
> +
> +	/* kuid 0 should also own test_ns (checked via parent init_user_ns) */
> +	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), test_ns));
> +
> +	/* Other kuids should not own test_ns */
> +	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(other_kuid, test_ns));
> +	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(500), test_ns));
> +}
> +
> +/**
> + * test_kuid_root_in_ns_with_different_mappings - Test with multiple namespaces
> + *
> + * Creates multiple user namespaces with different UID mappings to verify
> + * that kuid_root_in_ns correctly handles different namespace hierarchies.
> + *
> + * Since kuid_root_in_ns walks up the hierarchy, kuids that map to 0 in init_user_ns
> + * will own all namespaces, while kuids that only map to 0 in specific namespaces
> + * will only own those namespaces and their children.
> + *
> + * @test: KUnit test context
> + */
> +static void test_kuid_root_in_ns_with_different_mappings(struct kunit *test)
> +{
> +	struct user_namespace *ns1, *ns2, *ns3;
> +
> +	/* Create ns1 where uid 0 maps to kuid 1000 */
> +	ns1 = create_test_user_ns_with_mapping(test, &init_user_ns, KUIDT_INIT(1000));
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns1);
> +
> +	/* Create ns2 where uid 0 maps to kuid 2000 */
> +	ns2 = create_test_user_ns_with_mapping(test, &init_user_ns, KUIDT_INIT(2000));
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns2);
> +
> +	/* Create ns3 as a child of ns1 where uid 0 maps to kuid 3000 */
> +	ns3 = create_test_user_ns_with_mapping(test, ns1, KUIDT_INIT(3000));
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns3);
> +
> +	/* Test ns1: kuid 1000 owns it, kuid 0 owns it (via parent), kuid 2000 does not */
> +	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(1000), ns1));
> +	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), ns1));
> +	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(2000), ns1));
> +
> +	/* Test ns2: kuid 2000 owns it, kuid 0 owns it (via parent), kuid 1000 does not */
> +	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(2000), ns2));
> +	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), ns2));
> +	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(1000), ns2));
> +
> +	/* Test ns3: kuid 3000 owns it, kuid 1000 owns it (via parent ns1),
> +	 * kuid 0 owns it (via init_user_ns), kuid 2000 does not
> +	 */
> +	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(3000), ns3));
> +	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(1000), ns3));
> +	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), ns3));
> +	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(2000), ns3));
> +}
> +
> +static struct kunit_case commoncap_test_cases[] = {
> +	KUNIT_CASE(test_vfsuid_root_in_currentns_init_ns),
> +	KUNIT_CASE(test_vfsuid_root_in_currentns_invalid),
> +	KUNIT_CASE(test_vfsuid_root_in_currentns_nonzero),
> +	KUNIT_CASE(test_kuid_root_in_ns_init_ns_uid0),
> +	KUNIT_CASE(test_kuid_root_in_ns_init_ns_nonzero),
> +	KUNIT_CASE(test_kuid_root_in_ns_with_mapping),
> +	KUNIT_CASE(test_kuid_root_in_ns_with_different_mappings),
> +	{}
> +};
> +
> +static struct kunit_suite commoncap_test_suite = {
> +	.name = "commoncap",
> +	.test_cases = commoncap_test_cases,
> +};
> +
> +kunit_test_suite(commoncap_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +
> +#endif /* CONFIG_SECURITY_COMMONCAP_KUNIT_TEST */
> -- 
> 2.52.0
> 
