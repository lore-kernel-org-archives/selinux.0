Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24686C47095
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 09:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9E360BBB
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 09:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhFIJx0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jun 2021 05:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233188AbhFIJx0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jun 2021 05:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623232291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYZMGtW3kcEgfZr2yo2D1dicV1447q0bC+K68QCiJGc=;
        b=aa9OYKIvztlCt7nXwJbTB+uKXsL06uAiSgsVQ6fgDLl/uR1DbRQFO9iwwcSGTtHON6NjBE
        ID8WNt+dxxbiFEGCyvGxaM5JHzW9NuvWjKG7XBKWyU7+Z47eQ2SLT8x3drQ16Od5v7n+1b
        T6EktuzWGT33Ij5pL7uNu+AgvRDtlZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-WYJHpXY7NJuG7oJQIlfLrw-1; Wed, 09 Jun 2021 05:30:03 -0400
X-MC-Unique: WYJHpXY7NJuG7oJQIlfLrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F232DBBEFA;
        Wed,  9 Jun 2021 09:30:01 +0000 (UTC)
Received: from localhost (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7563D60FC2;
        Wed,  9 Jun 2021 09:30:01 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: selinux_status_open: return 1 in fallback mode
In-Reply-To: <87r1hjp54y.fsf@redhat.com>
References: <20210601150523.7016-1-cgzones@googlemail.com>
 <87r1hjp54y.fsf@redhat.com>
Date:   Wed, 09 Jun 2021 11:30:00 +0200
Message-ID: <8735trpeqv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
>> In case of a recurring call to `selinux_status_open(3)`, which
>> previously has been opened in fallback mode, return `1` according to its
>> documentation.
>>
>> Fixes: c5a699046f4 ("libselinux: make selinux_status_open(3) reentrant")
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

This is merged now. Thanks!


>
>> ---
>>  libselinux/src/sestatus.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
>> index 531a522c..89c1f621 100644
>> --- a/libselinux/src/sestatus.c
>> +++ b/libselinux/src/sestatus.c
>> @@ -283,7 +283,7 @@ int selinux_status_open(int fallback)
>>  	uint32_t	seqno;
>>=20=20
>>  	if (selinux_status !=3D NULL) {
>> -		return 0;
>> +		return (selinux_status =3D=3D MAP_FAILED) ? 1 : 0;
>>  	}
>>=20=20
>>  	if (!selinux_mnt) {
>> --=20
>> 2.32.0.rc2

