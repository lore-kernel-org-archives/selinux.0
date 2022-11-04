Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB462C4332F
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 11:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKDLVF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 07:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKDLVD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 07:21:03 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5EE1EADF
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 04:21:02 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id k67so4299151vsk.2
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt+1FlVe5ET4pUkBdzWnqAB4hGZsZ5Zil/KmWf1mQgA=;
        b=kbj9SCh5lGCilKPQKA2PH7z74zHlJVOWZrdBHyQtQav3kRhXDEDUZqbMLE4MRCFxuN
         qQnxeF4axyPYm+9V7C1+d4jeBDqJeG0KVEOKVO6QHlosJv8Y0mUlICnIMctSHuk3bCVk
         f/hYAustjSOarfhjHK+pKFdC25RZ2VP3Le1vsjtoialAGEe3CC4yLM765TpZCwL1QRXM
         dtDjoJNS2ikcWy5Ooc+s8lJxny5Dx5TKcMj1MTgH1gcn6NljZ1g+qES0RoREEODktx4L
         kM/a4eNaQc7K1H0OeUesNFEyWPZqtV06OjmAeV58Y6+RELn5Gj58KPWVb2wvQSt6uunG
         ZKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zt+1FlVe5ET4pUkBdzWnqAB4hGZsZ5Zil/KmWf1mQgA=;
        b=IYWjd9MWLa2RvVHkCvr+Rm/8yiql3bSETCaFR9EEvS4rXEf0regIhhH0fJdDEPBpAf
         qHjWbB4TK2ix8EEZsWrcHzl4Iw6FVKBQ9MKwePYW1I5R7Ot1G8/TpIyVOxRahLVAGjO9
         w/1pDIzWBMiRmrWOGkqR+OU7BfTBdpsrU74zxvfn7Go+Uas0HeGLt31LHIYKDOa4ZqYo
         wBX79XwI5kRC5j+I3x+DknKWrkgKanamHRUKw5Id7zkxIEgFb6KT00Be/rTQun9pMNNo
         sYovwfmYHPF7OWMP2l9y+nU77oqHDgPn3E+zszlUK52wfuRz7+JOrNvIYDkV+MSPZP/N
         SbpQ==
X-Gm-Message-State: ACrzQf2fjLsEpP5AsUUm2zq5PiTWTEjudJEv5ReXAl/wBjft6Kg1h7M9
        zxPUO9q9nGVYNdXnqQcJReMjm7ZzjLtJ1UDVuRbk1iHf+AU=
X-Google-Smtp-Source: AMsMyM4AQjEPvxHkbLg4Ukpce2xxs8yjcxoXjzFKKOBDQHIb36PUfSyc+BLTokdAkJqxdhcY+Zfv6OplZ5DIWqY9AUE=
X-Received: by 2002:a05:6102:356f:b0:3aa:52b2:d90a with SMTP id
 bh15-20020a056102356f00b003aa52b2d90amr20156378vsb.20.1667560861599; Fri, 04
 Nov 2022 04:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ2a_DeBWkHziE4+DsRqqLULtGkdX68c8jdU3Hxs++84NoPpsQ@mail.gmail.com>
 <20221007134600.137812-1-plautrba@redhat.com> <874jvfdmtf.fsf@redhat.com>
In-Reply-To: <874jvfdmtf.fsf@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 4 Nov 2022 12:20:50 +0100
Message-ID: <CAJ2a_Dfzxn1jHcjJBbktO69fYeLytTDdBSec-oy9fv9rKJ7bbA@mail.gmail.com>
Subject: Re: [PATCH v4] fixfiles: Unmount temporary bind mounts on SIGINT
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 4 Nov 2022 at 11:42, Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Petr Lautrbach <plautrba@redhat.com> writes:
>
> > `fixfiles -M relabel` temporary bind mounts filestems before relabeling
> > but it leaves a directory mounted in /tmp/tmp.XXXX when a user hits
> > CTRL-C. It means that if the user run `fixfiles -M relabel` again and
> > answered Y to clean out /tmp directory, it would remove all data from
> > mounted fs.
> >
> > This patch changes the location where `fixfiles` mounts fs to /run, use=
s
> > private mount namespace via unshare and adds a handler for exit signals
> > which tries to umount fs mounted by `fixfiles`.
> >
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2125355
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
>
> Is there anyone who objects?
>
> Petr
>
>
> > ---
> > v2:
> >
> > - set trap on EXIT instead of SIGINT
> >
> > v3:
> >
> > - use /run instead of /tmp for mountpoints
> >
> > v4:
> >
> > - use mount namespace as suggested by Christian G=C3=B6ttsche <cgzones@=
googlemail.com> (September 16) (inbox)
> >
> >
> >  policycoreutils/scripts/fixfiles | 36 +++++++++++++++++++++++++-------
> >  1 file changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts=
/fixfiles
> > index c72ca0eb9d61..af64a5a567a6 100755
> > --- a/policycoreutils/scripts/fixfiles
> > +++ b/policycoreutils/scripts/fixfiles
> > @@ -207,6 +207,25 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" =
| grep '^0 ' | cut -f2- -d ' '
> >  [ ${PIPESTATUS[0]} !=3D 0 ] && echo "$1 not found" >/dev/stderr
> >  }
> >
> > +# unmount tmp bind mount before exit
> > +umount_TMP_MOUNT() {
> > +     if [ -n "$TMP_MOUNT" ]; then
> > +          umount "${TMP_MOUNT}${m}" || exit 130
> > +          rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> > +     fi
> > +     exit 130
> > +}
> > +
> > +fix_labels_on_mountpoint() {
> > +     test -z ${TMP_MOUNT+x} && echo "Unable to find temporary director=
y!" && exit 1
> > +     mkdir -p "${TMP_MOUNT}${m}" || exit 1
> > +     mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> > +     ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* =
-q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> > +     umount "${TMP_MOUNT}${m}" || exit 1
> > +     rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> > +}
> > +export -f fix_labels_on_mountpoint
> > +
> >  #
> >  # restore
> >  # if called with -n will only check file context
> > @@ -252,14 +271,15 @@ case "$RESTORE_MODE" in
> >               # we bind mount so we can fix the labels of files that ha=
ve already been
> >               # mounted over
> >               for m in `echo $FILESYSTEMSRW`; do
> > -                 TMP_MOUNT=3D"$(mktemp -d)"
> > -                 test -z ${TMP_MOUNT+x} && echo "Unable to find tempor=
ary directory!" && exit 1
> > -
> > -                 mkdir -p "${TMP_MOUNT}${m}" || exit 1
> > -                 mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> > -                 ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${=
THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> > -                 umount "${TMP_MOUNT}${m}" || exit 1
> > -                 rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> > +                     TMP_MOUNT=3D"$(mktemp -p /run -d fixfiles.XXXXXXX=
XXX)"

Whitespace issue:

git apply ~/Downloads/v4-fixfiles-Unmount-temporary-bind-mounts-on-SIGINT.p=
atch
/home/christian/Downloads/v4-fixfiles-Unmount-temporary-bind-mounts-on-SIGI=
NT.patch:137:
space before tab in indent.
                        TMP_MOUNT=3D"$(mktemp -p /run -d fixfiles.XXXXXXXXX=
X)"
warning: 1 line adds whitespace errors.

> > +                 export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG THREADS=
 FC TMP_MOUNT m
> > +                 if type unshare &> /dev/null; then
> > +                     unshare -m bash -x -c "fix_labels_on_mountpoint" =
$* || exit $?

Two issues:

I.
The `-x` flag make the output unreadable (especially for check/verify).

II.
The option (e.g. `-n` for check/verify) is not passed, should be `-c
"fix_labels_on_mountpoint $*"`.

> > +                 else
> > +                     trap umount_TMP_MOUNT EXIT
> > +                     fix_labels_on_mountpoint $*
> > +                     trap EXIT
> > +                 fi
> >               done;
> >           fi
> >       else
> > --
> > 2.37.3
>
