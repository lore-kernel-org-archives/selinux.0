Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD12C43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 15:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5580321925
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 15:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="V7Wi1xlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKLPjD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:39:03 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:27670 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKLPjC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 10:39:02 -0500
X-EEMSG-check-017: 30325766|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="30325766"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Nov 2019 15:38:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573573139; x=1605109139;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hP9H+NHGna5S6OkhziXcsm1KRoIVoixgc2EeVusJGds=;
  b=V7Wi1xlxQA+GKWk3iue0Bryn+HsOC0jDIogUCet5k0hTwOgb90WLtKz8
   CY/2cC4PipDgFqKwmYdjZvHaLsAyxjmq6it+mW4rxNO/7ihge0ic4+I+x
   5Z42acWMA7ywapBNTtt3Vm7C6pBRDHA4sO0xJ3jr2KVEaGLTW5wRZJKaf
   iSOaaImNT/Mmu7WMWKKp3eju8dMDELgMPtvGQ/B/d6/9yx0lo6QC1rmHi
   IA1+dDurxe+gXxsxF1LkvRF/Ga7Zdl2qe9XkB7fmr+2cOxWidFgTt262t
   NTB+GyIR2oiFchMQ3qbgip6J5SFJSKBxKuCHtY7WpBG4xU3R543l8T8vv
   w==;
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="35394765"
IronPort-PHdr: =?us-ascii?q?9a23=3AZydkfx3pguPLq2M/smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMSKfad9pjvdHbS+e9qxAeQG9mCsLQd0bud7P+ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBmoqQjducsbjIl/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXwqV8DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbN54gzaIwlp?=
 =?us-ascii?q?oUq0jDGDP5mF7qg6OMc0Uk++yo5/zmYrXguJCcK5d5hhzxP6khgMCyAfk0Ph?=
 =?us-ascii?q?IQU2WU5+iwzqDv8VX8QLpQj/02lqfZsIrdJcQevqO5GBJa0p045hajDzapzN?=
 =?us-ascii?q?QYnX4dIFJDYxKIlZLlO17JIPDmFfu/mUijkC93x/DaOb3sGpPNLnnfn7fmeb?=
 =?us-ascii?q?Zy8VVcxBAyzdBY4JJUEaoBLen2WkL+u93UFBg5Mxa7w+z/EtVyypseWX6TAq?=
 =?us-ascii?q?+eKK7SqkGH5uYuI+mKeY8Uty3wK+Yq5/Hwl381g1wdcrez3ZsRdn+4Gu5qI0?=
 =?us-ascii?q?KDYXrjmt0BC3sFvhIiTOz2j12PSTtTZ3exX60i/Tw0EoamDZvHRoCshryBwS?=
 =?us-ascii?q?i6EodRZmBcBVDfWUvvIqOFUPAIYTnaA8hmiSdMAb6gQIgl3ArotQj90KFPK7?=
 =?us-ascii?q?bEvCoCusSnnMN44+zViAEa6zN5FYKe3nuLQmUymXkHFBEs26UqmlBw0leO1+?=
 =?us-ascii?q?BDhvVcEdFCr6dSXhwSKY/Xz+s8Dcv7HA3GYIHaGx6dXty6DGRpHZoKyNgUbh?=
 =?us-ascii?q?M4Qo7zgw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BPAAAo0cpd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXQsbFUyKoQpj1gGgTaJZoofhyQJAQEBAQEBAQEBIxEBAgEBh?=
 =?us-ascii?q?EACgh0kOBMCDgEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQUjFUEQCxgCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgl8/AYJSJa89gTKFToM0gUiBDiiMFBh4gQeBOIJrPoEXhj6CX?=
 =?us-ascii?q?gSWUEWWe4IvgjaEYY4nBhuDL5ZKLY4anAcigVgrCAIYCCEPgycJRxEUmnqEI?=
 =?us-ascii?q?CMDMIEFAQGQVwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Nov 2019 15:38:58 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xACFcwU9007475;
        Tue, 12 Nov 2019 10:38:58 -0500
Subject: Re: [PATCH 2/3] libselinux, libsemanage: fix python_exception.i
 dependencies
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Cc:     Michael Shigorin <mike@altlinux.org>
References: <20191111115315.1173097-1-nicolas.iooss@m4x.org>
 <20191111115315.1173097-2-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bdf62121-254c-884c-f318-6f7f530cc006@tycho.nsa.gov>
Date:   Tue, 12 Nov 2019 10:38:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191111115315.1173097-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/11/19 6:53 AM, Nicolas Iooss wrote:
> selinuxswig_python_exception.i and semanageswig_python_exception.i need
> to be regenerated when either an input header file changes or
> exception.sh changes. Add the missing items to the respective Makefiles.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Wondering if we ought to be passing the dependencies as arguments to 
exception.sh and having it use them rather than a hardcoded header file 
path, but regardless:

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libselinux/src/Makefile  | 2 +-
>   libsemanage/src/Makefile | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 3b8bad810de0..7f5a5d7418e9 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -151,7 +151,7 @@ $(LIBSO): $(LOBJS)
>   $(LIBPC): $(LIBPC).in ../VERSION
>   	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
>   
> -selinuxswig_python_exception.i: ../include/selinux/selinux.h
> +selinuxswig_python_exception.i: exception.sh ../include/selinux/selinux.h
>   	bash -e exception.sh > $@ || (rm -f $@ ; false)
>   
>   %.o:  %.c policy.h
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index e029f0988dd8..8a9570c74163 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -94,7 +94,7 @@ $(LIBSO): $(LOBJS)
>   $(LIBPC): $(LIBPC).in ../VERSION
>   	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
>   
> -semanageswig_python_exception.i: ../include/semanage/semanage.h
> +semanageswig_python_exception.i: exception.sh $(wildcard ../include/semanage/*.h)
>   	bash -e exception.sh > $@ || (rm -f $@ ; false)
>   
>   conf-scan.c: conf-scan.l conf-parse.h
> 

