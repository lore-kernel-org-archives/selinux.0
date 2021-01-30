Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353A8C433E0
	for <selinux@archiver.kernel.org>; Sat, 30 Jan 2021 13:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B20B64DCC
	for <selinux@archiver.kernel.org>; Sat, 30 Jan 2021 13:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhA3NeV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 30 Jan 2021 08:34:21 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:38781 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhA3NeR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 30 Jan 2021 08:34:17 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B8236564ECF;
        Sat, 30 Jan 2021 14:33:34 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 1/1] scripts/release: make the script more robust and direct
Date:   Sat, 30 Jan 2021 14:33:13 +0100
Message-Id: <20210130133313.1759011-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan 30 14:33:35 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

- Fix many warnings reported by shellcheck, by quoting strings.
- Use bash arrays for DIRS and DIRS_NEED_PREFIX
- Merge DIRS and DIRS_NEED_PREFIX into a single array, in order to
  produce SHA256 digests that are directly in alphabetical order, for
  https://github.com/SELinuxProject/selinux/wiki/Releases
- Use "set -e" in order to fail as soon as a command fails
- Change to the top-level directory at the start of the script, in order
  to be able to run it from anywhere.
- Use `cat $DIR/VERSION` and `git -C $DIR` instead of `cd $i ; cat VERSION`
  in order to prevent unexpected issues from directory change.

Finally, if version tags already exists, re-use them. This enables using
this script to re-generate the release archive (and check that they
really match the git repository). Currently, running scripts/release
will produce the same archives as the ones published in the 3.2-rc1
release (with the same SHA256 digests as the ones on the release page,
https://github.com/SELinuxProject/selinux/wiki/Releases). This helps to
ensure that the behaviour of the script is still fine.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
This patch is to be applied after
https://lore.kernel.org/selinux/20210129200034.205263-1-plautrba@redhat.com/

 scripts/release | 98 ++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 45 deletions(-)

diff --git a/scripts/release b/scripts/release
index 40a9c06f56b9..b8bd478da024 100755
--- a/scripts/release
+++ b/scripts/release
@@ -1,45 +1,57 @@
 #!/bin/bash
 
-PWD=`pwd`
-WIKIDIR=../selinux.wiki
-
-if [ \! -d $WIKIDIR ]; then
-    git clone git@github.com:SELinuxProject/selinux.wiki.git $WIKIDIR
-fi
+# Fail when a command fails
+set -e
 
-RELEASE_TAG=`cat VERSION`
-DEST=releases/$RELEASE_TAG
-DIRS="libsepol libselinux libsemanage checkpolicy secilc policycoreutils mcstrans restorecond semodule-utils"
-DIRS_NEED_PREFIX="dbus gui python sandbox"
+# Ensure the script is running from the top level directory
+cd "$(dirname -- "$0")/.."
 
-git tag -a $RELEASE_TAG -m "Release $RELEASE_TAG"
+WIKIDIR=../selinux.wiki
 
-rm -rf $DEST
-mkdir -p $DEST
+if ! [ -d "$WIKIDIR" ]; then
+	git clone git@github.com:SELinuxProject/selinux.wiki.git "$WIKIDIR"
+fi
 
-for i in $DIRS; do
-	cd $i
-	VERS=`cat VERSION`
-	ARCHIVE=$i-$VERS.tar.gz
-	git tag $i-$VERS > /dev/null 2>&1
-	git archive -o ../$DEST/$ARCHIVE --prefix=$i-$VERS/ $i-$VERS
-	cd ..
-done
+RELEASE_TAG="$(cat VERSION)"
+DEST="releases/$RELEASE_TAG"
+DIRS=(
+	checkpolicy
+	libselinux
+	libsemanage
+	libsepol
+	mcstrans
+	policycoreutils
+	restorecond
+	secilc
+	selinux-dbus
+	selinux-gui
+	selinux-python
+	selinux-sandbox
+	semodule-utils
+)
+
+if git rev-parse "$RELEASE_TAG" > /dev/null ; then
+	echo "Warning: tag $RELEASE_TAG already exists"
+else
+	git tag -a "$RELEASE_TAG" -m "Release $RELEASE_TAG"
+fi
 
-for i in $DIRS_NEED_PREFIX; do
-	cd $i
-	VERS=`cat VERSION`
-	ARCHIVE=selinux-$i-$VERS.tar.gz
-	git tag selinux-$i-$VERS > /dev/null 2>&1
-	git archive -o ../$DEST/$ARCHIVE --prefix=selinux-$i-$VERS/ selinux-$i-$VERS
-	cd ..
+rm -rf "$DEST"
+mkdir -p "$DEST"
+
+for COMPONENT in "${DIRS[@]}"; do
+	DIR="${COMPONENT#selinux-}"
+	VERS="$(cat "$DIR/VERSION")"
+	TAG="$COMPONENT-$VERS"
+	if git rev-parse "$TAG" > /dev/null ; then
+		echo "Warning: tag $TAG already exists"
+	else
+		git tag "$TAG" > /dev/null
+	fi
+	git -C "$DIR" archive -o "../$DEST/$TAG.tar.gz" --prefix="$TAG/" "$TAG"
 done
 
-git archive -o $DEST/selinux-$VERS.tar.gz --prefix=selinux-$VERS/ $VERS
-
-cd $DEST
-
-git add .
+git archive -o "$DEST/selinux-${RELEASE_TAG}.tar.gz" --prefix="selinux-${RELEASE_TAG}/" "${RELEASE_TAG}"
 
 echo "Add the following to the $WIKIDIR/Releases.md wiki page:"
 
@@ -56,17 +68,13 @@ echo ""
 echo "[short log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/shortlog-$RELEASE_TAG.txt)"
 echo ""
 
-for i in $DIRS; do
-	tarball=$i-$VERS.tar.gz
-	echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$tarball) "
-	sha256sum $tarball | cut -d " " -f 1
-	echo ""
-done
-
-for i in $DIRS_NEED_PREFIX; do
-	tarball=selinux-$i-$VERS.tar.gz
+for COMPONENT in "${DIRS[@]}"; do
+	DIR="${COMPONENT#selinux-}"
+	VERS="$(cat "$DIR/VERSION")"
+	TAG="$COMPONENT-$VERS"
+	tarball="$TAG.tar.gz"
 	echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$tarball) "
-	sha256sum $tarball | cut -d " " -f 1
+	sha256sum "$DEST/$tarball" | cut -d " " -f 1
 	echo ""
 done
 
@@ -74,8 +82,8 @@ echo "### Everything"
 
 echo ""
 
-echo -n "[selinux-$VERS.tar.gz](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/selinux-$VERS.tar.gz) "
-sha256sum selinux-$VERS.tar.gz | cut -d " " -f 1
+echo -n "[selinux-${RELEASE_TAG}.tar.gz](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/selinux-${RELEASE_TAG}.tar.gz) "
+sha256sum "$DEST/selinux-${RELEASE_TAG}.tar.gz" | cut -d " " -f 1
 echo ""
 
 echo "And then run:"
-- 
2.30.0

