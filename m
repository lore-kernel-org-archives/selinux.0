Return-Path: <SRS0=4+dM=3K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56010C2D0CE
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 19:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6F9217F4
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 19:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="PAUQeLRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgAUTe1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:34:27 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:28513 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgAUTe1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jan 2020 14:34:27 -0500
X-EEMSG-check-017: 48026674|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,347,1574121600"; 
   d="scan'208";a="48026674"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Jan 2020 19:34:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579635264; x=1611171264;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Ngmfiy/sTjDpftGcNO1f9Nbtb2ojyTlD4sb7kPB3nho=;
  b=PAUQeLRdQqWi6MR2y4V22WdKT1e/5wd5ZmB6tF9uFNU/eZRPHhKQqjOX
   pYtbMViv+ZJFIO+yc6SazD1rdH5+u68iwlHC9eTA+FKudK6ywDdbpvqmi
   Zb2Ksdks4y2Btj/QU2pBExM833KBjePAkwU/sdf3DLUyEDH/U0m2lE1dd
   VY0BD0OnGn8pk8K5t6twfLvEEyj2x9tR5AYPXhXQAvHYY8VAnlpZHLFWo
   GwSa7qq7RuPtAW653/5i4Ia4YbLDMIRQ7dxHr7dEYMsZl29apE9+sx0wf
   diyxMy6SpGbbKKgrfKIuET+6jwuc527bxqEqkXVIRs5VG91uiWuDpNaxP
   w==;
X-IronPort-AV: E=Sophos;i="5.70,347,1574121600"; 
   d="scan'208";a="38063191"
IronPort-PHdr: =?us-ascii?q?9a23=3AbIMrzx16k0PuCCN+smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMRKfad9pjvdHbS+e9qxAeQG9mCt7Qd26GP6fqoGTRZp8rY6zZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZF/JqsyxR?=
 =?us-ascii?q?fFv2VEd/pLzm9sOV6fggzw68it8JNt6Shcp+4t+8tdWqjmYqo0SqBVAi47OG?=
 =?us-ascii?q?4v/s3rshfDTQqL5nQCV2gdjwRFDQvY4hzkR5n9qiT1uPZz1ymcJs32UKs7WS?=
 =?us-ascii?q?++4KdxSR/nkzkIOjgk+2zKkMNwjaZboBW8pxxjxoPffY+YOOZicq7bYNgXXn?=
 =?us-ascii?q?RKUNpPWCNdA4O8d4oPAPQHPeZEtIn2ul8CoQKjCQWwGO/jzzlFiXHs3a0+zu?=
 =?us-ascii?q?8vDwfI0gI9FN4KqXjYstH4OKIUXOuozqfH0C/DYutL1znj5ojGchMvr/+CUr?=
 =?us-ascii?q?1/c8Xe1UYhGhjZjliSs4HpIy+Z2+oPvmWd8uFuVfivi2kiqwxpvzav2tkjip?=
 =?us-ascii?q?HJho0LzFDP6Dh3wIMvKt28TE50f96lG4ZXuiGBKoR2WdgvQ31ouSkmyr0Gvo?=
 =?us-ascii?q?S3fC4RyJs93RLfZPuHc5aR7x/lSe2fLzB4hHd/d7K+gRa/6UagxfPhWcmzyl?=
 =?us-ascii?q?ZFtCtFkt/CtnAXzRPc9syHSvxg/ki8wzqP0BrT6u5CLEsplqTbM4YszqM/m5?=
 =?us-ascii?q?ccq0jOHjL6lF/ogKKZaEko4PWk5uL6abv8vJCcLZV7igTmP6QrncywHPo3Px?=
 =?us-ascii?q?AVX2ie5eS8zLrj/VDlQLlSjv05jK3ZsJfCKMQHvKG5GQ5V0ps46xqlDjem1t?=
 =?us-ascii?q?oYnX4cLF1bZB2LlZTpOlHSL/D4CvezmVKsnytwx//aJLHhB5TNLnzbnLfge7?=
 =?us-ascii?q?Zy9VJcxRIuwd1Q6J9YELEMLO/pVkPvu9HUEAU1PxGsz+biEtp914ceWWyVAq?=
 =?us-ascii?q?+eNaPfqUSI6f80I+SXeI8UuCryK/gi5/L0i385gkUScbOm3ZsQdnC0Bu5mLF?=
 =?us-ascii?q?mBYXrwntcBFn8HvhI6TOPwlV2CTSRTaG2oUK8n/DE0Fp+pDYfZSYCxmrCOwC?=
 =?us-ascii?q?C7HphObGBcFl+MCWvod5mDW/oUcyKdPMthkj0CVbi8RI4szg+utADkxLp9NO?=
 =?us-ascii?q?bU+TMXtYjl1Ndr4+3fjxYy9SZ7D5fV72bYd2xohCssTiIqxqp2qkw1nk+H2L?=
 =?us-ascii?q?VkmfZRPcZe6/NATkExMpuKnMJgDNWnYR7MZteETh6dR9yiBTwgBoYqz8Qmf1?=
 =?us-ascii?q?d2G9LkiAvKmSWtHelGxPSwGJUo//eEjDDKLMFnxiODjfNwgg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DUBgC8USde/wHyM5BlHQEBAQkBEQUFAYF7AoF7gRhVI?=
 =?us-ascii?q?BIqhBKJA4ZnAQEBBoESJYEBiG2PYoFnCQEBAQEBAQEBAS0KAQGEQAKCNjgTA?=
 =?us-ascii?q?hABAQEEAQEBAQEFAwEBbIU3DEIWAYFiKQGCegEFIxVBEAsOCgICJgICVwYNB?=
 =?us-ascii?q?gIBAYJjPwGCViUPrxqBMoVKgzWBOAaBDioBjC15gQeBEScMA4FfSTU+hAIvg?=
 =?us-ascii?q?yiCXgSXMkaXWoJDgkmEdI5uBhuady2XEpQ2IoFYKwgCGAghDzuCOAEBMlAYD?=
 =?us-ascii?q?ZEIhV0jAzACijiDUwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 21 Jan 2020 19:34:11 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00LJXUow161594;
        Tue, 21 Jan 2020 14:33:30 -0500
Subject: Re: [PATCH] libselinux: remove flask.h and av_permissions.h
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
References: <20200115155523.69438-1-sds@tycho.nsa.gov>
 <pjdh80vqivt.fsf@redhat.com> <pjdd0biq95r.fsf@redhat.com>
 <5d7eb243-1dbe-9c54-9cf6-b3e7cdfba7c7@tycho.nsa.gov>
 <3bf86683-05fd-e7fe-8808-5336b49b5932@tycho.nsa.gov>
 <pjd7e1kr4q9.fsf@redhat.com> <pjd5zh4r4i2.fsf@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8ae1bcf5-4728-8b88-d403-25081936fc7c@tycho.nsa.gov>
Date:   Tue, 21 Jan 2020 14:34:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <pjd5zh4r4i2.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/21/20 2:31 PM, Petr Lautrbach wrote:
> 
> Petr Lautrbach <plautrba@redhat.com> writes:
> 
>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>
>>> On 1/17/20 1:24 PM, Stephen Smalley wrote:
>>>> On 1/17/20 12:34 PM, Petr Lautrbach wrote:
>>>>>
>>>>> Petr Lautrbach <plautrba@redhat.com> writes:
>>>>>
>>>>>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>>>>>
>>>>>>> The flask.h and av_permissions.h header files were deprecated and
>>>>>>> all selinux userspace references to them were removed in
>>>>>>> commit 76913d8adb61b5 ("Deprecate use of flask.h and av_permissions.h.")
>>>>>>> back in 2014 and included in the 20150202 / 2.4 release.
>>>>>>> All userspace object managers should have been updated
>>>>>>> to use the dynamic class/perm mapping support since that time.
>>>>>>> Remove these headers finally to ensure that no users remain and
>>>>>>> that no future uses are ever introduced.
>>>>>>
>>>>>> I've patched libselinux and I'm building all packages which requires
>>>>>> libselinux-devel [1] in Fedora. I'm in the middle of package list and so far
>>>>>> there
>>>>>> are only 3 packages which fails to build without flask.h or
>>>>>> av_permission.h - libuser (the particular file wasn't updated since
>>>>>> 2012), ipsec-tools and mesa. When it's finished I'll investigate all
>>>>>> results, but I don't think there will be some blocker.
>>>>>>
>>>>>> [1]
>>>>>> https://copr.fedorainfracloud.org/coprs/plautrba/libselinux-without-flask.h/builds/
>>>>>>
>>>>>>
>>>>>
>>>>> So the complete list of Fedora packages dependent on selinux/flask.h is:
>>>>>
>>>>> xinetd
>>>>> usermode
>>>>> sed
>>>>> pam
>>>>> oddjob
>>>>> libuser
>>>>> ipsec-tools
>>>>>
>>>>> Problems are usually in tests or in Fedora specific patches. I'll start
>>>>> to work on fixes with affected maintainers.
>>>>
>>>> Great, thank you.  Hopefully the other patch for libsepol,checkpolicy to prune
>>>> its copy of flask.h of all SECCLASS_* definitions and take it private to
>>>> libsepol won't break anything.  With those two changes, we should be free of
>>>> any lingering uses of hardcoded class and permission definitions.  Then all we
>>>> need is for dbus-daemon to either set up a POLICYLOAD callback and re-fresh
>>>> its mapping at that time or switch over to looking up the class and
>>>> permissions each time as per the guidance in the updated libselinux man pages
>>>> (per my third patch) and userspace should be safe for class or permission
>>>> changes.
>>>
>>> Just wanted to check: you acked my patch so I assume it is ok to merge now even
>>> before the above packages are all updated but wanted to confirm.
>>
>> It's ok to merge it. It's better as a reference when it's merged, and pushed.
>>
>> I just wasn't sure if it's nor related to your other patches, but I
>> haven't time to check them yet..
> 
> And note that I have checked only Fedora (RHEL). OTOH if it's a problem
> in other distribution, selinux/flask.h can be patched into a distro package.

Ok, I've merged this patch now on selinux/master along with the man page 
patch.  I'll wait a bit on the libsepol,checkpolicy patch for removing 
its copy of {flask.h,av_permissions.h} to see if there are any comments 
on it.
