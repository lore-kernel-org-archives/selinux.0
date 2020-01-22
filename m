Return-Path: <SRS0=wfQh=3L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F2C2D0DB
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 18:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AEE24656
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 18:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZEsdf2bD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAVSx6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:53:58 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:4337 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVSx5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jan 2020 13:53:57 -0500
X-EEMSG-check-017: 48656030|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,350,1574121600"; 
   d="scan'208";a="48656030"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Jan 2020 18:53:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579719234; x=1611255234;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=+kbjf8pM2zyUj/ruHkFNZWMuJi8mnFgOgVfK3uiUE34=;
  b=ZEsdf2bDa0sSQn38IHizX1S0So+PESlVnOgN8jLCi19zEwH1vGUQNrod
   dFLJuK6ev4nulmGhMLMIaWaQ4BhtXNP0RdTF8pX2+zVpajEgD3oWAal2a
   j8XtbIdAx15XEORpV9+zFAfi37E1L5TbwL1/xN+m6xDEDgBC6fL/N+2ev
   gaKAdJWE/AgYDX6t3Hyp5yg9z0ogZxXLIaLJWoDrzSBJEF5KC3Ri7fjui
   4VeLNVcN6KbAC2LRoScAmAR2QUhJaCIycjRO7UxiFa06iE+LzsFQF2Zot
   KvkVC2YMhmFaayLd6xVfBPKU52bOJBOPOEn/yzdeEDk86N+K/Ow81UISa
   g==;
X-IronPort-AV: E=Sophos;i="5.70,350,1574121600"; 
   d="scan'208";a="38121263"
IronPort-PHdr: =?us-ascii?q?9a23=3Ah0o1uxxfozGl0WTXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2ukRIJqq85mqBkHD//Il1AaPAdyHragcwLOP6eigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam5VuJro+xh?=
 =?us-ascii?q?fUv3dEZfldyWd0KV6OhRrx6dq88ZB5/yhMp/4t8tNLXLnncag/UbFWFiktPX?=
 =?us-ascii?q?ov5M3suxnDTA+P6WUZX24LjBdGABXL4Q/jUJvpvST0quRy2C+BPc3rVr80Qi?=
 =?us-ascii?q?it771qSBDzligKMSMy/XzNhcxxiKJbpw+hpwB6zoXJboyZKOZyc6XAdt4BW2?=
 =?us-ascii?q?FPQtheWDBAAoOkbosAEewBPfpDr4Lgo1cCtAayCRWwCO/qzDJHiGX23akn2O?=
 =?us-ascii?q?o/Fw/I0hErE9YXvHnaqNj5MaEfWv23wqbV1zXOd+5Y1ynz6IbIcR4vr/+DUr?=
 =?us-ascii?q?1yfsXNxkciDB/Fg1eKpID5Iz+Y2OYAvm6G5ORgT+KvjGsnphlzojmh2sgjkJ?=
 =?us-ascii?q?PJhp4LxlvZ8ih5wog0KsGiR05hfd6oDoBdtz2aNoRqQsMiRHtkuCAhyrIco5?=
 =?us-ascii?q?K7cy8KyIo+yhPZdveJcJCI7wr+WOueLjp0nnJodK+lixqs/kWs1PfwWtSy3V?=
 =?us-ascii?q?1XtCRKiMPMuWoI1xHL78iHTeZy8Vm51DaU0gDT9vlEIUcplarHM5IhwqA/lp?=
 =?us-ascii?q?4UsUnbAi/5gl/2jK6LdkU/4OSo6uLnYrvhpp+HKYB7lhvyMrgum8OjAeQ4NR?=
 =?us-ascii?q?ICX26H9uSnyLLv50j5QLROjvEuk6nZto7VJdgDq6KkDAJY3Zwv5haiAzu8zt?=
 =?us-ascii?q?gVkmcLIEhYdB6fiojmIVDOIPT2DfelhFSslS9mx/LIP7L9GJrNNGTDnKn6cL?=
 =?us-ascii?q?Zh609T1AozzddF65JSEbEOOuj/WkD2tNzGFhM5KRC7w/77CNVh0YMTQWWPAq?=
 =?us-ascii?q?qeMKPJt1+H/P4gLPeXaY8PpjnyNvgl6OTyjXMjhVAdeqyp14MNaH+kBvRmP1?=
 =?us-ascii?q?mZYX30j9caD2gKugs+TOr3iFyNSjNTeXmyULwm5j0hC4KpE53DRoazj7yFxi?=
 =?us-ascii?q?u7GYdWZm8VQmyLRFDue5+JWb8pbzmUK8RskXRQUr2mUIko3hyGrgL2y7N7aO?=
 =?us-ascii?q?HT/3tc/Ynu0Nlz+v37ix4/73p3At6b3mXLSHt7zU0SQDpj3r90qFZhkB/X07?=
 =?us-ascii?q?dziuZET/RP9vhJVUE8LpeawOtkXYOhEjndd8uEHQ71Cu6tBis8G5domI4D?=
X-IPAS-Result: =?us-ascii?q?A2ARAwAimShe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YINEiqEEokDiC2UE4U9gWcJAQEBAQEBAQEBNwEBghOCLQKCPjgTAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIVDgjspAYJ6AQUjBBFRCwkFCgICJgICVwYBDAYCAQGCYz+Cf?=
 =?us-ascii?q?K9jfzOFSoMygT6BDiqNcECBEScPgl0+hDGDKIJeBIE/AYwSiWBGepZgBoI9l?=
 =?us-ascii?q?i0GG5p3LY4xnRkigVgrCkGBaIFOUBgNiA0XFY4sIwMwjWwBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 22 Jan 2020 18:53:52 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00MIrCH4033109;
        Wed, 22 Jan 2020 13:53:12 -0500
Subject: Re: [Non-DoD Source] [PATCH userspace 2/4] libsepol: remove unused
 cil_mem_error_handler
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200122154655.257233-1-omosnace@redhat.com>
 <20200122154655.257233-3-omosnace@redhat.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <a730c6ee-c5b4-2eb2-60c8-a069a87ec0a4@tycho.nsa.gov>
Date:   Wed, 22 Jan 2020 13:54:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200122154655.257233-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/22/20 10:46 AM, Ondrej Mosnacek wrote:
> It is declared in an internal header but never defined. Remove it.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   libsepol/cil/src/cil_mem.h     | 1 -
>   libsepol/cil/src/cil_strpool.c | 2 --
>   2 files changed, 3 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil_mem.h b/libsepol/cil/src/cil_mem.h
> index 902ce131..794f02a3 100644
> --- a/libsepol/cil/src/cil_mem.h
> +++ b/libsepol/cil/src/cil_mem.h
> @@ -36,7 +36,6 @@ void *cil_calloc(size_t num_elements, size_t element_size);
>   void *cil_realloc(void *ptr, size_t size);
>   char *cil_strdup(const char *str);
>   int cil_asprintf(char **strp, const char *fmt, ...);
> -void (*cil_mem_error_handler)(void);
>   
>   #endif /* CIL_MEM_H_ */
>   
> diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpool.c
> index 97d4c4b9..508541d6 100644
> --- a/libsepol/cil/src/cil_strpool.c
> +++ b/libsepol/cil/src/cil_strpool.c
> @@ -80,7 +80,6 @@ char *cil_strpool_add(const char *str)
>   		int rc = hashtab_insert(cil_strpool_tab, (hashtab_key_t)strpool_ref->str, strpool_ref);
>   		if (rc != SEPOL_OK) {
>   			pthread_mutex_unlock(&cil_strpool_mutex);
> -			(*cil_mem_error_handler)();
>   			pthread_mutex_lock(&cil_strpool_mutex);
>   		}
>   	}

I removed the cil_mem_error_handler stuff last Fall (see commit 4459d635). I 
guess that I must have missed these somehow.

In the other places where I removed it, I replaced it with the inlined default 
hanlder which consisted of the following:

   cil_log(CIL_ERR, "Failed to allocate memory\n");
   exit(1);

Since we are existing, the pthread_mutex_lock() call can be removed.

> @@ -104,7 +103,6 @@ void cil_strpool_init(void)
>   		cil_strpool_tab = hashtab_create(cil_strpool_hash, cil_strpool_compare, CIL_STRPOOL_TABLE_SIZE);
>   		if (cil_strpool_tab == NULL) {
>   			pthread_mutex_unlock(&cil_strpool_mutex);
> -			(*cil_mem_error_handler)();
>   			return;
>   		}
>   	}
> 

Same thing here, but now the return won't be needed.

Thanks,
Jim


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
