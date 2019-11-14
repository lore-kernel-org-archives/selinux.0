Return-Path: <SRS0=pcBM=ZG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5781CC432C3
	for <selinux@archiver.kernel.org>; Thu, 14 Nov 2019 15:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247BA206D6
	for <selinux@archiver.kernel.org>; Thu, 14 Nov 2019 15:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="iRWhkuMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfKNPcF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:32:05 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:53548 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfKNPcF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Nov 2019 10:32:05 -0500
X-EEMSG-check-017: 26914313|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,304,1569283200"; 
   d="scan'208";a="26914313"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Nov 2019 15:31:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573745503; x=1605281503;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=8r8qsgPHbgcmDbySKL6BgWd4ahqw+KJVRW667y2G+/w=;
  b=iRWhkuMsnBwlAId+jhrZc2mfhjgK0x6bIDC1EIx4t3MFkaoly7SVCqT6
   Y/gTno1ZItscSbUiwgzU2G9SdGukv+W2r1YYyGTpblMIpY13x098EeCzY
   wde/Fy8uNSJL6iaSRatQcmhkyJ1olidRkixl8nAVmSAP0Y8YGF28TwZuy
   SJ1Yg2tfCUS89qZuDSbrKs+tZlvHhPaWqFf7rIsLEAvYfmXnY/3i3a4oh
   gGIQ6Yvt8uj+3JqpUfakobv+pE+ZzNOvYlfDLmNEuezeQnIPoF4dI8tx9
   hnyEqd8fgzhj2D5WG6nXF4KSDu0CZdVTA2vkmyPDlBQtqfjnqRZmVW1xE
   w==;
X-IronPort-AV: E=Sophos;i="5.68,304,1569283200"; 
   d="scan'208";a="35518599"
IronPort-PHdr: =?us-ascii?q?9a23=3AsP3eLh3/egKeu846smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMULvad9pjvdHbS+e9qxAeQG9mCsLQd0LGd7P2ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBi4owjducsbjIt/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXwqV8DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbN54gzaIwlp?=
 =?us-ascii?q?oUq0jDGDP5mF7qg6OMc0Uk++yo5/zmYrXguJCcK5d5hhzxP6khgMCyAfk0Ph?=
 =?us-ascii?q?IQU2WU5+iwzqDv8VX8QLpQj/02lqfZsIrdJcQevqO5GBJa0p045hajDzapzN?=
 =?us-ascii?q?QYnX4dIFJDYxKIlZLlO17JIPDmFfu/mUijkC93x/DaOb3sGo/NLnnfn7fhZ7?=
 =?us-ascii?q?l98VNTxxIvwt9H55JbELABIPTtVU/qr9HXFQM5Mw2yw+b7Ftp9zIUeVnyTAq?=
 =?us-ascii?q?ODLKzStlqI7Po1I+aQfI8VpCr9K/896v71k3A5nV4dfa+03ZoYc324APtmLF?=
 =?us-ascii?q?uDYXb2gdcOD30KvgwgQ+zuklGCViRTZ3nhF547sws6A4KvF4uLZomshrGalH?=
 =?us-ascii?q?OhH5ZWb3pKPVu7EX7pcYifc/0QaSSOL9VnnyBCXr+kHctpzhyqtQnn25J5Ie?=
 =?us-ascii?q?fOvC4Vr5Tu0J5y/eKAuws18GlPE8mF02yLB1pxl2cMSi5+iLtzumRh21yD1u?=
 =?us-ascii?q?5+mPUeGttNsaAaGjwmPILRmrQpQ+v5XRjMK5LQEwer?=
X-IPAS-Result: =?us-ascii?q?A2BaAgCccc1d/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0LIFBMiqEKY8KVAaBNn+IZ5FDCQEBAQEBAQEBATQBAgEBhEACgiAkO?=
 =?us-ascii?q?BMCDgEBAQQBAQEBAQUDAQFshUOCOykBgm0BBSMVUQsYAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJfP4JHAwklsluBMoVOg0OBSIEOKIwVGHiBB4ERJ4I2NT6CG4U6gl4EllZFl?=
 =?us-ascii?q?wOCNII2kxAGG5oEjkeWH4V2IoFYKwgCGAghD4MnUBEUkSYXjkEjAzCBBQEBk?=
 =?us-ascii?q?REBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Nov 2019 15:31:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAEFVZL8009328;
        Thu, 14 Nov 2019 10:31:36 -0500
Subject: Re: [PATCH] selinux-testsuite: Add kernel module tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191113161454.4370-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <88c4e98b-47e6-8d3b-7f70-c6c48871cf44@tycho.nsa.gov>
Date:   Thu, 14 Nov 2019 10:31:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191113161454.4370-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/19 11:14 AM, Richard Haines wrote:
> Test kernel module loading permissions.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
<snip>
> diff --git a/tests/module_load/setestsuite_module.c b/tests/module_load/setestsuite_module.c
> new file mode 100644
> index 0000000..1f6be02
> --- /dev/null
> +++ b/tests/module_load/setestsuite_module.c
> @@ -0,0 +1,22 @@
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +
> +static int __init setestsuite_module_init(void)
> +{
> +	int result = 0;
> +
> +	pr_info("INIT - setestsuite_module\n");
> +	result = request_module_nowait("dummy-module");
> +	pr_info("request_module() returned: %d\n", result);
> +	return result;
> +}
> +
> +static void __exit setestsuite_module_exit(void)
> +{
> +	pr_info("EXIT - setestsuite_module\n");
> +}
> +
> +module_init(setestsuite_module_init);
> +module_exit(setestsuite_module_exit);
> +MODULE_LICENSE("GPL");

Hmm...with this approach, we can't distinguish a permission denial on 
the module_load versus one on the module_request, right?  Would it be 
better to have a separate no-op kernel module that always returns 0 for 
testing module_load and only use this one for testing module_request?
