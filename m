Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE338C43333
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 02:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962AA23442
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 02:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbhAMWcg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 17:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729369AbhAMWbo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 17:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610577016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1per2+WyWG7z5VOEKC1vqd1McOI3IxnQzAqIlehPFpg=;
        b=gK/Ttec3m92VjH0iV15bVp+tYDJvQPjxtP5r5Mrew2qCmP38HOcVmHDeKSfVqRh4ryT4xk
        c5zIKXOVgPnxfJR34R7qX/jiINpaeTW2PPvhD5HANjLecm9A5AS8AIT6qYYZPzY3FL/JlF
        FK1ecsROpDQqWsiu+QK0491yJ0kVfMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-ZHujTGQ8POiREG_CChgf7Q-1; Wed, 13 Jan 2021 17:30:14 -0500
X-MC-Unique: ZHujTGQ8POiREG_CChgf7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F163180A095;
        Wed, 13 Jan 2021 22:30:13 +0000 (UTC)
Received: from localhost (unknown [10.40.193.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F31635D9C0;
        Wed, 13 Jan 2021 22:30:12 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH] libsepol: destroy filename_trans list properly
In-Reply-To: <CAFqZXNs6n8Ta=z+MUG6XgwJVpbeoSdfuZ9r8fm0toDwRP+ukhg@mail.gmail.com>
References: <20210106081922.450743-1-nicolas.iooss@m4x.org>
 <CAFqZXNs6n8Ta=z+MUG6XgwJVpbeoSdfuZ9r8fm0toDwRP+ukhg@mail.gmail.com>
Date:   Wed, 13 Jan 2021 23:30:12 +0100
Message-ID: <87r1moa2rv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Wed, Jan 6, 2021 at 9:22 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>> OSS-Fuzz found a direct memory leak in policydb_filetrans_insert()
>> because filenametr_destroy() does not fully destroy the list associated
>> with a typetransition.
>>
>> More precisely, let's consider this (minimized) CIL policy:
>>
>>     (class CLASS (PERM))
>>     (classorder (CLASS))
>>     (sid SID)
>>     (sidorder (SID))
>>     (user USER)
>>     (role ROLE)
>>     (type TYPE) ; "type 1" in libsepol internal structures
>>     (type TYPE2) ; "type 2" in libsepol internal structures
>>     (type TYPE3) ; "type 3" in libsepol internal structures
>>     (category CAT)
>>     (categoryorder (CAT))
>>     (sensitivity SENS)
>>     (sensitivityorder (SENS))
>>     (sensitivitycategory SENS (CAT))
>>     (allow TYPE self (CLASS (PERM)))
>>     (roletype ROLE TYPE)
>>     (userrole USER ROLE)
>>     (userlevel USER (SENS))
>>     (userrange USER ((SENS)(SENS (CAT))))
>>     (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
>>
>>     (typetransition TYPE2 TYPE CLASS "some_file" TYPE2)
>>     (typetransition TYPE3 TYPE CLASS "some_file" TYPE3)
>>
>> The two typetransition statements make policydb_filetrans_insert()
>> insert an item with key {ttype=1, tclass=1, name="some_file"} in the
>> hashmap p->filename_trans. This item contains a linked list of two
>> filename_trans_datum_t elements:
>>
>> * The first one uses {otype=2, stypes=bitmap containing 2}
>> * The second one uses {otype=3, stypes=bitmap containing 3}
>>
>> Nevertheless filenametr_destroy() (called by
>> hashtab_map(p->filename_trans, filenametr_destroy, NULL);) only frees
>> the first element. Fix this memory leak by freeing all elements.
>>
>> This issue was introduced by commit 42ae834a7428 ("libsepol,checkpolicy:
>> optimize storage of filename transitions") and was never present in the
>> kernel, as filenametr_destroy() was modified appropriately in commit
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b
>
> Ouch, good catch!
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Merged, thanks!


>>
>> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29138
>
> I get "Permission denied" when opening this link. Any chance it could
> be made public?
>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> ---
>>  libsepol/src/policydb.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
>> index f43d5c67463e..71ada42ca609 100644
>> --- a/libsepol/src/policydb.c
>> +++ b/libsepol/src/policydb.c
>> @@ -1462,12 +1462,16 @@ static int filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
>>                               void *p __attribute__ ((unused)))
>>  {
>>         filename_trans_key_t *ft = (filename_trans_key_t *)key;
>> -       filename_trans_datum_t *fd = datum;
>> +       filename_trans_datum_t *fd = datum, *next;
>>
>>         free(ft->name);
>>         free(key);
>> -       ebitmap_destroy(&fd->stypes);
>> -       free(datum);
>> +       do {
>> +               next = fd->next;
>> +               ebitmap_destroy(&fd->stypes);
>> +               free(fd);
>> +               fd = next;
>> +       } while (fd);
>>         return 0;
>>  }
>>
>> --
>> 2.30.0
>>
>
> -- 
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.

