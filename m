Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70FEC43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 14:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBF020661
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 14:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="inO+MULf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfB0OBj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:01:39 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:25139 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfB0OBi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Feb 2019 09:01:38 -0500
X-EEMSG-check-017: 647703257|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,419,1544486400"; 
   d="scan'208";a="647703257"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Feb 2019 14:01:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551276097; x=1582812097;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=R8CCzO3imglhizzTwQTXdGVPpuvKhdKA5ySVu2DEatk=;
  b=inO+MULfBvXEqhHQO6xwP/qCRAf3zKyjZIumHvgUp0VGz+j0cAeRmyZx
   2L1KPXFgOn09c7FE8o6v/aGGXTNdsnFzgj+8lsuZvzTOnt2L+Xu2icyp9
   Ei21UAzHN6n1c+aWK7ruqkkK5BechB5IVBCgFzcpLc6mBx212fQ5Qaf0A
   kt/oNxbJ3hZ0PNC0v8qWTI3anoQD7LSXCI/zVZXTr2qAwUTp5Fo0FmlWM
   3pWdanwe5RMVl3u5Cw6OqVg5qj9GSa+v2wDQMbVvBUYJHKYZOxkDKfPS+
   nufBnhG8Zgr8zdS8QcvMaDewZWS/UT0JRhX59x0TNvqDZVjdk3u2H/kq3
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,419,1544486400"; 
   d="scan'208";a="24386847"
IronPort-PHdr: =?us-ascii?q?9a23=3AEBh6sRyX5jC9UrvXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoUK/ad9pjvdHbS+e9qxAeQG9mDu7Qc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYAhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+xbo4DAuwcNuhasob9vUMDowa+CweyCuPhyTFGiXH50qI4z+?=
 =?us-ascii?q?svHhrL3BAjEt8UrHjYsNv4OaUUXOuozKfI1zLDb/ZO1Dng9IjHbAghofGSUr?=
 =?us-ascii?q?J2bMHf1EwvGBnBjlWUt4PkPy6e2+MWs2eG9OptTv6vim47pAFxpTij3MEsip?=
 =?us-ascii?q?LTiY4PxVDE8jt5zZ8zKNalRkB7ZtukH4FRtyGcL4Z2Wd0tQ2VpuCY8170Hto?=
 =?us-ascii?q?a7fDINyJQl2RHQd+CHf5KP4hL5W+adOTh4hHVieLKwgxa971OgyurhVsmuzF?=
 =?us-ascii?q?lFsDBJncXLtnAI0RHY98uJSuNl80u81juC2Brf5+FZLUwui6bWJIAtzqQtmp?=
 =?us-ascii?q?cVrE/NBDX5mF/sg6+Tbkgk/++o5Pn5bbj+vZ+cMpN0ihn5MqQzhsyzGeQ4PR?=
 =?us-ascii?q?YKX2ic4em8yKfs/Vf4QLVXlf06iLXZsZDGKsQboa61GQlV3Zo46xmjFTum1d?=
 =?us-ascii?q?UYnX0fIFJEfhKIkZTpNknTLP33AvqzmVShnCpxy/zYMbDtHI/BImXbnLfkZ7?=
 =?us-ascii?q?l96kpcyAQpzdBY4pJZEqoBL+/oWkLqqNzZDgM2Mwyzw+r9DtV9zZkRVXiAAq?=
 =?us-ascii?q?+eLqPeqUWI6f43I+mQeI8Vvy7wK+A76PH1k3A5n14dfbWu3ZYMaXC3AOppLF?=
 =?us-ascii?q?uDbXrrmNcBHn8AvhAiQ+zylF2CTTlTam6wX6I7+D42E4SmAp3HRoCpmrCOwC?=
 =?us-ascii?q?C7HphObGBcFl+MCWvod5mDW/oUcyKdPMthkj0CVbi8RI4szg+utADkxLp9NO?=
 =?us-ascii?q?bU+TMXtYjl1Ndr4+3fjxYy9SZ7D5fV72bYZGFun3hAfzIc0aZ+vUs1nk+O26?=
 =?us-ascii?q?V+guBfPd1e6v4PVR01Y9qU7et3Q/b7XgaJKtWORX6gS9GiRzo2S4R1i8QDZ0?=
 =?us-ascii?q?d7BsWKkB/OxWypDqUTmrjNA4Y7oYzG2H2kHNpw03bL0uEailAiRsZefTm9ir?=
 =?us-ascii?q?VX6xnYB4mPlV6Q0amta/JPj2b26G6fwD/W7wljWwlqXPCABChBaw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BkAADZl3Zc/wHyM5BkHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VkqZ4EDhC+TZkwBAQEBAQEGgTV8iECOZIF7MAgBg3pGAoQNIjYHDQEDAQEBA?=
 =?us-ascii?q?QEBAgFsHAyCOikBgmcBBSMPAQVRCxgCAiYCAlcGAQwIAQGCXz0BgWUND6sbg?=
 =?us-ascii?q?S+KLYELiz0XeIEHgREngjY1gxKEeYJXApFekgwJh0KLIgYZgkuQUYpdhVaON?=
 =?us-ascii?q?gongVYrCAIYCCEPgygIgh8Xg0uFFIVdIQOBNQEBjnkrgiABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Feb 2019 14:01:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1RE1WY5001347;
        Wed, 27 Feb 2019 09:01:32 -0500
Subject: Re: neverallow rules
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Chris PeBenito <pebenito@ieee.org>, Joe Nall <joe@nall.com>,
        selinux@vger.kernel.org
References: <10D60D97-3E05-4F8C-86B5-8A56FCEFB3B1@nall.com>
 <6d65bb0be6bd5ccbdb1f99a646679e21955d6159.camel@ieee.org>
 <f1d65c8e-4490-5df0-7ba5-b589e3d85713@tycho.nsa.gov>
 <be045c89-1c1e-7c1a-0223-0ba655980d7c@tycho.nsa.gov>
 <cb3c7a17-077e-32f7-f293-f434d5b0ed72@tycho.nsa.gov>
Message-ID: <b3ede4f5-78ac-65e6-98bd-92d535eb0026@tycho.nsa.gov>
Date:   Wed, 27 Feb 2019 08:57:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <cb3c7a17-077e-32f7-f293-f434d5b0ed72@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/27/19 8:54 AM, Stephen Smalley wrote:
> On 2/27/19 8:48 AM, Stephen Smalley wrote:
>> On 2/27/19 8:29 AM, Stephen Smalley wrote:
>>> On 2/26/19 10:38 PM, Chris PeBenito wrote:
>>>> On Tue, 2019-02-26 at 19:29 -0600, Joe Nall wrote:
>>>>> Looking at neverallow rules, the semanage.conf file says
>>>>> "# expand-check check neverallow rules when executing all semanage
>>>>> commands.
>>>>>   # Large penalty in time if you turn this on. "
>>>>>
>>>>> If I don't set expand-check=1, are the neverallow rules actually
>>>>> enforced?
>>>>
>>>> Nope.
>>>>
>>>>> If so, when?
>>>>>
>>>>> An semodule -i of a policy module with neverallow rules that are
>>>>> violated by the existing binary policy succeeds without complaint
>>>>> unless expand-check=1 in RHEL 7.6. This is not what I expected.
>>>>>
>>>>> The time taken by a trivial module installation goes from ~.3 seconds
>>>>> to ~14 seconds, so the time hit for expand-check is pretty serious.
>>>>
>>>> The reason for adding the expand-check option is because the neverallow
>>>> checking is so expensive.
>>>>
>>>>> We are trying to establish some policy invariants to protect against
>>>>> unexpected/unnoticed RHEL upstream policy changes, some of which have
>>>>> bitten us recently. Any suggestions are welcome.
>>>>
>>>> One alternative would be to use the setools API to code up some policy
>>>> searches in Python, then process the results to find things you
>>>> do/don't want in your policy.
>>>
>>> The approach taken in Fedora/RHEL is to run make validate as part of 
>>> the selinux-policy.spec recipe, which uses the validate target in the 
>>> refpolicy Makefile, which manually runs semodule_link and 
>>> semodule_expand to manually link and expand the modules and performs 
>>> full checking.  Then the cost is only paid at policy build time and 
>>> is only applied for the neverallow rules and allow rules in the 
>>> Fedora/RHEL policy, not for third party modules.  If you are 
>>> rebuilding the RHEL policy from source, you could add your 
>>> neverallows to it there and the make validate should catch the 
>>> violations.
>>>
>>> In Android, neverallow checking is done both at policy build time and 
>>> as part of device certification.  The latter is done using a 
>>> sepolicy-analyze tool we originally contributed; it can take a 
>>> separate neverallow rule configuration in source form and an already 
>>> compiled kernel binary policy and check them against each other. 
>>> That's useful for cases where you don't have policy sources.
>>>
>>> You can have libsemanage apply your own checker against policy as 
>>> part of module transactions by specifying a [verify kernel] stanza in 
>>> semanage.conf, see:
>>> http://selinuxproject.org/page/PolicyValidate
>>
>> Also, FWIW, you can obtain, build, and use sepolicy-analyze outside of 
>> the Android build system as follows. If you are on RHEL 7, you likely 
>> need/want to obtain the upstream selinux userspace and build its 
>> version of libsepol.a for use below instead of using the 
>> libsepol-static package from RHEL since that is likely too old.
>>
>> # Get source and build.
>> $ git clone https://android.googlesource.com/platform/system/sepolicy
>> $ cd sepolicy/tools/sepolicy-analyze
>> $ gcc -o sepolicy-analyze *.c /path/to/libsepol.a
>>
>> # Run with neverallows specified on the command-line.
>> $ sepolicy-analyze /etc/selinux/targeted/policy/policy.31 neverallow 
>> -n "neverallow user_t self:process signal;"
>>
>> # Run with neverallows from a separate file.
>> $ cat > neverallows.conf <<EOF
>> neverallow user_t self:process signal;
>> EOF
>> $ sepolicy-analyze /etc/selinux/targeted/policy/policy.31 neverallow 
>> -f neverallows.conf
>>
>> There have been improvements to neverallow checking time upstream 
>> since RHEL 7, but it will still be a function of policy size and 
>> obviously RHEL has a much larger policy than Android...
> 
> For reference, on Fedora 29:
> 
> $ time sepolicy-analyze /etc/selinux/targeted/policy/policy.31 
> neverallow -n "neverallow user_t self:capability mac_admin;"
> 
> real    0m0.145s
> user    0m0.133s
> sys    0m0.012s

Also, you can put multiple neverallow statements (semicolon separated) 
in the -n option value and have them all checked at once, or similarly 
multiple ones in the file.
