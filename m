Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EA7C54EE9
	for <selinux@archiver.kernel.org>; Mon, 19 Sep 2022 11:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiISLRx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Sep 2022 07:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiISLRx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Sep 2022 07:17:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EF410543
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 04:17:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z97so40724320ede.8
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 04:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=EYqEyCLLzSjg9h6WPDquAoSiMa2Ir+u8dA8vT3OcTdA=;
        b=kI4dHu9YQ2wir73Vc2JsNrHEEWzlMpngoygcAK2DFkO9882yw4fMqGqaRMrelcImiz
         gOt3g23/NbyxujzaUX1FqEz9pw3SbWSbQbP6zx0UQ8bJ9AVNShyYQ2kW5Crd3u9gbY9Q
         7wXTqTZBcik7/WsM3uzzLZcAf/EbWCTAIkMVthhAo5By8G4EwH7ur34qFm+d1V0yYKX2
         u5qkFYwMtY5pUOh4v4O6u8tciuY74IoAxXFx6eawwMvrEGvzt1aRMJoHBDlhp+fhWStD
         Mg8hffziYyNwWxnnVGG6wVufQOuZysUFJAKEkx9Z0JBRt7DO4CO9KnLzVN5sNE5d6rou
         kahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EYqEyCLLzSjg9h6WPDquAoSiMa2Ir+u8dA8vT3OcTdA=;
        b=x8owa1NK2UCZpb+dGN5kUoeMscHxcZOwmQYs7zugcCRYuPoIG7F7bnmKoZWS7bk2DD
         oYK4e555ouIJosKzLGVETeBZFIMOQywqVzs+LcQE7mSTx7zlRopVX1clmIp3bgcK1Me4
         +IPVnvy0oZo33tLPSLoWnPZxChndzlITDgl3e1eOJa3bg+XcvrziQWn+4ldkhLecm7c6
         +cTO4LVbwaQu4vI/m2UNkQOtYS2bXzFPOOmrncVAPh5jo1DFhc4ryY3xnYSSXYlkKbv9
         IcCWyltvZvPF7Et9zhsygleUkooR/yX/ds075mBsbjNq6P1qk+hRvQdCa3THO85a1oqb
         L6pg==
X-Gm-Message-State: ACrzQf2k1ttF7VhBkchEqYr2yh6c2u16aVegl9rXh6E258bpz8XoGVUV
        Jw19ALt+51Nt0n3778ywETrLJec3bFrx9l8CIS4=
X-Google-Smtp-Source: AMsMyM7YQzKY95a4VHSBlKB531I2oYBJgv4aamOUSuTmtk1SDyOswIhkZxueCidOuUegF5CiSLaOfe8dnASCRaBIp7w=
X-Received: by 2002:a05:6402:254b:b0:451:2b1d:d82c with SMTP id
 l11-20020a056402254b00b004512b1dd82cmr15461645edb.343.1663586269605; Mon, 19
 Sep 2022 04:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220915163751.41804-1-plautrba@redhat.com> <20220916141308.72606-1-plautrba@redhat.com>
 <CAJ2a_DeBWkHziE4+DsRqqLULtGkdX68c8jdU3Hxs++84NoPpsQ@mail.gmail.com> <CAFqZXNvr6_kjfMxuCUqn_yAonEk0tRwFV7KVpYn+b1Ft=n_sMQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvr6_kjfMxuCUqn_yAonEk0tRwFV7KVpYn+b1Ft=n_sMQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 19 Sep 2022 13:17:37 +0200
Message-ID: <CAJ2a_Ddnxzoy=FwnS_Cm8ij3irvjaggGS0_4cP1Uj-dPrS4kNQ@mail.gmail.com>
Subject: Re: [PATCH v3] fixfiles: Unmount temporary bind mounts on SIGINT
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 19 Sept 2022 at 10:39, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> (Resending without HTML...)
>
> On Fri, Sep 16, 2022 at 5:37 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On Fri, 16 Sept 2022 at 16:14, Petr Lautrbach <plautrba@redhat.com> wro=
te:
> > >
> > > `fixfiles -M relabel` temporary bind mounts filestems before relabeli=
ng
> > > but it leaves a directory mounted in /tmp/tmp.XXXX when a user hits
> > > CTRL-C. It means that if the user run `fixfiles -M relabel` again and
> > > answered Y to clean out /tmp directory, it would remove all data from
> > > mounted fs.
> > >
> > > This patch changes the location where `fixfiles` mounts fs to /run an=
d
> > > adds a handler for exit signals which tries to umount fs mounted by
> > > `fixfiles`.
> >
> > What about additionally using mount namespaces, if available:
>
> What benefit would it bring? (Sorry, I'm not very familiar with mount
> namespaces.)

The bind mounts will only be visible to the process and its children
used in the unshare command (and processes explicitly joining that
mount namespace) and not to other (parallel or subsequent) instances
of fixfiles.

>
> >
> > @@ -256,10 +256,16 @@
> >                    test -z ${TMP_MOUNT+x} && echo "Unable to find
> > temporary directory!" && exit 1
> >
> >                    mkdir -p "${TMP_MOUNT}${m}" || exit 1
> > -                   mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> > -                   ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG}
> > ${THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> > -                   umount "${TMP_MOUNT}${m}" || exit 1
> > -                   rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> > +                   if ! unshare --mount /bin/sh -c "mount --bind
> > \"${m}\" \"${TMP_MOUNT}${m}\" || exit 1 && ${SETFILES} ${VERBOSE}
> > ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -q ${FC} -r \"${TMP_MOUNT}\"
> > \"${TMP_MOUNT}${m}\" || true"; then
> > +                        echo "Creating new mount namespace failed,
> > operating in root namespace"
> > +                       mount --bind "${m}" "${TMP_MOUNT}${m}" || exit =
1
> > +                       ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS}
> > ${FORCEFLAG} ${THREADS} $* -q ${FC} -r "${TMP_MOUNT}"
> > "${TMP_MOUNT}${m}"
> > +                       umount "${TMP_MOUNT}${m}" || exit 1
> > +                    fi
> > +                    if [ "${m}" !=3D '/' ]; then
> > +                        rmdir "${TMP_MOUNT}${m}" || echo "Error
> > cleaning up ${TMP_MOUNT}${m}."
> > +                    fi
> > +                   rmdir "${TMP_MOUNT}"     || echo "Error cleaning
> > up ${TMP_MOUNT}."
> >                done;
> >            fi
> >        else
> >
> > ?
> >
> > >
> > > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2125355
> > >
> > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > > ---
> > > v2:
> > >
> > > - set trap on EXIT instead of SIGINT
> > >
> > > v3:
> > >
> > > - use /run instead of /tmp for mountpoints
> > >
> > >
> > >  policycoreutils/scripts/fixfiles | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scrip=
ts/fixfiles
> > > index c72ca0eb9d61..acf5f0996c19 100755
> > > --- a/policycoreutils/scripts/fixfiles
> > > +++ b/policycoreutils/scripts/fixfiles
> > > @@ -207,6 +207,15 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1=
" | grep '^0 ' | cut -f2- -d ' '
> > >  [ ${PIPESTATUS[0]} !=3D 0 ] && echo "$1 not found" >/dev/stderr
> > >  }
> > >
> > > +# unmount tmp bind mount before exit
> > > +umount_TMP_MOUNT() {
> > > +       if [ -n "$TMP_MOUNT" ]; then
> > > +            umount "${TMP_MOUNT}${m}" || exit 130
> > > +            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> > > +       fi
> > > +       exit 130
> > > +}
> > > +
> > >  #
> > >  # restore
> > >  # if called with -n will only check file context
> > > @@ -251,8 +260,9 @@ case "$RESTORE_MODE" in
> > >             else
> > >                 # we bind mount so we can fix the labels of files tha=
t have already been
> > >                 # mounted over
> > > +               trap umount_TMP_MOUNT EXIT
> > >                 for m in `echo $FILESYSTEMSRW`; do
> > > -                   TMP_MOUNT=3D"$(mktemp -d)"
> > > +                   TMP_MOUNT=3D"$(mktemp -p /run -d fixfiles.XXXXXXX=
XXX)"
> > >                     test -z ${TMP_MOUNT+x} && echo "Unable to find te=
mporary directory!" && exit 1
> > >
> > >                     mkdir -p "${TMP_MOUNT}${m}" || exit 1
> > > @@ -261,6 +271,7 @@ case "$RESTORE_MODE" in
> > >                     umount "${TMP_MOUNT}${m}" || exit 1
> > >                     rm -rf "${TMP_MOUNT}" || echo "Error cleaning up.=
"
> > >                 done;
> > > +               trap EXIT
> > >             fi
> > >         else
> > >             echo >&2 "fixfiles: No suitable file systems found"
> > > --
> > > 2.37.3
> > >
> >
>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
