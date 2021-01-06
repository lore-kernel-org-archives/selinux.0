Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62975C433E0
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE2623100
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 09:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbhAFJBl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:01:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbhAFJBl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 04:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609923615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbOF0GBe97qcnKP/14PPYVZNZ5OhyuiaNRtMRjVyhpw=;
        b=aGm/a140LOo3goCN4YY1dvgY8sdjtv7BaG8TwbsNXzhqUgmX9ieGdJWNUlirqpRFNRIFg3
        AhWWYw+sniM7KEyGNS5wbvg3Ko5noXqIghwXUXu1vrKFgdf6cW/bz+lo8HzaSxAxKKV0L6
        RUBtkTdPj8xa3sDPoU4D/ee3ciSoK6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-Y_N-iVjNPw22BxsNy5LflQ-1; Wed, 06 Jan 2021 04:00:13 -0500
X-MC-Unique: Y_N-iVjNPw22BxsNy5LflQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 813E539388
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 09:00:12 +0000 (UTC)
Received: from thinkpad-work.redhat.com (unknown [10.40.193.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE42860BE2
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 09:00:11 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] python/semanage: Sort imports in alphabetical order
Date:   Wed,  6 Jan 2021 10:00:07 +0100
Message-Id: <20210106090007.176771-1-vmojzis@redhat.com>
In-Reply-To: <CAJfZ7==efgpSLs-U81UEp-0ven0mr3WZMLpP1+1XC8a-ww0uSg@mail.gmail.com>
References: <CAJfZ7==efgpSLs-U81UEp-0ven0mr3WZMLpP1+1XC8a-ww0uSg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/semanage | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index ce15983b..125271df 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -23,11 +23,13 @@
 #
 #
 
-import traceback
 import argparse
+import os
+import re
 import seobject
 import sys
-import os
+import traceback
+
 PROGNAME = "policycoreutils"
 try:
     import gettext
@@ -798,8 +800,6 @@ def setupExportParser(subparsers):
     exportParser.add_argument('-f', '--output_file', dest='output_file', action=SetExportFile, help=_('Output file'))
     exportParser.set_defaults(func=handleExport)
 
-import re
-
 
 def mkargv(line):
     dquote = "\""
-- 
2.29.2

