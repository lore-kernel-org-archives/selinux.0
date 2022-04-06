Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3540FC433EF
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 14:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiDFOF5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiDFOF3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 10:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBD0210FAED
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 02:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649237669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k+FwrE9qRBWZSyM2FEILcJsXyMbJhCtokonUeLnyEoQ=;
        b=eVzBIqccrQE1GIvrOug4ssfPiqFQ1ULbF8IrrMBfpBqwBAH5AT9mcwsA4g2zpAnlFembLw
        ClnnV/Y1cKTV09ctCAu34uwa+HBu4geUs9cIMc8quQNBfo7e6fuLoZBftNJY8Q0AWQD+/Z
        mzB9Fb1yMVOAHNlG/guG9ASG/ZN3if4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-bV29oGKcNsOp64BnElbTZQ-1; Wed, 06 Apr 2022 05:34:28 -0400
X-MC-Unique: bV29oGKcNsOp64BnElbTZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73829804196;
        Wed,  6 Apr 2022 09:34:28 +0000 (UTC)
Received: from localhost (unknown [10.40.193.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E44F403D188;
        Wed,  6 Apr 2022 09:34:27 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH 1/3] libsemanage: Fix USE_AFTER_FREE (CWE-672) in
 semanage_direct_get_module_info()
In-Reply-To: <CAP+JOzTF1BC6hF7-nb+qBGpoAuC_VH5Ts+=CZZGj3hE1DD=X-g@mail.gmail.com>
References: <20220401133549.122069-1-plautrba@redhat.com>
 <CAP+JOzTF1BC6hF7-nb+qBGpoAuC_VH5Ts+=CZZGj3hE1DD=X-g@mail.gmail.com>
Date:   Wed, 06 Apr 2022 11:34:27 +0200
Message-ID: <87bkxepnbw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Fri, Apr 1, 2022 at 11:54 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> >From fclose(3):
>> Upon successful completion, 0 is returned.  Otherwise, EOF is returned
>> and errno is set to indicate the error. In either case, any further
>> access (including another call to fclose()) to the stream results in
>> undefined behavior.
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> For all three patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Merged, thanks!


>
>> ---
>>  libsemanage/src/direct_api.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
>> index d83941b05ca1..d5716ce579e9 100644
>> --- a/libsemanage/src/direct_api.c
>> +++ b/libsemanage/src/direct_api.c
>> @@ -2293,6 +2293,7 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
>>         tmp = NULL;
>>
>>         if (fclose(fp) != 0) {
>> +               fp = NULL;
>>                 ERR(sh,
>>                     "Unable to close %s module lang ext file.",
>>                     (*modinfo)->name);
>> --
>> 2.35.1
>>

