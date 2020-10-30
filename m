Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651ABC388F9
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 23:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F092224E
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 23:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwepECcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgJ3XpF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 19:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgJ3XpF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 19:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604101503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lux5EuM7JshYrbNJrrD+th+z0TAjGXVKLIy8KMEt3ZA=;
        b=AwepECcNhk/HAuLRqxEuEBDZbp5g5Ip5jlVMChrrcKK6tiCCXx33AynQFfA4/SABMxY1Vl
        baVcgaOldAW6eXzJZVLFUb2kUSqlhT/gtedh4/Tcqy144q5MCWnkkqSv85xFf07XzhMoY+
        NDL9rgaSnBCkBahpt497g2w8fEbx6Pg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-pbOqZP8kMwOwUvePAWx7hg-1; Fri, 30 Oct 2020 19:45:00 -0400
X-MC-Unique: pbOqZP8kMwOwUvePAWx7hg-1
Received: by mail-lj1-f199.google.com with SMTP id s185so3304011lja.5
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 16:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lux5EuM7JshYrbNJrrD+th+z0TAjGXVKLIy8KMEt3ZA=;
        b=ht/VQvsxBMJ2uI+gI5MH52uWnkEvDrZthoMjR9qrwt2MV5t9VbH9gsU8HQNzu2sjex
         ZAWavOoVgdGrx5+N9YK4ijPlxslkxYDybOV+3CkWRku0sjofQyjByXHpGNWjHx91ZFsI
         DBaG1CkRq9yZuRNzhJ+ThYLCpgkJ1gE027zFD8lfScdevULKk+J44u06qGQC4T6DfOs2
         HQ5ZnTPf+6Mmy+3TdgcPbuKPZ/MMJUQVyWuzRAC66EKDxyGt4ig4b2nei2X9wu0JDwfa
         8hudpqUsIby/CRK5gbLk1j71MMbWErVWawmywEt+WhbvgtJ7dpPeeBQxXzoIDy+c8Csw
         zIpw==
X-Gm-Message-State: AOAM531n1F1YwM/pjseYowJqD8SSmMhjshCTlQLxpYiKehQ7GJS1E/xg
        YWhLl5gC6C6UdlJhvwb4Zsml0mTWUYLvNR3h2kbrfsti+ou2o+onnjIZdZNQkyKwUQSuvLUASzL
        Ud/Rh1ewK5WUOtkjj5+9c7coY8ZdTxAMT+g==
X-Received: by 2002:a2e:b009:: with SMTP id y9mr1951380ljk.372.1604101498298;
        Fri, 30 Oct 2020 16:44:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYNM8LqglqvEgEGTMdtxk+1BLVBaOtdjUcOWhC2xcJT0JwvJ+mXk8+OFWEvDvOLjzSjsbBmdfJXvUq7n8Oc24=
X-Received: by 2002:a2e:b009:: with SMTP id y9mr1951378ljk.372.1604101498087;
 Fri, 30 Oct 2020 16:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201013145456.77253-1-richard_c_haines@btinternet.com> <CAFqZXNu1o3rTRcrNBRwESt+txA+chc3PcdFjrZFiP50koceyAQ@mail.gmail.com>
In-Reply-To: <CAFqZXNu1o3rTRcrNBRwESt+txA+chc3PcdFjrZFiP50koceyAQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 31 Oct 2020 00:44:47 +0100
Message-ID: <CAFqZXNtubRw-pqEiuxwzp=6n53Gnso3oOoExbhc+OhWcQ5ESAA@mail.gmail.com>
Subject: Re: [PATCH 0/1] selinux-testsuite: Add btrfs support for filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 30, 2020 at 10:55 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Oct 13, 2020 at 4:55 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > This patch allows BTRFS filesystems to be tested.
> >
> > The tests/filesystem all pass using './test -f btrfs' on Fedora 32.
>
> For me, also these tests are failing (41 of 58):
>
> Test Summary Report
> -------------------
> filesystem/btrfs/test     (Wstat: 10496 Tests: 58 Failed: 41)
>   Failed tests:  3-4, 10, 13-15, 17-25, 27-28, 30-37, 39-45
>                 47-55
>   Non-zero exit status: 41

Oh, never mind... The reason why these were failing was that
btrfs-progs was not installed on the system. After installing that
package, only the fs_filesystem tests fail for btrfs.

Please add btrfs-progs as a dependency to README.md and
travis-ci/run-testsuite.sh in future versions of the patch.

> fs_filesystem/btrfs/test  (Wstat: 10752 Tests: 57 Failed: 42)
>   Failed tests:  3, 9-10, 13-26, 28-36, 38-44, 46-54
>   Non-zero exit status: 42
>
> See full log here:
> https://travis-ci.com/github/WOnder93/selinux-testsuite/jobs/422684295#L2711
>
> (Don't be confused by the unusual test output - I'm experimenting with
> running the tests for all filesystems in a single testsuite run.)
>
> And on related note, the existing vfat tests are also failing:
> Test Summary Report
> -------------------
> filesystem/vfat/test      (Wstat: 7936 Tests: 43 Failed: 31)
>   Failed tests:  3-4, 6-7, 10-12, 14-19, 21-22, 24-36, 38-40
>   Non-zero exit status: 31
> fs_filesystem/vfat/test   (Wstat: 8192 Tests: 42 Failed: 32)
>   Failed tests:  3, 5-7, 10-20, 22-35, 37-39
>   Non-zero exit status: 32

And this might be the same problem, but with dosfstools... I'll need to check.

>
> Full log here: https://travis-ci.com/github/WOnder93/selinux-testsuite/jobs/422652226#L2703
>
> > The tests/fs_filesystem fail 42 of 57 using './test -f btrfs' on Fedora 32.
> >
> > As Fedora 33/Rawhide now defaults to using btrfs, running 'make test' will
> > fail 42 of 57 fs_filesystem tests (tested on Rawhide).
> >
> > These fs_filesystem failures are caused by a bug when using the fsmount(2)
> > type calls that was reported in [1].
>
> I'll try to dig into this a little bit. It seems that FS maintainers
> are not interested :(
>
> >
> > Note btrfs requires a much larger image size (min 115 MiB), and therefore
> > takes more than 2x longer to run tests than ext4.
> >
> > [1] https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/
> >
> > Richard Haines (1):
> >   selinux-testsuite: Add BTRFS support for filesystem tests
> >
> >  tests/filesystem/Filesystem.pm | 10 +++++++++-
> >  tests/filesystem/test          |  6 ++++++
> >  tests/fs_filesystem/test       |  6 ++++++
> >  3 files changed, 21 insertions(+), 1 deletion(-)
> >
> > --
> > 2.26.2
> >
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.



-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

