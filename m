Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B0EC54EE9
	for <selinux@archiver.kernel.org>; Mon, 19 Sep 2022 08:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiISIja (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Sep 2022 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiISIj3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Sep 2022 04:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0021ADA9
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 01:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663576765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/zb3dqY3goa5y6NWRIp/zqIZ1iFcLEDBbqLCnpiaxM=;
        b=ZJsgQLK29DDDPTedixSY/2rFpPAWjD6IbEBo9m2Svkxbk88Ea0ZCKj+ZNAkY2DqpsF6xFy
        UdKs0yCSkbjxzWvm7hTjk1WOuH95wl8++APJJz0mbGBmqkxKZP2LmPGjnvckHtQ5wTqv/I
        xAzeFaeGU1r3SlD+9wUbXTbFqf4/xbY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-qmWeuEndPHuNYd1IcPKHVA-1; Mon, 19 Sep 2022 04:39:23 -0400
X-MC-Unique: qmWeuEndPHuNYd1IcPKHVA-1
Received: by mail-pg1-f200.google.com with SMTP id h13-20020a63530d000000b0043087bbf72dso13726629pgb.17
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 01:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7/zb3dqY3goa5y6NWRIp/zqIZ1iFcLEDBbqLCnpiaxM=;
        b=xFuwKXKIWIREtu7RCNU7xtORcg7ADPOMfHcXCUSnkfj4R2k9K86HVZECVi3xuHVmyA
         bSnLFkO0wEJeEEuUx/t6SeQw/4UF1t4K5iCFdfcC4KdZWbeG4y8FhGzVmyUlmYP9Nhr9
         9SlpP20gJjzFMwwC/F0rW+iKN0Y4DPbz7g3QsKv/2kyedKrXvOkeECsZQPYb/c5tWZxL
         p8srTiKOUrcwGuH6+cx2HT/epyJBH8ry7qPBvlq8d/mFk2PDBy+QzYSROIUfnT5oGITJ
         NMWY1tlOP1H6ByUZqFYO5uK/glQb2il4Blwn4z1/EabXHnziampT3JMZXc6bAGaFRRmU
         QpoA==
X-Gm-Message-State: ACrzQf3FUdfMECKmLJbteRGJTMLJ/4J9aldkbMjajuKlnp4kPbhDNjDU
        mmm1UoiFMoe+gRib+0aYEPCY3a8B6WGOAWe5M9Yxu8RE6qS4T4x0shf+VkrgoojcKAgQa5QPmLs
        Of5CuQRoHv/CBEo4QTDRXRh4Ni0GTV3y0fw==
X-Received: by 2002:a17:903:188:b0:178:3d49:45a0 with SMTP id z8-20020a170903018800b001783d4945a0mr11997415plg.154.1663576762779;
        Mon, 19 Sep 2022 01:39:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5IgbhgGwvJvJWn0FzTaALbnoL8AAKIsCmW1huGZhAOfZTQb682+OYmwKlZ5LCbDJ4Hol0XCSsL6JrDQmJ+MqM=
X-Received: by 2002:a17:903:188:b0:178:3d49:45a0 with SMTP id
 z8-20020a170903018800b001783d4945a0mr11997404plg.154.1663576762510; Mon, 19
 Sep 2022 01:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220915163751.41804-1-plautrba@redhat.com> <20220916141308.72606-1-plautrba@redhat.com>
 <CAJ2a_DeBWkHziE4+DsRqqLULtGkdX68c8jdU3Hxs++84NoPpsQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DeBWkHziE4+DsRqqLULtGkdX68c8jdU3Hxs++84NoPpsQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 19 Sep 2022 10:39:11 +0200
Message-ID: <CAFqZXNvr6_kjfMxuCUqn_yAonEk0tRwFV7KVpYn+b1Ft=n_sMQ@mail.gmail.com>
Subject: Re: [PATCH v3] fixfiles: Unmount temporary bind mounts on SIGINT
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

(Resending without HTML...)

On Fri, Sep 16, 2022 at 5:37 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Fri, 16 Sept 2022 at 16:14, Petr Lautrbach <plautrba@redhat.com> wrote=
:
> >
> > `fixfiles -M relabel` temporary bind mounts filestems before relabeling
> > but it leaves a directory mounted in /tmp/tmp.XXXX when a user hits
> > CTRL-C. It means that if the user run `fixfiles -M relabel` again and
> > answered Y to clean out /tmp directory, it would remove all data from
> > mounted fs.
> >
> > This patch changes the location where `fixfiles` mounts fs to /run and
> > adds a handler for exit signals which tries to umount fs mounted by
> > `fixfiles`.
>
> What about additionally using mount namespaces, if available:

What benefit would it bring? (Sorry, I'm not very familiar with mount
namespaces.)

>
> @@ -256,10 +256,16 @@
>                    test -z ${TMP_MOUNT+x} && echo "Unable to find
> temporary directory!" && exit 1
>
>                    mkdir -p "${TMP_MOUNT}${m}" || exit 1
> -                   mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> -                   ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG}
> ${THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> -                   umount "${TMP_MOUNT}${m}" || exit 1
> -                   rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> +                   if ! unshare --mount /bin/sh -c "mount --bind
> \"${m}\" \"${TMP_MOUNT}${m}\" || exit 1 && ${SETFILES} ${VERBOSE}
> ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -q ${FC} -r \"${TMP_MOUNT}\"
> \"${TMP_MOUNT}${m}\" || true"; then
> +                        echo "Creating new mount namespace failed,
> operating in root namespace"
> +                       mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> +                       ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS}
> ${FORCEFLAG} ${THREADS} $* -q ${FC} -r "${TMP_MOUNT}"
> "${TMP_MOUNT}${m}"
> +                       umount "${TMP_MOUNT}${m}" || exit 1
> +                    fi
> +                    if [ "${m}" !=3D '/' ]; then
> +                        rmdir "${TMP_MOUNT}${m}" || echo "Error
> cleaning up ${TMP_MOUNT}${m}."
> +                    fi
> +                   rmdir "${TMP_MOUNT}"     || echo "Error cleaning
> up ${TMP_MOUNT}."
>                done;
>            fi
>        else
>
> ?
>
> >
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2125355
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > ---
> > v2:
> >
> > - set trap on EXIT instead of SIGINT
> >
> > v3:
> >
> > - use /run instead of /tmp for mountpoints
> >
> >
> >  policycoreutils/scripts/fixfiles | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts=
/fixfiles
> > index c72ca0eb9d61..acf5f0996c19 100755
> > --- a/policycoreutils/scripts/fixfiles
> > +++ b/policycoreutils/scripts/fixfiles
> > @@ -207,6 +207,15 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" =
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
> >  #
> >  # restore
> >  # if called with -n will only check file context
> > @@ -251,8 +260,9 @@ case "$RESTORE_MODE" in
> >             else
> >                 # we bind mount so we can fix the labels of files that =
have already been
> >                 # mounted over
> > +               trap umount_TMP_MOUNT EXIT
> >                 for m in `echo $FILESYSTEMSRW`; do
> > -                   TMP_MOUNT=3D"$(mktemp -d)"
> > +                   TMP_MOUNT=3D"$(mktemp -p /run -d fixfiles.XXXXXXXXX=
X)"
> >                     test -z ${TMP_MOUNT+x} && echo "Unable to find temp=
orary directory!" && exit 1
> >
> >                     mkdir -p "${TMP_MOUNT}${m}" || exit 1
> > @@ -261,6 +271,7 @@ case "$RESTORE_MODE" in
> >                     umount "${TMP_MOUNT}${m}" || exit 1
> >                     rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> >                 done;
> > +               trap EXIT
> >             fi
> >         else
> >             echo >&2 "fixfiles: No suitable file systems found"
> > --
> > 2.37.3
> >
>

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

