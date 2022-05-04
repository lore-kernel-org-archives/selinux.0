Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD7FC43217
	for <selinux@archiver.kernel.org>; Wed,  4 May 2022 17:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiEDRqA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 May 2022 13:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359319AbiEDRoG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 May 2022 13:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03EE0527FC
        for <selinux@vger.kernel.org>; Wed,  4 May 2022 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651684042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z7d+jD/3CgE7Ci095LIO8Ereh1BIxwksLcpxFJN/n2A=;
        b=eSzBJPqFaeuJDawjkZ47B+H/M2bz6DwTPHei2sk29uOKhyFU8WbAKq8HGV9jXhWU9G8ATW
        RAPzy/M/6NOiaq09mbbf+fJ1x3TkvgaVGLAlGnp2+Qjud0MsykKZzM6pvAnvzDSIGRPKp9
        VHGfFxutr2mLt8wr4106LRry3LlM9iw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-1m8sD5w-Nq2BbEIlxReLmw-1; Wed, 04 May 2022 13:07:20 -0400
X-MC-Unique: 1m8sD5w-Nq2BbEIlxReLmw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38C67101AA46;
        Wed,  4 May 2022 17:07:20 +0000 (UTC)
Received: from localhost (unknown [10.40.195.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEDD6156A94C;
        Wed,  4 May 2022 17:07:19 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] checkpolicy: mention class name on invalid permission
In-Reply-To: <87ilql8cfy.fsf@redhat.com>
References: <20220426105914.15817-1-cgzones@googlemail.com>
 <87ilql8cfy.fsf@redhat.com>
Date:   Wed, 04 May 2022 19:07:19 +0200
Message-ID: <87fslp8bw8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
>> When a permission for a constraint statement cannot be found also
>> mention the related class name.
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>

Merged, thanks!


>
>> ---
>>  checkpolicy/policy_define.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
>> index 16b78346..a4c24115 100644
>> --- a/checkpolicy/policy_define.c
>> +++ b/checkpolicy/policy_define.c
>> @@ -3627,7 +3627,7 @@ int define_constraint(constraint_expr_t * expr)
>>  				}
>>  				if (!perdatum) {
>>  					yyerror2("permission %s is not"
>> -						 " defined", id);
>> +						 " defined for class %s", id, policydbp->p_class_val_to_name[i]);
>>  					free(id);
>>  					ebitmap_destroy(&classmap);
>>  					return -1;
>> --=20
>> 2.36.0

