Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412D5C4332F
	for <selinux@archiver.kernel.org>; Fri, 18 Nov 2022 17:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbiKRRBd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Nov 2022 12:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRRBb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Nov 2022 12:01:31 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049E87564
        for <selinux@vger.kernel.org>; Fri, 18 Nov 2022 09:01:30 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id i2so5332732vsc.1
        for <selinux@vger.kernel.org>; Fri, 18 Nov 2022 09:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK2uXyQP6R2U6eI5LG6bQUG3/YcbzP15DsEB+QCqgYQ=;
        b=SCfnPAEMgzXTblJF8z87BXmMOmWEHcExVF25oPgNiibkBd3/etXfLVLdi8pGXH4ZVL
         lgTn9sqtaLd6q2KSkaxd7gbGRVCtzAtc5TP8WFLKUx8gpISUHI2KMl9uBjrmRJFJ8nLY
         xn8RyH1Y0JANWXQqhr6q1XtxQ6kMfiFcxNCD/S6vpYhJ86v0HecCXHXNh/FlVgvyE0vr
         Nw54/VrceYPuaetevQ0k1MHjUta658AXRi2QV8DM67XMBOhTb2/zjKEY/xEIdbB4ue2K
         bWoQDl/QSl/M1PqZ3sh6mNhoeC5fGxm9anXedlDmkCuYabWDzC25QObqDJIcFmxpzYlL
         9qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KK2uXyQP6R2U6eI5LG6bQUG3/YcbzP15DsEB+QCqgYQ=;
        b=63dQjBEZCl6LacCrRWX0zC/gQ6W1JUfPDA6sfFkbZugPNtovbqBNI2vMYv1DA9s7fR
         6sA3qgPONo5/aJqZ2CnDPsj3DRgpTKH914DwLV9RFJjJidcxZ4Y+wZVAYg+HnwcjV0Yy
         a82N8LYl/e+uASd9C0d5quRZojiqO2vDzcv79Oik+0jbJ4HgJVTJPeZUsfRY3ECdw033
         VqCRkgq6OK2X7kw8MvLI0an3ESQUX45ZVqA9AcyYbD4anoSFShTpu7FpsrUL2jez37tP
         EdiMPC3rhr7VRp5mg8ZnQULBUW2+TbMTaNP8MN9f3vzySK6XTNhH8msvjXr8XWv+2iAm
         u0pw==
X-Gm-Message-State: ANoB5pnuPfHOEITT436rAIk9nGCjif35LHtZQPTWLGDJr8k/tgW+Xz3J
        6IK42AG7Nu1F+WwMHwg27Fk5KpUTfGlfTN6tX+ElZI7yoNs=
X-Google-Smtp-Source: AA0mqf4lH9FjMhiWbP77bMAP9C2mOh7pmfkEqZIJA+RElPZNqKXNxFp11rncwFJiO6x1hpmKddj7DWvI1xx//dPtzNc=
X-Received: by 2002:a67:e309:0:b0:3af:600e:84e6 with SMTP id
 j9-20020a67e309000000b003af600e84e6mr4835078vsf.71.1668790889797; Fri, 18 Nov
 2022 09:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20221107092504.1088612-1-plautrba@redhat.com> <87leonc95h.fsf@redhat.com>
 <87edu01sys.fsf@redhat.com>
In-Reply-To: <87edu01sys.fsf@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 18 Nov 2022 18:01:18 +0100
Message-ID: <CAJ2a_DdkFhd_goN_DmJ0_EUZjd3SFMfYa75VXtzA0fnav6E5GA@mail.gmail.com>
Subject: Re: [PATCH v2] fixfiles: Unmount temporary bind mounts on SIGINT
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 18 Nov 2022 at 11:03, Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Petr Lautrbach <plautrba@redhat.com> writes:
>
> > Petr Lautrbach <plautrba@redhat.com> writes:
> >
> >> `fixfiles -M relabel` temporary bind mounts file systems before
> >> relabeling, but it left the / directory mounted in /tmp/tmp.XXXX when =
a
> >> user hit CTRL-C. It means that if the user run `fixfiles -M relabel`
> >> again and answered Y to clean out /tmp directory, it would remove all
> >> data from mounted fs.
> >>
> >> This patch changes the location where `fixfiles` mounts fs to /run, us=
es
> >> private mount namespace via unshare and adds a handler for exit signal=
s
> >> which tries to umount fs mounted by `fixfiles`.
> >>
> >> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2125355
> >>
> >> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> >> ---
> >
> > Actually, it's v5:
> >
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
googlemail.com>
> >
> > v5
> >
> > - fixed issues reported by Christian G=C3=B6ttsche <cgzones@googlemail.=
com>
> >
>
> Any objections?

Works fine for me.
Tested-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

>
>
> >>
> >>
> >>  policycoreutils/scripts/fixfiles | 36 +++++++++++++++++++++++++------=
-
> >>  1 file changed, 28 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/script=
s/fixfiles
> >> index c72ca0eb9d61..166af6f360a2 100755
> >> --- a/policycoreutils/scripts/fixfiles
> >> +++ b/policycoreutils/scripts/fixfiles
> >> @@ -207,6 +207,25 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1"=
 | grep '^0 ' | cut -f2- -d ' '
> >>  [ ${PIPESTATUS[0]} !=3D 0 ] && echo "$1 not found" >/dev/stderr
> >>  }
> >>
> >> +# unmount tmp bind mount before exit
> >> +umount_TMP_MOUNT() {
> >> +    if [ -n "$TMP_MOUNT" ]; then
> >> +         umount "${TMP_MOUNT}${m}" || exit 130
> >> +         rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> >> +    fi
> >> +    exit 130
> >> +}
> >> +
> >> +fix_labels_on_mountpoint() {
> >> +    test -z ${TMP_MOUNT+x} && echo "Unable to find temporary director=
y!" && exit 1
> >> +    mkdir -p "${TMP_MOUNT}${m}" || exit 1
> >> +    mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> >> +    ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* =
-q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> >> +    umount "${TMP_MOUNT}${m}" || exit 1
> >> +    rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> >> +}
> >> +export -f fix_labels_on_mountpoint
> >> +
> >>  #
> >>  # restore
> >>  # if called with -n will only check file context
> >> @@ -252,14 +271,15 @@ case "$RESTORE_MODE" in
> >>              # we bind mount so we can fix the labels of files that ha=
ve already been
> >>              # mounted over
> >>              for m in `echo $FILESYSTEMSRW`; do
> >> -                TMP_MOUNT=3D"$(mktemp -d)"
> >> -                test -z ${TMP_MOUNT+x} && echo "Unable to find tempor=
ary directory!" && exit 1
> >> -
> >> -                mkdir -p "${TMP_MOUNT}${m}" || exit 1
> >> -                mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> >> -                ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${=
THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> >> -                umount "${TMP_MOUNT}${m}" || exit 1
> >> -                rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> >> +                TMP_MOUNT=3D"$(mktemp -p /run -d fixfiles.XXXXXXXXXX)=
"
> >> +                export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG THREADS=
 FC TMP_MOUNT m
> >> +                if type unshare &> /dev/null; then
> >> +                    unshare -m bash -c "fix_labels_on_mountpoint $*" =
|| exit $?
> >> +                else
> >> +                    trap umount_TMP_MOUNT EXIT
> >> +                    fix_labels_on_mountpoint $*
> >> +                    trap EXIT
> >> +                fi
> >>              done;
> >>          fi
> >>      else
> >> --
> >> 2.37.3
>
