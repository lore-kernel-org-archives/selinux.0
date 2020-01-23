Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB420C2D0DB
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 20:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D32246B2
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 20:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="i4zgDwGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgAWUke (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:40:34 -0500
Received: from UHIL19PA36.eemsg.mail.mil ([214.24.21.195]:54889 "EHLO
        UHIL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbgAWUkd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 15:40:33 -0500
X-EEMSG-check-017: 69652471|UHIL19PA36_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,355,1574121600"; 
   d="scan'208";a="69652471"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Jan 2020 20:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579812031; x=1611348031;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Q9Odlqb5wtJGsn/d8fDZEYfu3y8ith6clOW149Jggek=;
  b=i4zgDwGtctOntzB/hM+FfT9uMtMlIl05bQtcsRYXV8pOjzsEA2wh5rmZ
   eQrjtRWcs3YZsNkOpLvrDcpwxirAMXDSsqFBANpANj8cqNTz3U0Vj6COF
   99E1AVO/Ch1/I3En+2LG97wFTUo30YVBsweCl0B/H/pb8sRSMeLtznKHZ
   RUsnam2Z8PnUsUxWv59o/Rt4CkIOEzxR1RF1Es33IngjivqKhHUSalUWV
   gs1uTgKo73co5T2FVLEsWa5KMdmUbRujPJvjd0U79yryg+v9uKLQAM50d
   TUzApTfesCrQQvkDqDF7RQ3ACTJRTX5p2U37uCdNo3YYI2CdeigAFsj/+
   A==;
X-IronPort-AV: E=Sophos;i="5.70,355,1574121600"; 
   d="scan'208";a="38180751"
IronPort-PHdr: =?us-ascii?q?9a23=3AiuXL1hJQFcBofT7bpdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfL/jxwZ3uMQTl6Ol3ixeRBMOHsq4C0bCd4/6oGTRZp8rY6zZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZF8JqovxR?=
 =?us-ascii?q?fEoXpFcPlSyW90OF6fhRnx6tq+8ZJ57yhcp/ct/NNcXKvneKg1UaZWByk8PW?=
 =?us-ascii?q?Av483ruxjDTQ+R6XYZT24bjBlGDRXb4R/jRpv+vTf0ueR72CmBIM35Vqs0Vi?=
 =?us-ascii?q?i476dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3?=
 =?us-ascii?q?ZPUdhNWCxAGoO8bpUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izDFHhmXy3aYnze?=
 =?us-ascii?q?ovFw/I1xEkE94XsHnZqND5OaEPWu630abI1y3OYe5W1znj5ojGcR4vrv+DUr?=
 =?us-ascii?q?1ybcXfxlIiFx/Gg1iKtYDpIz2Y2+YLvmOG7+RgT+Wvi2s/pgFzrDmg2t0jip?=
 =?us-ascii?q?PVho4L11vJ8id5wYgpKtKiUk57fcCoHYBMtyCaK4R2QsQiT3tuuCYh0LIKo5?=
 =?us-ascii?q?G7fC8UyJk+wRPUdv+Jc5CQ7x7+W+ucLi10iXJ4dL6lmRq//lasxvfhWsSyzV?=
 =?us-ascii?q?1EtDBKksPWuXAIzxHT78+HReZj8Uq5wjaP0hzT6vlDIUApiarXM54hzaA0lp?=
 =?us-ascii?q?oUqUnDAjX5mF/3jK+LbUUo4Omo6+LpYrXhvZ+TKZN7hhviMqUuhsO/AeM4Ph?=
 =?us-ascii?q?IIX2eH4uSzyKfv/Uj4QLVOlvE2k6/Zv47GJckDu6K0DABY3pwj5hqiFTuqzt?=
 =?us-ascii?q?sVkWcdIF5YYB6HipLmO1DKIPD2F/e/hFGsnS9px/HIIrLuGI/NLmTdnLr6Yb?=
 =?us-ascii?q?Z861JTyAo0zdxF4ZJUEasOLOj8Wk/2qtzUFgU5PBCsw+b7FNV90ZsTVn+IAq?=
 =?us-ascii?q?+cMaPSt16I6f4sI+WWa48Vojf9K/Y55/P1kHA2h1Edcrev3ZsMdn+3Au5qI0?=
 =?us-ascii?q?OdYXD0mNcODX8KvhYiTOztkFCCSiBcZ3KzX6I6+zE6B5mrDZnMRo+zmryNxi?=
 =?us-ascii?q?S7EYNMZmBAFF+MFW3kd4KeW/cDO2quJZpNlTkFU7mqSMcOzxCgqEeux71iL+?=
 =?us-ascii?q?zV8S5euoji2sRd6+DdmBcp+DcyCcDLlymWQmV1mH4YbyE50bo5okFnzFqHl6?=
 =?us-ascii?q?9ijK92D9tWsvFWWQ4gKcSUm+5lANnoRljpYsaCSFHgRM6vRz42UIRikJc1f0?=
 =?us-ascii?q?9hFoD63Vj41C2wDupQzuHaCQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2B9AwCBAype/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBKJA4g0mzgJAQEBAQEBAQEBNwEBghOCLQKCQjgTAhABAQEEAQEBA?=
 =?us-ascii?q?QEFAwEBbIVDgjspAYJ5AQEBAQIBIw8BBUYLCQIJDwICJgICVwYBDAYCAQGCY?=
 =?us-ascii?q?z+CXCCRTZsBdYEyiH+BPoEOKo1xQIE4D4JdPodZgl4EgT8BjBKKKHqVanYGg?=
 =?us-ascii?q?j2WLgYbmneOXpcihXcigVgrCkFKgR6BTlAYDYg5jiwjAzCNRAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 23 Jan 2020 20:40:31 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00NKdk7w250994;
        Thu, 23 Jan 2020 15:39:47 -0500
Subject: Re: [Non-DoD Source] Re: any reason why a class mapping is not able
 to solve permissionx?
From:   jwcart2 <jwcart2@tycho.nsa.gov>
To:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
References: <20200117173448.GA166208@brutus.lan>
 <20200117182405.GA182181@brutus.lan>
 <904dcd8e-9b0b-b444-4931-4dc165e4fb1f@tycho.nsa.gov>
Message-ID: <b1a48f5e-6b11-ea21-a90a-5ae5fd8a12c5@tycho.nsa.gov>
Date:   Thu, 23 Jan 2020 15:41:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <904dcd8e-9b0b-b444-4931-4dc165e4fb1f@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/21/20 11:26 AM, jwcart2 wrote:
> On 1/17/20 1:24 PM, Dominick Grift wrote:
>> On Fri, Jan 17, 2020 at 06:34:48PM +0100, Dominick Grift wrote:
>>> For example this:
>>>
>>> (permissionx alg_socket_ioctl_except_SIOCGIFHWADDR (ioctl alg_socket (and 
>>> (all) (not (0x8927)))))
>>> (classmap all_sockets (ioctl_except_SIOCGIFHWADDR))
>>> (classmapping all_sockets ioctl_except_SIOCGIFHWADDR 
>>> alg_socket_ioctl_except_SIOCGIFHWADDR)
>>>
>>> (allowx a self (all_sockets (ioctl_except_SIOCGIFHWADDR)))
>>>
>>> Say's:
>>>
>>> <snip>
>>> Building AST from Parse Tree
>>> Destroying Parse Tree
>>> Resolving AST
>>> Failed to resolve classmapping statement at policy/base/class_maps.cil:994
>>> Problem at policy/base/class_maps.cil:994
>>> Pass 14 of resolution failed
>>> Failed to resolve ast
>>> Failed to compile cildb: -2
>>> make: *** [Makefile:30: policy.32] Error 254
>>>
>>> Am i doing something wrong or is this unsupported?
>>
>> Are we supposed to be able to use allowx rules in macros?
>>
> 
> Yes, allowx rules can be used in macros.
> 
>> This works when the tunable is set false:
>>
>> (tunable no_mac_addr true)
>>
>> (block bla1
>>          (blockinherit system_agent_template)
>>
>>          (macro stuff ((type ARG1))
>>                  (tunableif no_mac_addr
>>                    (true
>>                        (allow ARG1 self 
>> create_except_ioctl_tcp_stream_socket_perms)
>>                        (allowx ARG1 self tcp_socket_ioctl_except_SIOCGIFHWADDR))
>>                    (false
>>                        (allow ARG1 self create_tcp_stream_socket_perms)))))
>>
>> (block blah2
>>          (blockinherit system_agent_template)
>>
>>          (call bla1.stuff (subj)))
>>
>> But when the tunable is set true:
>> <snip>
>> Building AST from Parse Tree
>> Destroying Parse Tree
>> Resolving AST
>> make: *** [Makefile:30: policy.32] Segmentation fault (core dumped)
>>
> 
> Still trying to figure out the exact issue, but it is the use of the named 
> permissionx that is causing the seg fault.
> 

There was an error in the code to copy a permissionx. I sent a patch to the list 
to fix this issue.
Jim

> Jim
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
