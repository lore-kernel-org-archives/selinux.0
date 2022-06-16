Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5851FC433EF
	for <selinux@archiver.kernel.org>; Thu, 16 Jun 2022 10:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359728AbiFPKBd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jun 2022 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359757AbiFPKBc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jun 2022 06:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3C985C875
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 03:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655373687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ozoDvph0K6BA3g6r3howFDfcKnBzIAsGo6PsSlBh0Hw=;
        b=jPJvbCk1Fs4QEKbBfUY0CsSXuaEffIS2THdlXjxZETykxZGeL6XPo3BhKzq+YKgkgVY5oN
        Lr/mTaaaV6V+CMXAuPzZDAaBF1s+L5xTJsuFkaXymWqRIyfsncZwOqLeNumD68k30zpQUZ
        XO/xLuhZBB9cMrjxbkc40jqVWLC4PRs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-5Kr5POu2NiCGtKJPZBWdoA-1; Thu, 16 Jun 2022 06:01:25 -0400
X-MC-Unique: 5Kr5POu2NiCGtKJPZBWdoA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-317597643bfso8479877b3.20
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 03:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ozoDvph0K6BA3g6r3howFDfcKnBzIAsGo6PsSlBh0Hw=;
        b=0Vjvaw+ioPi2hTt9NB+HCJ/waBq0+OcOUNtx0C9NqohprNpch5T6rO8ajvWhAQsuTI
         15063QewOYNBgopctheyGz8kwWnkPwSwWWZrrkuBogbZeITVFUIf9Hg5/Zx1IV5Ucb48
         2s/ykD22IdQzDkGATr/Lc3xaLgFRCzgBiLY/PRRSva4SOuhYXwCwbCa/Ooaee+Cv2+UU
         AmM9HLV0uCF5EpEy2+2DlzrCkK1LPGKeheCU9jddfD3089mrFGj5qrG0X8j8Bb9eqLgS
         CM4EtClhaRu8VGMm9aLHVx+1uN9gsQx1WNswOrFs6KgS+GqyLSxQiX5mAdgxoMd3Fuzf
         4/cg==
X-Gm-Message-State: AJIora+SNwZPctWe9im3k0nyfOsHFFfhyQkPLZ5XkxLDjy5k6GlBnGY1
        5ZpFuK3odpY17u9Xdou3dAODhP2dYj8lobibQv9GguM1t/4iLZxjcFku1QEga52GSXeAJIuxXrD
        bnjM7n35fXg8xeZJYk9LNysP7JsPpl9IOnQ==
X-Received: by 2002:a25:5e87:0:b0:660:240c:784 with SMTP id s129-20020a255e87000000b00660240c0784mr4115347ybb.445.1655373684783;
        Thu, 16 Jun 2022 03:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ui7ESU6WffT6qj6SxFCwH4bvODzlCpQFC9BAQpAG52y5btPcyiS2azyJ9nUnq57Yas/SVGBWmfQY4dLiT9YXo=
X-Received: by 2002:a25:5e87:0:b0:660:240c:784 with SMTP id
 s129-20020a255e87000000b00660240c0784mr4115323ybb.445.1655373684527; Thu, 16
 Jun 2022 03:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220614102029.13006-1-cgzones@googlemail.com>
 <CAFqZXNt8rPZR-EdKD_yc6xKY0eQLUh51Kj4EpreF-Gek-pJYGA@mail.gmail.com> <CAJ2a_DfPn777=2zLjGFbCOjP-0JR2n7MwK6gVtU9vbQynuU-LA@mail.gmail.com>
In-Reply-To: <CAJ2a_DfPn777=2zLjGFbCOjP-0JR2n7MwK6gVtU9vbQynuU-LA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Jun 2022 12:01:13 +0200
Message-ID: <CAFqZXNuvEazZ96vPiRmNaQ3x7XKc436etGykZnj62_UU7B_jSQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] support Dash as default shell
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 15, 2022 at 4:31 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 14 Jun 2022 at 16:50, Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> >
> > On Tue, Jun 14, 2022 at 12:21 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > > Debian uses Dash as default shell and switching via
> > >
> > >     dpkg-reconfigure dash
> > >
> > > has become deprecated.
> > >
> > > * Use POSIX compliant `> target 2>&1` instead of `>& target`.
> >
> > I'm fine with this subset of changes.
> >
> > > * Call runcon directly to avoid a fork within Dash, which breaks test=
s
> > >   requiring to not change the PID of executing commands
> >
> > I don't seem to have such problem when I change the default shell to
> > dash on Fedora. Can you provide a minimal reproducer?
>
>
> =3D=3D=3D=3D test.pl =3D=3D=3D=3D
> #!/usr/bin/perl
>
> $basedir =3D $0;
> $basedir =3D~ s|(.*)/[^/]*|$1|;
>
> print "current PID: $$\n";
>
> if ( ( $pid =3D fork() ) =3D=3D 0 ) {
>    print "child PID: $$\n";
>    exec "runcon -t unconfined_execmem_t sh -c 'echo >$basedir/flag;
> while :; do :; done'";
>    #alternative: exec 'runcon', '-t', 'unconfined_execmem_t', 'sh',
> '-c', "echo >$basedir/flag; while :; do :; done";
>    exit;
> }
>
> # Wait for it to start.
> #system("bash -c 'read -t 5 <>$basedir/flag'");
> `/bin/bash -c 'read -t 5 <>$basedir/flag'`;
>
> $exists =3D kill 0, $pid;
> if ( $exists ) {
>    print "Process $pid is running:\n";
>    system("pstree -alpZ $pid");
> } else {
>    print "Process $pid is NOT running\n";
> }
>
> # Kill the process.
> kill KILL, $pid;
>
> exit;
> =3D=3D=3D=3D test.pl =3D=3D=3D=3D
>
> normal;
> current PID: 8558
> child PID: 8559
> Process 8559 is running:
> sh,8559,`unconfined_u:unconfined_r:unconfined_execmem_t:s0-s0:c0.c1023
> -c runcon -t unconfined_execmem_t bash -c 'echo >./flag; while :; do
> :; done'
>  =E2=94=94=E2=94=80bash,8561,`unconfined_u:unconfined_r:unconfined_execme=
m_t:s0-s0:c0.c1023
> -c echo >./flag; while :; do :; done

Hm, still not able to reproduce this behavior... Perhaps Debian's
version of dash doesn't implicitly exec the last command like bash and
Fedora 36's dash seem to do? Can you try if just adding "exec " before
"runcon" also fixes the issue?

exec "exec runcon -t unconfined_execmem_t sh -c 'echo >$basedir/flag;
while :; do :; done'";

>
> alternative:
> current PID: 8599
> child PID: 8600
> Process 8600 is running:
> sh,8600,`unconfined_u:unconfined_r:unconfined_execmem_t:s0-s0:c0.c1023
> -c echo >./flag; while :; do :; done

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

