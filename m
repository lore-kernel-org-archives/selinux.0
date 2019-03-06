Return-Path: <SRS0=Zlcp=RJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A54C43381
	for <selinux@archiver.kernel.org>; Wed,  6 Mar 2019 13:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAAF206DD
	for <selinux@archiver.kernel.org>; Wed,  6 Mar 2019 13:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="IWzE1Vmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCFNfY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:35:24 -0500
Received: from uphb19pa12.eemsg.mail.mil ([214.24.26.86]:4074 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbfCFNfY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Mar 2019 08:35:24 -0500
X-EEMSG-check-017: 189081920|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Mar 2019 13:35:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551879322; x=1583415322;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=X9BnZnhUvlOm85/CuBlFRz9D2NizH0rEwheroHB6Y/k=;
  b=IWzE1VmnQWVfOqtQL7yR1jIUTZIfHDDyF7b8p3/wxiWLrDjjzAwbmt90
   dwVSpfRgsP4T4/Rnj8+GFS+rjeOHmQIsHacT+Aggkgv0xDWmcPZytsPKD
   XCv6Jacl30rD+cr++tDyYMEkp1rhZPLNJdD70xbxIPrUUgGiF1xFY1Plp
   M9Ic8MMyByUisqrw8YJiWUWABEPfLdAV1Qr+tdvGFzAjyLEeTRpmtzVre
   68h1KcArPfIAFzkZ9GkDotLJpKe19RvxphAh1y1R0R/FAitQgDp0Nl7m0
   Tg832rI4nIB63m6BUiglZ+TDAfHkZFtwXWpPZwK7NW08evaG6JMwDftwV
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,448,1544486400"; 
   d="scan'208";a="21180800"
IronPort-PHdr: =?us-ascii?q?9a23=3At0H2FBX5QecqCOgAhziHCPWA85LV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbBOBt8tkgFKBZ4jH8fUM07OQ7/m4HzRZqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5uIBmssQndq9QdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94VS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMepGq4Txol0Dpga8CwaxHuPi0iJGiGH43aM60O?=
 =?us-ascii?q?ovHw/J0wMiEN0Sv3rZt8n1OaUIXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+ZL4t7Wt4uTm5ntSogyrAKpI?=
 =?us-ascii?q?S3cDYFxZg53RLTdvqKeJWS7B35TuaeOzJ4iWpgeLK4mhm971Ctyvb5VsmoyF?=
 =?us-ascii?q?ZKqTdFksXUunANyRPT7s+HR+Nh/ki7wzaP1h3T6vpeLUAolavUN54hwrkqmp?=
 =?us-ascii?q?oVrUvDBTP5lF/zjK+XckUo4umo6+L5bbX6vpKQKoB5hw7kPqkuh8CzG/o0Pw?=
 =?us-ascii?q?cQU2SB5OiwzLjj8lf4QLVOgP02iK7ZsJXCKMQAu6G5GBRY0poj6hmjDzem18?=
 =?us-ascii?q?4UnX8cLF1fYh6HgI/pO0/WLPDiEfi/m0iskCtsx/3eJr3hBo/CLmXfkLf7Zr?=
 =?us-ascii?q?ly8VVRyBAtwt9C55JbEK0BLOjvVU/2sdzSFgU5PBCsw+b7FNV90ZsTWXmRDa?=
 =?us-ascii?q?+dMaPSt0KI5+00LumSa48apiz9J+Im5/Hwl385n0ESfa2z0ZsQcnC4EacuH0?=
 =?us-ascii?q?LMWXfwmJ8lGHoWpAA3R+yi3EWGWCNPfXy7d7gx6jEyFMStCoKVAsi2jbiA2j?=
 =?us-ascii?q?qrNoNZa3oACV2WF3rsMYKeVKQiciWXd/R9nyQEWL7pcIoo0RWjpUeu0LZ8Bv?=
 =?us-ascii?q?bF8S0f85T43Z564POFxkJ6ziB9E8nIizLFdGpzhG5dAmZsja0=3D?=
X-IPAS-Result: =?us-ascii?q?A2CFAABRy39c/wHyM5BkHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?WUqgWsnhAiTZEwBAQEBAQEGgTV8iECJVYUSgXs4AYRAAoQxIjYHDQEBAwEBA?=
 =?us-ascii?q?QIBAwIBbCiCOikBgmcBBSMVUQsOCgICJgICVwYBDAYCAQGCXz+BaQ2rJYEvh?=
 =?us-ascii?q?USEZ4ELJAGLKBd4gQeBESeCNjWESoNBglcCigERhldMO1yRQwmSegYZky8ti?=
 =?us-ascii?q?kKUJgMugVYrCAIYCCEPgyeCFheOPCEDMIEFAQGKQYJNAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Mar 2019 13:35:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x26DZJci005352;
        Wed, 6 Mar 2019 08:35:21 -0500
Subject: Re: [PATCH v3] libselinux: Add security_reject_unknown(3) man page
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <pjdy35sma9h.fsf@redhat.com>
 <20190306125814.22023-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d303cc9d-e439-994f-1f98-48c98a6c8866@tycho.nsa.gov>
Date:   Wed, 6 Mar 2019 08:26:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306125814.22023-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/6/19 7:58 AM, Petr Lautrbach wrote:
> Commit c19395d72295 ("libselinux: selinux_set_mapping: fix handling of unknown
> classes/perms") added a new interface security_reject_unknown() which needs to
> be documented.
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libselinux/man/man3/security_getenforce.3     | 20 ++++++++++++++++++-
>   libselinux/man/man3/security_reject_unknown.3 |  1 +
>   2 files changed, 20 insertions(+), 1 deletion(-)
>   create mode 100644 libselinux/man/man3/security_reject_unknown.3
> 
> diff --git a/libselinux/man/man3/security_getenforce.3 b/libselinux/man/man3/security_getenforce.3
> index 29cf3de7..f339b8b0 100644
> --- a/libselinux/man/man3/security_getenforce.3
> +++ b/libselinux/man/man3/security_getenforce.3
> @@ -1,6 +1,7 @@
>   .TH "security_getenforce" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
>   .SH "NAME"
> -security_getenforce, security_setenforce, security_deny_unknown, security_get_checkreqprot\- get or set the enforcing state of SELinux
> +security_getenforce, security_setenforce, security_deny_unknown, security_reject_unknown,
> +security_get_checkreqprot \- get or set the enforcing state of SELinux
>   .
>   .SH "SYNOPSIS"
>   .B #include <selinux/selinux.h>
> @@ -11,6 +12,8 @@ security_getenforce, security_setenforce, security_deny_unknown, security_get_ch
>   .sp
>   .B int security_deny_unknown(void);
>   .sp
> +.B int security_reject_unknown(void);
> +.sp
>   .B int security_get_checkreqprot(void);
>   .
>   .SH "DESCRIPTION"
> @@ -27,6 +30,21 @@ returned.
>   returns 0 if SELinux treats policy queries on undefined object classes or
>   permissions as being allowed, 1 if such queries are denied, and \-1 on error.
>   
> +.BR security_reject_unknown ()
> +returns 1 if the current policy was built with handle-unknown=reject and SELinux
> +would reject loading it, if it did not define all kernel object classes and
> +permissions. In this state, when
> +.BR selinux_set_mapping()
> +and
> +.BR selinux_check_access()
> +are used with an undefined userspace class or permission, an error is returned
> +and errno is set to EINVAL.
> +
> +It returns 0 if the current policy was built with handle-unknown=allow or
> +handle-unknown=deny. In this state, policy queries are treated according to
> +.BR security_deny_unknown().
> +\-1 is returned on error.
> +
>   .BR security_get_checkreqprot ()
>   can be used to determine whether SELinux is configured to check the
>   protection requested by the application or the actual protection that will
> diff --git a/libselinux/man/man3/security_reject_unknown.3 b/libselinux/man/man3/security_reject_unknown.3
> new file mode 100644
> index 00000000..d59e5c2c
> --- /dev/null
> +++ b/libselinux/man/man3/security_reject_unknown.3
> @@ -0,0 +1 @@
> +.so man3/security_getenforce.3
> 

