Return-Path: <SRS0=XEA0=3T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A40CC2D0DB
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 20:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C583D2083E
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 20:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="hNH9FUzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgA3U1W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:27:22 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:29193 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3U1V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 15:27:21 -0500
X-EEMSG-check-017: 52191884|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="52191884"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Jan 2020 20:27:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580416038; x=1611952038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/S5kUAK1PB+/s1cHbNYY0dHWf6nh9gNEWRHS0e6gsxM=;
  b=hNH9FUzMPZlXKECxyTNCCHuzmzm2LsMtx8eWjR60i1cadPp0RkZTz1Cn
   YposTWnKht836QwRnGPtoPQpRw7y7VPIoKsvaUr+iGRHNxEbj4Lp7uGjq
   fK6l13SGj3JX/1rIZKgFB0XmAX6qwdUloeMbgDcVifXSbUcBlKP2oii4H
   5oh4khMi39bS55UcXjn0OhyzMPSXb/W64Ml5ae9a/rFQBjctCavYmjl9O
   rQmHwXclMbA6DEIX58zf0jFbgI8wFt6zNDW7iSlvqbKCapKGW6fOr9qvg
   MEez1avBsd6ffZotuf8Nk0ejwfBugtIL8IPU7QY3cGNentSMqtXh4vtIp
   w==;
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="38485158"
IronPort-PHdr: =?us-ascii?q?9a23=3AUxnXpBNkkMBgeiL74+Yl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z5psbcNUDSrc9gkEXOFd2Cra4d16yN4+u5AjdIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrw/xx?=
 =?us-ascii?q?bKrXdEZupbyG11Ll6Xgxrw+9288ZF+/yleof4t69JMXaDndKkkULJUCygrPX?=
 =?us-ascii?q?oo78PxrxnDSgWP5noYUmoIlxdDHhbI4hLnUJrvqyX2ruVy1jWUMs3wVrA0RC?=
 =?us-ascii?q?+t77x3Rx/yiScILCA2/WfKgcFtlq1boRahpxtiw47IZYyeKfRzcr/Bcd4cWG?=
 =?us-ascii?q?FOUNxRVyhcCY2iaYUBAfcKMeJBo4Tzo1YCqB2zDhSuCuzy0D9Fnn/407Mn3e?=
 =?us-ascii?q?ovEg/I2wMvEd0VvXjIr9j4LrseXPqpwKXUyzjIcvNY2S366IjNah0vvO2MUq?=
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
X-IPAS-Result: =?us-ascii?q?A2A6AABnOzNe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWgGA?=
 =?us-ascii?q?QELAYF8gRhVIBIqjReGVQEBAQMGiyaPToF7CQEBAQEBAQEBARsQDAEBhECCV?=
 =?us-ascii?q?DUIDgIQAQEBBAEBAQEBBQMBAWyFNwyCOymDMwFGgVGCZz8BglYlD68IiHuBP?=
 =?us-ascii?q?oE4AYdBhHh5gQeBETaDG4JLGQKBTYYEBJd9l2CCQ4JMhHeFRYkmDBuDQJdCl?=
 =?us-ascii?q?0SULAE2gVgrCAIYCCEPgycJRxgNkhCECIJJhCAjAzCOUgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Jan 2020 20:27:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00UKQRD9226332;
        Thu, 30 Jan 2020 15:26:29 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3 1/2] testsuite: provide support for testing labeled NFS
Date:   Thu, 30 Jan 2020 15:22:38 -0500
Message-Id: <20200130202239.11498-1-sds@tycho.nsa.gov>
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
v3 moves nfs.sh under tools/, updates README.md, and fixes nfs.sh for
the relocation.  As before, these patches depend on the previous one
("testsuite: enable running over labeled NFS") in order to allow the
testsuite to pass on NFS mounts.

 README.md    | 41 +++++++++++++++++++++++++++++++++++++++++
 defconfig    | 10 ++++++++++
 tools/nfs.sh | 13 +++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100755 tools/nfs.sh

diff --git a/README.md b/README.md
index 4352796edb2d..e02ae9ac6d6f 100644
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
+need to customize the nfs.sh script found in the tools directory to
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
+       # ./tools/nfs.sh
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
diff --git a/tools/nfs.sh b/tools/nfs.sh
new file mode 100755
index 000000000000..31c66c377cae
--- /dev/null
+++ b/tools/nfs.sh
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

