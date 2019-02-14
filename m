Return-Path: <SRS0=aI9x=QV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C23C43381
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 21:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBDE2147C
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 21:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="RBX2w/VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440196AbfBNVbb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:31:31 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:48640 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392871AbfBNVbb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Feb 2019 16:31:31 -0500
X-EEMSG-check-017: 685782846|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,370,1544486400"; 
   d="scan'208";a="685782846"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2019 21:31:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550179889; x=1581715889;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1zRfHdobMTB74n9f193SLELxwY3K50YxAG74kaAQUcY=;
  b=RBX2w/VNHWx1FKBesXBt3B5doMFWx3fLGe91cgaACoRlTInrcr8r0Gjs
   6nZm0nY542igwMpFrqg7TUIig24HUFjSlfgS59BiaHqJh+42cTKu2Ci8G
   Bnr1zK2udFUr/36zPoJWshZfYHXYRsdmsbclCXV+4yh05ldPvJrE06nJq
   M+m26dtXvTl091vV3BjgA92tukPsTjpsPvzxDWKrJT2GM8V1RxgtiwBuq
   0PJns+UX6nn2TZJGa1njgiiTLvq6IYgXX1hebU29fXNhtF8L3l73RyWqK
   74wIJtHtVwe9V++1SUZ5DS2NJ/jEI3D3dTJyqouDkl8sLhcmZx/yRjf9v
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,370,1544486400"; 
   d="scan'208";a="20575677"
IronPort-PHdr: =?us-ascii?q?9a23=3A8zwzNhEg7S6xrvq/y5hvu51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zpM2wAkXT6L1XgUPTWs2DsrQY07qQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDmwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/Vj?=
 =?us-ascii?q?q476dvVRTmliEJOTAk+23Tk8B8kb5XrBenqhdiwYDbfZuVOeJjcK3Dc9MURW?=
 =?us-ascii?q?lPUMhfWCNOAIyzc4QBAvEdPetatYTxu0cCoBW8CASqGejhyiVIhnjz3aAizu?=
 =?us-ascii?q?ohDR/J3BQgH90QtnTfscj7NKIIXuCxyKnH0zXCZO5R1Dfm9YfIaQssoe2MXL?=
 =?us-ascii?q?1sccrRzlMjFwXejlqKs4DlMDSV1voUvmWd8uFuW+Wvi2s9pAFwpDii3sgsio?=
 =?us-ascii?q?jVhoIV11DL7j91z5oyJd29TkNwfN2qEINIui2HOIZ7TdkuTmF1tCog1LELto?=
 =?us-ascii?q?C3cDIXxJkh2hXRceaIc5KS7RLmTOuRJDB4i297d7+nnBay9FSgyvX7VsmpzF?=
 =?us-ascii?q?ZGtipFncfItnAKzxHT9tKISuF8/ke8wjaDzRzT6+FYLkA0kqrXMZghzaIrlp?=
 =?us-ascii?q?UPq0jDGy72mEHugK+XcEUr5PSo5vz6brjpqZKQLY95hhzkPqgwlcGzH/40Ph?=
 =?us-ascii?q?UWU2ie4+u81bnj/UPjQLVNi/07irLZv43BJckAuq64AxNa0oYk6xqlCTemy8?=
 =?us-ascii?q?4XkWMILFJCZhKLl5LpNE3WIPDkEfe/hEyhkC9xyPDbOr3sGY3NIWLekLflZL?=
 =?us-ascii?q?p97klcyA0pzd9B/Z5bFrYBIPfrUE/rqNPYFgM5MxCzw+v/E9VyyIceWWOJAq?=
 =?us-ascii?q?+EP6LfqkGI5u0xLOmWfoMVuyjyK+Ij5/HwiX81g1gdfbOm3chfVHftBv17J2?=
 =?us-ascii?q?2BaGfox9IGFn0H+AE5Sb/EklqHBAVPam6yUqR03TQyDIarHM+XXYy2qKCQ1y?=
 =?us-ascii?q?e8WJtNbyZJDU7aQiSgTJmNR/pZMHHaGcRmiDFREOH5Rg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BLCADv3GVc/wHyM5BaCh0BAQUBBwUBgWWBWilngQMnh?=
 =?us-ascii?q?AaUCk0BAQEBAQaBCAgliTiOb4FnMAgBg3pGAoNjIjgSAQMBAQEBAQECAWwcD?=
 =?us-ascii?q?II6KYJoAQUjFTYLEAsYAgImAgJXEwYCAQGCXz0BgWUND6sdgS+FRIRzgQuLO?=
 =?us-ascii?q?Rd4gQeBOAyCX4MeAoEuAQcLAWyCPIJXAol7hxA7WpEOCYc6ixQGGYFuVoR+i?=
 =?us-ascii?q?zGLSYQ0jjIhZXErCAIYCCEPO4JsCYYBhAiGaSEDMIEFAQGNF4I+AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Feb 2019 21:31:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1ELVSWX006202;
        Thu, 14 Feb 2019 16:31:28 -0500
Subject: Re: [PATCH] selinux-testsuite: fix userspace, refpolicy, and mailing
 list
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org
References: <20190214190721.1074-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1f33e665-6147-9c22-ac53-36843035d321@tycho.nsa.gov>
Date:   Thu, 14 Feb 2019 16:31:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214190721.1074-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/19 2:07 PM, Stephen Smalley wrote:
> Update the URLs for the selinux userspace and refpolicy releases,
> and the email address for the selinux mailing list.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

I went ahead and applied this since it is a trivial doc fix.

> ---
>   README.md | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/README.md b/README.md
> index cf90ef6..26784f8 100644
> --- a/README.md
> +++ b/README.md
> @@ -79,12 +79,12 @@ integrated into the `coreutils` package, with support for the `chcon` and
>   If the base distribution does not include the SELinux userland, then the
>   source code for the core SELinux userland packages can be obtained from:
>   
> -* https://github.com/SELinuxProject/selinux/wiki/Releases
> +* https://github.com/SELinuxProject/selinux/releases
>   
>   If the base distribution does not include a policy configuration, then
>   the reference policy can be obtained from:
>   
> -* https://github.com/TresysTechnology/refpolicy/wiki/DownloadRelease
> +* https://github.com/SELinuxProject/refpolicy/releases
>   
>   ### Optional Prerequisites
>   
> @@ -182,7 +182,7 @@ to help identify the cause.  When run by hand, the test script displays the
>   expected number of tests, a status for each test, and any error messages from
>   the test script or its helper programs.
>   
> -Please report any failures to the selinux@tycho.nsa.gov mailing list,
> +Please report any failures to the selinux@vger.kernel.org mailing list,
>   including a copy of the test summary output, the raw output from test scripts
>   that failed, a description of your base platform, and the particular release
>   of SELinux that you are using.
> 

