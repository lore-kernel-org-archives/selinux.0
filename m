Return-Path: <SRS0=oqeB=XT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1AEC432C1
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 07:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAA4214D9
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 07:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="im5PHaj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409259AbfIXH0Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:26:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51959 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409182AbfIXH0Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Sep 2019 03:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569309975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EpW8vnAzU3Nxa16Bw4kzQ/chIOikZGy1ygSYTY7Jog8=;
        b=im5PHaj1jXZQIClmeNnvtzBG0HJX2kXCKSIJLN+djTJ21yJoi4NMj63wh5nZDRR+1SCdRW
        oWEyZc/nWdfqeTCiHx5LCDB9iJOco3ABAPg5UnzzjTRfMaK9CU1NUjKaNg2+5bD94az24K
        YNUyXdw6wEsye5VjSC5M1J/oSoqo3/A=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-fgoJWGlAMwS25oDtEtCmww-1; Tue, 24 Sep 2019 03:26:13 -0400
Received: by mail-ot1-f72.google.com with SMTP id i8so645484otc.19
        for <selinux@vger.kernel.org>; Tue, 24 Sep 2019 00:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpW8vnAzU3Nxa16Bw4kzQ/chIOikZGy1ygSYTY7Jog8=;
        b=jpJgYMvtrzkTH9yqjGvQmzp2tB5ZAYFXPbthjgroHcndxkvPMJc+3Nof3Ugd8Z8/Cd
         N/dWuxkNcQ9swDpPCgzBDI4JJ0ZWcSd2IRn7B+hWfUD8FlemKGxMx421yo5NGWAOHBrZ
         f4FLyepRk5VhnZmj9b6jlVvRtISWgg6FbiKg6sCujwDVVyesWx/kJ8lKqnclIXwWhZ+G
         0txwpJTmMD7vyXTOYZEFV5Usq0kp/fYJO6fpRjFy3venbVeU5NT62QehpHSMY62re6BV
         St0cnqnlLdpWy6Vqtvf0W7tNj5+euNMTknNUOMfrUg6O0r6DSkdMjlg1fwtSGUp2jeoM
         vvEQ==
X-Gm-Message-State: APjAAAX4UbWiWRlT9V4uFZeCs5yIM1B7plmpQDGypknM7uwbP65F6AAe
        /w1sAbwkBCm1tGmWFwO5cNPMo44Rzdr2S+oL5SgbyJHXPDLcnKy5ldjmvGGZLzVu7V8IPbQjHZV
        x1v5mFhfZAK8L68MrfmcP80NSv3o8NXY3IQ==
X-Received: by 2002:a9d:3f26:: with SMTP id m35mr797572otc.66.1569309972586;
        Tue, 24 Sep 2019 00:26:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYD8CCLzeoItuCgSGUJ0Re7jLjOdU9XOHtmMdJrXCRrO2HH0C/ltX+3mGOAawCCMXbN8GvaJGGZqhUsSc0E3c=
X-Received: by 2002:a9d:3f26:: with SMTP id m35mr797560otc.66.1569309972319;
 Tue, 24 Sep 2019 00:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <156927687193.621177.11371002337716273956.stgit@chester> <156927696325.621177.10551869484430505777.stgit@chester>
In-Reply-To: <156927696325.621177.10551869484430505777.stgit@chester>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 24 Sep 2019 09:26:01 +0200
Message-ID: <CAFqZXNvhNUvCoquAC-Zq9hZCSmAVUGySubJSUER1x--MqqPdng@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux-testsuite: use our own version of perltidy in
 the Travis CI tests
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: fgoJWGlAMwS25oDtEtCmww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 24, 2019 at 12:16 AM Paul Moore <paul@paul-moore.com> wrote:
> From: Paul Moore <paul@paul-moore.com>
>
> Unfortunately the perltidy results differ between moden distros and the
> current Travis CI environment.  This patch attempts to address this by
> using the current upstream perltidy in the Travis CI tests.

Generally thumbs up from me, although I have a few comments below.

>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  .travis.yml |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 61bb1f2..256e92c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -6,10 +6,17 @@ addons:
>    apt:
>      packages:
>        - astyle
> -      - perltidy
>        - libselinux1-dev
>        - libsctp-dev
>
> +before_install:
> +  - git clone https://github.com/perltidy/perltidy.git perltidy

I think it would be safer to add here something like:

- git checkout 8551fc60fc515cd290ba38ee8c758c1f4df52b56

That way the Travis checks won't suddenly break when something changes
in the master branch (where I'd expect things to change/break once in
a while). IMHO having to bump the commit manually from time to time is
less bothersome than having to deal with random changes in the
upstream branch.

> +  - |
> +    (cd perltidy;
> +     perl Makefile.PL;
> +     make;
> +     sudo make install)

This is not a big deal, but you might want to join these with '&&'
instead of ';' since if an earlier command fails, it doesn't make much
sense to try to run the rest (the pipeline would then almost certainly
fail later anyway).

> +
>  script:
>    - tools/check-syntax -f && git diff --exit-code
>    - make
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

