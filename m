Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BECEC33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB8A214AF
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 15:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="hop9NlML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgBFPsn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:48:43 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:19144 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBFPsn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 10:48:43 -0500
X-EEMSG-check-017: 55815733|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="55815733"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 15:48:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581004121; x=1612540121;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=3CBBJjVv81Y8DfZxCm0Vf3FzVn/2MUkLXjGyrW6zlog=;
  b=hop9NlMLsuy3pk8/Hswzbz4rxWXHyUN3UGYynEcurZSUq6hMDgnn/sFx
   I27hugWAIc8o8W5urIPotnwgh3jjowFxeQs5VI6z6J4i6tZHV3gaSuwsN
   XEHAXEoq7NpElexMf9AdXEp5BgEtAIg71lgJV2VROsIHNF2VZsAXAkqjD
   5clxq3rOZVsvc3zpBke2KMHQ1K07l2RkF9NJhiQOhhpE5Hp6hFpSEeaHP
   dwZeogMFUdep9s8O7r2MqGMQmjYBqsDS5qt5tT3U8w/JzvZIw3WjkwjE0
   r6urY3YXkd+408YUYH3ZslrZabU3ATTzJUclpnuaizaStyyCT5KG4mXfB
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="32764356"
IronPort-PHdr: =?us-ascii?q?9a23=3A+ndKFBc4tElZ9BsyVmyE7fD3lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW9Zx7h7PlgxGXEQZ/co6odzbaP7+a9Aidfvt7B6ClELMUXEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/Jas90B?=
 =?us-ascii?q?vEr3VHd+lUx25jOFafkwrh6suq85Nv7ipdt+g9+8JcVKnxYrg1Q6FfADk6KW?=
 =?us-ascii?q?4++dfltQPETQuB53scVnsZnx9VCAXb7x/0Q4n8vDLiuuVyxCeVM8v2TaspWT?=
 =?us-ascii?q?u59KdkVAXoiCYcODEn9mzcl9F9g7haoBKloBx/3pLUbYSIP/dwYq/RYdUXTn?=
 =?us-ascii?q?daU81PSyJOHJ+zb4oXD+oAI+lYqZX9p0ATphe6HAWgGf/jxiNNinLw06I6ye?=
 =?us-ascii?q?AhGhzY0gImEdwFrXDYoMz7OaoWVOy4yrTDwzfeYPNMwTrz9YjGfA4vof+PU7?=
 =?us-ascii?q?x/f8XexkszGA3KlViQtY7oMimJ2ugRvWWW7extXv+vhW49rAFxpyCiyNowio?=
 =?us-ascii?q?bXnoIVyk7L9SNky4goIN23Ukp7Ydq6H5pQqiqXMJB2Td45Q2xzpCY7yqEJuZ?=
 =?us-ascii?q?68fCQQzpQn3ATQZ+aIc4iP/BLuTeCcKip7inJ9YL+zmhm//Ee6xuD8S8W4yk?=
 =?us-ascii?q?hGoyVbntXWq3wA0QHY5NKdRftn5Eih3C6C1wXU6u5ZP085jbHbK5s9wr4okZ?=
 =?us-ascii?q?oTrFjDEjf2mEroiK+WcV0p+vSy5OT9Y7Xmu4ScO5V1igH4PKQunde/DvokPQ?=
 =?us-ascii?q?QUQ2ia+fiz1L3k/UHjRrVFkuY2nbXDvJDfJMQbora1Aw5T0ok99xayFyqq3d?=
 =?us-ascii?q?sXkHUdLF9JZQiLg5bmNl3QOvz0EO+zg1G2nzdqw/DGMKfhApLILnXbi7fuYK?=
 =?us-ascii?q?195lVAyAsz0d9f55VUBqsHIPLoQED9rtPYDhgnMwCs2eboFM191p8CWWKIGq?=
 =?us-ascii?q?KZKqLSvkOI5u01OemDeZcatyrlJPgl/fHujHk5lkEGfaSyxpQXdHG4HvJ6I0?=
 =?us-ascii?q?qHe3rshMkOEXsQsgUiS+zqjUWIUSRPaHaqQ6I8+jY7BZq9DYjdQoCtgbqB3D?=
 =?us-ascii?q?q0H5BNeGBGBU6DEW3ye4WHRfgMciSSLdFlkjAeUrihUYAhhlmSs1rAyrFnJ/?=
 =?us-ascii?q?DYsg0RtJTuz5Ah/ezYlRgo+Qt/OMSU0meAVEl+gmIOWzIs2q1j50d6zwHHmb?=
 =?us-ascii?q?N1h/1eCMx7+fxESEE5OITawug8DMr9CSzbedLcc0qrWtWrB3kKS9s1x9IfKx?=
 =?us-ascii?q?JmF86KkgHI3y3sBaQc0bOMGspnoernw3HtKpMlmD793647ggxjG5AeOA=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2DAAgBnNDxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsIRIqhBWJA4ZkAQEBBoE3iXCRSwkBAQEBAQEBAQE3AQGEQAKCYTgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYMCAQUjFVELGAICJgICVwYBDAYCAQGCYz+CS?=
 =?us-ascii?q?wMJJawxgTKJM4E+gQ4qjD15gQeBOA+CXT6CG4VAgl4Elz5GiDGPNoJEgk6Tc?=
 =?us-ascii?q?gYbgjiYUy2ONZ00IoFYKwgCGAghD4MnUBgNnQEjAzCOSgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Feb 2020 15:48:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016Flm72111705;
        Thu, 6 Feb 2020 10:47:48 -0500
Subject: Re: [PATCH 1/1] selinux-testsuite: Add watch_sb and watch_mount
 checks
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200130190732.110012-1-richard_c_haines@btinternet.com>
 <20200130190732.110012-2-richard_c_haines@btinternet.com>
 <19defad5-2e33-8da5-ad91-c8bd4042f11b@tycho.nsa.gov>
Message-ID: <64e281ab-5a3a-913a-1ea4-d5eb0348e92f@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 10:49:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <19defad5-2e33-8da5-ad91-c8bd4042f11b@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/4/20 8:44 AM, Stephen Smalley wrote:
> On 1/30/20 2:07 PM, Richard Haines wrote:
>> Test watch_sb and watch_mount permissions.
>> The policy is contained in test_filesystem_notify.te as it can then be
>> built if the policy supports the permissions.
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> 
> Tested with and without the watch permissions defined in base.cil and 
> all_perms.spt; everything worked as expected.
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
>> ---

Applied.


