Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0381C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 18:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57832072E
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 18:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="UZhEZXti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgAJSF1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:05:27 -0500
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:51781 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgAJSF1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 13:05:27 -0500
X-EEMSG-check-017: 70770547|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="70770547"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2020 18:03:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578679396; x=1610215396;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=LMIC/QMk3NXWhaq4QTpBacWH92DPSbkFBetyYJ1ANNM=;
  b=UZhEZXtiu87+5UWNiOL9UXOQS0AkK/axRt06/T5qWzz0qIHVDq/fkUjw
   FpaJSNB5qOuL7zCMv66gWC/WOI+X11cmTYMJqI/M+rUXYerHxl8plt5xO
   wSq70moTmcDzXjmvq0jjPvA2hA9Spc6stRtL7mR75Q/n8923i8TH7A7is
   0gmIaL9TBH7UG9lIHtleT4heuwdxT4z80iq7wv87VeDeS+YmZ+G9PHkCv
   TTrNyvCHnjKXSEN9d+P672xUaIUmduYc/1KfAm3uA4j+87pTG/zGf/k9H
   2Wh73eKgdbVC3jKVTktUHbxM1p1OXEigAWMGYpKlyJN7bcU5pjH2OJf1Q
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="37627342"
IronPort-PHdr: =?us-ascii?q?9a23=3Arqfpzx1LpQ8mdO3WsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWL/vxwZ3uMQTl6Ol3ixeRBMOHsqkC0bSN+Pm4AyQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngu6oATfu8UZnIduNrg9wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXoxazAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?khHw/Y0gwuHNwAv3rbo9r3KKgcXvu4zLXLwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEcyCwPKkE2QqYz7MDOTy+8Drm2b4PBkVeKrlWEmqxx6rz+0xsgxkY?=
 =?us-ascii?q?nEnZ4Vy1DY+iV5x4Y5P9u4SFVhbtK+H5tQsD+aOpJwT8g/TW9ovyM6xacHuZ?=
 =?us-ascii?q?69ZCULxo4oxwLBZPydaYSE+wvvWP+KIThmmH1lZai/hxeu8Umg0uH8Wci00E?=
 =?us-ascii?q?pKripYidbArGwC1xvW6sWBV/Bz/V+h1C6S2w3c5exIO0A5mbfBJ5I/zbM8iI?=
 =?us-ascii?q?AfvVnFEyTrgkv5lrWWeV8h+uWw7uTnZajpqYGEOo9vjwH+LrwumsuiAeQkKg?=
 =?us-ascii?q?QOX3aU+eC71LD74U32Wq9KjvwrkqnCqpzaJMIbpqC+Aw9OzIks9wyzDyum0d?=
 =?us-ascii?q?sEnXkHK0hJeBSbgIjyJ17COvX4Dfa7g1i0kTdrwe7JPqH5D5nQIXXOn63tcL?=
 =?us-ascii?q?Zg50JG1gY+ws5T64hJBr0ZJfL8QE7xtNjWDh8jNAy0xv7qCM5g2YMFQm+PHq?=
 =?us-ascii?q?+YP7/SsV+P/O4vJfKMa5UPtDbyLPgl+ebijWUlll8FYampwZwXZWigHvt8Pk?=
 =?us-ascii?q?WZZWHhgs8bHmcXugoyVenqiFqFUT5JeXm+Rb4z5jY+CIi+F4fMWpitgKCd3C?=
 =?us-ascii?q?e8BpBZem9GC1GLEXfuaYqEQOwBaC2VIs9mnTwEUaauS4o72hGvsA/20aZoLu?=
 =?us-ascii?q?3R+icAr5LsyMB15/HPlRE17TF0FNqS02WMT2Fyg2MJSCQ73L5woUNj0FePy6?=
 =?us-ascii?q?t4jOJCFdxV+fxJVh02NZnGz+x1WJjOXVf5d8qNAHOhRc+rSWUpR88168cHfk?=
 =?us-ascii?q?I4HtKllB2F1C2vVftdvLyRBYco86va6FdvO9pmwHbLnP0qgEshRMZUHWKhga?=
 =?us-ascii?q?F7+g3aBoqPmEKcwfWEb6MZiRXR+X+DwGzGh0RRVAp9QO2RRnwETlfHptT+oE?=
 =?us-ascii?q?XZRvmhDqpxYVgJ8tKLNqYfMo6htl5BXvq2fY2FMm8=3D?=
X-IPAS-Result: =?us-ascii?q?A2CuAACZuxhe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gRhUASASKoQJiQOGZQEBAQEBAQaBEiWJbpFICQEBAQEBAQEBASsMA?=
 =?us-ascii?q?QGEQAKCFjcGDgIQAQEBBAEBAQEBBQMBAWyFCwclDII7KQGCegEFIw8BBUEQC?=
 =?us-ascii?q?QIYAgImAgJXBgEMBgIBAYJjPwGCSgMJJQ+QXpt0gTKENAGDcA1jgTcGgQ4oA?=
 =?us-ascii?q?YwyeYEHgREnDAOCXT6CG0kCgSwhgyaCXgSNMCCKGZdOgkGCSIRzjmwGG5pqj?=
 =?us-ascii?q?lqIWpQqI4FYKwgCGAghD4MnUBgNjR6JJIpxIwMwjm2CQwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Jan 2020 18:03:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00AI2Uku125482;
        Fri, 10 Jan 2020 13:02:39 -0500
Subject: Re: [RFC PATCH] selinux: add policy capability for systemd overhaul
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
References: <20200110142038.21602-1-cgzones@googlemail.com>
 <CAHC9VhTm4Mv2=vy7-LVFnnVnNd87MajzN1imjSLcqx9H17uQqg@mail.gmail.com>
 <8426e416-cc8e-e054-aded-075cfc381057@tycho.nsa.gov>
Message-ID: <03490eb6-ac2f-ce43-4534-fd7a25f89020@tycho.nsa.gov>
Date:   Fri, 10 Jan 2020 13:03:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <8426e416-cc8e-e054-aded-075cfc381057@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 12:41 PM, Stephen Smalley wrote:
> On 1/10/20 11:55 AM, Paul Moore wrote:
>> On Fri, Jan 10, 2020 at 9:20 AM Christian Göttsche
>> <cgzones@googlemail.com> wrote:
>>> Support a SELinux overhaul of systemd by adding a policy capability.
>>>
>>> The systemd patch can be found at
>>> https://github.com/systemd/systemd/pull/10023
>>> and has NOT yet been accepted.
>>>
>>> This is just a rfc to test the water.
>>> ---
>>>   security/selinux/include/security.h | 1 +
>>>   security/selinux/ss/services.c      | 3 ++-
>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> Generally the SELinux policy capabilities are reserved for *kernel*
>> changes that potentially break compatibility with existing SELinux
>> policies.  I'm probably not the best person to talk about
>> tricks/conventions used to do similar things in userspace, but you've
>> come to the right place :)
> 
> It was my suggestion to use policy capabilities for this.  There is no 
> separate mechanism for supporting major changes to userspace SELinux 
> permission checks in a backward-compatible manner.  Userspace already 
> relies upon /sys/fs/selinux/{deny_unknown,reject_unknown} to get the 
> handle_unknown setting from the kernel policy to decide how to handle 
> unknown userspace classes/permissions.  That however is insufficient for 
> these changes to systemd's permission check because they go beyond 
> introducing new classes and permissions and overhaul the existing 
> checks.  Policy capability seemed like the best way to do it, and 
> getting it from the kernel is consistent with the fact that we are also 
> getting the userspace classes/perms from the kernel via 
> /sys/fs/selinux/class and the userspace access decisions from the kernel 
> via /sys/fs/selinux/access (through the libselinux AVC, typically).

As to why we keep the userspace policy as part of the kernel policy and 
not as a separate entity:

- It allows us to provide an effective atomicity in policy changes that 
may span both kernel and userspace components,

- There is significant overlap between the contexts used in the kernel 
and userspace policies, since most userspace policy enforcers are using 
contexts obtained from the kernel for the subject (e.g. 
SO_PEERSEC/getpeercon) or for the object (e.g. getfilecon),

- Policy lookups via /sys/fs/selinux/access are more efficient than 
performing an IPC to a userspace security server.  Of course, in both 
cases, we try to maximize use of the libselinux AVC first to avoid 
needing to perform the policy lookup at all.

There were experiments done with introducing support for userspace 
security server(s) for things like XACE/XSELinux and it was found to be 
unsatisfying both performance and security-wise.

There are still cases where we would recommend userspace security 
server(s), such as when the userspace component is implementing a policy 
entirely distinct from that of the kernel (e.g. a remote document server 
implementing RaDAC policies, as in one of our earlier experimental 
research projects), but not for things like systemd.

> 
>>
>>> diff --git a/security/selinux/include/security.h 
>>> b/security/selinux/include/security.h
>>> index ecdd610e6449..2853e462977f 100644
>>> --- a/security/selinux/include/security.h
>>> +++ b/security/selinux/include/security.h
>>> @@ -79,6 +79,7 @@ enum {
>>>          POLICYDB_CAPABILITY_ALWAYSNETWORK,
>>>          POLICYDB_CAPABILITY_CGROUPSECLABEL,
>>>          POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
>>> +       POLICYDB_CAPABILITY_SYSTEMD_OVERHAUL,
>>>          __POLICYDB_CAPABILITY_MAX
>>>   };
>>>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>>> diff --git a/security/selinux/ss/services.c 
>>> b/security/selinux/ss/services.c
>>> index 55cf42945cba..cb50e187b181 100644
>>> --- a/security/selinux/ss/services.c
>>> +++ b/security/selinux/ss/services.c
>>> @@ -73,7 +73,8 @@ const char 
>>> *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>>>          "extended_socket_class",
>>>          "always_check_network",
>>>          "cgroup_seclabel",
>>> -       "nnp_nosuid_transition"
>>> +       "nnp_nosuid_transition",
>>> +       "systemd_overhaul"
>>>   };
>>>
>>>   static struct selinux_ss selinux_ss;
>>> -- 
>>> 2.24.1
>>
> 

