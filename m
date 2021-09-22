Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB3EC433EF
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 11:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D8561107
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 11:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhIVL0A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235422AbhIVLZ7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Sep 2021 07:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632309869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/3ux/yolzWF7V3stDQ5a3LPeZypdYhCnqz7bpUbxO0=;
        b=jKF7kbQgeGPwdHENaUoxM+811Xmlzm3ufMqd+tP1bumUc11pW0JyMg9snXWE4ZjCN7RJkl
        2m6kXgj7yxEeqz5PS3axHHC0GIzOC/mcvU35vLJlU02zYmFdIkBng2kHzlY/x4HTxygXxA
        LTRQKniH1SgyF4qeI963uyE8GUmaAkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-L1OhP7pGP4emUvyCdxbftQ-1; Wed, 22 Sep 2021 07:24:28 -0400
X-MC-Unique: L1OhP7pGP4emUvyCdxbftQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E17A1006AA6;
        Wed, 22 Sep 2021 11:24:27 +0000 (UTC)
Received: from localhost (unknown [10.40.194.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEC5912D4A;
        Wed, 22 Sep 2021 11:24:26 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH v2] libselinux/utils: drop requirement to combine
 compiling and linking
In-Reply-To: <20210914131007.24150-1-cgzones@googlemail.com>
References: <20210714181325.58688-1-cgzones@googlemail.com>
 <20210914131007.24150-1-cgzones@googlemail.com>
Date:   Wed, 22 Sep 2021 13:24:25 +0200
Message-ID: <87a6k4vonq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> The extra dependency of sefcontext_compile on its object file causes the
> compile and link step to be separated.
> During the link step the CFLAGS are not passed, which might contain
> optimization or sanitizer flags.
>
> Reorder the LDLIBS requirements to avoid the symbol 'pcre_fullinfo'
> being unresolvable at link time.
>
> Current behavior:
>
>     gcc-11 **custom CFLAGS** -I../include -D_GNU_SOURCE     -c -o sefcont=
ext_compile.o sefcontext_compile.c
>     gcc-11 -L../src  sefcontext_compile.o ../src/regex.o  -lselinux  -lpc=
re ../src/libselinux.a -lsepol -o sefcontext_compile
>
> Changed:
>
>     gcc-11 **custom CFLAGS** -I../include -D_GNU_SOURCE    -L../src  sefc=
ontext_compile.c  -lselinux  ../src/libselinux.a -lpcre -lsepol -o sefconte=
xt_compile
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks!


> ---
> v2:
>   - drop line regarding regex.o, as suggested by Nicolas Iooss.
>   - order -lpcre after libselinux.a
>
>
>  libselinux/utils/Makefile | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index b018a08a..36816155 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -52,9 +52,7 @@ else
>  TARGETS=3D$(patsubst %.c,%,$(sort $(wildcard *.c)))
>  endif
>=20=20
> -sefcontext_compile: LDLIBS +=3D $(PCRE_LDLIBS) ../src/libselinux.a -lsep=
ol
> -
> -sefcontext_compile: sefcontext_compile.o ../src/regex.o
> +sefcontext_compile: LDLIBS +=3D ../src/libselinux.a $(PCRE_LDLIBS) -lsep=
ol
>=20=20
>  all: $(TARGETS)
>=20=20
> --=20
> 2.33.0

