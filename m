Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507B6C433EF
	for <selinux@archiver.kernel.org>; Mon, 29 Nov 2021 17:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243037AbhK2R6l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Nov 2021 12:58:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243565AbhK2R4l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Nov 2021 12:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638208403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bTj+QR0h4RqMXB25se2DoJjXjoiEJuxBNzReTkcK4cI=;
        b=e9BHAHTGpTELAbeVSYLQyQW67SSQDvJZj6OA8YOuo+tCAmeH6n+ObsnkBTHwRuhOOGYdxu
        iKblx8Mo3diCrDMi/weG4vV75Kii39qJ0HQvATiDsYxat5ZLEn4bN2xtlZxP3RaJtAM/i7
        bslag//c4pEwB7UJLdxPCUPPh0LY9Ec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378--oeZojR0OlmXIEWs4PrdLw-1; Mon, 29 Nov 2021 12:53:21 -0500
X-MC-Unique: -oeZojR0OlmXIEWs4PrdLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BA381006AD8;
        Mon, 29 Nov 2021 17:53:16 +0000 (UTC)
Received: from localhost (unknown [10.40.193.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBF4060854;
        Mon, 29 Nov 2021 17:53:15 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] semodule: Don't forget to munmap() data
In-Reply-To: <CAP+JOzRQSH4Eoox3Vnh8L6WKwxHabqj1KFAEQexy3P+e3xuYaQ@mail.gmail.com>
References: <20211123163851.438425-1-plautrba@redhat.com>
 <CAP+JOzRQSH4Eoox3Vnh8L6WKwxHabqj1KFAEQexy3P+e3xuYaQ@mail.gmail.com>
Date:   Mon, 29 Nov 2021 18:53:14 +0100
Message-ID: <8735ne3l2t.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Tue, Nov 23, 2021 at 11:41 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> semanage_module_extract() mmap()'s the module raw data but it leaves on
>> the caller to munmap() them.
>>
>> Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>> ---
>>  policycoreutils/semodule/semodule.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
>> index 57f005ce2c62..94a9d131bb79 100644
>> --- a/policycoreutils/semodule/semodule.c
>> +++ b/policycoreutils/semodule/semodule.c
>> @@ -394,6 +394,9 @@ static char *hash_module_data(const char *module_name, const int prio) {
>>         sha256_buf[i * 2] = 0;
>>
>>  cleanup_extract:
>> +       if (data_len > 0) {
>> +               munmap(data, data_len);
>> +       }
>>         semanage_module_info_destroy(sh, extract_info);
>>         free(extract_info);
>>         semanage_module_key_destroy(sh, modkey);
>> --
>> 2.33.1
>>

