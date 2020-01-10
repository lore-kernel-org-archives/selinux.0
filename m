Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93883C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 17:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D52B206ED
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 17:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="hPp2byot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAJRkw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:40:52 -0500
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:6652 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgAJRkv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 12:40:51 -0500
X-EEMSG-check-017: 68102404|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="68102404"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2020 17:40:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578678051; x=1610214051;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jG4I+UxCXqmhy/M+gOW/VbWVn0suilaoBZS+POP2m24=;
  b=hPp2byotZ1KOUlLyjx+S8ZsG8QW7PSv32V3rGYdcGmzMlr23WfN9TmYa
   onXUhKEB8dywwog+JuKUVI//hefAtTXTG3l5OJuAraTR9ZPceUCosvTOm
   8Ofd0s/RiVQ46+5FS17jKF5xChkwyWJfQRsdcEINUT9ssD0//VYCJh9Mi
   cOfFLitXu4MNTxtwUI4JBwomrAxDodJkjFQmtv4K1hfaW2vkAyotPRrb5
   wIrsYtCdVMaWoubfv4haW+yXER/lXeG/GQy12aIj9CEQZ6ykqUqlf6bRL
   yjGZYyhv4nXqJzNaEDRYBYTgx3et7afRnSfz88dBQW6odGZztnGWpOenc
   w==;
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="37625633"
IronPort-PHdr: =?us-ascii?q?9a23=3AfLGuMxbIHKMFIoxCF/bzF/3/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsy/YB7h7PlgxGXEQZ/co6odzbaP6Oa6BzdLsMbJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusQXj4ZuJaI8xx?=
 =?us-ascii?q?jUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezCw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjAdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmtiE6yrgctp?=
 =?us-ascii?q?66eigH0JomyATDa/OZaYiE+AvvWP+ILTdjmn1qZK+/hwyz8Ui8yuzwTsa00F?=
 =?us-ascii?q?dWripFj9nDrWoB2ADU6siCTPZ240Sv2S6X2gzO5exJLlo4mKrGJ5I73LI9mY?=
 =?us-ascii?q?QfvV7eEiLwhU74lrWZdl8+9eit8+nnZ7LmqYKCOIJskQH+N7gumtS4AeQlLg?=
 =?us-ascii?q?gCR2ib9vq41L3k5UD5XK9Fjuc3kqnEq5DWP8Ubpqi3Aw9SyYYs9QqwAy260N?=
 =?us-ascii?q?UYgXYHLFVFdAiBj4f1IFHBPOr0DfK+g1SoiDtrxvbGMaP9ApjVM3TOn7jsca?=
 =?us-ascii?q?x95kJB0gY/099S64xOBr0cOP7zX1X+tN3cDh83KQy0xOPnBc1m1owDQmKCGb?=
 =?us-ascii?q?OZMaPOvl+I4eIjOe+MZJQPtzrnJPgl4ODugWcjmVABZampwYcXaHegE/R+OU?=
 =?us-ascii?q?qZfH7sj8wZEWgQowo+SPXmiFiFUT5UfXa9Qbgw6S08CIKjFY3DXJyigKSd3C?=
 =?us-ascii?q?enGZ1bfnxJCl+NEHfvcYWLRewMZTmdIs9mlTwEWryhRJEk1R60tQ/6z6BrIf?=
 =?us-ascii?q?bT+i0drZjjzsR65/XPlREu8jx5F9+d3H+JT2F1mGMIWjA30bthoUxy1FiDy7?=
 =?us-ascii?q?J0g/9GGtxJ4fNGTAM6OYTbz+xgBNChEj7GK++AVVLuZ9KhGzx5Gso43tsme0?=
 =?us-ascii?q?9gH5CniRfZ0myhBLpD0/SgBIY16b7d1n7GCFhh123N1KRp21IpUMxJOHaOia?=
 =?us-ascii?q?l4+AzeAofIlwOSkKP8JooG2yuYz3uO1WqDugljVQd0VajUFSQEalD+scXy5k?=
 =?us-ascii?q?SESaSnT7sgLF0Smoa5NqJWZ4ix3h19T/D5NYGbOjnglg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CtAAC5thhe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gRhUASASKoQJiQOGZQEBAQEBAQaBN4lukUgJAQEBAQEBAQEBKwwBA?=
 =?us-ascii?q?YRAAoIWNwYOAhABAQEEAQEBAQEFAwEBbIU3DII7KQGCeQEBAQECASMPAQVBE?=
 =?us-ascii?q?AsYAgImAgJXBgEMBgIBAYJjPwGCSgMJBSAPq1J1gTKENAGBFIJZDWOBNwaBD?=
 =?us-ascii?q?igBjDJ5gQeBOA+CXT6CG0kCgSyDR4JeBI1QihmXToJBgkiEc45sBhuaao5ai?=
 =?us-ascii?q?FqUKiOBWCsIAhgIIQ+DJ1AYDZZCinEjAzCObYJDAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Jan 2020 17:40:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00AHe50e116035;
        Fri, 10 Jan 2020 12:40:06 -0500
Subject: Re: [RFC PATCH] selinux: add policy capability for systemd overhaul
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
References: <20200110142038.21602-1-cgzones@googlemail.com>
 <CAHC9VhTm4Mv2=vy7-LVFnnVnNd87MajzN1imjSLcqx9H17uQqg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8426e416-cc8e-e054-aded-075cfc381057@tycho.nsa.gov>
Date:   Fri, 10 Jan 2020 12:41:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTm4Mv2=vy7-LVFnnVnNd87MajzN1imjSLcqx9H17uQqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 11:55 AM, Paul Moore wrote:
> On Fri, Jan 10, 2020 at 9:20 AM Christian Göttsche
> <cgzones@googlemail.com> wrote:
>> Support a SELinux overhaul of systemd by adding a policy capability.
>>
>> The systemd patch can be found at
>> https://github.com/systemd/systemd/pull/10023
>> and has NOT yet been accepted.
>>
>> This is just a rfc to test the water.
>> ---
>>   security/selinux/include/security.h | 1 +
>>   security/selinux/ss/services.c      | 3 ++-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> Generally the SELinux policy capabilities are reserved for *kernel*
> changes that potentially break compatibility with existing SELinux
> policies.  I'm probably not the best person to talk about
> tricks/conventions used to do similar things in userspace, but you've
> come to the right place :)

It was my suggestion to use policy capabilities for this.  There is no 
separate mechanism for supporting major changes to userspace SELinux 
permission checks in a backward-compatible manner.  Userspace already 
relies upon /sys/fs/selinux/{deny_unknown,reject_unknown} to get the 
handle_unknown setting from the kernel policy to decide how to handle 
unknown userspace classes/permissions.  That however is insufficient for 
these changes to systemd's permission check because they go beyond 
introducing new classes and permissions and overhaul the existing 
checks.  Policy capability seemed like the best way to do it, and 
getting it from the kernel is consistent with the fact that we are also 
getting the userspace classes/perms from the kernel via 
/sys/fs/selinux/class and the userspace access decisions from the kernel 
via /sys/fs/selinux/access (through the libselinux AVC, typically).

> 
>> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
>> index ecdd610e6449..2853e462977f 100644
>> --- a/security/selinux/include/security.h
>> +++ b/security/selinux/include/security.h
>> @@ -79,6 +79,7 @@ enum {
>>          POLICYDB_CAPABILITY_ALWAYSNETWORK,
>>          POLICYDB_CAPABILITY_CGROUPSECLABEL,
>>          POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
>> +       POLICYDB_CAPABILITY_SYSTEMD_OVERHAUL,
>>          __POLICYDB_CAPABILITY_MAX
>>   };
>>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> index 55cf42945cba..cb50e187b181 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -73,7 +73,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>>          "extended_socket_class",
>>          "always_check_network",
>>          "cgroup_seclabel",
>> -       "nnp_nosuid_transition"
>> +       "nnp_nosuid_transition",
>> +       "systemd_overhaul"
>>   };
>>
>>   static struct selinux_ss selinux_ss;
>> --
>> 2.24.1
> 

