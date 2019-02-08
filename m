Return-Path: <SRS0=wfIc=QP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF33C169C4
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 16:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E771B2080F
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 16:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBHQqS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:46:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfBHQqS (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 8 Feb 2019 11:46:18 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 741C36EB93;
        Fri,  8 Feb 2019 16:46:17 +0000 (UTC)
Received: from localhost (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA6121077D1C;
        Fri,  8 Feb 2019 16:46:16 +0000 (UTC)
References: <20190206194529.24952-1-plautrba@redhat.com> <CAJfZ7=nBvZHQ6Uq4GXK=0mxf1iBt8TQEVCkOZd4mNoW4OV7NSg@mail.gmail.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH] libsemanage: genhomedircon - improve handling large groups
In-reply-to: <CAJfZ7=nBvZHQ6Uq4GXK=0mxf1iBt8TQEVCkOZd4mNoW4OV7NSg@mail.gmail.com>
Date:   Fri, 08 Feb 2019 17:46:15 +0100
Message-ID: <pjdimxuxm7c.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 08 Feb 2019 16:46:17 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Wed, Feb 6, 2019 at 8:45 PM Petr Lautrbach 
> <plautrba@redhat.com> wrote:
>>
>> getgrnam_r() uses a preallocated buffer to store a structure 
>> containing
>> the broken-out fields of the record in the group database. The 
>> size of
>> this buffer is usually sysconf(_SC_GETGR_R_SIZE_MAX) == 1024 
>> and it is
>> not enough for groups with a large number of users.  In these 
>> cases,
>> getgrnam_r() returns -1 and sets errno to ERANGE and the caller 
>> can
>> retry with a larger buffer.
>>
>> Fixes:
>> $ semanage login -a -s user_u -r s0-s0:c1.c2 '%largegroup'
>> libsemanage.semanage_direct_commit: semanage_genhomedircon 
>> returned error code -1. (Numerical result out of range).
>> OSError: Numerical result out of range
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>  libsemanage/src/genhomedircon.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/libsemanage/src/genhomedircon.c 
>> b/libsemanage/src/genhomedircon.c
>> index 591941fb..ac376671 100644
>> --- a/libsemanage/src/genhomedircon.c
>> +++ b/libsemanage/src/genhomedircon.c
>> @@ -1077,10 +1077,20 @@ static int 
>> get_group_users(genhomedircon_settings_t * s,
>>
>>         const char *grname = selogin + 1;
>>
>> -       if (getgrnam_r(grname, &grstorage, grbuf,
>> -                       (size_t) grbuflen, &group) != 0) {
>> -               goto cleanup;
>> +       errno = 0;
>> +       while (
>> +               (retval = getgrnam_r(grname, &grstorage, grbuf, 
>> (size_t) grbuflen, &group)) != 0 &&
>> +               errno == ERANGE
>> +       ) {
>> +               char *new_grbuf;
>> +               grbuflen *= 2;
>> +               new_grbuf = realloc(grbuf, grbuflen);
>> +               if (new_grbuf == NULL)
>> +                       goto cleanup;
>> +               grbuf = new_grbuf;
>>         }
>
> Hello,
> When reading this for loop, I am concerned about the case where 
> the
> member list exceeds 2Go on a system with a 32-bit CPU (where
> sizeof(long) = 4). Even if it seems very unlikely, if this ever
> happens, the loop will become infinite. Would you agree with 
> adding
> "&& grbuflen > 0" to the condition of the while statement?

Makes sense, I'll add it. Thanks.

> Anyway, if you do not agree, this patch looks good to me.
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Thanks,
> Nicolas
>
>> +       if (retval == -1)
>> +               goto cleanup;

According to the man page this check is not correct. - "In case of
error, an error number is returned, and NULL is stored in 
*result."

I'll fix it as well.


>>         if (group == NULL) {
>>                 ERR(s->h_semanage, "Can't find group named 
>>                 %s\n", grname);
>> --
>> 2.20.1
>>

