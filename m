Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF14C4332F
	for <selinux@archiver.kernel.org>; Wed, 23 Nov 2022 15:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbiKWPF2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Nov 2022 10:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiKWPFX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Nov 2022 10:05:23 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D08560E9F
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 07:05:20 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id i10so43363760ejg.6
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1Zli2s7HQ//ZZTx2QO/Nbv0tEOBx80aKbi11XYZtik=;
        b=h7evGgiTTVimp8LVLldi3onsJxNVR0K1lKlWYCcy1g2RDbb6l+f8HSnOrT/ENQh1b3
         JNazqhlxXBbSvmve9VfwASquOmVe/pVvoc/pIvitJ6v7bx27IX0m8iv5Tl+dh4IMey67
         oM89Bi02pmkmjd8A76x72LNBKbwp8cnUbuQbzXFTTSQQqVyX4QHpNTqTeyhlyw6rYoZt
         CCadzuHVewatmM5nwOwDNySd9jS8g9BdqXFZVFfzsENMZPhlCK0o5GnXEn9A4sd3NMNP
         1uNqT5f995PbNj18RGWmJjeoiIHIdPuP+I6IA90dCcgqiiuihzM/t1KX6vQpsAoA2/aV
         MOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1Zli2s7HQ//ZZTx2QO/Nbv0tEOBx80aKbi11XYZtik=;
        b=pzRvddP0q2OtEP++eTZGz6ow3buxNn7ZdNcHHtJMDtzPwoRjEo/RTTpenTRHnyyR/4
         5edi+6e5TJb4iR6Z3dwzpwk5MOel3jvfs9V4d+tADGVRnhd5SNYbPXGg4FN88pI0x6nl
         wkYCTaqa2+crNST04wyuzbhOMoP3PlEV63qDgrgEj7rt52CJRd14PYkj0WqHU14EYLMG
         ZtqeKMssAndOxJsEKwQT5tcNtFCwx5Xmumuf6bYcPpDtZQytpzHSrPVAkMQDbzsEeYcl
         myxpVyCA0HzjCTXDy1erhpfItyLItdJStqpRzUEbe5bj2FS3cDt49ZY9n84ca04J4LTa
         H+QQ==
X-Gm-Message-State: ANoB5pmNBWFHfc5ZDxO5tP7Xm3ZCco/EOWUaedx1kFNnHHOLFEUukghQ
        ZENNFTnJVHB0sblLxxGoge87NDYhHuSaW/JB8OMIn/3x
X-Google-Smtp-Source: AA0mqf4Hl/7YYCSMvFA97Qe3glNUuObzNcnb+TI1msklr3ebYVN5NIAJjgD2xBXI6FTwcQlhRSNG/PAUmnb8r3TFGw4=
X-Received: by 2002:a17:906:1e8a:b0:7b2:b992:694d with SMTP id
 e10-20020a1709061e8a00b007b2b992694dmr19649753ejj.651.1669215918766; Wed, 23
 Nov 2022 07:05:18 -0800 (PST)
MIME-Version: 1.0
References: <20221107092504.1088612-1-plautrba@redhat.com> <CAP+JOzQJ0aV=K-YS1tm56A2hRcc4jkA5NtZgBpyhE7GN-Zqagw@mail.gmail.com>
In-Reply-To: <CAP+JOzQJ0aV=K-YS1tm56A2hRcc4jkA5NtZgBpyhE7GN-Zqagw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 23 Nov 2022 10:05:07 -0500
Message-ID: <CAP+JOzR7_55B9NYOH66T-8Zr6aH+3PmJRyE0Z-xvxvYDCwZEaw@mail.gmail.com>
Subject: Re: [PATCH v2] fixfiles: Unmount temporary bind mounts on SIGINT
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 21, 2022 at 8:50 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Nov 7, 2022 at 4:31 AM Petr Lautrbach <plautrba@redhat.com> wrote=
:
> >
> > `fixfiles -M relabel` temporary bind mounts file systems before
> > relabeling, but it left the / directory mounted in /tmp/tmp.XXXX when a
> > user hit CTRL-C. It means that if the user run `fixfiles -M relabel`
> > again and answered Y to clean out /tmp directory, it would remove all
> > data from mounted fs.
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
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >
> > v2: fixed issues reported by Christian G=C3=B6ttsche <cgzones@googlemai=
l.com>
> >
> >
> >  policycoreutils/scripts/fixfiles | 36 +++++++++++++++++++++++++-------
> >  1 file changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts=
/fixfiles
> > index c72ca0eb9d61..166af6f360a2 100755
> > --- a/policycoreutils/scripts/fixfiles
> > +++ b/policycoreutils/scripts/fixfiles
> > @@ -207,6 +207,25 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" =
| grep '^0 ' | cut -f2- -d ' '
> >  [ ${PIPESTATUS[0]} !=3D 0 ] && echo "$1 not found" >/dev/stderr
> >  }
> >
> > +# unmount tmp bind mount before exit
> > +umount_TMP_MOUNT() {
> > +       if [ -n "$TMP_MOUNT" ]; then
> > +            umount "${TMP_MOUNT}${m}" || exit 130
> > +            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> > +       fi
> > +       exit 130
> > +}
> > +
> > +fix_labels_on_mountpoint() {
> > +       test -z ${TMP_MOUNT+x} && echo "Unable to find temporary direct=
ory!" && exit 1
> > +       mkdir -p "${TMP_MOUNT}${m}" || exit 1
> > +       mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> > +       ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $=
* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> > +       umount "${TMP_MOUNT}${m}" || exit 1
> > +       rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> > +}
> > +export -f fix_labels_on_mountpoint
> > +
> >  #
> >  # restore
> >  # if called with -n will only check file context
> > @@ -252,14 +271,15 @@ case "$RESTORE_MODE" in
> >                 # we bind mount so we can fix the labels of files that =
have already been
> >                 # mounted over
> >                 for m in `echo $FILESYSTEMSRW`; do
> > -                   TMP_MOUNT=3D"$(mktemp -d)"
> > -                   test -z ${TMP_MOUNT+x} && echo "Unable to find temp=
orary directory!" && exit 1
> > -
> > -                   mkdir -p "${TMP_MOUNT}${m}" || exit 1
> > -                   mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> > -                   ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} =
${THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> > -                   umount "${TMP_MOUNT}${m}" || exit 1
> > -                   rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> > +                   TMP_MOUNT=3D"$(mktemp -p /run -d fixfiles.XXXXXXXXX=
X)"
> > +                   export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG THREA=
DS FC TMP_MOUNT m
> > +                   if type unshare &> /dev/null; then
> > +                       unshare -m bash -c "fix_labels_on_mountpoint $*=
" || exit $?
> > +                   else
> > +                       trap umount_TMP_MOUNT EXIT
> > +                       fix_labels_on_mountpoint $*
> > +                       trap EXIT
> > +                   fi
> >                 done;
> >             fi
> >         else
> > --
> > 2.37.3
> >
