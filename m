Return-Path: <SRS0=XEA0=3T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2A0C2D0DB
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 20:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AA220708
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 20:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="XvOV/dMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgA3U1e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:27:34 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:59440 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3U1e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 15:27:34 -0500
X-EEMSG-check-017: 52337645|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="52337645"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Jan 2020 20:27:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580416038; x=1611952038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gRKXMpzuN/viEqPU6R74PED5gPEXDvsEnzU8Ut94v2M=;
  b=XvOV/dMhbJBqtP+rvMPWY51nPhFRP6s+6HiyvBbCr/2OvEwyjQOrzOUc
   ulpyvIimqC2jbYwAmQRS26o1qIPA3MNpjT/clqqLBpxTozSAwIN0DVdTV
   gp8LXMFpDnh7EMs2oHPpGokYy+yBGk2mv1h+BX5poU/gjqZKkyiN4e9Uo
   PeRoCsXTWMxNd0VDjbkff2Xeo3ZfFX95Ufjn7p57t5e0WvYvln2lYLJBq
   MVm/TuigGk9CKEBYk7mImXDk7GoLgpfX2IQsd3iLvUHHZxIlvjvJlovDm
   NKGPl4qEUx+pIbJ1UuJFITiCeoJaIXrTdTBeZpZrKZLi9e5LunKb/LUsm
   g==;
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="38485160"
IronPort-PHdr: =?us-ascii?q?9a23=3AV/x/+xNJ0opWei8vXjAl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z5osbcNUDSrc9gkEXOFd2Cra4d16yN4+u5AjdIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrw/xx?=
 =?us-ascii?q?bKrXdEZupbyG11Ll6Xgxrw+9288ZF+/yleof4t69JMXaDndKkkULJUCygrPX?=
 =?us-ascii?q?oo78PxrxnDSgWP5noYUmoIlxdDHhbI4hLnUJrvqyX2ruVy1jWUMs3wVrA0RC?=
 =?us-ascii?q?+t77x3Rx/yiScILCA2/WfKgcFtlq1boRahpxtiw47IZYyeKfRzcr/Bcd4cWG?=
 =?us-ascii?q?FOUNxRVyhcCY2iaYUBAfcKMeJBo4Tzo1YCqB2zDhSuCuzy0D9Fnn/407Mn3e?=
 =?us-ascii?q?ovEg/I2w4vH9wBv3rbt9j5KKQfXPqpwKTS0TnPc/Vb0ir95ojSdRAhpOmBU6?=
 =?us-ascii?q?9sccXP0UkvFx3KjlONooL4OjOazOANs2yF4OtgSOmijHUnpBxqojW02sctip?=
 =?us-ascii?q?XGhoISylze8yV525w6Kce3SE58f96pCZ1dvDyUOYtxR8MtWWBouCAix70JuJ?=
 =?us-ascii?q?67YCgKyIk8yBLFd/OHdI2I7xT+X+iSOTd1nG9pdb2wihqo8UWs1/fwWte73V?=
 =?us-ascii?q?pUtCZJj9/BvW0X2RPJ8MiIUP5981+k2TaIyg/c9PlJIVsxlarHM54hxaMwlo?=
 =?us-ascii?q?YLvUTDACD2nEL2gbeKdko+4Oio6vnnYq78qp+dMY90hAb+Mr8wlcOjG+g4Lg?=
 =?us-ascii?q?gPUHSb+eS7zrHj+1H2QK5WgfEsl6nZsZTaKdwapq6/HQBVzp4u5wuwAjqpyt?=
 =?us-ascii?q?gVnWQLIEhbdB+IkYTlIUzCLOj9DfilglSslDlrx+rBPr3kGpjNNWXMkKz6cL?=
 =?us-ascii?q?Zh609T1AozzddF65JSEbEOOuj/WkD2tNzGFhM5KRC7w/77CNVh0YMTQXiPAq?=
 =?us-ascii?q?6FP6PSq1CI/P8gLPGQa4ANuDbyMfkl5/jwgn8iglISZrWp3ZoRaHCkAPtmOU?=
 =?us-ascii?q?OZbmTwgtsbDWgKuQ8+RvTwiFKeST5Te2qyX6Uk6zE8DYKmCpzDRoa3j7Odwi?=
 =?us-ascii?q?i2BYdWaX5bBVCMC3joa5+IVOsLaCKXOsVhiCALVaC9S4890hGjrBT6xKRjLu?=
 =?us-ascii?q?rV/C0YqJ3i2cNr5+3cix4y7yZ4D8eD3GGXSWF7gGcISyUx3KBlrkx30k2D3r?=
 =?us-ascii?q?Rgg/xECdxT4OtEUh8gOp7By+x3EMjyVRjcfteNUVqmR9KmATYrTt0v2dMBf0?=
 =?us-ascii?q?F9G9DxxizEijKjHrs9j7WWANkx9aXG0j76IMMu5WzB0fwak1Q+QsZJfVajj6?=
 =?us-ascii?q?p7+hmbU5XFiG2Fhq2qcuIaxyeL+2Cdmznd9HpEWRJ9BP2WFUsUYVHb+JGit0?=
 =?us-ascii?q?4=3D?=
X-IPAS-Result: =?us-ascii?q?A2AmAABnOzNe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWcHA?=
 =?us-ascii?q?QELAYF8gRhVIBIqjDdghlUBAQEDBosmj06BewkBAQEBAQEBAQEbEAwBAYRAA?=
 =?us-ascii?q?oJSNAkOAhABAQEEAQEBAQEFAwEBbIU3DII7KYJ7BjIBRhBRVxmCZz8BglYlD?=
 =?us-ascii?q?68IiHuBPoE4AYdBhHh5gQeBR4MbgksZAoEsIYYEBI1Tiip6lmaCQ4JMhHeFR?=
 =?us-ascii?q?YkmDBuDQJdCl0SUKjmBWCsIAhgIIQ+DJwlHGA2SEIQIgkmEICMDMIwPgkMBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Jan 2020 20:27:17 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00UKQRDA226332;
        Thu, 30 Jan 2020 15:26:31 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3 2/2] testsuite: add further nfs tests
Date:   Thu, 30 Jan 2020 15:22:39 -0500
Message-Id: <20200130202239.11498-2-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130202239.11498-1-sds@tycho.nsa.gov>
References: <20200130202239.11498-1-sds@tycho.nsa.gov>
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
v3 moves nfs.sh under tools/, updates README.md, and fixes nfs.sh for
the relocation.  As before, these patches depend on the previous one
("testsuite: enable running over labeled NFS") in order to allow the
testsuite to pass on NFS mounts.

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
index 31c66c377cae..314f898a6c02 100755
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
+fctx=`secon -t -f /mnt/selinux-testsuite`
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
+fctx=`secon -t -f /mnt/selinux-testsuite`
+if [ "$fctx" != "etc_t" ]; then
+    echo "Context mount failed: got $fctx instead of etc_t."
+    exit 1
+fi
+umount /mnt/selinux-testsuite
+
+# Test non-context mount when not exported with security_label.
+mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
+echo "Testing non-context mount of a non-security_label export."
+fctx=`secon -t -f /mnt/selinux-testsuite`
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

