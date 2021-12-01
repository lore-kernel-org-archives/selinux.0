Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54242C433EF
	for <selinux@archiver.kernel.org>; Wed,  1 Dec 2021 15:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351166AbhLAP74 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Dec 2021 10:59:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350986AbhLAP7z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Dec 2021 10:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638374194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLrhYpzXGVnGefczDIMc5kp3iwi74pReqi5ylFeRbew=;
        b=VTIfb3s1XvI9sVdaM4p8boazb5NzZNpLs0IGgeO2/q+slAnvue1QQE0zJIWRuVuKRaqJqx
        YbefwrJ+bds0EZQro0SKNjqlvDrfSSnwyadukGGaHBpuRiMb8Dmyu5Pjn8luipZ2JJekDE
        JJyGyKBdS98X42/h9rXX7mCJwsX9MwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-ivNAq-coOBKpzL0agNcNrQ-1; Wed, 01 Dec 2021 10:56:30 -0500
X-MC-Unique: ivNAq-coOBKpzL0agNcNrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6BB7100C660;
        Wed,  1 Dec 2021 15:56:29 +0000 (UTC)
Received: from localhost (unknown [10.40.193.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70D4419D9F;
        Wed,  1 Dec 2021 15:56:29 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 2/3] libselinux: use PCRE2 by default
In-Reply-To: <20211123183249.6133-2-cgzones@googlemail.com>
References: <20211123183249.6133-1-cgzones@googlemail.com>
 <20211123183249.6133-2-cgzones@googlemail.com>
Date:   Wed, 01 Dec 2021 16:56:28 +0100
Message-ID: <87pmqg1fpv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Quoting pcre.org:
>
>     There are two major versions of the PCRE library. The current
>     version, PCRE2, released in 2015, is now at version 10.39.
>
>     The older, but still widely deployed PCRE library, originally
>     released in 1997, is at version 8.45. This version of PCRE is now at
>     end of life, and is no longer being actively maintained. Version
>     8.45 is expected to be the final release of the older PCRE library,
>     and new projects should use PCRE2 instead.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>



> ---
>  libselinux/Makefile       | 2 +-
>  libselinux/src/Makefile   | 1 -
>  libselinux/utils/Makefile | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index 439bc6a9..6d9e2736 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -23,7 +23,7 @@ ifeq ($(DISABLE_X11),y)
>  endif
>  export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST DISABLE_X1=
1 LABEL_BACKEND_ANDROID
>=20=20
> -USE_PCRE2 ?=3D n
> +USE_PCRE2 ?=3D y
>  ifeq ($(USE_PCRE2),y)
>  	PCRE_MODULE :=3D libpcre2-8
>  	PCRE_CFLAGS :=3D -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=3D8
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 52c40f01..04bf4f24 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -98,7 +98,6 @@ override LDFLAGS +=3D -L/opt/local/lib -undefined dynam=
ic_lookup
>  LD_SONAME_FLAGS=3D-install_name,$(LIBSO)
>  endif
>=20=20
> -PCRE_LDLIBS ?=3D -lpcre
>  # override with -lfts when building on Musl libc to use fts-standalone
>  FTS_LDLIBS ?=3D
>=20=20
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 36816155..801066cb 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -44,7 +44,6 @@ endif
>  override CFLAGS +=3D -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_=
CFLAGS)
>  override LDFLAGS +=3D -L../src
>  override LDLIBS +=3D -lselinux $(FTS_LDLIBS)
> -PCRE_LDLIBS ?=3D -lpcre
>=20=20
>  ifeq ($(ANDROID_HOST),y)
>  TARGETS=3Dsefcontext_compile
> --=20
> 2.34.0

