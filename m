Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC87BC77B78
	for <selinux@archiver.kernel.org>; Fri, 21 Apr 2023 07:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjDUHeH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Apr 2023 03:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjDUHeG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Apr 2023 03:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1E3974F
        for <selinux@vger.kernel.org>; Fri, 21 Apr 2023 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682062376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I04tVAOVsetWzV/WKEB/rohmcsYRuVBTVQIG/hOIda0=;
        b=U/wjVTNExV+Aj2iXh8HBXiGD9GNtf7Qqbhkbv0cdjHFK8hCkgKCATCKrvAxU0BIC6ZdF9e
        adyvzOZpM+ojSjWGxdv0PtGhBstbvmsHxkqdx25+pj5EOFETMdhMqCPs015KO3aCyJPQXd
        FN+/jJyad2hl9zO0AQdVDASRfS+78hI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-GQ2zas6yM5a8ecczsfoNhw-1; Fri, 21 Apr 2023 03:32:54 -0400
X-MC-Unique: GQ2zas6yM5a8ecczsfoNhw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-51b67183546so1185562a12.0
        for <selinux@vger.kernel.org>; Fri, 21 Apr 2023 00:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682062373; x=1684654373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I04tVAOVsetWzV/WKEB/rohmcsYRuVBTVQIG/hOIda0=;
        b=gNX2Tbuf9/7+MEL+8yGtXAnc61w8PBnciQkno9qp769Dj3ka1rUJufmqZOl1uSJ5Lc
         TUGpCtjtblpN3dQfeARoOfRjJnMLEfGGka4eIvPHLqE/3uCRliJV3R6cD3nwsYGgtmL+
         Tcy52ag6qcsqj90JYdx25jrRYCEKm4yYQVUXU0vNxsCv14zxHgbmbeuvxzhiS0jKwQK/
         jYeEZbbYv4DhkRovdCKU3j6alzmKCl4mWrn+VId8YGnAFdUCkDLRMp3JmYk4R0/yadZT
         nM7JLQJiaSnqJCjjJUnqbL9eRi+Yb5T8SY3K9XJHgayBRbX2tXvLAW227R7rnYW10xvu
         6jLA==
X-Gm-Message-State: AAQBX9fmhe4xEC0MISqjitKBcTy58SAzAPhOnhAnHW+/dnaK+Lc5qMWc
        BXc7leDno6DqXZcXsgeQFDaSPyZJjo9EqJeHKJes62eXOTI0KXiCMcQQ395iqcv+PT8/pJhMNfi
        H8PnywHafH4fH+VITqKVTgk3QEMCfOJcFGjBz7xOTMOK6
X-Received: by 2002:a17:90b:1d01:b0:247:83ed:7e5d with SMTP id on1-20020a17090b1d0100b0024783ed7e5dmr4101521pjb.18.1682062373607;
        Fri, 21 Apr 2023 00:32:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350aP0G2/Keyw4JLMs6cybXHFg0TCpFwWGl/hWa760oVQxpae//XDwFTSC6TSkcFGku/GONYhvslC8zX+3iWhJWc=
X-Received: by 2002:a17:90b:1d01:b0:247:83ed:7e5d with SMTP id
 on1-20020a17090b1d0100b0024783ed7e5dmr4101510pjb.18.1682062373254; Fri, 21
 Apr 2023 00:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230420135803.4692-1-cgzones@googlemail.com> <CAFqZXNtQ+zxTGBJbxXySaLVZHf7O3nXa9K84kV7GNtLJKZASAw@mail.gmail.com>
 <CAJ2a_De91qKV4Cz-VSuJqQn+xXaeHLhXwF4LvA+qRtHfezLhwQ@mail.gmail.com>
In-Reply-To: <CAJ2a_De91qKV4Cz-VSuJqQn+xXaeHLhXwF4LvA+qRtHfezLhwQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 21 Apr 2023 09:32:42 +0200
Message-ID: <CAFqZXNvGrzBwB+NGEuoyvgZQS2gC6H4-WVtADgSjsb2TnXwYJw@mail.gmail.com>
Subject: Re: [TESTSUITE PATCH] README.md: update dependencies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 20, 2023 at 5:11=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Thu, 20 Apr 2023 at 16:28, Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> >
> > On Thu, Apr 20, 2023 at 3:59=E2=80=AFPM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > > Add libibverbs-dev, required since 4b4922e1 ("tests/infiniband*:
> > > simplify test activation"):
> > >
> > >     create_modify_qp.c:10:10: fatal error: infiniband/verbs.h: No suc=
h file or directory
> > >        10 | #include <infiniband/verbs.h>
> > >           |          ^~~~~~~~~~~~~~~~~~~~
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  README.md | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/README.md b/README.md
> > > index 7bd1dbc..5256cda 100644
> > > --- a/README.md
> > > +++ b/README.md
> > > @@ -82,6 +82,7 @@ following command (NOTE: On Fedora 32 and below you=
 need to remove
> > >                 lksctp-tools-devel \
> > >                 attr \
> > >                 libbpf-devel \
> > > +               libibverbs-devel \
> > >                 keyutils-libs-devel \
> > >                 quota \
> > >                 xfsprogs-devel \
> > > @@ -124,6 +125,7 @@ command:
> > >                 libselinux1-dev \
> > >                 net-tools \
> > >                 iptables \
> > > +               libibverbs-dev \
> > >                 libsctp-dev \
> > >                 attr \
> > >                 libbpf-dev \
> > > --
> > > 2.40.0
> > >
> >
> > These have already been added in
> > https://github.com/SELinuxProject/selinux-testsuite/commit/65cbbb8c4a4c=
afd1b307bfbd954acd7c5a653bb8
>
> Whoops, must have looked on an outdated fork.
> Please disregard my fault.

No problem, mistakes happen :)

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

