Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B9EC43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 13:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E02120661
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 13:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ar41D0GP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfB0N5w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:57:52 -0500
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:28626 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbfB0N5w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Feb 2019 08:57:52 -0500
X-EEMSG-check-017: 647255414|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,419,1544486400"; 
   d="scan'208";a="647255414"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Feb 2019 13:57:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551275871; x=1582811871;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=K2MzW8Jct6VeTu2dVqF50y6yi5fs1qTt2REurRLvZuI=;
  b=ar41D0GPRTTR9tQAzCeLmX8vp1kQA+o6TSsfjgss5wtHh4v0Dgd3LZEO
   LOMt81jWA+126ZdKD+aj74kh+EpPWd7pCNOV8ahsYWooXu7RNNXsSfZuW
   9tRlIJPWERfuZ4l2Cj3qPyxyuL3vaRw3e2gHF2cmAqjEDLcNTDICLybyH
   YJDq2YAGC5EOxTGAMbzRyNP+fBR80XCWCa3o42ISav4s/5We5U0Y3GCSo
   8Ys43QSSilsyg93NOKYFFD/U/yX9klTUWWZvQSE+lLUhCdLJoIN15rXj0
   RSFqRCuvn9dYVlfujAw4uzO6CZ8OmKsAI+hbM1PsdE5s0qXH6lPUkztEJ
   A==;
X-IronPort-AV: E=Sophos;i="5.58,419,1544486400"; 
   d="scan'208";a="20936311"
IronPort-PHdr: =?us-ascii?q?9a23=3ADz116RF9MO6OGtzxz7YwFp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p867bnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+cAOOpVqZT2qVkTohukHQSiGePhxCFGhnH106M13e?=
 =?us-ascii?q?suHgPa0wIvBN8OrHfZoc/pOKsOX+24zq/FxijDYfNM3jf97ZDFfA09of6SRb?=
 =?us-ascii?q?JwcdTeyU8yHA3Yi1Wfs4jlPzeL2eUNrmOW6PFgWv+0i2M8twFwoiSgxscrio?=
 =?us-ascii?q?XTgIIV0UrL+T92wIYyO921UUh2asOqHptXsiGVLYp2QsU6TmFzpik6zrwGuZ?=
 =?us-ascii?q?imfCkF0JQn3Rnfa/6ZfIeU/hLvTuGRIS13hH59d7K/gBGy8UekyuLiTcm010?=
 =?us-ascii?q?tKrjBZndbSrHwCyxvT6s2BR/Bg/UmhwS6C2x3c5+xLO0w5lbfXJ4Q/zrM/iJ?=
 =?us-ascii?q?Yfq1nPEynrk0vslqCWbF8r+u2w5uTiZbXpu4GTOpdvigH7LqQugsu/AfkkMg?=
 =?us-ascii?q?QWX2iU5+C81Lr78E3lWrpKlPw2krTCsJzAOcQaprK2Aw9S0oo57RawEyym38?=
 =?us-ascii?q?gCkXkCLVJFfAqLj4nvO17QPPD1FeqzjlujnTtxx/3KI6ftDovCI3TdirvtYK?=
 =?us-ascii?q?5x60tGxwoyydBf6YhUCrYEIP/rQU/+qcfYAwQlMw203+nnCNJ92pkYWWKUGK?=
 =?us-ascii?q?CVKqzSsViW5u43OemDeJcVuCrhK/gi//PulWE2lkQDcqmv3JsXdHe4E+9nI0?=
 =?us-ascii?q?qHf3XjnM0NEWAQvgoxVObqkkGNUSZPZ3auWKIx/jM7CIW4AorYQICimriB3C?=
 =?us-ascii?q?OhEpJKYWBGD0iGEW30eIWcR/cMdCWSL9d6kjMaUbihSokh1QyhtQLh1bpnIf?=
 =?us-ascii?q?Tb+jcCuZLgytd1/evTmg829TBuCMSdyW6NHClImTYjRyU3x+hHrGZwzFaf1u?=
 =?us-ascii?q?Asm/FSGNpS+/RhUwo3ONjb1eMsT5jQXQ+JWN6NTB7yQNKrKTc4StZ3yNgLNQ?=
 =?us-ascii?q?I1ANimjxbezwK0DLIP0b+GHpo59uTbxXeiCdx6ziP9yKQ5j1QgCvBKPGmii7?=
 =?us-ascii?q?83oxPfHKbVgk6ZkOCsbq1a0ynTojTQhVGStV1VBVYjGZ7OWmoSMw6P9Yr0?=
X-IPAS-Result: =?us-ascii?q?A2AsAABnlnZc/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VkqZ4EDhC+IGotMTAEBAQEBAQaBNXyIQI5kgXswCAGDekYChA0iNAkNAQMBA?=
 =?us-ascii?q?QEBAQECAWwcDII6KQGCZwEFIw8BBVELGAICJgICVwYBDAgBAYJfPQGBZQ0Pq?=
 =?us-ascii?q?yiBL4otgQuLPRd4gQeBESeCNjWDEoR5glcCkV6SDAmHQosiBhmCS5BRil2FV?=
 =?us-ascii?q?o4vOIFWKwgCGAghD4MoCIIfF4NLhRSFXSEDgTUBAY55K4IgAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Feb 2019 13:57:49 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1RDvns3027355;
        Wed, 27 Feb 2019 08:57:49 -0500
Subject: Re: neverallow rules
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Chris PeBenito <pebenito@ieee.org>, Joe Nall <joe@nall.com>,
        selinux@vger.kernel.org
References: <10D60D97-3E05-4F8C-86B5-8A56FCEFB3B1@nall.com>
 <6d65bb0be6bd5ccbdb1f99a646679e21955d6159.camel@ieee.org>
 <f1d65c8e-4490-5df0-7ba5-b589e3d85713@tycho.nsa.gov>
 <be045c89-1c1e-7c1a-0223-0ba655980d7c@tycho.nsa.gov>
Message-ID: <cb3c7a17-077e-32f7-f293-f434d5b0ed72@tycho.nsa.gov>
Date:   Wed, 27 Feb 2019 08:54:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <be045c89-1c1e-7c1a-0223-0ba655980d7c@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/27/19 8:48 AM, Stephen Smalley wrote:
> On 2/27/19 8:29 AM, Stephen Smalley wrote:
>> On 2/26/19 10:38 PM, Chris PeBenito wrote:
>>> On Tue, 2019-02-26 at 19:29 -0600, Joe Nall wrote:
>>>> Looking at neverallow rules, the semanage.conf file says
>>>> "# expand-check check neverallow rules when executing all semanage
>>>> commands.
>>>>   # Large penalty in time if you turn this on. "
>>>>
>>>> If I don't set expand-check=1, are the neverallow rules actually
>>>> enforced?
>>>
>>> Nope.
>>>
>>>> If so, when?
>>>>
>>>> An semodule -i of a policy module with neverallow rules that are
>>>> violated by the existing binary policy succeeds without complaint
>>>> unless expand-check=1 in RHEL 7.6. This is not what I expected.
>>>>
>>>> The time taken by a trivial module installation goes from ~.3 seconds
>>>> to ~14 seconds, so the time hit for expand-check is pretty serious.
>>>
>>> The reason for adding the expand-check option is because the neverallow
>>> checking is so expensive.
>>>
>>>> We are trying to establish some policy invariants to protect against
>>>> unexpected/unnoticed RHEL upstream policy changes, some of which have
>>>> bitten us recently. Any suggestions are welcome.
>>>
>>> One alternative would be to use the setools API to code up some policy
>>> searches in Python, then process the results to find things you
>>> do/don't want in your policy.
>>
>> The approach taken in Fedora/RHEL is to run make validate as part of 
>> the selinux-policy.spec recipe, which uses the validate target in the 
>> refpolicy Makefile, which manually runs semodule_link and 
>> semodule_expand to manually link and expand the modules and performs 
>> full checking.  Then the cost is only paid at policy build time and is 
>> only applied for the neverallow rules and allow rules in the 
>> Fedora/RHEL policy, not for third party modules.  If you are 
>> rebuilding the RHEL policy from source, you could add your neverallows 
>> to it there and the make validate should catch the violations.
>>
>> In Android, neverallow checking is done both at policy build time and 
>> as part of device certification.  The latter is done using a 
>> sepolicy-analyze tool we originally contributed; it can take a 
>> separate neverallow rule configuration in source form and an already 
>> compiled kernel binary policy and check them against each other.  
>> That's useful for cases where you don't have policy sources.
>>
>> You can have libsemanage apply your own checker against policy as part 
>> of module transactions by specifying a [verify kernel] stanza in 
>> semanage.conf, see:
>> http://selinuxproject.org/page/PolicyValidate
> 
> Also, FWIW, you can obtain, build, and use sepolicy-analyze outside of 
> the Android build system as follows. If you are on RHEL 7, you likely 
> need/want to obtain the upstream selinux userspace and build its version 
> of libsepol.a for use below instead of using the libsepol-static package 
> from RHEL since that is likely too old.
> 
> # Get source and build.
> $ git clone https://android.googlesource.com/platform/system/sepolicy
> $ cd sepolicy/tools/sepolicy-analyze
> $ gcc -o sepolicy-analyze *.c /path/to/libsepol.a
> 
> # Run with neverallows specified on the command-line.
> $ sepolicy-analyze /etc/selinux/targeted/policy/policy.31 neverallow -n 
> "neverallow user_t self:process signal;"
> 
> # Run with neverallows from a separate file.
> $ cat > neverallows.conf <<EOF
> neverallow user_t self:process signal;
> EOF
> $ sepolicy-analyze /etc/selinux/targeted/policy/policy.31 neverallow -f 
> neverallows.conf
> 
> There have been improvements to neverallow checking time upstream since 
> RHEL 7, but it will still be a function of policy size and obviously 
> RHEL has a much larger policy than Android...

For reference, on Fedora 29:

$ time sepolicy-analyze /etc/selinux/targeted/policy/policy.31 
neverallow -n "neverallow user_t self:capability mac_admin;"

real	0m0.145s
user	0m0.133s
sys	0m0.012s
