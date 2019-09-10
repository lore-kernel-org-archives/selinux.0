Return-Path: <SRS0=Wrvk=XF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897E7C49ED7
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5238421019
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 18:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Bb3yFxuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfIJSzS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:55:18 -0400
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:4617 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfIJSzS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Sep 2019 14:55:18 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2019 14:55:17 EDT
X-EEMSG-check-017: 7397629|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="7397629"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Sep 2019 18:46:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568141219; x=1599677219;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=4ILTJaM5Pqw93MYUtJgMzvMzH/IPwVRxx3mFaDCb0lI=;
  b=Bb3yFxukEZRBduBmfrRYX/yk5sQP9Ay9HGHsTw8h7QVTQh3C/UYOWFAR
   tmLPYI0YjExejb8pB75+m6P2oGIlCfLmR69tSivCQ07aZ0qgfOWcrSCEd
   cpDlbLkTpwEmbmbaaaFFmR0ctSwgKz+puGbVzlQ9BUSiA64jcMVc2QrW6
   vEl8zOW6u52Okpw+kOzVIST+qPoEA1Yc2GlmasmG9wsomboMu/aakgcdY
   6M+3hyXRXzfixFEk3H0UtBU+O41rkZta0VFwb0PiOh53UeTbr3IgTtdh2
   0Hur2JPmE3ltH1ibGuN3+UBONYRp1X3DiCrOVY31b+r+qrdPst7jK82ck
   A==;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="32653198"
IronPort-PHdr: =?us-ascii?q?9a23=3Aw4oAXxOXt3jx1NfMm90l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/7+rarrMEGX3/hxlliBBdydt6sfzbKO+Pm4ByRAuc/H7ClYNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULj4ZuMLo9xg?=
 =?us-ascii?q?fGrndVZ+hbxH5jKVaPkxrh/Mu984Nv/zpKt/4968JMVLjxcrglQ7BfEDkoKX?=
 =?us-ascii?q?0+6tfxtRnEQwuP538cXXsTnxFVHQXL7wz0U4novCfiueVzxCeVPcvtTbApQj?=
 =?us-ascii?q?ui9LtkSAXpiCgcKTE09nzch9Fqg6JapBKhoAF/w5LRbYqIOvdyYr/RcNUHTm?=
 =?us-ascii?q?daQM1fSzJODZ+9b4sXDuoOI+BYr5Xmp1ATqReyHBSgCP/zxjNNgHL507c60+?=
 =?us-ascii?q?A8Gg/Y2gIuEc8FvHDNoNj7MKoeVOa4x7TKwzredfNbwSrz5pbGch4hov+CU7?=
 =?us-ascii?q?x/fsXTxkYzGA3IlUmQpI7/Mj+JyugAvWqW4ux9XuyvkW4nrARxryCtxsYilo?=
 =?us-ascii?q?bGnJgVykza+S5kx4s1J9O5R1Jhbt6+DJtcqTqXN5d2Q8w+Q2Fovzw2yrsduZ?=
 =?us-ascii?q?GhZiQKx5MnxwDGZvGBboOG4QrjWf6MLTp3i39pYrKyiwuo/US+xeDwSNO43E?=
 =?us-ascii?q?tMoyFYiNfDrGoN2AbW6sWfT/t9+Vqu1iiX2gDI7+FEPVg0la3GK5492rIwlo?=
 =?us-ascii?q?QcsUDEHiLuhEX5lrWWdkQ5+uiz8ejnfrXnqYOcN49zkA3+NLghmtejDugiNw?=
 =?us-ascii?q?gOXmyb9fy91L3l40L5XK1HguA5n6TWqpzXJdkXqrSnDwJazIov8QuzAy+j0N?=
 =?us-ascii?q?sCnHkHKFxFeAiAj4jsI1zOIv75AuuljFS2jDdn2evLPqHhA5rRLnjDl63tfb?=
 =?us-ascii?q?Bm60FG0gYzwtdf54xMBrEbPP3zQlPxtMDfDhIhNQy0wvroCNJ51owEQmKDGK?=
 =?us-ascii?q?6ZMKTVsV+T/eIiOOyMaYAauTrnLPgl/fHuh2cjmVABZampwYcXaHegE/R9PU?=
 =?us-ascii?q?qZZXvsgtEcEWYFpQc+UuPqh0OYUTJJZHa9Qbg85jclB4KiF4vDQZqtgLPSlB?=
 =?us-ascii?q?u8S7tXbWdCA0vEMHDvbJ7MD/ENYyWWK9QnkzsDTqOJTtMxkxa0u1m+g6FqKu?=
 =?us-ascii?q?vS5z0wq53uzp526vfVmBV08iZ7XOqH1GTYTX5/l3kUHXdi3r90qFZhkH+fwK?=
 =?us-ascii?q?N4hLpeDtUV6PRXBFRpfaXAxvB3XoihEjnKec2EHRP/GYSr?=
X-IPAS-Result: =?us-ascii?q?A2DxAACj7ndd/wHyM5BlHQEBBQEHBQGBVQYBCwGBbSqBP?=
 =?us-ascii?q?wEyKoQhjxOBaiV+mCCBewkBAQEBAQEBAQE0AQIBAYISgi0CgkkjNgcOAgwBA?=
 =?us-ascii?q?QEEAQEBAQEGAwEBbIU6gjopAYJmAQEBAQIBIxVGCwsJDwICHwcCAlcGAQwGA?=
 =?us-ascii?q?gEBgl8/gXwPqFGBMoVLgy2BSYEMKAGLd4FXQIERJwyCKjU+h0+CWASBLwGLI?=
 =?us-ascii?q?okNgTGVNwaCJYwOhBWETgYbgmOWJ41/mm8HKoFYKwpBgWiBToJOFxWOKSQDM?=
 =?us-ascii?q?IEGAQGPIAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Sep 2019 18:46:57 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8AIkuYp023720;
        Tue, 10 Sep 2019 14:46:56 -0400
Subject: Re: [Non-DoD Source] [PATCH 2/9] libsepol/cil: help static analyzers
 by aborting when an allocation fails
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190901180636.31586-1-nicolas.iooss@m4x.org>
 <20190901180636.31586-3-nicolas.iooss@m4x.org>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <920d5f9a-147d-1bcc-8689-0656997c6d09@tycho.nsa.gov>
Date:   Tue, 10 Sep 2019 14:48:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901180636.31586-3-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/1/19 2:06 PM, Nicolas Iooss wrote:
> When allocating memory with cil_* helpers, if malloc/calloc/realloc/...
> failed, (*cil_mem_error_handler)() is called. Implementations of this
> function are expected not to return to the caller, and the default one
> calls exit(1) to ensure this. In order for static analyzers to find out
> that cil_malloc/cil_realloc/... never returns a NULL pointer when
> failing to allocate some memory, introduce a call to abort().
> 
> This decreases the number of false positive warnings about null pointer
> dereferences reported by Infer static analyzer.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>   libsepol/cil/src/cil_mem.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
> index 12c59be21914..885431d8a8fd 100644
> --- a/libsepol/cil/src/cil_mem.c
> +++ b/libsepol/cil/src/cil_mem.c
> @@ -55,6 +55,7 @@ void *cil_malloc(size_t size)
>   			return NULL;
>   		}
>   		(*cil_mem_error_handler)();
> +		abort();
>   	}
> 

I am going to have to think about this one.

I think the real answer might be to rip out the (*cil_mem_error_handler)() 
statements and replace them with what is in the default handler. I notice now 
that even though there is a cil_set_mem_error_handler() function, it is not used 
anywhere.

>   	return mem;
> @@ -65,6 +66,7 @@ void *cil_calloc(size_t num_elements, size_t element_size)
>   	void *mem = calloc(num_elements, element_size);
>   	if (mem == NULL){
>   		(*cil_mem_error_handler)();
> +		abort();
>   	}
>   
>   	return mem;
> @@ -78,6 +80,7 @@ void *cil_realloc(void *ptr, size_t size)
>   			return NULL;
>   		}
>   		(*cil_mem_error_handler)();
> +		abort();
>   	}
>   
>   	return mem;
> @@ -95,6 +98,7 @@ char *cil_strdup(const char *str)
>   	mem = strdup(str);
>   	if (mem == NULL) {
>   		(*cil_mem_error_handler)();
> +		abort();
>   	}
>   
>   	return mem;
> @@ -111,6 +115,7 @@ __attribute__ ((format (printf, 2, 3))) int cil_asprintf(char **strp, const char
>   
>   	if (rc == -1) {
>   		(*cil_mem_error_handler)();
> +		abort();
>   	}
>   
>   	return rc;
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
