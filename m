Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1A3C7EE24
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 12:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjFBMFe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 08:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbjFBMFd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 08:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA9D99
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685707491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfZuFj/+nWoxhllamRhzrvXFJBvGTC98OSuZ5oUYAuw=;
        b=hHePWkTTXro9OVJJx8huO2tuL5K8XzIU8LU8mGFqINHevGyrObAzOCBCAIb9wXwLYwXqd2
        WEBVyP8e8b3bhG1F8J2nQ4VCB4s7ebwWMUu93Pp58xv/hwsM/7+y2Vzvrzj/sYNW1u8Kge
        +mjmHo1FzUxT83Mg8mQ7SgEzvj1KLaA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-LMD9eY_EMDyl8A8hEwFTDw-1; Fri, 02 Jun 2023 08:04:50 -0400
X-MC-Unique: LMD9eY_EMDyl8A8hEwFTDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FD2985A5BB
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 12:04:50 +0000 (UTC)
Received: from localhost (unknown [10.45.224.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 303122026D49;
        Fri,  2 Jun 2023 12:04:50 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Masatake YAMATO <yamato@redhat.com>, selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: Re: [PATCH] Makefile: expand ~ in DESTDIR
In-Reply-To: <20230531011548.1133249-1-yamato@redhat.com>
References: <20230531011548.1133249-1-yamato@redhat.com>
Date:   Fri, 02 Jun 2023 14:04:49 +0200
Message-ID: <87o7lyjcim.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Masatake YAMATO <yamato@redhat.com> writes:

> Though instructed as
>
>     DESTDIR=3D~/obj ./scripts/env_use_destdir make test
>
> in README.md, compiling policy_define.c was failed with following errors:
>
>     make[1]: Entering directory '/home/yamato/var/selinux/checkpolicy'
>     cc -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self \
>        -Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototypes=
 \
>        -Wnull-dereference -Wpointer-arith -Wshadow -Wstrict-prototypes \
>        -Wundef -Wunused -Wwrite-strings -fno-common -I~/obj/usr/include \
>        -o policy_define.o -c policy_define.c
>     policy_define.c: In function =E2=80=98define_te_avtab_xperms_helper=
=E2=80=99:
>     policy_define.c:2083:61: error: =E2=80=98RULE_NOTSELF=E2=80=99 undecl=
ared (first use in this function); did you mean =E2=80=98RULE_SELF=E2=80=99?
>      2083 |                         avrule->flags |=3D (add ? RULE_SELF :=
 RULE_NOTSELF);
> 	  |                                                             ^~~~~~~~=
~~~~
> 	  |                                                             RULE_SELF
>
> because cc cannot find the directory ~/obj/usr/include passed via -I opti=
on.
>
> cc doesn't expand "~".
>
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>

It doesn't work when DESTDIR does not exist -  If no existing file name
matches a pattern, then that pattern is omitted from the output of the
wildcard function, see
https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html


Petr

> ---
>  Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 2ffba8e9..053c6d3d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -26,11 +26,11 @@ else
>  endif
>=20=20
>  ifneq ($(DESTDIR),)
> -	LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> +	LIBDIR ?=3D $(wildcard $(DESTDIR))$(PREFIX)/lib
>  	LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
>=20=20
> -	CFLAGS +=3D -I$(DESTDIR)$(PREFIX)/include
> -	LDFLAGS +=3D -L$(DESTDIR)$(PREFIX)/lib -L$(LIBDIR)
> +	CFLAGS +=3D -I$(wildcard $(DESTDIR))$(PREFIX)/include
> +	LDFLAGS +=3D -L$(wildcard $(DESTDIR))$(PREFIX)/lib -L$(LIBDIR)
>  	export CFLAGS
>  	export LDFLAGS
>  	export LIBSEPOLA
> --=20
> 2.40.1

