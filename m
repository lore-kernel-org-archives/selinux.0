Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CE0C2D0DB
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 19:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C85A21D7E
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 19:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="EwQF7S6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAWTdh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:33:37 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:31086 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgAWTdg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 14:33:36 -0500
X-EEMSG-check-017: 48010098|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,354,1574121600"; 
   d="scan'208";a="48010098"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Jan 2020 19:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579808015; x=1611344015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gAQWaW5ssjA78AlR4r6j93+j2JAtD18UZoRtWhvc4yA=;
  b=EwQF7S6ljHGZxIOAeWq+Hxw7wpEDGXJbX3jApnMKKfaX3KoxUxMxvoFG
   hcBnrXv6URWpRz3CQebEzfnYMPyuHEYp0aTpXBy5f1KCEUAbqOONH6IrW
   iyaTaGOoPNlQ8m4BuOlhuFE1R7nS4eK1tpvVOxFjR/Vx1b5qI2Gx4KiHL
   XUqUpBwIHLm1GDT0j/zLMgHtKT9rKTuRdrMCULTmQGLWUmNh5aOuED/I1
   BochWiCfBq4yvP4Un2Vf/Jt16ESLUIHB/mjuhxL31/xwfLX+gLOqyZV8C
   3r+eRJvSHN5sFUqZmuyoPIiKwdWzcRtbiAbr0U9r83uJJy7f9SLKLP8DI
   g==;
X-IronPort-AV: E=Sophos;i="5.70,354,1574121600"; 
   d="scan'208";a="32270602"
IronPort-PHdr: =?us-ascii?q?9a23=3AKbNe7hA29DBkgZUlGlrIUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37pc6wAkXT6L1XgUPTWs2DsrQY0raQ6fqrCTRIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrwvxh?=
 =?us-ascii?q?fXrXdFePhazn5sKV6Pghrw/Mi98INt/ihKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHS2?=
 =?us-ascii?q?VBRMJRXDFfDI26YYUEEu4NMf9WooT5olcDqwa1CwuxC+P10jJGhmH407A03e?=
 =?us-ascii?q?oiFg/J0wMuEskSvHnXttj5KL0fXfypwKTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqHpxQtySAOIt3RMMvW25ouCcmyr0GpJ?=
 =?us-ascii?q?60ZzIGx4ggxx7abfGMbouG4gr7WeqMLjp1i2hpdbKiixqo70StxfPwWtOp3F?=
 =?us-ascii?q?tMsyFLiMPDtmoX2BzW8sWHT/x98Vq/1juXzADT7/1EIVgzlarGN54t2r4wmY?=
 =?us-ascii?q?QXsUTEBiL2hF/5jLWXdkU54eik8eXnYrPopp+bLI97lB3xPr4yms2/Hes4Mg?=
 =?us-ascii?q?8OU3Kd+eugz73s4Vf1QLBLjv0yiqXZsZbaKtoHpqOhHgNY3Yku5wy/Aju7yt?=
 =?us-ascii?q?gUg3YKIExfdB6al4TpPkvBIPH8DfexmVSslzJryujdPrL8GZXANWTDkbf9cr?=
 =?us-ascii?q?Z97E5Q0gwzzctF6J5OBbEBJ+zzVlfrtNPEFh85LxC0w+H/BdVn14MRRWKPDb?=
 =?us-ascii?q?WDMKzPqVCH+vogI+mWa48UvjbyNeMl6uX1gn8lmF8de7Wp0oUNaHC+APtmP1?=
 =?us-ascii?q?+VbmbrgtcECW0KpBYxTPT2iF2eVj5ef26yULgh5jE/E4+mFZ3MRp2pgLCY2S?=
 =?us-ascii?q?e7GZpWZnpYBVyWDXjocICEUe8WaC2OOs9hjiAEVb+5Ro8m0BGusxT6y7x9Ie?=
 =?us-ascii?q?XI5CIVrojj28Zo6O3Tjx4y6SZ4ANia02GIV2t0hH8HRycq3KBjpkxw0kyD3r?=
 =?us-ascii?q?Z8g/xZE9xT+vxIXxwkNZ7T0eN6Ecr+WgHfcdeTTlapXNGmDSs2TtIrzN9dK3?=
 =?us-ascii?q?p6Ts6vihHFwjqCHbAYjfqICYYy/6aa2GL+dOhnzHOT77Usl1krRIN0MGSigq?=
 =?us-ascii?q?Nuv1zIC5Xhj1SSl6Hsc78VmiHK6jHQniK1oEhEXVsoAu3+VncFax6T9oX0?=
X-IPAS-Result: =?us-ascii?q?A2BOAABD9Cle/wHyM5BlHQEBAQkBEQUFAYFnCAELAYF8g?=
 =?us-ascii?q?RhVIBIqjDVghnADAQEGiyaPToF7CQEBAQEBAQEBARsQDAEBhECCRDQJDgIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFNwyCOymDMwFGgVGCZz8BglYlD65AiH+BPoE4AYc9h?=
 =?us-ascii?q?HN5gQeBR4MbgksZAoFNhgQEjTgSijCXWoJDgkuEdY5oDBuCR5gvAYp+hSqHG?=
 =?us-ascii?q?JQgOYFYKwgCGAghD4MnCUcYDYt0hlGEICMDMI1EAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 23 Jan 2020 19:33:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00NJWl0U222319;
        Thu, 23 Jan 2020 14:32:47 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        richard_c_haines@btinternet.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] testsuite/policy: fixes for running on a labeled NFS mount
Date:   Thu, 23 Jan 2020 14:34:15 -0500
Message-Id: <20200123193415.34022-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When running the testsuite on a labeled NFS mount, certain
additional permissions are required for nfsd and its kernel threads
and for the nfs_t filesystem.  Allow them to avoid unnecessary
failures on NFS.  Also declare test_setfscreatecon_newcon_t as a
files_type() to ensure that it can be accessed as expected by
unconfined domains; otherwise, cleanup and repeated runs are not
guaranteed to work.  Saw denials for unconfined_t and kernel_t on
test_fscreatecon_newcon_t when running over labeled NFS, but
at least the unconfined_t access was possible even for running
locally.

With these changes, all of the "filesystem" tests pass on a labeled NFS
mount.

Certain test cases are still expected to fail over NFS; see
https://github.com/SELinuxProject/selinux-testsuite/issues/32
for more details.

Test sequence for labeled NFS is:
$ cat nfs.sh
MOUNT=/home # must be a top-level mount
TESTDIR=$MOUNT/path/to/selinux-testsuite
exportfs -orw,no_root_squash,security_label localhost:$MOUNT
systemctl start nfs-server
mkdir -p /mnt/selinux-testsuite
mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
pushd /mnt/selinux-testsuite
make test
popd
umount /mnt/selinux-testsuite
exportfs -u localhost:$TESTDIR
systemctl stop nfs-server

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/test_filesystem.te |  8 ++++++++
 policy/test_sctp.te       | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index a029a1b34404..c3c944affad4 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -41,6 +41,9 @@ files_search_all(test_filesystem_t)
 fs_associate(test_filesystem_file_t)
 fs_getattr_xattr_fs(test_filesystem_t)
 
+# Required when running the tests on a labeled NFS mount.
+fs_getattr_nfs(test_filesystem_t)
+
 # Update quotas
 fs_set_all_quotas(test_filesystem_t)
 allow test_filesystem_t test_filesystem_file_t:file { quotaon };
@@ -303,10 +306,15 @@ allow test_setfscreatecon_t test_file_t:dir { add_name write remove_name };
 
 # Set new context on fs:
 type test_setfscreatecon_newcon_t;
+files_type(test_setfscreatecon_newcon_t)
 unconfined_runs_test(test_setfscreatecon_newcon_t)
 fs_associate(test_setfscreatecon_newcon_t)
 allow test_setfscreatecon_t test_setfscreatecon_newcon_t:dir { create getattr rmdir };
 
+# Permit creation of the new file in a NFS filesystem.
+# This is required when running the testsuite on a labeled NFS mount.
+allow test_setfscreatecon_newcon_t nfs_t:filesystem associate;
+
 ################# deny process { setfscreate } #############
 type test_no_setfscreatecon_t;
 domain_type(test_no_setfscreatecon_t)
diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index aedd3a01ba66..df8606ec7a35 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -12,6 +12,15 @@ type netlabel_sctp_peer_t;
 corenet_in_generic_node(netlabel_sctp_peer_t)
 corenet_in_generic_if(netlabel_sctp_peer_t)
 
+# Permit nfsd and its kernel threads to receive these packets.
+# This is required when running the testsuite on a labeled NFS mount.
+gen_require(`
+	type kernel_t;
+	type nfsd_t;
+')
+allow kernel_t netlabel_sctp_peer_t:peer recv;
+allow nfsd_t netlabel_sctp_peer_t:peer recv;
+
 # Default label for CIPSO/CALIPSO:
 gen_require(`
 	type netlabel_peer_t;
@@ -89,6 +98,15 @@ allow test_sctp_client_t deny_assoc_sctp_peer_t:peer {recv };
 corenet_inout_generic_node(deny_assoc_sctp_peer_t)
 corenet_inout_generic_if(deny_assoc_sctp_peer_t)
 
+# Permit nfsd and its kernel threads to receive these packets.
+# This is required when running the testsuite on a labeled NFS mount.
+gen_require(`
+	type kernel_t;
+	type nfsd_t;
+')
+allow kernel_t deny_assoc_sctp_peer_t:peer recv;
+allow nfsd_t deny_assoc_sctp_peer_t:peer recv;
+
 #
 ############################# Connectx #################################
 #
-- 
2.24.1

