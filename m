Return-Path: <SRS0=0L3W=NU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BC0C43441
	for <selinux@archiver.kernel.org>; Fri,  9 Nov 2018 08:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF6C20827
	for <selinux@archiver.kernel.org>; Fri,  9 Nov 2018 08:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF6C20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeKISc7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:32:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbeKISc7 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 9 Nov 2018 13:32:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5228B8B107;
        Fri,  9 Nov 2018 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-194.brq.redhat.com [10.40.204.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F97319936;
        Fri,  9 Nov 2018 08:53:23 +0000 (UTC)
Subject: Re: [PATCH] python: replace aliases with corresponding type names
References: <CAJfZ7==UCR-a=mfLY1TRad++g+nbpZ6QMxFz5N6JV5_W6QomDQ@mail.gmail.com>
 <20181030152629.7438-1-vmojzis@redhat.com>
 <20181030152629.7438-2-vmojzis@redhat.com>
 <CAJfZ7==a_f6sJhHRwec1MkU70uOXZ0CLEqy7qK-53titStTWUQ@mail.gmail.com>
To:     nicolas.iooss@m4x.org
Cc:     selinux@vger.kernel.org
From:   Vit Mojzis <vmojzis@redhat.com>
Message-ID: <38deb58a-f063-58ff-6178-9e8d4c7ab946@redhat.com>
Date:   Fri, 9 Nov 2018 09:53:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJfZ7==a_f6sJhHRwec1MkU70uOXZ0CLEqy7qK-53titStTWUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 09 Nov 2018 08:53:24 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 05. 11. 18 21:51, Nicolas Iooss wrote:
> On Tue, Oct 30, 2018 at 4:27 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>> Aliases are not used in the selinux database. When user enters a type
>> alias as a parameter it should be converted to the corresponding type
>> in order to be processed correctly further in the userspace logic.
>>
>> Fixes e.g.:
>>
>> \#sepolicy transition -s phpfpm_t
>> /* where phpfpm_t is a type alias of httpd_t */
>>
>> Traceback (most recent call last):
>>    File "/usr/bin/sepolicy", line 691, in <module>
>>      args.func(args)
>>    File "/usr/bin/sepolicy", line 458, in transition
>>      mytrans = setrans(args.source, args.target)
>>    File "/usr/lib/python3.6/site-packages/sepolicy/transition.py", line 48, in __init__
>>      self._process(self.source)
>>    File "/usr/lib/python3.6/site-packages/sepolicy/transition.py", line 54, in _process
>>      trans = _get_trans(source)
>>    File "/usr/lib/python3.6/site-packages/sepolicy/transition.py", line 36, in _get_trans
>>      src_list = [src] + list(filter(lambda x: x['name'] == src, sepolicy.get_all_types_info()))[0]['attributes']
>> IndexError: list index out of range
>> ---
>>   python/semanage/seobject.py          | 43 ++++++++++++++++++++--------
>>   python/sepolicy/sepolicy.py          | 11 ++++---
>>   python/sepolicy/sepolicy/__init__.py | 14 ++++-----
>>   3 files changed, 45 insertions(+), 23 deletions(-)
>>
> [...]
>> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
>> index b18683e4..7db43957 100644
>> --- a/python/sepolicy/sepolicy/__init__.py
>> +++ b/python/sepolicy/sepolicy/__init__.py
>> @@ -172,7 +172,7 @@ def info(setype, name=None):
>>           results = list(q.results())
>>
>>           if name and len(results) < 1:
>> -            # type not found, try alias
>> +            #type not found, try alias
>>               q.name = None
>>               q.alias = name
>>               results = list(q.results())
> Hi, your patch looks good to me, but the comments you are using do not
> follow PEP-8 (https://www.python.org/dev/peps/pep-0008/#block-comments)
> and raise warnings in some linters that I am using. For example,
> flake8 reports:
>
> python/sepolicy/sepolicy/__init__.py:172:13: E265 block comment should
> start with '# '
> python/sepolicy/sepolicy/__init__.py:1072:9: E265 block comment should
> start with '# '
>
> I would like to apply the patch with the spaces added between "#" and
> the comment line. Does it suits you?


Sure, whatever needs fixing.

Thank you :)


> Otherwise, I will submit a patch
> to fix the comments after applying this patch.
>
> Thanks,
> Nicolas
>
