Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F47CC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 19:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4133020718
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 19:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WA93bDpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392079AbgAXTle (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:41:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24061 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391181AbgAXTld (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 14:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579894893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Rq8G6GpQRQVyJmxN0yzVSoCKTO5aqgGyzzf3uVe3uE=;
        b=WA93bDplZws4LDEd9Lj02SoezhA7p6nHbbslrhTzOcaJYE6kgRj/n0za8MbwLG8Dlno0E6
        gce4igNbBK7zZUA7pO+KmcX6iyieIwX3soy9qF/yKDDHRFFpye7F6xgxzQFo+ZA6X4rJRq
        JcSe1tT59JQC5niojwUXd90DrQnkWWk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-H9EWqhteO_Cy9lQ2yUTczw-1; Fri, 24 Jan 2020 14:41:30 -0500
X-MC-Unique: H9EWqhteO_Cy9lQ2yUTczw-1
Received: by mail-ot1-f72.google.com with SMTP id b10so1398740otp.3
        for <selinux@vger.kernel.org>; Fri, 24 Jan 2020 11:41:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Rq8G6GpQRQVyJmxN0yzVSoCKTO5aqgGyzzf3uVe3uE=;
        b=RQdxFPb6IZcLNniHhr8l5Jv3FZJTHzAaDr/+axQl1FcutUnG3z0AmhiSm1ESrJ3z4K
         E11ODIB5krVC/S7KyENVx0qDttetlez5lzmH5Sv24x3aRkYfT8oKXih32OJHdXXJmEg4
         uZDGA9Ihlg4Xvx7pl6AJwvSUyGbfEUlv700FfcIAh9b0oR0ckLi5O+42Ul2xoK/m2T+M
         DbtzQLBiggcI8cwBmC/x194oWy0hF9LXznUeXJ1NoRaUwM1i+hXtfytBBhD8VjJuOCW7
         VfyveVN64xX6nAnkwRZmRYCRH6KfKlkJ5+cNQtzFSOSb04eg+TOzE6sNX84R8pNEwa2i
         IPzw==
X-Gm-Message-State: APjAAAW1NlWKmlTFqCCiF3Upub2jNVBDoU2F0BHXWfWyEKOSNgu7hjO+
        +rjfckxuk6e+9fjggE7kqJo4xuecRs3JzOJp/SLCiHxK5ZyWefhO3OZrNCA7Llo2MgCyjxoqDQh
        BoezSJIdClTHX05zCS02XAyNyeSFpX44BSw==
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr3754535oto.367.1579894889963;
        Fri, 24 Jan 2020 11:41:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqLEhULMyOTcPHoRvfXDwD6jQAik7wJPbKDaVAWOQQtpKKtS6KOBdp5mZg4Rlz5p0xe4eQW+k6eqLe1KPS/eY=
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr3754527oto.367.1579894889676;
 Fri, 24 Jan 2020 11:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20200120111113.23349-1-richard_c_haines@btinternet.com>
 <20200120111113.23349-3-richard_c_haines@btinternet.com> <8467a014-e9aa-c148-ebc3-25c79c1853c5@tycho.nsa.gov>
 <CAHC9VhTkhrdTPfhBMD=tBqVbCZBGdQS+fPHO1y4k79-CQrAPiw@mail.gmail.com>
In-Reply-To: <CAHC9VhTkhrdTPfhBMD=tBqVbCZBGdQS+fPHO1y4k79-CQrAPiw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 24 Jan 2020 20:41:18 +0100
Message-ID: <CAFqZXNtPVFV9F2E7ngzbfvTjMa2WKSVnCzhKN3RHMRHF-_FQSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux-testsuite: Add fs*(2) API filesystem tests
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 24, 2020 at 8:17 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jan 24, 2020 at 10:12 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 1/20/20 6:11 AM, Richard Haines wrote:
> > > Test filesystem permissions using the fsopen(2), fsconfig(2), fsmount(2),
> > > fspick(2) and fsmount(2) api's introduced in kernel 5.2.
> > >
> > > Also tests move_mount(2) using open_tree(2).
> > >
> > > These tests use common code from tests/filesystem.
> > >
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> >
> > Only question I have is whether we want to enable the move_mount test
> > unconditionally and let it break on kernels with the regression.  Otherwise,
>
> Historically we haven't broken the test suite for older kernels, but I
> will admit that testing older kernels is no longer a priority for me.

I'd say if we expect the bug to be fixed in the stable branches of all
affected (& currently supported) kernel versions, we should just let
the test run unconditionally. I see little value in trying to match
the exact set of broken kernel versions. So my vote is to be strict
and if that turns out to cause too much trouble, we can always add
some check (and be more careful next time).

>
> > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> >
> > > ---
> > >   tests/Makefile                   |   6 +
> > >   tests/fs_filesystem/.gitignore   |   3 +
> > >   tests/fs_filesystem/Makefile     |  16 +
> > >   tests/fs_filesystem/fs_common.c  | 110 ++++
> > >   tests/fs_filesystem/fs_common.h  |  30 ++
> > >   tests/fs_filesystem/fsmount.c    |  89 ++++
> > >   tests/fs_filesystem/fspick.c     |  68 +++
> > >   tests/fs_filesystem/move_mount.c |  76 +++
> > >   tests/fs_filesystem/test         | 833 +++++++++++++++++++++++++++++++
> > >   9 files changed, 1231 insertions(+)
> > >   create mode 100644 tests/fs_filesystem/.gitignore
> > >   create mode 100644 tests/fs_filesystem/Makefile
> > >   create mode 100644 tests/fs_filesystem/fs_common.c
> > >   create mode 100644 tests/fs_filesystem/fs_common.h
> > >   create mode 100644 tests/fs_filesystem/fsmount.c
> > >   create mode 100644 tests/fs_filesystem/fspick.c
> > >   create mode 100644 tests/fs_filesystem/move_mount.c
> > >   create mode 100755 tests/fs_filesystem/test
>
> --
> paul moore
> www.paul-moore.com
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

