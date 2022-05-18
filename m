Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F259DC433F5
	for <selinux@archiver.kernel.org>; Wed, 18 May 2022 10:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiERKcr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 May 2022 06:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiERKcr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 May 2022 06:32:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2739120184
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652869965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nI2k6b9Rl/n47x5Q+G3IEk7EQLmg/33CNL5ZWXNQNKg=;
        b=WaPLmOc9p9tEijXRYUllbI78tIoxaPiXq3zXZ6mvFrQXeUxuC8aE6SHLWSUcWfK8euQbYl
        Wh1eDjOb7FCCaFfoR6wEdJdzKgZYiEX5iC9suE5pziraOYJ5GLSAcprn/xyLQjCgxnydQa
        6atY1ckpo+qkOY02btb3nw5AeHP7IUw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-NSazu0jINqejIahAFhFq5A-1; Wed, 18 May 2022 06:32:42 -0400
X-MC-Unique: NSazu0jINqejIahAFhFq5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C758D85A5A8;
        Wed, 18 May 2022 10:32:41 +0000 (UTC)
Received: from localhost (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6561740C1421;
        Wed, 18 May 2022 10:32:41 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: update man page of setfilecon(3) family
 about context parameter
In-Reply-To: <871qws8isv.fsf@redhat.com>
References: <20220505174338.24370-1-cgzones@googlemail.com>
 <871qws8isv.fsf@redhat.com>
Date:   Wed, 18 May 2022 12:32:40 +0200
Message-ID: <87o7zv6shj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
>> The family of setfilecon(3) functions take the context as a read-only
>> `const char *` parameter.
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>
> Thanks.

Merged.

>
>> ---
>>  libselinux/man/man3/setfilecon.3 | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/libselinux/man/man3/setfilecon.3 b/libselinux/man/man3/setf=
ilecon.3
>> index 0e9a383f..6bd3e415 100644
>> --- a/libselinux/man/man3/setfilecon.3
>> +++ b/libselinux/man/man3/setfilecon.3
>> @@ -5,17 +5,17 @@ setfilecon, fsetfilecon, lsetfilecon \- set SELinux se=
curity context of a file
>>  .SH "SYNOPSIS"
>>  .B #include <selinux/selinux.h>
>>  .sp
>> -.BI "int setfilecon(const char *" path ", char *" con );
>> +.BI "int setfilecon(const char *" path ", const char *" con );
>>  .sp
>> -.BI "int setfilecon_raw(const char *" path ", char *" con );
>> +.BI "int setfilecon_raw(const char *" path ", const char *" con );
>>  .sp
>> -.BI "int lsetfilecon(const char *" path ", char *" con );
>> +.BI "int lsetfilecon(const char *" path ", const char *" con );
>>  .sp
>> -.BI "int lsetfilecon_raw(const char *" path ", char *" con );
>> +.BI "int lsetfilecon_raw(const char *" path ", const char *" con );
>>  .sp
>> -.BI "int fsetfilecon(int "fd ", char *" con );
>> +.BI "int fsetfilecon(int "fd ", const char *" con );
>>  .sp
>> -.BI "int fsetfilecon_raw(int "fd ", char *" con );
>> +.BI "int fsetfilecon_raw(int "fd ", const char *" con );
>>  .
>>  .SH "DESCRIPTION"
>>  .BR setfilecon ()
>> --=20
>> 2.36.0

