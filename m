Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369E6C433E0
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05D164F68
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhBCIfs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 03:35:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232710AbhBCIfr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 03:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612341259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKq55L2mqVhZMZdJ8VjVfgZsJZRP+wc1k9g1tbdCfOc=;
        b=EwB2Joz3I60MTw46S4Z7ZyF5WUAuD9yROYKewuqW32lWEBDcjrszZtcansvFgIYYW4qMv9
        /CdJRW+lCAzzqvNLybCXC+aHC+8DrgMIdHYkSmDwnhrIeCWJEXx6lUG1MfkOizdMn3ZzVc
        fSY7XEe573eGVWKoR8z4plRAqkp1Dl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-Vixm4X1QOKS7cwp93um6KA-1; Wed, 03 Feb 2021 03:34:17 -0500
X-MC-Unique: Vixm4X1QOKS7cwp93um6KA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D8E01015C86;
        Wed,  3 Feb 2021 08:34:16 +0000 (UTC)
Received: from localhost (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E32645D9F1;
        Wed,  3 Feb 2021 08:34:15 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH] policycoreutils/setfiles: Drop unused nerr variable
In-Reply-To: <CAJfZ7==LVUDB7pF2vjr-tRks3svUt-kyy8-N-rVHYjur3HSZNQ@mail.gmail.com>
References: <20210201143206.389547-1-plautrba@redhat.com>
 <CAJfZ7==LVUDB7pF2vjr-tRks3svUt-kyy8-N-rVHYjur3HSZNQ@mail.gmail.com>
Date:   Wed, 03 Feb 2021 09:34:15 +0100
Message-ID: <87y2g5mtx4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Mon, Feb 1, 2021 at 3:32 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Suggested-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

> Thanks!
> Nicolas
>> ---
>>  policycoreutils/setfiles/setfiles.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
>> index 92616571ef2a..f018d161aa9e 100644
>> --- a/policycoreutils/setfiles/setfiles.c
>> +++ b/policycoreutils/setfiles/setfiles.c
>> @@ -19,7 +19,6 @@ static int warn_no_match;
>>  static int null_terminated;
>>  static int request_digest;
>>  static struct restore_opts r_opts;
>> -static int nerr;
>>
>>  #define STAT_BLOCK_SIZE 1
>>
>> @@ -161,7 +160,6 @@ int main(int argc, char **argv)
>>         warn_no_match = 0;
>>         request_digest = 0;
>>         policyfile = NULL;
>> -       nerr = 0;
>>
>>         r_opts.abort_on_error = 0;
>>         r_opts.progname = strdup(argv[0]);
>> @@ -427,9 +425,6 @@ int main(int argc, char **argv)
>>         r_opts.selabel_opt_digest = (request_digest ? (char *)1 : NULL);
>>         r_opts.selabel_opt_path = altpath;
>>
>> -       if (nerr)
>> -               exit(-1);
>> -
>>         restore_init(&r_opts);
>>
>>         if (use_input_file) {
>> --
>> 2.30.0
>>

