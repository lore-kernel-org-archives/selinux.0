Return-Path: <SRS0=dLD2=QS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37636C169C4
	for <selinux@archiver.kernel.org>; Mon, 11 Feb 2019 19:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15AF21B68
	for <selinux@archiver.kernel.org>; Mon, 11 Feb 2019 19:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Q/lrKjxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbfBKTGo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:06:44 -0500
Received: from upbd19pa11.eemsg.mail.mil ([214.24.27.86]:58844 "EHLO
        upbd19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387511AbfBKTGn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Feb 2019 14:06:43 -0500
X-EEMSG-check-017: 188561870|UPBD19PA11_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Feb 2019 19:06:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549912001; x=1581448001;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=CCl25gJf8HBi+8kUabyBi3J+6cCeYyeSZfKIcwwIQBQ=;
  b=Q/lrKjxi0j2TZxSFEASl3eirxHx0LQ+vgtUm2MSbePWpmuaENFHOfZk+
   riacBw7f6HXCRSsJxzyelRjqt+PYUiQrHWKahfEraO06d8KIAT+9Huy4I
   NQrn5j73dCOINc1pwGTwMorCT9M+oWg59oJ8UjFkcb0jAdwG+Ittl8Xg7
   Za18GdRv0m4b7loGtQM/epOWlbZ3RrtWctpS13UYoApeRsjROsniLs+2L
   5y2UJbIBTxxalGV6HHg+Fyo1qvh9BJkmCnHC4lraEeEFThJLiuHw+fdmg
   4esNHNDfTIGJNP+NRedAl3qyyEFLE85Lic9xWwweMF9geeBgwJoXuHV1P
   g==;
X-IronPort-AV: E=Sophos;i="5.58,359,1544486400"; 
   d="scan'208";a="20416228"
IronPort-PHdr: =?us-ascii?q?9a23=3ALclNehf5fbjYsN/QVFhulyp6lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcS9Yx7h7PlgxGXEQZ/co6odzbaO4+a4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahYr5+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNI/pUo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
 =?us-ascii?q?ovHg7J3gMvA90AvW/IrNj3LqoeTfy5wafKwDjFcvhY2S396I/Nch05o/GNU6?=
 =?us-ascii?q?5/ftDLyUkzCQ/Ok1KdqY7rPjyJzOsNqXSb4/R7WOKzi28otwFxoj+1yscqkY?=
 =?us-ascii?q?nGnJgZyl/D9SVn2Ys4I8CzRk1jYdO8DZdduC6XO5F2T88/WW1kpik3xqMctZ?=
 =?us-ascii?q?KmeiUB1Y4pyATFa/OddoiF+hfjVOGMLjhmnH9lY7e/hwqq8Uin1+38StG40F?=
 =?us-ascii?q?ZUoSpBldnBrmwN2AbJ6siGV/t95V2t2SqP1g/P6uFEJlo4lazHJJ463rE8jJ?=
 =?us-ascii?q?8TsUXHHiPumUX2irGZdlk89+S15Onqba/qq5+BO4NulA3zPboiltaiDeggNw?=
 =?us-ascii?q?gBRWmb+eCy1L35+k35Ra1Hjv84k6bFqp/aP9gbqrCiDg9J0ocs9xa/DzC83N?=
 =?us-ascii?q?QehnkINkhJeB2Aj4j3I13OOuz3De+jg1Swlzdm3/bGPrz9DZXKKnjMiqzhca?=
 =?us-ascii?q?x8605bzwoz1stf6olRCrwOL/P/QEjxtMbXDhUhKQy73/7nCMlh1oMZQW+PGb?=
 =?us-ascii?q?GWMKfTsV+O++IuLPKBZJEauDnjMfgp/f3ugmEjmV8bY6ap2YEbaHeiHvRpcA?=
 =?us-ascii?q?2lZi/Kg9wGFW4R9is5S/fxwAmEUDVUY3+pGaM74SogIIf6HcHEXI/7xPSa0S?=
 =?us-ascii?q?O6GIBGTn5JB0rKEnrycYiAHfAWZ3G8OMhkxz4bXrG7V9VpgROxvwbg1+BPMv?=
 =?us-ascii?q?vf+ipes4nqktdy+buAxlkJ6TVoApHFgCm2RGZukzZNHmVu0Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BiAwDqxmFc/wHyM5BjHAEBAQQBAQcEAQGBZYFbKYFqJ?=
 =?us-ascii?q?4QElAuBYAglmg44AYRAAoM/IjgSAQMBAQEBAQECAWwogjopAYJnAQUjBBFRC?=
 =?us-ascii?q?wkPAgImAgJXBgEMBgIBAYJhP4ICqnV8M4VEhGuBC4s4gVZAgREnDIJfiAqCV?=
 =?us-ascii?q?wKBLAGPVzuRYAYDkkoGGZJgiWRPk2YhgVYrCkGBaIFOgigXE44pIQMwgQUBA?=
 =?us-ascii?q?Y0nAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 11 Feb 2019 19:06:39 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions.infosec.tycho.ncsc.mil [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1BJ6X16005957;
        Mon, 11 Feb 2019 14:06:33 -0500
Subject: Re: [Non-DoD Source] [PATCH 1/1] libsepol/cil: silence static
 analyser's use-after-free warning
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190206210752.11828-1-nicolas.iooss@m4x.org>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <d1643ffa-0e04-552f-9903-fa1f111029df@tycho.nsa.gov>
Date:   Mon, 11 Feb 2019 14:06:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206210752.11828-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/19 4:07 PM, Nicolas Iooss wrote:
> clang's static analyze reports a use-after-free in
> __cil_expr_to_string(), when __cil_expr_to_string_helper() does not
> modify its third parameter (variable s1 here) in this loop:
> 
>      for (curr = curr->next; curr; curr = curr->next) {
>          __cil_expr_to_string_helper(curr, flavor, &s1);
>          cil_asprintf(&c2, "%s %s", c1, s1);
>          free(c1);
>          free(s1);
>          c1 = c2;
>      }
> 
> Silence this warning by making sure s1 is always NULL at the beginning
> of every iteration of the loop.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@tycho.nsa.gov>

> ---
>   libsepol/cil/src/cil_binary.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index a10c3763bea4..e2eb3ebe8ff3 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -2075,6 +2075,7 @@ static void __cil_expr_to_string(struct cil_list *expr, enum cil_flavor flavor,
>   		char *c2 = NULL;
>   		__cil_expr_to_string_helper(curr, flavor, &c1);
>   		for (curr = curr->next; curr; curr = curr->next) {
> +			s1 = NULL;
>   			__cil_expr_to_string_helper(curr, flavor, &s1);
>   			cil_asprintf(&c2, "%s %s", c1, s1);
>   			free(c1);
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
