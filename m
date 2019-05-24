Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7887AC072B5
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 16:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28754217D7
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 16:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="iPeEe61K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389831AbfEXQBM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 12:01:12 -0400
Received: from upbd19pa10.eemsg.mail.mil ([214.24.27.85]:8531 "EHLO
        upbd19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389812AbfEXQBM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 May 2019 12:01:12 -0400
X-EEMSG-check-017: 227477854|UPBD19PA10_EEMSG_MP10.csd.disa.mil
X-EEMSG-Attachment-filename: test_01.conf, test.sh
X-EEMSG-Attachment-filesize: 4295, 990
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 May 2019 16:01:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558713667; x=1590249667;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to;
  bh=aOmz2sFfI1Xb7RL35odCwP6KzjB1n1NUQIEPTA+jv2Q=;
  b=iPeEe61KWX/EYBFagaDnNgev5FVK26R7nAntThmlwnN5Pv1p+Ze2qiz/
   XgDkUkZffTqclX6W23FDjENXCehM/3E459uNrtJO/WisaErxAhJ/G79lE
   ZE3Obl4bu7QSFuCj2QD1ht0szS5pAPZMQ2yehr2+ogtr21bUD87FEI6at
   HxC84I3zvKb6CY4U7fdBHrJsJ6Y+yjvk/jT82pVsPujzULqRBYBw5GTAh
   +tuRZMuC6XGl8nGPZdtvzGtc41hIjTY2jiZ6IuRs1kdDLcuTpbuOKn5xa
   +qeAls15wKfJQYzAiIUYoC8g/IvKyqkjoW8wGw8RgXyaAGmRoPJNztjHd
   g==;
X-Attachment-Exists: TRUE
X-IronPort-AV: E=Sophos;i="5.60,507,1549929600"; 
   d="sh'?conf'?scan'208";a="24074696"
IronPort-PHdr: =?us-ascii?q?9a23=3AkNOIBBFgzqqSVU6FvOsVe51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7ypciwAkXT6L1XgUPTWs2DsrQY0rOQ6vm+Ej1eqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5vIBmssAndq8gbjYRmJ6sw1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoQW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sJXOCw0KXF1y/OY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acfRy0cuGB/fgVWKtYzpIS6e2+MPs2mV8+VvT/ivi3I5pwxqvjiuxtsjio?=
 =?us-ascii?q?nOho4PzFDE7j92zJw6Jd2/Vk52eNipG4ZeuSGdMot5WMIiQ2dwtSYm0L0Jo4?=
 =?us-ascii?q?C7fCkRyJg+2xHfauaLc4+S4hLsTOqRLjZ4hG5leLKinBm+61Svyur5VsSyzV?=
 =?us-ascii?q?1ErTJFn8HRun0C2BHf8MiKRuZn8ku/1juDyRrf5vxCLEspj6TUMYQhzaQ1lp?=
 =?us-ascii?q?cLtETDGTL5l1vuga+Nc0Uk5vCo6+P6YrX6vpOcN5F7igX5Mqk2hsywG/44Mg?=
 =?us-ascii?q?kTX2iA4+i8yL3i8lH5QLVNlPE2lLXWsIvGKsgBo665AgtV3p4i6xa5ETimzM?=
 =?us-ascii?q?wVkWQIIV9KYh6Kj5XlN0vQLP33E/uzmUmgnC9ux//cP73hBpvNLmLEkLfkZb?=
 =?us-ascii?q?t96UBdxxYpwtBF+5JYFKoMIO7zW0DttNzYCQU1Mwqvw+n9Etl92YQeWXyXDq?=
 =?us-ascii?q?+DLKzSqUOI5v4oI+SUY48VvTH9K+Mj5/H0kXA2h0QQfbO30pQKaHC3BOhmL1?=
 =?us-ascii?q?+Fbnrrh9cLCX0KsRYmTOz2lF2CViZeZ22sUKI45zE7Dp+mDIjYS4Czj7yOwj?=
 =?us-ascii?q?27EodVZm9YEFCMF2nnd4GeV/cLciKSLZwprjtRcr6tUYIjnTSprwnzwLdkZr?=
 =?us-ascii?q?7T/yoDs5vo2fBv6uHTnA10/jtxWZezyWaIGmNrlWoSW2V+iKJgqkVn1g2rzb?=
 =?us-ascii?q?lzg/seE8daofxOTFFpZtbn0+VmBoWqCUr6ddCTRQPjG4/3DA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DJAwATFOhc/wHyM5BfBh4BBgcGgVEJCwGBZippUQEyK?=
 =?us-ascii?q?IQTiHuMHX6RUIYKFIFnCQEBAQEBAQEBAQMBKQcBAgEBgUtHgWhGAoI/IzQJD?=
 =?us-ascii?q?gEDAQEBBAEBAQEDAQFsHAyCOikBgmcBBSMEUhALCQUKKgICAlUGDQYCAQGCX?=
 =?us-ascii?q?z8BggoPpgN8M4QyAYEUgy+BNhCBNAGBT4oDgVZAgREngjY1PoJhAoE7Dgolg?=
 =?us-ascii?q?nOCWASBLQGKDwGIGZRwBgOCD4MWghgvVoFvhkGEKQYbgh9nhXyNP5NokGQ4g?=
 =?us-ascii?q?VcrCkFKgR6BTgkKgggXFIM5glaCPoVbIwMwgQYBAYs0ASQHgiUBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 May 2019 16:01:05 +0000
Received: from localhost.localdomain (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4OG15aE003405;
        Fri, 24 May 2019 12:01:05 -0400
Subject: Re: [Non-DoD Source] [PATCH userspace 0/4] Remove redundant rules
 when building policydb
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
References: <20190523102449.9621-1-omosnace@redhat.com>
 <0571b2a9-2f34-72c4-431d-450adb7df6a5@tycho.nsa.gov>
 <CAFqZXNsYY5HWkcqwYhu2sZR3eGQGDJnEr43pVbM1fxeA0M1Lzg@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <0480cc58-a4f4-bd0f-9edb-f2befe546578@tycho.nsa.gov>
Date:   Fri, 24 May 2019 12:01:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNsYY5HWkcqwYhu2sZR3eGQGDJnEr43pVbM1fxeA0M1Lzg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------4B840BCA91868A9E2E84BD37"
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------4B840BCA91868A9E2E84BD37
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/19 4:54 AM, Ondrej Mosnacek wrote:
> On Thu, May 23, 2019 at 10:39 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>> On 5/23/19 6:24 AM, Ondrej Mosnacek wrote:
>>> This series implements an optional optimization step when building
>>> a policydb via semodule or secilc, which identifies and removes rules
>>> that are redundant -- i.e. they are already covered by a more general
>>> rule based on attribute inheritance.
>>>
>>> Since the performance penalty of this additional step is very small
>>> (it adds about 1 s to the current running time of ~20-30 s [1]) and
>>> it can have a big positive effect on the number of rules in policy
>>> (it manages to remove ~40% AV rules from Fedora 29 policy), the
>>> optimization is enabled by default and can be turned off using a
>>> command-line option (--no-optimize) in secilc and semodule [2].
>>>
>>> The optimization routine eliminates:
>>>    * all allow/neverallow/dontaudit/auditallow rules (including xperm
>>>      variants) that are covered by another more general rule,
>>>    * all conditional versions of the above rules that are covered by a
>>>      more general rule either in the unconditional table or in the same
>>>      branch of the same conditional.
>>>
>>> The optimization doesn't process other rules, since they currently
>>> do not support attributes. There is some room left for more precise
>>> optimization of conditional rules, but it would likely bring only
>>> little additional benefit.
>>>
>>> When the policy is mostly or fully expanded, the optimization should
>>> be turned off. If it isn't, the policy build time will increase a lot
>>> for no benefit. However, the complexity of optimization will be only
>>> linear w.r.t. the number of rules and so the impact should not be
>>> catastrophic. (When testing with secilc on a subset of Fedora policy
>>> with -X 100000 the build time was 1.7 s with optimization vs. 1 s
>>> without it.)
>>>
>>> Tested live on my Fedora 29 devel machine under normal use. No unusual
>>> AVCs were observed with optimized policy loaded.
>>>
>>> Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/536157427
>>>
>>> NOTE: The xperm rule support wasn't tested -- I would welcome some
>>>         peer review/testing of this part.
>>>
>>> [1] As measured on my machine (Fedora 29 policy, x86_64).
>>> [2] I have no problem with switching it to opt-in if that is preferred.
>>>
>>> Ondrej Mosnacek (4):
>>>     libsepol: add a function to optimize kernel policy
>>>     secilc: optimize policy before writing
>>>     libsemanage: optimize policy on rebuild
>>>     semodule: add flag to disable policy optimization
>>>
>>>    libsemanage/include/semanage/handle.h      |   4 +
>>>    libsemanage/src/direct_api.c               |   7 +
>>>    libsemanage/src/handle.c                   |  13 +
>>>    libsemanage/src/handle.h                   |   1 +
>>>    libsemanage/src/libsemanage.map            |   5 +
>>>    libsepol/include/sepol/policydb.h          |   5 +
>>>    libsepol/include/sepol/policydb/policydb.h |   2 +
>>>    libsepol/src/libsepol.map.in               |   5 +
>>>    libsepol/src/optimize.c                    | 370 +++++++++++++++++++++
>>>    libsepol/src/policydb_public.c             |   5 +
>>>    policycoreutils/semodule/semodule.c        |  12 +-
>>>    secilc/secilc.c                            |  16 +-
>>>    12 files changed, 442 insertions(+), 3 deletions(-)
>>>    create mode 100644 libsepol/src/optimize.c
>>>
>>
>> It would be nice to have checkpolicy support this as well. It shouldn't be too
>> hard to do that.
> 
> Looking at checkpolicy.c, it looks like it only generates POLICY_BASE
> or POLICY_MODULE policy types. I currently limit the optimization only
> to POLICY_KERN type, because from comments in policydb.h I got the
> impression that other policy types have different structure and I'm
> not sure if they need some special handling. I don't have that much
> knowledge about SELinux userspace code yet... if you can give me some
> hints about the difference between the various POLICY_* types, then I
> will be happy to make some adjustments if they make sense.
> 

It is kind of confusing. I sent a patch to the list. You can incorporate that 
into your patch series or I can just do it after.

I've attached the test policy that I used and a test script. I haven't had a 
chance to dig more into what may be going on.

Jim


>>
>> I need to do some more testing, but I think something is not working correctly.
>>
>> I am starting from conf files here because I have both Fedora and Android ones
>> that I have used for testing and it is easier to run them through checkpolicy to
>> convert to CIL.
>>
>> With these rules:
>>
>> # Redundant 1
>> allow tp01 tpr1:cl01 { p01a p11a p01b p11b };
>> allow tp02 tpr1:cl01 { p01a p11a };
>> allow at02 tpr1:cl01 { p01a p11a p01b };
>>
>> # Redundant 2
>> dontaudit tp01 tpr2:cl01 { p01a p11a p01b p11b };
>> dontaudit tp02 tpr2:cl01 { p01a p11a };
>> dontaudit at02 tpr2:cl01 { p01a p11a p01b };
>>
>> # Redundant 3
>> allow at02 tpr3:cl01 { p01a p11a p01b };
>> if (b01) {
>>     allow tp01 tpr3:cl01 { p01a p11a p01b p11b };
>>     allow tp02 tpr3:cl01 { p01a p11a };
>> }
>>
>> # Redundant 4
>> dontaudit at02 tpr4:cl01 { p01a p11a p01b };
>> if (b01) {
>>     dontaudit tp01 tpr4:cl01 { p01a p11a p01b p11b };
>>     dontaudit tp02 tpr4:cl01 { p01a p11a };
>> }
>>
>>
>> I see the following from sediff:
>>
>> Allow Rules (0 Added, 1 Removed, 0 Modified)
>>      Removed Allow Rules: 1
>>         - allow tp02 tpr3:cl01 { p01a p11a }; [ b01 ]:True
>>
>> Dontaudit Rules (0 Added, 1 Removed, 1 Modified)
>>      Removed Dontaudit Rules: 1
>>         - dontaudit tp01 tpr4:cl01 { p01a p01b p11a p11b }; [ b01 ]:True
>>      Modified Dontaudit Rules: 1
>>         * dontaudit tp01 tpr2:cl01 { p01b p11a p01a -p11b };
>>
>> So it handles Redundant 1 just fine, but has problems with Redundant 2 which
>> should be the same.
> 
> Yes, I think I'm handling the dontaudit rules incorrectly... For some
> (historical?) reason they actually specify the permissions that *are*
> audited, although the semantic of combining multiple rules is still
> that a permission is dontaudited if there is at least one dontaudit
> rule for it, so the logic of handling the raw perms data has to be
> inverted for AVTAB_AUDITDENY entries. I had noticed earlier that
> AVTAB_AUDITDENY rules are handled differently but somehow I concluded
> that the perms values should still bitwise-or together...
> 
> Can you please try it with adding:
> 
> if (specified & AVTAB_AUDITDENY)
>      return (d1->data & d2->data) == d2->data;
> 
> to the beginning of match_avtab_datum() in optimize.c? (patch form
> here: https://github.com/WOnder93/selinux/commit/17c77e4bb8857ebfff9b32e2e0bc800e206aba1e.patch)
> 
>>
>> I don't remember what to expect from sediff for boolean rules. I had played
>> around with removing rules with some of my earlier lua tools and I thought that
>> sediff handled removing redundant rules from booleans, but I could be wrong.
>>
>> I will look at this more maybe tomorrow, but most likely after the Memorial day
>> weekend.
>>
>> Jim
>>
>> --
>> James Carter <jwcart2@tycho.nsa.gov>
>> National Security Agency
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--------------4B840BCA91868A9E2E84BD37
Content-Type: text/plain; charset=UTF-8;
 name="test_01.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test_01.conf"

IyBBbGwgcG9saWN5LmNvbmYgcnVsZXMKIyBDYWxsZWQgdGVzdF8wMi5jb25mIGluIGV4cGVj
dGVkX3Bhc3MvY29uZgojIEFkZGVkIHJlZHVuZGFudGFsbG93IHJ1bGVzIHRoYXQgYXJlIGNv
dmVyZWQgYnkgYXR0cmlidXRlCgpjbGFzcyBjbDAxCmNsYXNzIGNsMDIKY2xhc3MgY2wwMwpj
bGFzcyBjbDA0CmNsYXNzIGNseAoKc2lkIGtlcm5lbApzaWQgc2VjdXJpdHkKc2lkIHVubGFi
ZWxlZAoKY29tbW9uIGNtMDEgeyBwMTFhIHAxMWIgfQpjb21tb24gY20wMiB7IHAyMmEgcDIy
YiB9CgpjbGFzcyBjbDAxIGluaGVyaXRzIGNtMDEgeyBwMDFhIHAwMWIgfQpjbGFzcyBjbDAy
IGluaGVyaXRzIGNtMDIKY2xhc3MgY2wwMyB7IHAwM2EgcDAzYiB9CmNsYXNzIGNsMDQgeyBw
MDRhIHAwNGIgfQpjbGFzcyBjbHggeyBpb2N0bCB9CgpkZWZhdWx0X3VzZXIgeyBjbDAxIGNs
MDIgY2wwMyB9IHNvdXJjZTsKZGVmYXVsdF9yb2xlIHsgY2wwMSB9IHNvdXJjZTsKZGVmYXVs
dF90eXBlIHsgY2wwMiB9IHRhcmdldDsKZGVmYXVsdF9yYW5nZSB7IGNsMDMgfSB0YXJnZXQg
bG93LWhpZ2g7CgpzZW5zaXRpdml0eSBzMDEgYWxpYXMgc3lzbG93OwpzZW5zaXRpdml0eSBz
MDI7CnNlbnNpdGl2aXR5IHMwMyBhbGlhcyB7IHN5c2hpZ2ggbWF4c2VucyB9OwoKZG9taW5h
bmNlIHsgczAxIHMwMiBzMDMgfQoKY2F0ZWdvcnkgYzAxIGFsaWFzIGNhdDAxOwpjYXRlZ29y
eSBjMDIgYWxpYXMgeyBjYXQwMmEgY2F0MDJiIH07CmNhdGVnb3J5IGMwMzsKCmxldmVsIHMw
MTsKbGV2ZWwgczAyOmMwMSxjMDM7CmxldmVsIHMwMzpjMDEuYzAzOwoKbWxzY29uc3RyYWlu
IGNsMDEgeyBwMDFhIH0gKChoMSBkb20gaDIpIGFuZCAobDEgZG9tYnkgaDEpKTsKbWxzdmFs
aWRhdGV0cmFucyBjbDAyICgobDEgZXEgbDIpIG9yIChsMSBpbmNvbXAgbDIpKTsKbWxzdmFs
aWRhdGV0cmFucyBjbDAyICgobDEgZXEgbDIpIG9yICh0MyBlcSB0cG8pKTsKCnBvbGljeWNh
cCBuZXR3b3JrX3BlZXJfY29udHJvbHM7CnBvbGljeWNhcCBvcGVuX3Blcm1zOwoKYXR0cmli
dXRlIGF0MDE7CmF0dHJpYnV0ZSBhdDAyOwoKYXR0cmlidXRlX3JvbGUgYXIwMTsKYXR0cmli
dXRlX3JvbGUgYXIwMjsKCmJvb2wgYjAxIGZhbHNlOwpib29sIGIwMiB0cnVlOwoKdHlwZSB0
cG87CnR5cGUgdHB4Owp0eXBlIHRwMDE7CnR5cGUgdHAwMjsKdHlwZSB0cDAzcDsKdHlwZSB0
cDAzYzsKdHlwZSB0cDA0Owp0eXBlIHRwcjE7CnR5cGUgdHByMjsKdHlwZSB0cHIzOwp0eXBl
IHRwcjQ7CnR5cGUgdHByNTsKCnR5cGVhbGlhcyB0cDAxIGFsaWFzIHsgdGEwMWEgdGEwMWIg
fTsKdHlwZWFsaWFzIHRwMDIgYWxpYXMgdGEwMjsKCnR5cGVib3VuZHMgdHAwM3AgdHAwM2M7
Cgp0eXBlYXR0cmlidXRlIHRwMDEgYXQwMSwgYXQwMjsKdHlwZWF0dHJpYnV0ZSB0cDAyIGF0
MDI7CgpwZXJtaXNzaXZlIHRwMDE7CgphbGxvdyB0cDAxIHNlbGY6Y2wwMSB7IHAwMWEgcDEx
YSB9OwphbGxvdyB0cDAxIHRhMDFhOmNsMDEgcDAxYjsKYWxsb3cgdHAwMSBhdDAxOmNsMDEg
cDExYjsKYWxsb3cgdHAwMSB0cG86Y2wwMiBwMjJhOwphbGxvdyBhdDAyIHRwbzpjbDAyIHAy
MmI7CmFsbG93IHRwMDNwIHRwbzpjbDAzIHsgcDAzYSBwMDNiIH07CmFsbG93IHRwMDNjIHRw
bzpjbDAzIHAwM2E7CmFsbG93IHRwMDQgdHB4OmNseCBpb2N0bDsKYXVkaXRhbGxvdyB0cDAx
IHRwbzpjbDAxIHAwMWE7CmRvbnRhdWRpdCB0cDAxIHRwbzpjbDAxIHAwMWI7Cm5ldmVyYWxs
b3cgdHAwMSB0cG86Y2wwMSBwMTFhOwoKIyBSZWR1bmRhbnQgMQphbGxvdyB0cDAxIHRwcjE6
Y2wwMSB7IHAwMWEgcDExYSBwMDFiIHAxMWIgfTsKYWxsb3cgdHAwMiB0cHIxOmNsMDEgeyBw
MDFhIHAxMWEgfTsKYWxsb3cgYXQwMiB0cHIxOmNsMDEgeyBwMDFhIHAxMWEgcDAxYiB9OwoK
IyBSZWR1bmRhbnQgMgpkb250YXVkaXQgdHAwMSB0cHIyOmNsMDEgeyBwMDFhIHAxMWEgcDAx
YiBwMTFiIH07CmRvbnRhdWRpdCB0cDAyIHRwcjI6Y2wwMSB7IHAwMWEgcDExYSB9Owpkb250
YXVkaXQgYXQwMiB0cHIyOmNsMDEgeyBwMDFhIHAxMWEgcDAxYiB9OwoKIyBSZWR1bmRhbnQg
MwphbGxvdyBhdDAyIHRwcjM6Y2wwMSB7IHAwMWEgcDExYSBwMDFiIH07CmlmIChiMDEpIHsK
ICBhbGxvdyB0cDAxIHRwcjM6Y2wwMSB7IHAwMWEgcDExYSBwMDFiIHAxMWIgfTsKICBhbGxv
dyB0cDAyIHRwcjM6Y2wwMSB7IHAwMWEgcDExYSB9Owp9CgojIFJlZHVuZGFudCA0CmRvbnRh
dWRpdCBhdDAyIHRwcjQ6Y2wwMSB7IHAwMWEgcDExYSBwMDFiIH07CmlmIChiMDEpIHsKICBk
b250YXVkaXQgdHAwMSB0cHI0OmNsMDEgeyBwMDFhIHAxMWEgcDAxYiBwMTFiIH07CiAgZG9u
dGF1ZGl0IHRwMDIgdHByNDpjbDAxIHsgcDAxYSBwMTFhIH07Cn0KCiMgUmVkdW5kYW50IDUK
CmlmIChiMDEpIHsKICBhbGxvdyB0cDAxIHRwcjU6Y2wwMSB7IHAwMWEgcDExYSBwMDFiIHAx
MWIgfTsKICBhbGxvdyB0cDAyIHRwcjU6Y2wwMSB7IHAwMWEgcDExYSB9Owp9IGVsc2Ugewog
IGFsbG93IGF0MDIgdHByNTpjbDAxIHsgcDAxYSBwMTFhIHAwMWIgfTsKfQoKYWxsb3d4cGVy
bSB0cDA0IHRweDpjbHggaW9jdGwgMHgxMjM0OwphdWRpdGFsbG93eHBlcm0gdHAwNCB0cHg6
Y2x4IGlvY3RsIDB4OTkxMTsKZG9udGF1ZGl0eHBlcm0gdHAwNCB0cHg6Y2x4IGlvY3RsIDB4
OTkyMjsKbmV2ZXJhbGxvd3hwZXJtIHRwMDQgdHB4OmNseCBpb2N0bCAweDk5MzM7Cgp0eXBl
X3RyYW5zaXRpb24gdHAwMSB0cG86Y2wwMSB0cDAyOwp0eXBlX21lbWJlciB0cDAxIHRwbzpj
bDAyIHRwMDI7CnR5cGVfY2hhbmdlIHRwMDEgdHBvOmNsMDMgdHAwMjsKdHlwZV90cmFuc2l0
aW9uIHRwMDEgdHBvOmNsMDQgdHAwMiAiZmlsZTAxIjsKCnJhbmdlX3RyYW5zaXRpb24gdHAw
MSB0cG86Y2wwMSBzMDI7ICAKcmFuZ2VfdHJhbnNpdGlvbiB0cDAxIHRwbzpjbDAyIHMwMiAt
IHMwMzpjMDEsY2F0MDJhOyAgCgpyb2xlIHJsMDE7CnJvbGUgcmwwMjsKcm9sZSBybDAzcDsK
cm9sZSBybDAzYzsKCnJvbGUgcmwwMSB0eXBlcyB7IHRwMDEgdHAwMiB9Owpyb2xlIHJsMDIg
dHlwZXMgeyB0cDAyIH07CnJvbGUgcmwwM3AgdHlwZXMgdHAwM3A7CnJvbGUgcmwwM2MgdHlw
ZXMgdHAwM2M7Cgpyb2xlYXR0cmlidXRlIHJsMDEgYXIwMSwgYXIwMjsKcm9sZWF0dHJpYnV0
ZSBybDAyIGFyMDI7CgphbGxvdyBybDAxIHJsMDI7Cgpyb2xlX3RyYW5zaXRpb24gcmwwMSB0
cG86Y2wwMSBybDAyOwoKdXNlciB1czAxIHJvbGVzIHJsMDEgbGV2ZWwgczAxIHJhbmdlIHMw
MSAtIHMwMzpjMDEuYzAzOwoKY29uc3RyYWluIGNsMDEgeyBwMDFiIH0gbm90ICgodDEgPT0g
dHBvKSBhbmQgKHUxICE9IHUyKSk7CnZhbGlkYXRldHJhbnMgY2wwMiAoKHUxID09IHUyKSBv
ciAocjEgPT0gcjIpKTsKdmFsaWRhdGV0cmFucyBjbDAyICgodTEgPT0gdTIpIG9yICh0MyA9
PSB0cG8pKTsKCnNpZCBrZXJuZWwgdXMwMTpybDAxOnRwMDE6c3lzbG93IC0gc3lzaGlnaDpj
MDEsY2F0MDJiLGMwMwpzaWQgc2VjdXJpdHkgdXMwMTpybDAxOnRwMDE6czAxIC0gczAyCnNp
ZCB1bmxhYmVsZWQgdXMwMTpybDAxOnRwMDE6czAyOmMwMSxjMDMgLSBtYXhzZW5zOmNhdDAx
LGMwMwoKZnNfdXNlX3hhdHRyIGZzMDEgdXMwMTpybDAxOnRwMDE6czAxOwpmc191c2VfdGFz
ayBmczAyIHVzMDE6cmwwMTp0cDAxOnMwMTsKZnNfdXNlX3RyYW5zIGZzMDMgdXMwMTpybDAx
OnRwMDE6czAxOwpnZW5mc2NvbiBmczA0IC8gdXMwMTpybDAxOnRwMDE6czAxCnBvcnRjb24g
dWRwIDEwMDAgdXMwMTpybDAxOnRwMDE6czAxCnBvcnRjb24gdWRwIDEwMDEtMTAwOSB1czAx
OnJsMDE6dHAwMTpzMDEKcG9ydGNvbiB0Y3AgMjAwMCB1czAxOnJsMDE6dHAwMTpzMDEKcG9y
dGNvbiB0Y3AgMjAwMS0yMDA5IHVzMDE6cmwwMTp0cDAxOnMwMQpwb3J0Y29uIGRjY3AgMzAw
MCB1czAxOnJsMDE6dHAwMTpzMDEKcG9ydGNvbiBkY2NwIDMwMDEtMzAwOSB1czAxOnJsMDE6
dHAwMTpzMDEKbmV0aWZjb24gaWYwMSB1czAxOnJsMDE6dHAwMTpzMDEgdXMwMTpybDAxOnRw
MDI6czAxCm5vZGVjb24gMTAuMC4wLjEgMjU1LjI1NS4yNTUuMCB1czAxOnJsMDE6dHAwMTpz
MDEKbm9kZWNvbiBmYzAwOjoxIGZjMDA6OmZmZmYgdXMwMTpybDAxOnRwMDE6czAxCgojIFhF
TgojcGlycWNvbiA2NTUzNSB1czAxOnJsMDE6dHAwMTpzMDEKI2lvbWVtY29uIDAtOTk5OTkg
dXMwMTpybDAxOnRwMDE6czAxCiNpb3BvcnRjb24gMC05OTk5OSB1czAxOnJsMDE6dHAwMTpz
MDEKI3BjaWRldmljZWNvbiA5OTk5OSB1czAxOnJsMDE6dHAwMTpzMDEKI2RldmljZXRyZWVj
b24gIi9QQVRIIiB1czAxOnJsMDE6dHAwMTpzMDE=
--------------4B840BCA91868A9E2E84BD37
Content-Type: application/x-shellscript;
 name="test.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test.sh"

IyEgL3Vzci9iaW4vYmFzaAoKUFJFRklYPS9ob21lL2p3Y2FydDIvbG9jYWwKCmV4cG9ydCBM
RF9MSUJSQVJZX1BBVEg9JFBSRUZJWC9saWI6JFBSRUZJWC91c3IvbGliOiRQUkVGSVgvdXNy
L2xpYjY0OiRQUkVGSVgvdXNyL2xpYmV4ZWM6JHtMRF9MSUJSQVJZX1BBVEh9CgokUFJFRklY
L3Vzci9iaW4vY2hlY2twb2xpY3kgLU0gLW8gdGVzdF8wMS5jb25mLm9yaWcuYmluIHRlc3Rf
MDEuY29uZgokUFJFRklYL3Vzci9iaW4vY2hlY2twb2xpY3kgLU8gLU0gLW8gdGVzdF8wMS5j
b25mLm9wdC5iaW4gdGVzdF8wMS5jb25mCiRQUkVGSVgvdXNyL2Jpbi9jaGVja3BvbGljeSAt
TyAtTSAtYiAtbyB0ZXN0XzAxLmNvbmYub3B0Mi5iaW4gdGVzdF8wMS5jb25mLm9yaWcuYmlu
CgokUFJFRklYL3Vzci9iaW4vY2hlY2twb2xpY3kgLU0gLUMgLW8gdGVzdF8wMS5jb25mLmNp
bCB0ZXN0XzAxLmNvbmYKJFBSRUZJWC91c3IvYmluL3NlY2lsYyAtbiAtTiAtTSAxIC1vIHRl
c3RfMDEuY29uZi5jaWwub3JpZy5iaW4gdGVzdF8wMS5jb25mLmNpbAokUFJFRklYL3Vzci9i
aW4vc2VjaWxjIC1OIC1NIDEgLW8gdGVzdF8wMS5jb25mLmNpbC5vcHQuYmluIHRlc3RfMDEu
Y29uZi5jaWwKCnNlZGlmZiB0ZXN0XzAxLmNvbmYub3JpZy5iaW4gdGVzdF8wMS5jb25mLmNp
bC5vcmlnLmJpbiA+IHRlc3RfMDEtb3JpZ19vcmlnLnNlZGlmZgpzZWRpZmYgdGVzdF8wMS5j
b25mLm9wdC5iaW4gdGVzdF8wMS5jb25mLmNpbC5vcHQuYmluID4gdGVzdF8wMS1vcHRfb3B0
LnNlZGlmZgpzZWRpZmYgdGVzdF8wMS5jb25mLm9yaWcuYmluIHRlc3RfMDEuY29uZi5vcHQu
YmluID4gdGVzdF8wMS1jb25mLnNlZGlmZgpzZWRpZmYgdGVzdF8wMS5jb25mLm9yaWcuYmlu
IHRlc3RfMDEuY29uZi5vcHQyLmJpbiA+IHRlc3RfMDEtY29uZjIuc2VkaWZmCnNlZGlmZiB0
ZXN0XzAxLmNvbmYuY2lsLm9yaWcuYmluIHRlc3RfMDEuY29uZi5jaWwub3B0LmJpbiA+IHRl
c3RfMDEtY2lsLnNlZGlmZgoK
--------------4B840BCA91868A9E2E84BD37--
