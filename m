Return-Path: <SRS0=oqeB=XT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD512C432C1
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 17:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896E5207FD
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 17:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Urv5sCvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395092AbfIXRPB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:15:01 -0400
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:57792 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395043AbfIXRPB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Sep 2019 13:15:01 -0400
X-EEMSG-check-017: 31494655|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,544,1559520000"; 
   d="scan'208";a="31494655"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Sep 2019 17:11:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569345060; x=1600881060;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9VUMg1Ij1jTcd9DhixszFzBBRrnnqvO1ZYMNAdlEBQ0=;
  b=Urv5sCvAgArqoenUMGBQOx7SFcQ3Neju7Rfj2TaNROZqQl0TpqnEuzQq
   aakYU4N3EZDFV65DL1Q43ztOzZze/xIW05DVJEjUquL0WCywjyiCd0+Ix
   2KbFe7uTTWbOd7ybY5ndwi9onQPvh0ATi8rGxW1a+7m2GhkXfP1i1nNZq
   Qp7WTxwL2GDWDk25I/GswCBNicPr5bDrMof6ig5K7yjeYIFtIS+BizXL/
   UKjoqQ/jOQE5vW7H88z3Qpxis9VJ9gn7TxVgA6m7ilHZ8FUUX3JzFyJVC
   DyloZw3OKfC4PRSfahEbp5t661rajT+ESMZ11pYTiAymIo9rhyHmWDhaU
   w==;
X-IronPort-AV: E=Sophos;i="5.64,544,1559520000"; 
   d="scan'208";a="28268686"
IronPort-PHdr: =?us-ascii?q?9a23=3A+vlVzxQ24inovxc1tngQc60V/Npsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYBWN2/xhgRfzUJnB7Loc0qyK6vumAjRLuM7e+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLuMQanYRuJrstxh?=
 =?us-ascii?q?bLv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCReoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtig9yr0Do5?=
 =?us-ascii?q?G7fS4KxYw8xx7YdvyHaZSH7QztVOaWOzd4i2xqdKi5hxms7UitzPD3WMqs0F?=
 =?us-ascii?q?tSsyZIndbBumoN2hDO8MSLVPRw8lm71TqS0Q3Y9/tKLloulaXBLp4s2rswlp?=
 =?us-ascii?q?0OvkvdBiL2g0D2jLOOdkUj5+io9/zrYrX4qZ+YMI95kh3+Pb40msy+HOQ4KR?=
 =?us-ascii?q?ICX3Sb+Oug1L3j+lf1QLNWgf0tjqbVqpXaJcUfpqKhAg9V1Jgs6wqnAju739?=
 =?us-ascii?q?kVkmMLIVJYdB6dkYTkNE/CLOrlAfunhlSjijZrx/TIPr37BZXNK2DOkKz8cr?=
 =?us-ascii?q?Zm8ENc1Aoywsxf55JTEL0BJunzVVXruNzXCR85LRS4w/z7B9VlyoMeRWWPD7?=
 =?us-ascii?q?efMKPTrVCI4eYvLPOXZIMPuTb9LP8l5+X1jXIinF8Qcqao0YEQaHCiEfRsO1?=
 =?us-ascii?q?+Zbmb0gtcdDWcKuRIzTPf0h12GUD5TYWuyXq0n6zElB4KpE53DSpqugLOfxi?=
 =?us-ascii?q?e7GINZZmRcBlCLC3foeNbMZ/BZTiOZJctoiXQlUr+6UMd10xClswvz0PxmKe?=
 =?us-ascii?q?3P4QUd6YKl08J6sambjhw29DppH+yD3GyXCWJ5hGUFQ3kxxq8sj1Z6zwK4za?=
 =?us-ascii?q?Vgg/FeXedW7vdNXxZyYYXQ1MRmGtvyXUTHZd7PR1G4FIb1SQotR848loddK3?=
 =?us-ascii?q?12HM+v21WahXun?=
X-IPAS-Result: =?us-ascii?q?A2DeAADqTIpd/wHyM5BlHQEBBQEMBQGBUwgBCwGBcyptU?=
 =?us-ascii?q?zIqhCKIHIZzTQEBAQEBAQaBNol1jy2BewkBAQEBAQEBAQErCQECAQGEPwKDI?=
 =?us-ascii?q?SM0CQ4CDAEBAQQBAQEBAQUDAQFshS0MgjopAYJnAQUjFVELGAICJgICVwYBD?=
 =?us-ascii?q?AYCAQEXgkg/AYF2FA+tfYEyhUyDOYFIgQwoAYwIGHiBB4ERJ4JrPoEXgUoDg?=
 =?us-ascii?q?SmDQoJYBIpRghYGiRWBMoZvjmmCLIIug0eBEIUUiGsGG4MolX2OGogTknw4g?=
 =?us-ascii?q?VgrCAIYCCEPgycJRxAUgVoXFYgThhYkAzABgQUBAYlJglQBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 Sep 2019 17:10:57 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8OHAusj020590;
        Tue, 24 Sep 2019 13:10:56 -0400
Subject: Re: [PATCH] libsepol, libsemanage: add a macro to silence static
 analyzer warnings in tests
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190921213046.1121337-1-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9f87e1b0-8bfd-601f-31ba-4fffbcd64a78@tycho.nsa.gov>
Date:   Tue, 24 Sep 2019 13:10:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190921213046.1121337-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/21/19 5:30 PM, Nicolas Iooss wrote:
> Several static analyzers (clang's one, Facebook Infer, etc.) warn about
> NULL pointer dereferences after a call to CU_ASSERT_PTR_NOT_NULL_FATAL()
> in the test code written using CUnit framework. This is because this
> CUnit macro is too complex for them to understand that the pointer
> cannot be NULL: it is translated to a call to CU_assertImplementation()
> with an argument as TRUE in order to mean that the call is fatal if the
> asserted condition failed (cf.
> http://cunit.sourceforge.net/doxdocs/group__Framework.html).
> 
> A possible solution could consist in replacing the
> CU_ASSERT_..._FATAL() calls by assert() ones, as most static analyzers
> know about assert(). Nevertheless this seems to go against CUnit's API.
> 
> An alternative solution consists in overriding CU_ASSERT_..._FATAL()
> macros in order to expand to assert() after a call to the matching
> CU_ASSERT_...() non-fatal macro. This appears to work fine and to remove
> many false-positive warnings from various static analyzers.
> 
> As this substitution should only occur when using static analyzer, put
> it under #ifdef __CHECKER__, which is the macro used by sparse when
> analyzing the Linux kernel.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>   libsemanage/tests/test_utilities.c      |  2 ++
>   libsemanage/tests/utilities.h           | 24 ++++++++++++++++++++++
>   libsepol/tests/helpers.h                | 27 +++++++++++++++++++++++++
>   libsepol/tests/test-common.c            |  2 ++
>   libsepol/tests/test-deps.c              |  2 ++
>   libsepol/tests/test-expander-attr-map.c |  1 +
>   libsepol/tests/test-expander-roles.c    |  1 +
>   libsepol/tests/test-expander-users.c    |  1 +
>   scripts/run-scan-build                  |  6 +++++-
>   9 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_utilities.c
> index 601508c2c386..ba995b5ae094 100644
> --- a/libsemanage/tests/test_utilities.c
> +++ b/libsemanage/tests/test_utilities.c
> @@ -34,6 +34,8 @@
>   #include <string.h>
>   #include <unistd.h>
>   
> +#include "utilities.h"
> +
>   void test_semanage_is_prefix(void);
>   void test_semanage_split_on_space(void);
>   void test_semanage_split(void);
> diff --git a/libsemanage/tests/utilities.h b/libsemanage/tests/utilities.h
> index c9d54d1e1b76..1d15a98d9db1 100644
> --- a/libsemanage/tests/utilities.h
> +++ b/libsemanage/tests/utilities.h
> @@ -41,6 +41,30 @@
>   		CU_ASSERT_STRING_EQUAL(__str, __str2); \
>   	} while (0)
>   
> +
> +/* Override CU_*_FATAL() in order to help static analyzers by really asserting that an assertion holds */
> +#ifdef __CHECKER__
> +
> +#undef CU_ASSERT_FATAL
> +#define CU_ASSERT_FATAL(value) do { \
> +		CU_ASSERT(value); \
> +		assert(value); \
> +	} while (0)

You only want to evaluate value once and save the result for use in both 
CU_ASSERT() and assert() or it could change, e.g.
         CU_ASSERT_FATAL(semanage_ibendport_del_local(sh, key) >= 0);

> +
> +#undef CU_FAIL_FATAL
> +#define CU_FAIL_FATAL(msg) do { \
> +		CU_FAIL(msg); \
> +		assert(0); \
> +	} while (0)
> +
> +#undef CU_ASSERT_PTR_NOT_NULL_FATAL
> +#define CU_ASSERT_PTR_NOT_NULL_FATAL(value) do { \
> +		CU_ASSERT_PTR_NOT_NULL(value); \
> +		assert((value) != NULL); \
> +	} while (0)

Ditto.

> +
> +#endif /* __CHECKER__ */
> +
>   #define I_NULL  -1
>   #define I_FIRST  0
>   #define I_SECOND 1
> diff --git a/libsepol/tests/helpers.h b/libsepol/tests/helpers.h
> index 10d390946499..34b8f21e10e0 100644
> --- a/libsepol/tests/helpers.h
> +++ b/libsepol/tests/helpers.h
> @@ -24,9 +24,36 @@
>   
>   #include <sepol/policydb/policydb.h>
>   #include <sepol/policydb/conditional.h>
> +#include <CUnit/Basic.h>
>   
>   /* helper functions */
>   
> +/* Override CU_*_FATAL() in order to help static analyzers by really asserting that an assertion holds */
> +#ifdef __CHECKER__
> +
> +#include <assert.h>
> +
> +#undef CU_ASSERT_FATAL
> +#define CU_ASSERT_FATAL(value) do { \
> +		CU_ASSERT(value); \
> +		assert(value); \
> +	} while (0)
> +
> +#undef CU_FAIL_FATAL
> +#define CU_FAIL_FATAL(msg) do { \
> +		CU_FAIL(msg); \
> +		assert(0); \
> +	} while (0)
> +
> +#undef CU_ASSERT_PTR_NOT_NULL_FATAL
> +#define CU_ASSERT_PTR_NOT_NULL_FATAL(value) do { \
> +		CU_ASSERT_PTR_NOT_NULL(value); \
> +		assert((value) != NULL); \
> +	} while (0)
> +
> +#endif /* __CHECKER__ */
> +
> +
>   /* Load a source policy into p. policydb_init will called within this function.
>    *
>    * Example: test_load_policy(p, POLICY_BASE, 1, "foo", "base.conf") will load the
> diff --git a/libsepol/tests/test-common.c b/libsepol/tests/test-common.c
> index 1d902880fe2e..f690635eee27 100644
> --- a/libsepol/tests/test-common.c
> +++ b/libsepol/tests/test-common.c
> @@ -26,6 +26,8 @@
>   
>   #include <CUnit/Basic.h>
>   
> +#include "helpers.h"
> +
>   void test_sym_presence(policydb_t * p, const char *id, int sym_type, unsigned int scope_type, unsigned int *decls, unsigned int len)
>   {
>   	scope_datum_t *scope;
> diff --git a/libsepol/tests/test-deps.c b/libsepol/tests/test-deps.c
> index 6bbba810564a..f4ab09ba0dbf 100644
> --- a/libsepol/tests/test-deps.c
> +++ b/libsepol/tests/test-deps.c
> @@ -66,6 +66,8 @@
>   #include <sepol/debug.h>
>   #include <sepol/handle.h>
>   
> +#include "helpers.h"
> +
>   #define BASE_MODREQ_TYPE_GLOBAL    0
>   #define BASE_MODREQ_ATTR_GLOBAL    1
>   #define BASE_MODREQ_OBJ_GLOBAL     2
> diff --git a/libsepol/tests/test-expander-attr-map.c b/libsepol/tests/test-expander-attr-map.c
> index d10636ca09a8..a9744541fe00 100644
> --- a/libsepol/tests/test-expander-attr-map.c
> +++ b/libsepol/tests/test-expander-attr-map.c
> @@ -21,6 +21,7 @@
>   
>   #include "test-expander-attr-map.h"
>   #include "test-common.h"
> +#include "helpers.h"
>   
>   #include <sepol/policydb/policydb.h>
>   #include <CUnit/Basic.h>
> diff --git a/libsepol/tests/test-expander-roles.c b/libsepol/tests/test-expander-roles.c
> index aba3c9bd19c4..74c781b85e68 100644
> --- a/libsepol/tests/test-expander-roles.c
> +++ b/libsepol/tests/test-expander-roles.c
> @@ -22,6 +22,7 @@
>   
>   #include "test-expander-roles.h"
>   #include "test-common.h"
> +#include "helpers.h"
>   
>   #include <sepol/policydb/policydb.h>
>   #include <CUnit/Basic.h>
> diff --git a/libsepol/tests/test-expander-users.c b/libsepol/tests/test-expander-users.c
> index 9d9c7a62f215..ab2265c110d5 100644
> --- a/libsepol/tests/test-expander-users.c
> +++ b/libsepol/tests/test-expander-users.c
> @@ -21,6 +21,7 @@
>    */
>   
>   #include "test-expander-users.h"
> +#include "helpers.h"
>   
>   #include <sepol/policydb/policydb.h>
>   #include <CUnit/Basic.h>
> diff --git a/scripts/run-scan-build b/scripts/run-scan-build
> index 88fe551ce698..ae5aa48b4a05 100755
> --- a/scripts/run-scan-build
> +++ b/scripts/run-scan-build
> @@ -22,7 +22,11 @@ export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir
>   
>   # Build and analyze
>   make -C .. CC=clang clean distclean -j"$(nproc)"
> -scan-build -analyze-headers -o "$OUTPUTDIR" make -C .. CC=clang DESTDIR="$DESTDIR" install install-pywrap install-rubywrap all test
> +scan-build -analyze-headers -o "$OUTPUTDIR" make -C .. \
> +    CC=clang \
> +    DESTDIR="$DESTDIR" \
> +    CFLAGS="-O2 -Wall -D__CHECKER__ -I$DESTDIR/usr/include" \
> +    install install-pywrap install-rubywrap all test
>   
>   # Reduce the verbosity in order to keep the message from scan-build saying
>   # "scan-build: Run 'scan-view /.../output-scan-build/2018-...' to examine bug reports.
> 

