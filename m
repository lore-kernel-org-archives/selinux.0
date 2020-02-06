Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE697C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 15:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A775E222C2
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 15:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="LTadfQ3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgBFPej (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:34:39 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:19640 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBFPei (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 10:34:38 -0500
X-EEMSG-check-017: 55553485|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="55553485"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 15:34:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581003276; x=1612539276;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=70wO0Ue82+DvuayQ5qfSFSHJj/3SbKzpOJisN1Wxrr4=;
  b=LTadfQ3RD2dR+wPgawlMNgeto5VqtvV4QAI+PJvI5KUQnFA0xkdIV1aQ
   F0sKOns2MZvMcOW1kFK1Medl6ynA8DadNjf5KcJAZvdHYt8x5KUCJ031Y
   ajgFsK4VwcyOudQ3fk8C6WWSnH6FDcQrJx1HWE0AbJFX9gpGo5twoI32q
   G/53PM97oZB3Ef1VB+ga4ynfm/KUTSmUxc5ot6qGzJtMqbEj7jZXfu93s
   hDrAktm7BUEGPBqdwBIfuxYDswQ0uh4iW9TUH9QrRriIoXjn1LvFT+SkK
   GMuhlq/joDiByGcZyR9Y8uDpHOQKu52OqkJ13C2o1bhgiSpbcN5Md2Otu
   w==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="38758860"
IronPort-PHdr: =?us-ascii?q?9a23=3AXPHXGRSlZbJY6G7gHdoqJS64/tpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYhON2/xhgRfzUJnB7Loc0qyK6vymBDdLvsvJ8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HJr3ZGdOhbx2NlLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsNKofVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDnMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8kxlo?=
 =?us-ascii?q?nGmJoVylDa+iV/3Y07ONi4R1R/Yd6gDpRRtzyROoxtQsw/WGFlozo6y70atp?=
 =?us-ascii?q?67eygG0pInxwXFZPCdfIiI5QzjWf+XLDxlh3xlYKqyiwu9/EWv0OHxVtS43E?=
 =?us-ascii?q?xUoidKjNXArG0B2hrO4cadUPR95F2u2TOX2gDW7eFLPF47mLLAK54k3r4wjp?=
 =?us-ascii?q?0TsVnfHiPumEX5kquWdkI89+i08evneLTmpoKHN4NuiwH+NKoumsukAesmLg?=
 =?us-ascii?q?cCRXSb+OSg273j+k31WrNKgeEtkqbFqpzaIMUbpqqhDw9U1IYs9Qq/Ai+73N?=
 =?us-ascii?q?kXknQLNlJIdA+dg4T3NFzCPur0Aeqnj1SpijhrxvTGPrP7ApXKK3jOiKzhcq?=
 =?us-ascii?q?tm60NH1AoyzcxQ55JTCr0bJvLzQVX+uMbXDh8+LQy42/znB8ll1oMCRWKPBb?=
 =?us-ascii?q?eUMKTXsV+P/eIvJfODa5MLtzvmMfgq+ePhjX8jll8BZ6WmwZwXaHWgFPR8P0?=
 =?us-ascii?q?qZeWbsgssGEWoSpQoxUujqiFyEUT5OaHe/RLw85j4lB4K8F4vDRZ6igKaH3C?=
 =?us-ascii?q?ilGp1afGdGCkqDEX3wbYWLR+8MaD6OIs9mijEETbyhRJU81RGyrg/10KBoI/?=
 =?us-ascii?q?HO+iIGqJ3j1MJ65/HJmR4u8jx0CpfV72bYaGd4hG4KDxoxx6Z2qkF+ggOE1K?=
 =?us-ascii?q?9jhfVTGPRJ6v9JWxt8PpnZmb9UEdf3Dzndc8+JRVDuedCvBTU8X5pl2NMVS1?=
 =?us-ascii?q?psENWlyBbY1mylBKFDxO/DP4A97q+Jhyu5HM160XuTkfB83lQ=3D?=
X-IPAS-Result: =?us-ascii?q?A2DmBADBMDxe/wHyM5BmHgELHIN4gWwhEiqEFYkDhmUBA?=
 =?us-ascii?q?QEGgRIliXCRSwkBAQEBAQEBAQE3AQGEQAKCYTgTAhABAQEEAQEBAQEFAwEBb?=
 =?us-ascii?q?IVDgjspAYMCAQUjFUEQCw4KAgImAgJXBg0GAgEBgmM/glclrCWBMoVKg2aBP?=
 =?us-ascii?q?oEOKow9eYEHgTgMA4JdPodbgl4EjT4giWBGl2eCRIJOk3IGG4JIiBCQM5Atm?=
 =?us-ascii?q?2kigVgrCAIYCCEPgydQGA2dASMDMI5KAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Feb 2020 15:34:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016FXfQU108408;
        Thu, 6 Feb 2020 10:33:43 -0500
Subject: Re: [RFC PATCH 2/2] semodule: support changing policyvers via command
 line
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20200206131253.535302-1-omosnace@redhat.com>
 <20200206131253.535302-3-omosnace@redhat.com>
 <dfd44a69-8ba1-9de7-c3a8-bca702fdf6a0@tycho.nsa.gov>
 <CAFqZXNvkvuP2qVna2uj3zPPJC5rgJuOei7rF9=gLUo6QUxyvZw@mail.gmail.com>
 <5714f2b9-2dc1-feaf-1f73-2a50a464101b@tycho.nsa.gov>
 <CAFqZXNuAZWx4b9UrT68ui2HbD8mY94jz393ErowaC2soV6f7Vw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f3af0abe-1705-2ef3-80ac-13c9fbacda94@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 10:35:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNuAZWx4b9UrT68ui2HbD8mY94jz393ErowaC2soV6f7Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/20 10:28 AM, Ondrej Mosnacek wrote:
> On Thu, Feb 6, 2020 at 3:52 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 2/6/20 9:19 AM, Ondrej Mosnacek wrote:
>>> On Thu, Feb 6, 2020 at 2:44 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 2/6/20 8:12 AM, Ondrej Mosnacek wrote:
>>>>> When using semodule for building a distribution policy package (as
>>>>> Fedora does), the environment might not have selinuxfs available and
>>>>> provide no way to modify semanage.conf. When we want to build a policy
>>>>> with version X (because our kernel doesn't support X+1 and above yet),
>>>>> but our libsepol already has support for X+1, then we currently have no
>>>>> way to do so.
>>>>
>>>> Not fundamentally opposed, but unclear on the motivation.  The current
>>>> approach is to generate the highest policy version supported by our
>>>> libsepol at build time, then libselinux selinux_mkload_policy() uses
>>>> libsepol functions (sepol_policydb_set_vers(),
>>>> sepol_policydb_to_image()) to automatically downgrade the policy in
>>>> memory to whatever version is supported by the kernel before writing it
>>>> to the kernel.  This works as long as one uses the same or newer
>>>> libsepol at load time as at build time and as long as policydb_write()
>>>> supports writing older policy versions (generally discarding newer
>>>> features).
>>>
>>> The problem is that:
>>> 1. selinux-policy expects that the generated /etc/selinux/.../policy.X
>>> file will be generated with a specific (hard-coded) value X, so if the
>>> userspace is updated in buildroot, the selinux-policy build fails.
>>> 2. If we fix the above by expecting any value X and ship that, then
>>> the build passes in such case, but if a user updates selinux-policy
>>> without updating userspace and reboots, the system will not boot. So
>>> even if we stop incrementing the expected policy version manually, we
>>> would still need to manually increment the minimum required userspace
>>> version each time the policy is rebuilt with userspace that has
>>> incremented its max policyvers.
>>
>> Seems like you could just have selinux-policy depend on the version of
>> libsepol used to build it.
>>
>> The problem with both your current approach and your proposed one is
>> that it means that if a user or package does a semodule -B (or any other
>> semodule/semanage command) on their system, that will generate the
>> latest policy.N version supported by their libsepol, and libselinux will
>> give precedence to that policy at load time.  So if they then later
>> update their selinux-policy package, and it only installs a prebuilt
>> policy.(N-1), that won't actually get loaded - libselinux
>> selinux_mkload_policy() will keep using the policy.N file (which may be
>> older).  Unless I'm missing something.
> 
> Hm, yes, you're right... It seems we have no other choice than to
> better handle the dependency between selinux-policy and libsepol.
> Please disregard this patch series.

Historically, I think we got to this point because originally 
selinux-policy would run semodule from %post to generate the policy.N 
file at install time, thereby always generating the latest version 
supported, and then later switched to pre-building policy.N at package 
build time and just dropping it in place at install time to avoid the 
runtime and memory overhead.  Particularly because it could otherwise 
fail at install time on low-memory systems/VMs.

As a separate matter, one could possibly argue that libselinux 
selinux_mkload_policy() should give preference to the newest file (i.e. 
timestamp-based) rather than the latest policy version.  But even if we 
were to make that change going forward, it won't help with existing 
distro releases.
