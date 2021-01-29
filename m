Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A54DC433DB
	for <selinux@archiver.kernel.org>; Fri, 29 Jan 2021 20:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE96F61492
	for <selinux@archiver.kernel.org>; Fri, 29 Jan 2021 20:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhA2UGX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:06:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233129AbhA2UCV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jan 2021 15:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611950442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kzlpXBXLDpoR8wascPiVhXuZImo4m6XUODbq0/ex+TI=;
        b=cJbXMoH+Qka7OHYXkljqFl6rQAjVKQJtILpuG2TWklBFHzDBDuXf96Dp6TTQ0bP4Qk0gPz
        B8ALO540rD9+AVu+/UVV4IJFHvxlLKuPOgnfsYFK8OjCprY0RsJG7CRyavVfK67CZuuOoD
        0lBtWwJXyfnxcTUcKbCzcIOskFFf/6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-Bx8cIQu5MeS2j7UCNSyoCw-1; Fri, 29 Jan 2021 15:00:40 -0500
X-MC-Unique: Bx8cIQu5MeS2j7UCNSyoCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22BB280670E
        for <selinux@vger.kernel.org>; Fri, 29 Jan 2021 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4506860BE2;
        Fri, 29 Jan 2021 20:00:38 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] scripts/release: Release also tarball with everything
Date:   Fri, 29 Jan 2021 21:00:34 +0100
Message-Id: <20210129200034.205263-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create and publish with sha256sum also tarball called
selinux-$VERS.tar.gz with the whole tree. It could be useful for unit
testing directly from tarball or backporting patches which affects more
subdirectories. Github already provides similar archive called "Source
code (tar.gz)" via release assets, but there's no guarantee this file
would not change.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 scripts/release | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/scripts/release b/scripts/release
index 895a0e1ca1a1..40a9c06f56b9 100755
--- a/scripts/release
+++ b/scripts/release
@@ -35,6 +35,8 @@ for i in $DIRS_NEED_PREFIX; do
 	cd ..
 done
 
+git archive -o $DEST/selinux-$VERS.tar.gz --prefix=selinux-$VERS/ $VERS
+
 cd $DEST
 
 git add .
@@ -54,13 +56,28 @@ echo ""
 echo "[short log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/shortlog-$RELEASE_TAG.txt)"
 echo ""
 
-for i in *.tar.gz; do
+for i in $DIRS; do
+	tarball=$i-$VERS.tar.gz
+	echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$tarball) "
+	sha256sum $tarball | cut -d " " -f 1
+	echo ""
+done
 
-	echo -n "[$i](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$i) "
-	sha256sum $i | cut -d " " -f 1
+for i in $DIRS_NEED_PREFIX; do
+	tarball=selinux-$i-$VERS.tar.gz
+	echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$tarball) "
+	sha256sum $tarball | cut -d " " -f 1
 	echo ""
 done
 
+echo "### Everything"
+
+echo ""
+
+echo -n "[selinux-$VERS.tar.gz](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/selinux-$VERS.tar.gz) "
+sha256sum selinux-$VERS.tar.gz | cut -d " " -f 1
+echo ""
+
 echo "And then run:"
 echo "  cd $WIKIDIR"
 echo "  git commit  -m \"Release $RELEASE_TAG\" -a -s"
-- 
2.30.0

