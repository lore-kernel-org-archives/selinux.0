Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5612FC433E6
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E8964EAA
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBAOdo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:33:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230193AbhBAOdn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Feb 2021 09:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612189937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bwJoNorL6hqWwlYb4sGD12idD9v9uN0FkIXrPi2DLwc=;
        b=d6DcEAEtmTUkWW6z/JDqmtoOQ9Bvb1OuavxX3TTWqr1RrJUKIA09VG5f3TiUtCYOAhOw3y
        e95zbLGZ2H3nbd6JucXv9pslqd0+vI8J3ZjJk0rqb86o+zVtXeFHKZkoIK9BPv9dOUZrTB
        PyFcF2CcshNKK5Qv5bKBJTFOJB+djx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-gUO9nSTEM6mCxrTmvwYZgg-1; Mon, 01 Feb 2021 09:32:15 -0500
X-MC-Unique: gUO9nSTEM6mCxrTmvwYZgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73E4E107ACF5;
        Mon,  1 Feb 2021 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1208E9473;
        Mon,  1 Feb 2021 14:32:11 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: [PATCH] policycoreutils/setfiles: Drop unused nerr variable
Date:   Mon,  1 Feb 2021 15:32:06 +0100
Message-Id: <20210201143206.389547-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Suggested-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/setfiles/setfiles.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 92616571ef2a..f018d161aa9e 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -19,7 +19,6 @@ static int warn_no_match;
 static int null_terminated;
 static int request_digest;
 static struct restore_opts r_opts;
-static int nerr;
 
 #define STAT_BLOCK_SIZE 1
 
@@ -161,7 +160,6 @@ int main(int argc, char **argv)
 	warn_no_match = 0;
 	request_digest = 0;
 	policyfile = NULL;
-	nerr = 0;
 
 	r_opts.abort_on_error = 0;
 	r_opts.progname = strdup(argv[0]);
@@ -427,9 +425,6 @@ int main(int argc, char **argv)
 	r_opts.selabel_opt_digest = (request_digest ? (char *)1 : NULL);
 	r_opts.selabel_opt_path = altpath;
 
-	if (nerr)
-		exit(-1);
-
 	restore_init(&r_opts);
 
 	if (use_input_file) {
-- 
2.30.0

