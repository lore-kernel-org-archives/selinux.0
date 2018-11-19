Return-Path: <SRS0=oFG+=N6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD7FC43441
	for <selinux@archiver.kernel.org>; Mon, 19 Nov 2018 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D8F20831
	for <selinux@archiver.kernel.org>; Mon, 19 Nov 2018 13:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D8F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbeKTAO0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:14:26 -0500
Received: from uphb19pa12.eemsg.mail.mil ([214.24.26.86]:58661 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727310AbeKTAO0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Nov 2018 19:14:26 -0500
X-EEMSG-check-008: 161060052|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Nov 2018 13:50:44 +0000
X-IronPort-AV: E=Sophos;i="5.56,252,1539648000"; 
   d="scan'208";a="20764054"
IronPort-PHdr: =?us-ascii?q?9a23=3An3xPQBd8/1Kjv45FaW3rsIDTlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW5bB7h7PlgxGXEQZ/co6odzbaO4+a4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahYr5+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYMPONUoo/grFUMsBS+HxGhCv7vxDFWiH/43qM03O?=
 =?us-ascii?q?ouHg7EwAMuEMkDsGjXodjvKKseTe64wavOwD7eb/1WwzD96I3Qfx48vfGDQ6?=
 =?us-ascii?q?pwccrPxkkpCgjLk1CQppbhPzORyOsMs3WQ4u17Ve2ykG4qsB1xozizyccsjY?=
 =?us-ascii?q?nFnIQVykve+iljz4Y1IsO4RVd9bNW5HpVQsCSaOJF3QsMkW2xotyc6yqEGuZ?=
 =?us-ascii?q?6mZycG0ogoxxnaa/Cfb4iI+AjsVPiQITdjnX5qZLO/iwy18Ui6xe3wTsy030?=
 =?us-ascii?q?xMridHiNXMsWoN1xPV58OaSfV95l+s1SuA2g3c8O1JIV04mbDFJ5Mu3LI8jI?=
 =?us-ascii?q?cfvELeFSHsgkr2lrWZdkA89+it7OTof6vpq4eHN49xlgH+KqMumtGjAeggMg?=
 =?us-ascii?q?gBQWyb+eOk2b3/50L5WrRKjuAtkqXDrJDbJdgUpq6+AwNP1IYs9w2/ACu83N?=
 =?us-ascii?q?QdnHkHKEpJeBOBj4f3J1HDOO30APiwjli2kDpn2urKMqPuD5nTNHTPja/tfb?=
 =?us-ascii?q?Nn5E5dzAozw8pf55VRCrwZO/L8R1TxucfEDh45LwO0w+HnBM971oMFQ22DGK?=
 =?us-ascii?q?CZMKTMsVOQ/OIgP/GMZJMJuDb6M/Ul4f/ugmM+mV8ZZ6apxoEbaHG/HvRhOE?=
 =?us-ascii?q?WZemHhgtIOHGYFpAY+S/bqiFKaWz5Je3myR7485i08CI++FofMWIStgL2H3C?=
 =?us-ascii?q?emEZxbfX5GCl+SHnfybYmEWOkDaDiUIsB/ljwIT7+hS5Uu1ULmiAiv7btsKe?=
 =?us-ascii?q?7d4WU5spX4z5Ah4ezYkhU77np1CMOGyEmIE3EymXkHEWwYxqd69Hdhx0+D3K?=
 =?us-ascii?q?4wuPlREdhe9rsdSQshHYLNxOx9TdbpU0TOecnfGwXuecmvHTxkFoF5+NQJeU?=
 =?us-ascii?q?soXoz60B0=3D?=
X-IPAS-Result: =?us-ascii?q?A2C3AADTvvJb/wHyM5BiHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopZk8zJ4N4lBRMAQEBAQEBBoEICCWJFZAbMAgBg3pGAoNrIjcGDQEDAQEBA?=
 =?us-ascii?q?QEBAgFsHAyCNiQBgmIBBSMPAQUPMhAJAhgCAiYCAlcGDQYCAQGCXj8BgXQND?=
 =?us-ascii?q?4skm1CBL4MqgQMBhW6BC4p6F3iBB4ERJwyCX4FUgUcCAYEpgzuCVwKJEgaGb?=
 =?us-ascii?q?k6PGwmGeoonBhiCJI5ZjTmMOSKBVSsIAhgIIQ+DJwkKDIIxgziFFIVcIQMwA?=
 =?us-ascii?q?YEEAQGLM4JNAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Nov 2018 13:50:42 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wAJDoehQ016112;
        Mon, 19 Nov 2018 08:50:41 -0500
Subject: Re: [PATCH] libsemanage: set selinux policy root to match semanage
 root or storename
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
References: <20181106192021.17556-1-sds@tycho.nsa.gov>
 <CAJfZ7=kYppH2JjSkpcgX1FXnaRtHB7c561hkgRZ0XOym_T7_Ww@mail.gmail.com>
 <a29de7d8-7efb-f8ce-1c29-01dd4c43bb73@tycho.nsa.gov>
Message-ID: <42f12202-0298-cbc7-2ce9-7cf6e7020049@tycho.nsa.gov>
Date:   Mon, 19 Nov 2018 08:52:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a29de7d8-7efb-f8ce-1c29-01dd4c43bb73@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/8/18 9:20 AM, Stephen Smalley wrote:
> On 11/7/18 3:45 PM, Nicolas Iooss wrote:
>> On Tue, Nov 6, 2018 at 8:18 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>
>>> As reported in #109, semodule -p /path/to/policyroot -s minimum -n -B
>>> tries to use /etc/selinux/targeted/booleans.subs_dist.  This is because
>>> it invokes the libselinux selinux_boolean_sub() interface, which uses
>>> the active/installed policy files rather than the libsemanage ones.
>>>
>>> To fix, we need to set the selinux policy root when either the semanage
>>> root or the semanage storename is set.  When setting the semanage root,
>>> we need to prepend the semanage root to the selinux policy root.  When
>>> setting the semanage storename, we need to replace the last component
>>> of the selinux policy root with the new storename.
>>>
>>> Test:
>>> strace semodule -p ~/policy-root -s minimum -n -B
>>>
>>> Before:
>>> openat(AT_FDCWD, "/etc/selinux/targeted/booleans.subs_dist", 
>>> O_RDONLY|O_CLOEXEC) = 5
>>>
>>> After:
>>> openat(AT_FDCWD, 
>>> "/home/sds/policy-root/etc/selinux/minimum/booleans.subs_dist", 
>>> O_RDONLY|O_CLOEXEC) = 5
>>>
>>> Fixes https://github.com/SELinuxProject/selinux/issues/109
>>>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> ---
>>>   libsemanage/src/handle.c | 29 ++++++++++++++++++++++++++++-
>>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
>>> index a6567bd4..c163e553 100644
>>> --- a/libsemanage/src/handle.c
>>> +++ b/libsemanage/src/handle.c
>>> @@ -43,8 +43,21 @@ static char *private_semanage_root = NULL;
>>>
>>>   int semanage_set_root(const char *root)
>>>   {
>>> +       char *new_selinux_root = NULL;
>>> +
>>> +       asprintf(&new_selinux_root, "%s%s", root, 
>>> selinux_policy_root());
>>> +       if (!new_selinux_root)
>>> +               return -1;
>>
>> https://travis-ci.org/SELinuxProject/selinux/builds/451528669 failed
>> because the return value of asprintf needs to be checked instead of
>> new_selinux_root. http://man7.org/linux/man-pages/man3/asprintf.3.html
>> states:
>>
>>      If memory allocation wasn't possible, or some other error occurs,
>> these functions will return -1, and the contents of strp are
>> undefined.
>>
>> [...]
>>
>>> +
>>> +       char *newroot = NULL;
>>> +       asprintf(&newroot, "%s%s", root, storename);
>>> +       assert(newroot);
>>
>> Same here.
> 
> Unfortunately there are more fundamental problems with the patch as 
> well, e.g.
> 
> 1) Mutating selinux_policy_root breaks the test of whether we are 
> installing to the active store in semanage_install_final_tmp(), which 
> will cause policy reloads to be triggered when performing an operation 
> on a different store, a different root, or both.
> 
> 2) semanage_select_store() is supposed to only modify the per-handle 
> state.  Changing selinux policy root is global state and would affect 
> any other handles.
> 
> 3) Multiple semanage_set_root() calls would yield the wrong result.
> 
> 4) An allocation failure for private_semanage_root would leave the 
> policy root modified.
> 
> Not sure of the best approach here.  Could possibly just modify the 
> policy root around the selinux_boolean_sub() call and leave the rest 
> unchanged...

I guess the underlying bug here is that booleans.subs_dist is not itself 
managed via libsemanage.  If it was managed and therefore lived within 
the policy store, then libsemanage could access the appropriate 
booleans.subs_dist file without using the libselinux interface at all, 
and thus would not need to switch the selinux policy root. Moving 
booleans.subs_dist to being a managed file however would be a more 
substantial change.  The short term fix might be to switch the selinux 
policy root around the selinux_boolean_sub() call, with a longer term 
fix of taking booleans.subs_dist to being a managed file.

