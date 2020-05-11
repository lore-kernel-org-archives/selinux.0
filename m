Return-Path: <SRS0=Gc5K=6Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9FBC54E8D
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 12:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F988206D5
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 12:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xrh9ioOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgEKMDo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 May 2020 08:03:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34550 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729782AbgEKMDm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 May 2020 08:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589198620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qlX+2yKfkAS1/QYW6KAlaROgMZdAUEwKGbcgun6ZPjg=;
        b=Xrh9ioOAPcIEyZGuDImOFNeTr3aRdh7bkm1Ks75lDN7tnd1DL6oNtOJJbYt1hQ4Rgv57c9
        H052/tD+N3ta3r1jOxUz5aIq7dJAgaGNq60tQB5+ClvBGbJGLFqZiQwcbZO9aKB8ajDZFF
        rs/f48T6jS3oN+DCfUm8IPIMWL5oRJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-Kr7846pnNrywDbwnXa3VCw-1; Mon, 11 May 2020 08:03:38 -0400
X-MC-Unique: Kr7846pnNrywDbwnXa3VCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 434FFEC1A5
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7915D60BE2;
        Mon, 11 May 2020 12:03:36 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] run-flake8: Filter out ./.git/ directory
Date:   Mon, 11 May 2020 14:03:32 +0200
Message-Id: <20200511120332.26029-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When a branch has '.py' suffix git creates a file with the same suffix and this
file is found by the `find . -name '*.py'` command. Such files from './git' need
to be filtered out.

Fixes:

    $ PATH="$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8
    Analyzing 189 Python scripts
    ./.git/logs/refs/heads/semanage-test.py:1:42: E999 SyntaxError: invalid syntax
    ./.git/refs/heads/semanage-test.py:1:4: E999 SyntaxError: invalid syntax
    The command "PATH="$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8" exited with 1.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 scripts/run-flake8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-flake8 b/scripts/run-flake8
index 24b1202fde99..67cccfe99e5f 100755
--- a/scripts/run-flake8
+++ b/scripts/run-flake8
@@ -7,7 +7,7 @@ if [ $# -eq 0 ] ; then
 
     # Run on both files ending with .py and Python files without extension
     # shellcheck disable=SC2046
-    set -- $( (find . -name '*.py' ; grep --exclude-dir=.git -l -e '^#!\s*/usr/bin/python' -e '^#!/usr/bin/env python' -r .) | sort -u )
+    set -- $( (find . -name '*.py' ; grep -l -e '^#!\s*/usr/bin/python' -e '^#!/usr/bin/env python' -r .) | grep -v '^\./\.git/' | sort -u )
     echo "Analyzing $# Python scripts"
 fi
 
-- 
2.26.2

