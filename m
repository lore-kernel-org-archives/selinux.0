Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3018C433DB
	for <selinux@archiver.kernel.org>; Sat, 30 Jan 2021 13:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B0464DCC
	for <selinux@archiver.kernel.org>; Sat, 30 Jan 2021 13:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhA3Ndz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 30 Jan 2021 08:33:55 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:54154 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhA3Ndx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 30 Jan 2021 08:33:53 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 41A0A564ECA
        for <selinux@vger.kernel.org>; Sat, 30 Jan 2021 14:33:08 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id d7so11499113otf.3
        for <selinux@vger.kernel.org>; Sat, 30 Jan 2021 05:33:08 -0800 (PST)
X-Gm-Message-State: AOAM531l0REib1lTR4iDlppt9lE/qzamwaPoWu9vSeNBWZ6cXzy1yOb2
        SUl/XT/sJ02xjDbQt3FnAjJuz/+a6RTMN8Nh0p0=
X-Google-Smtp-Source: ABdhPJyovbNaGE/ogilc+9z+NQHbL2l6cq3f82pFLfBBdcxL/LCgmDzO+zSF0AECO38BPcanAIV4iST4cwW6+W3M1I0=
X-Received: by 2002:a9d:66da:: with SMTP id t26mr5817495otm.279.1612013587144;
 Sat, 30 Jan 2021 05:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20210129200034.205263-1-plautrba@redhat.com>
In-Reply-To: <20210129200034.205263-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 30 Jan 2021 14:32:56 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mJ+=tPA8aZzmxhgRqR-incXW8qztibPPQ=RSkc2pS_kQ@mail.gmail.com>
Message-ID: <CAJfZ7=mJ+=tPA8aZzmxhgRqR-incXW8qztibPPQ=RSkc2pS_kQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/release: Release also tarball with everything
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan 30 14:33:09 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 29, 2021 at 9:06 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Create and publish with sha256sum also tarball called
> selinux-$VERS.tar.gz with the whole tree. It could be useful for unit
> testing directly from tarball or backporting patches which affects more
> subdirectories. Github already provides similar archive called "Source
> code (tar.gz)" via release assets, but there's no guarantee this file
> would not change.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  scripts/release | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/release b/scripts/release
> index 895a0e1ca1a1..40a9c06f56b9 100755
> --- a/scripts/release
> +++ b/scripts/release
> @@ -35,6 +35,8 @@ for i in $DIRS_NEED_PREFIX; do
>         cd ..
>  done
>
> +git archive -o $DEST/selinux-$VERS.tar.gz --prefix=selinux-$VERS/ $VERS
> +
>  cd $DEST
>
>  git add .
> @@ -54,13 +56,28 @@ echo ""
>  echo "[short log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/shortlog-$RELEASE_TAG.txt)"
>  echo ""
>
> -for i in *.tar.gz; do
> +for i in $DIRS; do
> +       tarball=$i-$VERS.tar.gz
> +       echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$tarball) "
> +       sha256sum $tarball | cut -d " " -f 1
> +       echo ""
> +done
>
> -       echo -n "[$i](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$i) "
> -       sha256sum $i | cut -d " " -f 1
> +for i in $DIRS_NEED_PREFIX; do
> +       tarball=selinux-$i-$VERS.tar.gz
> +       echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$tarball) "
> +       sha256sum $tarball | cut -d " " -f 1
>         echo ""
>  done
>
> +echo "### Everything"
> +
> +echo ""
> +
> +echo -n "[selinux-$VERS.tar.gz](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/selinux-$VERS.tar.gz) "
> +sha256sum selinux-$VERS.tar.gz | cut -d " " -f 1
> +echo ""

Hello, there are at least two issues here:
* The section is named "Everything" but on
https://github.com/SELinuxProject/selinux/wiki/Releases it is named
"All in one". What is the proper name?
* $VERS comes from a VERSION file in a subdirectory. It would be more
consistent to either use $RELEASE_TAG (which is the content of the
main VERSION file) or to use a single $VERS variable (and to verify
that the */VERSION files all contain the same content, for example
with "diff VERSION $i/VERSION"). Which option would be preferable?

Moreover I do not like using string variables without quotes (and
shellcheck reports warnings for this), but this is a general issue of
this script. I will send a patch to improve the release script.

Cheers,
Nicolas

