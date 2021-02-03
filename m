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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D593DC433DB
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 09:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8F064F61
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 09:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhBCJfm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 04:35:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229650AbhBCJfl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 04:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612344853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKQVoamwTnJEkmYeB7tBHQjppbeD+N7gOLutktSbDgU=;
        b=exOmT/JBBCCJkXIoa9UABXt4c/+tvV7fRtvquzQgOo4DScEckJePwQ0LPCmq4ZDdXJZSTf
        ydbj2oAoVZNTDLTuWxTQZQGqFsQ9uXtPSqOl1PgHw6+sg8r58g98e860fTG8eBwK/ef1wt
        CsDdT/et8vk6v89JOWPUxbfx6rsK1D4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-rNX6uTw_N325DIwn2SSLqA-1; Wed, 03 Feb 2021 04:34:08 -0500
X-MC-Unique: rNX6uTw_N325DIwn2SSLqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E28A1015CAA;
        Wed,  3 Feb 2021 09:34:07 +0000 (UTC)
Received: from localhost (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42A9F5D982;
        Wed,  3 Feb 2021 09:34:05 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Subject: Re: [PATCH v2 1/1] scripts/release: make the script more robust,
 and release a source repository snapshot
In-Reply-To: <20210201221646.13190-1-nicolas.iooss@m4x.org>
References: <20210201221646.13190-1-nicolas.iooss@m4x.org>
Date:   Wed, 03 Feb 2021 10:34:04 +0100
Message-ID: <87sg6dmr5f.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> Following Petr Lautrbach's suggestion, release a snapshot of the source
> repository next to the individual archives which constitute a release.
>
> While at it, make scripts/release more robust:
>
> - Fix many warnings reported by shellcheck, by quoting strings.
> - Use bash arrays for DIRS and DIRS_NEED_PREFIX
> - Merge DIRS and DIRS_NEED_PREFIX into a single array, in order to
>   produce SHA256 digests that are directly in alphabetical order, for
>   https://github.com/SELinuxProject/selinux/wiki/Releases
> - Use "set -e" in order to fail as soon as a command fails
> - Change to the top-level directory at the start of the script, in order
>   to be able to run it from anywhere.
> - Use `cat $DIR/VERSION` and `git -C $DIR` instead of `cd $i ; cat VERSION`
>   in order to prevent unexpected issues from directory change.
>
> Finally, if version tags already exists, re-use them. This enables using
> this script to re-generate the release archive (and check that they
> really match the git repository). Currently, running scripts/release
> will produce the same archives as the ones published in the 3.2-rc1
> release (with the same SHA256 digests as the ones on the release page,
> https://github.com/SELinuxProject/selinux/wiki/Releases). This helps to
> ensure that the behaviour of the script is still fine.
>
> Suggested-by: Petr Lautrbach <plautrba@redhat.com>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  scripts/release | 95 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 60 insertions(+), 35 deletions(-)
>
> diff --git a/scripts/release b/scripts/release
> index 895a0e1ca1a1..21e30ff54b80 100755
> --- a/scripts/release
> +++ b/scripts/release
> @@ -1,43 +1,57 @@
>  #!/bin/bash
>  
> -PWD=`pwd`
> -WIKIDIR=../selinux.wiki
> -
> -if [ \! -d $WIKIDIR ]; then
> -    git clone git@github.com:SELinuxProject/selinux.wiki.git $WIKIDIR
> -fi
> +# Fail when a command fails
> +set -e
>  
> -RELEASE_TAG=`cat VERSION`
> -DEST=releases/$RELEASE_TAG
> -DIRS="libsepol libselinux libsemanage checkpolicy secilc policycoreutils mcstrans restorecond semodule-utils"
> -DIRS_NEED_PREFIX="dbus gui python sandbox"
> +# Ensure the script is running from the top level directory
> +cd "$(dirname -- "$0")/.."
>  
> -git tag -a $RELEASE_TAG -m "Release $RELEASE_TAG"
> +WIKIDIR=../selinux.wiki
>  
> -rm -rf $DEST
> -mkdir -p $DEST
> +if ! [ -d "$WIKIDIR" ]; then
> +	git clone git@github.com:SELinuxProject/selinux.wiki.git "$WIKIDIR"
> +fi
>  
> -for i in $DIRS; do
> -	cd $i
> -	VERS=`cat VERSION`
> -	ARCHIVE=$i-$VERS.tar.gz
> -	git tag $i-$VERS > /dev/null 2>&1
> -	git archive -o ../$DEST/$ARCHIVE --prefix=$i-$VERS/ $i-$VERS
> -	cd ..
> -done
> +RELEASE_TAG="$(cat VERSION)"
> +DEST="releases/$RELEASE_TAG"
> +DIRS=(
> +	checkpolicy
> +	libselinux
> +	libsemanage
> +	libsepol
> +	mcstrans
> +	policycoreutils
> +	restorecond
> +	secilc
> +	selinux-dbus
> +	selinux-gui
> +	selinux-python
> +	selinux-sandbox
> +	semodule-utils
> +)
> +
> +if git rev-parse "$RELEASE_TAG" > /dev/null ; then
> +	echo "Warning: tag $RELEASE_TAG already exists"
> +else
> +	git tag -a "$RELEASE_TAG" -m "Release $RELEASE_TAG"
> +fi

fatal: ambiguous argument '3.2-rc2': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'


> -for i in $DIRS_NEED_PREFIX; do
> -	cd $i
> -	VERS=`cat VERSION`
> -	ARCHIVE=selinux-$i-$VERS.tar.gz
> -	git tag selinux-$i-$VERS > /dev/null 2>&1
> -	git archive -o ../$DEST/$ARCHIVE --prefix=selinux-$i-$VERS/ selinux-$i-$VERS
> -	cd ..
> +rm -rf "$DEST"
> +mkdir -p "$DEST"
> +
> +for COMPONENT in "${DIRS[@]}"; do
> +	DIR="${COMPONENT#selinux-}"
> +	VERS="$(cat "$DIR/VERSION")"
> +	TAG="$COMPONENT-$VERS"
> +	if git rev-parse "$TAG" > /dev/null ; then
> +		echo "Warning: tag $TAG already exists"
> +	else
> +		git tag "$TAG" > /dev/null
> +	fi

fatal: ambiguous argument 'checkpolicy-3.2-rc2': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

The following change fixes both:

--- a/scripts/release
+++ b/scripts/release
@@ -30,7 +30,7 @@ DIRS=(
        semodule-utils
 )
 
-if git rev-parse "$RELEASE_TAG" > /dev/null ; then
+if git rev-parse "$RELEASE_TAG" &> /dev/null ; then
        echo "Warning: tag $RELEASE_TAG already exists"
 else
        git tag -a "$RELEASE_TAG" -m "Release $RELEASE_TAG"
@@ -43,7 +43,7 @@ for COMPONENT in "${DIRS[@]}"; do
        DIR="${COMPONENT#selinux-}"
        VERS="$(cat "$DIR/VERSION")"
        TAG="$COMPONENT-$VERS"
-       if git rev-parse "$TAG" > /dev/null ; then
+       if git rev-parse "$TAG" &> /dev/null ; then
                echo "Warning: tag $TAG already exists"
        else
                git tag "$TAG" > /dev/null




> +	git -C "$DIR" archive -o "../$DEST/$TAG.tar.gz" --prefix="$TAG/" "$TAG"
>  done
>  
> -cd $DEST
> -
> -git add .
> +git archive -o "$DEST/selinux-${RELEASE_TAG}.tar.gz" --prefix="selinux-${RELEASE_TAG}/" "${RELEASE_TAG}"
>  
>  echo "Add the following to the $WIKIDIR/Releases.md wiki page:"
>  
> @@ -54,13 +68,24 @@ echo ""
>  echo "[short log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/shortlog-$RELEASE_TAG.txt)"
>  echo ""
>  
> -for i in *.tar.gz; do
> -
> -	echo -n "[$i](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$i) "
> -	sha256sum $i | cut -d " " -f 1
> +for COMPONENT in "${DIRS[@]}"; do
> +	DIR="${COMPONENT#selinux-}"
> +	VERS="$(cat "$DIR/VERSION")"
> +	TAG="$COMPONENT-$VERS"
> +	tarball="$TAG.tar.gz"
> +	echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$tarball) "
> +	sha256sum "$DEST/$tarball" | cut -d " " -f 1
>  	echo ""
>  done
>  
> +echo "### Source repository snapshot"
> +
> +echo ""
> +
> +echo -n "[selinux-${RELEASE_TAG}.tar.gz](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/selinux-${RELEASE_TAG}.tar.gz) "
> +sha256sum "$DEST/selinux-${RELEASE_TAG}.tar.gz" | cut -d " " -f 1
> +echo ""
> +
>  echo "And then run:"
>  echo "  cd $WIKIDIR"
>  echo "  git commit  -m \"Release $RELEASE_TAG\" -a -s"
> -- 
> 2.30.0

