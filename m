Return-Path: <SRS0=10e4=NC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3039C004D3
	for <selinux@archiver.kernel.org>; Mon, 22 Oct 2018 15:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DEE2064C
	for <selinux@archiver.kernel.org>; Mon, 22 Oct 2018 15:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DEE2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeJVX7Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:59:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbeJVX7Q (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 22 Oct 2018 19:59:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6164C04D306
        for <selinux@vger.kernel.org>; Mon, 22 Oct 2018 15:40:14 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-155.brq.redhat.com [10.40.204.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38FB3798A5
        for <selinux@vger.kernel.org>; Mon, 22 Oct 2018 15:40:14 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH 2/3] python/sepolicy: Stop rejecting aliases in sepolicy commands
Date:   Mon, 22 Oct 2018 17:40:01 +0200
Message-Id: <20181022154003.19309-1-vmojzis@redhat.com>
In-Reply-To: <CAJfZ7=nSsAKJ=MB6HiZ3mDE3kVa4Yx8imkVDsq-ngC-2O8Vfpg@mail.gmail.com>
References: <CAJfZ7=nSsAKJ=MB6HiZ3mDE3kVa4Yx8imkVDsq-ngC-2O8Vfpg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 22 Oct 2018 15:40:14 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 21. 10. 18 11:20, Nicolas Iooss wrote:> On Sun, Oct 21, 2018 at 11:10 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>>
>> On Tue, Oct 16, 2018 at 12:05 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>>>
>>> Fix CheckDomain and CheckPortType classes to properly deal with aliases.
>>>
>>> Resolves:
>>>     https://bugzilla.redhat.com/show_bug.cgi?id=1600009
>>>
>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>>> ---
>>>   python/sepolicy/sepolicy.py          |  8 +++-----
>>>   python/sepolicy/sepolicy/__init__.py | 10 +++++++++-
>>>   2 files changed, 12 insertions(+), 6 deletions(-)
>>>
>> [...]
>>> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
>>> index 8484b28c..0da3917b 100644
>>> --- a/python/sepolicy/sepolicy/__init__.py
>>> +++ b/python/sepolicy/sepolicy/__init__.py
>>> @@ -447,6 +447,14 @@ def get_file_types(setype):
>>>       return mpaths
>>>
>>>
>>> +# determine if entered type is an alias
>>> +# and return corresponding type name
>>> +def get_real_type_name(name):
>>> +    try:
>>> +        return next(info(TYPE, name))["name"]
>>> +    except (RuntimeError, StopIteration):
>>> +        return None
>>> +
>>
>> When I first read the function comment, I did not understand whether
>> the returned value was a kind of SELinux type (like something which
>> would say "a file type", "a port type") or the SELinux type which is
>> aliased. It is the second interpretation which is implemented.
>> Moreover, this comment seems to be better in a function docstring. I
>> suggest changing this into the following:
>>
>> def get_real_type_name(name):
>>      """Return the real name of a type:
>>
>>      * If 'name' refers to a type, return the same name.
>>      * If 'name' refers to a type alias, return the corresponding name.
>>      * Otherwise return None.
>>      """
>>
>> What do you think of this suggestion?
>>
>> Moreover, when is RuntimeError triggered, in the exception that are caught?

Catching RuntimeError ensures compatibility with setools3, which
triggers this exception instead of returning empty list.

> 
> Also, if name is empty, sepolicy.info(TYPE, name) returns all
> available types, so get_real_type_name("") returns the first type in
> the list of types defined in the policy. I saw that your patches use
> "if setype and sepolicy.get_real_type_name(setype) not in
> self.valid_types" in many places (which looks good). To increase the
> robustness of the Python code, I would also add a test in
> get_real_type_name as well, like:
> 
>      if not name:
>          return None

Good point, thank you.

> 
> Nicolas
> 


