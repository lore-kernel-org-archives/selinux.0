Return-Path: <SRS0=61sA=XS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A14C32755
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B0C20820
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 10:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiWK4PDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407538AbfIWKCL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:02:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48625 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405464AbfIWKCL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Sep 2019 06:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569232930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdI6NrJxMqXqyy3AvPJjQUjw71IIMYJaTkSZ2yey0Qg=;
        b=IiWK4PDUUcVwsB5F3cjgEE4Ub7mmMIMC13gx/6fYp+38uwI/8UO76T5+K63O1rCyppLwSc
        ov/xdejGeoSGyTmQkwlJlkHkYcQvTluRboIkc7Ei+ac57Tbc0LfGDL9E0nWUTDZiYLkC4h
        ZzMhnYkKtrk/2SuIb7ty2o7+poGz0io=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-5CdOylzXO3-jVTOMWhKVVA-1; Mon, 23 Sep 2019 06:02:08 -0400
Received: by mail-oi1-f200.google.com with SMTP id k185so5236952oih.1
        for <selinux@vger.kernel.org>; Mon, 23 Sep 2019 03:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=q/P6TW+Lo8DrOABhUUa+l8oqw2Czf1zciCHb9AgLP3o=;
        b=W38/wQfmWRsBUFcxzgZMLWIIKjSRkgw71unHN9hoZLnKUzwcdhOGFgAxwT4ZU1p8rA
         oI6keEKSLZxYXkFmq3+ywTl9lFyhmjaKeS/ADkQTzk+mv1Db1wLEJPpDQv2TrFa5qKx6
         j1Sl6TedkLkopCGBo2EBIS8LxGXX2SBJdUOOSrJAuCiiSIEhiOZNwulhjGeDBbtd0Q+m
         Mtwr0FwW+OZjBXfXhMEt/uhx4UljFO60Zufw6YTja6Fy/eusGwF5o7bgftYEmpPqo7PO
         XZmCEzBZMU/ZRXjRKYt1A/AqmdF5berjfzbLQwiZsfydw8I9VinYXq7T7y7Bjj29ZR9d
         syeg==
X-Gm-Message-State: APjAAAUxHMsCW2Z2xVZYUbR656hzNbOLokAt9Vdq+/LRp4UyLQghnsd1
        x8Yq2VFgjnTf2seTjpYtaq205TcIjuPsYbGUmKVHBLdRWOGfYhgmJWYjcdKQj25mUhkJIsrPS5A
        KLdprgemaacCS4ZzWzX55lBcNFa/fIy9kWw==
X-Received: by 2002:aca:e046:: with SMTP id x67mr13092866oig.156.1569232927533;
        Mon, 23 Sep 2019 03:02:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzfpjB8r8dtkdmWHwVz6YV2DhLgiDie8G/TLwNqFC9YLvCl3/z6Wg4x/enGUCaaK5Dwmw9ICxJAqQ8w63HWVDA=
X-Received: by 2002:aca:e046:: with SMTP id x67mr13092843oig.156.1569232927253;
 Mon, 23 Sep 2019 03:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190923095837.25752-1-omosnace@redhat.com>
In-Reply-To: <20190923095837.25752-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 23 Sep 2019 12:01:56 +0200
Message-ID: <CAFqZXNsMDuvBtmueWdTrNuudxXY1wFYn4e_ifUKno5BBU5KOeg@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: do not rebuild policy package if
 already built
To:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: 5CdOylzXO3-jVTOMWhKVVA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 23, 2019 at 11:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrot=
e:
> Right now, test_policy.pp is rebuilt on every make invocation. Tweak the
> Makefile so that it is only build when it hasn't been built, it has been
> cleaned, or the source files changed.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policy/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/policy/Makefile b/policy/Makefile
> index a5942b3..cc0f140 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -86,7 +86,7 @@ ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHE=
L6))
>  TARGETS:=3D$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te,=
 $(TARGETS))
>  endif
>
> -all: build
> +all: test_policy/test_policy.pp
>
>  expand_check:
>         # Test for "expand-check =3D 0" in /etc/selinux/semanage.conf
> @@ -94,7 +94,7 @@ expand_check:
>                 (echo "ERROR: set 'expand-check =3D 0' in /etc/selinux/se=
manage.conf"; \
>                  /bin/false)
>
> -build: $(TARGETS)
> +test_policy/test_policy.pp: $(TARGETS) test_policy.if
>         # General policy build
>         @if [ -d $(POLDEV) ]; then \
>                 mkdir -p test_policy; \
> --
> 2.21.0
>

This doesn't make much of a difference performance-wise, but the
behavior is more logical this way.

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

