Return-Path: <SRS0=4X/7=3D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027AFC33CB1
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 14:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD23724679
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 14:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="RvCUtqDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgANOAH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:00:07 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:7645 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbgANOAG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jan 2020 09:00:06 -0500
X-EEMSG-check-017: 45361553|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,433,1571702400"; 
   d="scan'208";a="45361553"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Jan 2020 14:00:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579010403; x=1610546403;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=2CqJIBnDEPW4gcpZNN3oyG4u4e5ji37lsl2ri48NTFo=;
  b=RvCUtqDyE6CCPojbFbyxx3uXvV8ouS6/RpK0uLpuktdnSaBvxxCNjDXI
   DSM4jSAcvW8JeTPQiB72cWCcL/CwwLjQ21Cwj6DeQ3iOfh3Xv63+fAhf+
   ZwoJ+TDxEJJvHgm1TKNNBaHQBORA96zaGOGw+rIFXhTCGm6/+QFy1F1F9
   VjA+t3GH0YC9i04sE0U5fRLkzV594mxeNF2rK9eC4I7wo33fOSLQ4mFxF
   mhv7TFbBLgDagGT1Uw5hpYeYxRDvkcJBGQDuRlrKAtyzHQ41V+8+o+XHw
   S4BaM7Ke5uArPyVuPlBuGPwceO+AgDsN6hpLADttel/CRp8ep8GPyu2em
   w==;
X-IronPort-AV: E=Sophos;i="5.69,433,1571702400"; 
   d="scan'208";a="37742190"
IronPort-PHdr: =?us-ascii?q?9a23=3ALh6OXhPmbUswPqXEIf4l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/v4rarrMEGX3/hxlliBBdydt6sYzbKO+Pu/ESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4Nqo91h?=
 =?us-ascii?q?TFr3VKdu9LwW9kOU+fkwzz68ut8pNv6Thct+4k+8VdTaj0YqM0QKBCAj87KW?=
 =?us-ascii?q?41/srrtRfCTQuL+HQRV3gdnwRLDQbY8hz0R4/9vSTmuOVz3imaJtD2QqsvWT?=
 =?us-ascii?q?u+9adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYMgXTn?=
 =?us-ascii?q?RdUMlPSyNBA5u8b4oRAOoHIeZYtJT2q18XoRejGQWgGObjxzlGiX/s2a0xzv?=
 =?us-ascii?q?ovHwfI0gc9G94CqXTZodHwOKoUTOu7zrTHzS/bYv1L2Tnz9obIfBMvr/6CUr?=
 =?us-ascii?q?1/c9bex0Y0GgPZjVids5DpMy+b2+kPtWWQ8upuVfioi24iswx/vySvydk0io?=
 =?us-ascii?q?nJmI0VzE3P+zh8wIkvId24TFB0YN65G5ZXrCGVKpB2T9g+Q2BopCk6yroGtY?=
 =?us-ascii?q?S9fCgR0psr3RHfa/uZc4WR5B/oSeWfIS9giX54d7+yiAy+/Ei9xuHmSMW530?=
 =?us-ascii?q?hGojBYntTKq3sDzQbc6tKdRft45kqh3DGP2B3N5excOkA0kLbbK4Ymwr4tip?=
 =?us-ascii?q?ofqUTDETHymEXxlKKWal8r+vKp6+T6ebXqvJ6cN4l6igH5KaQhhNCwDf4kMg?=
 =?us-ascii?q?kOQ2eb+eO82Kfl/ULlW7VFkuc6kqzYsJDePcgbp6i5DBFJ0os79hqyADir3M?=
 =?us-ascii?q?4YkHUaNl5JZh2Kg5bzN13TOPz4CO2wg1WokDdl3fDGObjhD43WLnfei7fsZq?=
 =?us-ascii?q?p96k5AxwozytBT/ZRUCqobL/7pVU/xs8LYAgcjMwOo2+bnFMl91oQGVGKVA6?=
 =?us-ascii?q?+WLKPSvkWS5u0yO+aDeJcauDbnJPgk4f7hk2Q5lEQGcqm13JsXbmy4Eep8I0?=
 =?us-ascii?q?Wff3Xsns0NHnsNvgo7VObqkkGNUSZPZ3auWKIx/io7B5yiDYfCQICtnbOA0T?=
 =?us-ascii?q?ylHp1ZeG9GEEqAEXT2eIWeXfcDdiaSLtVmkjweWrjyA7MmgCuvvw/z0bYvDu?=
 =?us-ascii?q?PV/CAD/cb51dN17vffohoF9TV1CcmG+2uRTmdok3kOSiNw16d69wg10VqH0K?=
 =?us-ascii?q?5lk9RGGtFJofBESAE3Mdjb1eMpJcr1X1f6YtqRSFugCu6jCDU1Q8N5l8QCeG?=
 =?us-ascii?q?5hCt6iiVbFxCPsDLgLwe/YTKco+77RiiCib/12zGzLgex40ggr?=
X-IPAS-Result: =?us-ascii?q?A2BDAwCGyB1e/wHyM5BfBhwBAQEBAQcBAREBBAQBAYF7g?=
 =?us-ascii?q?X2BbSAShDeJA4ZtBoE3iW6RSQkBAQEBAQEBAQE3AQGEQAKCITgTAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIVDgjspAYJ6AQUjDwEFUQkCGAICJgICVwYBDAgBAYJjP4JXJ?=
 =?us-ascii?q?Y96m3SBMokcgT2BDiiMM3mBB4E4D4IoNT6EO4MegjwiBJZFgSeXUoJCgkmTX?=
 =?us-ascii?q?gYbmm2OW50IIoFYKwgCGAghD4MoTxgNiA0XjkEjA41RAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Jan 2020 13:59:49 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00EDxAiu149914;
        Tue, 14 Jan 2020 08:59:10 -0500
Subject: Re: [PATCH V4 0/1] selinux-testsuite: Add filesystem tests
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200114122804.321628-1-richard_c_haines@btinternet.com>
 <f483648a-7687-8388-917d-c2520b8f3bd6@tycho.nsa.gov>
 <5302118848ee1846e9c6010e93c163dd40547fd0.camel@btinternet.com>
 <bdf3b824-341a-9b56-9cf6-fa256dd422ef@tycho.nsa.gov>
Message-ID: <c30bdf29-4d51-0e83-33a1-fe3e4c7edcda@tycho.nsa.gov>
Date:   Tue, 14 Jan 2020 09:00:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <bdf3b824-341a-9b56-9cf6-fa256dd422ef@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/14/20 8:46 AM, Stephen Smalley wrote:
> On 1/14/20 8:39 AM, Richard Haines wrote:
>> On Tue, 2020-01-14 at 08:30 -0500, Stephen Smalley wrote:
>>> On 1/14/20 7:28 AM, Richard Haines wrote:
>>>> These tests should cover all the areas in selinux/hooks.c that
>>>> touch
>>>> the 'filesystem' class. Each hooks.c function is listed in the
>>>> 'test'
>>>> script as there are some permissions that are checked in multiple
>>>> places.
>>>>
>>>> Tested on Fedora 31 and Rawhide (5.5 for the new watch perm).
>>>>
>>>> V4 Changes:
>>>> 1) Test non-name based type transition rule.
>>>> 2) Test two different name-based type transition rules that only
>>>> differ
>>>>      in name.
>>>
>>> Sorry, I guess my wording was confusing.  What I meant was that the
>>> inputs to the two name-based type transition rules were identical
>>> except
>>> for the name, but you would want them to have different
>>> output/result
>>> types so that you can tell whether it actually distinguished them.
>>
>> So would this be ok as policy rules:
>>
>> type_transition test_filesystem_t test_filesystem_t:file
>> test_filesystem_filenametranscon1_t "name_trans_test_file1";
>> type_transition test_filesystem_t test_filesystem_t:file
>> test_filesystem_filenametranscon2_t "name_trans_test_file2";
> 
> Yes.  It looks a little odd in that usually the source context is a 
> process context and the target context is a parent directory context so 
> it is unusual that they'd be the same in any real-world policy 
> (generally that would only happen for /proc/pid and you can't create 
> files there).  But I guess that's a side effect of the way the other 
> tests work / using context mounts?

That's fine btw - no need to change it just noting it.

