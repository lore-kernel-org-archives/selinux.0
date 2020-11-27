Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A951C2D0E4
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 08:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A291222249
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 08:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIa4FkU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgK0Ixm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Nov 2020 03:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbgK0Ixl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Nov 2020 03:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606467221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XhLrTNGBUIFJ3bPY5sqxzMKSdYXFlfsm4mww8eWC1ME=;
        b=jIa4FkU3HT/el8Nv72GPfeUogJzYfN3gPntPbPGWC/0ITrECvgNM7MPqjGtG7LqVMs/a6M
        P8Hvu08QN7936RabIV6zCw2LdHuYUPPoZNg8aubzQwYjC8WUzl/X3W5SjyV9ypbDg2i3vK
        rj2CxjfK9ggtq4DPYLFTDofRhEP1dOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-bJcehTICOvebwvVugRG9Ow-1; Fri, 27 Nov 2020 03:53:36 -0500
X-MC-Unique: bJcehTICOvebwvVugRG9Ow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DD8B1005D5C;
        Fri, 27 Nov 2020 08:53:35 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.193.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A65DD19C46;
        Fri, 27 Nov 2020 08:53:34 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Hu Keping <hukeping@huawei.com>
Subject: [PATCH 3/3] Simplify the tarball generating scripts
Date:   Fri, 27 Nov 2020 09:52:21 +0100
Message-Id: <20201127085220.813760-4-plautrba@redhat.com>
In-Reply-To: <20201127085220.813760-1-plautrba@redhat.com>
References: <20201127085220.813760-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Hu Keping <hukeping@huawei.com>

Since the format of git archive is inferred from the output file,
it's safe to remove the pipe for gzip.

Signed-off-by: Hu Keping <hukeping@huawei.com>
---
 scripts/release | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/release b/scripts/release
index 040aaf68e86a..895a0e1ca1a1 100755
--- a/scripts/release
+++ b/scripts/release
@@ -22,7 +22,7 @@ for i in $DIRS; do
 	VERS=`cat VERSION`
 	ARCHIVE=$i-$VERS.tar.gz
 	git tag $i-$VERS > /dev/null 2>&1
-	git archive --format=tar --prefix=$i-$VERS/ $i-$VERS | gzip > ../$DEST/$ARCHIVE
+	git archive -o ../$DEST/$ARCHIVE --prefix=$i-$VERS/ $i-$VERS
 	cd ..
 done
 
@@ -31,7 +31,7 @@ for i in $DIRS_NEED_PREFIX; do
 	VERS=`cat VERSION`
 	ARCHIVE=selinux-$i-$VERS.tar.gz
 	git tag selinux-$i-$VERS > /dev/null 2>&1
-	git archive --format=tar --prefix=selinux-$i-$VERS/ selinux-$i-$VERS | gzip > ../$DEST/$ARCHIVE
+	git archive -o ../$DEST/$ARCHIVE --prefix=selinux-$i-$VERS/ selinux-$i-$VERS
 	cd ..
 done
 
-- 
2.29.2

