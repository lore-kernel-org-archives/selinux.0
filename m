Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF73C433EF
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 09:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhKWJrX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 04:47:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231240AbhKWJrW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 04:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637660654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9e48JXUEF5/Eho//A0L2kGfXM5dNRtIcPCiNQK+RUBA=;
        b=glR6pUDy/gV2wTwKBRWFQvXn6964HUxIQErTq66LOegA7x+gmwUVDywDxCR/N0QcTO2ujG
        T70nr1ehLEx98QvSLyg6648S77K9La/Zz74J9dxdf/1MvFUqwFUcBXPLu1/t+Snj/piFZv
        wdjNecwf1q+7aqFNbmoBsbheiXAsZ/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-S0mmj0a_MSCPN4UzIPk5VA-1; Tue, 23 Nov 2021 04:44:13 -0500
X-MC-Unique: S0mmj0a_MSCPN4UzIPk5VA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38E4B83DD16;
        Tue, 23 Nov 2021 09:44:12 +0000 (UTC)
Received: from localhost (unknown [10.40.193.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C50705F4E0;
        Tue, 23 Nov 2021 09:44:11 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] semodule: Fix lang_ext column index
In-Reply-To: <CAP+JOzSPTEwjeFbgd+pNEQS5XUbOA3uMLxs2axWL40fRV2xd2w@mail.gmail.com>
References: <20211116151122.172831-1-plautrba@redhat.com>
 <CAP+JOzSPTEwjeFbgd+pNEQS5XUbOA3uMLxs2axWL40fRV2xd2w@mail.gmail.com>
Date:   Tue, 23 Nov 2021 10:44:10 +0100
Message-ID: <87fsrnkxzp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Tue, Nov 16, 2021 at 10:12 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> lang_ext is 3. column - index number 2.
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks.

It's merged now.


>
>> ---
>>  policycoreutils/semodule/semodule.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
>> index ddbf10455abf..57f005ce2c62 100644
>> --- a/policycoreutils/semodule/semodule.c
>> +++ b/policycoreutils/semodule/semodule.c
>> @@ -684,7 +684,7 @@ cleanup_extract:
>>                                                 if (result != 0) goto cleanup_list;
>>
>>                                                 size = strlen(tmp);
>> -                                               if (size > column[3]) column[3] = size;
>> +                                               if (size > column[2]) column[2] = size;
>>                                         }
>>
>>                                         /* print out each module */
>> --
>> 2.33.1
>>

