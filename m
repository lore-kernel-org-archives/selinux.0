Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CE7C6FA8E
	for <selinux@archiver.kernel.org>; Tue, 28 Feb 2023 14:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjB1ONs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Feb 2023 09:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB1ONs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Feb 2023 09:13:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB58A24A
        for <selinux@vger.kernel.org>; Tue, 28 Feb 2023 06:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677593576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FwScJTD1hNgmOM00GgqSTpfBFJvArfgtsQpmo3/eHaI=;
        b=OJntSZD78BSy3byPVykqzQsZI5eJvJkZmyNgcXRqNMaWHEsmJrjGJsrrmE38KosAL0QMLr
        WPYx4nBoVLKF0D2PhQmkKqn9C5z5kwgcjcYp/BXuHQs3H5n1E6jZH9MAEr8FnbN8akXWtT
        Q78AC9euP4oAlz03F9I7oGUO7Y1Rysw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-YTmS6somMEGMbO_HDHI_xg-1; Tue, 28 Feb 2023 09:12:54 -0500
X-MC-Unique: YTmS6somMEGMbO_HDHI_xg-1
Received: by mail-wr1-f69.google.com with SMTP id q7-20020a05600000c700b002cd9188abe5so341712wrx.3
        for <selinux@vger.kernel.org>; Tue, 28 Feb 2023 06:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwScJTD1hNgmOM00GgqSTpfBFJvArfgtsQpmo3/eHaI=;
        b=i/aLUg6nM9bDKziWA65Zy5kaBVBanXlMImK/qKrXK4F8QqaxoJ56BATfQUIbM9dSsM
         IsznSaLVPVdJMs37Pm735Sj1lvBHm3oK4oZ734K4ekjxmCNmFDb998DGxckRLg7C31lQ
         Sh8mkN+SPutaE89wLazcWgOCJIChOMWd8YtyvymwPrZp+nvyIeYTjP/LxH4SRUFfRjPV
         HMsKHk++KwZnx8+rqMXih2CTkGfCyLWXKD9BreECzES5xMteRy6hwHC9/pRfVx4PfG9x
         mO8Jj+8m1CGHSbGhZ/5yJB/hvnv8VwrkCRyFnNhpfMvW2N7vBSfrbkovvxv6C9PeZTCL
         RSbg==
X-Gm-Message-State: AO0yUKVU7PrLaa5L/RxftS75Fz703Tu+zqEE+rKuu6Xxb8tYT9bELsLH
        D4m0BtkLMGCBAdaBhx7bOKh8sGu7AuGqSmfI9oTR+CfuTBcFHeMP0pdgPliHW12HCuV1zbVFMlx
        3gipJEKJq22L8mZFBunJXevT4Wsn1ALXO/Du4UM//r4i7ufy3b8OCIHQ4Ie1osrpnE6OHRzGqZH
        7ZgQ==
X-Received: by 2002:a05:600c:1652:b0:3eb:399d:ab18 with SMTP id o18-20020a05600c165200b003eb399dab18mr2225897wmn.35.1677593573307;
        Tue, 28 Feb 2023 06:12:53 -0800 (PST)
X-Google-Smtp-Source: AK7set8TlqnJTTojgSSx2itOCo8NrxjP8KCtx7ScEhrjbTeWMs2u67EeZ8nPlOQkEi/j+ui/r6CsyA==
X-Received: by 2002:a05:600c:1652:b0:3eb:399d:ab18 with SMTP id o18-20020a05600c165200b003eb399dab18mr2225877wmn.35.1677593572904;
        Tue, 28 Feb 2023 06:12:52 -0800 (PST)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g14-20020a7bc4ce000000b003eb20d4d4a8sm12161129wmk.44.2023.02.28.06.12.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:12:51 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 3/3] tests/infiniband*: simplify test activation
Date:   Tue, 28 Feb 2023 15:12:47 +0100
Message-Id: <20230228141247.626736-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228141247.626736-1-omosnace@redhat.com>
References: <20230228141247.626736-1-omosnace@redhat.com>
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

