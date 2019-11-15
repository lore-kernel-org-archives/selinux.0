Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBACEC43215
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55452073A
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQBGteZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfKOP3F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:29:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38343 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727412AbfKOP3F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Nov 2019 10:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573831743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sh8Olyy3o2ck3onB4gtfdFWHsnsOhergpnF9KqEdK30=;
        b=NQBGteZKEYNCXmxOn+mirpbu2bipWpPXX4j7MXe5fRkBOwqmlWpLfl3nouwHnQ9f3UhAvB
        LGYukz7jYcw1knTNec2Hu3vO/BFnCH6TBkOr/ZC6PCPAJqNhGmu49RarZOBEMKGj8H3j0H
        4t8mZOIzN7/w7DILWFzl7MZoRB4IqVI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-RF8lKIlGNKKT-mjl6-veOA-1; Fri, 15 Nov 2019 10:29:00 -0500
Received: by mail-ot1-f70.google.com with SMTP id 109so5549663otv.1
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2019 07:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fW5kUtVx1ua33DqgPvV/yfxEsooXlv0klmfTNPrwvtk=;
        b=UEHxRV/4xU6AGmsK3exJ0y2PK+0iGAWV+nXyYEzNG9hV1e01xfEPxa8PqA9NojhKoj
         YBw57DZVrYJNAXE8BBb8+CA2JPIARoHQ7dCqLRCnFXY38uWmdp/KWebfYqOR3+UhlMEp
         /APsQTFGpwdJovhISSNx7s9paY2C0JXsmGoVnUnKCETbvn8FsRNveMWIR47NVOhqwkHC
         VAGE/5ZzRE+bih2u6uAAI99xT2jqCQNXoHWirgRQrTGwIcpj98mreIfcP26HWw38GA8w
         bplYjOFNdYcgEV756GEqq5g6M2jo0yGC58AQJjoPEgTBj7Gar3N2QXDLqQvbLiF+6kxx
         sHVg==
X-Gm-Message-State: APjAAAVjHEp0ouWyOwEtM+juaHQHWk68Za3UEkBdYHmCzqIM+Pj22s5N
        yf3XIR4U8JsC1Ibtq44vB2QN3/358TcLKW/3yIFYBhXtLXs0pWbpoaPUNwLgmyh4COEls9LFQc3
        5UHck5oonVJr6HBVJX0KRlgBc92qwWPPEaQ==
X-Received: by 2002:a9d:5884:: with SMTP id x4mr11121443otg.367.1573831739207;
        Fri, 15 Nov 2019 07:28:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfDnkJDQNKWgbSoivUli9+qWvpCTsmhTUubMllkXWBkfynx4m+mUYAIzcuua6h5sszyyvvt/QERivp9Kf6lxE=
X-Received: by 2002:a9d:5884:: with SMTP id x4mr11121424otg.367.1573831738919;
 Fri, 15 Nov 2019 07:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20191115151623.265770-1-omosnace@redhat.com>
In-Reply-To: <20191115151623.265770-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 15 Nov 2019 16:28:48 +0100
Message-ID: <CAFqZXNvkMN0ALmyfFSM6t2VKZ0Sgp6o9W9KVypJ=Agze4Tz+7g@mail.gmail.com>
Subject: Re: [PATCH testsuite v2 0/3] Fix refpolicy build & build
 test_policy.pp in Travis
To:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: RF8lKIlGNKKT-mjl6-veOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 15, 2019 at 4:16 PM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> This series fixes the remaining test_policy.pp build errors under
> refpolicy and enables building the test policy under both Fedora policy
> and refpolicy in Travis CI.
>
> Changes in v2:
>  - report policy version 999 in the fake selinuxfs to force building
>    latest version
>  - install userspace tools and libraries straight from source instead
>    of working around maissing features in the Ubuntu builds
>  - install also latest keyutils from source to allow the new 'keys'
>    subtest helpers to build

Demo Travis run:
https://travis-ci.org/WOnder93/selinux-testsuite/builds/612431495

>
> Ondrej Mosnacek (3):
>   policy: consolidate macros for home dirs access
>   policy: add fallbacks for Fedora-specific macros
>   travis: test building the test policy package
>
>  .travis.yml                         | 48 ++++++++++++++++++++++++++---
>  policy/Makefile                     | 11 ++++---
>  policy/test_overlayfs.te            |  6 ++--
>  policy/test_policy.if               | 23 ++++++++++++--
>  travis-ci/enable-policy.sh          | 10 ++++++
>  travis-ci/setup-policy-fedora.sh    | 33 ++++++++++++++++++++
>  travis-ci/setup-policy-refpolicy.sh | 19 ++++++++++++
>  7 files changed, 136 insertions(+), 14 deletions(-)
>  create mode 100644 travis-ci/enable-policy.sh
>  create mode 100644 travis-ci/setup-policy-fedora.sh
>  create mode 100644 travis-ci/setup-policy-refpolicy.sh
>
> --
> 2.23.0

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

