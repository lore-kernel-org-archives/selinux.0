Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68560C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 13:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393E0205ED
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 13:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ADOlTrb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfLPNul (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:50:41 -0500
Received: from UHIL19PA35.eemsg.mail.mil ([214.24.21.194]:36636 "EHLO
        UHIL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfLPNul (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 08:50:41 -0500
X-EEMSG-check-017: 57730771|UHIL19PA35_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="57730771"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Dec 2019 13:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576504239; x=1608040239;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=2k1H/a06zDtQ4rYa2fRG68MEPGfS5eePYvu6AQNf/rQ=;
  b=ADOlTrb8KFkXdJUhZrAdPGVzN6n1DLcV6SXkTsLNF7dWXQ5TpfPCGXyS
   8/7+PA1x6sLq/AwL1XQmVgEIrs4S9imVbWbr6zpSVMkqHzVsu22xF0CfU
   urFmOh2YWNlq9UeLuQjN6XOb9w7KxWY9ZvG01NNg4MoH8bVNVCUTA8zPx
   2hzOpHbf9mLsxsbzRk7kHtaxseJEJfK+dRH2KcCJJTWbssM4eItJonI6h
   FAOD8oLbb7r65CEb8Ls2x4psNtvl/Yf6xl/cu1BAGFB15oc25+4J545LY
   KbG/64FT/kV7HgP9Z3NuH9JprjQxrK4FQ2heK2es7QZiB2o+FXMuya/zI
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="36781451"
IronPort-PHdr: =?us-ascii?q?9a23=3ADEkLhxJTxrGjPGEe59mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfKvnxwZ3uMQTl6Ol3ixeRBMOHsqkC0bKL+P29EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm6sQXcusYWjIZiN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5DxqlUKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK58nwr4+kZ?=
 =?us-ascii?q?oTqlrMETPslEXqjK6ZakUk+u+y5+ThfrrmvYOTO5VxigH/NqQigs2/AeImPQ?=
 =?us-ascii?q?gSR2WX5Oux2bL58UD5XblGlOM6n6bHvJzAOMgXvqu5DBVU0oYn5Ra/FTCm0N?=
 =?us-ascii?q?EAkHkcMV1FYwmKj5TpOl7SIPD4Cu2zg1K3kDhx3fzGMbrhAovVInjZjLjhZa?=
 =?us-ascii?q?p961JbyAcrytBf4pVUCqoHIP3pRkD+qsfVDgUnPAOpw+boEsl92pkCVmKIB6?=
 =?us-ascii?q?+TKLnSvkOQ5uIzP+mMY5cYuC3jJPgh5v7ui2I5mFAGcKm30psYdmq4Eu5lI0?=
 =?us-ascii?q?qHe3rshMkOEWMQsgo5Vuzqhw7KbTkGQHC+Ra8+rhQ8E4SvBorADtSqhbua2i?=
 =?us-ascii?q?6wE7VMa2xGA0zKGnDtIcHMQPoIaSSPMud/nTEeE7usUYks0VeprgCp5aBgK7?=
 =?us-ascii?q?/v5iAAtZ/lnONw7unXmAB6oSd4FOyBwmqNSCdyhWpOSDgoivMs6Xdhw0uOhP?=
 =?us-ascii?q?Ary8dTEsZesrYQCVY3?=
X-IPAS-Result: =?us-ascii?q?A2DdAAAsi/dd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gW0gEiqEBIkDhnUGgTeJapFFCQEBAQEBAQEBATcBAYRAAoI4OBMCE?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMVUQsOCgICJgICVwYBDAYCAQGCX?=
 =?us-ascii?q?z+CUyWuHYEyhU+DL4FIgQ4ojDJ5gQeBOA+CXT6HWYJeBJcJRpcrgj6CP5NAB?=
 =?us-ascii?q?huaSC2OH5xaIoFYKwgCGAghD4MnUBEUm3YjAzCQJgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Dec 2019 13:50:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBGDoDam134329;
        Mon, 16 Dec 2019 08:50:13 -0500
Subject: Re: [PATCH testsuite] selinux-testsuite: fix tun_tap checks
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191213091733.1058949-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9265b6af-231f-dbcf-b24b-81e7997d5588@tycho.nsa.gov>
Date:   Mon, 16 Dec 2019 08:51:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213091733.1058949-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/13/19 4:17 AM, Ondrej Mosnacek wrote:
> The attach_queue permission was introduced later than the tun_socket
> class itself. So check for that instead of the class, since the policy
> fails to build without it.
> 
> Fixes: 4e0f6d5a52d2 ("selinux-testsuite: Add TUN/TAP driver tests")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks, applied.

> ---
>   policy/Makefile | 2 +-
>   tests/Makefile  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index f0de669..909594a 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -101,7 +101,7 @@ ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && ech
>   TARGETS+=test_module_load.te
>   endif
>   
> -ifeq ($(shell grep -q tun_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +ifeq ($(shell grep -q attach_queue $(POLDEV)/include/support/all_perms.spt && echo true),true)
>   TARGETS += test_tun_tap.te
>   endif
>   
> diff --git a/tests/Makefile b/tests/Makefile
> index 9a890be..45c9885 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -79,7 +79,7 @@ SUBDIRS+=module_load
>   endif
>   endif
>   
> -ifeq ($(shell grep -q tun_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +ifeq ($(shell grep -q attach_queue $(POLDEV)/include/support/all_perms.spt && echo true),true)
>   SUBDIRS += tun_tap
>   endif
>   
> 

