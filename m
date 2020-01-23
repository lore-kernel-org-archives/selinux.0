Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A33C2D0DB
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 18:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A786921569
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 18:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="X2cOoJdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAWSdH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:33:07 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:58064 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgAWSdH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 13:33:07 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jan 2020 13:33:06 EST
X-EEMSG-check-017: 47891719|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,354,1574121600"; 
   d="scan'208";a="47891719"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Jan 2020 18:25:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579803954; x=1611339954;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=zfyweS8K5F6JbuJTeBZY9HtItjN3Qa3Pz2CwHb+5IfQ=;
  b=X2cOoJdMihGKC0otCd509LUP6vX5kd295l23yNHnWNMJiPCb5PqxbpFa
   R+GOwmSM4cqArJYE1rkwT6a2Z4ezhZ9WqOmOO9RsUt4U0hwSLicgpfDR8
   WmmgcdSxrx5xTjR1IzJZ4FP0NK7XnMMhed+FGM9bNLygchvMwda3+leNB
   rHiaGX9YKLKze4W+CCyp0Yx4CqbbDE/d2DDwTsWXmv453YRnarcMYbVRA
   lwjO9dDUJtunlekfajVErWSGxa+fHgu4ylfMWYv/by1JhyKL1gXNFYuTg
   tkf5IKhAd5Ls4ZxNrVtUn79T33YulqIeXh7ARTQWIhgi7dotXHS9xYsfM
   g==;
X-IronPort-AV: E=Sophos;i="5.70,354,1574121600"; 
   d="scan'208";a="38171849"
IronPort-PHdr: =?us-ascii?q?9a23=3A6BxslxwjCKZR2OvXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2ukSIJqq85mqBkHD//Il1AaPAdyHragewLWN++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMn4duNKk9xx?=
 =?us-ascii?q?nHr3BVf+ha2X5kKUickhrh6Mq85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2?=
 =?us-ascii?q?VfQslRVjRBAoKiYIsJE+oBJvtTo43kq1cTsReyGQygCeXhxT9Sgn/9wLM03e?=
 =?us-ascii?q?IvHwrb2AAsBtwDvXDRoNjzKawcU/26zLPQwDvecf1W1zfz5ovGfB8vrv6DX6?=
 =?us-ascii?q?5/f8XKxEkzFQ7IlEmcpZDrMj6X0OkGrmiV7/BnVeKqk2MnqQ9wrSS1ycc2lo?=
 =?us-ascii?q?nFmJ8ex1fG9SR33Ik6P8e4SFJlbdO/DJtRtz2VN4txQs84RWFoozw1xqcJuZ?=
 =?us-ascii?q?68YigH0ZIqzAPcZfyfa4WE/x3uWemLLTp4mX5pYqyzihms/US61+HxUNS/3k?=
 =?us-ascii?q?xQoSpfiNbMs2gA1xnU6seaVPRw5lyh2TOT1wDL7eFEPFw0mbLbK5E/xr4wkY?=
 =?us-ascii?q?IesVjZES/smUX2kbSWel8l+uiu5eTnZa7mqYGAOINulgH/Mrghmsy4AegiNA?=
 =?us-ascii?q?gBQ3Ob9vim2L3m/E35RK1GjvwwkqbHrJDXPdkXq6G2DgNP0osv9gyzAymp3d?=
 =?us-ascii?q?gGh3ULMUpJeBedgIjoP1HOLur4DfC6g1m0kjdqyezJMaf7ApXRMHTOi6vhfL?=
 =?us-ascii?q?Zh5E5czwo/19Zf54lOBb0bL/LzXVHxuMTCDhAlKwy03/rnCNJl24MZXGKPBb?=
 =?us-ascii?q?SZMKXIvlCU+O0iOPOMa5EItzb9Mfcl++TigmM+mV8YZaOpx4cYaGikHvR6JE?=
 =?us-ascii?q?WUeWHsjckFEWcLuAo+UePrhUacUT5ceXmyRbgw5jIlB4K8C4fMWIStjKaG3C?=
 =?us-ascii?q?ehEZ0FLlxBX3eKHW3ldc2hXOwKYSmfIYc1lTkDTr6oQIIJzxyitAbmjbFgK7?=
 =?us-ascii?q?yQsjYVsZPlychd+eLej1cx+CZyAsDb1HuCHE9umWZdRSA91bpj+wQpyEiI2L?=
 =?us-ascii?q?Jk2dREBNdT4LVPSQ58OpnCmb8pQ+vuUx7MK4/aAG2tRc+rVHRoFYM8?=
X-IPAS-Result: =?us-ascii?q?A2B3AwDM4yle/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBKJA4gymzgJAQEBAQEBAQEBNwEBghOCLQKCQjgTAhABAQEEAQEBA?=
 =?us-ascii?q?QEFAwEBbIVDgjspAYJ6AQUjFVELCQUKAgImAgJXBgEMBgIBAYJjP4J8rQqBM?=
 =?us-ascii?q?oVKgzCBPoEOKo1xQIE4D4JdPoQSg0eCPCIEgT8Bi3iJfEaXWgaCPZYuBhuad?=
 =?us-ascii?q?45enRkigVgrCkGBaIFOUBgNiDmOLCMDMIsBgkMBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 23 Jan 2020 18:25:47 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00NIP3ou184476;
        Thu, 23 Jan 2020 13:25:03 -0500
Subject: Re: [Non-DoD Source] [PATCH userspace v2 4/4] Makefile: always build
 with -fno-common
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200123125716.12662-1-omosnace@redhat.com>
 <20200123125716.12662-5-omosnace@redhat.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <fb745330-9f6d-b4e4-93de-c7be8a3991bd@tycho.nsa.gov>
Date:   Thu, 23 Jan 2020 13:26:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200123125716.12662-5-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/23/20 7:57 AM, Ondrej Mosnacek wrote:
> GCC 10 has it enabled by default and everything now builds OK with it,
> so add it to CFLAGS to avoid breaking the build in the future.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

For all four patches,

Acked-by: James Carter <jwcart2@tycho.nsa.gov>

> ---
>   Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index c238dbc8..298cd2b7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -16,7 +16,8 @@ else
>   		-Wstrict-prototypes \
>   		-Wundef \
>   		-Wunused \
> -		-Wwrite-strings
> +		-Wwrite-strings \
> +		-fno-common
>   endif
>   
>   ifneq ($(DESTDIR),)
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
