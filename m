Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21CEC7EE2F
	for <selinux@archiver.kernel.org>; Fri,  3 Mar 2023 14:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCCOJ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Mar 2023 09:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjCCOJv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Mar 2023 09:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1402CC55
        for <selinux@vger.kernel.org>; Fri,  3 Mar 2023 06:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677852542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FwScJTD1hNgmOM00GgqSTpfBFJvArfgtsQpmo3/eHaI=;
        b=G8la4WHoLU6DrPyNdnI0TxKgy2sxZwHvBvkN0CZbeTXDqonVw5du17fabToYXaan2mI7yL
        Y+kXU+/8eaL91++iAcQlSbMe+V1EGVLdNYEO2BJX6eLzueaCjMPKmvUKyfjwKoBJrsDGBQ
        rT3dse/wmR8qz39n8YOJM1k89HQdcV8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-06dEAPp5PlSgDGwgyrb7Ug-1; Fri, 03 Mar 2023 09:09:01 -0500
X-MC-Unique: 06dEAPp5PlSgDGwgyrb7Ug-1
Received: by mail-wr1-f72.google.com with SMTP id m10-20020adfe94a000000b002cdc5eac0d0so410576wrn.2
        for <selinux@vger.kernel.org>; Fri, 03 Mar 2023 06:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwScJTD1hNgmOM00GgqSTpfBFJvArfgtsQpmo3/eHaI=;
        b=bxQLDw+SpGlWbXHaXy7LHzS3nJ5GUaR7/oYrzLZppnRReqyAh/Ikj4ijylbQ5gtxjE
         93nBTvIXWEGAZ+yWYRIVd5InyzZ+trkAGkUxwDy7EU70xqIpVFIN9uPKMmW+P8rsUPuz
         Wsh0oiLjRJxk4VxhvknjjR/2yXrFh17sACVx8knMIcFkz1S2QtoqgJRGldnu5458pX3r
         kw/bviFDbhbDmfw0qcECeIbfuJtmPYEf7RzuABjaP04G2DIAD5vbl65u9AObUGHG4XsY
         kbXGaZvdVEeCiOzhc1K0S6wf1Z4IOwMyN2mm7Kh2IHgd4zfuUWn2xt+6odf7orHtfoAU
         2Veg==
X-Gm-Message-State: AO0yUKXH+6cDRMv+dLQMug5dSQ0StanhH1a/wM0xyq88jGOJZJ7XcrUU
        APyQuzSUh3M/54elO6f/MvfXniAsDYp/2qbtIe5161UfPGFsikzELi3nza3aDQClG7Pp9FVUMsF
        8C0nF1+uEl/M+dDpQLSA6VTfpf7ft+17F6bFb7ZSmaRlTKlkun92dOhsHxp7MBI88kk7K0BG8+P
        LbYA==
X-Received: by 2002:a05:600c:1c9c:b0:3ea:4af0:3475 with SMTP id k28-20020a05600c1c9c00b003ea4af03475mr1846908wms.1.1677852539857;
        Fri, 03 Mar 2023 06:08:59 -0800 (PST)
X-Google-Smtp-Source: AK7set+zOTZIT5yakKOtUEioun6kZuzaxBKoWCCHypcmKUDyW4RRnWJe/DnUf1aKGkrUTS7ISTd4LQ==
X-Received: by 2002:a05:600c:1c9c:b0:3ea:4af0:3475 with SMTP id k28-20020a05600c1c9c00b003ea4af03475mr1846851wms.1.1677852539172;
        Fri, 03 Mar 2023 06:08:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c41d100b003dc4fd6e624sm2423650wmh.19.2023.03.03.06.08.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 06:08:58 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 3/3] tests/infiniband*: simplify test activation
Date:   Fri,  3 Mar 2023 15:08:53 +0100
Message-Id: <20230303140853.1276325-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303140853.1276325-1-omosnace@redhat.com>
References: <20230303140853.1276325-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use Test::More and skip_all to enable/disable these tests if they are
configured instead of doing this in the Makefile via grep.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 Vagrantfile                   |  1 +
 tests/Makefile                | 11 ++-------
 tests/infiniband_endport/test | 39 ++++++++++++++++++-------------
 tests/infiniband_pkey/test    | 44 ++++++++++++++++++++---------------
 4 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/Vagrantfile b/Vagrantfile
index 6f7675f..682b805 100644
--- a/Vagrantfile
+++ b/Vagrantfile
@@ -89,6 +89,7 @@ EOF
       e2fsprogs \
       jfsutils \
       dosfstools \
+      rdma-core-devel \
       #{kernel_pkgs}
 
     #{extra_commands}
diff --git a/tests/Makefile b/tests/Makefile
index 5998a9f..74df247 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -27,7 +27,8 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
-	inet_socket overlay checkreqprot mqueue mac_admin atsecure
+	inet_socket overlay checkreqprot mqueue mac_admin atsecure \
+	infiniband_endport infiniband_pkey
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
@@ -82,14 +83,6 @@ endif # POL_VERS
 endif # POL_TYPE
 endif # MAX_KERNEL_POLICY
 
-ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST=" infiniband_endport/ibendport_test.conf | cut -d'=' -f 2),1)
-SUBDIRS += infiniband_endport
-endif
-
-ifeq ($(shell grep "^SELINUX_INFINIBAND_PKEY_TEST=" infiniband_pkey/ibpkey_test.conf | cut -d'=' -f 2),1)
-SUBDIRS += infiniband_pkey
-endif
-
 ifneq ($(shell ./kvercmp $$(uname -r) 5.2),-1)
 SUBDIRS += cgroupfs_label
 endif
diff --git a/tests/infiniband_endport/test b/tests/infiniband_endport/test
index f071fbc..c55ce84 100755
--- a/tests/infiniband_endport/test
+++ b/tests/infiniband_endport/test
@@ -1,25 +1,32 @@
 #!/usr/bin/perl
 
-use Test;
+use Test::More;
 
-BEGIN { plan tests => 3 }
+my %conf;
 
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $confpath = $basedir . "/ibendport_test.conf";
+    open( $f, $confpath ) or die("Couldn't open $confpath");
+    while ( $r = <$f> ) {
+        if ( $r =~ /^\s*#/ || $r =~ /^\s*$/ ) { next; }
+        chomp $r;
+        ( $k, $v ) = split( /=/, $r );
+        $conf{$k} = $v;
+    }
+    close($f);
 
-my %conf;
-my $confpath = $basedir . "/ibendport_test.conf";
-open( $f, $confpath ) or die("Couldn't open ibtest.conf");
-while ( $r = <$f> ) {
-    if ( $r =~ /^\s*#/ || $r =~ /^\s*$/ ) { next; }
-    chomp $r;
-    ( $k, $v ) = split( /=/, $r );
-    $conf{$k} = $v;
+    # Verify that we really want to run these tests.
+    if ( $conf{SELINUX_INFINIBAND_ENDPORT_TEST} eq 1 ) {
+        plan tests => 2;
+    }
+    else {
+        plan skip_all => "test not configured";
+    }
 }
 
-# verify that we really want to run these tests
-ok( $conf{SELINUX_INFINIBAND_ENDPORT_TEST} eq 1 );
-
 @allowed_device_port =
   split( /,/, $conf{SELINUX_INFINIBAND_ENDPORT_TEST_ALLOWED} );
 @denied_device_port =
@@ -36,7 +43,7 @@ foreach (@allowed_device_port) {
         last;
     }
 }
-ok( $result, 0 );
+ok( $result eq 0 );
 
 foreach (@denied_device_port) {
     @dev_port_pair = split( / /, $_ );
diff --git a/tests/infiniband_pkey/test b/tests/infiniband_pkey/test
index 382c259..e5d2efb 100755
--- a/tests/infiniband_pkey/test
+++ b/tests/infiniband_pkey/test
@@ -1,25 +1,31 @@
 #!/usr/bin/perl
 
-use Test;
+use Test::More;
 
-BEGIN { plan tests => 4 }
+my %conf;
 
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
 
-my %conf;
-$confpath = $basedir . "/ibpkey_test.conf";
-open( $f, $confpath ) or die("Couldn't open $confpath");
-while ( $r = <$f> ) {
-    if ( $r =~ /^\s*#/ || $r =~ /^\s*$/ ) { next; }
-    chomp $r;
-    ( $k, $v ) = split( /=/, $r );
-    $conf{$k} = $v;
-}
-close($f);
+    $confpath = $basedir . "/ibpkey_test.conf";
+    open( $f, $confpath ) or die("Couldn't open $confpath");
+    while ( $r = <$f> ) {
+        if ( $r =~ /^\s*#/ || $r =~ /^\s*$/ ) { next; }
+        chomp $r;
+        ( $k, $v ) = split( /=/, $r );
+        $conf{$k} = $v;
+    }
+    close($f);
 
-# Verify that we really want to run these tests.
-ok( $conf{SELINUX_INFINIBAND_PKEY_TEST} eq 1 );
+    # Verify that we really want to run these tests.
+    if ( $conf{SELINUX_INFINIBAND_PKEY_TEST} eq 1 ) {
+        plan tests => 3;
+    }
+    else {
+        plan skip_all => "test not configured";
+    }
+}
 
 $device = $conf{SELINUX_INFINIBAND_PKEY_TEST_DEV};
 $port   = $conf{SELINUX_INFINIBAND_PKEY_TEST_PORT};
@@ -47,7 +53,7 @@ foreach (@unlabeled_pkeys) {
     }
 }
 if (@unlabeled_pkeys) {
-    ok( $result, 0 );
+    ok( $result eq 0 );
 }
 else {
     ok(1);
@@ -69,7 +75,7 @@ foreach (@unlabeled_pkeys) {
     }
 }
 if (@unlabeled_pkeys) {
-    ok( $result >> 8, 13 );
+    ok( $result >> 8 eq 13 );
 }
 else {
     ok(1);
@@ -83,7 +89,7 @@ foreach (@labeled_pkeys) {
     }
 }
 if (@labeled_pkeys) {
-    ok( $result >> 8, 13 );
+    ok( $result >> 8 eq 13 );
 }
 else {
     ok(1);
-- 
2.39.2

