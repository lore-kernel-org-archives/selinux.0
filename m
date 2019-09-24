Return-Path: <SRS0=oqeB=XT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE65C432C1
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 13:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD7A2146E
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 13:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="aI9tP9jY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfIXN6R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Sep 2019 09:58:17 -0400
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:59921 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfIXN6R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Sep 2019 09:58:17 -0400
X-EEMSG-check-017: 31366077|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,544,1559520000"; 
   d="scan'208";a="31366077"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Sep 2019 13:58:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569333482; x=1600869482;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QhXw4FH3OvyHIoZYoE4GW4WneTNl1NB09D/kQ+smOrM=;
  b=aI9tP9jYBpecPgtJr6QhdWtv2GCPEPnA1/nnNTo7/gQRP9k0yFOC7red
   DNuLyYuKcM/VLz5K/Yma/w6o43WVK09fRCA3SUlmjLTi2K2DM7azG7N44
   LXm+NrzfvTfzT44dKQ0ueWPUDfSv670ZA0zsRbZwb0UpwH6kBSFVmsK04
   HXgr59yP4Hn5sO31DJUW/jhjZGSYXOH4ETD3PHatNczR8nu0Z5yqX/21/
   OFXBhDegNYe8XHR8q23aw+joEyCvfI+0nsO6bBm1hMnDGiqHCtkCnd90z
   DVq3S5i2qGun2mQJjrmT0q9U2Meo03xlJgrV/6HP1EE6n9+a9xS2mSKJd
   A==;
X-IronPort-AV: E=Sophos;i="5.64,544,1559520000"; 
   d="scan'208";a="28252085"
IronPort-PHdr: =?us-ascii?q?9a23=3Aqttj/h8hW/CcKf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B31escTK2v8tzYMVDF4r011RmVBN6dsKoP1beempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCCzbL9uIxm7rAXcvdQKjIV/Lao81g?=
 =?us-ascii?q?HHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9Lm?=
 =?us-ascii?q?A6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD?=
 =?us-ascii?q?+/9KpgVgPmhzkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe90VRX?=
 =?us-ascii?q?BFXs1MSSJPBI2yZJYLA+YYM+tVq4zxql0TphW8GAasHvvixCJWiH/43aM00O?=
 =?us-ascii?q?ovHg/J0wMiA90Av2/ZrMn3OaoITey50KfFwDfFYvhL2Tn98o/IchU5rP+RQb?=
 =?us-ascii?q?J/b9LRyUkxGAPDk16etInlMCmR1uQJrWea7/drWOW0i2E6sAF8uSSvx8cwhY?=
 =?us-ascii?q?nJgYIZ0FbE9T5jz4ovKt24T1B7bMeiHZBNtC+aL5N7Tt4tTmxnoio3yqAKtY?=
 =?us-ascii?q?SlcCUF1pgr3QPTZvqaeIaS+B3jTvyeITJgiXJgf7Kwmgi9/FC7yu35Ssm0yF?=
 =?us-ascii?q?FKrjdZktXUtnACyRjT6s+fR/th5EihwzeP1x3I6u1ePUA1lbbUK54mwrIqkJ?=
 =?us-ascii?q?ocrV/DETPslEXzja+Wcl0o+umu6+v5frXrvoKQOoB7hw3kMqkih9azDfo3Pw?=
 =?us-ascii?q?QQRWSX5Pyw1Lj58k34RLVKgOc2kq7csJ3CPsQUu7W5DhRJ0ocj9xm/DzCm3M?=
 =?us-ascii?q?4enXkcNl1JYh2Hj4/3O13WOvD3Ee+/g0iwkDds3/3GObjhApLWLnjFirjuYa?=
 =?us-ascii?q?hy5lVGyAUt0N9f54hbCq0bLP3vXU/xscTSDgUlPAys3+bnFNJ925sFWW2RBq?=
 =?us-ascii?q?+ZMaXSsUKH5+80PemMa5EauCznJ/gm+fHul3k5lkEZfaWz2psXcn+4TbxaJB?=
 =?us-ascii?q?C+Z3b2j9VJNGARuAM1Qe+i3FqHViVVbn2/d7gx6jEyFMStCoKVFa63h7nU5z?=
 =?us-ascii?q?u2Bp1bYCh9D1mIFXr5P9GfV+wkdDOZIsgnlCcNE7emVdlyhlmVqAbmxu8/fa?=
 =?us-ascii?q?Lv8SoCuMemjYMk6g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AhAAAjIIpd/wHyM5BlHAEBAQQBAQwEAQGBUwcBAQsBg?=
 =?us-ascii?q?XMqgUAyKoQiiByHPQEBAQEBAQaBNol1jy2BewkBAQEBAQEBAQE0AQIBAYQ/A?=
 =?us-ascii?q?oMhIzQJDgIMAQEBBAEBAQEBBQMBAWyFOYI6KQGCZwEFIxVBEAsOCgICJgICV?=
 =?us-ascii?q?wYNBgIBAYJfPwGBdhStaIEyhUyDOYFIgQwoAYwIGHiBB4ERJ4JrPodPglgEl?=
 =?us-ascii?q?gKXCoIsgi6JbAeIYwYbgjaWb49WmVM4gVgrCAIYCCEPgydQEBSQLyQDMIEGA?=
 =?us-ascii?q?QGMHQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 Sep 2019 13:58:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8ODw11e000507;
        Tue, 24 Sep 2019 09:58:01 -0400
Subject: Re: [PATCH testsuite] policy: do not rebuild policy package if
 already built
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20190923095837.25752-1-omosnace@redhat.com>
 <b74cd6c5-0f63-80d8-99c0-967dc638279c@tycho.nsa.gov>
 <CAFqZXNtagT7TDgV4D88juWK7qVTEgkcjm6UL6zKsPm8gd7yyWg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e2bf659c-53a7-7c20-0c7b-3a102b05513a@tycho.nsa.gov>
Date:   Tue, 24 Sep 2019 09:58:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNtagT7TDgV4D88juWK7qVTEgkcjm6UL6zKsPm8gd7yyWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/24/19 6:51 AM, Ondrej Mosnacek wrote:
> On Mon, Sep 23, 2019 at 4:11 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 9/23/19 5:58 AM, Ondrej Mosnacek wrote:
>>> Right now, test_policy.pp is rebuilt on every make invocation. Tweak the
>>> Makefile so that it is only build when it hasn't been built, it has been
>>> cleaned, or the source files changed.
>>
>> It also needs to be rebuilt if anything under
>> /usr/share/selinux/devel/include has changed e.g. upon an update of
>> selinux-policy-devel.
> 
> I am now testing a version that always executes the `$(MAKE) -C
> test_policy -f $(POLDEV)/Makefile test_policy.pp` step, relying on the
> system Makefile to rebuild the pp as needed (there already are proper
> dependencies on the include files). However, the package manager on
> Fedora preserves the timestamps of the installed files (from package
> build time), which means that make doesn't always detect that the
> files are newer than the already built policy package.
> 
> So it looks like we don't have any other choice than to always rebuild
> if we really need to auto-react to changing system files.

I'd rather err on the side of rebuilding too often than using stale policy.

> 
>>
>>>
>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>> ---
>>>    policy/Makefile | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/policy/Makefile b/policy/Makefile
>>> index a5942b3..cc0f140 100644
>>> --- a/policy/Makefile
>>> +++ b/policy/Makefile
>>> @@ -86,7 +86,7 @@ ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>>>    TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
>>>    endif
>>>
>>> -all: build
>>> +all: test_policy/test_policy.pp
>>>
>>>    expand_check:
>>>        # Test for "expand-check = 0" in /etc/selinux/semanage.conf
>>> @@ -94,7 +94,7 @@ expand_check:
>>>                (echo "ERROR: set 'expand-check = 0' in /etc/selinux/semanage.conf"; \
>>>                 /bin/false)
>>>
>>> -build: $(TARGETS)
>>> +test_policy/test_policy.pp: $(TARGETS) test_policy.if
>>>        # General policy build
>>>        @if [ -d $(POLDEV) ]; then \
>>>                mkdir -p test_policy; \
>>>
>>
> 
> 

