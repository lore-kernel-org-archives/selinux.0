Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804F7C3436F
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B451B24778
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DZyJvsKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfLMSg2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:36:28 -0500
Received: from UHIL19PA36.eemsg.mail.mil ([214.24.21.195]:40314 "EHLO
        UHIL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfLMSg2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 13:36:28 -0500
X-EEMSG-check-017: 57507249|UHIL19PA36_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="57507249"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Dec 2019 18:36:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576262187; x=1607798187;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vRv1ffVnTWnaqpIO5iRkeyWQy5D8zlja3ey2rjaVhbk=;
  b=DZyJvsKL1JJlvdSctTWqYjwmx9yvieTp9jO3iyPg3LWRenhbG2ToLBy7
   kEInyBe6fFI7Oz53J1BBu2okE9x39UmpQAWu+A2PhVIuOgAfsY4eDX+s0
   0ToQeRHUyLe3WoI0xK87Wf1YCw7JyARVLCTzpL0mmalqeKbjkRkjUG5O1
   clHowAnx1t3yBEGaXnEzSEcZqBS8RMiaU4SWS0fdJ/YRYI4Oi/evCPXI4
   DdkFGYLU/pSSWnNG7VOALx64vxdu/KASpp0pjjx38GRdf5GNM4JZDTETx
   ZJfJeRxQb/d2p4n3VhawJHXb6Vy2aGj58BDRQ0ARbuXDdKSVPcvcma012
   w==;
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="31094777"
IronPort-PHdr: =?us-ascii?q?9a23=3AbWil4R3lFCLtkZwDsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesUKv/xwZ3uMQTl6Ol3ixeRBMOHsqkC0ruH+Pm5BSQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngi6oAHVu8UZnIduN6k8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXsxezAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?k/HwHI3AIuHNwAv3rbo9r3KKgcXvu4zLXKwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEcyCwPKkE2QqYz7MDOTy+8Drm2b4PBkVeKrlWEmqxx6rz+0xsgxkY?=
 =?us-ascii?q?nEnZ4Vy1DY+iV5x4Y5P9u4SFVhbtK+H5tQsD+aOpJwT8g/TW9ovyM6xacHuZ?=
 =?us-ascii?q?69ZCUKzJAnxwDaa/CddIiI+B3jWP6eITd5mHJleK+/iA2o/Ue8ze38U8+520?=
 =?us-ascii?q?tJoCpditTAq38A2hPJ5sWHV/dx5Fmt1DmR2wzJ9+1JJ10/m7DBJJ472LEwk4?=
 =?us-ascii?q?IesUHEHiDrhkr7lLSWdkA4+uiw7OTnf6nmqoecN4BqjgH+NbwjmtClDuQiMw?=
 =?us-ascii?q?gOQnOb9f691L3l8035R65KgeMqnaXDrJDbJdgUpq6+AwNP1IYs9w2/ACu83N?=
 =?us-ascii?q?QdnHkHKEpJeBOBj4f3J1HDOO30APiwjli2kDpn2urKMqPuD5nTNHTPja/tfb?=
 =?us-ascii?q?Nn5E5dzAozw8pf55VRCrwZO/L8R1TxucfEDh45LwO0w+HnBM971oMFQ22DGK?=
 =?us-ascii?q?CZMKTMsVOQ/OIgP/GMZJMJuDb6M/Ul5ODhgmEimVABeqmp2pgXZWukEfRmOU?=
 =?us-ascii?q?WZZn/sgtYcEWcPpAY+S/bqiFKaWz5Je3myR7485i08CI++FYfMXJ2tgLia0S?=
 =?us-ascii?q?ejBJJWe2RGBkmJEXfvcIWEQekDZDiOLc9mlzwOTaKhRJM51RGyqA/6zKJqLv?=
 =?us-ascii?q?HK9S0ctJLj0sV15uLImBEs+jx7Ed6d33uOT25qhGMIQSE53KRlrUx60FeD3r?=
 =?us-ascii?q?Byg+ZEGtxL+/NJTgA6OIbez+NkBdDyVBzBc8yGSFahRdWmDjUxQcwrz9ASZE?=
 =?us-ascii?q?Z9Hs2ojgrf0CqyH78Vi7uLCYQz8qLZ2HjxPMB9xGza26Y/lFQmWNVAOnCmhq?=
 =?us-ascii?q?Fl6wjfHZLGk0Kcl6yyb6QTwDbN9HufzWqJpExXTA9wUb3GXXACeETWrdD561?=
 =?us-ascii?q?jNT7+rE7snMw9BxdSeJatNb93jlU9GS+v7ONTCf2KxnH+9CguSybOIa4rqfW?=
 =?us-ascii?q?Qd0T7YCEcenAAT/GqJNQwgCSi7u2LSFiBhFVXqYxCkze4ri362VQcfyAaJJx?=
 =?us-ascii?q?li2reu8RkShtSXS+kU27MZvWEmsToiT3in2NeDMMaNvwpseu1nZNo55FpWnT?=
 =?us-ascii?q?bCuxdVIo2rL6ckgEUXNQtwoRW9hF1MFoxcnJ1y/zsRxw1oJPfdiQkQeg=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2BpAgCI2fNd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?IEYVAEgEoQtiQOGdQaBN4lpkUUJAQEBAQEBAQEBKwwBAYRAAoIzOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshQsGJgyCOykBgnoBBSMVQRALGAICJgICVwYNCAEBgl8/A?=
 =?us-ascii?q?YJSJQ+tSoEyhDoBgRSDM4FCBoEOKIwyeYEHgTgPgl0+gmQChHOCXgSNG4Jbh?=
 =?us-ascii?q?xNGlymCOoI/hGmOVgYbgkKHdpAPlxqUCCKBWCsIAhgIIQ+DKE8RFIMfjWaFF?=
 =?us-ascii?q?IVdIwOPfwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Dec 2019 18:36:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBDIa41e068591;
        Fri, 13 Dec 2019 13:36:04 -0500
Subject: Re: Does anyone use RANDSTRUCT?
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Connor Kuehl <cipkuehl@gmail.com>,
        Dan Aloni <daloni@magicleap.com>
References: <bf727420-b7bd-d3e9-a597-812922ba20a3@tycho.nsa.gov>
 <201912130943.A301DBF@keescook>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7514d477-3a27-0d35-d611-335a103290ec@tycho.nsa.gov>
Date:   Fri, 13 Dec 2019 13:36:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <201912130943.A301DBF@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/13/19 1:05 PM, Kees Cook wrote:
> On Fri, Dec 13, 2019 at 10:40:54AM -0500, Stephen Smalley wrote:
>> See $(subject). If yes, there are some obvious candidates among the SELinux
>> data structures for randomized layouts to avoid fixed locations for
>> enforcing, initialized, etc.  If not, then no point in pursuing it. Doesn't
>> look like Fedora enables it, probably because they'd have to publish the
>> random seeds anyway for third party kernel modules.  But maybe it would be
>> useful for some distros/users?  ChromeOS?  Android?
> 
> It is used by "in-house" kernel builders who optimize for high security
> above all other things (I've talked to a few of them over the years
> when finding out what defenses they've wanted). I've also seen Huawai
> Android patches that seem to indicate they're using it as well, but I
> haven't been able to determine if any released devices are shipping with
> it enabled. I've also had several people ask after the Clang randstruct
> port, which is ongoing[1] by a couple people (added to CC).
> 
> I think it would be very handy to add some more markings to sensitive
> data structures. Please send patches!

Do you know if there is something inhibiting usage in e.g. Pixel 
devices?  Performance impact?

> 
> -Kees
> 
> [1]	https://reviews.llvm.org/D59254
> 	https://github.com/da-x/llvm-project/commits/clang-r365631c-randstruct
> 	https://github.com/da-x/linux/commits/android-4.19-randstruct
> 	https://github.com/connorkuehl/llvm-project/commits/randstruct
> 	https://github.com/connorkuehl/llvm-project/pull/21
> 

