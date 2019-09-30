Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F87C35280
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A760420842
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iY17dVzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfI3NQL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:16:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29689 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbfI3NQL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 09:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569849369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PbldcGfs9qBKGcUQcGOi2yPJ+puhtZeDpB58KwYrd6c=;
        b=iY17dVzAVyl9WtfLw/XRRBI5anu+5PT5ZAp2Wm6mGk6Os+4Sfg/rzYNobY9pfGZ1CX20NW
        gtQFQge9+hXQq1SI3EOznVatvqe/FFQVlH/eVU0JonVbjYGX1lM1/KdlSNryR2abqbGK2z
        WydIm8rt5/HZa3KopscNtV0D4KRmEyE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-iHcSNMpvO0KlwSVrDhVTvQ-1; Mon, 30 Sep 2019 09:16:05 -0400
Received: by mail-wm1-f70.google.com with SMTP id r21so3906911wme.5
        for <selinux@vger.kernel.org>; Mon, 30 Sep 2019 06:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6fiWpuawIDiR+HYuU0jcDTtbMInZJwymRpbX+5/glk=;
        b=kQTI2F6r9FAk/dsrJT39f4q8gPK6CXIR8oSVOauVccbWuYCjANQ9v/jDE6MlW7IWig
         miDsBt4DDE1FuaEHUDfI+q9wnUcBeacqYtodRFPa+wI1mP1aoijLEK/RT/TtXGNXhBwQ
         N5igcJMHrBVJV+abfVK0H3+rfnwQmDNUTls/voPKvoA0SUbRR1ftrb1Z5nY9JZr4dVs/
         wgbj3d4Zo3jVt2brrd93rc5T6tZKcqofXJzK4fkwiD8j38kMZ6AsavaCTJ1JaZ0xmiy1
         8sA/YUHyqADTT32VjWDRJtifQnwQr/u76i+ES1Z9iS8k63hjlL+366ThKoQ3P/0B8Hm7
         6SKQ==
X-Gm-Message-State: APjAAAUb9VKzQdOwBiSwEVLQuVsPRvFJEBtrIho5AJ1stDsANXDDVgc+
        MYPkmT1qKx64XczlhSEKIx28vK6r/9ktRiLdGww0Ka+uFUccGa2QrS8kwHOszToBnZXvnFUTQwu
        w57mAHKFRE0rWungUzg==
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr12628009wru.12.1569849363577;
        Mon, 30 Sep 2019 06:16:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzsDAAoLMs3nf4LiFlAakGY9Usevw6S3kJB7crNgzmYR5F2OhLlGi0AkMnaR/5QFWMNvXg44A==
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr12627981wru.12.1569849363253;
        Mon, 30 Sep 2019 06:16:03 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s12sm29465030wra.82.2019.09.30.06.16.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:16:02 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] selinux-testsuite: Add submount test
Date:   Mon, 30 Sep 2019 15:16:00 +0200
Message-Id: <20190930131600.21473-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: iHcSNMpvO0KlwSVrDhVTvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a test that verifies that SELinux permissions are not checked when
mounting submounts. The test sets up a simple local NFS export on a
directory which has another filesystem mounted on its subdirectory.
Since the export is set up with the crossmnt option enabled, any client
mount will try to transparently mount any subdirectory that has a
filesystem mounted on it on the server, triggering an internal mount.
The test tries to access the automounted part of this export via a
client mount without having a permission to mount filesystems, expecting
it to succeed.

The original bug this test is checking for has been fixed in kernel
commit 892620bb3454 ("selinux: always allow mounting submounts"), which
has been backported to 4.9+ stable kernels.

The test first checks whether it is able to export and mount directories
via NFS and skips the actual tests if e.g. NFS daemon is not running.
This means that the testsuite can still be run without having the NFS
server installed and running.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 README.md               | 24 ++++++++++++
 defconfig               | 11 ++++++
 policy/Makefile         |  2 +-
 policy/test_submount.te | 31 +++++++++++++++
 tests/Makefile          |  3 +-
 tests/submount/Makefile |  2 +
 tests/submount/test     | 84 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 155 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_submount.te
 create mode 100644 tests/submount/Makefile
 create mode 100755 tests/submount/test

diff --git a/README.md b/README.md
index 1396c8e..f45f5b4 100644
--- a/README.md
+++ b/README.md
@@ -114,6 +114,30 @@ the tests:
 =09tests/infiniband_pkey/ibpkey_test.conf
 =09tests/infiniband_endport/ibendport_test.conf
=20
+#### NFS server and client support
+
+The NFS automount test (tests/submount) requires NFS server and client sup=
port
+in the kernel.  In addition, it requires the NFS utility programs and a ru=
nning
+NFS daemon.  On Fedora/RHEL you need the following package (other distribu=
tions
+should have a similar package):
+
+* nfs-utils _(to setup the NFS server and export directory trees)_
+
+On a modern Fedora system you can install it with the following command:
+
+=09# dnf install nfs-utils
+
+The process to start the NFS server service varies across distributions, b=
ut
+usually you can start it by running:
+
+=09# service nfs-server start
+=09(or)
+=09# service nfs start
+=09(or)
+=09# systemctl start nfs-server
+=09(or)
+=09# systemctl start nfs
+
 ## Running the Tests
=20
 Create a shell with the `unconfined_r` or `sysadm_r` role and the Linux
diff --git a/defconfig b/defconfig
index cb57f22..2bcebbb 100644
--- a/defconfig
+++ b/defconfig
@@ -67,3 +67,14 @@ CONFIG_ANDROID_BINDERFS=3Dy
 # They are not required for SELinux operation itself.
 CONFIG_BPF=3Dy
 CONFIG_BPF_SYSCALL=3Dy
+
+# NFS server and client.
+# This is enabled for testing NFS automount in tests/submount.
+# It is not required for SELinux operation itself.
+CONFIG_NETWORK_FILESYSTEMS=3Dy
+CONFIG_FILE_LOCKING=3Dy
+CONFIG_MULTIUSER=3Dy
+CONFIG_NFSD=3Dm
+CONFIG_NFSD_V3=3Dy
+CONFIG_NFS_FS=3Dm
+CONFIG_NFS_V3=3Dm
diff --git a/policy/Makefile b/policy/Makefile
index a5942b3..dbef42d 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -24,7 +24,7 @@ TARGETS =3D \
 =09test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
 =09test_transition.te test_unix_socket.te \
 =09test_mmap.te test_overlayfs.te test_mqueue.te \
-=09test_ibpkey.te test_atsecure.te test_cgroupfs.te
+=09test_ibpkey.te test_atsecure.te test_cgroupfs.te test_submount.te
=20
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS +=3D test_bounds.te test_nnp_nosuid.te
diff --git a/policy/test_submount.te b/policy/test_submount.te
new file mode 100644
index 0000000..8694c6b
--- /dev/null
+++ b/policy/test_submount.te
@@ -0,0 +1,31 @@
+#################################
+#
+# Policy for testing NFS crosmnt
+#
+
+# A domain that can access NFS files/directories
+type test_readnfs_t;
+domain_type(test_readnfs_t)
+unconfined_runs_test(test_readnfs_t)
+domain_obj_id_change_exemption(test_readnfs_t)
+typeattribute test_readnfs_t testdomain;
+
+# Allow execution of helper programs
+corecmd_exec_bin(test_readnfs_t)
+domain_exec_all_entry_files(test_readnfs_t)
+libs_use_ld_so(test_readnfs_t)
+libs_use_shared_libs(test_readnfs_t)
+libs_exec_ld_so(test_readnfs_t)
+libs_exec_lib_files(test_readnfs_t)
+
+# Allow this domain to be entered from sysadm domain
+miscfiles_domain_entry_test_files(test_readnfs_t)
+userdom_sysadm_entry_spec_domtrans_to(test_readnfs_t)
+corecmd_bin_entry_type(test_readnfs_t)
+sysadm_bin_spec_domtrans_to(test_readnfs_t)
+
+# Allow the domain to search home dirs so that ls works
+userdom_search_generic_user_home_dirs(test_readnfs_t)
+
+# Allow the domain to read NFS mounted files/directories
+fs_read_nfs_files(test_readnfs_t)
diff --git a/tests/Makefile b/tests/Makefile
index e5bdfff..e292be3 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -11,7 +11,8 @@ SUBDIRS:=3D domain_trans entrypoint execshare exectrace e=
xecute_no_trans \
 =09task_setnice task_setscheduler task_getscheduler task_getsid \
 =09task_getpgid task_setpgid file ioctl capable_file capable_net \
 =09capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
-=09inet_socket overlay checkreqprot mqueue mac_admin atsecure
+=09inet_socket overlay checkreqprot mqueue mac_admin atsecure \
+=09submount
=20
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt &=
& echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
diff --git a/tests/submount/Makefile b/tests/submount/Makefile
new file mode 100644
index 0000000..e7c006f
--- /dev/null
+++ b/tests/submount/Makefile
@@ -0,0 +1,2 @@
+all:
+clean:
diff --git a/tests/submount/test b/tests/submount/test
new file mode 100755
index 0000000..754b989
--- /dev/null
+++ b/tests/submount/test
@@ -0,0 +1,84 @@
+#!/usr/bin/perl
+# SPDX-License-Identifier: GPL-2.0
+#
+# This test checks that NFS automounts do not trigger
+# unwanted SELinux checks for mount permission
+#
+# Author:  Ondrej Mosnacek <omosnace@redhat.com>
+# Based on code by:  Martin Frodl <mfrodl@redhat.com>
+# Copyright (c) 2018 Red Hat, Inc.
+#
+
+use Test::More;
+use File::Spec;
+
+my ( $basedir, $result );
+
+BEGIN {
+    $basedir =3D File::Spec->rel2abs($0);
+    $basedir =3D~ s|(.*)/[^/]*|$1|;
+
+    system "rm -rf $basedir/nfs_export 2>&1";
+    system "rm -rf $basedir/nfs_import 2>&1";
+
+    system "mkdir $basedir/nfs_export";
+    system "mkdir $basedir/nfs_import";
+
+    # Try exporting and mounting NFS.
+    $result =3D
+      system "exportfs -o ro,crossmnt,sync 127.0.0.1:$basedir/nfs_export 2=
>&1";
+    $result +=3D system "mount -t nfs -o ro,timeo=3D5,retry=3D0,retrans=3D=
1 "
+      . "127.0.0.1:$basedir/nfs_export $basedir/nfs_import 2>&1";
+
+    # Cleanup.
+    system "umount $basedir/nfs_import 2>&1";
+    system "exportfs -u 127.0.0.1:$basedir/nfs_export 2>&1";
+
+    # If basic NFS workflow failed, then skip the test.
+    if ( $result eq 0 ) {
+        plan tests =3D> 2;
+    }
+    else {
+        system "rm -rf $basedir/nfs_export 2>&1";
+        system "rm -rf $basedir/nfs_import 2>&1";
+        plan skip_all =3D> "Unable to use NFS server/client";
+    }
+}
+
+# Create an EXT2 image to mount as submount (NFS needs a fs with UUID).
+system
+  "dd if=3D/dev/zero of=3D$basedir/nfs_export/image.ext2 bs=3D5M count=3D1=
 status=3Dnone";
+system "mkfs.ext2 -q -F $basedir/nfs_export/image.ext2";
+
+# Create the submount dir and mount the EXT2 image on it.
+system "mkdir $basedir/nfs_export/submount";
+system "mount -t ext2 -o loop "
+  . "$basedir/nfs_export/image.ext2 $basedir/nfs_export/submount";
+system "touch $basedir/nfs_export/submount/file";
+
+system "chcon -R -t test_file_t $basedir/nfs_export";
+
+# Export the directory.
+system "exportfs -o ro,crossmnt,sync 127.0.0.1:$basedir/nfs_export";
+
+# Mount the NFS export.
+system "mount -t nfs -o ro 127.0.0.1:$basedir/nfs_export $basedir/nfs_impo=
rt";
+
+# Sanity check if we can access the mounted filesystem.
+$result =3D
+  system "runcon -t test_readnfs_t -- ls $basedir/nfs_import >/dev/null";
+ok( $result eq 0 );
+
+# Check that we can access the submounted filesystem.
+$result =3D system "runcon -t test_readnfs_t -- "
+  . "cat $basedir/nfs_import/submount/file >/dev/null";
+ok( $result eq 0 );
+
+# Cleanup.
+system "umount $basedir/nfs_import 2>&1";
+system "exportfs -u 127.0.0.1:$basedir/nfs_export 2>&1";
+while ( system("umount $basedir/nfs_export/submount 2>&1") ne 0 ) {
+    select( undef, undef, undef, 1 );
+}
+system "rm -rf $basedir/nfs_export 2>&1";
+system "rm -rf $basedir/nfs_import 2>&1";
--=20
2.21.0

