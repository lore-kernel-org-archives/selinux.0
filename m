Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DDCC433E0
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 15:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7113601FA
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 15:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBSPUd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Feb 2021 10:20:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhBSPUd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Feb 2021 10:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613747946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZphNJytbUmMOYKXhsBz0eRhEaFVfkclbZzRolq5+fZQ=;
        b=NjSp4FnWIlcfMgeoDQP7IOy5v1MG76DpHk8nOU4h8oSebQm2koAIyqHKvOrSJOEgxYPKQH
        Oq59WZbNYOXLy5Huf039wTAI3WvEYlIps6lQGi1SdQiKdGfQyhp6bTKyQSsJ4FfxXM7WDc
        3xYB3Egi5Q0pnCAIgmG2Tdmu4BxGH+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-8GGILRMnNbyVs-afZo2bbw-1; Fri, 19 Feb 2021 10:19:03 -0500
X-MC-Unique: 8GGILRMnNbyVs-afZo2bbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3671835E21;
        Fri, 19 Feb 2021 15:19:01 +0000 (UTC)
Received: from localhost (unknown [10.40.194.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 545A413470;
        Fri, 19 Feb 2021 15:19:01 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@gmail.com>,
        Dominick Grift <dominick.grift@defensec.nl>
Subject: Re: [PATCH] secilc: fixes cil_role_statements.md example
In-Reply-To: <CAP+JOzT1jbDYK=u8nyAG8X=_abxKwb7vqqF=gyDVKWLZqFh6xg@mail.gmail.com>
References: <20210217073728.1137112-1-dominick.grift@defensec.nl>
 <CAP+JOzT1jbDYK=u8nyAG8X=_abxKwb7vqqF=gyDVKWLZqFh6xg@mail.gmail.com>
Date:   Fri, 19 Feb 2021 16:19:00 +0100
Message-ID: <87czwwozkr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Wed, Feb 17, 2021 at 2:42 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged, thanks!

>> ---
>>  secilc/docs/cil_role_statements.md | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/secilc/docs/cil_role_statements.md b/secilc/docs/cil_role_statements.md
>> index ee6a5868..2e1b4047 100644
>> --- a/secilc/docs/cil_role_statements.md
>> +++ b/secilc/docs/cil_role_statements.md
>> @@ -339,7 +339,7 @@ In this example the role `test` cannot have greater privileges than `unconfined.
>>  ```secil
>>      (role test)
>>
>> -    (unconfined
>> +    (block unconfined
>>          (role role)
>>          (rolebounds role .test)
>>      )
>> --
>> 2.30.1
>>

