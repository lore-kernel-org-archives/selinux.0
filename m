Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68615C43334
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 14:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbiFOObf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiFOObf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 10:31:35 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E824B1DD
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 07:31:31 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 111-20020a9d0378000000b0060c2db66d44so8948101otv.6
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mEof1+r5FN6g8rO/9MHvL6zAU+AsEtzz1vfZ0dtNv8E=;
        b=j6+7xHwCz6CGC6hC5r3P5vSFFvTDU0S4eYBTDC8WK67vPiINQoVY75yzwIMx0uEY7K
         79JMhdihyDlS6uNW4r23mpN49COpE6Qd9qdfGa0S2hDuVR0Hza5JSM9hJUTPrB7MLuj8
         BzLS3FX9tec7V8vOcxyBAadrzyHRij8xC4T04suk9jd8H9kzo6/CddEpKGjdKe+Dqm6e
         9l38l7dGwJ/gVq+LaoZLggzIB+TpOhfqTO3nUYfpYISO22YS8Pue71lzos/TvUNF2B/4
         3CzkRbc/nFApRgjqxSBqMKDl4OwBidqLC8DjyvsYNipooKaP8OuAzMyerpSjzNHXgE6j
         5AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mEof1+r5FN6g8rO/9MHvL6zAU+AsEtzz1vfZ0dtNv8E=;
        b=I9Tym+CBK9KxdDna+RDZ9BZftMYODUG9i6FmuIdD7sPZSTaAHQ1sBveEphMQnSXIw2
         7C0Ye1y7/9kTVbBWuThlr4z5c/TAtmuJ9gZ+R9JtNrVRumqMiohAPY6ldfI/VlSfZhAg
         kdIt6VS8euRIA7oyFnDwiq4rUsHJxZHi0aVE1Iwsc6aOALF7F5FbRFlK5NzTZi0CKxhi
         IgUPc3ksD4EYJ1f+Nu+utKBLYy02jGKau4Zl9+ZYKqIe1v5PHtrUFvB5qG4gLIARYPCE
         SL3fvJYOwdz7diiamJmNVj7BmTybxzWD26JxfEeQ+qj4Rlw4SKkvK7O95TopDlh/1r26
         ODlA==
X-Gm-Message-State: AJIora/uE6YKU8F8vS9DOMDhXfHLA3yB7KG18wDEVpfm4aMTRh5YQIoG
        /nqLAMOxYyaOxbdLuSoUeOl/hKWfsjNRtqzpIq8=
X-Google-Smtp-Source: AGRyM1vgy/WB7i9FhA3IwB5TQhgrOu5nanV2ULcMYpFy9dDg44VXbGcOznWQ5UkrAaJhib6ZnJeUaVgAe36UTqmeRyU=
X-Received: by 2002:a9d:360a:0:b0:60b:e5b3:4f0c with SMTP id
 w10-20020a9d360a000000b0060be5b34f0cmr44118otb.117.1655303490521; Wed, 15 Jun
 2022 07:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220614102029.13006-1-cgzones@googlemail.com> <CAFqZXNt8rPZR-EdKD_yc6xKY0eQLUh51Kj4EpreF-Gek-pJYGA@mail.gmail.com>
In-Reply-To: <CAFqZXNt8rPZR-EdKD_yc6xKY0eQLUh51Kj4EpreF-Gek-pJYGA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 15 Jun 2022 16:31:19 +0200
Message-ID: <CAJ2a_DfPn777=2zLjGFbCOjP-0JR2n7MwK6gVtU9vbQynuU-LA@mail.gmail.com>
Subject: Re: [PATCH 1/4] support Dash as default shell
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 14 Jun 2022 at 16:50, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Jun 14, 2022 at 12:21 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> > Debian uses Dash as default shell and switching via
> >
> >     dpkg-reconfigure dash
> >
> > has become deprecated.
> >
> > * Use POSIX compliant `> target 2>&1` instead of `>& target`.
>
> I'm fine with this subset of changes.
>
> > * Call runcon directly to avoid a fork within Dash, which breaks tests
> >   requiring to not change the PID of executing commands
>
> I don't seem to have such problem when I change the default shell to
> dash on Fedora. Can you provide a minimal reproducer?


=3D=3D=3D=3D test.pl =3D=3D=3D=3D
#!/usr/bin/perl

$basedir =3D $0;
$basedir =3D~ s|(.*)/[^/]*|$1|;

print "current PID: $$\n";

if ( ( $pid =3D fork() ) =3D=3D 0 ) {
   print "child PID: $$\n";
   exec "runcon -t unconfined_execmem_t sh -c 'echo >$basedir/flag;
while :; do :; done'";
   #alternative: exec 'runcon', '-t', 'unconfined_execmem_t', 'sh',
'-c', "echo >$basedir/flag; while :; do :; done";
   exit;
}

# Wait for it to start.
#system("bash -c 'read -t 5 <>$basedir/flag'");
`/bin/bash -c 'read -t 5 <>$basedir/flag'`;

$exists =3D kill 0, $pid;
if ( $exists ) {
   print "Process $pid is running:\n";
   system("pstree -alpZ $pid");
} else {
   print "Process $pid is NOT running\n";
}

# Kill the process.
kill KILL, $pid;

exit;
=3D=3D=3D=3D test.pl =3D=3D=3D=3D

normal;
current PID: 8558
child PID: 8559
Process 8559 is running:
sh,8559,`unconfined_u:unconfined_r:unconfined_execmem_t:s0-s0:c0.c1023
-c runcon -t unconfined_execmem_t bash -c 'echo >./flag; while :; do
:; done'
 =E2=94=94=E2=94=80bash,8561,`unconfined_u:unconfined_r:unconfined_execmem_=
t:s0-s0:c0.c1023
-c echo >./flag; while :; do :; done

alternative:
current PID: 8599
child PID: 8600
Process 8600 is running:
sh,8600,`unconfined_u:unconfined_r:unconfined_execmem_t:s0-s0:c0.c1023
-c echo >./flag; while :; do :; done


> > * Use bash explicitly for non POSIX read option -t
>
> I'd like to try to find some nicer alternative for this one first...
> If I don't find one, then yours will have to do, I guess.
>
> Any specific reason why you used `` instead of system()? AFAIK the
> only difference is that `` return the command's stdout as a string,
> while system() returns the exit code and forwards stdout.
>
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  README.md                      |  7 -------
> >  tests/binder/test              |  2 +-
> >  tests/bpf/test                 |  4 ++--
> >  tests/fdreceive/test           |  2 +-
> >  tests/filesystem/Filesystem.pm | 14 +++++++-------
> >  tests/inet_socket/test         |  2 +-
> >  tests/ptrace/test              |  6 +++---
> >  tests/sctp/test                |  2 +-
> >  tests/sigkill/test             |  2 +-
> >  tests/task_getpgid/test        |  6 +++---
> >  tests/task_getscheduler/test   |  6 +++---
> >  tests/task_getsid/test         |  6 +++---
> >  tests/task_setnice/test        |  6 +++---
> >  tests/task_setscheduler/test   |  6 +++---
> >  tests/unix_socket/test         |  2 +-
> >  tests/vsock_socket/test        |  2 +-
> >  16 files changed, 34 insertions(+), 41 deletions(-)
> >
> (snip)
>
> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
