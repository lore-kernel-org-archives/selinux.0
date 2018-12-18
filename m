Return-Path: <SRS0=zZcK=O3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B8EC43387
	for <selinux@archiver.kernel.org>; Tue, 18 Dec 2018 12:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FE92080D
	for <selinux@archiver.kernel.org>; Tue, 18 Dec 2018 12:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeLRMZA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:25:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33527 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbeLRMZA (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 18 Dec 2018 07:25:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5011C05E767;
        Tue, 18 Dec 2018 12:24:59 +0000 (UTC)
Received: from workstation (unknown [10.43.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 014FA608C2;
        Tue, 18 Dec 2018 12:24:58 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] python/sepolicy: search() also for dontaudit rules
References: <20181212152826.24140-1-plautrba@redhat.com>
        <CAJfZ7==ehVcSkb1NdMch1mErAVMTevWuvQzd_JdTsmkb2WOsUQ@mail.gmail.com>
Date:   Tue, 18 Dec 2018 13:24:57 +0100
In-Reply-To: <CAJfZ7==ehVcSkb1NdMch1mErAVMTevWuvQzd_JdTsmkb2WOsUQ@mail.gmail.com>
        (Nicolas Iooss's message of "Sat, 15 Dec 2018 16:28:12 +0100")
Message-ID: <pjd4lbbuina.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 18 Dec 2018 12:24:59 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Wed, Dec 12, 2018 at 4:28 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> dontaudit rules were accidentally dropped during rewrite to SETools 4 API in
>> 97d5f6a2
>>
>> Fixes:
>> >>> import sepolicy
>> >>> sepolicy.search(['dontaudit'])
>> []
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Merged.

>> ---
>>
>> Same patch as https://lore.kernel.org/selinux/20180918134401.22956-1-plautrba@redhat.com/
>> but with a slightly reworded commit message
>>
>>  python/sepolicy/sepolicy/__init__.py | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
>> index cd7af7cf..fbeb731d 100644
>> --- a/python/sepolicy/sepolicy/__init__.py
>> +++ b/python/sepolicy/sepolicy/__init__.py
>> @@ -344,6 +344,8 @@ def search(types, seinfo=None):
>>          tertypes.append(NEVERALLOW)
>>      if AUDITALLOW in types:
>>          tertypes.append(AUDITALLOW)
>> +    if DONTAUDIT in types:
>> +        tertypes.append(DONTAUDIT)
>>
>>      if len(tertypes) > 0:
>>          q = setools.TERuleQuery(_pol,
>> --
>> 2.19.2
>>
