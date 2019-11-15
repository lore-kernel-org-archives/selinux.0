Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E576C432C3
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636FE206D3
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NS+FoFK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfKOP7V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:59:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51025 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727423AbfKOP7U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Nov 2019 10:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573833559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s88tm4vKyiHkGDtzjwhLpeSta9bmQsUwwr1I7/A8Z9A=;
        b=NS+FoFK7vTTPUVUvx5SO/dnvOr98j/LtaCRgK9LwJwYLNDj6VFXuwkzCDg6z4cbmBUpi3L
        eAHSqM6wY0+ne7/ZNOUkAvKtmAqwEQxx48ZENxOGLV5+zDBS6UVzKip+WcrxtCZEOXDyIu
        mfXw3bZUJjePlpbBK3Wj6ZWBCcgY3R0=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-8CsleqinO62Exm2sbdmmMA-1; Fri, 15 Nov 2019 10:59:18 -0500
Received: by mail-ot1-f69.google.com with SMTP id m7so5598254otr.12
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2019 07:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zknuXfFohCjZT/5vTf9mCoYIy/gUAjbmYxg02utbUCU=;
        b=GVL1fPGnimqMMQ3GZa7HGqByIcK29EtJ+jgy9UfUQYbyn8+V4/nSzOmp3Ldy6x3Vla
         caAs9p6Ln1wI6OQ8I4JaTKtvmm2frWEWUyLEu4oDh3Ppi51f4g+bOZGWnMA+gyt/DXJ6
         X+GFRhsTj+lkrZnCdILin9w4V46SR8MUGLGGrJpcz3vedj73j+L89LimEpdDZfjXgSn5
         IABpr/TWcfnW5hCSOApKN5z54FtMD95/rD3VZaxiCYJhLa/icofHB8ailfgt4p0jy+1u
         azfxGfZAJ9n2A21IQWIzWPG28SRFPg+R009sfVsO14Zvb2L/7U7dNmXeApk1BWPhObjG
         I4CA==
X-Gm-Message-State: APjAAAXtIEgkIyDPjBaHxw9yub48U3yHBxZTTqA2gY00zEvIg3N5TQMP
        Uzaibi3G6eoZ9xzPhYShbd/DRg+hFSnbWbnY9OJRqGW1abFwKKSauA6uVHNJq/1k3buDPD6BB19
        AGl/N40oo/ZalBqBUmfhj/Im6TdhElJfPkA==
X-Received: by 2002:aca:da87:: with SMTP id r129mr2189096oig.26.1573833557221;
        Fri, 15 Nov 2019 07:59:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzVu/YL+s91svWCWNUqgVNFiU54d1zifEnmZu76c6SB/652SSGTSoJrbpV1CMilZaj5fARo8ChRYriJuAKAEs=
X-Received: by 2002:aca:da87:: with SMTP id r129mr2189070oig.26.1573833556872;
 Fri, 15 Nov 2019 07:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20191115151623.265770-1-omosnace@redhat.com> <74a989a0-4288-af3b-21c1-05cbfa6ba167@tycho.nsa.gov>
In-Reply-To: <74a989a0-4288-af3b-21c1-05cbfa6ba167@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 15 Nov 2019 16:59:05 +0100
Message-ID: <CAFqZXNtjTis3u6BYjJQNfOW4D3mT-w07Z_XLVW3iyhCdST7bDg@mail.gmail.com>
Subject: Re: [PATCH testsuite v2 0/3] Fix refpolicy build & build
 test_policy.pp in Travis
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: 8CsleqinO62Exm2sbdmmMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 15, 2019 at 4:53 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/15/19 10:16 AM, Ondrej Mosnacek wrote:
> > This series fixes the remaining test_policy.pp build errors under
> > refpolicy and enables building the test policy under both Fedora policy
> > and refpolicy in Travis CI.
> >
> > Changes in v2:
> >   - report policy version 999 in the fake selinuxfs to force building
> >     latest version
> >   - install userspace tools and libraries straight from source instead
> >     of working around maissing features in the Ubuntu builds
> >   - install also latest keyutils from source to allow the new 'keys'
> >     subtest helpers to build
>
> Doesn't appear to have addressed any of my comments on the first version
> of the first two patches:
>
> https://lore.kernel.org/selinux/6df6dafe-56a6-7de0-0196-d2b714b453bb@tych=
o.nsa.gov/
>
> https://lore.kernel.org/selinux/c7521035-8608-c24e-4056-c58aa02de387@tych=
o.nsa.gov/

Ah, sorry, I got back to this after a long delay and forgot about
those... I'll address them in v3 then.

>
> >
> > Ondrej Mosnacek (3):
> >    policy: consolidate macros for home dirs access
> >    policy: add fallbacks for Fedora-specific macros
> >    travis: test building the test policy package
> >
> >   .travis.yml                         | 48 ++++++++++++++++++++++++++--=
-
> >   policy/Makefile                     | 11 ++++---
> >   policy/test_overlayfs.te            |  6 ++--
> >   policy/test_policy.if               | 23 ++++++++++++--
> >   travis-ci/enable-policy.sh          | 10 ++++++
> >   travis-ci/setup-policy-fedora.sh    | 33 ++++++++++++++++++++
> >   travis-ci/setup-policy-refpolicy.sh | 19 ++++++++++++
> >   7 files changed, 136 insertions(+), 14 deletions(-)
> >   create mode 100644 travis-ci/enable-policy.sh
> >   create mode 100644 travis-ci/setup-policy-fedora.sh
> >   create mode 100644 travis-ci/setup-policy-refpolicy.sh
> >
>


--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

