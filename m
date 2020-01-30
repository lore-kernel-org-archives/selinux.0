Return-Path: <SRS0=XEA0=3T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE86C35240
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 14:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030F120CC7
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 14:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="O8cyiATb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgA3OXU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:23:20 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:37800 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3OXR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 09:23:17 -0500
X-EEMSG-check-017: 75222127|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="75222127"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Jan 2020 14:22:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580394172; x=1611930172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wYg3nXBdihtEnFNqEYefhUOpfw03r8bhjwyhuANwWqU=;
  b=O8cyiATbrCQuWA4WWBmUHjK71aW3D/1KWZ4TgtDxq9QCJyCYUQght6AC
   g5Lq/75tVp2QOOSKaXMRTijuxSJRslTrME1Y+Vn6I6ZUWyXAcYhyXM3R2
   76f8VPlNesvIq/TwMbt+wIiazNcSOl0MIDyZCJ7RFVYZgeI9MTfCY8ub3
   Or20zzzdhEgq4WWjIgch2Nz3Xxr3yUkcnqfZza7H+S77aMvePm4PJmdiv
   kQpMxzZj+pP0ZtADokDT5KffTFWOc8ZGtQzLav/LHmNR8E3GU126Z2E5P
   nhRjguu9LBqjTTBbQXMKrMWki+s77cyWrI9DrbohrcQVnDWLKDS8j1Wb0
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="38455259"
IronPort-PHdr: =?us-ascii?q?9a23=3A+uVY2xdJNBjTF177ImA3u6wqlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc26ZRyN2/xhgRfzUJnB7Loc0qyK6vymAjxLv8/J8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HHr3ZLdOhbxH5kLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcUMlRTShBCZ6iYYUJAeQKIOJUo5DzqlYKqBezAxSnCuHyxT9SnnL43bM03f?=
 =?us-ascii?q?kvHw/F2wIvEN0AvW/IoNj2LqoeTfq4wLXUwTjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBeuSaaN45sTcMjRWFloCk6yrwauZ?=
 =?us-ascii?q?67YSgF044ryALYa/yCdYWD/xHtVP6JLDtli39od6izihav/US61OHxWde43E?=
 =?us-ascii?q?xXoidDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2kLWZdl8l+ui18OTreLTmppmSN49zkQHxLLghltajAeU4Lg?=
 =?us-ascii?q?cOX2+b9f661LL/5k32XK9Gjvg3kqndqJzaJMIbqbClAwJNz4ou5BmyAy2m3d?=
 =?us-ascii?q?gFh3ULMl1IdAydg4T0I13OJer3Dfa7g1SiijdrwPXGM6X6AprQNXjOi6vhfL?=
 =?us-ascii?q?Zh5E5czwo/19Zf54lOBb0bL/LzXVHxuMTCDhAlKwy03/rnCNJl24MEWGKAHq?=
 =?us-ascii?q?+ZP7nIsVCV/u0gP/GDZI8Ptzb8Lfgq+eXugGQill8BfKmp24cXZ26iHvRgPU?=
 =?us-ascii?q?qZfWDgjcsGEWcPpgA+VvDliEWeUT5PYHa/R6U85jQ8CIK9C4fMXJyij6Ka0S?=
 =?us-ascii?q?ehAJJZe2BGBUqQEXvya4qEXPIMYjqIIsB9ijwESaShS4g52BG1qgD6z7tnLu?=
 =?us-ascii?q?zJ+iwXrp/jytd16PPJlR0o9jx7Ed6d02eTQGFwhG8IQCU23K9nq0xn1liDyb?=
 =?us-ascii?q?R4g+BfFdFL//NGSBo6NZrHwuxiEd/yRwbBcs6MSFahRdWmGy8+QsgtzN8JZk?=
 =?us-ascii?q?YuU+ml2wjKwi6CG7YIk/mOA5su/+TX2H2iCdx6ziP9yKQ5j1QgCvBKPGmii7?=
 =?us-ascii?q?83oxPfHKbVgk6ZkOCsbq1a0ynTojTQhVGStV1VBVYjGZ7OWmoSMw6N/Nk=3D?=
X-IPAS-Result: =?us-ascii?q?A2AvAAA15TJe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWcHA?=
 =?us-ascii?q?QELAYF8gRhUASASKow3YIZcBosmj06BewkBAQEBAQEBAQEbEAwBAYRAglQ0C?=
 =?us-ascii?q?Q4CEAEBAQQBAQEBAQUDAQFshTcMgjspgzMBRoFRgmc/AYJWJQ+tf4kCgT6BO?=
 =?us-ascii?q?AGHQYR4eYEHgRE2gxuCSxkCgU2GBASXfZdggkOCTIR3hUWJJgwbg0CXQQGXR?=
 =?us-ascii?q?JQqOYFYKwgCGAghD4MnCUcYDZIQhAiCSYQgIwMwjlIBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Jan 2020 14:22:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00UELxLS028021;
        Thu, 30 Jan 2020 09:22:03 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] testsuite: provide support for testing labeled NFS
Date:   Thu, 30 Jan 2020 09:23:43 -0500
Message-Id: <20200130142343.163003-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Provide instructions in the README.md file, the required kernel config
options in defconfig, and a nfs.sh script for running the testsuite
within a labeled NFS mount.  This depends on the previous change to
enable running over labeled NFS without failures.

This completes the first part of
https://github.com/SELinuxProject/selinux-testsuite/issues/32.

What remains unfinished is adding tests that context mounts are properly
honored, with and without security_label in exports, for NFS, and
default labeling of NFS when neither security_label nor context mounts
are used (i.e. genfscon default of nfs_t).

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 README.md | 41 +++++++++++++++++++++++++++++++++++++++++
 defconfig | 10 ++++++++++
 nfs.sh    | 13 +++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100755 nfs.sh

diff --git a/README.md b/README.md
index 4352796edb2d..25ffe1233a2d 100644
--- a/README.md
+++ b/README.md
@@ -118,6 +118,47 @@ the tests:
 	tests/infiniband_pkey/ibpkey_test.conf
 	tests/infiniband_endport/ibendport_test.conf
 
+#### NFS
+
+It is possible to run most of the tests within a labeled NFS mount in
+order to exercise the NFS security labeling functionality.  Certain
+tests have been excluded from such testing due to differences between
+NFS and local filesystems; these tests will be automatically skipped.
+
+You will need to install an additional package, the package below
+is for Fedora/RHEL but other Linux distributions should have a similar
+package:
+
+* nfs-utils _(for `nfsd', `exportfs', and other NFS-related programs)_
+
+On a modern Fedora system you can install this dependency with the
+following command:
+
+	# dnf install nfs-utils
+
+If your distribution does not use systemd as its init system, you will
+need to customize the nfs.sh script found in this directory to
+correctly start and stop the nfs server.  You may also choose to not
+start/stop the nfs-server as part of the script by removing those lines
+if you are already using NFS for other reasons.
+
+Before running the tests in a labeled NFS mount, first ensure that you
+can run them successfully on a local filesystem following the standard
+instructions further below.  Any failures that occur on a local
+filesystem should also typically be expected when running over NFS.
+
+To run the tests within a labeled NFS mount, you can run the
+nfs.sh script while in the selinux-testsuite directory:
+
+       # cd selinux-testsuite
+       # ./nfs.sh
+
+The script will start the nfs-server, export the mount containing the
+testsuite directory with the security_label option to localhost, mount
+it via NFSv4.2 on /mnt/selinux-testsuite, switch to that directory,
+and run the testsuite there.  After completion, it will unmount and
+unexport the mount and then stop the nfs-server.
+
 ## Running the Tests
 
 Create a shell with the `unconfined_r` or `sysadm_r` role and the Linux
diff --git a/defconfig b/defconfig
index 7cb6a2ca7f71..8419e40b79dc 100644
--- a/defconfig
+++ b/defconfig
@@ -94,3 +94,13 @@ CONFIG_TRACEPOINTS=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
 CONFIG_QFMT_V2=y
+
+# Test labeled NFS.
+# This is not required for SELinux operation itself.
+CONFIG_NFS_FS=m
+CONFIG_NFS_V4=m
+CONFIG_NFS_V4_2=y
+CONFIG_NFS_V4_SECURITY_LABEL=y
+CONFIG_NFSD=m
+CONFIG_NFSD_V4=y
+CONFIG_NFSD_V4_SECURITY_LABEL=y
diff --git a/nfs.sh b/nfs.sh
new file mode 100755
index 000000000000..31c66c377cae
--- /dev/null
+++ b/nfs.sh
@@ -0,0 +1,13 @@
+#!/bin/sh -e
+MOUNT=`stat --print %m .`
+TESTDIR=`pwd`
+systemctl start nfs-server
+exportfs -orw,no_root_squash,security_label localhost:$MOUNT
+mkdir -p /mnt/selinux-testsuite
+mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
+pushd /mnt/selinux-testsuite
+make test
+popd
+umount /mnt/selinux-testsuite
+exportfs -u localhost:$MOUNT
+systemctl stop nfs-server
-- 
2.24.1

