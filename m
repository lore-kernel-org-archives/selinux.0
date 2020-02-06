Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8318C35247
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 19:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B668520659
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 19:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="VmDMnDvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBFTWB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:22:01 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:1967 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgBFTWA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 14:22:00 -0500
X-EEMSG-check-017: 55836269|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="55836269"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 19:21:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581016912; x=1612552912;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2NFTIgpvqwCVUH/RZa8fynAyt0BLsEyAw2F59vIWBgw=;
  b=VmDMnDvbzpv8LwBMrWBLSl2ibzqa9uJ+b5aHT4zPv6U2ICeJdWk9s/Sm
   pQe9d+yeDUyndLJIF9Tl7C7j/7P+fz7ybiCgGAWUqkMGfCzKynkR55zNJ
   CpHHx6rO2GVQsOEXynBEvKvekUjP2xm2lIXmP18Ez+TkSBAtRyI5nPrn2
   rhWhSlx/hOm/I8CmbC+037rJ4If6b2R9C3sGn6+4inHOi+Ao+sw+zxk1B
   YOWtbFdTZd+BFOTqwfj+gvOuzJ1CDb3cNCIeMue6vlZskoIk1I7bQYhDk
   s3b/p45V7/+oWaftwRLl3HZoUHZVzAEvfbTU+r0VDV6OFx82A3tA59hyT
   g==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="32781241"
IronPort-PHdr: =?us-ascii?q?9a23=3AtkgHaBIuTZjvRV9/8tmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfLfzxwZ3uMQTl6Ol3ixeRBMOHsq4C1rGd6vq6ESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4Kqs8xB?=
 =?us-ascii?q?TFrmZWd+hI2GhkIU6fkwvm6sq/4ZJu/T5ct+49+8JFTK73Y7k2QbtEATo8Lm?=
 =?us-ascii?q?s7/tfrtR7NTQuO4nsTTGAbmQdWDgbG8R/3QI7/vjP1ueRh1iaaO9b2Ta0vVj?=
 =?us-ascii?q?S586hrUh7ohzwZODM/7Wral9Z/jKNfoBKmuhx/34vZa5ybOfZiYq/Qe84RSH?=
 =?us-ascii?q?FfVchNSSNOHoK8b5MOD+UfO+ZYs5L9rEYKoRenGAWgGP/jxjpOi3D4x6061/?=
 =?us-ascii?q?kqHx/A0gIuAtkCtG3YodXxOasXV+2+0avGwijZb/5OxDnz6JbGch4ir/+CU7?=
 =?us-ascii?q?1/fsjexlUgGQ7eklWdqpboMy+J2ukDsWWW6fdrW+K1i24grgF8uiWhxtsyhY?=
 =?us-ascii?q?nRhoIa1FbE/jhkzoYwP9K4TEp7bsCkEZBNsCyaLJZ5Qtg5TmF0uCc11r0GuZ?=
 =?us-ascii?q?mhcCgM05Qo3QTTa/OAc4iW+x/uUvuaLzRghH99Zb6yiBm//VKgx+HhTMW4zl?=
 =?us-ascii?q?lHojRfntXRsH0Gygbd5dKdSvRn+0eswTOP1wfO5e5aOU00jq/bK4I5wr43i5?=
 =?us-ascii?q?oTrVzPHi/ol0Xyi6+bblkk9fKy6+Tmf7XmvYWQN45yigHwNaQugdKwDvgiPg?=
 =?us-ascii?q?gSX2mU5eS81Lr58U3/XLpKleE5nrPcsJDbIcQXvq+5AwlL3YY/8xuzEjir3d?=
 =?us-ascii?q?sCkXQHMV5JYgyLgof3N13UPfz0FfK/jE6tkDdvyfDGJLrhApDVI3jYjbjhZq?=
 =?us-ascii?q?1w61JcyQUvzdBf4IhYCrcaIP3pQEPxu9vYDgEhPwyu3+nnEMl91p8ZWW+XBa?=
 =?us-ascii?q?+ZNaTSsUSO5u01P+aDepQYuCzjJPc45/7hl2M5lUUBcqmu2JsdcGq4Eeh+I0?=
 =?us-ascii?q?WFfXrshc8MEXwUsQo6TezqjkCCUDFIanasUKIz+Cs7BJilDYjdXICthqKO3C?=
 =?us-ascii?q?OhEp1RfGBGBUiGEW30eIWcR/cMdCWSL9d5kjwAT7ehVpMh1Qu1uwDg0LdnNP?=
 =?us-ascii?q?Tb9TAYtZ35yNh5/fHclRY39W88M8PI9GeBVWx21kYPXDk/16186Rh6z1CY16?=
 =?us-ascii?q?FzjtRCGNBT7u8PWQA/Y83y1et/XuvuVxrBc9HBc1OvRtGrEHllVd4q68MfaE?=
 =?us-ascii?q?Z6XdO5h1bM2DT8UOxdrKCCGJFhqvGU5HP2Pcsoji+bhaQ=3D?=
X-IPAS-Result: =?us-ascii?q?A2A9BAD8Zjxe/wHyM5BmHQEBAQkBEQUFAYF7gX2BbSASK?=
 =?us-ascii?q?oQViQOGYgEBAQEBAQaBN4lwkUsJAQEBAQEBAQEBNwEBhEACgmE4EwIQAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFQ4I7KQGDAgEFIw8BBUEQCw4KAgImAgJXBg0GAgEBgmM/g?=
 =?us-ascii?q?lclrW2BMokqgT6BDiqMPXmBB4E4D4JdPodbgl4EjT4giiaXZ4JEgk6TcgYbg?=
 =?us-ascii?q?kiIEJAzkC2baSKBWCsIAhgIIQ+DJ1AYDY4pF45BIwMwjkoBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Feb 2020 19:21:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016JKx90226542;
        Thu, 6 Feb 2020 14:20:59 -0500
Subject: Re: [RFC PATCH 2/2] semodule: support changing policyvers via command
 line
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20200206131253.535302-1-omosnace@redhat.com>
 <20200206131253.535302-3-omosnace@redhat.com>
 <dfd44a69-8ba1-9de7-c3a8-bca702fdf6a0@tycho.nsa.gov>
 <CAFqZXNvkvuP2qVna2uj3zPPJC5rgJuOei7rF9=gLUo6QUxyvZw@mail.gmail.com>
 <5714f2b9-2dc1-feaf-1f73-2a50a464101b@tycho.nsa.gov>
 <CAFqZXNuAZWx4b9UrT68ui2HbD8mY94jz393ErowaC2soV6f7Vw@mail.gmail.com>
 <f3af0abe-1705-2ef3-80ac-13c9fbacda94@tycho.nsa.gov>
 <b1014a44-296a-f417-850e-969986cdce0a@tycho.nsa.gov>
Message-ID: <e716fb3d-e858-c546-7a9e-3aa2ccabb105@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 14:22:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b1014a44-296a-f417-850e-969986cdce0a@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/20 1:47 PM, Stephen Smalley wrote:
> On 2/6/20 10:35 AM, Stephen Smalley wrote:
>> On 2/6/20 10:28 AM, Ondrej Mosnacek wrote:
>>> On Thu, Feb 6, 2020 at 3:52 PM Stephen Smalley <sds@tycho.nsa.gov> 
>>> wrote:
>>>>
>>>> On 2/6/20 9:19 AM, Ondrej Mosnacek wrote:
>>>>> On Thu, Feb 6, 2020 at 2:44 PM Stephen Smalley <sds@tycho.nsa.gov> 
>>>>> wrote:
>>>> Seems like you could just have selinux-policy depend on the version of
>>>> libsepol used to build it.
>>>>
>>>> The problem with both your current approach and your proposed one is
>>>> that it means that if a user or package does a semodule -B (or any 
>>>> other
>>>> semodule/semanage command) on their system, that will generate the
>>>> latest policy.N version supported by their libsepol, and libselinux 
>>>> will
>>>> give precedence to that policy at load time.  So if they then later
>>>> update their selinux-policy package, and it only installs a prebuilt
>>>> policy.(N-1), that won't actually get loaded - libselinux
>>>> selinux_mkload_policy() will keep using the policy.N file (which may be
>>>> older).  Unless I'm missing something.
>>>
>>> Hm, yes, you're right... It seems we have no other choice than to
>>> better handle the dependency between selinux-policy and libsepol.
>>> Please disregard this patch series.
>>
>> Historically, I think we got to this point because originally 
>> selinux-policy would run semodule from %post to generate the policy.N 
>> file at install time, thereby always generating the latest version 
>> supported, and then later switched to pre-building policy.N at package 
>> build time and just dropping it in place at install time to avoid the 
>> runtime and memory overhead.  Particularly because it could otherwise 
>> fail at install time on low-memory systems/VMs.
>>
>> As a separate matter, one could possibly argue that libselinux 
>> selinux_mkload_policy() should give preference to the newest file 
>> (i.e. timestamp-based) rather than the latest policy version.  But 
>> even if we were to make that change going forward, it won't help with 
>> existing distro releases.
> 
> I guess that doesn't help either since the timestamp of the policy.N 
> file generated at package build may still be older than that of any 
> locally generated one, even if the package was installed later.

Looks like selinux-policy.spec has preInstall and postInstall macros 
that are triggering a rebuild of policy (semodule -B) if there are any 
/etc/selinux/targeted/policy/policy.* files that differ from the 
packaged one.  So if the user did a semodule -B or any other 
semodule/semanage command previously that generated a newer policy 
version (or the same version but with different contents) then the 
package install is going to run semodule -B and re-generate it anyway.
I guess it isn't broken then.
