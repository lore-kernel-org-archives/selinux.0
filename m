Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E88FC35DE1
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 14:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E442D2064A
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 14:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXHpcCUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgBYOGN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:06:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45536 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYOGN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 09:06:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id g3so14834100wrs.12
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 06:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kp4Q5Dbr3WrOdQyQyIHeXGYab2MVrwkJWAZOKdmWYNw=;
        b=lXHpcCUpeNS/Vj5SBUSE31K7fQHnAubbPAIcjgjHmP1YHAfkWO/nw9dL4+X4h3nt7d
         Xas4vKRbhwhGHGo7NHaPXpHdxJXw2AN026sWfEd3+/TPUYHX+j5d5rHQkGKbZEQ/RPsd
         kNmNYuJ+OULlMZz4ci6YP/h7cY+yiOGBw0QtfET6K6U5AK/vBAAZYLHEUPMsdI8fBePi
         HlevjAKLMjNcDzIqg+8xEPAyjbmbf7y3ICPbOq7s8cohNfV8vcrjJteEAaqbr/qtT98x
         EusncLpyRAYzxd9vapgtBEPxFiSEDxLNWUDeTUFj9jrrzEsvzW4Z5b801UX+QZM1ZNQJ
         Rf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kp4Q5Dbr3WrOdQyQyIHeXGYab2MVrwkJWAZOKdmWYNw=;
        b=Te161qMAmdr6/vuCuze13tvE+Om6DLLhOS3LFSJQKxLAMMuH4ZLUWZ2NDbjNjWAGYz
         7vIcZ/MfKHF81AJfUYjcICMfONtOHx65CRCmgWH6r/7bdEvOgBYHnqZmZ0jsYYhA0p+p
         rrIuG8RAGAqEJqCEDtt7xv5ddRpYlg9y6DNgXW8xlow1PtFnKQo1XcUotpj02iSlkhE1
         vzAk+NPfvSgrYX0W/COOoZgK2md6/3WJz2bbwcmjJMPBl7E+E+o6b4UHZv6h5kMMFpDP
         +ME5d577/h5wNou5tXAxNbTIFpKJ0M8NC9njCIkomC51Op8gecPUqG7uJTGzoFp4LT0T
         i5yA==
X-Gm-Message-State: APjAAAVw3GELtoYJEwfrXqVJemZjdcWtPJ8gu2j/F+aUNlV0qlNz9sNH
        2mOKQ83mGZaGASuPTDReAgb/+2QoN4zkniixHbIcNA==
X-Google-Smtp-Source: APXvYqxOytWc+kkwhrjW2YHlcqJMa+QjWtjFGUYZ4iO5AMDfKLMz/mv808Ck+5Vibrr5eotczLi03p6GQyFr3ovcUUE=
X-Received: by 2002:a5d:604a:: with SMTP id j10mr6915337wrt.181.1582639571407;
 Tue, 25 Feb 2020 06:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20200221131825.91499-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200221131825.91499-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Tue, 25 Feb 2020 09:07:42 -0500
Message-ID: <CAB9W1A0Cyg577HvJ8hnhWbvC697QSLmym07hi=Faip1j0gdLRQ@mail.gmail.com>
Subject: Re: [PATCH V2] selinux-testsuite: Allow nfs test script to close cleanly
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 21, 2020 at 8:18 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Whenever a failure, close NFS cleanly.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

I'm not much of a shell programmer but this looks good to me.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
> V2 Changes:
> Revamp error handling to cover all cases
>
>  tools/nfs.sh | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/tools/nfs.sh b/tools/nfs.sh
> index 314f898..7ba4cfc 100755
> --- a/tools/nfs.sh
> +++ b/tools/nfs.sh
> @@ -1,14 +1,33 @@
>  #!/bin/sh -e
>  MOUNT=`stat --print %m .`
>  TESTDIR=`pwd`
> -systemctl start nfs-server
> +MAKE_TEST=0
> +
> +function err_exit() {
> +    if [ $MAKE_TEST -eq 1 ]; then
> +        echo "Closing down NFS"
> +        popd
> +    else
> +        echo "Error on line: $1 - Closing down NFS"
> +    fi
> +    umount /mnt/selinux-testsuite
> +    exportfs -u localhost:$MOUNT
> +    rmdir /mnt/selinux-testsuite
> +    systemctl stop nfs-server
> +    exit 1
> +}
> +
> +trap 'err_exit $LINENO' ERR
>
> +systemctl start nfs-server
>  # Run the full testsuite on a labeled NFS mount.
>  exportfs -orw,no_root_squash,security_label localhost:$MOUNT
>  mkdir -p /mnt/selinux-testsuite
>  mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
>  pushd /mnt/selinux-testsuite
> +MAKE_TEST=1
>  make test
> +MAKE_TEST=0
>  popd
>  umount /mnt/selinux-testsuite
>
> @@ -18,7 +37,7 @@ echo "Testing context mount of a security_label export."
>  fctx=`secon -t -f /mnt/selinux-testsuite`
>  if [ "$fctx" != "etc_t" ]; then
>      echo "Context mount failed: got $fctx instead of etc_t."
> -    exit 1
> +    err_exit $LINENO
>  fi
>  umount /mnt/selinux-testsuite
>  exportfs -u localhost:$MOUNT
> @@ -30,7 +49,7 @@ echo "Testing context mount of a non-security_label export."
>  fctx=`secon -t -f /mnt/selinux-testsuite`
>  if [ "$fctx" != "etc_t" ]; then
>      echo "Context mount failed: got $fctx instead of etc_t."
> -    exit 1
> +    err_exit $LINENO
>  fi
>  umount /mnt/selinux-testsuite
>
> @@ -40,7 +59,7 @@ echo "Testing non-context mount of a non-security_label export."
>  fctx=`secon -t -f /mnt/selinux-testsuite`
>  if [ "$fctx" != "nfs_t" ]; then
>      echo "Context mount failed: got $fctx instead of nfs_t."
> -    exit 1
> +    err_exit $LINENO
>  fi
>  umount /mnt/selinux-testsuite
>
> --
> 2.24.1
>
