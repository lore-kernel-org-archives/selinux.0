Return-Path: <SRS0=GZQR=AR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441BCC433DF
	for <selinux@archiver.kernel.org>; Mon,  6 Jul 2020 18:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2429420663
	for <selinux@archiver.kernel.org>; Mon,  6 Jul 2020 18:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbIZbjmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgGFS0C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbgGFS0C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jul 2020 14:26:02 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85818C061755
        for <selinux@vger.kernel.org>; Mon,  6 Jul 2020 11:26:02 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t198so20229386oie.7
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2020 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ga5dM7iw7lSmdOs7zJ3S7bFU3vdOvd22xf2NrC6CCE=;
        b=FbIZbjmI1xxDKRVRh88G9Ot6+6fI7UiB4t8ilRhtxy6bet7KwkoPhVnQzFBjPnwJ7i
         iTqjT7H+mJyT9Rj3/9KZyimG3a0HtcE7efYPpjtepC60OrXkT+NhcbtZB0YRsJ3MGGOw
         s1V+d0P6iHFJuN/abk6SarzqQ00E3s2+ArV4Yzpc0+xqN4bPu0pOXcmSILzWExHYWl5N
         97zGkU8U0r/AQ+oUS3IiG+VrBxR89B22Fi3D/4hp+P/WqEhRTQ+M0SPtsDVXAy0zGJpI
         UfddlDShI0SdXpcnuodi7OPdqxo5iqHJt4zBTCGWfkHqEcY4NzFOGo74aExD+M2yb3ls
         MHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ga5dM7iw7lSmdOs7zJ3S7bFU3vdOvd22xf2NrC6CCE=;
        b=Wz7sZecxAmAlxPnVyMXft+uzk6CYr/n4Pb1JAdlC40aB2m+rzkyRnYxkFFRosrgGrT
         Z920e2aHn8iTyutUe4lhwqBQ4UeGuNVeqKyjgPpetR5QzoLMEDc1y+/R1xXdss8NsGbI
         VjKaFCS0ww2WYRCGOXrTU0Pvjmz+wohVQ6eMgAaJ98oc6giH8VQ7bSqQQvUT5VAgMflE
         7SIt/71wV/QcDoAbAMrIexzwjtPy4I5ExP2iEqQ8dj/ixuz8Kt0+i+JOyQnsScC4CY87
         eQpbvMpNfyED1Q0I/y87xrIBUfnYZVB4B4TXAGeJzx9lsSv5j15bE3VQewF3l31Y1xbZ
         XHTQ==
X-Gm-Message-State: AOAM532P8ZEMwV+L6ElzTmwzy3BBSUQjiEJXsR0J1TqtzZLVih1A5BwT
        c3VOeloe4nYbGWL2tBC6TMg2sMtCtXZFO2XxQrg=
X-Google-Smtp-Source: ABdhPJwjrWkSaSoqeYBo+2EJaQgopruLowtPLp0mS9PnbC4/VockB+8kelQKB+LhBbMXk2ksk1RbkPfdpcv5BlBV9lM=
X-Received: by 2002:aca:c4cc:: with SMTP id u195mr443046oif.160.1594059961810;
 Mon, 06 Jul 2020 11:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <330f12f0-44d6-3659-0153-32b3cddf2db6@gmail.com>
In-Reply-To: <330f12f0-44d6-3659-0153-32b3cddf2db6@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 6 Jul 2020 14:25:51 -0400
Message-ID: <CAEjxPJ67MVocx8MO51VcpHRmwZzxANa8Q+-iZFgxPrdwXk5i3g@mail.gmail.com>
Subject: Re: [RFC PATCH] fixfiles: correctly restore context of mountpoints
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 30, 2020 at 11:01 AM bauen1 <j2468h@googlemail.com> wrote:
>
> By bind mounting every filesystem we want to relabel we can access all
> files without anything hidden due to active mounts.
>
> This comes at the cost of user experience, because setfiles only
> displays the percentage if no path is given or the path is /

Perhaps this should be opt-in via a new command-line option rather
than the default, given the user-visible difference in behavior and
the potential for something to go wrong for existing users.  We might
also want to look at improving setfiles / selinux_restorecon() to
support percentage progress without this limitation.

>
> Signed-off-by: bauen1 <j2468h@gmail.com>

Generally I think a real name is required for Signed-off-by lines in
the DCO since otherwise it isn't truly meaningful from a legal
perspective.

> ---
>  policycoreutils/scripts/fixfiles | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index 5d777034..dc5be195 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -243,7 +243,19 @@ case "$RESTORE_MODE" in
>         if [ -n "${FILESYSTEMSRW}" ]; then
>             LogReadOnly
>             echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
> -           ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -q ${FC} ${FILESYSTEMSRW}
> +
> +           # we bind mount so we can fix the labels of files that have already been
> +           # mounted over
> +           for m in `echo $FILESYSTEMSRW`; do
> +               TMP_MOUNT="$(mktemp -d)"
> +               test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
> +
> +               mkdir -p "${TMP_MOUNT}${m}" || exit 1
> +               mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> +               ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> +               umount "${TMP_MOUNT}${m}" || exit 1
> +               rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> +           done;
>         else
>             echo >&2 "fixfiles: No suitable file systems found"
>         fi
> --
> 2.27.0
>
