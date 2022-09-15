Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44633ECAAA1
	for <selinux@archiver.kernel.org>; Thu, 15 Sep 2022 13:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiIONSm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Sep 2022 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiIONSh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Sep 2022 09:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5B865268
        for <selinux@vger.kernel.org>; Thu, 15 Sep 2022 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663247914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4MUJY3DQwBwdocmkGYzUomjpLr0uK18dtLBwgLtxf4E=;
        b=bRh7bl5zR2nKbNcQr+VIS0sixrzA9uGtYWM81ZD3Tbiq32dtF3PAYVCpppd9SIgcV5GBGt
        fs66EkAL6vEzgTlvEegrm5CAJxpTarAx9sa29Wsk4BGlmi0fwOoB4NAp6dxiM+SmI+4E0l
        K1NCEvypjltXsCk61UsgGHicszmoMj4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-vbuTZZFcNNyjdFMQmmVPrA-1; Thu, 15 Sep 2022 09:18:33 -0400
X-MC-Unique: vbuTZZFcNNyjdFMQmmVPrA-1
Received: by mail-pl1-f197.google.com with SMTP id z7-20020a170903018700b0017835863686so8251328plg.11
        for <selinux@vger.kernel.org>; Thu, 15 Sep 2022 06:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4MUJY3DQwBwdocmkGYzUomjpLr0uK18dtLBwgLtxf4E=;
        b=DpzFfRYhI02CvQF/icn4Aod2HNkT4g/XZoLmH9sndXLljsKtjzDcy69qils/eoiifC
         VeCy+KDdTdyP953tWW35IYSif6Uwjo0Z8dUhiaTGeDVN0IgxW9R9bXMV2oOP3QTAqx8L
         rBPtDGlzNjN8/A/NE+ai5T3r7Q9AXLDCIpIbIQrQ/CJ7PfsOwgPm1tw29MTGL6ZvxrMY
         LV/MuTRUGbmpYUPv8m3ZmQp1e8Ozstd+8HH69r0RJZtCXWjHy1dKMNW80KxKKRb5t6Ry
         wbYYfZeXF7Koxqbi5AEeZ5pzLzRhq3hnXDb1RZd/OTKJ9j+uuPKLnutkHT3IdL2d4Clm
         MFAQ==
X-Gm-Message-State: ACrzQf2QL7xAJEoAsWWFD/DQ5hplQgKkx7PYzcN9jm+83JGOqmRpYRJD
        4COje37j6EIzb7u03105AMuPg96mE3nEiGeKZTFvB4nO9afU2pWWiW/LgMJAf0njmuvaa1sSYic
        nG6yOBCBvkhIDmMCsVISeFnhtZ62j3NaLug==
X-Received: by 2002:a17:903:188:b0:178:3d49:45a0 with SMTP id z8-20020a170903018800b001783d4945a0mr4289075plg.154.1663247912546;
        Thu, 15 Sep 2022 06:18:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5hWjYfWwqm+jxCBXyoT81iEm7LV5jHhA8WnjEKLEwX9EsZH3sk9l0z6V/9SWK7UCVAuRFoGDlqFBiUYcaPoZI=
X-Received: by 2002:a17:903:188:b0:178:3d49:45a0 with SMTP id
 z8-20020a170903018800b001783d4945a0mr4289052plg.154.1663247912216; Thu, 15
 Sep 2022 06:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220915124418.27156-1-plautrba@redhat.com>
In-Reply-To: <20220915124418.27156-1-plautrba@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 15 Sep 2022 15:18:21 +0200
Message-ID: <CAFqZXNvmjHBQ4gTkm3252NE2KcBL4=5da5+dK2pHD0mAxqbAkw@mail.gmail.com>
Subject: Re: [PATCH] fixfiles: Unmount temporary bind mounts on SIGINT
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 15, 2022 at 2:45 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> `fixfiles -M relabel` temporary bind mounts filestems before relabeling
> but it leaves a directory mounted in /tmp/tmp.XXXX when a user hits
> CTRL-C. It means that if the user run `fixfiles -M relabel` again and
> answered Y to clean out /tmp directory, it would remove all data from
> mounted fs.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2125355
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  policycoreutils/scripts/fixfiles | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index c72ca0eb9d61..6811921970f2 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -207,6 +207,15 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
>  [ ${PIPESTATUS[0]} != 0 ] && echo "$1 not found" >/dev/stderr
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
>  #
>  # restore
>  # if called with -n will only check file context
> @@ -251,6 +260,7 @@ case "$RESTORE_MODE" in
>             else
>                 # we bind mount so we can fix the labels of files that have already been
>                 # mounted over
> +               trap umount_TMP_MOUNT SIGINT
>                 for m in `echo $FILESYSTEMSRW`; do
>                     TMP_MOUNT="$(mktemp -d)"
>                     test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
> @@ -261,6 +271,7 @@ case "$RESTORE_MODE" in
>                     umount "${TMP_MOUNT}${m}" || exit 1
>                     rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>                 done;
> +               trap SIGINT
>             fi
>         else
>             echo >&2 "fixfiles: No suitable file systems found"
> --
> 2.37.3
>

And what if the fixfiles process is terminated via SIGTERM or even
SIGKILL? Or a power failure occurs at the wrong time? What if some
other process leaves behind a bind mount / other mount in /tmp?

My suggestion would be to:
1) Change the trap from SIGINT to EXIT. That will cover both SIGTERM and SIGINT.
2) Additionally modify fullrelabel() to not traverse across mounts
when doing the removing (+ possibly exit with an error whenever a
mountpoint is encountered - OR - try to unmount the mounts instead of
removing their contents).

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

