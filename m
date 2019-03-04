Return-Path: <SRS0=k4Wl=RH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C158EC43381
	for <selinux@archiver.kernel.org>; Mon,  4 Mar 2019 18:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E62F2070B
	for <selinux@archiver.kernel.org>; Mon,  4 Mar 2019 18:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="bSt0iHqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfCDSa4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:30:56 -0500
Received: from uhil19pa13.eemsg.mail.mil ([214.24.21.86]:61531 "EHLO
        uhil19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCDSaz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Mar 2019 13:30:55 -0500
X-EEMSG-check-017: 378388734|UHIL19PA13_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Mar 2019 18:30:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551724245; x=1583260245;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=sLVHxhSiSs89Yqcr7dpK9hb1zk/M7caP66KpGUUDE+o=;
  b=bSt0iHqKadthkHhtoeCSp6c+zGbHNtHBit0xKVeqkdroVvlLQu9FfxCM
   SWWmtQN37QueikyXBXMoZ3gZDAs9dpeuMckWj2pp9rhWOtMVPIhUwH0YW
   xii9OsP1s+/zcTxZhh+N8UdFPj67qeyXuGX5rTbQ8RZ5PueR6lryG6WxL
   tW20Wa6xtmdApqRAfYKr2Qavvwnr+E6NJVkoC7tNefN/x32nQmOCAr8QR
   EFjLYoPqndgTsjDjkb7FDT0Wj3l6YFsRItyT8WGYNf90mgI/SdrT6wfN/
   pQLVzbR9crF/exMxAMdx3ZH3nfvFl/CkBoc+o1X7bTfpF9Ap579L+vh1M
   w==;
X-IronPort-AV: E=Sophos;i="5.58,440,1544486400"; 
   d="scan'208";a="24585936"
IronPort-PHdr: =?us-ascii?q?9a23=3AGpfWgRf1jq8cPBETMi4rtdFVlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcS9Yh7h7PlgxGXEQZ/co6odzbaP6+a4ACQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagfb9+Ngm6oRjMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNI+JVo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
 =?us-ascii?q?ovHg7J3gMvA90AvW/IrNj3LqoeTfy5wafKwDjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBetDmaOpNrTs4tTGxkoiY3xqActZ?=
 =?us-ascii?q?KlcyUG1o4rywPZZveaaYaH+AjjW/yUITpggXJlf6+wiAiq/Ei7z+38StG00F?=
 =?us-ascii?q?FXripZitXMtm4C1xjU6sWfVvty5F2h2TeS1wDI8O1EPUA1mrbbK54m2LIwkI?=
 =?us-ascii?q?YcsV/fESPsnUX2jauWel0l+uiu9evnfq3rqoKTOoJ7kA3zMrkiltahDek3LA?=
 =?us-ascii?q?QCRXWX9fy51LL5/E35RLtKjucxkqncqJ3aPtkUprWiDg9J0ocs9xa/DzC83N?=
 =?us-ascii?q?QehnkINkhJeB2Aj4j3I13OOuz3De+jg1Swlzdm3+jGPrn7DZXQMnjDiqzucq?=
 =?us-ascii?q?xm5k5G1gU80NBf6IhICr0bPP3zXUrxvsTCDhAlKwy03/rnCNJl24MFR22PBq?=
 =?us-ascii?q?6ZMKXPsV6H/e8vPeaMa5EPuDrnKPgq+eTujXknll8ZZ6Wp2oEXaH/rVshhdn?=
 =?us-ascii?q?2UfWCkpt4cDX0AtwE+BLjyjFSfTSRZbl6oUq487y19A4WjW8OLXY2pgbqczA?=
 =?us-ascii?q?+lEZBMIGNLEFaBFTHvbYrXde0LbXepPsJ5kjECHYOkQosl2ADm4BT20JJ7P+?=
 =?us-ascii?q?HU/Wserpul299rsb6A3Sou/CB5WpzOm1qGSHt5yyZRHW47?=
X-IPAS-Result: =?us-ascii?q?A2CtAABjbn1c/wHyM5BkHQEBBQEHBQGBUgcBCwGBZSqBO?=
 =?us-ascii?q?DMnhAiTZUwBAQEBAQEGgQgtfIhAiVOFEoF7OAGEQAKEJSI1CA0BAQMBAQECA?=
 =?us-ascii?q?QMCAWwogjopAYJnAQUjFVELDgoCAiYCAlcGAQwGAgEBgl8/gWkNqSaBL4VEh?=
 =?us-ascii?q?GaBCyQBiycXeIEHgREngjY1hEqDQYJXAol+O4YrTDtckT0Jkm4GGZMiLYo3l?=
 =?us-ascii?q?BMDM4FWKwgCGAghD4MnghYXjjwhAzCBBQEBjUGCTQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Mar 2019 18:30:35 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x24IUZf1019686;
        Mon, 4 Mar 2019 13:30:35 -0500
Subject: Re: [PATCH] libselinux: Add security_reject_unknown(3) man page
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20190304163735.29563-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1a98677c-7e70-b965-04fb-7ac01fa6c5d6@tycho.nsa.gov>
Date:   Mon, 4 Mar 2019 13:23:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304163735.29563-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/4/19 11:37 AM, Petr Lautrbach wrote:
> Commit c19395d7 added a new interface security_reject_unknown() which needs to
> be documented.
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>   libselinux/man/man3/security_getenforce.3     | 9 ++++++++-
>   libselinux/man/man3/security_reject_unknown.3 | 1 +
>   2 files changed, 9 insertions(+), 1 deletion(-)
>   create mode 100644 libselinux/man/man3/security_reject_unknown.3
> 
> diff --git a/libselinux/man/man3/security_getenforce.3 b/libselinux/man/man3/security_getenforce.3
> index 29cf3de7..8d72afb6 100644
> --- a/libselinux/man/man3/security_getenforce.3
> +++ b/libselinux/man/man3/security_getenforce.3
> @@ -1,6 +1,7 @@
>   .TH "security_getenforce" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
>   .SH "NAME"
> -security_getenforce, security_setenforce, security_deny_unknown, security_get_checkreqprot\- get or set the enforcing state of SELinux
> +security_getenforce, security_setenforce, security_deny_unknown, security_reject_unknown,
> +security_get_checkreqprot\- get or set the enforcing state of SELinux
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
> @@ -27,6 +30,10 @@ returned.
>   returns 0 if SELinux treats policy queries on undefined object classes or
>   permissions as being allowed, 1 if such queries are denied, and \-1 on error.
>   
> +.BR security_reject_unknown ()
> +returns 0 if SELinux allows to load a policy which doesn't define all object
> +classes and permissions, 1 if loading such policy is rejected, and \-1 on error.

s/all object classes and permissions/all kernel object classes and 
permissions/

A policy can still be loaded if it is missing userspace object classes 
and permissions regardless of security_reject_unknown(), although the 
object manager may later encounter a failure upon selinux_set_mapping(), 
which internally calls security_reject_unknown() to decide how to 
proceed, or direct attempts to lookup the class or permission via 
string_to_security_class() or string_to_av_perm().

I don't know of anyone building policies with handle_unknown == reject 
so it is unlikely that anyone is testing this case.  deny is the 
default.  allow is set in Fedora/RHEL.  Android uses deny.

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

