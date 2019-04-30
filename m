Return-Path: <SRS0=/07/=TA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9813EC43219
	for <selinux@archiver.kernel.org>; Tue, 30 Apr 2019 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A9220652
	for <selinux@archiver.kernel.org>; Tue, 30 Apr 2019 16:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfD3QAo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfD3QAo (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 30 Apr 2019 12:00:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8EB93065416;
        Tue, 30 Apr 2019 16:00:28 +0000 (UTC)
Received: from localhost (unknown [10.43.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 556E51001E63;
        Tue, 30 Apr 2019 16:00:27 +0000 (UTC)
References: <20190404211938.24183-1-plautrba@redhat.com> <CAJfZ7=n3sfg9aqd-fG61s4SJXUBNTiBoAFgAqOm50UHa2TsVTA@mail.gmail.com>
User-agent: mu4e 1.0; emacs 26.2
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Bogdan BOTEZ <bmbogdan@gmail.com>
Subject: Re: [PATCH] semanage/semanage-boolean.8: Fix a minor typo
In-reply-to: <CAJfZ7=n3sfg9aqd-fG61s4SJXUBNTiBoAFgAqOm50UHa2TsVTA@mail.gmail.com>
Date:   Tue, 30 Apr 2019 18:00:25 +0200
Message-ID: <pjdv9yv8ova.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 30 Apr 2019 16:00:33 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Thu, Apr 4, 2019 at 11:19 PM Petr Lautrbach 
> <plautrba@redhat.com> wrote:
>>
>> boolan -> boolean
>>
>> Reported-by: Bogdan BOTEZ <bmbogdan@gmail.com>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

>> ---
>>  python/semanage/semanage-boolean.8 | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/python/semanage/semanage-boolean.8 
>> b/python/semanage/semanage-boolean.8
>> index 99a6260b..1282d106 100644
>> --- a/python/semanage/semanage-boolean.8
>> +++ b/python/semanage/semanage-boolean.8
>> @@ -45,7 +45,7 @@ Disable the boolean
>>
>>  .SH EXAMPLE
>>  .nf
>> -Turn on the apache can send mail boolan
>> +Turn on the apache can send mail boolean
>>  # semanage boolean \-m \-\-on httpd_can_sendmail
>>
>>  List customized booleans
>> --
>> 2.21.0
>>

