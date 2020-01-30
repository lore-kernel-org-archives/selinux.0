Return-Path: <SRS0=XEA0=3T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE8AC2D0DB
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 20:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23562083E
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 20:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="oPJxw88P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgA3UKo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:10:44 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:35413 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3UKo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 15:10:44 -0500
X-EEMSG-check-017: 52221384|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="52221384"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Jan 2020 20:10:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580415040; x=1611951040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2ndt9O6PqTCwkTMR6yoSUdV2zcQgP+K41YH2om+DCnQ=;
  b=oPJxw88PB82derSzrBcj51EXFPbTr/DoYa8gg6C6jzxtOnGWdLk4jvXf
   zMAYIejt+lLbgafIR8RJR+IQylhtxv04YhVy1mVWXWRkKGUJeYNLlCBuT
   mvsKjiwQfF8b+iGG73y/OYJcvGUEMrZK+size6KjFsMxDOF5tLoViEZ4o
   2H2JYD30aR33nN7eYYrJeS2uHEL9vU4iJu7uFLJHnoz4sSyyiQGcL84wR
   E3xfPk4TP4eyTMIxNPkj5vmCirWwGacLMfS28OCsFWZZbcs13eEtRxzau
   Xvca/j4GEBebyWzsslqQoy8I5njuqGcdsU8b7IaVenfjVjLX/csI2AWqm
   g==;
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="38484124"
IronPort-PHdr: =?us-ascii?q?9a23=3AhGo5VRT5gu6KKExYqh/7Ckcyatpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZBaGt8tkgFKBZ4jH8fUM07OQ7/m8HzdQqs/b4ThCKMUKC0?=
 =?us-ascii?q?Zez51O3kQJO42sMQXDNvnkbig3ToxpdWRO2DWFC3VTA9v0fFbIo3e/vnY4Ex?=
 =?us-ascii?q?T7MhdpdKyuQtaBx8u42Pqv9JLNfg5GmCSyYa9oLBWxsA7dqtQajZFtJ6osxR?=
 =?us-ascii?q?bFuHVFdudZyW91O16emwv36sOs8JJ+6ShdtO8t+sBaXanmY6g0SKFTASg7PW?=
 =?us-ascii?q?wy+MDlrwTIQxGV5nsbXGUWkx5IDBbA4RrnQJr/sTb0u/Rk1iWCMsL4Ub47WT?=
 =?us-ascii?q?K576d2UxDokzsINyQ48G7MlMN9ir9QrQ+7qBx+x47UZ5yVNOZ7c6jAc94WWX?=
 =?us-ascii?q?ZNU8BMXCNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAi0+?=
 =?us-ascii?q?ovDxzI0gIjEdwJv3vao874OLsRXO2v0KXF1ynPY+9Q1Dzg6IbIaBchofSUUL?=
 =?us-ascii?q?xtbcre11EvFwPbgVWWtIfrIjaV2f4Js2if8eVhVf+khmk8qw5suTii3dssi4?=
 =?us-ascii?q?nViYIVzVDI7yN5wJ0vKtGiR057ZsCkHYJWuiqHOYV2RcYiTHtpuCY80rAGtp?=
 =?us-ascii?q?+7fDQKyJQ63BHTceCIc4+N4h/lSe2fIi94iWp4dL+wiBu+60itxvDmWsWq31?=
 =?us-ascii?q?tGsDBJnsTKu3sQzRLc8NKHReF4/kq53DaP0B3c5f9cLEAvkKrbN4Yhwrktlp?=
 =?us-ascii?q?oPqUjDHjH5mEHxjKKOakUr4PKo6+X6YrX9vJOcNol0ig/5MqQ1hMOwHf40Mh?=
 =?us-ascii?q?QOXmeH+eS806fv/UvlT7VRkvI6iKzZsJHeJcgDp665BRFa0po75hqiADqr38?=
 =?us-ascii?q?4UkHkaIF5fZh6KgJblN0vTLPzgCPewmVWskDNlx/DcOb3hB43ALmPen7f6Zr?=
 =?us-ascii?q?t9905dxxYzzdBY/Z5UDKoBL+jpVk/+s9zYEAc1MxaozOb/FNV9yoQeVHqVAq?=
 =?us-ascii?q?+YLKzSsUWH5vgyLOaUeIAaoDb9JOIk5/7ok3A5gkQQcrK13ZsWbnC4AuppI1?=
 =?us-ascii?q?+fYXXyntcNC3sFvg07TObykl2NTSZTZ2quX6I7/jw7D4emDYDYRoCrmrOOwD?=
 =?us-ascii?q?m0E4ZMZm9YF1+MEW3nd5meV/gQbyKSJ9drkiYYWri5V48hyRauuRfhy7V5Ku?=
 =?us-ascii?q?rU+ysYtY/s1dVu+e3Tmg899SZuA8SezW6NVWd0kX0MRzMs26B/u0N9wE+Z0a?=
 =?us-ascii?q?dkm/xYCcBT5/RRXwciL5Hc0uh6BsvqWg3bY9eJTE+qQtChATE2VNI+3cUCbF?=
 =?us-ascii?q?p6G9Wn3Vj/2H+yCqIRv6SCGZhx96XbxXW3LMF4mFjc06x0tEUrWstCMyWdg6?=
 =?us-ascii?q?d78wXCT9rSn16xi7ehdaNa2jXEsmiE0zzd7wljTAdsXPCdDjgkbUzMoIG8vR?=
 =?us-ascii?q?LP?=
X-IPAS-Result: =?us-ascii?q?A2AvAADvNzNe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWcHA?=
 =?us-ascii?q?QELAYF8gRhUASASKow3YIZbBosmj06BewkBAQEBAQEBAQEbEAwBAYRAglQ0C?=
 =?us-ascii?q?Q4CEAEBAQQBAQEBAQUDAQFshTcMgjspgzMBRoFRgmc/AYJWJQ+vCYkFgT6BO?=
 =?us-ascii?q?AGHQYR4eYEHgRE2gxuCSxkCgU2GBASXfZdggkOCTIR3hUWJJgwbg0CXQpdEl?=
 =?us-ascii?q?Co5gVgrCAIYCCEPgycJRxgNkhCECIJJhCAjAzCOUgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Jan 2020 20:10:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00UK9bao216072;
        Thu, 30 Jan 2020 15:09:40 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2 1/2] testsuite: provide support for testing labeled NFS
Date:   Thu, 30 Jan 2020 15:11:06 -0500
Message-Id: <20200130201107.4152-1-sds@tycho.nsa.gov>
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
v2 moves nfs.sh under tools/.  As before, these two patches depend
on the previous one ("testsuite:enable running over labeled NFS") in order
to allow the testsuite to pass on NFS mounts.

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

