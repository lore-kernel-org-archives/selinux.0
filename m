Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C486BC43460
	for <selinux@archiver.kernel.org>; Tue, 18 May 2021 18:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BBB611B0
	for <selinux@archiver.kernel.org>; Tue, 18 May 2021 18:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351619AbhERSoj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 May 2021 14:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351643AbhERSoh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 May 2021 14:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621363399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eT5nDPUkgGl4XiwpdjL3oeaRF8zA+eRVaVow5wzWypc=;
        b=CAeIEh3oeDKCZAX7GctZojXIcbGAwc9oap18KhClJZme4Otw4jFP8OHKPcbv1A50jLyQQY
        Km/5wbDhw0gwJ4k69+Axyqc3urZtVBLA5aKaJmRUpZHbBFfkPJKHvtRSQyc+C0o+DwnbKZ
        dLqMzm9z7YUJnSGbV6eVRyE6Efv0uHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-dUlpUaBHNEC3mF5O8mA3QA-1; Tue, 18 May 2021 14:43:17 -0400
X-MC-Unique: dUlpUaBHNEC3mF5O8mA3QA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 019E7107ACCA;
        Tue, 18 May 2021 18:43:16 +0000 (UTC)
Received: from localhost (unknown [10.40.192.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89E17BA6D;
        Tue, 18 May 2021 18:43:15 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH userspace 1/2] libselinux: fix invalid free in
 store_stem()/load_mmap()
In-Reply-To: <CAJ2a_Dfacd18naq_FnnG86B_erzWW9z-EPjqf088mEHfREwGrw@mail.gmail.com>
References: <20210512102529.122753-1-omosnace@redhat.com>
 <20210512102529.122753-2-omosnace@redhat.com>
 <CAJ2a_Dfacd18naq_FnnG86B_erzWW9z-EPjqf088mEHfREwGrw@mail.gmail.com>
Date:   Tue, 18 May 2021 20:43:14 +0200
Message-ID: <877djvlw71.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Am Mi., 12. Mai 2021 um 12:25 Uhr schrieb Ondrej Mosnacek <omosnace@redha=
t.com>:
>>
>> Building libselinux with GCC 11.1.1 produces the following warning:
>> ```
>> In file included from label_file.c:24:
>> In function =E2=80=98store_stem=E2=80=99,
>>     inlined from =E2=80=98load_mmap=E2=80=99 at label_file.c:277:12,
>>     inlined from =E2=80=98process_file=E2=80=99 at label_file.c:551:5:
>> label_file.h:289:25: error: =E2=80=98free=E2=80=99 called on pointer =E2=
=80=98*mmap_area.next_addr=E2=80=99 with nonzero offset 4 [-Werror=3Dfree-n=
onheap-object]
>>   289 |                         free(buf);
>>       |                         ^~~~~~~~~
>> ```
>>
>> Indeed, in this case the pointer shouldn't be freed as it comes from
>> mmap. Fix this by adding a from_mmap parameter to store_stem() instead
>> of overriding the saved_data::from_mmap value in load_mmap().
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> See https://patchwork.kernel.org/project/selinux/patch/20210503175350.559=
54-17-cgzones@googlemail.com/
> for an alternative.

https://patchwork.kernel.org/project/selinux/patch/20210503175350.55954-17-=
cgzones@googlemail.com/ - Accepted

https://patchwork.kernel.org/project/selinux/patch/20210512102529.122753-2-=
omosnace@redhat.com/ - Rejected

Thanks to both!

