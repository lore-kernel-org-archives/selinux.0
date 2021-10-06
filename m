Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B1C433EF
	for <selinux@archiver.kernel.org>; Wed,  6 Oct 2021 10:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7073D61052
	for <selinux@archiver.kernel.org>; Wed,  6 Oct 2021 10:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbhJFKjL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237890AbhJFKjL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Oct 2021 06:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633516638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H49Ogc5Sjbo+G2D0Xc9S8E6GIcSBWyUq32ob/xY6nE0=;
        b=GyfXgODK3oUKs+XSMdCf/5e/5swLUbTwtJQskSmI/1cgtcIjnwUb/z8fCLHpe+cvW8GkeI
        NniKhyyKInvhVvXbANncSlNIO9Nmk0FklGx6NOGjkLIJ4uz33gQzS2MBTD9Lir65PWW8Cw
        Mw8944i4T53Il2XAUxCXD1a0S5StGnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-99WV3436N02bFhFnb8pyEA-1; Wed, 06 Oct 2021 06:37:15 -0400
X-MC-Unique: 99WV3436N02bFhFnb8pyEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 497C336259;
        Wed,  6 Oct 2021 10:37:14 +0000 (UTC)
Received: from localhost (unknown [10.40.192.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D400019D9F;
        Wed,  6 Oct 2021 10:37:13 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] libselinux/semodule: Improve extracting message
In-Reply-To: <CAP+JOzQM1SCb+CMP-tgqsAwOna64i-Q_DOF4hprtkC20VhOz6g@mail.gmail.com>
References: <20211004125719.1155053-1-plautrba@redhat.com>
 <CAP+JOzQM1SCb+CMP-tgqsAwOna64i-Q_DOF4hprtkC20VhOz6g@mail.gmail.com>
Date:   Wed, 06 Oct 2021 12:37:12 +0200
Message-ID: <87o882zbfr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Mon, Oct 4, 2021 at 8:59 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> The code doesn't check the default priority, it just looks for the
>> highest.
>>
>> Fixes:
>>
>>     # semodule -E testmodule
>>     Module 'testmodule' does not exist at the default priority '400'. Extracting at highest existing priority '400'.
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>


Merged. Thanks!


>> ---
>>  policycoreutils/semodule/semodule.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
>> index bf9eec02a050..66ea06624eda 100644
>> --- a/policycoreutils/semodule/semodule.c
>> +++ b/policycoreutils/semodule/semodule.c
>> @@ -672,8 +672,7 @@ int main(int argc, char *argv[])
>>                                         }
>>
>>                                         semanage_module_info_get_priority(sh, extract_info, &curr_priority);
>> -                                       printf("Module '%s' does not exist at the default priority '%d'. "
>> -                                                       "Extracting at highest existing priority '%d'.\n", mode_arg, priority, curr_priority);
>> +                                       printf("Extracting at highest existing priority '%d'.\n", curr_priority);
>>                                         priority = curr_priority;
>>                                 }
>>
>> --
>> 2.32.0
>>

