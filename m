Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E6C433EF
	for <selinux@archiver.kernel.org>; Mon, 29 Nov 2021 17:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbhK2R7C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Nov 2021 12:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242578AbhK2R5B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Nov 2021 12:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638208423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jt8XvKcCtSRTmHLJb9lupmC8Jzt64r0RWLrMPvp8hdE=;
        b=GNDTiD/jXmRZh7SU9t83ISns52eYlM7t4zA7YmOnvw81sfO0x1fBwBmQTW/9qE8vPUfooB
        +6vEzFhQ7ImEaxXfKXMNJ7prZAKtHzTN/DlOOCTgM58j7X/z+GMnZfemjBSwYPRa2yCQq6
        1bDbGcqDF8KI1TOnvbYk2VFFk/HPNHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-OU_z-9tANDysqmqQCb4-uQ-1; Mon, 29 Nov 2021 12:53:42 -0500
X-MC-Unique: OU_z-9tANDysqmqQCb4-uQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADDF08042E1
        for <selinux@vger.kernel.org>; Mon, 29 Nov 2021 17:53:40 +0000 (UTC)
Received: from localhost (unknown [10.40.193.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49D606060F;
        Mon, 29 Nov 2021 17:53:40 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] libselinux: Fix selinux_restorecon_parallel symbol version
In-Reply-To: <CAFqZXNsm966va58Y-+cdVEPPJXvqz=tJPm_Q9bVpTT6q0qNf-w@mail.gmail.com>
References: <20211123103805.415558-1-plautrba@redhat.com>
 <CAFqZXNsm966va58Y-+cdVEPPJXvqz=tJPm_Q9bVpTT6q0qNf-w@mail.gmail.com>
Date:   Mon, 29 Nov 2021 18:53:39 +0100
Message-ID: <87zgpm26ho.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Tue, Nov 23, 2021 at 11:38 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>> selinux_restorecon_parallel was originally proposed before 3.3, but it
>> was merged after release so it will be introduced in version 3.4.
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>  libselinux/src/libselinux.map | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
>> index d138e951ef0d..4acf1caacb55 100644
>> --- a/libselinux/src/libselinux.map
>> +++ b/libselinux/src/libselinux.map
>> @@ -241,7 +241,7 @@ LIBSELINUX_1.0 {
>>      *;
>>  };
>>
>> -LIBSELINUX_3.3 {
>> +LIBSELINUX_3.4 {
>>    global:
>>      selinux_restorecon_parallel;
>>  } LIBSELINUX_1.0;
>> --
>> 2.33.1
>>
>
> Thanks, I forgot to bump this when sending the v4.
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>

Merged.

