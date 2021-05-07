Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887C3C433ED
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 11:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408F561041
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 11:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhEGLWt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 May 2021 07:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52000 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231932AbhEGLWs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 May 2021 07:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620386508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ipcIxSJChvc98FPArSaKznr8SnurYH9HEbQL3IwdK4o=;
        b=Z1cuhPJv9v1JLHytTLVJKSLGbVDahhDmIFbsE4WQIm1bjqXjbeyyGWtMN5M60R0rS2pMhg
        YZyQ7rr7pFN/aboAWZOZGskU1FJcSR8BzTsGkN6hZoQE0lKC0zBB/P9ygQszulLkDzLdDA
        FjnVaWSguGQJvT4xzBkiIun37rNtZj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-umyVG773Mr-fQeI_KaS21w-1; Fri, 07 May 2021 07:21:46 -0400
X-MC-Unique: umyVG773Mr-fQeI_KaS21w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B519618C35BA;
        Fri,  7 May 2021 11:21:45 +0000 (UTC)
Received: from localhost (unknown [10.40.192.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A63359460;
        Fri,  7 May 2021 11:21:44 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: silence -Wstringop-overflow warning from
 gcc 10.3.1
In-Reply-To: <20210430193702.42974-1-nicolas.iooss@m4x.org>
References: <20210430193702.42974-1-nicolas.iooss@m4x.org>
Date:   Fri, 07 May 2021 13:21:44 +0200
Message-ID: <87fsyyhjqv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> When building libselinux on Fedora 33 with gcc 10.3.1, the compiler
> reports:
>
>     label_file.c: In function =E2=80=98lookup_all.isra=E2=80=99:
>     label_file.c:940:4: error: =E2=80=98strncpy=E2=80=99 specified bound =
depends on the
>     length of the source argument [-Werror=3Dstringop-overflow=3D]
>       940 |    strncpy(clean_key, key, len - 1);
>           |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     label_file.c:927:8: note: length computed here
>       927 |  len =3D strlen(key);
>           |        ^~~~~~~~~~~
>     cc1: all warnings being treated as errors
>
> As clean_key is the result of malloc(len), there is no issue here. But
> using strncpy can be considered as strange, because the size of the
> string is already known and the NUL terminator is always added later, in
> function =E2=80=98lookup_all.isra.
>
> Replace strncpy with memcpy to silence this gcc false-positive warning.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I wasn't able to reproduce it with gcc-11.0.1-0.7.fc35.x86_64, but it's
indeed reproducible with gcc-10.3.1-1.fc33.x86_64 and this patch fixes
it.

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  libselinux/src/label_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 726394ca4332..cfce23e0119e 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -909,7 +909,7 @@ static const struct spec **lookup_all(struct selabel_=
handle *rec,
>  			if (!clean_key)
>  				goto finish;
>=20=20
> -			strncpy(clean_key, key, len - 1);
> +			memcpy(clean_key, key, len - 1);
>  		}
>=20=20
>  		clean_key[len - 1] =3D '\0';
> --=20
> 2.31.0

