Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A8BC388F9
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 20:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4132072C
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 20:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdATgl6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgJaUng (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 16:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728524AbgJaUnf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 16:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604177013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kWcW2SVSlNcCFL3k79YLgkLP6RMPg7XJ2SKUEVFyvHk=;
        b=gdATgl6Ne87i3N9D9C7gwN4N74Au0pQ2IKmj68vZilWbW34AOTuJKLxwM0Cq2lkwuD9Ibz
        mwM7AK0n8t+fTOVYexGMfj2FHA5PjRttGX32pZ0vXl0mb0WxmLSrx8jYViENNyn2eGWM7x
        d89bWZaXqWrI4grhZ/2PpgFPfTeVVZM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-q7LPbqCzPyitDKsTCGCsHQ-1; Sat, 31 Oct 2020 16:43:32 -0400
X-MC-Unique: q7LPbqCzPyitDKsTCGCsHQ-1
Received: by mail-lj1-f197.google.com with SMTP id z8so4182059ljc.10
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 13:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWcW2SVSlNcCFL3k79YLgkLP6RMPg7XJ2SKUEVFyvHk=;
        b=IS5q36h64xrTUWDQT0K5yJ02jgyNlwd6UiAldSr7drpSuGRVtbyfOdgEzccPJ09EON
         ezl4sKdhEEbBgI8flcLOTXyaQgi3XK7fLHUMszCUVtI11RffiqBb0qNgOap8k6+3TiHN
         YSmpazd3QMfe+W8XPT8n8HEI0u4aJViGFcd6OIZm+u04m/JXDlZf0m37KnjjSkWF68n5
         oCFUy++oOYpw9zzU7H772On7PYTTTwwUk2BJFxyBh9i5VMDz0+UAoWm9yXLD0FNigeEz
         pD7S92hkl4Og0eqf9/95r5dFi0hKM6/eIzMpHWo7AKgC6IHaotdSJil5g6VJ0ev6SNWH
         N16Q==
X-Gm-Message-State: AOAM532hH4EdGk25ChBdFhSOsDNb/GzfdUv1jjTBTXjIo/i7a8eLf0v5
        arx993QFfkIMRLZxIt3WDmysLMLeO8GJaN1d9e9yLIBrI+hkxQf6PTf2k+TtHTweAJJfZFjdT6i
        G+lX+B956yhAX+H94sDISnTVhF7ViXxI9nA==
X-Received: by 2002:a19:f605:: with SMTP id x5mr3172564lfe.39.1604177010457;
        Sat, 31 Oct 2020 13:43:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJVhzkFMdKwKJMcI8BB7SPy8YSz1tmWa+2G+RqbSFiwZrKbbDaUIyizWeK+AK0HYYzPjtZmhg2TzfwVJhJ79M=
X-Received: by 2002:a19:f605:: with SMTP id x5mr3172560lfe.39.1604177010222;
 Sat, 31 Oct 2020 13:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201031115601.157591-1-omosnace@redhat.com> <20201031115601.157591-4-omosnace@redhat.com>
 <c5a80f14035b607b58ce6e4bb5b2fc9c2e8187ee.camel@btinternet.com>
In-Reply-To: <c5a80f14035b607b58ce6e4bb5b2fc9c2e8187ee.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 31 Oct 2020 21:43:19 +0100
Message-ID: <CAFqZXNt8p7D-muwuuxfa55kawodxE8czu_JeqkiDbVRuz4it0w@mail.gmail.com>
Subject: Re: [PATCH testsuite 3/3] tests/[fs_]filesystem: test all filesystems
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Oct 31, 2020 at 7:05 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Sat, 2020-10-31 at 12:56 +0100, Ondrej Mosnacek wrote:
> > Run [fs_]filesystem tests always for all common filesystems (xfs,
> > ext4,
> > jfs, vfat). Use symlinks to achieve this without changing much code
> > while still allowing to run the test script directly (optionally
> > specifying the filesystem type).
>
> These ran okay using 'make test', however when I moved to
> tests/filesystem and ran ./test the fs_type was .. Also when I moved to
> filesystems/xfs and ran ./test, the move mount failed because mount
> does not like sym links and resolves to realpath.
>
> I've had a go at fixing these and I've noted the changes below (please
> feel free to rework). The fs_filesystem also has the same issues.

Heh, I should've tried it before making that claim :)

> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  tests/Makefile           |  8 ++++++--
> >  tests/filesystem/ext4    |  1 +
> >  tests/filesystem/jfs     |  1 +
> >  tests/filesystem/test    | 14 ++++++++++++--
> >  tests/filesystem/vfat    |  1 +
> >  tests/filesystem/xfs     |  1 +
> >  tests/fs_filesystem/ext4 |  1 +
> >  tests/fs_filesystem/jfs  |  1 +
> >  tests/fs_filesystem/test | 14 ++++++++++++--
> >  tests/fs_filesystem/vfat |  1 +
> >  tests/fs_filesystem/xfs  |  1 +
> >  11 files changed, 38 insertions(+), 6 deletions(-)
> >  create mode 120000 tests/filesystem/ext4
> >  create mode 120000 tests/filesystem/jfs
> >  create mode 120000 tests/filesystem/vfat
> >  create mode 120000 tests/filesystem/xfs
> >  create mode 120000 tests/fs_filesystem/ext4
> >  create mode 120000 tests/fs_filesystem/jfs
> >  create mode 120000 tests/fs_filesystem/vfat
> >  create mode 120000 tests/fs_filesystem/xfs
> >
[...]
> > diff --git a/tests/filesystem/test b/tests/filesystem/test
> > index 7d4654d..6b37b76 100755
> > --- a/tests/filesystem/test
> > +++ b/tests/filesystem/test
> > @@ -12,6 +12,17 @@ BEGIN {
> >      $basedir = $0;
> >      $basedir =~ s|(.*)/[^/]*|$1|;
> >
> > +    # extract test_name and move up one dir if started from a subdir
> > +    $test_name = $basedir;
> > +    $test_name =~ s|.*/([^/]*)|$1|;
> > +    if ( $test_name eq "fs_filesystem" ) {
> > +        $fs_type = " ";
> > +    }
> > +    else {
> > +        $fs_type = $test_name;
> > +        $basedir =~ s|(.*)/[^/]*|$1|;
> > +    }
> > +
>
> I changed the above to this:
>
>     # extract test_name and move up one dir if started from a subdir
>     $test_name = $basedir;
>     $test_name =~ s|.*/([^/]*)|$1|;
>     if ( $test_name eq "." ) {
>         $cwd = `pwd 2>/dev/null`;
>         chomp($cwd);
>         my($d_name) = ($cwd =~ m#/([^/]+)$#);
>         if ( $d_name eq "filesystem" ) {
>             $fs_type = " ";
>         }
>         else {
>             $fs_type = $d_name;
>         }
>     }
>     else {
>         $fs_type = $test_name;
>         $basedir =~ s|(.*)/[^/]*|$1|;
>     }

Yes, I'll need to use something similar. Thanks!

>
> >      # Options: -v Verbose, -e enable udisks(8) daemon, -f filesystem
> > type
> >      $v              = " ";
> >      $disable_udisks = 1;
> > @@ -20,8 +31,7 @@ BEGIN {
> >      $nfs_enabled    = 0;
> >      $vfat_enabled   = 0;
> >
> > -    $i       = 0;
> > -    $fs_type = " ";
> > +    $i = 0;
> >      foreach $arg (@ARGV) {
> >          if ( $arg eq "-v" ) {
> >              $v = $arg;
>
>
>
> Also to fix the move mount sym link problem I changed:
>
> # mount(2) MS_BIND | MS_PRIVATE requires an absolute path to a private
> mount
> # point before MS_MOVE
> $cwd = `pwd 2>/dev/null`;
> chomp($cwd);
> if ( $basedir eq "." ) {
>     $target = `realpath -e $cwd`;
>     chomp($target);
>     $private_path = "$target/mntpoint";
> }
> else {
>     $private_path = "$cwd/$basedir/mntpoint";
> }
>
> The reason the move mount check failed was because I was passing the
> original sym link paths such as: ..../tests/filesystem/vfat to mount.c
> that had a compare to check if moved. However it was mounted on the
> real path (..../tests/filesystem/..) not the sym link.

I think I might have a simpler way to solve this... I'll have to try it.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

