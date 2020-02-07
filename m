Return-Path: <SRS0=TwHm=33=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF616C2BA83
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 21:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A967A222D9
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 21:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="RrVDcsLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgBGVah (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:30:37 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:45128 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGVag (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Feb 2020 16:30:36 -0500
X-EEMSG-check-017: 56437953|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,414,1574121600"; 
   d="scan'208";a="56437953"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Feb 2020 21:26:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581110814; x=1612646814;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=rDTD5FejupCBwtEdcpyE3zsVfH02UiQNIQMG6z1QtEY=;
  b=RrVDcsLF9+bA+Akmb6vNRZBXwuRvdo2VpAlpC7DFRu2i0FJGF9vsmpsA
   5W2bYh5Ctg6EiAGiWPEHROG++LQ1P+6rAxsYpZYq9Vys3QRqtsE4Sq9qO
   97Ss8eOauXis1N+6s799TQSQW6790gz06XJM/3L6koZnKko3G290U80Wi
   Wu+w1vNqRSzruCf11uSEpGOVA45cgq5QbPfUKGayJX7q3fj+bw9t0VH9e
   A0VYc3RFXsoTmJVyuagqxYCI6UPJZKqWFmvfjDJSykCw3GRD4P2H84Ue/
   1pJ1hyBgOc+QuTKtsD8vv0H3PALGUBa1Oju2pr5QuLfpABEXcTrySUlky
   g==;
X-IronPort-AV: E=Sophos;i="5.70,414,1574121600"; 
   d="scan'208";a="38841646"
IronPort-PHdr: =?us-ascii?q?9a23=3AxmR2uxIGZ6COt/sJwNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfLv3xwZ3uMQTl6Ol3ixeRBMOHsq4C1red6vy+ESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4Kqs8yh?=
 =?us-ascii?q?TFrmZHdulX2GhkIU6fkwvm6sq/4ZJu/T5ct+49+8JFTK73Y7k2QbtEATo8Lm?=
 =?us-ascii?q?s7/tfrtR7NTQuO4nsTTGAbmQdWDgbG8R/3QI7/vjP1ueRh1iaaO9b2Ta0vVj?=
 =?us-ascii?q?S586hrUh7ohzwZODM/7Wral9Z/jKNfoBKmuhx/34vZa5ybOfZiYq/Qe84RSH?=
 =?us-ascii?q?FfVchNSSNOHoK8b5MOD+UfO+ZYs5L9rEYKoRenGAWgGP/jxjpOi3D4x6061/?=
 =?us-ascii?q?kqHx/A0gIuAtkCtG3YodvxOasXV+2+0avGwijZb/5OxDnz9obIfBAir/+CU7?=
 =?us-ascii?q?1/fsjexlUgGQ7eklWdq5boMy+J2ukDsWWW6fdrW+K1i24grgF8uiWhxtsyhY?=
 =?us-ascii?q?nRhoIa1FbE/jhkzoYwP9K4TEp7bsCkEZBNsCyaLJZ5Qtg5TmF0uCc11r0GuZ?=
 =?us-ascii?q?mhcCgM05Qo3QTTa/OAc4iW+x/uUvuaLzRghH99Zb6yiBm//VKgx+HhTMW4zl?=
 =?us-ascii?q?lHojRfntXRsH0Gygbd5dKdSvRn+0eswTOP1wfO5e5aOU00jq/bK4I5wr43i5?=
 =?us-ascii?q?oTrVzPHi/ol0Xyi6+bblkk9fKy6+Tmf7XmvYWQN45yigHwNaQugdKwDvgiPg?=
 =?us-ascii?q?gSX2mU5eS81Lr58U3/XLpKleE5nrPcsJDbIcQXvq+5AwlL3YY/8xuzEjir3d?=
 =?us-ascii?q?sCkXQHMV5JYgyLgof3N13UPfz0FfK/jE6tkDdvyfDGJLrhApDVI3jYjbjhZq?=
 =?us-ascii?q?1w61JcyQUvzdBf4IhYCrcaIP3pQEPxu9vYDgEhPwyu3+nnEMl91p8ZWW+XBa?=
 =?us-ascii?q?+ZNaTSsUSO5u01P+aDepQYuCzjJPc45/7hl2M5lUUBcqmu2JsdcGq4Eeh+I0?=
 =?us-ascii?q?WFfXrshc8MEXwUsQo6TezqjkCCUDFIanasUKIz+Cs7BJilDYjdXICthqKO3C?=
 =?us-ascii?q?OhEp1RfGBGBQPELXC9UIOIQfoOIAeVOclomTEHHeymTog60xiluSfgxrZnJ/?=
 =?us-ascii?q?aS8Sod49arz9Vx5uvOhTks+jFuSceQyWeASydzhGxbaSUx2fVEvUFlylqFmZ?=
 =?us-ascii?q?N9ivhcGM0bs+hFSS8mJJXcyKp8ENm0VQXfKITaAG26S8mrVGliBuk6xMUDNg?=
 =?us-ascii?q?MkQISv?=
X-IPAS-Result: =?us-ascii?q?A2CvAAC91T1e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gW0gEiqEFYkDhmQBAQEGgTeJcJFLCQEBAQEBAQEBATcBAYRAAoJnN?=
 =?us-ascii?q?wYOAhABAQEEAQEBAQEFAwEBbIVDgjspAYMCAQUjFVELDgoCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgmM/glclr1+BMoVKg2CBPoEOKgGMPHmBB4E4D4JdPoEOhk2CXgSXQkaXa?=
 =?us-ascii?q?oJEgk6TeAYbmw+OZJ01I4FYKwgCGAghD4MnUBgNnQEjAzCOaAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Feb 2020 21:26:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 017LPxxw240770;
        Fri, 7 Feb 2020 16:25:59 -0500
Subject: Re: [PATCH 2/2] Travis-CI: test that DEBUG build works
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200206131901.535779-1-omosnace@redhat.com>
 <20200206131901.535779-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6fd93c7d-e5fe-b5ce-d5cc-b11125b9c587@tycho.nsa.gov>
Date:   Fri, 7 Feb 2020 16:27:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206131901.535779-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/20 8:19 AM, Ondrej Mosnacek wrote:
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   .travis.yml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index e9f86baa..918958ac 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -13,6 +13,7 @@ env:
>       # Test the last version of Python and Ruby together, with some linkers
>       - PYVER=python3.7 RUBYLIBVER=2.6
>       - PYVER=python3.7 RUBYLIBVER=2.6 TEST_FLAGS_OVERRIDE=1
> +    - PYVER=python3.7 RUBYLIBVER=2.6 TEST_DEBUG=1
>       - PYVER=python3.7 RUBYLIBVER=2.6 LINKER=gold
>       - PYVER=python3.7 RUBYLIBVER=2.6 LINKER=bfd
>   
> @@ -116,6 +117,8 @@ before_script:
>   
>     # If TEST_FLAGS_OVERRIDE is defined, test that overriding CFLAGS, LDFLAGS and other variables works fine
>     - if [ -n "$TEST_FLAGS_OVERRIDE" ]; then EXPLICIT_MAKE_VARS="CFLAGS=-I$DESTDIR/usr/include LDFLAGS=-L$DESTDIR/usr/lib LDLIBS= CPPFLAGS=" ; fi
> +  # If TEST_DEBUG is defined, test that debug build works fine
> +  - if [ -n "$TEST_DEBUG" ]; then EXPLICIT_MAKE_VARS="$EXPLICIT_MAKE_VARS DEBUG=1" ; fi
>   
>   script:
>     # Start by installing everything into $DESTDIR
> 

