Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BACC4CEC4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 12:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCF8205F4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 12:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="C2w6G9Pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfIRMZ3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:25:29 -0400
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:7534 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfIRMZ2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 08:25:28 -0400
X-EEMSG-check-017: 9771036|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="9771036"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 12:25:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568809527; x=1600345527;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Nw6x3GviPfCLVxIjqR9JEDFVMulrvPvy+TfSF3FgmiY=;
  b=C2w6G9PajtIkKjCDpo2UAJFU1qolD9pFhBGzT2c1jX7aoyZtihn2j9Zo
   os9eCzY0gZKgxUhVAekOG+JSqcZ8ZDfk8vrbkmzTo5rWN2ct8hk4gy8sc
   m/7Jc/5Fd4jQoFO45WCg1HHprztcBi1HIfe+wQUrFkSV2En/XRyGDDIO0
   Ancc3eS826sBWu5fqqtc38sziB9oXp7UzQ5B9fglVsPBGKapaxk/c8078
   u8Tpmh72XdtIimXULwrWhwwHAxW7GGRetdOHswbd9Gg/uoSzls1xisyJn
   MmGHRldSITdqnsiFbNKoGmBKaagtd6/f7Y7nGGmCld+NdgeS65b+tYuWY
   w==;
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="28039101"
IronPort-PHdr: =?us-ascii?q?9a23=3AGJqx1R2J0GhHFDWosmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWKvjxwZ3uMQTl6Ol3ixeRBMOHsqkC0rqd7vioGTRZp8rY6jZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8cbjZF/JqsyxR?=
 =?us-ascii?q?fEomdEcPlSyW90OF6fhRnx6tqu8JJ57yhcp/ct/NNcXKvneKg1UaZWByk8PW?=
 =?us-ascii?q?Av483ruxjDTQ+R6XYZT24bjBlGDRXb4R/jRpv+vTf0ueR72CmBIM35Vqs0Vi?=
 =?us-ascii?q?i476dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3?=
 =?us-ascii?q?ZPUdhNWCxAGoO8bpUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izDFHhmXy3aYnze?=
 =?us-ascii?q?ovFw/I1xEkE94XrnjZqND5OaEPWu630abI1y3OYe5I1zfz6IbGcR4vrv+DUr?=
 =?us-ascii?q?1ybcXfxlIiFx/Hg1iKtYDpIz2Y2+YLvmOG7+RgT+Wvi2s/pg9svjig2N8sio?=
 =?us-ascii?q?nXiYIT11vK6CB5z5wxJd28VkF6YcOvHZxLty6HLIt7Wd8iQmF0tyY6zb0Ko5?=
 =?us-ascii?q?i7fDMQx5g9yB7fbOKHfpGO7xn+WuiRJjJ4i2hkeLK5nxuy9UegyvH5VsWuzF?=
 =?us-ascii?q?lKqS9FnsHDtnAMyxzT6tWHReBn8ki93jaP0hjf6vpaLkAxkKrbL4AuzqQsmZ?=
 =?us-ascii?q?oUtETOGDL9lkbujKKOa0kp9eel5/7nb7n7vJOQKYB5hh/kPqgznMG0HP42PR?=
 =?us-ascii?q?IUX2eB/OSxzLjj/UrkT7pUlvA2iazZsIzCJcQcu665HxdZ0oY95Ba7CDeryM?=
 =?us-ascii?q?gYkmMdLFJEZRKHlJLlO03OIf/kDfe/hE6gkDF3yPDdIrLtGJDNLnnHkLv5fL?=
 =?us-ascii?q?Z97VBTyBYrwNxC6J9ZBasNLfLuVkPrqtDVAQE1Pxapz+r/DdVyzIIeWWaBAq?=
 =?us-ascii?q?+DN6PStEeF5vkyLOmXf4IVpDb8JOQl5/7pl3M5n0QdcrOz0ZsYb3C4AOxqI1?=
 =?us-ascii?q?+Fbnr0ntcBDWAKsxI4TOzrlFKCVjpTaGypX64m5zE7D4WmDZzYRo22hbyM0y?=
 =?us-ascii?q?i6EodRZmBcBVCGCW3oeJmcW/cQdCKSJddskicaWrilSo8h0wyutQDhxrp5Ie?=
 =?us-ascii?q?rb5DcYuYjg1Ndr/e3Tkw899ThuA8SayWGNQDI8omRdYT4926R2ugRczVCYyu?=
 =?us-ascii?q?Ashf1TEtha/LVIVQAhLrbZk/w8DMr9DEaJZdqNSVC7Uv24DjwrCNE82dkDZw?=
 =?us-ascii?q?B6AdrxoArE2n+RH7INl7GNTKcx+6bY0mm5c91x0F7axaIhiB8gWcIJOmq40P?=
 =?us-ascii?q?0svzPPDpLExh3K352hcr4RiWuUrjaO?=
X-IPAS-Result: =?us-ascii?q?A2DNAABnIYJd/wHyM5BmHAEBAQQBAQcEAQGBVQUBAQsBg?=
 =?us-ascii?q?W0qbVMyKoQijw9QAQEBBoE2iXSPLYF7CQEBAQEBAQEBAS0HAQIBAYN6RQKDA?=
 =?us-ascii?q?yM2Bw4CDAEBAQQBAQEBAQUDAQFshS0MgjopAYJmAQEBAQIBIxVRCxgCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgl8/AYF2BQ8PsD+BMoVMgy+BSYEMKAGMCBh4gQeBOIJrPoJIG?=
 =?us-ascii?q?QEBAYRrgjYiBJV6ln6CLIIuhFeFEYhnBhuDKJV4GYQmiVCIDpJ8DCWBWCsIA?=
 =?us-ascii?q?hgIIQ+CcwEBMgkJDTEQFIIegyKKbyQDMAEBgQQBAY9uAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Sep 2019 12:25:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8ICPOEq007574;
        Wed, 18 Sep 2019 08:25:24 -0400
Subject: Re: [PATCH] Add configuration file for lgtm.com
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190901181410.357-1-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fe67dcc7-ec04-b3b1-35c9-22c588554c95@tycho.nsa.gov>
Date:   Wed, 18 Sep 2019 08:25:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190901181410.357-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/1/19 2:14 PM, Nicolas Iooss wrote:
> Add a configuration file in order to parse the C code on
> https://lgtm.com/projects/g/SELinuxProject/selinux/
> 
> The documentation about this file is on
> https://help.semmle.com/lgtm-enterprise/user/help/lgtm.yml-configuration-file.html
> and
> https://help.semmle.com/lgtm-enterprise/user/help/cpp-extraction.html
> 
> Fixes: https://github.com/SELinuxProject/selinux/issues/98

Thanks, applied.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> 
> diff --git a/lgtm.yml b/lgtm.yml
> new file mode 100644
> index 000000000000..f80bf1461fb6
> --- /dev/null
> +++ b/lgtm.yml
> @@ -0,0 +1,5 @@
> +extraction:
> +  cpp:
> +    index:
> +      build_command:
> +        - make DESTDIR="$LGTM_WORKSPACE/destdir" install
> 

