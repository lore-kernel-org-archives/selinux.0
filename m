Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4010C33CA3
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 19:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF17206DA
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 19:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="kXV2M56e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgAJTwZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:52:25 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:58168 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgAJTwZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 14:52:25 -0500
X-EEMSG-check-017: 68232196|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,418,1571702400"; 
   d="scan'208";a="68232196"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2020 19:52:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578685943; x=1610221943;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vLaK5ANUDxRv1HrhPh7T5LOKgsoDPO/KaBLwO7WYGP4=;
  b=kXV2M56eBHZWZ3RglqTW1h/GFAMJlmD22I4fBfsovloVfKPjyBJEORBs
   pXhper7ViWmF2sOpxm9+GLwcnkXg7lI9FVfycDnzHiKVkGlv036p+USh0
   uQQOZrE4BZt/gj6JWcH3l//xMr+jEFNxpCE1dfz6xkDX7ltMQX9nP6b19
   KyLODbYokdBl20tXM9f8zhWeR6M1gdFUSXu6YUUB3EPG//S/JEOmm2da1
   vgJwCkzVtKDJxCHM8ieGvSDiWtXQjeS14uIUj048JbQeRpXd3780GcfHo
   ThQ5bE2Ojcav1lAhQBNg3hY590NFm2WSX40A2N6rOPbLrmASVdVbvXuOn
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,418,1571702400"; 
   d="scan'208";a="37633881"
IronPort-PHdr: =?us-ascii?q?9a23=3ArlqFTBT7t3XDV40NPggBZJyDsNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZBGAt8tkgFKBZ4jH8fUM07OQ7/m7HzZeut3Y6ixKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMIjYZjJKs9xQ?=
 =?us-ascii?q?bFrmVHdu9L2W5mOFWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl9d9h7xHrh2/uxN/wpbUYICLO/p4YqPdZs4RSW?=
 =?us-ascii?q?5YUspMSyBNHoawYo0BAOobOeZTspfzqV0AoxCjAQWgHe3ixztNinLwwKY00f?=
 =?us-ascii?q?kuERve0QI9H9wArnrUotb7OqgcXu+6zrXHwzrYYvNK2jrw8pTEfgwvrPyOW7?=
 =?us-ascii?q?97bMrfyVMoFwPAllietJDlMC2N1uQNrWeb6fdrW/+qi2E9rwFxpiagx8cxgY?=
 =?us-ascii?q?TOnYIa10vE+D5lwIc1OdK4SEl7bcSiEJtLrS6WLYR2QsQ8Q2xxvisx17MIuZ?=
 =?us-ascii?q?m+fCcQyZQnwQbSavKdfIiU/B3jTvydLS5hiH58Y7KwmQq98VW6yu39Ssm10E?=
 =?us-ascii?q?5GriVEktnQtnANygfc5tKbRft6+0es3yuE2QPL6uxcPEw5mqXWJ4Qhz7ItjJ?=
 =?us-ascii?q?Yfr0vOEjHslEnriqKda18q9fKy6+v9Z7XrvpqcN4hphQ7gKqkugcm/AfggMg?=
 =?us-ascii?q?gJQmib5fyw1L398k39R7VHluE2nbPDsJDbOMQbvbS1Aw5T0oYt7Ba/FCmp38?=
 =?us-ascii?q?gCkXkbLFNKZBKHj4/zN1HIPP/4Fuuwj06pkDdqw/DKJrzhApPTIXjfiLrtYL?=
 =?us-ascii?q?lw5kFGxAcz0NxT/YxYB74fLP7pR0P9rNnYAQU4MwywzebnEtJ91oYGVGKUH6?=
 =?us-ascii?q?CZK7jfsUOI5+0zI+mMY5UZuDDmK/c//fLugng5mUEFcamzwZQXcGy4HuhhI0?=
 =?us-ascii?q?iBeXrjmMoBEWMRswomVuPqlVmCXSdWZ3a1WKI8/C80BJi6AofEQ4CnmKaB0z?=
 =?us-ascii?q?ujHp1KemBGDUiBHmvnd4SFXPcMbjydItR6nzwLUrihTIAh1RWwuw//0bVnL+?=
 =?us-ascii?q?7U9jcEupLk0dh///fTmg0q9TxoE8Sd1HmAT3pqkWMMRj822r1/oENmx1ed3q?=
 =?us-ascii?q?h3neZYGcZQ5/xXSAc6M4DTz+hgB9D1QALBcYTBdFHzety7BXkUSdUrzpdae0?=
 =?us-ascii?q?9gH/26hw3Hmi+tBKUY0beMAcpwuoncxXnqO8d0zUHpSrU9lFImT4MbPmK0ga?=
 =?us-ascii?q?hy7CDcAInGl0icnqeuM68b2Xie2n2EyD+1oExAUAN2GZ7AVHQba1qe+c/1/W?=
 =?us-ascii?q?veXrSuDvIhKQIHxsmcfPgZIub1hElLEa+wcO/VZHi8ziLpXkeF?=
X-IPAS-Result: =?us-ascii?q?A2AJAQBw1Rhe/wHyM5AZAUsdAQEBCQERBQUBgWoFAQsBA?=
 =?us-ascii?q?YF7gRhVIBIqhAyJA4ZrBoESJYlukUgJAQEBAQEBAQEBKwwBAYN7RQKCFjcGD?=
 =?us-ascii?q?gIQAQEBBAEBAQEBBQMBAWyFCwclDII7KQGCegEFIw8BBUEQCQIYAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAReCTD8BgkoDCSUPjkKCN5t0gTKENAGDXw1jgTcGgQ4oAYwyeYEHg?=
 =?us-ascii?q?REnDAOCXT6CG0kCgSwhgyaCXgSNMCCKGZdOgkGCSIRzjmwGG4JHmCOOWoFJh?=
 =?us-ascii?q?xGUKiOBWCsIAhgIIQ87gmxQGA2NHoU9F4NQinEjAzCOYIJDAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Jan 2020 19:52:20 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00AJph0r184861;
        Fri, 10 Jan 2020 14:51:43 -0500
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
 <514a7fd5-a61e-be09-ceee-d06cb3bebe02@tycho.nsa.gov>
Message-ID: <ea048da0-ec4a-9242-54ad-9760215f6219@tycho.nsa.gov>
Date:   Fri, 10 Jan 2020 14:53:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <514a7fd5-a61e-be09-ceee-d06cb3bebe02@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 1:54 PM, Stephen Smalley wrote:
> On 1/10/20 1:12 PM, Stephen Smalley wrote:
>> On 1/10/20 1:03 PM, Stephen Smalley wrote:
>>> On 1/10/20 12:41 PM, Stephen Smalley wrote:
>>>> On 1/10/20 11:55 AM, Paul Moore wrote:
>>>>> On Fri, Jan 10, 2020 at 9:20 AM Christian Göttsche
>>>>> <cgzones@googlemail.com> wrote:
>>>>>> Support a SELinux overhaul of systemd by adding a policy capability.
>>>>>>
>>>>>> The systemd patch can be found at
>>>>>> https://github.com/systemd/systemd/pull/10023
>>>>>> and has NOT yet been accepted.
>>>>>>
>>>>>> This is just a rfc to test the water.
>>>>>> ---
>>>>>>   security/selinux/include/security.h | 1 +
>>>>>>   security/selinux/ss/services.c      | 3 ++-
>>>>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> Generally the SELinux policy capabilities are reserved for *kernel*
>>>>> changes that potentially break compatibility with existing SELinux
>>>>> policies.  I'm probably not the best person to talk about
>>>>> tricks/conventions used to do similar things in userspace, but you've
>>>>> come to the right place :)
>>>>
>>>> It was my suggestion to use policy capabilities for this.  There is 
>>>> no separate mechanism for supporting major changes to userspace 
>>>> SELinux permission checks in a backward-compatible manner.  
>>>> Userspace already relies upon 
>>>> /sys/fs/selinux/{deny_unknown,reject_unknown} to get the 
>>>> handle_unknown setting from the kernel policy to decide how to 
>>>> handle unknown userspace classes/permissions.  That however is 
>>>> insufficient for these changes to systemd's permission check because 
>>>> they go beyond introducing new classes and permissions and overhaul 
>>>> the existing checks.  Policy capability seemed like the best way to 
>>>> do it, and getting it from the kernel is consistent with the fact 
>>>> that we are also getting the userspace classes/perms from the kernel 
>>>> via /sys/fs/selinux/class and the userspace access decisions from 
>>>> the kernel via /sys/fs/selinux/access (through the libselinux AVC, 
>>>> typically).
>>>
>>> As to why we keep the userspace policy as part of the kernel policy 
>>> and not as a separate entity:
>>>
>>> - It allows us to provide an effective atomicity in policy changes 
>>> that may span both kernel and userspace components,
>>>
>>> - There is significant overlap between the contexts used in the 
>>> kernel and userspace policies, since most userspace policy enforcers 
>>> are using contexts obtained from the kernel for the subject (e.g. 
>>> SO_PEERSEC/getpeercon) or for the object (e.g. getfilecon),
>>>
>>> - Policy lookups via /sys/fs/selinux/access are more efficient than 
>>> performing an IPC to a userspace security server.  Of course, in both 
>>> cases, we try to maximize use of the libselinux AVC first to avoid 
>>> needing to perform the policy lookup at all.
>>>
>>> There were experiments done with introducing support for userspace 
>>> security server(s) for things like XACE/XSELinux and it was found to 
>>> be unsatisfying both performance and security-wise.
>>>
>>> There are still cases where we would recommend userspace security 
>>> server(s), such as when the userspace component is implementing a 
>>> policy entirely distinct from that of the kernel (e.g. a remote 
>>> document server implementing RaDAC policies, as in one of our earlier 
>>> experimental research projects), but not for things like systemd.
>>
>> All that said, I can see that we probably don't want a hardcoded 
>> reference to systemd in the kernel, since not everyone uses systemd ;) 
>> Perhaps what we need is for some range of policy capabilities to be 
>> user-defined, with generic names in the kernel and then userspace can 
>> choose to associate meaning with them.
>>
>> This would be a bit easier if we implemented a solution to the 2nd 
>> part of https://github.com/SELinuxProject/selinux/issues/55, i.e. pass 
>> capabilities to the kernel as a list of uninterpreted string names 
>> rather than a bitmap.  Then the kernel only needs to recognize its own 
>> capability names and create selinuxfs nodes for all of them reflecting 
>> their policy values, but no hard-coded references to systemd required.
> 
> Actually, given that Christian is proposing defining entirely new 
> classes for the new checks in systemd, maybe we don't need a policy 
> capability at all?  systemd can just check whether its new classes are 
> defined and use that as the indicator of whether the policy support the 
> new checks?

And this can be done via the existing libselinux 
string_to_security_class() interface, already used by systemd elsewhere. 
  Just test for a zero return value to indicate not-defined.

NB On a policy update/reload, the class might become defined without 
necessarily restarting systemd.  So you may need to set a 
SELINUX_CB_POLICYLOAD callback and recheck whether it has become defined 
there.

> 
>>
>>>
>>>>
>>>>>
>>>>>> diff --git a/security/selinux/include/security.h 
>>>>>> b/security/selinux/include/security.h
>>>>>> index ecdd610e6449..2853e462977f 100644
>>>>>> --- a/security/selinux/include/security.h
>>>>>> +++ b/security/selinux/include/security.h
>>>>>> @@ -79,6 +79,7 @@ enum {
>>>>>>          POLICYDB_CAPABILITY_ALWAYSNETWORK,
>>>>>>          POLICYDB_CAPABILITY_CGROUPSECLABEL,
>>>>>>          POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
>>>>>> +       POLICYDB_CAPABILITY_SYSTEMD_OVERHAUL,
>>>>>>          __POLICYDB_CAPABILITY_MAX
>>>>>>   };
>>>>>>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>>>>>> diff --git a/security/selinux/ss/services.c 
>>>>>> b/security/selinux/ss/services.c
>>>>>> index 55cf42945cba..cb50e187b181 100644
>>>>>> --- a/security/selinux/ss/services.c
>>>>>> +++ b/security/selinux/ss/services.c
>>>>>> @@ -73,7 +73,8 @@ const char 
>>>>>> *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>>>>>>          "extended_socket_class",
>>>>>>          "always_check_network",
>>>>>>          "cgroup_seclabel",
>>>>>> -       "nnp_nosuid_transition"
>>>>>> +       "nnp_nosuid_transition",
>>>>>> +       "systemd_overhaul"
>>>>>>   };
>>>>>>
>>>>>>   static struct selinux_ss selinux_ss;
>>>>>> -- 
>>>>>> 2.24.1
>>>>>
>>>>
>>>
>>
> 

