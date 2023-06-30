Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E83EB64DA
	for <selinux@archiver.kernel.org>; Fri, 30 Jun 2023 12:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjF3MaH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Jun 2023 08:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3MaF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Jun 2023 08:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13F735AC
        for <selinux@vger.kernel.org>; Fri, 30 Jun 2023 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688128153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NViHL01NYB5twbiNWeFSNkgGYVT124NS0cO7NQFdiAE=;
        b=h23nO1Xo30kp5Kf6lQ8s+zoFIpNInsvDIEQTQy/SAJlc/tmZs0c7n0X5PLVGI53k2qB63M
        t471WwP5+nwuKZWxfIRLYG0MMo0Qt31GO0fLYkO0N34otQjNYkIaI7HNqWCtjFgqpPhDju
        Pu6g/1HoZybOWtKfl8MeWKnhAbNXaXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-Ap4ziyW-Mu-y7ImuWduDwQ-1; Fri, 30 Jun 2023 08:29:09 -0400
X-MC-Unique: Ap4ziyW-Mu-y7ImuWduDwQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 355401044589;
        Fri, 30 Jun 2023 12:29:09 +0000 (UTC)
Received: from localhost (unknown [10.45.224.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB73D492B02;
        Fri, 30 Jun 2023 12:29:08 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Huaxin Lu <luhuaxin1@huawei.com>, selinux@vger.kernel.org
Cc:     shenyining@huawei.com, fangxiuning@huawei.com,
        zhujianwei7@huawei.com
Subject: Re: [PATCH] libselinux: add check for calloc in check_booleans
In-Reply-To: <87sfad0x7o.fsf@redhat.com>
References: <20230618231702.118125-1-luhuaxin1@huawei.com>
 <87sfad0x7o.fsf@redhat.com>
Date:   Fri, 30 Jun 2023 14:29:07 +0200
Message-ID: <87v8f5yvzg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Huaxin Lu <luhuaxin1@huawei.com> writes:
>
>> Check the return value of calloc() to avoid null pointer reference.
>>
>> Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>
>> ---
>>  libselinux/src/audit2why.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
>> index ba1a66e..2def89f 100644
>> --- a/libselinux/src/audit2why.c
>> +++ b/libselinux/src/audit2why.c
>> @@ -149,6 +149,12 @@ static int check_booleans(struct boolean_t **bools)
>>  
>>  	if (fcnt > 0) {
>>  		*bools = calloc(sizeof(struct boolean_t), fcnt + 1);
>> +		if (!*bools) {
>> +			PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
>> +			free(foundlist);
>> +			return 0;
>> +		}
>> +	
>
> There's a trailing whitespace, but it's not necessary to resend the patch.
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

merged, thanks

>>  		struct boolean_t *b = *bools;
>>  		for (i = 0; i < fcnt; i++) {
>>  			int ctr = foundlist[i];
>> -- 
>> 2.33.0

