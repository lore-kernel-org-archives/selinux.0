Return-Path: <SRS0=XEA0=3T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08CEC2D0DB
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 19:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CDD206D3
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 19:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Hh7OoHKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgA3T1M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:27:12 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:23161 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3T1L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 14:27:11 -0500
X-EEMSG-check-017: 52185005|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="52185005"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Jan 2020 19:26:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580412410; x=1611948410;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qF8sfWr8beV+8MbmD1ZqHA3Rs7bIH562lO/p43AEdIc=;
  b=Hh7OoHKCnkwz7KS05yrearY8uEsi6Nz6FCb7WVwS+liWkIjg99oudXLN
   w+4sXnAMqqi+J93FP9Ttgi+Kv5enWES8AE1Kx67ymtJkjDDf1bSvp9EK/
   jW9gWAX6hxp30o7Xxg9Ond2mBUW5ZC2g1oLLAlW/MPshLiykVp8W0QQSw
   reUX78NkNFMH2aauy19HrfVD/JfRgxnpZ8sr2jb+6daMGWzq2Tf+IgI1F
   1VatfNiBQg8ARRqLYbl14uZFho6wFy+yhGSA8SqQcEBIJlx2UfqKZQowa
   k0voiWRyeQ1jWcXt6Qryej0wSCvE5jI2UvP3f/vcogtwM7WChN4RH21EG
   A==;
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="38479796"
IronPort-PHdr: =?us-ascii?q?9a23=3AXlwtTBFEYK7zPY6zXDl8hp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p867bnLW6fgltlLVR4KTs6sC17OK9fuwEjVauN7B6ClELMUXEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/Jas90B?=
 =?us-ascii?q?XEr3hHd+hL229kOE+YkxLg6sut5pJu/Dlctvw7+8JcTan2erkzQKBFAjghL2?=
 =?us-ascii?q?07/tDguwPZTQuI6HscU2EWnQRNDgPY8hz0XYr/vzXjuOZl1yaUIcP5TbYvWT?=
 =?us-ascii?q?S/9KhrUwPniD0GNzEi7m7ajNF7gb9BrxKgoxx/xJPUYJ2QOfFjcK7RYc8WSG?=
 =?us-ascii?q?xcVclfTSxBBp63YZUJAeQPIO1Uq5DxqlUKoBe7AwSnGeHhxSJShnLu3aM0zf?=
 =?us-ascii?q?kvHw/F0gInEN0Av2/ZoMn2OaoITey41rXEwSnFYvhL2Tn98o/IchU5rP+RQb?=
 =?us-ascii?q?J/b9LRyUkxGAPDk16etInlMCmR1uQJrWea7/drWOW0i2E6sAF8uSSvx8cwhY?=
 =?us-ascii?q?nJgYIZ0FbE9T5jz4ovKt24T1B7bMeiHZBNuS+aMI52TdkjQ2FuoCs6xbwGuY?=
 =?us-ascii?q?K7fCgX05sr3QLQa/uCc4WO/xntV/6RLC9liH9qd7+znRa//VW6xuHiWcS4zk?=
 =?us-ascii?q?xGojdDn9LRrH4CzQbT5dKCSvZl+0eh3iuA2B7L5+FfJEA0ibLbK5k8wr4sjp?=
 =?us-ascii?q?YTsVrMHivxmEjukK+ZbF8k+um16+T8eLnmp5mcN4FzigHlLKshhtazAfg4Mw?=
 =?us-ascii?q?cSX2ib/v6w1Lv/8k3iXLpGlPg2kqjdsJzCJMQboLC2AxNN34o+5BuyAC2q3d?=
 =?us-ascii?q?QFkXUdMl5IdwyLg5L0N13WJfD3F/a/g1CikDdxwPDGO6XsAo7QIXjYi7rhYb?=
 =?us-ascii?q?Z85FJcyAo019xf4YlUBasbLPL8XU/xqsTUDgUlPAys3+bnFNJ925sEWWKOHq?=
 =?us-ascii?q?CZMLndsUWV6e03P+aDfI8Vtyz8K/gj+fHulmQ0lkQBfamo25sXdG63Hu5gI0?=
 =?us-ascii?q?qHfXrgmMsOEWAPvgAmVuzllEWCUSJPZ3a1R6884TQ7CIW9DYfFXI+inKKO0T?=
 =?us-ascii?q?yhHpJIe29GCkqDEWvye4qYXPcMbTqYItV9nTwcSbihV4gh2Am1tADkz7pnL+?=
 =?us-ascii?q?zU+jAXtJ/4yth16PPclQso+Tx3EcudyWeNQH9wnm8SQD82xq9/q1Rnylifya?=
 =?us-ascii?q?h4n+BYFdtL6vNRSAg6KJrcwvdiC9/oRwLBes6FSFOhQtWhGzE+UMg9zMMJY0?=
 =?us-ascii?q?Z4SJ2eiUXb1jeuK6ccirjOAZsz6K+a1H/0dOhnzHOT77Usl1krRIN0MGSigq?=
 =?us-ascii?q?Nuv1zIC5Xhj1SSl6Hsc78VmiHK6jHQniK1oEhEXVsoAu3+VncFax6T9oX0?=
X-IPAS-Result: =?us-ascii?q?A2AvAABbLTNe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWcHA?=
 =?us-ascii?q?QELAYF8gRhUASASKow3YIZdBosmj06BewkBAQEBAQEBAQEbEAwBAYRAglQ0C?=
 =?us-ascii?q?Q4CEAEBAQQBAQEBAQUDAQFshTcMgjspgzMBRoFRgmc/AYJWJQ+vFIkJgT6BO?=
 =?us-ascii?q?AGHQYR4eYEHgUeDG4JLGQKBTWOFIQSNU4oqepZmgkOCTIR3jmsMG5sBAZdEl?=
 =?us-ascii?q?Co5gVgrCAIYCCEPgycJRxgNkhCGUYQgIwMwjlIBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Jan 2020 19:26:48 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00UJPplL185539;
        Thu, 30 Jan 2020 14:25:59 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] testsuite: add further nfs tests
Date:   Thu, 30 Jan 2020 14:27:35 -0500
Message-Id: <20200130192735.247499-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In addition to testing full NFS security labeling support,
make sure that context mounts continue to work independent
of whether the mount was exported with security_label, and
add a simple test of the default NFS file labeling.

With the previous changes, this completes addressing
https://github.com/SELinuxProject/selinux-testsuite/issues/32

Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/32
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 nfs.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/nfs.sh b/nfs.sh
index 31c66c377cae..a82c4069d76d 100755
--- a/nfs.sh
+++ b/nfs.sh
@@ -2,6 +2,8 @@
 MOUNT=`stat --print %m .`
 TESTDIR=`pwd`
 systemctl start nfs-server
+
+# Run the full testsuite on a labeled NFS mount.
 exportfs -orw,no_root_squash,security_label localhost:$MOUNT
 mkdir -p /mnt/selinux-testsuite
 mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
@@ -9,5 +11,41 @@ pushd /mnt/selinux-testsuite
 make test
 popd
 umount /mnt/selinux-testsuite
+
+# Test context mounts when exported with security_label.
+mount -t nfs -o vers=4.2,context=system_u:object_r:etc_t:s0 localhost:$TESTDIR /mnt/selinux-testsuite
+echo "Testing context mount of a security_label export."
+fctx=`secon -t -f /mnt/selinux-testsuite/nfs.sh`
+if [ "$fctx" != "etc_t" ]; then
+    echo "Context mount failed: got $fctx instead of etc_t."
+    exit 1
+fi
+umount /mnt/selinux-testsuite
+exportfs -u localhost:$MOUNT
+
+# Test context mounts when not exported with security_label.
+exportfs -orw,no_root_squash localhost:$MOUNT
+mount -t nfs -o vers=4.2,context=system_u:object_r:etc_t:s0 localhost:$TESTDIR /mnt/selinux-testsuite
+echo "Testing context mount of a non-security_label export."
+fctx=`secon -t -f /mnt/selinux-testsuite/nfs.sh`
+if [ "$fctx" != "etc_t" ]; then
+    echo "Context mount failed: got $fctx instead of etc_t."
+    exit 1
+fi
+umount /mnt/selinux-testsuite
+
+# Test non-context mount when not exported with security_label.
+mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
+echo "Testing non-context mount of a non-security_label export."
+fctx=`secon -t -f /mnt/selinux-testsuite/nfs.sh`
+if [ "$fctx" != "nfs_t" ]; then
+    echo "Context mount failed: got $fctx instead of nfs_t."
+    exit 1
+fi
+umount /mnt/selinux-testsuite
+
+# All done.
+echo "Done"
 exportfs -u localhost:$MOUNT
+rmdir /mnt/selinux-testsuite
 systemctl stop nfs-server
-- 
2.24.1

