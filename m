Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28F2C433F5
	for <selinux@archiver.kernel.org>; Thu,  7 Apr 2022 06:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiDGGsD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Apr 2022 02:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiDGGr7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Apr 2022 02:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E68021046D
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 23:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649313960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8cUENk1fkY1QAkdTkVl/DYG/QWnboHLI1djfIV9prA=;
        b=M9ro05AmfYoyZhEPxvQSJp+w13+W5QKslC9PCZ5IPvA1xJHxA2kNNxgxF5nMJbl2rxDJkV
        bYyIIET5VGKgWOkkXYlbKYiZXK7+5fXWrf038sVasSk+gDksDu64aRHZ1uFjN03rsAiWl8
        eO+96/m1/IuVi/hlCpuX0M5UKyEPan4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-ZEHw3oH3NNGMS7dqWV00tQ-1; Thu, 07 Apr 2022 02:45:59 -0400
X-MC-Unique: ZEHw3oH3NNGMS7dqWV00tQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B793383396C;
        Thu,  7 Apr 2022 06:45:58 +0000 (UTC)
Received: from localhost (unknown [10.40.193.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6233D40CF91F;
        Thu,  7 Apr 2022 06:45:58 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH v2] setfiles.8: -q is deprecated and has no effect
In-Reply-To: <CAP+JOzQq2oEwLoe=AzguxnyA4oLnSyAdUjeSWa0Dg4RqSJ2zaA@mail.gmail.com>
References: <CAP+JOzTVdo2N8YKuhaS7xBVYCUjNFfb7NHk=yqTN1LZRncB+gA@mail.gmail.com>
 <20220405071735.251995-1-plautrba@redhat.com>
 <CAP+JOzQq2oEwLoe=AzguxnyA4oLnSyAdUjeSWa0Dg4RqSJ2zaA@mail.gmail.com>
Date:   Thu, 07 Apr 2022 08:45:57 +0200
Message-ID: <87r169o0gq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Tue, Apr 5, 2022 at 3:38 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>  policycoreutils/setfiles/setfiles.8 | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
>> index 15f939d1bee0..5267064de3b5 100644
>> --- a/policycoreutils/setfiles/setfiles.8
>> +++ b/policycoreutils/setfiles/setfiles.8
>> @@ -124,7 +124,9 @@ and
>>  options are mutually exclusive.
>>  .TP
>>  .B \-q
>> -Deprecated, was only used to stop printing inode association parameters.
>> +Deprecated and replaced by
>> +.B \-v
>> +. Has no effect on other options or on program behavior.
>
> The "." at the beginning causes that line to not appear.
>
> I am no man page expert, but this seems to work.
>
> .B \-q
> Deprecated and replaced by \fB\-v\fR. Has no effect on other options
> or on program
> behavior.
>

I'm sorry for that. I really thought I opened the page and checked it
works. Apparently I didn't :(


> Thanks,
> Jim
>
>>  .TP
>>  .BI \-r \ rootpath
>>  use an alternate root path. Used in meta-selinux for OpenEmbedded/Yocto builds
>> --
>> 2.35.1
>>

