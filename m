Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B655ECAAD8
	for <selinux@archiver.kernel.org>; Fri, 16 Sep 2022 12:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIPMYq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Sep 2022 08:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiIPMYV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Sep 2022 08:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3756B1BB7
        for <selinux@vger.kernel.org>; Fri, 16 Sep 2022 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663331047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5vnxeMhxEtv0SDnWd7OoFX8D3UskkPitLNHwhYPm/FA=;
        b=gJobAWWA8mmTdUhgK+4FujBJupOCtaVtp28OrQWfT8mcnmZjX1IoFB83jC/6rJDQeou2ax
        O4uGCouococOkqT0HiZnuaUeo1glP/F8qOBs+7C6hXmrFFlloPWmGS+MOUcmMvevq1trPn
        W0/O+foQtKK3UZNGqELcAnvALmgfXVg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-a5rZyPnGMSyJDbmWzmh-Zw-1; Fri, 16 Sep 2022 08:24:05 -0400
X-MC-Unique: a5rZyPnGMSyJDbmWzmh-Zw-1
Received: by mail-pl1-f197.google.com with SMTP id x13-20020a170902ec8d00b00177f0fa642cso14828845plg.10
        for <selinux@vger.kernel.org>; Fri, 16 Sep 2022 05:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5vnxeMhxEtv0SDnWd7OoFX8D3UskkPitLNHwhYPm/FA=;
        b=vswzaiLrVqqOk8nYsrZP0q0yspnuXKkWTZ2FDOWScqJxn0GIoscSSfY6hf/35VzY5O
         U8azZmORbA7quyEolOxFu7Uyk6ssO5xqOUjKotyGKV0mMy+MjQgYFiKi81ZXkvUCCIzI
         6eHdk6LkY09jY5MUnvUH3hqgsAkTJajDSLiB4lMS+kEoGG7v8ftvoJ1uNmG7pCjp/neF
         6ba2eMhVxBNYCFgUZQOHUUTK1ddMk5qeXAPw3CJCxwYN/c3QhhS/uspDHlkn39SCVx6t
         Eu1RFFMukkoa8kaNiW5aCmZhiCWs4eU0/VHtBF9Ifsa9qqUGFODyd4AgzWbB4ne7om1Y
         XQKg==
X-Gm-Message-State: ACrzQf3/MBKz9IwZD15oIBjN5ANfsDspuaIwxq2/un2FlNUdCY//7SVu
        v0Zg6FlCucza9DppNi0gF/FHmX4Z+RnJVMF0ktVVhnwAox/OHgJ7xjnD2a+hjC8W9CXWBmCj3l6
        04/ZnqCkZTorqKVUGeVR0Gp75JZupEIcUkA==
X-Received: by 2002:a17:903:188:b0:178:3d49:45a0 with SMTP id z8-20020a170903018800b001783d4945a0mr4408787plg.154.1663331044602;
        Fri, 16 Sep 2022 05:24:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7t36HIsUkztIiL/X8oRIbcxN0zudOz4wWOUhZWljfKiTQUPe36qhmy2uFlCoiyHcqRT8vBFe9ULOJMEPWFDzQ=
X-Received: by 2002:a17:903:188:b0:178:3d49:45a0 with SMTP id
 z8-20020a170903018800b001783d4945a0mr4408763plg.154.1663331044269; Fri, 16
 Sep 2022 05:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220915124418.27156-1-plautrba@redhat.com> <CAFqZXNvmjHBQ4gTkm3252NE2KcBL4=5da5+dK2pHD0mAxqbAkw@mail.gmail.com>
 <87leqkd2jd.fsf@redhat.com>
In-Reply-To: <87leqkd2jd.fsf@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 16 Sep 2022 14:23:51 +0200
Message-ID: <CAFqZXNumqe5gaUgQFn2-afy=BNrcu+PU2v+-6FroYAhcJBe6=A@mail.gmail.com>
Subject: Re: [PATCH] fixfiles: Unmount temporary bind mounts on SIGINT
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 15, 2022 at 6:29 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> Ondrej Mosnacek <omosnace@redhat.com> writes:
>
> > On Thu, Sep 15, 2022 at 2:45 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >> `fixfiles -M relabel` temporary bind mounts filestems before relabeling
> >> but it leaves a directory mounted in /tmp/tmp.XXXX when a user hits
> >> CTRL-C. It means that if the user run `fixfiles -M relabel` again and
> >> answered Y to clean out /tmp directory, it would remove all data from
> >> mounted fs.
> >>
> >> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2125355
> >>
> >> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> >> ---
> >>  policycoreutils/scripts/fixfiles | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> >> index c72ca0eb9d61..6811921970f2 100755
> >> --- a/policycoreutils/scripts/fixfiles
> >> +++ b/policycoreutils/scripts/fixfiles
> >> @@ -207,6 +207,15 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
> >>  [ ${PIPESTATUS[0]} != 0 ] && echo "$1 not found" >/dev/stderr
> >>  }
> >>
> >> +# unmount tmp bind mount before exit
> >> +umount_TMP_MOUNT() {
> >> +       if [ -n "$TMP_MOUNT" ]; then
> >> +            umount "${TMP_MOUNT}${m}" || exit 130
> >> +            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> >> +       fi
> >> +       exit 130
> >> +}
> >> +
> >>  #
> >>  # restore
> >>  # if called with -n will only check file context
> >> @@ -251,6 +260,7 @@ case "$RESTORE_MODE" in
> >>             else
> >>                 # we bind mount so we can fix the labels of files that have already been
> >>                 # mounted over
> >> +               trap umount_TMP_MOUNT SIGINT
> >>                 for m in `echo $FILESYSTEMSRW`; do
> >>                     TMP_MOUNT="$(mktemp -d)"
> >>                     test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
> >> @@ -261,6 +271,7 @@ case "$RESTORE_MODE" in
> >>                     umount "${TMP_MOUNT}${m}" || exit 1
> >>                     rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> >>                 done;
> >> +               trap SIGINT
> >>             fi
> >>         else
> >>             echo >&2 "fixfiles: No suitable file systems found"
> >> --
> >> 2.37.3
> >>
> >
> > And what if the fixfiles process is terminated via SIGTERM or even
> > SIGKILL?
>
> Good point.
>
> > Or a power failure occurs at the wrong time?
>
> After power failure and reboot there's no bind mountpoints from fixfiles
> left.

Indeed, sorry for the brainfart.

> > What if some
> > other process leaves behind a bind mount / other mount in /tmp?
>
> I don't know. But it's up to users to decide. If they are not sure, they
> should answer 'No' to /tmp clean up.

I disagree. We shouldn't offer the user an easy way of shooting
themselves in the foot for no good reason.

>
>
> > My suggestion would be to:
> > 1) Change the trap from SIGINT to EXIT. That will cover both SIGTERM and SIGINT.
>
> I'll send updated patch with this.
>
> > 2) Additionally modify fullrelabel() to not traverse across mounts
> > when doing the removing (+ possibly exit with an error whenever a
> > mountpoint is encountered - OR - try to unmount the mounts instead of
> > removing their contents).
>
> Given that I don't know what was the original motivation for the cleaing
> code and users are asked whether they want to clean up /tmp and they are
> warned that they would need to reboot after this operation, I'm not sure
> how I would defend the change.

The reboot will not fix the deletion of all files caused by a leftover
mount. If you don't want to harden the removal, then at least please
add a big warning to the prompt that the operation will also attempt
to delete files inside mounts mounted under /tmp. (But that's pretty
silly, when you could instead just add -xdev and avoid the problem
altogether...)

I would say the motivation is simply to force the re-creation of all
temporary files in /tmp so that any changes in type transition rules
are applied. It is illogical to remove also contents of mounts, as
these will likely use different labeling rules (depending on the
superblock or in case of a bind mount the original path). There is
just no way that deleting across mounts would be anything but a
horrible idea in this case.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

