Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03773C19F2B
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiG2MDD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiG2MDB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B646A863DF
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SjOKJ5pSp0I4W+1qNscXMbSk+FLgh9TnZgXIW9UlBWY=;
        b=OojxMi98ynBE1QNZ9Rqlfbmg1MkP9Bu9hwYDUC+NgfAHdg/6hG0K9FJblk7wDKugw5Q/dX
        L+sPc1oyudGy0lB+xpYeFYgX/7AneX8H9RvJdxT16ryBBtAXCmKK1cnvX+yRvatKWdrjPT
        N75VtiGy0OBcLUig2QawkATTfZthwZk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-5oo-vK3GNwq_OhR53Y7HBw-1; Fri, 29 Jul 2022 08:02:57 -0400
X-MC-Unique: 5oo-vK3GNwq_OhR53Y7HBw-1
Received: by mail-wm1-f69.google.com with SMTP id r8-20020a1c4408000000b003a2fdeea756so3431556wma.2
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=SjOKJ5pSp0I4W+1qNscXMbSk+FLgh9TnZgXIW9UlBWY=;
        b=eirQw+wkOqZfmgQvCbiGoFxXmoA/2Wr0cruYTHUHEkWE0gxzQnn8qj6MiXOGBe4Nq8
         f0Wqcjsiq/1rfI+GjSi7NjzFXrJEIHK2SWXLxSVeo/hWLIL4omxiJy79/SeXzoRLwPxd
         7GNiQ6VEik8B82Jyss06smGd4P2fvACLeWHOgLAvUdtV0HiY+l1NO/3NHv/O3Po3ZAjj
         iJgz0SxmmWF1obL9XzH+r3I74SmubyxG5fAeacumbzB4D30WKUz4e3SjBKZhm7KKPS29
         raaX/6eBuHxh4Fc4JXv8HepqPmoXwkKiTUmtg5LHd3oVP4dywQEPWLoicw36CCVyQCCZ
         6AOw==
X-Gm-Message-State: ACgBeo3q70gi0ArKbvYciswDzUGjJkOzpZceqy04cbnhfFtOj9ehjdjr
        TKhF1npfAigOwfUvd78lJB3qWP6AgyxqLvIH6+mqDc6cMj8LCKk8bO4r7D8Lw7TzTt36Tt+clQv
        zPoLtcJPHYlBz3bO0NxhBndi40e/H0n5d8coaGW0Z0WQKRjUFaoI0wg2I5S3g4UAC0+PSBw==
X-Received: by 2002:a5d:624e:0:b0:21e:bd15:3e11 with SMTP id m14-20020a5d624e000000b0021ebd153e11mr2262085wrv.431.1659096175977;
        Fri, 29 Jul 2022 05:02:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6306bqtAGVYcHzngd1MsFLzM3QGjvABdRw6JhLshEcHEyAGwjNdIoFo8doU/7ZoEK2a1oj9Q==
X-Received: by 2002:a5d:624e:0:b0:21e:bd15:3e11 with SMTP id m14-20020a5d624e000000b0021ebd153e11mr2262058wrv.431.1659096175478;
        Fri, 29 Jul 2022 05:02:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:54 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 15/24] tests/*filesystem: remove weird uses of unconfined_t
Date:   Fri, 29 Jul 2022 14:02:20 +0200
Message-Id: <20220729120229.207584-16-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It seems more logical to drop the associate permission for test_file_t
from the *_no_associate_t domains and use test_file_t in the tests
instead of unconfined_t. This also fixes the tests as they weren't
testing the associate permission (as the comments say), but in fact they
were failing on the lack of relabelto unconfined_t permission instead.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_filesystem.te | 8 ++------
 tests/filesystem/test     | 4 ++--
 tests/fs_filesystem/test  | 4 ++--
 tests/nfs_filesystem/test | 4 ++--
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index d8c5c51..59eac2b 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -356,16 +356,12 @@ allow test_filesystem_may_create_no_associate_t nfs_t:filesystem { associate };
 allow test_filesystem_may_create_no_associate_t test_file_t:dir { add_name };
 allow test_filesystem_may_create_no_associate_t test_file_t:file { create write relabelfrom };
 allow test_filesystem_may_create_no_associate_t test_filesystem_file_t:filesystem { mount unmount relabelto };
-allow test_file_t test_filesystem_may_create_no_associate_t:filesystem { associate };
-allow unconfined_t test_filesystem_may_create_no_associate_t:filesystem { getattr mount relabelto unmount };
-# neverallow unconfined_t test_filesystem_may_create_no_associate_t:filesystem { associate };
+# neverallow test_file_t test_filesystem_may_create_no_associate_t:filesystem { associate };
 
 allow test_filesystem_inode_setxattr_no_associate_t nfs_t:filesystem { associate };
 allow test_filesystem_inode_setxattr_no_associate_t test_file_t:dir { add_name };
 allow test_filesystem_inode_setxattr_no_associate_t test_file_t:file { create relabelfrom write };
-allow test_file_t test_filesystem_inode_setxattr_no_associate_t:filesystem { associate };
-allow unconfined_t test_filesystem_inode_setxattr_no_associate_t:filesystem { getattr mount relabelfrom relabelto unmount };
-# neverallow unconfined_t test_filesystem_inode_setxattr_no_associate_t:filesystem { associate };
+# neverallow test_file_t test_filesystem_inode_setxattr_no_associate_t:filesystem { associate };
 
 #
 ############### Rules for NFS mount ##################
diff --git a/tests/filesystem/test b/tests/filesystem/test
index c94deda..382923a 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -476,7 +476,7 @@ if ( not $nfs_enabled and not $vfat_enabled ) {
 
     print "Creating test file $basedir/mntpoint/mp1/test_file\n";
     $result = system(
-"runcon -t test_filesystem_may_create_no_associate_t $basedir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
+"runcon -t test_filesystem_may_create_no_associate_t $basedir/create_file_change_context -t test_file_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
     );
     ok( $result >> 8 eq 13 );    # EACCES
 
@@ -783,7 +783,7 @@ if ( not $nfs_enabled and not $vfat_enabled ) {
     ok( $result eq 0 );
 
     $result = system(
-"runcon -t test_filesystem_inode_setxattr_no_associate_t $basedir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
+"runcon -t test_filesystem_inode_setxattr_no_associate_t $basedir/create_file_change_context -t test_file_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
     );
     ok( $result >> 8 eq 13 );    # EACCES
 
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index e706e42..9917c41 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -504,7 +504,7 @@ if ( not $nfs_enabled and not $vfat_enabled ) {
 
     print "Creating test file $basedir/mntpoint/mp1/test_file\n";
     $result = system(
-"runcon -t test_filesystem_may_create_no_associate_t $filesystem_dir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
+"runcon -t test_filesystem_may_create_no_associate_t $filesystem_dir/create_file_change_context -t test_file_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
     );
     ok( $result >> 8 eq 13 );    # EACCES
 
@@ -813,7 +813,7 @@ if ( not $nfs_enabled and not $vfat_enabled ) {
     ok( $result eq 0 );
 
     $result = system(
-"runcon -t test_filesystem_inode_setxattr_no_associate_t $filesystem_dir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
+"runcon -t test_filesystem_inode_setxattr_no_associate_t $filesystem_dir/create_file_change_context -t test_file_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
     );
     ok( $result >> 8 eq 13 );    # EACCES
 
diff --git a/tests/nfs_filesystem/test b/tests/nfs_filesystem/test
index e43da67..fc8d525 100755
--- a/tests/nfs_filesystem/test
+++ b/tests/nfs_filesystem/test
@@ -240,7 +240,7 @@ while ( $i < 2 ) {
     ok( $result eq 0, $test_msg );
 
     $result = system(
-"runcon -t test_filesystem_may_create_no_associate_t $filesystem_dir/create_file_change_context $v -t unconfined_t -f $target/tests/nfs_filesystem/mntpoint/mp1/test_file 2>&1"
+"runcon -t test_filesystem_may_create_no_associate_t $filesystem_dir/create_file_change_context $v -t test_file_t -f $target/tests/nfs_filesystem/mntpoint/mp1/test_file 2>&1"
     );
     ok( $result >> 8 eq 13, $test_msg );    # EACCES
 
@@ -264,7 +264,7 @@ while ( $i < 2 ) {
     ok( $result eq 0, $test_msg );
 
     $result = system(
-"runcon -t test_filesystem_inode_setxattr_no_associate_t $filesystem_dir/create_file_change_context $v -t unconfined_t -f $target/tests/nfs_filesystem/mntpoint/mp1/test_file 2>&1"
+"runcon -t test_filesystem_inode_setxattr_no_associate_t $filesystem_dir/create_file_change_context $v -t test_file_t -f $target/tests/nfs_filesystem/mntpoint/mp1/test_file 2>&1"
     );
     ok( $result >> 8 eq 13, $test_msg );    # EACCES
 
-- 
2.37.1

