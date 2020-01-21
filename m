Return-Path: <SRS0=4+dM=3K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F6EC2D0CE
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 18:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C2F21734
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 18:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OgK90Oy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAUS7V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:59:21 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:39563 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAUS7V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jan 2020 13:59:21 -0500
X-EEMSG-check-017: 48023199|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,346,1574121600"; 
   d="scan'208";a="48023199"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Jan 2020 18:59:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579633158; x=1611169158;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=XsMMGdlfmI8J3BqK/p/KTnj0oB6kjGXHmVHF3Fy8peY=;
  b=OgK90Oy4oSOE8LSeCrBvJa33wDK+XcEQ22CYmHi5X6J6lWzDVuTY/7SQ
   0L8UhnHVQdxaQN0v/i4pSWEUwlbjT5R7PG4k5IvwU2Jn0WSPeF46ID0lh
   LV5qlYfQ3GGeEMDR3LM7MxUJqgAw+KNVlT203VvFuJGuxdbcYc9yzdu+R
   51BYTDVOc+XmyXnHYeNVRrsdbRQ24EyWEflsY2Wjs1WJdPEVbjrCpxFCL
   iKZXWwX8jWjis9yQdauGLn57Usl8XHKsWJbX9Vw93HiuO5iEdw/S9WSBM
   ofjFmA9xyxdXuXngF6czhW6DMbfLe3sWKiYSWf43hxs31WNvsGt/VpWK0
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,346,1574121600"; 
   d="scan'208";a="32166137"
IronPort-PHdr: =?us-ascii?q?9a23=3AGWLADxzDQ8CpgC7XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2uMeIJqq85mqBkHD//Il1AaPAdyHrasUwLOP7eigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam5ZuJ6U+xh?=
 =?us-ascii?q?fUv3dFevldyWd0KV6OhRrx6dq88ZB5/yhMp/4t8tNLXLnncag/UbFWFiktPX?=
 =?us-ascii?q?ov5M3suxnDTA+P6WUZX24LjBdGABXL4Q/jUJvpvST0quRy2C+BPc3rVr80Qi?=
 =?us-ascii?q?it771qSBDzligKMSMy/XzNhcxxiKJbpw+hpwB6zoXJboyZKOZyc6XAdt4BW2?=
 =?us-ascii?q?FPQtheWDBAAoOkbosAEewBPfpDr4Lgo1cCtAayCRWwCO/qzDJHiGX23akn2O?=
 =?us-ascii?q?o/Fw/I0hErE9YXvHjKqNj5MaEfWv23wqbV1zXOd+5Y1zfj5ojGcR4vr/+DUr?=
 =?us-ascii?q?1yfsXNxkciDB/Fg1aKpID5Iz+Y2OYAvm6G5ORgT+KvjGsnphlsrDiz2Mgsko?=
 =?us-ascii?q?nJiZwTylvZ6Ct5xZw6Jdm8SEFlYd+vDZxdtzqHOIttWc4iX2Fptzo6yr0Bo5?=
 =?us-ascii?q?K7ejMKx449yx7QbPyHbZGF7xT+X+ifJjd4gWhqeLO5hxuq/0iv1PDzVs6u0F?=
 =?us-ascii?q?lQrypFlNfMtmoX2BPP7siHTeZ98Vq71TaIzQDT5edJKl03m6rDM5Mt37E9m5?=
 =?us-ascii?q?UJvUnDAyP6glv6gaCIekk+5+Sl7fnsbK/8qZ+GLYB0jxnzMqEpmsOiH+s1Kh?=
 =?us-ascii?q?MOX22H+eSk073j4FH5TK1KjvIolqnZt4jXJdgBqa6jAg9Vz50j5wy+Dzeg3t?=
 =?us-ascii?q?QYmmIHI0xZdx6dk4joO03BIPD/DfulhVSjjCxryOzcMr3kA5XNKmDPkLbnfb?=
 =?us-ascii?q?lj905R0Bc/wN9Q6p5OCrwNPej/VlH+udDGFBM1LhS4w+P9B9V80oMeV3iPAq?=
 =?us-ascii?q?icMK7Kql+H+/kvLvKQZI4VpDn9K/8l6+TojX8ig1ARZ6ap3ZwJaHygBPRpP1?=
 =?us-ascii?q?2ZYWbwgtcGCWoKpg4+Q/b3iF2eSz5cfGy9Urkm5j4lFY2mDZ3MRpy3jLOd2y?=
 =?us-ascii?q?e7G4VcZnpaBVCUDXfoa4KEVu8XaC2MJs9hkzoEVaWuSoI6yxGuuxH1y6B9Iu?=
 =?us-ascii?q?rX5CIYr5Tj28Zx5+HJkhEy7zN0XIyh1DS1Qn1u1kcBWiMs1ql0oQQp0lOKzL?=
 =?us-ascii?q?RiifVwD9Ff5/pVFAw9MMiYh/d3D9H0RxLpYNiEUhClT8+gDDV3Scg+kPEUZE?=
 =?us-ascii?q?MoIMmvlhDO2WKRBrYRk7GaTMgv/rn0w2n6J8E7zW3PkqYmkQ91EYN0KWS6i/?=
 =?us-ascii?q?snpEDoDInTnhDczvz7eA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DVBgCqSCde/wHyM5BlHQEBAQkBEQUFAYF7AoF7gRhVI?=
 =?us-ascii?q?BIqhBKJA4ZnAQEBBoESJYluj2KBZwkBAQEBAQEBAQEtCgEBhEACgjY4EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFNwxCFgGBYikBgnoBBSMPAQVRCw4KAgImAgJXBgEMB?=
 =?us-ascii?q?gIBAYJjPwGCViUPrxWBMoh4gTgGgQ4qAYwteYEHgTgMA4IoNT6EAi+DKIJeB?=
 =?us-ascii?q?Jd4l1qCQ4JJhHSObgYbmnctjjGIYZQ2IoFYKwgCGAghDzuCOAEBMlAYDZEIh?=
 =?us-ascii?q?V0jAzACijiDUwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 21 Jan 2020 18:59:17 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00LIwasO151657;
        Tue, 21 Jan 2020 13:58:36 -0500
Subject: Re: [PATCH] libselinux: remove flask.h and av_permissions.h
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20200115155523.69438-1-sds@tycho.nsa.gov>
 <pjdh80vqivt.fsf@redhat.com> <pjdd0biq95r.fsf@redhat.com>
 <5d7eb243-1dbe-9c54-9cf6-b3e7cdfba7c7@tycho.nsa.gov>
Message-ID: <3bf86683-05fd-e7fe-8808-5336b49b5932@tycho.nsa.gov>
Date:   Tue, 21 Jan 2020 14:00:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <5d7eb243-1dbe-9c54-9cf6-b3e7cdfba7c7@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/20 1:24 PM, Stephen Smalley wrote:
> On 1/17/20 12:34 PM, Petr Lautrbach wrote:
>>
>> Petr Lautrbach <plautrba@redhat.com> writes:
>>
>>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>>
>>>> The flask.h and av_permissions.h header files were deprecated and
>>>> all selinux userspace references to them were removed in
>>>> commit 76913d8adb61b5 ("Deprecate use of flask.h and 
>>>> av_permissions.h.")
>>>> back in 2014 and included in the 20150202 / 2.4 release.
>>>> All userspace object managers should have been updated
>>>> to use the dynamic class/perm mapping support since that time.
>>>> Remove these headers finally to ensure that no users remain and
>>>> that no future uses are ever introduced.
>>>
>>> I've patched libselinux and I'm building all packages which requires
>>> libselinux-devel [1] in Fedora. I'm in the middle of package list and 
>>> so far there
>>> are only 3 packages which fails to build without flask.h or
>>> av_permission.h - libuser (the particular file wasn't updated since
>>> 2012), ipsec-tools and mesa. When it's finished I'll investigate all
>>> results, but I don't think there will be some blocker.
>>>
>>> [1] 
>>> https://copr.fedorainfracloud.org/coprs/plautrba/libselinux-without-flask.h/builds/ 
>>>
>>>
>>
>> So the complete list of Fedora packages dependent on selinux/flask.h is:
>>
>> xinetd
>> usermode
>> sed
>> pam
>> oddjob
>> libuser
>> ipsec-tools
>>
>> Problems are usually in tests or in Fedora specific patches. I'll start
>> to work on fixes with affected maintainers.
> 
> Great, thank you.  Hopefully the other patch for libsepol,checkpolicy to 
> prune its copy of flask.h of all SECCLASS_* definitions and take it 
> private to libsepol won't break anything.  With those two changes, we 
> should be free of any lingering uses of hardcoded class and permission 
> definitions.  Then all we need is for dbus-daemon to either set up a 
> POLICYLOAD callback and re-fresh its mapping at that time or switch over 
> to looking up the class and permissions each time as per the guidance in 
> the updated libselinux man pages (per my third patch) and userspace 
> should be safe for class or permission changes.

Just wanted to check: you acked my patch so I assume it is ok to merge 
now even before the above packages are all updated but wanted to confirm.
