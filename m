Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285DDC388F7
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 09:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC2420756
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 09:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUBZwHx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgJaJDg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 05:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbgJaJDf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 05:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604135014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oHaOC/aMlcVx+Kp0eOVeeylV5z97o8Wy1wGjV5oilgM=;
        b=jUBZwHx/FcGg7vAwy4eDuQdkDfMmWeNdoMerJQ4qwD6tCPv2+9xCh2rKu6A0VdSiqLhCPG
        YTN2lfEi9ng9FaCA5SvfOjEAIA0AgfifLSxkK7cwUkIVEzJTtfQxMSDMy1wO5JUH0r93gX
        HU5JFxTHFIlCXmospHRdMPlcQ9PkOTw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-SNHey5xXOYSiiSI_h9hiew-1; Sat, 31 Oct 2020 05:03:31 -0400
X-MC-Unique: SNHey5xXOYSiiSI_h9hiew-1
Received: by mail-lj1-f198.google.com with SMTP id f4so3701319ljn.2
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 02:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHaOC/aMlcVx+Kp0eOVeeylV5z97o8Wy1wGjV5oilgM=;
        b=nzgZPn0+5pkAlZJor6EEPu4E4ZwOn9U1GsrH5Y/YoFQ4XA5lBbl0lf6Ng8bR33nYmZ
         31Lpbs9/7Dp95WGq40JRi2ItiVR03oBbQ2kzG1vxNU1tZ4il6bmBc+B2rx/RpTB6mfQ2
         bIkjrT6xvkgq3i0bWfXyrATqNhpf1YAWLBn5p2+X+xhX7EY8xFaJzHOWR9Uj9mFT/TkB
         bY7rBZNZGdvWXIVlQQvf049VVZmIGTiH61sWscKItOKk8gMn8nfYb/QusMBB7jjEPSAF
         QY8cUP4cEVAcBCOPFqKy84nLqdaJnjYWt/QNZzA1OtOmy052g/1LG/0SaDzpF+vpsfxT
         KC0Q==
X-Gm-Message-State: AOAM5318oDdLCNymENzm0a8ioxTRfRiKq/y9sKBEUnYcowQKxlBkZ3J4
        QBww+KMB/gr1a9T1LHU1kQ0+e1ti8qfW8+a1EaOCHRfvVXboLyiWGtQ4NwVeiJssZe2VYgjdX1C
        liJDkel5n6c/O20Fb1LbSzCXXt/kC/ik6Aw==
X-Received: by 2002:a2e:7815:: with SMTP id t21mr2533761ljc.217.1604135009377;
        Sat, 31 Oct 2020 02:03:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysAFOz6gFuZNuPQoXZwZ89rsWqY9d2e6OklC+Bb/e5Atp0eYW0dIn88CelYpjq6U7y86XfqctU9faTTfjzsds=
X-Received: by 2002:a2e:7815:: with SMTP id t21mr2533757ljc.217.1604135009180;
 Sat, 31 Oct 2020 02:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201013145456.77253-1-richard_c_haines@btinternet.com>
 <CAFqZXNu1o3rTRcrNBRwESt+txA+chc3PcdFjrZFiP50koceyAQ@mail.gmail.com> <CAFqZXNtubRw-pqEiuxwzp=6n53Gnso3oOoExbhc+OhWcQ5ESAA@mail.gmail.com>
In-Reply-To: <CAFqZXNtubRw-pqEiuxwzp=6n53Gnso3oOoExbhc+OhWcQ5ESAA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 31 Oct 2020 10:03:17 +0100
Message-ID: <CAFqZXNtOd5CNXF49pKcDUf3Aag=V1-+nidFePX0hknteg9tq-g@mail.gmail.com>
Subject: Re: [PATCH 0/1] selinux-testsuite: Add btrfs support for filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Oct 31, 2020 at 12:44 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Oct 30, 2020 at 10:55 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Tue, Oct 13, 2020 at 4:55 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > >
> > > This patch allows BTRFS filesystems to be tested.
> > >
> > > The tests/filesystem all pass using './test -f btrfs' on Fedora 32.
> >
> > For me, also these tests are failing (41 of 58):
> >
> > Test Summary Report
> > -------------------
> > filesystem/btrfs/test     (Wstat: 10496 Tests: 58 Failed: 41)
> >   Failed tests:  3-4, 10, 13-15, 17-25, 27-28, 30-37, 39-45
> >                 47-55
> >   Non-zero exit status: 41
>
> Oh, never mind... The reason why these were failing was that
> btrfs-progs was not installed on the system. After installing that
> package, only the fs_filesystem tests fail for btrfs.
>
> Please add btrfs-progs as a dependency to README.md and
> travis-ci/run-testsuite.sh in future versions of the patch.

...and please also don't forget to update defconfig :)

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

