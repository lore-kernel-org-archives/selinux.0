Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254EB5227;
	Tue, 11 Nov 2025 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821631; cv=none; b=Cu0p/9mnC06Xs7Jlm6+rEdOVVIPmox/hzbvVzj2VGcuJKk0FAJfuXZMCMx6m0Y0qrTLS7mvbOgHIHgaDefrVf20Uegb0sfj6LWNsrfMw4Ny3XDF2LsbJdT0yrfbns1tpyHEMV5ExYRMRY1lsD2h3rY/K4o+B5uLw7UXRdKR3N3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821631; c=relaxed/simple;
	bh=VcdPLs3EB//q4aR6+ynLP7yXQxBJC2aRhBa0wVKo43g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRmwWFmUZss48mhrW7L1hAH1o4hCRMPdtWjflywnWD/EnzG4Mk9jm4NahvEnfj5RCFt0tZAfZZPj6VgtVVmJDK6WZIvGgw2bPfuGzkvc9+Z8FIaXb8ezvXQl42l5My964e0GtB1DM79PRvdHWjS+/OpW49PoQSQNGV2yt5LYdOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 519EE160B; Mon, 10 Nov 2025 18:33:29 -0600 (CST)
Date: Mon, 10 Nov 2025 18:33:29 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Ryan Foster <foster.ryan.r@gmail.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, serge@hallyn.com, paul@paul-moore.com
Subject: Re: [PATCH] security: Add KUnit tests for rootid_owns_currentns()
Message-ID: <aRKEWVse2AzperzG@mail.hallyn.com>
References: <20251110143748.4144288-1-foster.ryan.r@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110143748.4144288-1-foster.ryan.r@gmail.com>

On Mon, Nov 10, 2025 at 06:37:48AM -0800, Ryan Foster wrote:
> The rootid_owns_currentns() function in security/commoncap.c is a
> security-critical function used to determine if a root ID from a
> parent namespace owns the current namespace. This function is used
> in multiple security-critical paths:
> 
> 1. cap_inode_getsecurity() - file capability retrieval
> 2. get_vfs_caps_from_disk() - file capability loading during exec
> 
> Despite its security-critical nature, this function had no test
> coverage. This patch adds KUnit tests to verify the function's
> behavior in various scenarios:
> 
> - Root ID in init namespace (positive case)
> - Invalid vfsuid (negative case)
> - Non-root UID (negative case)

I'd be more excited about this if it tested the actual
functionality.

The rootid_owns_currentns() could be split so that it calls
a (static if not testing) inline rootid_owns_userns(), and
then you test the latter.  Then create a few user namespaces
with different values for the namespace's uid 0, and make
sure rootid_owns_userns(testns, testuid) behaves correctly.

Actually, this function should probably be renamed.
"rootid_owns_currentns()" is not correct.  It should just be
"uid_owns_currentns()".

> The function is made testable by exporting it when
> CONFIG_SECURITY_COMMONCAP_KUNIT_TEST is enabled, while maintaining
> static visibility in production builds.
> 
> This follows the pattern established by other security subsystems
> (IPE, Landlock) for KUnit testing.
> 
> Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>
> ---
>  security/Kconfig          |  17 ++++++
>  security/Makefile         |   1 +
>  security/commoncap.c      |   5 ++
>  security/commoncap_test.c | 109 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 132 insertions(+)
>  create mode 100644 security/commoncap_test.c
> 
> diff --git a/security/Kconfig b/security/Kconfig
> index 285f284dfcac..c7b3f42ef875 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -284,6 +284,23 @@ config LSM
>  
>  	  If unsure, leave this as the default.
>  
> +config SECURITY_COMMONCAP_KUNIT_TEST
> +	bool "Build KUnit tests for commoncap" if !KUNIT_ALL_TESTS
> +	depends on KUNIT=y
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
> diff --git a/security/Makefile b/security/Makefile
> index 22ff4c8bd8ce..5b1285fde552 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_KEYS)			+= keys/
>  
>  # always enable default capabilities
>  obj-y					+= commoncap.o
> +obj-$(CONFIG_SECURITY_COMMONCAP_KUNIT_TEST)	+= commoncap_test.o
>  obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
>  obj-$(CONFIG_MMU)			+= min_addr.o
>  
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 6bd4adeb4795..4d0e014ce7cd 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -358,7 +358,12 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
>  	return error;
>  }
>  
> +#ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
> +bool rootid_owns_currentns(vfsuid_t rootvfsuid);
> +bool rootid_owns_currentns(vfsuid_t rootvfsuid)
> +#else
>  static bool rootid_owns_currentns(vfsuid_t rootvfsuid)
> +#endif
>  {
>  	struct user_namespace *ns;
>  	kuid_t kroot;
> diff --git a/security/commoncap_test.c b/security/commoncap_test.c
> new file mode 100644
> index 000000000000..9757d433d314
> --- /dev/null
> +++ b/security/commoncap_test.c
> @@ -0,0 +1,109 @@
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
> +#include <linux/module.h>
> +
> +/* We need to include the actual vfsuid_t definition but avoid the problematic
> + * inline functions in mnt_idmapping.h. Include just the type definitions.
> + */
> +#include <linux/types.h>
> +
> +/* Forward declare the minimal types we need - match the actual kernel definitions */
> +struct mnt_idmap;
> +typedef struct {
> +	uid_t val;
> +} vfsuid_t;
> +
> +/* Minimal macros we need - match kernel definitions from mnt_idmapping.h */
> +static inline uid_t __vfsuid_val(vfsuid_t uid)
> +{
> +	return uid.val;
> +}
> +
> +#define VFSUIDT_INIT(val) ((vfsuid_t){ __kuid_val(val) })
> +#define INVALID_VFSUID VFSUIDT_INIT(INVALID_UID)
> +
> +#ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
> +
> +/* Forward declaration - function is exported when KUNIT_TEST is enabled */
> +extern bool rootid_owns_currentns(vfsuid_t rootvfsuid);
> +
> +/**
> + * test_rootid_owns_currentns_init_ns - Test rootid_owns_currentns with init ns
> + *
> + * Verifies that a root ID in the init namespace correctly owns the current
> + * namespace when running in init_user_ns.
> + */
> +static void test_rootid_owns_currentns_init_ns(struct kunit *test)
> +{
> +	vfsuid_t root_vfsuid;
> +	kuid_t root_kuid;
> +
> +	/* Create a root UID in init namespace */
> +	root_kuid = KUIDT_INIT(0);
> +	root_vfsuid = VFSUIDT_INIT(root_kuid);
> +
> +	/* In init namespace, root should own current namespace */
> +	KUNIT_EXPECT_TRUE(test, rootid_owns_currentns(root_vfsuid));
> +}
> +
> +/**
> + * test_rootid_owns_currentns_invalid - Test rootid_owns_currentns with invalid vfsuid
> + *
> + * Verifies that an invalid vfsuid correctly returns false.
> + */
> +static void test_rootid_owns_currentns_invalid(struct kunit *test)
> +{
> +	vfsuid_t invalid_vfsuid;
> +
> +	/* Use the predefined invalid vfsuid */
> +	invalid_vfsuid = INVALID_VFSUID;
> +
> +	/* Invalid vfsuid should return false */
> +	KUNIT_EXPECT_FALSE(test, rootid_owns_currentns(invalid_vfsuid));
> +}
> +
> +/**
> + * test_rootid_owns_currentns_nonroot - Test rootid_owns_currentns with non-root UID
> + *
> + * Verifies that a non-root UID correctly returns false.
> + */
> +static void test_rootid_owns_currentns_nonroot(struct kunit *test)
> +{
> +	vfsuid_t nonroot_vfsuid;
> +	kuid_t nonroot_kuid;
> +
> +	/* Create a non-root UID */
> +	nonroot_kuid = KUIDT_INIT(1000);
> +	nonroot_vfsuid = VFSUIDT_INIT(nonroot_kuid);
> +
> +	/* Non-root UID should return false */
> +	KUNIT_EXPECT_FALSE(test, rootid_owns_currentns(nonroot_vfsuid));
> +}
> +
> +static struct kunit_case commoncap_test_cases[] = {
> +	KUNIT_CASE(test_rootid_owns_currentns_init_ns),
> +	KUNIT_CASE(test_rootid_owns_currentns_invalid),
> +	KUNIT_CASE(test_rootid_owns_currentns_nonroot),
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
> +
> -- 
> 2.43.0
