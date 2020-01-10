Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF44C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0432072A
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 18:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="oaT1nZPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgAJSxm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:53:42 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:41670 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbgAJSxl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 13:53:41 -0500
X-EEMSG-check-017: 43147028|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,418,1571702400"; 
   d="scan'208";a="43147028"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2020 18:53:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578682420; x=1610218420;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OACZPCqkFOAe5oY1wmOGHxqr8RNrxSYN+v8HqtxSojU=;
  b=oaT1nZPqNe0gCFyRZ5RxQZN4QCCd3GX2/YMlhQFy3xEA+adk9IpPTGho
   mOvHgWRuroznrDlSMIunYdgRDyD8e4qdTi/3tkLKmr4j7MbzooERjzwE5
   V5t5FCe/2qdrNjnHdcU/RolS0ENng1YLC812MLMggJVMqeFp9jDDsHmXq
   AcVdL0aeSuuH1UshnT7Aj3Mkogi6/MVj+JQMj6FDyO1d00Q1ZKTy3MB2U
   Lxg38gniKvn9B3Rm498ze7gY+qviOHBaQwVubS46CHjU8aepH8R7b+gD0
   7C7JLHBkJt9O01kAIvP4mcrj2donSgbGaDt2DIiN1lrEDe2p1Apc+8lNl
   A==;
X-IronPort-AV: E=Sophos;i="5.69,418,1571702400"; 
   d="scan'208";a="31826237"
IronPort-PHdr: =?us-ascii?q?9a23=3AnTWuoxeElsT6JP4sCvcR2e6SlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc26YRON2/xhgRfzUJnB7Loc0qyK6vumAzJbqs/Y6zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajIpsJ6o+1x?=
 =?us-ascii?q?fFv3VFcPlKyG11Il6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1Cu7izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0hEgEdwQvnTar9v7O6kdXu+30KbGwi7Ob+9V1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1uNtYzqISuV1uQTvGid8uFuSOevhHQjqwF1vDeuxtonh4?=
 =?us-ascii?q?7Sho0I0VDJ7jl5wYYpKt24T053e9ikEIBKuC2AOIt2Rd0iTnhutS0nxLMGvp?=
 =?us-ascii?q?u7czILyJQh3xPeZeaIc5SW7RL5TuqdOC50iGt+eL2hmxmy7FKgyuzgVsi0yF?=
 =?us-ascii?q?pKoStFksXMtnAQzBPf8NSISvx4/kqnxD2B1BjT5/lZLU07mqfXMZ4szqMqmp?=
 =?us-ascii?q?YNvknPADX6lFjwgaSLbEsr4PKo5P7iYrj+o5+cMJJ7hR/mP6Q1n8y/Hfw4Mg?=
 =?us-ascii?q?8TX2iH4ei81KPs/Un+QLhSkv05iLPZsJHHJcQAvKK5AglV0ogk6xakETipzM?=
 =?us-ascii?q?4UnWUHLV1ZeBKHiJLlO1fSL/DjEfizmVGskDZvx/zeP73hBIvCLmTbnbv8cr?=
 =?us-ascii?q?tw5FRQxQouwdxF+Z5ZBa8NLOjuVkPpsdzXFB45Mwi6w+b9D9V905sTWXmSDa?=
 =?us-ascii?q?+CK67SrV+J6f4vI+mLfoMVvi39JOI/6/7hin85h0cRfbO10psPdHC4AvNmLl?=
 =?us-ascii?q?2BYXX2n9cBFXwHvhIkQ+z3jF2OSDtTZ3G1X6Im+D43Ep6pDYDGRoq1mryOwD?=
 =?us-ascii?q?+7HoFKZmBBEl2DDXjodoSDW/cKdi2SOdRskjMDVbimRI8h0Q+htArgxLpmKu?=
 =?us-ascii?q?rY4DEXtZXm1NJt/e3ciQky9SBoD8Say2yNVH97nmcJRz8wwaB+rldwykmM0a?=
 =?us-ascii?q?dmmfxUD99T6O1TUgc8K5Hcy/Z2C9foWgLOLZ+1TwOeS8iiSRQ2Scg8i4sWal?=
 =?us-ascii?q?t5M82rkxSG2i2tGbJTnLuOUth82aLG3mPtJs97/FlYyLU6hFkrCp9EOn+hgK?=
 =?us-ascii?q?Nk3wfUAIHNnkCQlqLsfqMZin3j7mCGmFGSsVlYXQg4aqDMWXQSdwOCttjizl?=
 =?us-ascii?q?/TRL+pT7I8O01OztDUefgCUcHgkVgTHKSrA9/ZeW/k3j7rVBs=3D?=
X-IPAS-Result: =?us-ascii?q?A2B+BACnxxhe/wHyM5AZAUsdAQEBCQERBQUBgXsCgXuBG?=
 =?us-ascii?q?FQBIBIqhAmJA4ZlAQEBAQEBBoE3iW6RSAkBAQEBAQEBAQErDAEBg3tFAoIWO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshQsHJQyCOykBgnkBAQEBAgEjDwEFQRAJAhgCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBF4JMPwGCSgMJBSAPjjeCP5p/dYEyhDQBg2cNY4E3BoEOK?=
 =?us-ascii?q?AGMMnmBB4ERJw+CXT6CG0kCgSwhgyaCXgSNMCCKGZdOgkGCSIRzjmwGG5pqj?=
 =?us-ascii?q?lqIWpQrIoFYKwgCGAghDzuCbFAYDY0ehT0Xg1CKcSMDMI5tgkMBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Jan 2020 18:53:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00AIqxSS153826;
        Fri, 10 Jan 2020 13:52:59 -0500
Subject: Re: [RFC PATCH] selinux: add policy capability for systemd overhaul
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
References: <20200110142038.21602-1-cgzones@googlemail.com>
 <CAHC9VhTm4Mv2=vy7-LVFnnVnNd87MajzN1imjSLcqx9H17uQqg@mail.gmail.com>
 <8426e416-cc8e-e054-aded-075cfc381057@tycho.nsa.gov>
 <03490eb6-ac2f-ce43-4534-fd7a25f89020@tycho.nsa.gov>
 <0f0a3b90-583e-bae0-bc23-5ddf1d64924e@tycho.nsa.gov>
Message-ID: <514a7fd5-a61e-be09-ceee-d06cb3bebe02@tycho.nsa.gov>
Date:   Fri, 10 Jan 2020 13:54:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <0f0a3b90-583e-bae0-bc23-5ddf1d64924e@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 1:12 PM, Stephen Smalley wrote:
> On 1/10/20 1:03 PM, Stephen Smalley wrote:
>> On 1/10/20 12:41 PM, Stephen Smalley wrote:
>>> On 1/10/20 11:55 AM, Paul Moore wrote:
>>>> On Fri, Jan 10, 2020 at 9:20 AM Christian Göttsche
>>>> <cgzones@googlemail.com> wrote:
>>>>> Support a SELinux overhaul of systemd by adding a policy capability.
>>>>>
>>>>> The systemd patch can be found at
>>>>> https://github.com/systemd/systemd/pull/10023
>>>>> and has NOT yet been accepted.
>>>>>
>>>>> This is just a rfc to test the water.
>>>>> ---
>>>>>   security/selinux/include/security.h | 1 +
>>>>>   security/selinux/ss/services.c      | 3 ++-
>>>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> Generally the SELinux policy capabilities are reserved for *kernel*
>>>> changes that potentially break compatibility with existing SELinux
>>>> policies.  I'm probably not the best person to talk about
>>>> tricks/conventions used to do similar things in userspace, but you've
>>>> come to the right place :)
>>>
>>> It was my suggestion to use policy capabilities for this.  There is 
>>> no separate mechanism for supporting major changes to userspace 
>>> SELinux permission checks in a backward-compatible manner.  Userspace 
>>> already relies upon /sys/fs/selinux/{deny_unknown,reject_unknown} to 
>>> get the handle_unknown setting from the kernel policy to decide how 
>>> to handle unknown userspace classes/permissions.  That however is 
>>> insufficient for these changes to systemd's permission check because 
>>> they go beyond introducing new classes and permissions and overhaul 
>>> the existing checks.  Policy capability seemed like the best way to 
>>> do it, and getting it from the kernel is consistent with the fact 
>>> that we are also getting the userspace classes/perms from the kernel 
>>> via /sys/fs/selinux/class and the userspace access decisions from the 
>>> kernel via /sys/fs/selinux/access (through the libselinux AVC, 
>>> typically).
>>
>> As to why we keep the userspace policy as part of the kernel policy 
>> and not as a separate entity:
>>
>> - It allows us to provide an effective atomicity in policy changes 
>> that may span both kernel and userspace components,
>>
>> - There is significant overlap between the contexts used in the kernel 
>> and userspace policies, since most userspace policy enforcers are 
>> using contexts obtained from the kernel for the subject (e.g. 
>> SO_PEERSEC/getpeercon) or for the object (e.g. getfilecon),
>>
>> - Policy lookups via /sys/fs/selinux/access are more efficient than 
>> performing an IPC to a userspace security server.  Of course, in both 
>> cases, we try to maximize use of the libselinux AVC first to avoid 
>> needing to perform the policy lookup at all.
>>
>> There were experiments done with introducing support for userspace 
>> security server(s) for things like XACE/XSELinux and it was found to 
>> be unsatisfying both performance and security-wise.
>>
>> There are still cases where we would recommend userspace security 
>> server(s), such as when the userspace component is implementing a 
>> policy entirely distinct from that of the kernel (e.g. a remote 
>> document server implementing RaDAC policies, as in one of our earlier 
>> experimental research projects), but not for things like systemd.
> 
> All that said, I can see that we probably don't want a hardcoded 
> reference to systemd in the kernel, since not everyone uses systemd ;) 
> Perhaps what we need is for some range of policy capabilities to be 
> user-defined, with generic names in the kernel and then userspace can 
> choose to associate meaning with them.
> 
> This would be a bit easier if we implemented a solution to the 2nd part 
> of https://github.com/SELinuxProject/selinux/issues/55, i.e. pass 
> capabilities to the kernel as a list of uninterpreted string names 
> rather than a bitmap.  Then the kernel only needs to recognize its own 
> capability names and create selinuxfs nodes for all of them reflecting 
> their policy values, but no hard-coded references to systemd required.

Actually, given that Christian is proposing defining entirely new 
classes for the new checks in systemd, maybe we don't need a policy 
capability at all?  systemd can just check whether its new classes are 
defined and use that as the indicator of whether the policy support the 
new checks?

> 
>>
>>>
>>>>
>>>>> diff --git a/security/selinux/include/security.h 
>>>>> b/security/selinux/include/security.h
>>>>> index ecdd610e6449..2853e462977f 100644
>>>>> --- a/security/selinux/include/security.h
>>>>> +++ b/security/selinux/include/security.h
>>>>> @@ -79,6 +79,7 @@ enum {
>>>>>          POLICYDB_CAPABILITY_ALWAYSNETWORK,
>>>>>          POLICYDB_CAPABILITY_CGROUPSECLABEL,
>>>>>          POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
>>>>> +       POLICYDB_CAPABILITY_SYSTEMD_OVERHAUL,
>>>>>          __POLICYDB_CAPABILITY_MAX
>>>>>   };
>>>>>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>>>>> diff --git a/security/selinux/ss/services.c 
>>>>> b/security/selinux/ss/services.c
>>>>> index 55cf42945cba..cb50e187b181 100644
>>>>> --- a/security/selinux/ss/services.c
>>>>> +++ b/security/selinux/ss/services.c
>>>>> @@ -73,7 +73,8 @@ const char 
>>>>> *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>>>>>          "extended_socket_class",
>>>>>          "always_check_network",
>>>>>          "cgroup_seclabel",
>>>>> -       "nnp_nosuid_transition"
>>>>> +       "nnp_nosuid_transition",
>>>>> +       "systemd_overhaul"
>>>>>   };
>>>>>
>>>>>   static struct selinux_ss selinux_ss;
>>>>> -- 
>>>>> 2.24.1
>>>>
>>>
>>
> 

