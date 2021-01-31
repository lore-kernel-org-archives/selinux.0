Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4E3C433E0
	for <selinux@archiver.kernel.org>; Sun, 31 Jan 2021 20:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C32664E1F
	for <selinux@archiver.kernel.org>; Sun, 31 Jan 2021 20:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhAaUDA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:03:00 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:49336 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhAaT6w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 31 Jan 2021 14:58:52 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8C25B564E37
        for <selinux@vger.kernel.org>; Sun, 31 Jan 2021 18:30:46 +0100 (CET)
Received: by mail-oi1-f172.google.com with SMTP id w124so16221083oia.6
        for <selinux@vger.kernel.org>; Sun, 31 Jan 2021 09:30:46 -0800 (PST)
X-Gm-Message-State: AOAM530jKq68zWdzH9h63XvsLmpFnkL9c7grgIwsB2PKiX62bf5C3W82
        cPaBd3uNxcu/aTPkqjoGJNlGdhS95pfT5bkRd/o=
X-Google-Smtp-Source: ABdhPJyXuchX7nCynRVeZMtEpVerULVreYS3EYxLwKMJMV1jRN/jkMK+du7KQB6OjkIEfhpvYTL+CY1+pIlD55ELJiU=
X-Received: by 2002:a05:6808:918:: with SMTP id w24mr8732526oih.20.1612114245435;
 Sun, 31 Jan 2021 09:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20210129200034.205263-1-plautrba@redhat.com> <CAJfZ7=mJ+=tPA8aZzmxhgRqR-incXW8qztibPPQ=RSkc2pS_kQ@mail.gmail.com>
 <87bld5o1te.fsf@redhat.com>
In-Reply-To: <87bld5o1te.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 31 Jan 2021 18:30:34 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mJ7-RCXFO1iDDmaUJx24xmd6-+-ERmi1J7w82Kb3hi7A@mail.gmail.com>
Message-ID: <CAJfZ7=mJ7-RCXFO1iDDmaUJx24xmd6-+-ERmi1J7w82Kb3hi7A@mail.gmail.com>
Subject: Re: [PATCH] scripts/release: Release also tarball with everything
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jan 31 18:30:46 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jan 31, 2021 at 11:09 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
> > On Fri, Jan 29, 2021 at 9:06 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >>
> >> Create and publish with sha256sum also tarball called
> >> selinux-$VERS.tar.gz with the whole tree. It could be useful for unit
> >> testing directly from tarball or backporting patches which affects more
> >> subdirectories. Github already provides similar archive called "Source
> >> code (tar.gz)" via release assets, but there's no guarantee this file
> >> would not change.
> >>
> >> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> >> ---
> >>  scripts/release | 23 ++++++++++++++++++++---
> >>  1 file changed, 20 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/scripts/release b/scripts/release
> >> index 895a0e1ca1a1..40a9c06f56b9 100755
> >> --- a/scripts/release
> >> +++ b/scripts/release
> >> @@ -35,6 +35,8 @@ for i in $DIRS_NEED_PREFIX; do
> >>         cd ..
> >>  done
> >>
> >> +git archive -o $DEST/selinux-$VERS.tar.gz --prefix=selinux-$VERS/ $VERS
> >> +
> >>  cd $DEST
> >>
> >>  git add .
> >> @@ -54,13 +56,28 @@ echo ""
> >>  echo "[short log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/shortlog-$RELEASE_TAG.txt)"
> >>  echo ""
> >>
> >> -for i in *.tar.gz; do
> >> +for i in $DIRS; do
> >> +       tarball=$i-$VERS.tar.gz
> >> +       echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$tarball) "
> >> +       sha256sum $tarball | cut -d " " -f 1
> >> +       echo ""
> >> +done
> >>
> >> -       echo -n "[$i](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$i) "
> >> -       sha256sum $i | cut -d " " -f 1
> >> +for i in $DIRS_NEED_PREFIX; do
> >> +       tarball=selinux-$i-$VERS.tar.gz
> >> +       echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$tarball) "
> >> +       sha256sum $tarball | cut -d " " -f 1
> >>         echo ""
> >>  done
> >>
> >> +echo "### Everything"
> >> +
> >> +echo ""
> >> +
> >> +echo -n "[selinux-$VERS.tar.gz](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/selinux-$VERS.tar.gz) "
> >> +sha256sum selinux-$VERS.tar.gz | cut -d " " -f 1
> >> +echo ""
> >
> > Hello, there are at least two issues here:
> > * The section is named "Everything" but on
> > https://github.com/SELinuxProject/selinux/wiki/Releases it is named
> > "All in one". What is the proper name?
>
>
> I used "All in one" in rc1 release but I didn't announce it properly and
> it didn't feel good to me. So I sent this patch to make this official.
> And I like "Everything" more than the original "All in one". I can
> change it on the release page if the change is accepted or drop it
> completely if it's denied.

I find "Everything" to be quite unclear, because for example the
archive does not contain the git history... What about "Source
repository snapshot", which better describes what the archive really
is? This is a personal opinion and I am also fine with keeping
"Everything" if you do not like my suggestion.

> > * $VERS comes from a VERSION file in a subdirectory. It would be more
> > consistent to either use $RELEASE_TAG (which is the content of the
> > main VERSION file) or to use a single $VERS variable (and to verify
> > that the */VERSION files all contain the same content, for example
> > with "diff VERSION $i/VERSION"). Which option would be preferable?
>
> For now I'd use $RELEASE_TAG for selinux-X.Y.tar.gz
>
> and maybe something like:
>
> -for i in $DIRS; do
> -       tarball=$i-$VERS.tar.gz
> +for i in $DIRS; do
> +       tarball=`ls $i-*.tar.gz`

I do not like using wildcard patterns. In the patch I sent
(https://lore.kernel.org/selinux/20210130133313.1759011-1-nicolas.iooss@m4x.org/)
I replaced this part with reading $i/VERSION again:

+for COMPONENT in "${DIRS[@]}"; do
+ DIR="${COMPONENT#selinux-}"
+ VERS="$(cat "$DIR/VERSION")"
+ TAG="$COMPONENT-$VERS"
+ tarball="$TAG.tar.gz"

Nevertheless the script is currently using wildcards and your
suggestion works, so you can use `ls $i-*.tar.gz` and I will then
propose a new version of my patch to remove this. Or you can include
my changes in your patch, if you agree with them. How do you want to
proceed?

Thanks,
Nicolas

