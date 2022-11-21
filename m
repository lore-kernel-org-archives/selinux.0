Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2635C433FE
	for <selinux@archiver.kernel.org>; Mon, 21 Nov 2022 13:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiKUNvW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiKUNvQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Nov 2022 08:51:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408D6B961A
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 05:51:07 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b8so5525482edf.11
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 05:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2uF8gUU5jQmN84DBBPIJC3sFD+smfj8nHc6RYbgB2w=;
        b=gxQMCe0ZfIF8NpRDatJlxDiK2+U4/0KOXmvS1ImVOUn0cKYtwj5uwRCfc5FKM8YxAS
         i3a9UoaAV+nLmxNqzJVsAG79CdltHygJcrMomV9tdGBG4e+IMcNgBrIite1n5GVKGowA
         Ui3+48PMkaCJgvNYcqGAs0C/bhmZzhXl/h077GIzWhG0NsodoLg/VMIjJ9BB58xU5L7F
         /L0RAIYZ4w+aWSPqbottiv140tzGW595iTwwdfq1WalXzsEdTkWa1XvtBrrR8g2eisNz
         1TZen/pucTnWX5nPHtSzujlOM6YhUCTroRWpM4Z73Hrd/gGAEPGB2uHYlOJi2aIqKa28
         a1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2uF8gUU5jQmN84DBBPIJC3sFD+smfj8nHc6RYbgB2w=;
        b=U9qzEJHnvaX6O+sxnJhQEYXupYA7+RdaE2t8mtX59OhX6sN4PPme+HE3gzOoNuBupV
         4DtuXtYbpnsC/Ow5ibKlfNmhbqIjXWIXGLpX6pJ7A/VmUYBxxlNmuefXqE6l3I98CUQG
         V5a7k05VJkmY6ani8wa/BauYQJ5OxGXSumxjNoA8vaom0Sg0KlUl6SD6VWvn3kNKofKU
         Mb+frIwo5ZHFV6RsinoZ7nvGCsvykXcukjm5Xum7rKJ+qGfjkph1olHzenlo2ZGfdxVl
         Z/n4hsqDeBSLapj1ImHI5Jj5XISVuT2jSNrNabsp6MeJkto3n/+j8jA39y7j5/2CWK94
         aPgA==
X-Gm-Message-State: ANoB5plzqPZ1wNFENRF0qRN+5UpNSdX1x/rWkNtzIxIzSZu07Oskd7eW
        Gju0N86ZNDvMH/Obp/eva01OxZx46VlV/pEDQe4=
X-Google-Smtp-Source: AA0mqf7g3nO2c/rRNRuGwcDe7LFGm8SkrtusSMmUI8OSyy+rUN2/uvETaTihlvLucGgLOL5EeFa2lsOoF4W2VFTBt+I=
X-Received: by 2002:a05:6402:1f88:b0:461:7a9d:c2ee with SMTP id
 c8-20020a0564021f8800b004617a9dc2eemr4461913edc.36.1669038666108; Mon, 21 Nov
 2022 05:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20221107092504.1088612-1-plautrba@redhat.com>
In-Reply-To: <20221107092504.1088612-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Nov 2022 08:50:54 -0500
Message-ID: <CAP+JOzQJ0aV=K-YS1tm56A2hRcc4jkA5NtZgBpyhE7GN-Zqagw@mail.gmail.com>
Subject: Re: [PATCH v2] fixfiles: Unmount temporary bind mounts on SIGINT
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 7, 2022 at 4:31 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> `fixfiles -M relabel` temporary bind mounts file systems before
> relabeling, but it left the / directory mounted in /tmp/tmp.XXXX when a
> user hit CTRL-C. It means that if the user run `fixfiles -M relabel`
> again and answered Y to clean out /tmp directory, it would remove all
> data from mounted fs.
>
> This patch changes the location where `fixfiles` mounts fs to /run, uses
> private mount namespace via unshare and adds a handler for exit signals
> which tries to umount fs mounted by `fixfiles`.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2125355
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>
> v2: fixed issues reported by Christian G=C3=B6ttsche <cgzones@googlemail.=
com>
>
>
>  policycoreutils/scripts/fixfiles | 36 +++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/f=
ixfiles
> index c72ca0eb9d61..166af6f360a2 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -207,6 +207,25 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | =
grep '^0 ' | cut -f2- -d ' '
>  [ ${PIPESTATUS[0]} !=3D 0 ] && echo "$1 not found" >/dev/stderr
>  }
>
> +# unmount tmp bind mount before exit
> +umount_TMP_MOUNT() {
> +       if [ -n "$TMP_MOUNT" ]; then
> +            umount "${TMP_MOUNT}${m}" || exit 130
> +            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> +       fi
> +       exit 130
> +}
> +
> +fix_labels_on_mountpoint() {
> +       test -z ${TMP_MOUNT+x} && echo "Unable to find temporary director=
y!" && exit 1
> +       mkdir -p "${TMP_MOUNT}${m}" || exit 1
> +       mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> +       ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* =
-q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> +       umount "${TMP_MOUNT}${m}" || exit 1
> +       rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> +}
> +export -f fix_labels_on_mountpoint
> +
>  #
>  # restore
>  # if called with -n will only check file context
> @@ -252,14 +271,15 @@ case "$RESTORE_MODE" in
>                 # we bind mount so we can fix the labels of files that ha=
ve already been
>                 # mounted over
>                 for m in `echo $FILESYSTEMSRW`; do
> -                   TMP_MOUNT=3D"$(mktemp -d)"
> -                   test -z ${TMP_MOUNT+x} && echo "Unable to find tempor=
ary directory!" && exit 1
> -
> -                   mkdir -p "${TMP_MOUNT}${m}" || exit 1
> -                   mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> -                   ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${=
THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> -                   umount "${TMP_MOUNT}${m}" || exit 1
> -                   rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> +                   TMP_MOUNT=3D"$(mktemp -p /run -d fixfiles.XXXXXXXXXX)=
"
> +                   export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG THREADS=
 FC TMP_MOUNT m
> +                   if type unshare &> /dev/null; then
> +                       unshare -m bash -c "fix_labels_on_mountpoint $*" =
|| exit $?
> +                   else
> +                       trap umount_TMP_MOUNT EXIT
> +                       fix_labels_on_mountpoint $*
> +                       trap EXIT
> +                   fi
>                 done;
>             fi
>         else
> --
> 2.37.3
>
