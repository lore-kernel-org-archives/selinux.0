Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F641ECE588
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD87B218DE
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="V5xnVm9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbfJON1R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:27:17 -0400
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:20315 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbfJON1R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 09:27:17 -0400
X-EEMSG-check-017: 22420378|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="22420378"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 13:27:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571146032; x=1602682032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1mtR5H7bIcqJX9zvsAPSppov88Nr9E+WOOEjPdyWUog=;
  b=V5xnVm9ifFWZf+dSn3AKMDabUnS3FRT8JSiYAvvoMAXLYDsDIPKJaPjF
   Hb3xK7JneefrA/E3r0ktNgs5QNvXvssYTG4dkpdTkb90KLPMPgvBoeqpB
   PsQl1jwK4ZcWboBGuqSAlLP0Oz9nqud9C4Z6VZLestceYAvgZaxC15mm8
   X/sZjvoyxVf0TA7B9oKuLf8n/W5tvo/U+yzEJRI091yWd6mo5zZnGkwA4
   0nX7zG0r73J2qKemgnkccOA0eTvODFz76lYeafAjnQVVdnFrCaazxDRux
   AepIUUYeWg+e5QNbIVqfnhsTqLrF3Kqd9jzX392+++7ZkyUR04qWl/qVb
   g==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="34156709"
IronPort-PHdr: =?us-ascii?q?9a23=3APbH6ehJ9Ke3ipAod4NmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeKvjxwZ3uMQTl6Ol3ixeRBMOHsqkC1LGd7v6ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalwIRi4ognctsgbipZ+J6gszR?=
 =?us-ascii?q?fEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3QqBWAzogM2?=
 =?us-ascii?q?Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VS?=
 =?us-ascii?q?ik4qx2RhDokiMHPCMn/m/RhMJ7kaZXrAuhqhF7xoLZZpyeOvhjcaPHZd4URX?=
 =?us-ascii?q?RPUNtfWSJCBY2zbYUPAOUOM+tDs4XwpEEDoQekCAWwGO/izCJDiH/s3a091u?=
 =?us-ascii?q?QsCRzI3BA+ENIWsHTbstP1P7oPX+Cw1qbIyTHDYO1W2Dzg74XIaQ0uoeqXUL?=
 =?us-ascii?q?Jsccve1UkvFwTfglWWsozqJSmZ1usKs2iF9udtU/+khW0/qwxpvzSiycghhp?=
 =?us-ascii?q?PJi44I0FzI6yp0zJgvKdGlTkNwfMSqH4FKty6AMot7WsYiQ2Z1tykk0rAGop?=
 =?us-ascii?q?u7fDQSyJQg2h7fd+SLc4iW7RLnU+acOSt4i2h/eLK+mhay6lKsyvH8V8ao0F?=
 =?us-ascii?q?ZKqTBJkt/QuXAWyxPf8M2HSvp5/ku52DaP0R7c6v1cLEwpmqfWJIQtz74tmp?=
 =?us-ascii?q?YJr0jOETH6lF/rgKOOc0Ur4Omo6+DpYrX8oZ+cMpd5ihrjPaQ1gcG/HeQ5PR?=
 =?us-ascii?q?QOX2ic4+i80qbj8lfjTLVFif02jLHVsIrGKsQDuq65HwhV35476xmlEjem1M?=
 =?us-ascii?q?8VnWEdI1JYfBKLlo3pO1bJIPDiE/izmUijkDBux/reJL3uHo3NLmTfkLfmZb?=
 =?us-ascii?q?t98FBTyA4yzdBZ+pJVBaoMIOz8WkDvrtzUFBw5PBKuw+bhFtp90pkSWWWVAq?=
 =?us-ascii?q?+WY+vutgqT6+YuJfScTJEatSy7KPU/4fPqy3gjlgwzZ66siKALZWi4E/IuGE?=
 =?us-ascii?q?CQZX7hk59VCmsRlhYvR+ztzluZWHhcYGjkDPF03S0yFI/zVdSLfYuqmrHUmX?=
 =?us-ascii?q?rqEw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CqBwAuxaVd/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBb?=
 =?us-ascii?q?wUsgT8BMiqTUgEBAQEBAQaLLpEvCQEBAQEBAQEBARsZAQIBAYRAAoJrJDgTA?=
 =?us-ascii?q?gwBAQEEAQEBAQEFAwEBbIU5gjopgmkGJwsBRhBRVxmCYz+CUyWwKzOFTYMug?=
 =?us-ascii?q?UiBNIc1hFkYeIEHgRGDUIQNhiMErUqCLIIxkl4MG4I6i3uLDKl9IoFYKwgCG?=
 =?us-ascii?q?AghD4MnUBAUgVsXFY4qJQMwgQYBAY1tAiQHgicBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Oct 2019 13:27:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FDPV4N010187;
        Tue, 15 Oct 2019 09:27:01 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 09/10] selinux: add a selinuxfs interface to unshare selinux namespace
Date:   Tue, 15 Oct 2019 09:25:27 -0400
Message-Id: <20191015132528.13519-10-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015132528.13519-1-sds@tycho.nsa.gov>
References: <20191015132528.13519-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DO NOT MERGE - experimental, unsafe code.  You have been warned.

Provide a userspace API to unshare the selinux namespace.
Currently implemented via a selinuxfs node. This could be
coupled with unsharing of other namespaces (e.g.  mount namespace,
network namespace) that will always be needed or left independent.
Don't get hung up on the interface itself, it is just to allow
experimentation and testing.

Sample usage:
echo 1 > /sys/fs/selinux/unshare
unshare -m -n
umount /sys/fs/selinux
mount -t selinuxfs none /sys/fs/selinux
load_policy
getenforce
id
echo $$

The above will show that the process now views itself as running in the
kernel domain in permissive mode, as would be the case at boot.
From a different shell on the host system, running ps -eZ or
cat /proc/<pid>/attr/current will show that the process that
unshared its selinux namespace is still running in its original
context in the initial namespace, and getenforce will show the
the initial namespace remains enforcing.  Enforcing mode or policy
changes in the child will not affect the parent.

This is not yet safe; do not use on production systems.
Known issues include at least the following items:

* The policy loading code has not been thoroughly audited
and hardened for use by unprivileged code, both with respect to
ensuring that the policy is internally consistent and restricting
the range of values used from the policy as loop bounds and memory
allocation sizes to sane limits.

* The SELinux hook functions have not been modified to be
namespace-aware, so the hooks only perform checking against the
current namespace.  Thus, unsharing allows the process to escape
confinement by the parent.  Fixing this requires updating each hook to
perform its processing on the current namespace and all of its ancestors
up to the init namespace.

* Some of the hook functions can be called outside of process context
(e.g. task_kill, send_sigiotask, network input/forward) and should not use
the current task's selinux namespace. These hooks need to be updated to
obtain the proper selinux namespace to use instead from the caller or
cached in a suitable data structure (e.g. the file or sock security
structures).

* The support for per-namespace inode and superblock security blobs has
been dropped from this series pending a rewrite to address blob
lifecycle management by the security framework and a possible change in
approach.  Hence, they also now fall under the proviso below for other
objects.

* Object security blobs have not been updated to be namespace-aware and
support multiple namespaces.  Hence, the hooks could end up performing
permission checks or other operations on SIDs created in a different
selinux namespace, yielding denials on unlabeled contexts or completely
random contexts that happen to be mapped to that SID.

* The network SID caches (netif, netnode, netport) have not yet
been instantiated per selinux namespace, unlike the AVC and SS.

* There is no way currently to restrict or bound nesting of
namespaces; if you allow it to a domain in the init namespace,
then that domain can in turn unshare to arbitrary depths and can
grant the same to any domain in its own policy.  Related to this
is the fact that there is no way to control resource usage due to
selinux namespaces and they can be substantial (per-namespace
policydb, sidtab, AVC, etc).

* SIDs may be cached by audit and networking code and in external
kernel data structures and used later, potentially in a different
selinux namespace than the one in which the SID was originally created.

* No doubt other things I'm forgetting or haven't thought of.
Use at your own risk.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/include/classmap.h |  3 +-
 security/selinux/selinuxfs.c        | 66 +++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 32e9b03be3dd..9e911e5931bf 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -42,7 +42,8 @@ struct security_class_mapping secclass_map[] = {
 	  { "compute_av", "compute_create", "compute_member",
 	    "check_context", "load_policy", "compute_relabel",
 	    "compute_user", "setenforce", "setbool", "setsecparam",
-	    "setcheckreqprot", "read_policy", "validate_trans", NULL } },
+	    "setcheckreqprot", "read_policy", "validate_trans", "unshare",
+	    NULL } },
 	{ "process",
 	  { "fork", "transition", "sigchld", "sigkill",
 	    "sigstop", "signull", "signal", "ptrace", "getsched", "setsched",
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 41270a783cf5..48afdc3a4aa4 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -62,6 +62,7 @@ enum sel_inos {
 	SEL_STATUS,	/* export current status using mmap() */
 	SEL_POLICY,	/* allow userspace to read the in kernel policy */
 	SEL_VALIDATE_TRANS, /* compute validatetrans decision */
+	SEL_UNSHARE,	    /* unshare selinux namespace */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -325,6 +326,70 @@ static const struct file_operations sel_disable_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+
+{
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_ns *ns = fsi->ns;
+	char *page;
+	ssize_t length;
+	bool set;
+	int rc;
+
+	if (count >= PAGE_SIZE)
+		return -ENOMEM;
+
+	/* No partial writes. */
+	if (*ppos != 0)
+		return -EINVAL;
+
+	rc = avc_has_perm(current_selinux_ns, current_sid(),
+			  SECINITSID_SECURITY, SECCLASS_SECURITY,
+			  SECURITY__UNSHARE, NULL);
+	if (rc)
+		return rc;
+
+	page = memdup_user_nul(buf, count);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	length = -EINVAL;
+	if (kstrtobool(page, &set))
+		goto out;
+
+	if (set) {
+		struct cred *cred = prepare_creds();
+		struct task_security_struct *tsec;
+
+		if (!cred) {
+			length = -ENOMEM;
+			goto out;
+		}
+		tsec = selinux_cred(cred);
+		if (selinux_ns_create(ns, &tsec->ns)) {
+			abort_creds(cred);
+			length = -ENOMEM;
+			goto out;
+		}
+		tsec->osid = tsec->sid = SECINITSID_KERNEL;
+		tsec->exec_sid = tsec->create_sid = tsec->keycreate_sid =
+			tsec->sockcreate_sid = SECSID_NULL;
+		tsec->parent_cred = get_current_cred();
+		commit_creds(cred);
+	}
+
+	length = count;
+out:
+	kfree(page);
+	return length;
+}
+
+static const struct file_operations sel_unshare_ops = {
+	.write		= sel_write_unshare,
+	.llseek		= generic_file_llseek,
+};
+
 static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
 				   size_t count, loff_t *ppos)
 {
@@ -1917,6 +1982,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
+		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0200},
 		/* last one */ {""}
 	};
 
-- 
2.21.0

