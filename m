Return-Path: <SRS0=XEA0=3T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BC4C33CB3
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 20:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EF22082E
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 20:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="UFCDujoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgA3UKq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:10:46 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:35413 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3UKq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 15:10:46 -0500
X-EEMSG-check-017: 52221396|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="52221396"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Jan 2020 20:10:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580415040; x=1611951040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RFnbbo11AdxdWJcbA5z+ssY4Z6qhGZyYyWdy24gyUFo=;
  b=UFCDujoJSmb9g3n09gaJI6hdCqAkizL0dfejC9NPMIRK7dSxb5bYlKNl
   fYGcvZKoX/hwu5dJaMivU8AxCO1BydjCvztT+1yQKrW0yyTpBo/SnjEEW
   u00w+Gie1w9sMXhkE5xkWIXJ+OHbf2kt3Q5WORATK0/s+XtnRA74xX5cm
   N+bXsND6AJUyXS0lwPT5QX8ToQ+KDD7mMNGTdu3Tjt6cuGvfv2Bujokcg
   j1luNe+H//y5hO5EwxK1gulWSlxKVAJQbQgqc0lt6Vt48KZFo6V/OBRL8
   1hiNweTjUnQf2lTlXe3pfD0/fPpwwjGYsseGP0+sLgn1LNcCYlLhETnVs
   w==;
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="38484125"
IronPort-PHdr: =?us-ascii?q?9a23=3AOEV8ZB/UuXhTof9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+gTIJqq85mqBkHD//Il1AaPAdyHrakUwLOM4uigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4VvJ6U+xh?=
 =?us-ascii?q?fUvHdFf/ldyWd0KV6OhRrx6dq88ZB5/yhMp/4t8tNLXLnncag/UbFWFiktPX?=
 =?us-ascii?q?ov5M3suxnDTA+P6WUZX24LjBdGABXL4Q/jUJvpvST0quRy2C+BPc3rVr80Qi?=
 =?us-ascii?q?it771qSBDzligKMSMy/XzNhcxxiKJbpw+hpwB6zoXJboyZKOZyc6XAdtwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMOhcooX4oVYFsBmwChS2BO73yjFGmGL406M53e?=
 =?us-ascii?q?omEw7G0gMvEd0VvXjIr9j4LrseXPqpwKXUyzjIcvNY2S366IjNah0vvO2MUq?=
 =?us-ascii?q?xoccrR10YvER7OgEiVqYP/OzOV0voCsmiG5OdnTuKglnUnphptojmv2sgsio?=
 =?us-ascii?q?7JipgTylDf7yp12ok1JdqmSENiZ9OvDZVetyafN4RsQ8MiRXlluCk7yr0auZ?=
 =?us-ascii?q?67YTMFxI47yB7YbvyKdZWD7BH7VOuJPDt1i31odKi/ihqv60Ss1OLxWteu3F?=
 =?us-ascii?q?pXqCdOj8PCuWoX1xPJ78iKUv59/kC81jmRzw3T8eREIVwslarcNp4h3qY8lp?=
 =?us-ascii?q?oNvkTHGS/7gFn2g7WMdkUl5+io8P7rYrTgpp+SMI90kR/xPbg0lsyjAeU3Lg?=
 =?us-ascii?q?gOX2+B9eS6yLLj5lH2TK9Pjv03lqnVqJHaJcIFqa6lGwJZz4ku5hmlAzqmzd?=
 =?us-ascii?q?gUh2cLIV1bdB6dkoTlI1TOL+r5Dfe7jVSsijBrx/XeM736H5rNNWPOkKvhfL?=
 =?us-ascii?q?lh605czxA/zdZE551OEL0BL/XzWlHpuNzCEhA5KxC0w/rgCNhlzIMeWH6AAq?=
 =?us-ascii?q?+DP6PIrFCH/v4gLPGMZIAPuTb9LeYq5+X1gHAihV8dfK+p3YcJZ3CiGPRpPV?=
 =?us-ascii?q?mZbWDwjdcGFGcAphA+Q/DyiF2eTT5TYG6/X6U55jE8E4KmC53MSZyzj7Gaxi?=
 =?us-ascii?q?e0AIBZZmBcBVCQC3vna4KEW/IUYiKIPsBhiiAEVaSmS4I5zhGhqgv6y7thLu?=
 =?us-ascii?q?rJ9SwVrozj1Ndr6O3Jjx0y9iJ7D96b026TS2F4hGQIRyU53Kpnu0xy1k+D0b?=
 =?us-ascii?q?Rkg/xfDdFT/+lGUho+NZPH1+x1Ec3yWgbYcteMT1amRc+mDi8rQt0txN8OZh?=
 =?us-ascii?q?U1J9L3lhne2wKyCqIR0rmMA4Y5tKnb2ivfPcF4nk3a2bEhgl9uec5GMWmrl+?=
 =?us-ascii?q?Yr7ATIL5LYmEWe0aCxfOIT2zCbpzTL9naHoEwNCF04aq7CR31KIxCHoA=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2AvAADvNzNe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWcHA?=
 =?us-ascii?q?QELAYF8gRhUASASKow3YIZbBosmj06BewkBAQEBAQEBAQEbEAwBAYRAAoJSN?=
 =?us-ascii?q?AkOAhABAQEEAQEBAQEFAwEBbIU3DII7KYJ7BjIBRhBRVxmCZz8BglYlD68Ji?=
 =?us-ascii?q?QWBPoE4AYdBhHh5gQeBR4MbgksZAoEsIYYEBI1Tiip6lmaCQ4JMhHeOawwbg?=
 =?us-ascii?q?0CXQpdElCo5gVgrCAIYCCEPgycJRxgNkhCECIJJhCAjAzCMD4JDAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Jan 2020 20:10:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00UK9bap216072;
        Thu, 30 Jan 2020 15:09:42 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2 2/2] testsuite: add further nfs tests
Date:   Thu, 30 Jan 2020 15:11:07 -0500
Message-Id: <20200130201107.4152-2-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130201107.4152-1-sds@tycho.nsa.gov>
References: <20200130201107.4152-1-sds@tycho.nsa.gov>
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
v2 moves nfs.sh under the tools/ directory and also updates
README.md for the additional tests. As before, these patches
depend on "testsuite: enable running over labeled NFS" to
enable the testsuite to pass on NFS mounts.

 README.md    |  5 ++++-
 tools/nfs.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index e02ae9ac6d6f..64f80c8fd493 100644
--- a/README.md
+++ b/README.md
@@ -156,7 +156,10 @@ nfs.sh script while in the selinux-testsuite directory:
 The script will start the nfs-server, export the mount containing the
 testsuite directory with the security_label option to localhost, mount
 it via NFSv4.2 on /mnt/selinux-testsuite, switch to that directory,
-and run the testsuite there.  After completion, it will unmount and
+and run the testsuite there.  After running the testsuite, the script
+will also perform tests of context mounts with and without the
+security_label export option and will test default NFS file labeling
+in the absence of any options.  When finished, it will unmount and
 unexport the mount and then stop the nfs-server.
 
 ## Running the Tests
diff --git a/tools/nfs.sh b/tools/nfs.sh
index 31c66c377cae..a82c4069d76d 100755
--- a/tools/nfs.sh
+++ b/tools/nfs.sh
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

