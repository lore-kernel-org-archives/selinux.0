Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242D9C4332F
	for <selinux@archiver.kernel.org>; Tue,  8 Nov 2022 17:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbiKHRDh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Nov 2022 12:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiKHRDg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Nov 2022 12:03:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4C928F
        for <selinux@vger.kernel.org>; Tue,  8 Nov 2022 09:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667926955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I7tPwrvCKT4uZskR5iulHoyXrZiBiwsRyZ6tSbrMAEM=;
        b=Mhgkn5ffJRhHlrb6IMmzcFuzKwO4YUrFMEHaXRRYWjR1RIRFTeYSrEuGaSe5dZm8/5C++v
        yTxKARcHylkm0RuVRGPmpp75PAoU3Q1zrBUbkCesHd9LKUNA3sbC4wqqOjv57VvMscTWYQ
        uZcab/+bn7ZAQlVRDA03EKSeWqZsz1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-gKaUlB_-P8a33XUWTkbpog-1; Tue, 08 Nov 2022 12:02:34 -0500
X-MC-Unique: gKaUlB_-P8a33XUWTkbpog-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33CE21078529;
        Tue,  8 Nov 2022 17:02:30 +0000 (UTC)
Received: from localhost (ovpn-193-179.brq.redhat.com [10.40.193.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDDC4492B05;
        Tue,  8 Nov 2022 17:02:29 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] python: Fix typo in audit2allow.1 example
In-Reply-To: <CAP+JOzTenjFNOAPd-bWppmpoPCq79Hfov523hrVxp6tvvzxwjg@mail.gmail.com>
References: <20221108101854.1136685-1-plautrba@redhat.com>
 <CAP+JOzTenjFNOAPd-bWppmpoPCq79Hfov523hrVxp6tvvzxwjg@mail.gmail.com>
Date:   Tue, 08 Nov 2022 18:02:29 +0100
Message-ID: <87sfitl6qi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Tue, Nov 8, 2022 at 5:20 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>  python/audit2allow/audit2allow.1 | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2allow.1
>> index c61067b33688..f1a4b8ea33b3 100644
>> --- a/python/audit2allow/audit2allow.1
>> +++ b/python/audit2allow/audit2allow.1
>> @@ -151,7 +151,7 @@ policy_module(local, 1.0)
>>  gen_require(`
>>          type myapp_t;
>>          type etc_t;
>> - };
>> +');
>
> Should be:
> +\[aq]);
>
> Otherwise, the line does not show up.
> You can't use \' because that is translated into a closing single quote.
>

I haven't checked it, sorry for that.

I'll send a proper fix.


>
>>
>>  files_read_etc_files(myapp_t)
>>  <review local.te and customize as desired>
>> --
>> 2.37.3
>>

