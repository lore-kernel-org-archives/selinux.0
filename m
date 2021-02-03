Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B63C433DB
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 09:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1EBD64F60
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 09:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhBCJsF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 04:48:05 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:54634 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhBCJr7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 04:47:59 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id CC8C6565AB1
        for <selinux@vger.kernel.org>; Wed,  3 Feb 2021 10:47:12 +0100 (CET)
Received: by mail-oo1-f50.google.com with SMTP id x23so5859277oop.1
        for <selinux@vger.kernel.org>; Wed, 03 Feb 2021 01:47:12 -0800 (PST)
X-Gm-Message-State: AOAM533xBkigmeTPOhK0a3laaG1ZrkCqcZE+vsxXM4ifhhZcBnkRJFxd
        DNSqL2YLUtbRzJ1cIDE9BtQGwA2/dpCcGOQFGtk=
X-Google-Smtp-Source: ABdhPJyL30VSpkiLl/ewnSxBl7Mmop3Zdf8vmNOGjz4NyKx+x94VlUamCUm/pqvO/RdCx+K1FrvtIH3y+hHKWzX75fU=
X-Received: by 2002:a4a:a22a:: with SMTP id m42mr1547359ool.22.1612345631753;
 Wed, 03 Feb 2021 01:47:11 -0800 (PST)
MIME-Version: 1.0
References: <20210201221646.13190-1-nicolas.iooss@m4x.org> <87sg6dmr5f.fsf@redhat.com>
In-Reply-To: <87sg6dmr5f.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 3 Feb 2021 10:47:00 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==OM+VKJF7pTgnztWTTBmgCJTkkchXFdg265CgQ0LdQeA@mail.gmail.com>
Message-ID: <CAJfZ7==OM+VKJF7pTgnztWTTBmgCJTkkchXFdg265CgQ0LdQeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] scripts/release: make the script more robust, and
 release a source repository snapshot
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Feb  3 10:47:13 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 3, 2021 at 10:34 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
> > Following Petr Lautrbach's suggestion, release a snapshot of the source
> > repository next to the individual archives which constitute a release.
> >
> > While at it, make scripts/release more robust:
> >
> > - Fix many warnings reported by shellcheck, by quoting strings.
> > - Use bash arrays for DIRS and DIRS_NEED_PREFIX
> > - Merge DIRS and DIRS_NEED_PREFIX into a single array, in order to
> >   produce SHA256 digests that are directly in alphabetical order, for
> >   https://github.com/SELinuxProject/selinux/wiki/Releases
> > - Use "set -e" in order to fail as soon as a command fails
> > - Change to the top-level directory at the start of the script, in order
> >   to be able to run it from anywhere.
> > - Use `cat $DIR/VERSION` and `git -C $DIR` instead of `cd $i ; cat VERSION`
> >   in order to prevent unexpected issues from directory change.
> >
> > Finally, if version tags already exists, re-use them. This enables using
> > this script to re-generate the release archive (and check that they
> > really match the git repository). Currently, running scripts/release
> > will produce the same archives as the ones published in the 3.2-rc1
> > release (with the same SHA256 digests as the ones on the release page,
> > https://github.com/SELinuxProject/selinux/wiki/Releases). This helps to
> > ensure that the behaviour of the script is still fine.
> >
> > Suggested-by: Petr Lautrbach <plautrba@redhat.com>
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  scripts/release | 95 +++++++++++++++++++++++++++++++------------------
> >  1 file changed, 60 insertions(+), 35 deletions(-)
> >
> > diff --git a/scripts/release b/scripts/release
> > index 895a0e1ca1a1..21e30ff54b80 100755
> > --- a/scripts/release
> > +++ b/scripts/release
> > @@ -1,43 +1,57 @@
> >  #!/bin/bash
> >
> > -PWD=`pwd`
> > -WIKIDIR=../selinux.wiki
> > -
> > -if [ \! -d $WIKIDIR ]; then
> > -    git clone git@github.com:SELinuxProject/selinux.wiki.git $WIKIDIR
> > -fi
> > +# Fail when a command fails
> > +set -e
> >
> > -RELEASE_TAG=`cat VERSION`
> > -DEST=releases/$RELEASE_TAG
> > -DIRS="libsepol libselinux libsemanage checkpolicy secilc policycoreutils mcstrans restorecond semodule-utils"
> > -DIRS_NEED_PREFIX="dbus gui python sandbox"
> > +# Ensure the script is running from the top level directory
> > +cd "$(dirname -- "$0")/.."
> >
> > -git tag -a $RELEASE_TAG -m "Release $RELEASE_TAG"
> > +WIKIDIR=../selinux.wiki
> >
> > -rm -rf $DEST
> > -mkdir -p $DEST
> > +if ! [ -d "$WIKIDIR" ]; then
> > +     git clone git@github.com:SELinuxProject/selinux.wiki.git "$WIKIDIR"
> > +fi
> >
> > -for i in $DIRS; do
> > -     cd $i
> > -     VERS=`cat VERSION`
> > -     ARCHIVE=$i-$VERS.tar.gz
> > -     git tag $i-$VERS > /dev/null 2>&1
> > -     git archive -o ../$DEST/$ARCHIVE --prefix=$i-$VERS/ $i-$VERS
> > -     cd ..
> > -done
> > +RELEASE_TAG="$(cat VERSION)"
> > +DEST="releases/$RELEASE_TAG"
> > +DIRS=(
> > +     checkpolicy
> > +     libselinux
> > +     libsemanage
> > +     libsepol
> > +     mcstrans
> > +     policycoreutils
> > +     restorecond
> > +     secilc
> > +     selinux-dbus
> > +     selinux-gui
> > +     selinux-python
> > +     selinux-sandbox
> > +     semodule-utils
> > +)
> > +
> > +if git rev-parse "$RELEASE_TAG" > /dev/null ; then
> > +     echo "Warning: tag $RELEASE_TAG already exists"
> > +else
> > +     git tag -a "$RELEASE_TAG" -m "Release $RELEASE_TAG"
> > +fi
>
> fatal: ambiguous argument '3.2-rc2': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
>
>
> > -for i in $DIRS_NEED_PREFIX; do
> > -     cd $i
> > -     VERS=`cat VERSION`
> > -     ARCHIVE=selinux-$i-$VERS.tar.gz
> > -     git tag selinux-$i-$VERS > /dev/null 2>&1
> > -     git archive -o ../$DEST/$ARCHIVE --prefix=selinux-$i-$VERS/ selinux-$i-$VERS
> > -     cd ..
> > +rm -rf "$DEST"
> > +mkdir -p "$DEST"
> > +
> > +for COMPONENT in "${DIRS[@]}"; do
> > +     DIR="${COMPONENT#selinux-}"
> > +     VERS="$(cat "$DIR/VERSION")"
> > +     TAG="$COMPONENT-$VERS"
> > +     if git rev-parse "$TAG" > /dev/null ; then
> > +             echo "Warning: tag $TAG already exists"
> > +     else
> > +             git tag "$TAG" > /dev/null
> > +     fi
>
> fatal: ambiguous argument 'checkpolicy-3.2-rc2': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
>
> The following change fixes both:
>
> --- a/scripts/release
> +++ b/scripts/release
> @@ -30,7 +30,7 @@ DIRS=(
>         semodule-utils
>  )
>
> -if git rev-parse "$RELEASE_TAG" > /dev/null ; then
> +if git rev-parse "$RELEASE_TAG" &> /dev/null ; then
>         echo "Warning: tag $RELEASE_TAG already exists"
>  else
>         git tag -a "$RELEASE_TAG" -m "Release $RELEASE_TAG"
> @@ -43,7 +43,7 @@ for COMPONENT in "${DIRS[@]}"; do
>         DIR="${COMPONENT#selinux-}"
>         VERS="$(cat "$DIR/VERSION")"
>         TAG="$COMPONENT-$VERS"
> -       if git rev-parse "$TAG" > /dev/null ; then
> +       if git rev-parse "$TAG" &> /dev/null ; then
>                 echo "Warning: tag $TAG already exists"
>         else
>                 git tag "$TAG" > /dev/null

Oops, indeed. The errors do not seem to be fatal, but yes, it is
better to hide them, like you suggest. You can modify my patch with
this change, or write a patch.

Anyway, your suggestion looks good to me.

Thanks!
Nicolas

