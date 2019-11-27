Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A770C432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0402A20665
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ERXazAsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK0PET (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:04:19 -0500
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:25125 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK0PET (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 10:04:19 -0500
X-EEMSG-check-017: 54923390|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,249,1571702400"; 
   d="scan'208";a="54923390"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2019 15:03:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574867037; x=1606403037;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Ao21goY/gx//LERsaZpi3UMCEETnzcUe14T9YlyI0z0=;
  b=ERXazAsr/3LlKrAFrfGOD5XiU45tefEx17/PUZtNE8qHBbuUWsY+9GYq
   KDxs/O/XrQOs1eKTzWfdNKuQcAxoKTHhXk0OzfSaZjGQT+TJLArB7FYh2
   W+VvC+ZL193fMYNH7SQrAf+TVO5WTy/F51CgIM9fKqFXqyAvfjLpGQFC+
   6cr5JqZ6p9WJp4cio9GrQRz1Uu0g8gmhEG3xBXTaQe/E70TgwXQT/AGiJ
   U1uUBinqOPmkEVFpAMjtFfmlo6TRlWX1CRHZPkQVg/6B1pn7UgHceJdRf
   wU8B0kuGeTKrb5uaMJPKZLJzEtjQtUrW+YMwqQxRMqjThAND7Kgr1grVI
   w==;
X-IronPort-AV: E=Sophos;i="5.69,249,1571702400"; 
   d="scan'208";a="36082499"
IronPort-PHdr: =?us-ascii?q?9a23=3AwLV2Jhzrn1u38bPXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoXKvad9pjvdHbS+e9qxAeQG9mCsLQd1bed7fCocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBi3rQjducgbjIh/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXwp18DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbKpghwrA3lp?=
 =?us-ascii?q?oIr0vMAjX6mFn2jaCKdkUk/fKk6+L7bbX9upCQLYp0igD6Mqg2m8y/B/o3Mh?=
 =?us-ascii?q?QWUmSG9umx26fv8E3kTLlQkPE7nbfVvIrHKcgDo662GQ5V0oIt6xalCDem1c?=
 =?us-ascii?q?wVnWIaI1JeYx+Hk4joNE3OIPD/F/u/hU+sny1xy/DJOb3hHI3BLmLfn7f5Yb?=
 =?us-ascii?q?Z990lcxRIozd9B45JUC7cBIO/8W0LqqtzYAQE2Mxauz+bkFtp9zIUeVnyLAq?=
 =?us-ascii?q?ODN6PSq1CI7Po1I+aQfI8VpCr9K/896vHzl3A2hUURfa633ZQJcnC4BPVmLF?=
 =?us-ascii?q?iHbnf3jdcBFH0Fvgs6TODwlFKCVjtTbW6oX60g/jE7FJ6mDYDbS4C1nrOOxz?=
 =?us-ascii?q?m0HptXZmBaDVCBCnboeJuaVPgSci6SJdVhkjNXHYSmHpQs0RCoqR/S1bVqNK?=
 =?us-ascii?q?zX9zceuJal08J6o6X/khQz8z1/DIyyyWCDUykgkmoDATgo0bploEBw4liG2K?=
 =?us-ascii?q?l8xfdfEIoXr7liUh07LoLb1+x3EZjQHEr5c/2ETle6RZ/uVSk8RN83wsMJS0?=
 =?us-ascii?q?dwFtjkiQrMiXmEGbgQwoeXCYQ0/6SU5H34I8Jw2j6Sz6U6p0U3SctIc2u9j+?=
 =?us-ascii?q?hw8BaFVN2BqFmQi6v/LfdU5yXK7mrWiDPT7Uw=3D?=
X-IPAS-Result: =?us-ascii?q?A2BIAAChj95d/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSAShFWJA4ZZBoE3iWmPXYFnCQEBAQEBAQEBATcBAYRAA?=
 =?us-ascii?q?oIkOBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgm4BBSMVUQsYAgImAgJXBgEMC?=
 =?us-ascii?q?AEBgl8/glMlslCBMoVPg0OBSIEOKIESix55gQeBEScPgl0+hDELgx2CXgSNB?=
 =?us-ascii?q?VSJCkaHXI5EcII3gjmTFwYbkQiJF45IlxGFFCKBWCsIAhgIIQ+DKE8RFJUsI?=
 =?us-ascii?q?wOMLoI/AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Nov 2019 15:03:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xARF3Sj0268040;
        Wed, 27 Nov 2019 10:03:30 -0500
Subject: Re: [RFC 0/3] Second phase of UserPrefix to UserRBACSEPRole
 transition
To:     selinux@vger.kernel.org, Dominick Grift <dac.override@gmail.com>,
        "Christopher J. PeBenito" <pebenito@ieee.org>
References: <20191123144245.3079306-1-dac.override@gmail.com>
 <7f62f389-f531-f1dd-cb38-3a5b75e40731@tycho.nsa.gov>
 <20191125141035.GB441967@brutus.lan>
 <fe0d0ffe-a96a-9438-76f2-7759a41b823c@tycho.nsa.gov>
 <20191127112241.GA23027@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <49b2e25e-d317-3ea9-dd75-5beae73309ee@tycho.nsa.gov>
Date:   Wed, 27 Nov 2019 10:03:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127112241.GA23027@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/27/19 6:22 AM, Dominick Grift wrote:
> On Tue, Nov 26, 2019 at 01:27:42PM -0500, Stephen Smalley wrote:
>> On 11/25/19 9:10 AM, Dominick Grift wrote:
>>> On Mon, Nov 25, 2019 at 08:24:21AM -0500, Stephen Smalley wrote:
>>>> On 11/23/19 9:42 AM, Dominick Grift wrote:
>>>>> In 2008 support for UserPrefix was removed from Reference policy.
>>>>> The code to support this functionality in libsepol and libsemanage however remained albeit slightly modified.
>>>>> I am not sure why it was not fully removed.
>>>>>
>>>>> DefaultRole replaces UserPrefix functionality but the code in libsepol and libsemanage was only slighty adjusted to accomodate my use-case.
>>>>> This was done in 88e334f1923396d5ace56b8439c731dcde0d1f3b (2016).
>>>>> I do not use semanage and I do not mind using the old UserPrefix statement, but there is some confusion.
>>>>> For example there was a report recently about how semanage does not document UserPrefix.
>>>>> The documentation was likely removed from view because UserPrefix is no longer supported as such.
>>>>>
>>>>> I want to make the situation better and this proposal is the next phase.
>>>>> This proposal causes some disruption as Reference policy based policy often calls the gen_user() macro with the "user" prefix.
>>>>>
>>>>> Example: gen_user(user_u, user, user_r, s0, s0)
>>>>>
>>>>> This will no longer be valid, and the userprefix parameter in gen_user() can be left empty (or needs a valid role if RBACSEP DefaultRole is leveraged).
>>>>>
>>>>> Example: gen_user(user_u,, user_r, s0, s0)
>>>>>
>>>>> UserPrefix will now default to object_r. This should not affect common policy implementations.
>>>>>
>>>>> The next phases will be:
>>>>>
>>>>> Renaming the UserPrefix statement to UserRBACSEPRole, and renaming references to (user)?prefix to (user)?rbacseprole.
>>>>> Adjusting semanage to expose UserRBACSEPRole.
>>>>> Removing legacy UserPrefix (ROLE/USER_TEMPLATE) references from libsemanage.
>>>>>
>>>>> After this the UserPrefix to UserRBACSEPRole transition should be completed.
>>>>>
>>>>> This should get us by until someone decides to rewrite libsemanage to take advantage of CIL, simplify the code, and to make the code more robust.
>>>>
>>>> I guess my only question with regard to this phase and the next ones is with
>>>> regard to backward compatibility.  Even if no one is using this facility, we
>>>> have to make sure we do not break existing installs upon upgrade.
>>>
>>> Maybe we can duplicate the code instead. That way we would not have to touch the existing, but dead userprefix code.
>>> That should address any compatibility issues.
>>
>> At a minimum, we must avoid breaking existing installs upon upgrade, and we
>> must avoid breaking compilation of existing policy modules (both refpolicy
>> and CIL).
>>
>> A simple test would be ensuring that if you upgrade the userspace and run
>> semodule -B with your previously installed policy (including its existing
>> userprefix statements), there are no errors and you get the same
>> file_contexts.homedirs as you had before.
>>
>> That should be relatively easy to ensure for targeted policy.  Might be more
>> complicated with your policy, the CLIP policy, or perhaps others.
> 
> I am thinking that we might be able to add something to cil_resolve_userprefix() that would just not process any entries referencing the "prefix" keyword as in "user ... prefix ...;" instead of "user ... rbacseprole ...;", and instead emits a warning: "Not processing deprecated userprefix: userprefix. Use userrbacseprole instead."
> That would then just not add those entries to users_extra, and instead rely on "fallback_rbacseprole=object_r" in genhomedircon.c, if the "migration" code in libsemanage does not catch it first.

I don't think we want warnings; otherwise someone upgrading Fedora to 
new userspace would get constant warnings on all subsequent libsemanage 
transactions due to their existing distro-provided users_extra file.

Also, not to bikeshed, but userrbacseprole is hard on the eyes.  Looks 
like libsemanage/src/genhomedircon.c currently tests whether the prefix 
value is a homedir role (prefix_is_homedir_role()) and uses it as such 
in that case.  Can we just do that?  And if we have to rename it, maybe 
just call it homedir_role instead.




