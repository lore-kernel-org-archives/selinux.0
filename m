Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F52C433E0
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F81D64EA1
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhBAOO3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231849AbhBAOO2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Feb 2021 09:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612188781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UI5GqjcFQspow3+abXaQs58FO7JYwy9g+u0Scm8Z36I=;
        b=Y0sZDHe1T2mXkPETeavn4nz9HH231AzFP0z5nw5gRyiH009z3DcXVoxUTQLd2QMPR+CfHx
        pjpINCEFtLWcHmmgpeYZG+RSF/I9QSDWp8zLFIFFif10TYIPwaTdRmSPrBD/BW1cZJlK0r
        G5NV/8Dpu7KjGQPkNYP1G6dRdl0UVP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-MkDqzNqEMRG1DQFja9A1lQ-1; Mon, 01 Feb 2021 09:12:59 -0500
X-MC-Unique: MkDqzNqEMRG1DQFja9A1lQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B716D107ACE3;
        Mon,  1 Feb 2021 14:12:58 +0000 (UTC)
Received: from localhost (unknown [10.40.192.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C49FA5D9DD;
        Mon,  1 Feb 2021 14:12:57 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH v3] libsemanage: sync filesystem with sandbox
In-Reply-To: <CAJfZ7=kpTbkjZPF7MdgxshvfbSWumN5+iMdAcN7Cypm6aiqH8w@mail.gmail.com>
References: <20210131110251.300553-1-plautrba@redhat.com>
 <CAJfZ7=kpTbkjZPF7MdgxshvfbSWumN5+iMdAcN7Cypm6aiqH8w@mail.gmail.com>
Date:   Mon, 01 Feb 2021 15:12:56 +0100
Message-ID: <87mtwnswpj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Sun, Jan 31, 2021 at 12:53 PM Petr Lautrbach <plautrba@redhat.com> wrote:
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
>> It looks like this situation can be avoided if the filesystem with the
>> sandbox is sync()ed before we start to rename() directories in the
>> store.
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Merged.

> Thanks!
> Nicolas
>
>> ---
>>
>> - syncfs() moved before rename() dance
>>
>>  libsemanage/src/semanage_store.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
>> index cd5e46bb2401..c6a736fe2d26 100644
>> --- a/libsemanage/src/semanage_store.c
>> +++ b/libsemanage/src/semanage_store.c
>> @@ -1736,6 +1736,19 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
>>         }
>>         close(fd);
>>
>> +       /* sync changes in sandbox to filesystem */
>> +       fd = open(sandbox, O_DIRECTORY);
>> +       if (fd == -1) {
>> +               ERR(sh, "Error while opening %s for syncfs(): %d", sandbox, errno);
>> +               return -1;
>> +       }
>> +       if (syncfs(fd) == -1) {
>> +               ERR(sh, "Error while syncing %s to filesystem: %d", sandbox, errno);
>> +               close(fd);
>> +               return -1;
>> +       }
>> +       close(fd);
>> +
>>         retval = commit_number;
>>
>>         if (semanage_get_active_lock(sh) < 0) {
>> --
>> 2.30.0
>>

