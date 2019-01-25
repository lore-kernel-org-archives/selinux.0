Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE73C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BCE218CD
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 14:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="LiElf3Ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAYOqw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:46:52 -0500
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:46116 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfAYOqw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 09:46:52 -0500
X-EEMSG-check-017: 666966836|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,521,1539648000"; 
   d="scan'208";a="666966836"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Jan 2019 14:46:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1548427609; x=1579963609;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=R3TtTJAt3BWugOZQAuRBoz94ClHdABsAxq92V8W5BiM=;
  b=LiElf3NiLCVI5n2QXRkThvVTCeLNWBOoWttBIUpzQ2Fl80HEJfIoq5ZJ
   4v1pOLbK/fUj2FiTxlZzo9BYij5FzY08a4clPfeFeDLcfZP+i2SNZrfEB
   zWNamZbwYF9oskkQJUvoNZ0gZ5c1YG3VphURwETsTrEjS037sVL1La4xV
   ktPR1ipxnwGnkWHCFRdtHDSDXw6UcSHjgfTkJEs2Z/Q+TmhrbikQyHfzj
   0K6RAdJSJp+K964LlYcEQ4UU/uDbw7v4eMksD9YM11KAzlRrAScxLH60C
   xG7Rehb+WQj89zAZpApPy5UY0qhiBg2XroH2HX9OGx14vxQrub7Pj1hQ7
   w==;
X-IronPort-AV: E=Sophos;i="5.56,521,1539648000"; 
   d="scan'208";a="23086085"
IronPort-PHdr: =?us-ascii?q?9a23=3AkqlQCBwcgCDCFLbXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoUL/ad9pjvdHbS+e9qxAeQG9mDu7Qc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYAhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcZcDA+8HMO1FrYfyukEOoAOjCweyCuPhyjxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98MqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1YsakHYNNuyyVOIZ6WMMvT3xytCokxbAKp4?=
 =?us-ascii?q?S3cDUMxZ863RDQceaHfJKN4h/7UeaRJip3i2x9dbKkghay7VCgyurhVsmoyF?=
 =?us-ascii?q?pKrjRKkt3Ltn0Vyxzc8NKHSvpg/ke6wzqPywDS5f1EIUAzj6bbLYIuwqUsmZ?=
 =?us-ascii?q?YJtETDHyv2lF33jK+QaEok5vCl5/nob7jpvJORN5J4hhvgPqkhhMCzG/k0Ph?=
 =?us-ascii?q?ALX2eB+OS80LPj/Vf+QLVPlvA2ibTWsIvBKMQHpq+2Hw9V0oE55xa5FDepys?=
 =?us-ascii?q?4UnXYALFJbYB6HlZTmO0nSIPDkCveym1OskDJsx/DdOL3uGInCIWbYnbf7Y7?=
 =?us-ascii?q?ly9k5cxxAvzdxF+51UDbQBKurpWkDtrNzYEgM5Mwuszub8Ftp90oIeWWSSAq?=
 =?us-ascii?q?6WK67Sr1CI6fw1I+WWZ48apiz9K/476P7ql3M5nkUdfaax15sNdH+4BuhmI1?=
 =?us-ascii?q?meYXf0mtcOC3oKvg4lQezyklKCTDpTa2+3X6I74TE7EpypAZ3fSYCqhbyLxD?=
 =?us-ascii?q?27EYFOZmBaFlCMFm/ld4GFW/cKdSKTLdZtnSYZVbe8So8hyQqjtBXkxLV6Lu?=
 =?us-ascii?q?rb4DEYuYj/29hy4u2A3S01oBtyA96Q0SmoSHpyl2gFRHdi26V4ukp0wVqry6?=
 =?us-ascii?q?V0g/VEU9dU4qUNGhw3MZ/a0vxSFd//QETCc82PRVLgRc+pRXkJR881i/oJZF?=
 =?us-ascii?q?xwU4G6hw3H9zKjHrtQkruMHpFy+aXZiSvfPcF4nk3a2bEhgl9uec5GMWmrl+?=
 =?us-ascii?q?Yr7ATIL5LYmEWe0aCxfOIT2zCbpzTL9naHoEwNCF04aq7CR31KIxKM9dk=3D?=
X-IPAS-Result: =?us-ascii?q?A2AkAQC1IEtc/wHyM5BkGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?YE3ATInhAGUEUwBAQEBAQEGgQgIJYk0kE44AYRAAoMJIjgSAQMBAQEBAQECA?=
 =?us-ascii?q?WwogjopAYJnAQUjBBFBEAsOCgICJgICVwYBDAYCAQGCXz+BdQ2rJHwzhUOEb?=
 =?us-ascii?q?YELizYXeIEHgTgMgio1iAqCVwKJVxWGJ0k5VpBNCZIkBgIWkieKE5MPIYFWK?=
 =?us-ascii?q?wgCGAghD4MngicXjjwhAzCBBQEBiicBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 25 Jan 2019 14:46:48 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0PEklO8008608;
        Fri, 25 Jan 2019 09:46:47 -0500
Subject: Re: [PATCH v3 1/4] selinux: inline some AVC functions used only once
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com
References: <20190125100651.21753-1-omosnace@redhat.com>
 <20190125100651.21753-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <10788722-11ec-104a-682e-a4fd3bb4b39a@tycho.nsa.gov>
Date:   Fri, 25 Jan 2019 09:49:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125100651.21753-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/25/19 5:06 AM, Ondrej Mosnacek wrote:
> avc_dump_av() and avc_dump_query() are each used only in one place. Get
> rid of them and open code their contents in the call sites.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/avc.c | 140 +++++++++++++++++------------------------
>   1 file changed, 58 insertions(+), 82 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 9b63d8ee1687..502162eeb3a0 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -129,75 +129,6 @@ static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
>   	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
>   }
>   
> -/**
> - * avc_dump_av - Display an access vector in human-readable form.
> - * @tclass: target security class
> - * @av: access vector
> - */
> -static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
> -{
> -	const char **perms;
> -	int i, perm;
> -
> -	if (av == 0) {
> -		audit_log_format(ab, " null");
> -		return;
> -	}
> -
> -	BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
> -	perms = secclass_map[tclass-1].perms;
> -
> -	audit_log_format(ab, " {");
> -	i = 0;
> -	perm = 1;
> -	while (i < (sizeof(av) * 8)) {
> -		if ((perm & av) && perms[i]) {
> -			audit_log_format(ab, " %s", perms[i]);
> -			av &= ~perm;
> -		}
> -		i++;
> -		perm <<= 1;
> -	}
> -
> -	if (av)
> -		audit_log_format(ab, " 0x%x", av);
> -
> -	audit_log_format(ab, " }");
> -}
> -
> -/**
> - * avc_dump_query - Display a SID pair and a class in human-readable form.
> - * @ssid: source security identifier
> - * @tsid: target security identifier
> - * @tclass: target security class
> - */
> -static void avc_dump_query(struct audit_buffer *ab, struct selinux_state *state,
> -			   u32 ssid, u32 tsid, u16 tclass)
> -{
> -	int rc;
> -	char *scontext;
> -	u32 scontext_len;
> -
> -	rc = security_sid_to_context(state, ssid, &scontext, &scontext_len);
> -	if (rc)
> -		audit_log_format(ab, "ssid=%d", ssid);
> -	else {
> -		audit_log_format(ab, "scontext=%s", scontext);
> -		kfree(scontext);
> -	}
> -
> -	rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
> -	if (rc)
> -		audit_log_format(ab, " tsid=%d", tsid);
> -	else {
> -		audit_log_format(ab, " tcontext=%s", scontext);
> -		kfree(scontext);
> -	}
> -
> -	BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
> -	audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
> -}
> -
>   /**
>    * avc_init - Initialize the AVC.
>    *
> @@ -735,11 +666,37 @@ out:
>   static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>   {
>   	struct common_audit_data *ad = a;
> -	audit_log_format(ab, "avc:  %s ",
> -			 ad->selinux_audit_data->denied ? "denied" : "granted");
> -	avc_dump_av(ab, ad->selinux_audit_data->tclass,
> -			ad->selinux_audit_data->audited);
> -	audit_log_format(ab, " for ");
> +	struct selinux_audit_data *sad = ad->selinux_audit_data;
> +	u32 av = sad->audited;
> +	const char **perms;
> +	int i, perm;
> +
> +	audit_log_format(ab, "avc:  %s ", sad->denied ? "denied" : "granted");
> +
> +	if (av == 0) {
> +		audit_log_string(ab, " null");
> +		return;
> +	}
> +
> +	BUG_ON(!sad->tclass || sad->tclass >= ARRAY_SIZE(secclass_map));
> +	perms = secclass_map[sad->tclass-1].perms;
> +
> +	audit_log_string(ab, " {");
> +	i = 0;
> +	perm = 1;
> +	while (i < (sizeof(av) * 8)) {
> +		if ((perm & av) && perms[i]) {
> +			audit_log_format(ab, " %s", perms[i]);
> +			av &= ~perm;
> +		}
> +		i++;
> +		perm <<= 1;
> +	}
> +
> +	if (av)
> +		audit_log_format(ab, " 0x%x", av);
> +
> +	audit_log_string(ab, " } for ");
>   }
>   
>   /**
> @@ -751,15 +708,34 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>   static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
>   {
>   	struct common_audit_data *ad = a;
> -	audit_log_format(ab, " ");
> -	avc_dump_query(ab, ad->selinux_audit_data->state,
> -		       ad->selinux_audit_data->ssid,
> -		       ad->selinux_audit_data->tsid,
> -		       ad->selinux_audit_data->tclass);
> -	if (ad->selinux_audit_data->denied) {
> -		audit_log_format(ab, " permissive=%u",
> -				 ad->selinux_audit_data->result ? 0 : 1);
> +	struct selinux_audit_data *sad = ad->selinux_audit_data;
> +	char *scontext;
> +	u32 scontext_len;
> +	int rc;
> +
> +	rc = security_sid_to_context(sad->state, sad->ssid, &scontext,
> +				     &scontext_len);
> +	if (rc)
> +		audit_log_format(ab, " ssid=%d", sad->ssid);
> +	else {
> +		audit_log_format(ab, " scontext=%s", scontext);
> +		kfree(scontext);
>   	}
> +
> +	rc = security_sid_to_context(sad->state, sad->tsid, &scontext,
> +				     &scontext_len);
> +	if (rc)
> +		audit_log_format(ab, " tsid=%d", sad->tsid);
> +	else {
> +		audit_log_format(ab, " tcontext=%s", scontext);
> +		kfree(scontext);
> +	}
> +
> +	BUG_ON(!sad->tclass || sad->tclass >= ARRAY_SIZE(secclass_map));
> +	audit_log_format(ab, " tclass=%s", secclass_map[sad->tclass-1].name);
> +
> +	if (sad->denied)
> +		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
>   }
>   
>   /* This is the slow part of avc audit with big stack footprint */
> 

