Return-Path: <SRS0=bqQ6=OX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA6AC67839
	for <selinux@archiver.kernel.org>; Fri, 14 Dec 2018 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3143920643
	for <selinux@archiver.kernel.org>; Fri, 14 Dec 2018 13:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="WpRkkfz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeLNNkx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:40:53 -0500
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:10273 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNNkx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Dec 2018 08:40:53 -0500
X-EEMSG-check-008: 654253094|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,353,1539648000"; 
   d="scan'208";a="654253094"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Dec 2018 13:40:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1544794850; x=1576330850;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZgyLkE1ncNvzup+Nve16P75++R8pe+zCOhMowOx4rz4=;
  b=WpRkkfz8Cc5IWssPHo1ZQwZddRk9HjOSQheE7ANjdgxALc+nnLcTgCGR
   dTTBDKYQ2rgOnzl2BR7CQJvdwBYuDaNqis9NZ8sNADFy0jZE7kPgmdvjv
   6l1QjAw4X5YguAJbpekadZSU/gWtDFK8wfVItDCK9QeMlsgUT6LE0f0O0
   DcNhpOuqdCNDRQbAIEx8zc1h6aGvKhnteJRoKfGURBAPVXuOCImryG/Xx
   wKKbmq5j6QsFmm+3WBOgmN3xiVU0GXC7G9U3hsKE9UAiUW4suNy1jt+O8
   c51EG0YsZcvKQ0T3d2nmKAz5mdYBMgtINsQ2+sbOyFaHjGjORr3Z0QhgO
   g==;
X-IronPort-AV: E=Sophos;i="5.56,353,1539648000"; 
   d="scan'208";a="18714632"
IronPort-PHdr: =?us-ascii?q?9a23=3AMZqT6BRc+r4XiW6M1NuMLnkomNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYBCN2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMfhEo4X4oVYFsBmwChS2BO731zFGmHH206053e?=
 =?us-ascii?q?ovHw7J0w4vEM4BvnnPsNX4Nr0fXfypwKTGzzjOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lp?=
 =?us-ascii?q?wPvkTYAiD6gkD2jK6Sdkk8++io7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9eik0b3s50z5QLFEjv0slanZtYjXJd8Gqa6iGAJVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2IHI0hfdBKIiIjpJUnCIOrkAvenn1SsjDBryujdMb3gBpXNKmLPn6v7cb?=
 =?us-ascii?q?Zn7E5T0xQ8zcpD55JPEbwBL/fzVVXwtNzcFBM2Lwu0w+P/AtVnyoweQX6PAr?=
 =?us-ascii?q?OeMK7Kql+H+OYvI+iKZI8ItzfwMOYl5/Hwgn8jg1Mdfrem3YERaH+mGvRqOU?=
 =?us-ascii?q?KZYWDjgt0ZC2cFohI+TPD2iF2FSTNSaXeyX6Y45jE6Eo2mCJ3PSZy3jLyb2y?=
 =?us-ascii?q?e0BYNZZnpaClCXCnrodoOEW+sSZyKWOMNujjsEVb3yA7MmgBuvsAu8wPx9Ke?=
 =?us-ascii?q?DZ4DEDnZ3m3dlxoebUkFV67jFwDsKAw0mTQGxu2GAFXTk72OZ4u0Mu5E2E1P?=
 =?us-ascii?q?1Dn/FAFdFVr8hMWwM+OI+Um/d2EPjuSwnBeZGPU1/gTdK4V2JiBuktysMDNh?=
 =?us-ascii?q?4uU+6piQrOim/zWecY?=
X-IPAS-Result: =?us-ascii?q?A2ARAAB/sRNc/wHyM5BkGwEBAQEDAQEBBwMBAQGBUgUBA?=
 =?us-ascii?q?QELAYFaKYFoJ4N8lFwBAQEBAQEGgQgtiRQOjjWBejgBhEACgwUiNQgNAQMBA?=
 =?us-ascii?q?QEBAQECAWwogjYkAYJhAQEBAQIBIxVBEAsVAwICJgICITYHDAYCAQGCXj+Ba?=
 =?us-ascii?q?QMIBQild4EvhUCCRQ2CHIELizMXeIEHgTiCa4JXhTCCNSICiR6GdTeQHy8Jj?=
 =?us-ascii?q?iqDKgYYkVIsiQ+GCItmAjSBVisIAhgIIQ+DJ5B5IQMwAYEEAQGNNwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Dec 2018 13:40:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBEDekPq021138;
        Fri, 14 Dec 2018 08:40:46 -0500
Subject: Re: [PATCH 1/2] Makefile: fix _FORTIFY_SOURCE redefined build error
To:     bill.c.roberts@gmail.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>,
        James Carter <jwcart2@tycho.nsa.gov>
References: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a31ecb59-e330-08c8-95d3-8c9fe5a4022d@tycho.nsa.gov>
Date:   Fri, 14 Dec 2018 08:43:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/13/18 4:32 PM, bill.c.roberts@gmail.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> Certain builds of gcc enable _FORTIFY_SOURCE which results in the error:
> <command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined
> <command-line>:0:0: note: this is the location of the previous definition
> 
> Correct this by undefining it first and redefining it. Also, the previous
> command line option was using -Wp which passing the value *AS IS* to the
> pre-processor rather than to the compiler driver. The C pre-processor has
> an undocumented interface subject to change per man 1 gcc. Just use the
> -D option as is.

See commit ca07a2ad46be141dad90d885dd33a2ac31c6559a ("libselinux: avoid 
redefining _FORTIFY_SOURCE") for why we don't specify a value for 
_FORTIFY_SOURCE here.  Not sure about the -Wp,-D vs -D rationale.

> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>   libselinux/src/Makefile   | 2 +-
>   libselinux/utils/Makefile | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 977b5c8cfcca..ee55bd0dbff7 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
>   EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
>   	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
>   	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
> -	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE
> +	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
>   else
>   EXTRA_CFLAGS = -Wunused-command-line-argument
>   endif
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index d06ffd66893b..64ab877015c6 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
>             -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
>             -Woverflow -Wpointer-to-int-cast -Wpragmas \
>             -Wno-missing-field-initializers -Wno-sign-compare \
> -          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
> +          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1 \
>             -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
>             -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
>             -Werror -Wno-aggregate-return -Wno-redundant-decls \
> 

