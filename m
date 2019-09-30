Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F082C32792
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2966B2086A
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="IV/cS8gB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfI3NH4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:07:56 -0400
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:57430 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3NH4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 09:07:56 -0400
X-EEMSG-check-017: 13300604|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="13300604"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Sep 2019 13:07:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569848875; x=1601384875;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Vpe3ioGTgNCGzs1TrvhGChKsL/z5k/KW9wvTXZMW5vU=;
  b=IV/cS8gBLHFRSDEalpW+OGzGK64IrRmy1EwlZU0TLYnzRHpr3gmpKXqS
   gIzkrHcKyLMvppxsMAV74tJo/HYGWXrRa1U71QUkJti6MGGcY85OyFvoq
   dIjj4s63hYqn8Ai1nBQRpyKtmiZ8S4vlhZvecmzwkkV6r7RY0PtiMszIP
   ChV6yPwT9w9W3LROSbgE8mrXCZ690rmVvZ9tOHpd+vORJ3ZLf/hWPhQP3
   o9UrMbg0Y3zuhjzm2dnjvkbs2q8c5g+vCKb3qhtNS9Ow3NhbD19uzkSol
   XihMr7H6/HP/fD0VgJZ44A4hF8RDcUSWZGBTzxWRohyObzzvpMAjTfsXM
   g==;
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="28451141"
IronPort-PHdr: =?us-ascii?q?9a23=3A8eg3qRJTVGB/oTVH1tmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfKfTxwZ3uMQTl6Ol3ixeRBMOHsqkC17Cd7v2ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbal9IRmoognctskbipZ+J6gszR?=
 =?us-ascii?q?fEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3QqBWAzogM2?=
 =?us-ascii?q?Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VS?=
 =?us-ascii?q?ik4qx2UxLjljsJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ2?=
 =?us-ascii?q?ROXtxVVydcHI2yaYUBBPcFMepBsYXwo14CoB2jDgeuGezv0CdFiGLo06000+?=
 =?us-ascii?q?ovEg/I0wIvEN0MrHvao874NLsQXO2v0KXE0TvOYvFQ1Dzg6IbIaBchofSUUL?=
 =?us-ascii?q?xtbcre11EvFwPbgVWWtIfrIjaV2f4Js2if8eVhVf+khmk8qw5suTii3dssi4?=
 =?us-ascii?q?nViYIVzVDI7yN5wJ0vKtGiR057ZsCkHYJWuiqHOYV2RcYiTHtpuCY80rAGop?=
 =?us-ascii?q?m7fDUQyJs72RHfZfuHc5KH4h39TuqRJyl3hG5jdbmihBiy6VCtxvDzW8S7yl?=
 =?us-ascii?q?pHrjdJnsPSun0CyRDf8NWLR/1g9Um7wzmPzRrc6uRcLEAxkqrUNoAuz6Yrlp?=
 =?us-ascii?q?oWrUTDBij2mFjqjKOOdkUr5Oyo6+P/b7X6vJCcLY50ihzlMqg0hsy+Afg3Mg?=
 =?us-ascii?q?gJX2SB/+SzyKbj8lHjTLVPj/02lrHVsJHcJcsFuq60GxJZ34ks5hqlDzqqzc?=
 =?us-ascii?q?4UkWcIIV5bYh6LkpDlO1TUL/D5Cfe/jU6skDBux/3eJb3uH47NI2PfkLbhYb?=
 =?us-ascii?q?l960lcxBA1zdBE/Z1YEL4BIPXtWkPprtzXEgc5MxCow+bgENh90IIeVn6IAq?=
 =?us-ascii?q?+dKqzSqkWE5uMoI+mLf48Voy3wK/0q6v/hl3M5nkUdfaax15sNdH+4BuhmI1?=
 =?us-ascii?q?meYXf0mdcOD2MKvgs4TOz3h1yPSiBTZ3msUKIm/D07C5ypDZ3FRo+zhLyNxi?=
 =?us-ascii?q?C7HodZZjMONlfZN3bjcIGNQL8tbyWJOYc1lD0PUryoUMkg0ha1ryf/l6ohKf?=
 =?us-ascii?q?DbrGlQrp/n1d5o98XNmhwosz95FcKQ1yeKVW4nsHkPQmoNwK1noUF7gmyG2K?=
 =?us-ascii?q?x8ju0QQcdf/NtVQww6Mtja1OU8BNfsDFGSNuyVQUqrF431SQo6Scg8lppXOR?=
 =?us-ascii?q?dw?=
X-IPAS-Result: =?us-ascii?q?A2AIAQC3/ZFd/wHyM5BmHQEBBQEMBQGBVAcBCwGBcyptU?=
 =?us-ascii?q?zIqhCKOcFADBoE2iXWPL4F7CQEBAQEBAQEBASsJAQIBAYRAAoNDIzUIDgIMA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFLQyCOikBgmgBBSMVUQsYAgImAgJXBgEMBgIBAReCS?=
 =?us-ascii?q?D8BgXYUD60mgTKFTYMmgUiBDCgBjA0YeIEHgREngms+gReBSgOBKYNCglgEi?=
 =?us-ascii?q?lKCGAaJGoEzlVqCLIIug0eBEIUUiGwGG4Mplg2OIYgYkwMCNIFYKwgCGAghD?=
 =?us-ascii?q?4MnCUcQFIFaFxWIE4YWJQMwAYEFAQGNJCqCKgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Sep 2019 13:07:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8UD7W6k017338;
        Mon, 30 Sep 2019 09:07:32 -0400
Subject: Re: [PATCH v2] libsepol, libsemanage: add a macro to silence static
 analyzer warnings in tests
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190926220405.4524-1-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a97cc4bc-2daf-ce19-690e-59a8d68661e9@tycho.nsa.gov>
Date:   Mon, 30 Sep 2019 09:07:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190926220405.4524-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/26/19 6:04 PM, Nicolas Iooss wrote:
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

Thanks, merged.

> ---
> 
> v2: introduce a temporary variable to not evaluate twice the argument
> of the macros.
> 
>   libsemanage/tests/test_utilities.c      |  2 ++
>   libsemanage/tests/utilities.h           | 26 ++++++++++++++++++++++
>   libsepol/tests/helpers.h                | 29 +++++++++++++++++++++++++
>   libsepol/tests/test-common.c            |  2 ++
>   libsepol/tests/test-deps.c              |  2 ++
>   libsepol/tests/test-expander-attr-map.c |  1 +
>   libsepol/tests/test-expander-roles.c    |  1 +
>   libsepol/tests/test-expander-users.c    |  1 +
>   scripts/run-scan-build                  |  6 ++++-
>   9 files changed, 69 insertions(+), 1 deletion(-)
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
> index c9d54d1e1b76..db4dabf95588 100644
> --- a/libsemanage/tests/utilities.h
> +++ b/libsemanage/tests/utilities.h
> @@ -41,6 +41,32 @@
>   		CU_ASSERT_STRING_EQUAL(__str, __str2); \
>   	} while (0)
>   
> +
> +/* Override CU_*_FATAL() in order to help static analyzers by really asserting that an assertion holds */
> +#ifdef __CHECKER__
> +
> +#undef CU_ASSERT_FATAL
> +#define CU_ASSERT_FATAL(value) do { \
> +		int _value = (value); \
> +		CU_ASSERT(_value); \
> +		assert(_value); \
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
> +		const void *_value = (value); \
> +		CU_ASSERT_PTR_NOT_NULL(_value); \
> +		assert(_value != NULL); \
> +	} while (0)
> +
> +#endif /* __CHECKER__ */
> +
>   #define I_NULL  -1
>   #define I_FIRST  0
>   #define I_SECOND 1
> diff --git a/libsepol/tests/helpers.h b/libsepol/tests/helpers.h
> index 10d390946499..fa84cfab7f10 100644
> --- a/libsepol/tests/helpers.h
> +++ b/libsepol/tests/helpers.h
> @@ -24,9 +24,38 @@
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
> +		int _value = (value); \
> +		CU_ASSERT(_value); \
> +		assert(_value); \
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
> +		const void *_value = (value); \
> +		CU_ASSERT_PTR_NOT_NULL(_value); \
> +		assert(_value != NULL); \
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

