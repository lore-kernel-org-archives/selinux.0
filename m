Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C92DC43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 14:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2705F206B7
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 14:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DqSWTQYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfLPOVf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:21:35 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:31762 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfLPOVf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 09:21:35 -0500
X-EEMSG-check-017: 36020680|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="36020680"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Dec 2019 14:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576506091; x=1608042091;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tjvs7x0IgiCdjt5cEAWoHOoU3fkGUxU+N30apkYEc9s=;
  b=DqSWTQYDncbp4ndaF9INeW3mUoVfawagzsuprM0KL8G60kZWSBGmyp1g
   2lhXXdw4EWVgNlLoMy+6fygjsFVogxDxVmZXKBQ3UxzeJWhXUVMzFVceX
   4/GeTRUue3y/smDOeI8bk063MbkWXXFsTStwq/N+iEAIP5NayO16m8K/m
   OfUSAM3CfgaHWbpoIQMmwwHSspX1mzcsCX94pv6hYzmZk2x8CEFNMWDW8
   h+S7i3Nc2x3/33CkYlD+6NFJ9GzA8HKXz+EznmeF2WVRYrYWiE6qEcQ7A
   a944U+LpVMiZEqC1AuDK3fXzoCAQXO6q6JEWvxug5dfy/QQuVKoc2D/hV
   g==;
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="31133508"
IronPort-PHdr: =?us-ascii?q?9a23=3AXl6eTxPAbC0Iga89a5Ml6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z8p8bcNUDSrc9gkEXOFd2Cra4d0KyM6/2rBzVIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+ooQnNtsQajopvJrsswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwIOSQ58GXKgcJuiqxVrg+qqxhmz4PaZIyZMfxzdb7fc9wHX2?=
 =?us-ascii?q?pMRttfWTJPAo28bIUBAeQOMulaoIbhqFUDtge+CAu2Ce/z1jNFiH370Ksn2O?=
 =?us-ascii?q?ohCwHG2wkgEsoTvnTIstr1LKcSXv6zzKLV0DvDaulZ2TP56IfWchEqvPaBXa?=
 =?us-ascii?q?ltfsrK0kQvCwPEgUmQqYziJT+V0P8NvHKB4+pvUuKvlXcqpgdsqTahwccsj5?=
 =?us-ascii?q?PGhoMTyl3c+iV5xps1Kce/SE5hbt6pFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIUEylarVLJ4h2aA/mY?=
 =?us-ascii?q?YJvUTfHi75hEX2jKiMekUi5ueo8Pjobq/jpp+dM494kgD+MqIwlcyjGek0Lw?=
 =?us-ascii?q?cDUmeB9em8ybHv51P1TbpUgvEsj6XVqJXaKt4apq69DQ9VyIEj6xOnAje9zd?=
 =?us-ascii?q?sYhmIKLE5FeR2bj4jpPEvCIPbjDfilmVisnzBrx+7eMr37HprNNmTDkKvmfb?=
 =?us-ascii?q?tl9kFT0gwzwMtc551KELEBJuz8WkvwtNzdFBM2Lwu0w+P/AtVnyoweQX6PAr?=
 =?us-ascii?q?OeMK7KqV+H/P8vI+2XaY8Nojn9Nvwl6+frjX8+nl8dZ7em0YELZ3C/G/RsO1?=
 =?us-ascii?q?+Zbmb0gtcdDWcKuRIzTPf0h12GUD5TYWuyXq0n6zElB4KpE53DSpqugLOfxi?=
 =?us-ascii?q?e7GINZZmRcBlCLC3foeJ2OW+0QZyKKPs9hjjsEWKCiS4A/yx6urxP1y71gLu?=
 =?us-ascii?q?rX4SAXqZLj1MJy5+3WlBEy6Dl0A96a02GXQGF+hnkISCMu3KBjvUx9zU+O0a?=
 =?us-ascii?q?99g/xfDtxT4elGXRskOpPH1ex1Fc39WgLbcdeVUlqpXtKmATQpRNIr39AOe1?=
 =?us-ascii?q?p9G8mljh3b3SqlHbEVl7KVBJEv/aLc2H/xJ8l5y3nYzqUuk14mQs4cfVGh04?=
 =?us-ascii?q?J28UD6A4nPkg3Nm6+sXacRxijA8GaGi2GJuRcLfhR3VPD+QX0HZkbQ5e/870?=
 =?us-ascii?q?fGQq7mXa8rKSNd2MWCLe1McdSvglJYEqSwcO/Can68zj/jTS2DwamBOc+xKm?=
 =?us-ascii?q?g=3D?=
X-IPAS-Result: =?us-ascii?q?A2BWAADmkfdd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBGFQBIBIqhASJA4ZxAQQGgTeJapFFCQEBAQEBAQEBASsMA?=
 =?us-ascii?q?QGEQAKCODgTAhABAQEEAQEBAQEFAwEBbIU3DII7KYJ6AQEBAQIBIxVBEAsYA?=
 =?us-ascii?q?gImAgJXBg0IAQGCXz8BglIFIA+tFnWBMoVPgz+BQgaBDiiMMnmBB4E4D4JdP?=
 =?us-ascii?q?oJkBBqEV4JeBJcJRpcrgj6CP4RqhTWJIQYbmkiXG5QLIoFYKwgCGAghD4MoT?=
 =?us-ascii?q?xEUlhmFXSMDMAGQJQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Dec 2019 14:21:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBGEL8sH153114;
        Mon, 16 Dec 2019 09:21:09 -0500
Subject: Re: [RFC PATCH] selinux: randomize layout of key structures
To:     Dan Aloni <dan@kernelim.com>
Cc:     paul@paul-moore.com, selinux@vger.kernel.org,
        keescook@chromium.org, omosnace@redhat.com, jeffv@google.com
References: <20191213202838.7323-1-sds@tycho.nsa.gov>
 <20191214185002.GA8076@gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e25e8aec-f3a2-1b35-ee6c-e2c9344db885@tycho.nsa.gov>
Date:   Mon, 16 Dec 2019 09:22:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191214185002.GA8076@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/14/19 1:50 PM, Dan Aloni wrote:
> On Fri, Dec 13, 2019 at 03:28:38PM -0500, Stephen Smalley wrote:
>> I would have expected that two kernels built with the same config
>> with this enabled would have yielded different struct layouts in
>> pahole vmlinux output, but that doesn't appear to be the case. They
>> do have different seeds.  Am I doing something wrong?
>> Also, does DEBUG_INFO_BTF effectively undermine/negate the benefits of this
>> change if enabled?
> 
> There's currently a long-standing bug with the GCC plugin where the
> generated debug info is in declaration order, not build order (see:
> [1]).  So, to verify it, try looking at the generated machine code.

Thanks for that clarification; I can see in the code that the struct 
layout has changed between the two kernel builds.

> 
> Planned Clang implementation of this feature does not have this bug.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?format=multiple&id=84052


