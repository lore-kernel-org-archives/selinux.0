Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40DFC388F2
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA69222B9
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 12:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BduIiacX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgKBMU2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 07:20:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728537AbgKBMU1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 07:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604319626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dM1irNjYPFtJZ5KIfXmHIvxfdR0qXqWZ+GfquqTZjJ8=;
        b=BduIiacXyo3Hi/aY63QYJuy7aqOSPDuOpnNiIUZincsguqlFUh4Z1JUFAkzmGIoX07ia5o
        Ifqq077WRL9eMyc3pDgQkoRmjq0GAF44rN6a9yZxUzaeEhqjNycBpH3syR1rBmHaISNymI
        XBsUrecFQ69DBJvEKBJh7xAqqAdhIQ0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-AzOyZsd1M-m5PvWSRqTeyQ-1; Mon, 02 Nov 2020 07:20:22 -0500
X-MC-Unique: AzOyZsd1M-m5PvWSRqTeyQ-1
Received: by mail-lj1-f197.google.com with SMTP id f14so5746805ljg.18
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 04:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dM1irNjYPFtJZ5KIfXmHIvxfdR0qXqWZ+GfquqTZjJ8=;
        b=Iuh8MZ+i/BvX+27uBAOY/i7UKf7nBb0l/fAfFwq58GkVejINeueQ4Z0hVhDrhzKuS8
         B72MdYO4ganRFZW/xdG6vTHL4GZqlxYEGokpSF6TtdV9BqnqPa9sM1LLHfaCOpJgDRWa
         Z9CioXmJ1T2J9EeGJzQKv/ThoOO5lQnysYhC8ySeWMzAn+JONA48/xxBr6yRaTXE4XSx
         8qvXxUhOM95Eq/WHR06mJl0DU1gNnVGggO8V5XZt6zbLFX68r1xR/Ie7SYZ+qTAM5a3f
         UnO2QOkz05gau1AJzM+PET4OKWqrjApp9NXRpQtFS1lIM+4btjv5f7OJEj/fTCnmr4Mc
         QYrg==
X-Gm-Message-State: AOAM531Mlkct0cGsukmJzE3d04qC++llJWKHfR5Z15gQ4kE98dF1w/OU
        IcTFQNT0DZBr3wvz4XXGAq0GpsXA2HGmCy3DvC9ZdvkCrtn60G730ibg4rzC3Jqkbj4ATZgPCYZ
        P6ahXrN7VyB1RIWzXwmzN8eP+geX3Kj4xlg==
X-Received: by 2002:a2e:b60e:: with SMTP id r14mr6700413ljn.77.1604319620976;
        Mon, 02 Nov 2020 04:20:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjtr4a3TK4vPGH934ZVdrMWzNq1F01ezG+5NaFOqrz4fayx6vPQtdk1E+p+5NUU3tXAkNws5FjDjIBdN7J2dw=
X-Received: by 2002:a2e:b60e:: with SMTP id r14mr6700407ljn.77.1604319620778;
 Mon, 02 Nov 2020 04:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20201102083516.477149-1-omosnace@redhat.com> <20201102083516.477149-2-omosnace@redhat.com>
 <7963858698dc5060170db74f70c5a9cb00b611db.camel@btinternet.com>
In-Reply-To: <7963858698dc5060170db74f70c5a9cb00b611db.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 2 Nov 2020 13:20:09 +0100
Message-ID: <CAFqZXNugBoMM126Z9GHEwefL_VbW++Jwv8Qy+dN+2NqvMmOFrA@mail.gmail.com>
Subject: Re: [PATCH testsuite v2 1/4] README,travis: add e2fsprogs, jfsutils,
 and dosfstools to deps
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 2, 2020 at 1:03 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Mon, 2020-11-02 at 09:35 +0100, Ondrej Mosnacek wrote:
> > They are needed for ext4, jfs, and vfat tests, which will become
> > executed by default in an upcoming patch.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  README.md                  | 6 ++++++
> >  travis-ci/run-testsuite.sh | 3 +++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/README.md b/README.md
> > index 838a082..1149f30 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -58,6 +58,9 @@ similar dependencies):
> >  * keyutils-libs-devel _(tools used by the keys tests)_
> >  * kernel-devel _(used by the kernel module tests)_
> >  * quota, xfsprogs-devel and libuuid-devel _(used by the filesystem
> > tests)_
> > +* e2fsprogs _(used by the ext4 filesystem tests)_
> > +* jfsutils _(used by the jfs filesystem tests)_
> > +* dosfstools _(used by the vfat filesystem tests)_
> >  * nftables _(used by inet_socket and sctp tests if ver >= 9.3 for
> > secmark testing )_
> >
> >  On a modern Fedora system you can install these dependencies with
> > the
> > @@ -81,6 +84,9 @@ following command (NOTE: On Fedora 32 and below you
> > need to remove
> >               quota \
> >               xfsprogs-devel \
> >               libuuid-devel \
> > +             e2fsprogs \
> > +             jfsutils \
> > +             dosfstools \
>
> I guess these should also be under Debian as well.

Yes, absolutely! I missed that section, because I saw only the line
"apt-get install selinux-basics selinux-policy-default auditd" and
thought that there is no such comprehensive list for Debian... Should
have looked more carefully.

Given that this is just documentation, I'll add them when applying so
I don't need to repost everything. I'll make sure to double-check the
package names, which might be different on Debian.

Thank you for the review!


>
> >               nftables \
> >               kernel-devel-$(uname -r) \
> >               kernel-modules-$(uname -r)
> > diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
> > index 051f9d8..bd9073c 100755
> > --- a/travis-ci/run-testsuite.sh
> > +++ b/travis-ci/run-testsuite.sh
> > @@ -38,6 +38,9 @@ dnf install -y \
> >      quota \
> >      xfsprogs-devel \
> >      libuuid-devel \
> > +    e2fsprogs \
> > +    jfsutils \
> > +    dosfstools \
> >      kernel-devel-"$(uname -r)" \
> >      kernel-modules-"$(uname -r)"
> >
>


--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

