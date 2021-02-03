Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77486C433E0
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 12:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C5664F7E
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 12:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhBCMJ3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 07:09:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233983AbhBCMJV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 07:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612354074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PvnotjT26+1QZt8uzvWykOPhfe7DUxRUVg5f5543GLs=;
        b=eXjAfHslf75kVOaqxDoN7UXzlr7rBFA6egAk5dGbiHrrJmWr+mB3TmBfz9jvPVwTDPaRXF
        4G5qL7x8Ny/znEABsflryOg/xzmBJ17Koah/PJKdhTpRDkeswU+Ug18HtOjiNPrfhG/0aH
        vlnQOhHJt9TdcPhnq01t9IlmoK8TdK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-K3-42c10O8GC3GX3uX3_aw-1; Wed, 03 Feb 2021 07:07:52 -0500
X-MC-Unique: K3-42c10O8GC3GX3uX3_aw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 359441936B60;
        Wed,  3 Feb 2021 12:07:51 +0000 (UTC)
Received: from localhost (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2D981971C;
        Wed,  3 Feb 2021 12:07:50 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH v2 1/1] scripts/release: make the script more robust,
 and release a source repository snapshot
In-Reply-To: <87pn1hmq1j.fsf@redhat.com>
References: <20210201221646.13190-1-nicolas.iooss@m4x.org>
 <87sg6dmr5f.fsf@redhat.com>
 <CAJfZ7==OM+VKJF7pTgnztWTTBmgCJTkkchXFdg265CgQ0LdQeA@mail.gmail.com>
 <87pn1hmq1j.fsf@redhat.com>
Date:   Wed, 03 Feb 2021 13:07:49 +0100
Message-ID: <87ft2dmk16.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
>> On Wed, Feb 3, 2021 at 10:34 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>>
>>> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>>>
>>> > Following Petr Lautrbach's suggestion, release a snapshot of the source
>>> > repository next to the individual archives which constitute a release.
>>> >
>>> > While at it, make scripts/release more robust:
>>> >
>>> > - Fix many warnings reported by shellcheck, by quoting strings.
>>> > - Use bash arrays for DIRS and DIRS_NEED_PREFIX
>>> > - Merge DIRS and DIRS_NEED_PREFIX into a single array, in order to
>>> >   produce SHA256 digests that are directly in alphabetical order, for
>>> >   https://github.com/SELinuxProject/selinux/wiki/Releases
>>> > - Use "set -e" in order to fail as soon as a command fails
>>> > - Change to the top-level directory at the start of the script, in order
>>> >   to be able to run it from anywhere.
>>> > - Use `cat $DIR/VERSION` and `git -C $DIR` instead of `cd $i ; cat VERSION`
>>> >   in order to prevent unexpected issues from directory change.
>>> >
>>> > Finally, if version tags already exists, re-use them. This enables using
>>> > this script to re-generate the release archive (and check that they
>>> > really match the git repository). Currently, running scripts/release
>>> > will produce the same archives as the ones published in the 3.2-rc1
>>> > release (with the same SHA256 digests as the ones on the release page,
>>> > https://github.com/SELinuxProject/selinux/wiki/Releases). This helps to
>>> > ensure that the behaviour of the script is still fine.
>>> >
>>> > Suggested-by: Petr Lautrbach <plautrba@redhat.com>
>>> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>>> > ---
>>> >  scripts/release | 95 +++++++++++++++++++++++++++++++------------------
>>> >  1 file changed, 60 insertions(+), 35 deletions(-)
>>> >
>>> > diff --git a/scripts/release b/scripts/release
>>> > index 895a0e1ca1a1..21e30ff54b80 100755
>>> > --- a/scripts/release
>>> > +++ b/scripts/release
>>> > @@ -1,43 +1,57 @@
>>> >  #!/bin/bash
>>> >
>>> > -PWD=`pwd`
>>> > -WIKIDIR=../selinux.wiki
>>> > -
>>> > -if [ \! -d $WIKIDIR ]; then
>>> > -    git clone git@github.com:SELinuxProject/selinux.wiki.git $WIKIDIR
>>> > -fi
>>> > +# Fail when a command fails
>>> > +set -e
>>> >
>>> > -RELEASE_TAG=`cat VERSION`
>>> > -DEST=releases/$RELEASE_TAG
>>> > -DIRS="libsepol libselinux libsemanage checkpolicy secilc policycoreutils mcstrans restorecond semodule-utils"
>>> > -DIRS_NEED_PREFIX="dbus gui python sandbox"
>>> > +# Ensure the script is running from the top level directory
>>> > +cd "$(dirname -- "$0")/.."
>>> >
>>> > -git tag -a $RELEASE_TAG -m "Release $RELEASE_TAG"
>>> > +WIKIDIR=../selinux.wiki
>>> >
>>> > -rm -rf $DEST
>>> > -mkdir -p $DEST
>>> > +if ! [ -d "$WIKIDIR" ]; then
>>> > +     git clone git@github.com:SELinuxProject/selinux.wiki.git "$WIKIDIR"
>>> > +fi
>>> >
>>> > -for i in $DIRS; do
>>> > -     cd $i
>>> > -     VERS=`cat VERSION`
>>> > -     ARCHIVE=$i-$VERS.tar.gz
>>> > -     git tag $i-$VERS > /dev/null 2>&1
>>> > -     git archive -o ../$DEST/$ARCHIVE --prefix=$i-$VERS/ $i-$VERS
>>> > -     cd ..
>>> > -done
>>> > +RELEASE_TAG="$(cat VERSION)"
>>> > +DEST="releases/$RELEASE_TAG"
>>> > +DIRS=(
>>> > +     checkpolicy
>>> > +     libselinux
>>> > +     libsemanage
>>> > +     libsepol
>>> > +     mcstrans
>>> > +     policycoreutils
>>> > +     restorecond
>>> > +     secilc
>>> > +     selinux-dbus
>>> > +     selinux-gui
>>> > +     selinux-python
>>> > +     selinux-sandbox
>>> > +     semodule-utils
>>> > +)
>>> > +
>>> > +if git rev-parse "$RELEASE_TAG" > /dev/null ; then
>>> > +     echo "Warning: tag $RELEASE_TAG already exists"
>>> > +else
>>> > +     git tag -a "$RELEASE_TAG" -m "Release $RELEASE_TAG"
>>> > +fi
>>>
>>> fatal: ambiguous argument '3.2-rc2': unknown revision or path not in the working tree.
>>> Use '--' to separate paths from revisions, like this:
>>> 'git <command> [<revision>...] -- [<file>...]'
>>>
>>>
>>> > -for i in $DIRS_NEED_PREFIX; do
>>> > -     cd $i
>>> > -     VERS=`cat VERSION`
>>> > -     ARCHIVE=selinux-$i-$VERS.tar.gz
>>> > -     git tag selinux-$i-$VERS > /dev/null 2>&1
>>> > -     git archive -o ../$DEST/$ARCHIVE --prefix=selinux-$i-$VERS/ selinux-$i-$VERS
>>> > -     cd ..
>>> > +rm -rf "$DEST"
>>> > +mkdir -p "$DEST"
>>> > +
>>> > +for COMPONENT in "${DIRS[@]}"; do
>>> > +     DIR="${COMPONENT#selinux-}"
>>> > +     VERS="$(cat "$DIR/VERSION")"
>>> > +     TAG="$COMPONENT-$VERS"
>>> > +     if git rev-parse "$TAG" > /dev/null ; then
>>> > +             echo "Warning: tag $TAG already exists"
>>> > +     else
>>> > +             git tag "$TAG" > /dev/null
>>> > +     fi
>>>
>>> fatal: ambiguous argument 'checkpolicy-3.2-rc2': unknown revision or path not in the working tree.
>>> Use '--' to separate paths from revisions, like this:
>>> 'git <command> [<revision>...] -- [<file>...]'
>>>
>>> The following change fixes both:
>>>
>>> --- a/scripts/release
>>> +++ b/scripts/release
>>> @@ -30,7 +30,7 @@ DIRS=(
>>>         semodule-utils
>>>  )
>>>
>>> -if git rev-parse "$RELEASE_TAG" > /dev/null ; then
>>> +if git rev-parse "$RELEASE_TAG" &> /dev/null ; then
>>>         echo "Warning: tag $RELEASE_TAG already exists"
>>>  else
>>>         git tag -a "$RELEASE_TAG" -m "Release $RELEASE_TAG"
>>> @@ -43,7 +43,7 @@ for COMPONENT in "${DIRS[@]}"; do
>>>         DIR="${COMPONENT#selinux-}"
>>>         VERS="$(cat "$DIR/VERSION")"
>>>         TAG="$COMPONENT-$VERS"
>>> -       if git rev-parse "$TAG" > /dev/null ; then
>>> +       if git rev-parse "$TAG" &> /dev/null ; then
>>>                 echo "Warning: tag $TAG already exists"
>>>         else
>>>                 git tag "$TAG" > /dev/null
>>
>> Oops, indeed. The errors do not seem to be fatal, but yes, it is
>> better to hide them, like you suggest. You can modify my patch with
>> this change, or write a patch.
>>
>> Anyway, your suggestion looks good to me.
>
>
> I'm just preparing 3.2-rc2 so I'm going to modify your patch, merge and
> use it for the new release. 
>
>

It's merged now. Thanks!

