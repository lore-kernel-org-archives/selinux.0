Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8643C00A89
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 08:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1F0206DC
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 08:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7pNDcnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgKBIf2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 03:35:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727902AbgKBIf1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 03:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604306126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jP7noH1PbgFSru/7lAAsyzSfcqdeniDkdv6M0r9Zj0=;
        b=a7pNDcncm8WaakYJka8QJO5qz405VZlKI/bWPV+RmhntvPh0F76FI6j6W7viFox0ARBSVD
        ikVTCFX0U7ZnPM9cu1tUVCHU4AIFMJOqYoK2gidgdZymwpIKNmSL84qtZTQVesI6N/sqFM
        j2EuQs1XpdelBZ7XZNb5tiVOLjreK6E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-5g-HdquOOsS7shpxA8yKbg-1; Mon, 02 Nov 2020 03:35:24 -0500
X-MC-Unique: 5g-HdquOOsS7shpxA8yKbg-1
Received: by mail-ej1-f71.google.com with SMTP id b17so4008221ejb.20
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 00:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+jP7noH1PbgFSru/7lAAsyzSfcqdeniDkdv6M0r9Zj0=;
        b=R9j4UTyef2OyIvnksVdtpHLxv67Hy0dXpXgpZd+jU3wqRJ3KRSzaMOIHO/q/2p/S4y
         T63H6aKs8d5k9A7zmq/LkIhGFqCv5fLQjAHo64AAUkfgdr4o7aQG044kGhdsYUz54Tee
         yHwzzbfzauaYiPTBOdqVtTr4N8ymkwkSnFJaOYA+6RZfUS4U/UnBeZh4TF46RhGeJmLv
         pBPYTSdsgEM5xdA5Uf4KlkeIY8DV+XNRyDRGMRjhvLfpm+A9nr3kdVjDDpRVJ7U3gfE/
         TSbgwYAmHrvCvGYNt96+n8/ZXNr9bkiYRA80NCNH5KC6KG/p53vvSaSUNFLyOYxzup9L
         kOPw==
X-Gm-Message-State: AOAM53374tLhlB2DzSwcF1A9iZEvIn3Hrz/iYyBQg9094oa8ie2/ydE0
        pvkQ97yHGHsAOA7c/m8WWMPzliWrM2kuONUGhRsRs9gtPkHMW5qDw7dcD3GIXmXVcQvi6GwAcl/
        fsf/gipUsu2xJUobE5g==
X-Received: by 2002:a17:906:4753:: with SMTP id j19mr13089107ejs.65.1604306122689;
        Mon, 02 Nov 2020 00:35:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnFGePp/VQNizs5E3l2VLwHYup/DFGjAV80Lzb/1DSO2+C4yOWt29WoMe1wpiKRCIaOhdlAw==
X-Received: by 2002:a17:906:4753:: with SMTP id j19mr13089098ejs.65.1604306122527;
        Mon, 02 Nov 2020 00:35:22 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id bk13sm9293716ejb.58.2020.11.02.00.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:35:21 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH testsuite v2 3/4] tests/[fs_]filesystem: fix unwanted error output when testing vfat
Date:   Mon,  2 Nov 2020 09:35:15 +0100
Message-Id: <20201102083516.477149-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102083516.477149-1-omosnace@redhat.com>
References: <20201102083516.477149-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The tests currently output "fsetfilecon(3) Failed: Operation not
supported" during a clean run. Since testing that fsetfilecon(3) returns
-EOPNOTSUPP on vfat is not all that useful, rather than conditionally
silencing the error output, just skip the fsetfilecon(3) tests for vfat.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/filesystem/test    | 30 +++++++++++++++---------------
 tests/fs_filesystem/test | 30 +++++++++++++++---------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/tests/filesystem/test b/tests/filesystem/test
index 7d4654d..5a9f0f6 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -104,6 +104,9 @@ BEGIN {
     }
     elsif ($vfat_enabled) {
 
+        # For setfilecon tests as not supported
+        $test_count -= 2;
+
         # For hooks.c may_create() FILESYSTEM__ASSOCIATE as not supported
         $test_count -= 3;
 
@@ -243,15 +246,12 @@ if ($test_type_trans) {
     ok( $result eq 0 );
 }
 
-print "Creating 'test_file' and changing its context via setfilecon(3)\n";
-$result =
-  system(
+if ( not $vfat_enabled ) {
+    print "Creating 'test_file' and changing its context via setfilecon(3)\n";
+    $result =
+      system(
 "runcon -t test_filesystem_t $basedir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
-  );
-if ($vfat_enabled) {
-    ok( $result >> 8 eq 95 );    # EOPNOTSUPP
-}
-else {
+      );
     ok( $result eq 0 );
 }
 
@@ -981,16 +981,16 @@ if ( not $nfs_enabled ) {
     ok( $result eq 0 );
 
     # Create file with 'test_filesystem_filecon_t' context
-    print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-    $result =
-      system(
+    if ( not $vfat_enabled ) {
+        print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+        $result =
+          system(
 "runcon -t test_filesystem_context_t $basedir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
-      );
-    if ($vfat_enabled) {
-        ok( $result >> 8 eq 95 );    # EOPNOTSUPP
+          );
+        ok( $result eq 0 );
     }
     else {
-        ok( $result eq 0 );
+        system("touch $private_path/mp1/test_file");
     }
 
     print "Unmount filesystem from $basedir/mntpoint/mp1\n";
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 5dedf83..4462438 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -112,6 +112,9 @@ BEGIN {
     }
     elsif ($vfat_enabled) {
 
+        # For setfilecon tests as not supported
+        $test_count -= 2;
+
         # For hooks.c may_create() FILESYSTEM__ASSOCIATE as not supported
         $test_count -= 3;
 
@@ -243,15 +246,12 @@ if ($test_type_trans) {
     ok( $result eq 0 );
 }
 
-print "Creating 'test_file' and changing its context via setfilecon(3)\n";
-$result =
-  system(
+if ( not $vfat_enabled ) {
+    print "Creating 'test_file' and changing its context via setfilecon(3)\n";
+    $result =
+      system(
 "runcon -t test_filesystem_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
-  );
-if ($vfat_enabled) {
-    ok( $result >> 8 eq 95 );    # EOPNOTSUPP
-}
-else {
+      );
     ok( $result eq 0 );
 }
 
@@ -1010,16 +1010,16 @@ if ( not $nfs_enabled ) {
     ok( $result eq 0 );
 
     # Create file with 'test_filesystem_filecon_t' context
-    print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-    $result =
-      system(
+    if ( not $vfat_enabled ) {
+        print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+        $result =
+          system(
 "runcon -t test_filesystem_context_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
-      );
-    if ($vfat_enabled) {
-        ok( $result >> 8 eq 95 );    # EOPNOTSUPP
+          );
+        ok( $result eq 0 );
     }
     else {
-        ok( $result eq 0 );
+        system("touch $private_path/mp1/test_file");
     }
 
     print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-- 
2.26.2

