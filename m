Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743DEC282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 18:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0272080D
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 18:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ArQvFmx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgAJSMO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:12:14 -0500
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:48216 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgAJSMO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 13:12:14 -0500
X-EEMSG-check-017: 71005584|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="71005584"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2020 18:12:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578679931; x=1610215931;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=eNa9OkfNdp4auckQNzOn2kNcJcFbyL41ugxCTuZIWoA=;
  b=ArQvFmx95ISvUsSBgHpP+Gs0NIe7SW+UiK+mTAe71mjlAShFVPZ7bgCN
   QdhIG3yuArDNp8TtV2oJrjGwVXOBzIQTUyFCHyXle3kGjl1+daZ9vW0Cu
   WlOdIY+8hcSsWCMmK02Mrh43JuIa9iPmfRFYy0DRf++GE3sEoQ6QFAfpx
   c5ozduieXuAedPADCC4nRYtFg+RWfLwsImXDfxmxJLfanQHnSCGkjziG7
   5ctTDQlpQdsTzsK3641E5zie0aBssH7wIZZmQHCSRaeWNnRU3j5g0hxuC
   PCgNi6PrRG+XTuyLqFgO4fwsTtDo0Bj71UrudwXoPX5nme6mQpoaIslQp
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="31824164"
IronPort-PHdr: =?us-ascii?q?9a23=3AOH6XfhxzSjXsncHXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoTLfad9pjvdHbS+e9qxAeQG9mCsLQe1bGd6vi8EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm7rAvcusYLjYd+Jas61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IAoBa6AAWhAv7kxD1ViX/sxaA0zu?=
 =?us-ascii?q?QvHx/I3AIjEdwBvnvbo9fpO6kdSu210KrFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4sTWFvvSY10LwGuZ?=
 =?us-ascii?q?ijcSkE0psn2wDQa+adf4SR+x7vTf2RLilki3J4YrK/hgqy8Ei4xu3zV8m0zF?=
 =?us-ascii?q?ZKrjdendXWqn8N0BnT586aQfV+5keswSuD2g/c5+1eIU04iLDXJ4Auz7IujJ?=
 =?us-ascii?q?YfrELOFTLslkrslq+ZbEAk9/Ct6+Tgf7rpuIeRN5RxigHiKqQundG/AfggPg?=
 =?us-ascii?q?gOQWeb/eO82aX//ULjWrVKj+A2krLDvJDbI8QbqKm5AxRL3Yk/8Rq/Ezen38?=
 =?us-ascii?q?gYnXkANl5Ffg6Ij5P1NF3UJfD4DPO/j0ytkDdt2f/GIqXsDojCI3XMirvsfa?=
 =?us-ascii?q?tx51RCxAc809xT/Y9YBqkEIP3pW0/xsNLYDgU+Mwyx2+vnE8hy1pgFVGKTAq?=
 =?us-ascii?q?6WLKPSsViS6uIpOOmDfpUZuDn6K/g7//Lul2M2mUcBfam12psacGi4Ee57I0?=
 =?us-ascii?q?Wdenfsms0OEXoOvgYnSezqj1qCUSRNaHqoQ6084TQ7Apq8DYjfXoCtnKCB3C?=
 =?us-ascii?q?CjE5JKaWBHC1eMEXH2eIWfQPoMZyWSIshukjwAS7ehTpUu1RCqtAPg17VnKe?=
 =?us-ascii?q?/U8DUCtZ3/zNh1+/HTlRYq+DxvEcud12CNT2dpnmIHXDI2wq9/rlJnyluZ0q?=
 =?us-ascii?q?h3neZYFdpN6PNNSAs6MoTcz+MpQ+z1DzrIY9PBbVGhWNjuVSk4U9YZ29YTZw?=
 =?us-ascii?q?N4HNK4g1bI2C/8R/c+l6aKH4A1+6Tr8ObtO912y3uOgKIunV4gT9BnOmqhia?=
 =?us-ascii?q?py8gHSA8jClEDPxIiwcqFJ5zLA7GeOyyK1uUhcVANhGfHeUWs3elrdrdO/4F?=
 =?us-ascii?q?jLCbCpF+J0YUN61ceeJ/4SOZXShlJcSaKmYY+Pbg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2B6BAAevRhe/wHyM5AZAUsdAQEBCQERBQUBgXsCgXuBG?=
 =?us-ascii?q?FQBIBIqhAmJA4ZlAQEBAQEBBoE3iW6RSAkBAQEBAQEBAQErDAEBg3tFAoIWO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshQsHJQyCOykBgnoBBSMPAQVBEAkCGAICJgICV?=
 =?us-ascii?q?wYBDAYCAQEXgkw/AYJKAwklD44igkCbdIEyhDQBg3ANY4E3BoEOKAGMMnmBB?=
 =?us-ascii?q?4ERJw+CXT6CG0kCgSwhgyaCXgSNMCCKGZdOgkGCSIRzjmwGG5pqjlqIWpQrI?=
 =?us-ascii?q?oFYKwgCGAghDzuCbFAYDY0ehT0Xg1CKcSMDMI5tgkMBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Jan 2020 18:12:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00AIBWVT134793;
        Fri, 10 Jan 2020 13:11:33 -0500
Subject: Re: [RFC PATCH] selinux: add policy capability for systemd overhaul
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
References: <20200110142038.21602-1-cgzones@googlemail.com>
 <CAHC9VhTm4Mv2=vy7-LVFnnVnNd87MajzN1imjSLcqx9H17uQqg@mail.gmail.com>
 <8426e416-cc8e-e054-aded-075cfc381057@tycho.nsa.gov>
 <03490eb6-ac2f-ce43-4534-fd7a25f89020@tycho.nsa.gov>
Message-ID: <0f0a3b90-583e-bae0-bc23-5ddf1d64924e@tycho.nsa.gov>
Date:   Fri, 10 Jan 2020 13:12:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <03490eb6-ac2f-ce43-4534-fd7a25f89020@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 1:03 PM, Stephen Smalley wrote:
> On 1/10/20 12:41 PM, Stephen Smalley wrote:
>> On 1/10/20 11:55 AM, Paul Moore wrote:
>>> On Fri, Jan 10, 2020 at 9:20 AM Christian Göttsche
>>> <cgzones@googlemail.com> wrote:
>>>> Support a SELinux overhaul of systemd by adding a policy capability.
>>>>
>>>> The systemd patch can be found at
>>>> https://github.com/systemd/systemd/pull/10023
>>>> and has NOT yet been accepted.
>>>>
>>>> This is just a rfc to test the water.
>>>> ---
>>>>   security/selinux/include/security.h | 1 +
>>>>   security/selinux/ss/services.c      | 3 ++-
>>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> Generally the SELinux policy capabilities are reserved for *kernel*
>>> changes that potentially break compatibility with existing SELinux
>>> policies.  I'm probably not the best person to talk about
>>> tricks/conventions used to do similar things in userspace, but you've
>>> come to the right place :)
>>
>> It was my suggestion to use policy capabilities for this.  There is no 
>> separate mechanism for supporting major changes to userspace SELinux 
>> permission checks in a backward-compatible manner.  Userspace already 
>> relies upon /sys/fs/selinux/{deny_unknown,reject_unknown} to get the 
>> handle_unknown setting from the kernel policy to decide how to handle 
>> unknown userspace classes/permissions.  That however is insufficient 
>> for these changes to systemd's permission check because they go beyond 
>> introducing new classes and permissions and overhaul the existing 
>> checks.  Policy capability seemed like the best way to do it, and 
>> getting it from the kernel is consistent with the fact that we are 
>> also getting the userspace classes/perms from the kernel via 
>> /sys/fs/selinux/class and the userspace access decisions from the 
>> kernel via /sys/fs/selinux/access (through the libselinux AVC, 
>> typically).
> 
> As to why we keep the userspace policy as part of the kernel policy and 
> not as a separate entity:
> 
> - It allows us to provide an effective atomicity in policy changes that 
> may span both kernel and userspace components,
> 
> - There is significant overlap between the contexts used in the kernel 
> and userspace policies, since most userspace policy enforcers are using 
> contexts obtained from the kernel for the subject (e.g. 
> SO_PEERSEC/getpeercon) or for the object (e.g. getfilecon),
> 
> - Policy lookups via /sys/fs/selinux/access are more efficient than 
> performing an IPC to a userspace security server.  Of course, in both 
> cases, we try to maximize use of the libselinux AVC first to avoid 
> needing to perform the policy lookup at all.
> 
> There were experiments done with introducing support for userspace 
> security server(s) for things like XACE/XSELinux and it was found to be 
> unsatisfying both performance and security-wise.
> 
> There are still cases where we would recommend userspace security 
> server(s), such as when the userspace component is implementing a policy 
> entirely distinct from that of the kernel (e.g. a remote document server 
> implementing RaDAC policies, as in one of our earlier experimental 
> research projects), but not for things like systemd.

All that said, I can see that we probably don't want a hardcoded 
reference to systemd in the kernel, since not everyone uses systemd ;) 
Perhaps what we need is for some range of policy capabilities to be 
user-defined, with generic names in the kernel and then userspace can 
choose to associate meaning with them.

This would be a bit easier if we implemented a solution to the 2nd part 
of https://github.com/SELinuxProject/selinux/issues/55, i.e. pass 
capabilities to the kernel as a list of uninterpreted string names 
rather than a bitmap.  Then the kernel only needs to recognize its own 
capability names and create selinuxfs nodes for all of them reflecting 
their policy values, but no hard-coded references to systemd required.

> 
>>
>>>
>>>> diff --git a/security/selinux/include/security.h 
>>>> b/security/selinux/include/security.h
>>>> index ecdd610e6449..2853e462977f 100644
>>>> --- a/security/selinux/include/security.h
>>>> +++ b/security/selinux/include/security.h
>>>> @@ -79,6 +79,7 @@ enum {
>>>>          POLICYDB_CAPABILITY_ALWAYSNETWORK,
>>>>          POLICYDB_CAPABILITY_CGROUPSECLABEL,
>>>>          POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
>>>> +       POLICYDB_CAPABILITY_SYSTEMD_OVERHAUL,
>>>>          __POLICYDB_CAPABILITY_MAX
>>>>   };
>>>>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>>>> diff --git a/security/selinux/ss/services.c 
>>>> b/security/selinux/ss/services.c
>>>> index 55cf42945cba..cb50e187b181 100644
>>>> --- a/security/selinux/ss/services.c
>>>> +++ b/security/selinux/ss/services.c
>>>> @@ -73,7 +73,8 @@ const char 
>>>> *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>>>>          "extended_socket_class",
>>>>          "always_check_network",
>>>>          "cgroup_seclabel",
>>>> -       "nnp_nosuid_transition"
>>>> +       "nnp_nosuid_transition",
>>>> +       "systemd_overhaul"
>>>>   };
>>>>
>>>>   static struct selinux_ss selinux_ss;
>>>> -- 
>>>> 2.24.1
>>>
>>
> 

