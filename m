Return-Path: <SRS0=Ce+3=QK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774D6C169C4
	for <selinux@archiver.kernel.org>; Sun,  3 Feb 2019 22:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3BF2177E
	for <selinux@archiver.kernel.org>; Sun,  3 Feb 2019 22:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfBCWYE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 3 Feb 2019 17:24:04 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:35837 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfBCWYE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 3 Feb 2019 17:24:04 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5D86F5646F8
        for <selinux@vger.kernel.org>; Sun,  3 Feb 2019 23:24:01 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id e12so10632366otl.5
        for <selinux@vger.kernel.org>; Sun, 03 Feb 2019 14:24:01 -0800 (PST)
X-Gm-Message-State: AJcUukfseEBwzRZ1GbqPgLhTf1rKrUYlDPP+potvJp2cxH+Nn9RHYCgL
        S6msyuUUd65z99Ym6so4qEi5PLNC8oWlQo8yW04=
X-Google-Smtp-Source: ALg8bN742XVrAFYPcBFNPJuciSRfAlPk4KKBNijV24A11Iy8FEJdNMRjM0ws0ZZmWyXDL2vYu5YcHc/sguY1Pjemnos=
X-Received: by 2002:a9d:2f66:: with SMTP id h93mr37141026otb.165.1549232640177;
 Sun, 03 Feb 2019 14:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20190131134812.20440-1-plautrba@redhat.com>
In-Reply-To: <20190131134812.20440-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 3 Feb 2019 23:23:48 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nW+1DnK1T0-0eDuzP48L26B2yMUA44VWfsnxMVEd_k4Q@mail.gmail.com>
Message-ID: <CAJfZ7=nW+1DnK1T0-0eDuzP48L26B2yMUA44VWfsnxMVEd_k4Q@mail.gmail.com>
Subject: Re: [PATCH] scripts/release: Update links to use release assets
 instead of wiki links
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb  3 23:24:01 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 2:48 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> - new release files are created in release/$RELEASE_TAG
> - download links refers to new release assets
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

I have created packages for 2.9-rc1 for Arch Linux without any
trouble, using the information from the GitHub release page and the
generated wiki page
(https://github.com/SELinuxProject/selinux/wiki/Releases).

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  scripts/release | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/release b/scripts/release
> index ad10d557..07813749 100755
> --- a/scripts/release
> +++ b/scripts/release
> @@ -7,11 +7,12 @@ if [ \! -d $WIKIDIR ]; then
>      git clone git@github.com:SELinuxProject/selinux.wiki.git $WIKIDIR
>  fi
>
> -DEST=$WIKIDIR/files/releases/$(date '+%Y%m%d')
> +RELEASE_TAG=$(date '+%Y%m%d')
> +DEST=releases/$RELEASE_TAG
>  DIRS="libsepol libselinux libsemanage checkpolicy secilc policycoreutils mcstrans restorecond semodule-utils"
>  DIRS_NEED_PREFIX="dbus gui python sandbox"
>
> -git tag -a $(date '+%Y%m%d') -m "Release $(date '+%Y%m%d')"
> +git tag -a $RELEASE_TAG -m "Release $RELEASE_TAG"
>
>  rm -rf $DEST
>  mkdir -p $DEST
> @@ -44,19 +45,34 @@ echo ""
>
>  echo "## Release $(date '+%Y-%m-%d')"
>
> +echo ""
> +
> +echo "[Release Notes](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/RELEASE-$RELEASE_TAG.txt)"
> +echo ""
> +echo "[full log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/log-$RELEASE_TAG.txt)"
> +echo ""
> +echo "[short log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/shortlog-$RELEASE_TAG.txt)"
> +echo ""
> +
>  for i in *.tar.gz; do
>
> -       echo -n "[$i](https://raw.githubusercontent.com/wiki/SELinuxProject/selinux/files/releases/$(date '+%Y%m%d')/$i) "
> +       echo -n "[$i](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$i) "
>         sha256sum $i | cut -d " " -f 1
>         echo ""
>  done
>
>  echo "And then run:"
>  echo "  cd $WIKIDIR"
> -echo "  git commit  -m \"Release $(date '+%Y%m%d')\" -a -s"
> +echo "  git commit  -m \"Release $RELEASE_TAG\" -a -s"
>  echo "  git push"
>
>  echo ""
>  echo "Push the release and its tags to git via:"
>  echo "  git push"
>  echo "  git push --tags"
> +
> +echo ""
> +echo "Create a new release from the latest tag on https://github.com/SELinuxProject/selinux/tags"
> +
> +echo ""
> +echo "Add files from releases/$RELEASE_TAG as assets to the new github release"
> --
> 2.20.1
>

