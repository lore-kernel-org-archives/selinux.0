Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEDEC433DB
	for <selinux@archiver.kernel.org>; Sun, 31 Jan 2021 10:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3449F64E0E
	for <selinux@archiver.kernel.org>; Sun, 31 Jan 2021 10:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhAaKhn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 31 Jan 2021 05:37:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230523AbhAaKSk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 31 Jan 2021 05:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612088231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XVjgrgSxu+Q6QL/yO5HoiOq3M7MLy7evplZiUDyXGzg=;
        b=e8wpE4VYuvHr2/7cMdeSu9vLLr/TDbO4of5JA8ISIlyl1lGFxiIuK1vUcz8MZXwb291dj4
        //sCa55osywRP1jUxebOEP+OOx4+VK+7ql6VOZIYaFxpVJRWcy5HJwUyvekAG1Bor/DVMR
        WH/YAB1pQTwwKQffwsN4/x84PXBQ6sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-GpN9y5lQP7-8hoIPtxKRVw-1; Sun, 31 Jan 2021 05:17:09 -0500
X-MC-Unique: GpN9y5lQP7-8hoIPtxKRVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F0318015DA;
        Sun, 31 Jan 2021 10:17:08 +0000 (UTC)
Received: from localhost (unknown [10.40.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9643E60C0F;
        Sun, 31 Jan 2021 10:17:07 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH v2] libsemanage: sync filesystem with sandbox
In-Reply-To: <CAJfZ7=kwaQcrDKF+2b4K4EPezXdRec_E7Fuia5FPY2xNWPF9rA@mail.gmail.com>
References: <20210128102741.101112-1-plautrba@redhat.com>
 <20210128104231.102470-1-plautrba@redhat.com>
 <CAJfZ7=kwaQcrDKF+2b4K4EPezXdRec_E7Fuia5FPY2xNWPF9rA@mail.gmail.com>
Date:   Sun, 31 Jan 2021 11:17:06 +0100
Message-ID: <878s89o1gd.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Thu, Jan 28, 2021 at 11:44 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Commit 331a109f91ea ("libsemanage: fsync final files before rename")
>> added fsync() for policy files and improved situation when something
>> unexpected happens right after rename(). However the module store could
>> be affected as well. After the following steps module files could be 0
>> size:
>>
>> 1. Run `semanage fcontext -a -t var_t "/tmp/abc"`
>> 2. Force shutdown the server during the command is run, or right after
>>    it's finished
>> 3. Boot the system and look for empty files:
>>     # find /var/lib/selinux/targeted/ -type f -size 0 | wc -l
>>     1266
>>
>> It looks like this situation can be avoided it the filesystem with the
>> store is sync()ed before rename()
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>
>> - fixed close(fd) indentation
>>
>>  libsemanage/src/semanage_store.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
>> index cd5e46bb2401..9a81be54db60 100644
>> --- a/libsemanage/src/semanage_store.c
>> +++ b/libsemanage/src/semanage_store.c
>> @@ -1764,6 +1764,21 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
>>         /* clean up some files from the sandbox before install */
>>         /* remove homedir_template from sandbox */
>>
>> +       /* sync filesystem with sandbox first */
>> +       fd = open(sandbox, O_DIRECTORY);
>> +       if (fd == -1) {
>> +               ERR(sh, "Error while opening %s for syncfs(): %d", sandbox, errno);
>> +               retval = -1;
>> +               goto cleanup;
>> +       }
>> +       if (syncfs(fd) == -1) {
>> +               ERR(sh, "Error while syncing %s to filesystem: %d", sandbox, errno);
>> +               close(fd);
>> +               retval = -1;
>> +               goto cleanup;
>> +       }
>> +       close(fd);
>> +
>>         if (rename(sandbox, active) == -1) {
>>                 ERR(sh, "Error while renaming %s to %s.", sandbox, active);
>>                 /* note that if an error occurs during the next
>> --
>> 2.30.0
>>
> Hello,
>
> The sync logic seems to be fine, but why does it happen between
> rename(active, backup) and rename(sandbox, active)? It feels more
> logical to me if the syncing (which could take time) was done before
> the rename dance (so before rename(active, backup)). Nevertheless I
> could be missing something to understand your choice. If it is so, a
> comment about why syncfs() is done after rename(active, backup) would
> be very useful.
>

My original idea was to do syncfs(sandbox) just before sandbox is
renamed to active. But you are right that it should happen before
rename(active, backup) as if syncfs() failed there would be no active
anymore. I'll send another patch.


Thanks!

Petr

