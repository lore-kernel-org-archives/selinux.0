Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D8C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 13:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5853A218AC
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 13:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbfBON4o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:56:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbfBON4o (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 15 Feb 2019 08:56:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69889C057F9A;
        Fri, 15 Feb 2019 13:56:44 +0000 (UTC)
Received: from workstation (unknown [10.40.205.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A66F060C62;
        Fri, 15 Feb 2019 13:56:43 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH v2] libsemanage: genhomedircon - improve handling large groups
References: <pjdimxuxm7c.fsf@redhat.com>
        <20190212152046.13875-1-plautrba@redhat.com>
        <CAJfZ7=kFKx6cz1Tj1impdii4iDKfKtC_LffBTW3Rfg1fEJkHzA@mail.gmail.com>
Date:   Fri, 15 Feb 2019 14:56:41 +0100
In-Reply-To: <CAJfZ7=kFKx6cz1Tj1impdii4iDKfKtC_LffBTW3Rfg1fEJkHzA@mail.gmail.com>
        (Nicolas Iooss's message of "Tue, 12 Feb 2019 22:02:18 +0100")
Message-ID: <pjd1s49noiu.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 15 Feb 2019 13:56:44 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Tue, Feb 12, 2019 at 4:20 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> getgrnam_r() uses a preallocated buffer to store a structure containing
>> the broken-out fields of the record in the group database. The size of
>> this buffer is usually sysconf(_SC_GETGR_R_SIZE_MAX) == 1024 and it is
>> not enough for groups with a large number of users.  In these cases,
>> getgrnam_r() returns -1 and sets errno to ERANGE and the caller can
>> retry with a larger buffer.
>>
>> Fixes:
>> $ semanage login -a -s user_u -r s0-s0:c1.c2 '%largegroup'
>> libsemanage.semanage_direct_commit: semanage_genhomedircon returned error code -1. (Numerical result out of range).
>> OSError: Numerical result out of range
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

>> ---
>>  libsemanage/src/genhomedircon.c | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
>> index 591941fb..e5f8d371 100644
>> --- a/libsemanage/src/genhomedircon.c
>> +++ b/libsemanage/src/genhomedircon.c
>> @@ -1077,10 +1077,24 @@ static int get_group_users(genhomedircon_settings_t * s,
>>
>>         const char *grname = selogin + 1;
>>
>> -       if (getgrnam_r(grname, &grstorage, grbuf,
>> -                       (size_t) grbuflen, &group) != 0) {
>> -               goto cleanup;
>> +       errno = 0;
>> +       while (
>> +               (retval = getgrnam_r(grname, &grstorage, grbuf, (size_t) grbuflen, &group)) != 0 &&
>> +               errno == ERANGE
>> +       ) {
>> +               char *new_grbuf;
>> +               grbuflen *= 2;
>> +               if (grbuflen < 0)
>> +                       /* the member list could exceed 2Gb on a system with a 32-bit CPU (where
>> +                        * sizeof(long) = 4) - if this ever happened, the loop would become infinite. */
>> +                       goto cleanup;
>> +               new_grbuf = realloc(grbuf, grbuflen);
>> +               if (new_grbuf == NULL)
>> +                       goto cleanup;
>> +               grbuf = new_grbuf;
>>         }
>> +       if (retval != 0)
>> +               goto cleanup;
>>
>>         if (group == NULL) {
>>                 ERR(s->h_semanage, "Can't find group named %s\n", grname);
>> --
>> 2.20.1
>>
