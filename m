Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A12C433F5
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 13:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiDFNCQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiDFNBv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 09:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A64FC5BE12F
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649237131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KqfrsIUXKYO2fQy99gSa5dnT265nm7oP2c2id6CCNk=;
        b=FjLp3Zizwef/Tl2CH6D9dPqP6lk2ENCLtFd7w9wdVkWMS5AJynBt6v1SMtOKOt7ogbh1SJ
        7fxanM8BmkeiPkuatNK4tZB2dNAFuV9YBMZB9JmLkauqCdloASdtTZoKD4bKbmG7BmeuF5
        We9KXJm/P/SPacF4JCZUxN476YpYM9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-QPd1CmmPNj6cYzB50jd69w-1; Wed, 06 Apr 2022 05:25:28 -0400
X-MC-Unique: QPd1CmmPNj6cYzB50jd69w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D57B851784;
        Wed,  6 Apr 2022 09:25:24 +0000 (UTC)
Received: from localhost (unknown [10.40.193.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4321F403171;
        Wed,  6 Apr 2022 09:25:24 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>,
        Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH] libsepol/cil: silence GCC 12 array-bounds false positive
In-Reply-To: <CAP+JOzSvNxZP86C5xvQbbQ_JopwoYCj5AikS3-djjww4fVVu7Q@mail.gmail.com>
References: <20220331144343.30689-1-cgzones@googlemail.com>
 <CAP+JOzSvNxZP86C5xvQbbQ_JopwoYCj5AikS3-djjww4fVVu7Q@mail.gmail.com>
Date:   Wed, 06 Apr 2022 11:25:23 +0200
Message-ID: <87mtgypnr0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Thu, Mar 31, 2022 at 11:34 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
>>
>> GCC 12 produces an array-bounds warning:
>>
>>     In file included from ../include/sepol/policydb/context.h:23,
>>                      from ../include/sepol/policydb/policydb.h:62,
>>                      from ../cil/src/cil_binary.c:41:
>>     In function =E2=80=98mls_level_init=E2=80=99,
>>         inlined from =E2=80=98mls_level_destroy=E2=80=99 at ../include/s=
epol/policydb/mls_types.h:99:2,
>>         inlined from =E2=80=98mls_level_destroy=E2=80=99 at ../include/s=
epol/policydb/mls_types.h:92:20,
>>         inlined from =E2=80=98mls_range_destroy=E2=80=99 at ../include/s=
epol/policydb/mls_types.h:149:2,
>>         inlined from =E2=80=98cil_rangetransition_to_policydb=E2=80=99 a=
t ../cil/src/cil_binary.c:3231:6:
>>     ../include/sepol/policydb/mls_types.h:89:9: error: =E2=80=98memset=
=E2=80=99 offset [0, 23] is out of the bounds [0, 0] [-Werror=3Darray-bound=
s]
>>        89 |         memset(level, 0, sizeof(mls_level_t));
>>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     ../include/sepol/policydb/mls_types.h:89:9: error: =E2=80=98memset=
=E2=80=99 offset [0, 23] is out of the bounds [0, 0] [-Werror=3Darray-bound=
s]
>>     cc1: all warnings being treated as errors
>>
>> This is a false positive, by inspecting the code and compiling with -O3
>> and -flto.
>>
>> Closes: https://github.com/SELinuxProject/selinux/issues/339
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>> ---
>>  libsepol/cil/src/cil_binary.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary=
.c
>> index 53017e2d..d5211f69 100644
>> --- a/libsepol/cil/src/cil_binary.c
>> +++ b/libsepol/cil/src/cil_binary.c
>> @@ -3222,7 +3222,16 @@ int cil_rangetransition_to_policydb(policydb_t *p=
db, const struct cil_db *db, st
>>                                         } else {
>>                                                 cil_log(CIL_ERR, "Out of=
 memory\n");
>>                                         }
>> +// TODO: add upper version bound once fixed in upstream GCC
>> +#if defined(__GNUC__) && (__GNUC__ >=3D 12)
>> +# pragma GCC diagnostic push
>> +# pragma GCC diagnostic ignored "-Warray-bounds"
>> +# pragma GCC diagnostic ignored "-Wstringop-overflow"
>> +#endif
>>                                         mls_range_destroy(newdatum);
>> +#if defined(__GNUC__) && (__GNUC__ >=3D 12)
>> +# pragma GCC diagnostic pop
>> +#endif
>>                                         free(newdatum);
>>                                         free(newkey);
>>                                         if (rc !=3D SEPOL_OK) {
>> --
>> 2.35.1
>>

