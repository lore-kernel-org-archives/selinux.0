Return-Path: <SRS0=fLGi=XV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C273AC4360C
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91804222C2
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="miH/Z2Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfIZMzh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:55:37 -0400
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:51862 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfIZMzg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Sep 2019 08:55:36 -0400
X-EEMSG-check-017: 27744290|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,551,1559520000"; 
   d="scan'208";a="27744290"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2019 12:55:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569502535; x=1601038535;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=y7OdV1jzHe09zo/guEqo5hqoBjhsMAQgYxTXQpKMe18=;
  b=miH/Z2Gop7ILgPl+caS3uWc8Av8PIl4eAJ5MkH1cCgXR/WR1I0NZAXrp
   yEpl24b+5c43nkM+0TGCVk4rR3B97H3CB9fWXMQN9afOi7C+s2Wu7fZC7
   1pc5oSvJsbWmbHqwEnH77oQX9XigNCVGXiSod2fF+nCf5/LGnKqM1crvy
   8RRqNoRX/edonvIDrSuzILuIV/MM3qMXFvwgWhVpSYwLXmqPgy9s7V7q2
   slLV6A3qeOU+j79DxyxtRUaTT1FiNgkpy9KQK7f4erjXRs8ARJBW+ac6G
   EzmM6SOUd7/W9ol93oT4ckciE1EPyfrUDlQF0fsmeha3kO/IU2rACdwLR
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,552,1559520000"; 
   d="scan'208";a="28346159"
IronPort-PHdr: =?us-ascii?q?9a23=3AZp2coRRfmwV4POzj2t9Mw7haOtpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6ybBGN2/xhgRfzUJnB7Loc0qyK6vumAjBLvM3JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/fu8QZjodvKqg8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXoxazAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?k/HwHI3AIuHNwAv3rbo9r3KKgcXvu4zLXKwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEcyCwPKkE2QqYz7MDOTy+8Drm2b4PBkVeKrlWEmqxx6rz+0xsgxkY?=
 =?us-ascii?q?nEnZ4Vy1DY+iV5x4Y5P9u4SFVhbtK+H5tQsD+aOpJwT8g/QG9ooD43xqAJtJ?=
 =?us-ascii?q?O0ZiQHyIkrywTBZ/GIbYSE+A/vWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U?=
 =?us-ascii?q?5RripAjtnMrncN1wHP6sSfSvty4EOh2TGX2gDP8O5EO0E0lbfAK5I73r4xlo?=
 =?us-ascii?q?YcsUTEHiPsnkX5kLSWeVk+9uit6uTnZq3qpp6aN4BqlgHzKrkil8OwDOgiMg?=
 =?us-ascii?q?UCQnKX9fqz2bH950H1Xa1GjvgsnanYtJDaK94bpqm8AwJNyYYs9g2/Aiy60N?=
 =?us-ascii?q?UYgXYHLFVFdAiBj4jyIV7COv/4DfChg1i0ijdk2+jGPqH9ApXKNnXDiLPhcq?=
 =?us-ascii?q?xg605A0go81spQ6olOCr4fPf3zWlX+tMDCAhAlNAy0xv7tCM9h2YMGRWKPHq?=
 =?us-ascii?q?iZPbvJsVCW4uIvIu+MZJIauTvmNfgl6ODhjWUjlV8eY6apx50XZ268Hvh8JE?=
 =?us-ascii?q?WZe3Xs0Z89FjIysxYkBMjjlUGYWzdYZz7mR6Y1+y0hAouOF4rPRomxxreG2X?=
 =?us-ascii?q?H/VoZbYmFAF0CkD3jlbcOHVu0KZSbUJdVuwRIeUr30cJMszRGjskfBzrNjKu?=
 =?us-ascii?q?fFsnkDuYnLyMl+5+qVkwo7szNzEZLOgCm2U2hokzZQFHcN16dlrBk4kwzS3A?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2B+AQCDtIxd/wHyM5BmHAEBAQQBAQwEAQGBVgQBAQsBg?=
 =?us-ascii?q?XMqbVMyKoQijw1NAQEBAQEBBoE2iXWRKAkBAQEBAQEBAQEjEQECAQGEPwKDM?=
 =?us-ascii?q?SM3Bg4CDAEBAQQBAQEBAQUDAQFshS0MgjopAYJnAQUjFVELDgoCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/AYF2FK8NgTKFTIM7gUiBDCgBjAsYeIEHgTiCaz6HT4I2IgSWB?=
 =?us-ascii?q?JcMgiyCLoRXjX8GG4MolgOOG5slIoFYKwgCGAghD4MnCUcQFIslhQokAzCBB?=
 =?us-ascii?q?gEBjXQBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 26 Sep 2019 12:55:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8QCtVEd003915;
        Thu, 26 Sep 2019 08:55:31 -0400
Subject: Re: [PATCH] Switch last 2 files using /usr/bin/env to
 /usr/bin/python3
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20190924194637.248190-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <49c32c3f-7f2b-b210-99a7-9770d7c9b037@tycho.nsa.gov>
Date:   Thu, 26 Sep 2019 08:55:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924194637.248190-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/24/19 3:46 PM, Petr Lautrbach wrote:
> Other python scripts already use python3 by default. Both files don't have exec
> bits so they have to be run using python interpret on command line anyway:
> 
>      $ python3 ./setup.py ...
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.

> ---
>   libsemanage/src/pywrap-test.py | 2 +-
>   python/sepolicy/setup.py       | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libsemanage/src/pywrap-test.py b/libsemanage/src/pywrap-test.py
> index 5ac48f40..f266f700 100644
> --- a/libsemanage/src/pywrap-test.py
> +++ b/libsemanage/src/pywrap-test.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/python3
>   from __future__ import print_function
>   
>   import sys
> diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
> index 4bd8353d..3633c127 100644
> --- a/python/sepolicy/setup.py
> +++ b/python/sepolicy/setup.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/python3
>   
>   # Author: Thomas Liu <tliu@redhat.com>
>   # Author: Dan Walsh <dwalsh@redhat.com>
> 

