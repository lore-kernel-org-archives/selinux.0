Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC869C49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 19:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D83206C2
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 19:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="bJHnKynw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfIPTpD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:45:03 -0400
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:50620 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbfIPTpD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 15:45:03 -0400
X-EEMSG-check-017: 14421689|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="14421689"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 19:44:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568663096; x=1600199096;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZGN/7bGbjcH6ZO1JOeVzZy6XnJUvKQw0HKi7ayTJUyI=;
  b=bJHnKynwJ5QdOEGwcc90hfACbzXXaAl1K4eRNIab3CQ4k4VzQzGA2EsR
   H7P2i21DgSKkldMcQLnXBQmONccU8F/E7UUAe09KTmjiy7AJhBEAMD5eP
   QaRaR0uZd+LI1/n+V2Dleo226sQg+JmWfRcTBdYV6GqDG3JSeaWPOEvwN
   EbWt3lPgfY7t3yrsNmx3ALsW2iYT7t50HCpy5iOwbd64YP3WWgV9qfhKS
   MkXjwojgWbBs9kRihDwu20uCD3hL2qTJlpmMKXQLb/df/MUQDBMzTBUYF
   glt2BrzZtIXAErhsWsYZuPqiqv/nAMoq35BbcwcwaWKDhQcssFauf9Kj9
   g==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="32913916"
IronPort-PHdr: =?us-ascii?q?9a23=3AXzeurxwhXWCXkt3XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoSIvad9pjvdHbS+e9qxAeQG9mCsLQd0KGP7/moGTRZp8rY6jZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8cbjZF/Jqs/xR?=
 =?us-ascii?q?fFv3RFd/lLzm9sOV6fggzw68it8JJ96Shcp+4t+8tdWqjmYqo0SqBVAi47OG?=
 =?us-ascii?q?4v/s3rshfDTQqL5nQCV2gdjwRFDQvY4hzkR5n9qiT1uPZz1ymcJs32UKs7WS?=
 =?us-ascii?q?++4KdxSR/nkzkIOjgk+2zKkMNwjaZboBW8pxxjxoPffY+YOOZicq7bYNgXXn?=
 =?us-ascii?q?RKUNpPWCNdA4O8d4oPAPQHPeZEtIn2ul8CoQKjCQWwGO/jzzlFiXHs3a0+zu?=
 =?us-ascii?q?8vDwfI0gI9FN4KqXjYstH4OKIUXOuozqfH0C/DYutL1zn99obIfBMvr/+CUr?=
 =?us-ascii?q?1/c8Xe1UYhGhjZjliTs4HpIy+Z2+oPvmWd8uFuVfivi2kiqwxpvzav2tkjip?=
 =?us-ascii?q?HJho0LzFDP6Dh3wIMvKt28TE50f96lG4ZXuiGBKoR2WdgvQ31ouSkmyr0Gvo?=
 =?us-ascii?q?S3fC4RyJs93RLfZPuHc5aR7x/lSe2fIi94iWp4dL+wiBu+60itxvDmWsWq31?=
 =?us-ascii?q?tGsDBJnsTKu3sQzRLc8NKHReF4/kq53DaP0B3c5f9cLEAvkKrbN4Yhwrktlp?=
 =?us-ascii?q?oPqUjDHjH5mEHxjKKOakUr4PKo6+X6YrX9vJOcK491hR3+MqQpgMC/B/g3Mh?=
 =?us-ascii?q?MSUGSB/OS81bnj8VX4QLVMkPI2jrHUvI3VKMkUvKK0AxJZ3pw95xuwETuqys?=
 =?us-ascii?q?kUkWECLF1feRKHi4bpO0vJIPD9Ffq/mEmjkCxwyvDaPrzuHpXNLn/ZnLfnZr?=
 =?us-ascii?q?Zy8VRQyAU0zdBB/55UEK0OIOrvWk/ts9zVFgI2PBa0w+n7CNVyzIUeWXmIAq?=
 =?us-ascii?q?+fK67SvlqI6fguI+mIfoMapDH9K/097f70kXA5gUMdfbWu3ZYPbnC4H+hpI0?=
 =?us-ascii?q?KdYXX2mdcNC2YKvg05TOzxk12PSjtTanm9Xq4m4TE7Eo2mB5/ZRo+xmLyBwD?=
 =?us-ascii?q?u7HppOa2BYD1CMFnXodoSFW/cXcy+SONFunSEEVbe7V48tzw2htAj/y7B/NO?=
 =?us-ascii?q?rb5jUYtY7/1Nhy/+DTjg899Th1D8SbzmGMQHp5nn0HRzAoxqBzu099xUmZ0a?=
 =?us-ascii?q?h+nfNYEcZf5/RTUgc1ZtbgyLlRC9n+EiLIeMyOTh7yTtymCjE4SMk2xfcBZk?=
 =?us-ascii?q?98H5OpiRWVm2KMArQSk7WQTL0z9bnHlyz3Js16z3/dkqgmiEI9as4TJSuhnK?=
 =?us-ascii?q?EppCbJAIucqFmUj6anc+wn2SfJ8GqShT6VsFpwTB97UaKDW2sWIETRs4KqtQ?=
 =?us-ascii?q?v5U7ayBOF/YUN6wsmYJ/4PM4e4gA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BmAABv5X9d/wHyM5BmHAEBAQQBAQcEAQGBUwcBAQsBg?=
 =?us-ascii?q?W0qgT8BMiqEIYgchzoBAQEBAQEGgREliXOPLIF7CQEBAQEBAQEBATQBAgEBh?=
 =?us-ascii?q?D8Cgm8jNAkOAgwBAQEEAQEBAQEFAwEBbIU6gjopAYJnAQUjDwEFQRAJAg4KA?=
 =?us-ascii?q?gImAgJXBgEMBgIBAYJfP4F3FJFrm2+BMokDgUmBDCgBhH+GeBh4gQeBOAyCX?=
 =?us-ascii?q?z6HT4JYBJ4Mjl6CLIIukkwGG4I1h0ePHY4Jmnw4gVgrCAIYCCEPgyeRIyQDM?=
 =?us-ascii?q?IEGAQGPbgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Sep 2019 19:44:54 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GJip63027655;
        Mon, 16 Sep 2019 15:44:51 -0400
Subject: Re: [PATCH 2/2] Fix mcstrans secolor examples
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Chad Hanson <dahchanson@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
References: <20190702120905.9808-1-vmojzis@redhat.com>
 <20190702120905.9808-2-vmojzis@redhat.com>
 <CAJfZ7=nZ3mVRFD6d5OGq+r1srH+8bRr-hKeLi3kpc_bx3W5yTw@mail.gmail.com>
 <CAOFCXecb5Z_d+iSqda-yHaQRgEsonHJEZx4MQut89t8E4CQ9BA@mail.gmail.com>
 <7762a815-65b6-b57c-7c03-38303ccf1d25@tycho.nsa.gov>
Message-ID: <772f365c-5719-c509-6605-c7416cd4b9e6@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 15:44:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7762a815-65b6-b57c-7c03-38303ccf1d25@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/13/19 11:33 AM, Stephen Smalley wrote:
> On 7/31/19 1:15 AM, Chad Hanson wrote:
>> I agree the secolor configuration file is lacking consistency. From a
>> historical MLS perspective, there were two special labels in many MLS
>> systems: SystemLow and SystemHigh.  This would be "s0" (lowest
>> level/no categories)  and "s15:c0.c1023" (highest level/all
>> categories) respectively.  At these special  levels, there was
>> traditionally no other category usage.
>>
>> I concur we either do the proposed change in this patch or just change
>> the "s0:c0.c1023" lines to just "s0" (SystemLow) to be consistent with
>> the "s15:c0.c1023" (SystemHigh) range that exists currently. They will
>> both provide the desired results.
> 
> I see that these two patches were never merged and still apply.  Does 
> anyone have any objection to merging them both?

Both patches applied.

> 
>>
>> -Chad
>>
>>
>> On Mon, Jul 29, 2019 at 5:41 PM Nicolas Iooss <nicolas.iooss@m4x.org> 
>> wrote:
>>>
>>> On Tue, Jul 2, 2019 at 2:09 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>>>>
>>>> According to "check_dominance" function:
>>>> Range defined as "s15:c0.c1023" does not dominate any other range than
>>>>   "s15:c0.c1023" (does not dominate "s15", "s15:c0.c200", etc.).
>>>> While range defined as "s15-s15:c0.c1023" dominates all of the above.
>>>>
>>>> This is either a bug, or "s15:c0.c1023" should not be used in the
>>>> examples.
>>>
>>> Hello,
>>> I am not familiar with the concepts about range dominance, so I do not
>>> know whether this is a bug that should be fixed or if updating the
>>> examples is better. Can someone please review this?
>>>
>>> Cheers,
>>> Nicolas
>>>
>>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>>>> ---
>>>>   libselinux/man/man5/secolor.conf.5                      | 4 ++--
>>>>   libselinux/man/ru/man5/secolor.conf.5                   | 4 ++--
>>>>   mcstrans/share/examples/urcsts-via-include/secolor.conf | 2 +-
>>>>   mcstrans/share/examples/urcsts/secolor.conf             | 2 +-
>>>>   4 files changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/libselinux/man/man5/secolor.conf.5 
>>>> b/libselinux/man/man5/secolor.conf.5
>>>> index b834577a..a3bf2da1 100644
>>>> --- a/libselinux/man/man5/secolor.conf.5
>>>> +++ b/libselinux/man/man5/secolor.conf.5
>>>> @@ -123,7 +123,7 @@ range s7\-s7:c0.c1023 = black red
>>>>   .br
>>>>   range s9\-s9:c0.c1023 = black orange
>>>>   .br
>>>> -range s15:c0.c1023   = black yellow
>>>> +range s15\-s15:c0.c1023   = black yellow
>>>>   .RE
>>>>
>>>>   .sp
>>>> @@ -165,7 +165,7 @@ type xguest_t     = black green
>>>>   .br
>>>>   user sysadm_u     = white black
>>>>   .br
>>>> -range s0:c0.c1023 = black white
>>>> +range s0-s0:c0.c1023 = black white
>>>>   .br
>>>>   user *            = black white
>>>>   .br
>>>> diff --git a/libselinux/man/ru/man5/secolor.conf.5 
>>>> b/libselinux/man/ru/man5/secolor.conf.5
>>>> index 4c1236ae..bcae80c1 100644
>>>> --- a/libselinux/man/ru/man5/secolor.conf.5
>>>> +++ b/libselinux/man/ru/man5/secolor.conf.5
>>>> @@ -121,7 +121,7 @@ range s7\-s7:c0.c1023 = black red
>>>>   .br
>>>>   range s9\-s9:c0.c1023 = black orange
>>>>   .br
>>>> -range s15:c0.c1023   = black yellow
>>>> +range s15\-s15:c0.c1023   = black yellow
>>>>   .RE
>>>>
>>>>   .sp
>>>> @@ -163,7 +163,7 @@ type xguest_t     = black green
>>>>   .br
>>>>   user sysadm_u     = white black
>>>>   .br
>>>> -range s0:c0.c1023 = black white
>>>> +range s0\-s0:c0.c1023 = black white
>>>>   .br
>>>>   user *            = black white
>>>>   .br
>>>> diff --git a/mcstrans/share/examples/urcsts-via-include/secolor.conf 
>>>> b/mcstrans/share/examples/urcsts-via-include/secolor.conf
>>>> index d35b3c67..3b3f5430 100644
>>>> --- a/mcstrans/share/examples/urcsts-via-include/secolor.conf
>>>> +++ b/mcstrans/share/examples/urcsts-via-include/secolor.conf
>>>> @@ -17,5 +17,5 @@ range s3-s3:c0.c1023 = black tan
>>>>   range s5-s5:c0.c1023 = white blue
>>>>   range s7-s7:c0.c1023 = black red
>>>>   range s9-s9:c0.c1023 = black orange
>>>> -range s15:c0.c1023 = black yellow
>>>> +range s15-s15:c0.c1023 = black yellow
>>>>
>>>> diff --git a/mcstrans/share/examples/urcsts/secolor.conf 
>>>> b/mcstrans/share/examples/urcsts/secolor.conf
>>>> index d35b3c67..3b3f5430 100644
>>>> --- a/mcstrans/share/examples/urcsts/secolor.conf
>>>> +++ b/mcstrans/share/examples/urcsts/secolor.conf
>>>> @@ -17,5 +17,5 @@ range s3-s3:c0.c1023 = black tan
>>>>   range s5-s5:c0.c1023 = white blue
>>>>   range s7-s7:c0.c1023 = black red
>>>>   range s9-s9:c0.c1023 = black orange
>>>> -range s15:c0.c1023 = black yellow
>>>> +range s15-s15:c0.c1023 = black yellow
>>>>
>>>> -- 
>>>> 2.17.2
>>>>
>>>
> 

