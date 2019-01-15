Return-Path: <SRS0=jgNJ=PX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD7DC43612
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 13:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D53820868
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 13:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZsTFP92w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfAONzv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:55:51 -0500
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:15466 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfAONzu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Jan 2019 08:55:50 -0500
X-EEMSG-check-017: 192439346|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Jan 2019 13:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547560545; x=1579096545;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ipVTueNHPDKw7/n+vABBjYFZcZcNpNIyuZkBieByRqk=;
  b=ZsTFP92wytyC0g/MwxddgzJR4odPFZs2RkUYfO4d61sc+EP9Yj+QKbGS
   hrbocIfmFH2d/Zp+3S/JoXKejJdv6dwbbDD/wAtn9h7M79QniGcamr7VI
   c7tEh7o6MTM4laiOkPcJFVhfYQ6BTbToeVHJAg+2nlk6IN+gdyexvMStG
   lY7iTAx/gC93JFugv6wAdL2uNowakZwQHAtScsYBFyET3dVBj0UD6/PVJ
   T28Pg/jD4B32eo/Cgvfs9+QmZNNe9QxiqUkOfuSVUeSTQ/FxV/vtLGuuN
   AqdKj+Du14U7SgY5R4/VzuJLmLmrLN8EjPkFcT2Aqffyp2UhNqebZZkLZ
   A==;
X-IronPort-AV: E=Sophos;i="5.56,481,1539648000"; 
   d="scan'208";a="19522131"
IronPort-PHdr: =?us-ascii?q?9a23=3A5TUDlheKrThhu1ls2D5FyChNlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcS9Yh7h7PlgxGXEQZ/co6odzbaO4+a4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahYr5+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNI/pUo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
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
 =?us-ascii?q?HU/Wserpul299rsb6A3Sou/CB5WpzOm1qGSHt5yyZRHWc7?=
X-IPAS-Result: =?us-ascii?q?A2CWAAB75T1c/wHyM5BjHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopZk8zJ4QBlAxSBoE1iS+QSCgQAYRAAoJCIjcGDQEDAQEBAQEBAgFsHAyCO?=
 =?us-ascii?q?ikBgmcBBSMVUQsOCgICJgICVwYBDAYCAQGCXz8BgXQNrGWBL4VChHGBC4s0F?=
 =?us-ascii?q?3iBB4E4gmuESoNAglcCkEQ4kQkJhyCKZwYYgjGPT4l4klQigVYrCAIYCCEPg?=
 =?us-ascii?q?ycJjHGEACEDMIEFAQGHVYJNAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Jan 2019 13:55:44 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0FDth4p019239;
        Tue, 15 Jan 2019 08:55:43 -0500
Subject: Re: [PATCH] libselinux/audit2why.so: Filter out non-python related
 symbols
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <353f9889-d43c-9a14-4605-5ba1eac22284@tycho.nsa.gov>
 <20190115133629.21263-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3c3b0512-334d-524a-42be-e966cffa2f4a@tycho.nsa.gov>
Date:   Tue, 15 Jan 2019 08:57:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115133629.21263-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/15/19 8:36 AM, Petr Lautrbach wrote:
> audit2why.so used to export libsepol.a symbols. We only need Python related
> symbols:
> 
> - initaudit2why for python 2
> - PyInit_audit2why for python3
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libselinux/src/Makefile      | 2 +-
>   libselinux/src/audit2why.map | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
>   create mode 100644 libselinux/src/audit2why.map
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 8891086e..92e30738 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -165,7 +165,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
>   	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
>   
>   $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> -	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(LDLIBS_LIBSEPOLA) $(PYLIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(LDLIBS_LIBSEPOLA) $(PYLIBS) -Wl,-soname,audit2why.so,--version-script=audit2why.map,-z,defs
>   
>   %.o:  %.c policy.h
>   	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> diff --git a/libselinux/src/audit2why.map b/libselinux/src/audit2why.map
> new file mode 100644
> index 00000000..65989a8d
> --- /dev/null
> +++ b/libselinux/src/audit2why.map
> @@ -0,0 +1,6 @@
> +AUDIT2WHY_2.9 {
> +  global:
> +    initaudit2why;
> +    PyInit_audit2why;
> +  local: *;
> +};
> 

