Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4C8C10F14
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2CF218DE
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="BRdX7vFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfJON1S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:27:18 -0400
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:20310 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfJON1R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 09:27:17 -0400
X-EEMSG-check-017: 22420383|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="22420383"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 13:27:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571146032; x=1602682032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ABv5GBCUYwX0W0GkpRVecoXxaZJs9vqtMjSVA/jTr0=;
  b=BRdX7vFE3k1k6yI69PR2sI1iWZuwwet3AXFCzgRRZ3yvsUAHCJU2ByrT
   pCyfHYXF/iHoUqGlig19auAbEtP91fGDAp8jpwBGggf0fhnbaDIedEXu1
   6yyNdrybITd9GZm7kyQPhavSWv0LJGhUh2PHXz7GnTKpyNgq42J5uLKng
   UhIkcLbEvWRV7F9KeOvEwsTSyz6IxHmHPuj6UYRdLzO2J1jr9l9euoFR2
   Obyk7r7tEXpjUyTgCdfMw5l3ahhbpA8XgIK96FRUY1Rg7WT0kLlEfm59J
   oLd6D/HYsKfBo9/5ihXbSfUjDW9uF7v4lRhbvAMj8Ud3l9huUAun0gbRs
   Q==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="34156710"
IronPort-PHdr: =?us-ascii?q?9a23=3AuPnNgRE8j+RTcZQ1PN5L151GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zp8iwAkXT6L1XgUPTWs2DsrQY0rGQ7PurBDJIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+0oAjfucUbgYpvIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1higHLTo5+3zJhMJ2gqxQvRatqwV/zoPQZY2YMud1cKHActMAXW?=
 =?us-ascii?q?dPXthfWTFPDI2/aIUADeQBMulXoYTmu1cDrgGzCRW2Ce/z1jNFgGL9060g0+?=
 =?us-ascii?q?QmFAHLxBEuH84Qv3TMrNX6KqESWv2owqnN1zrDa/dW1in96YPVdR0huuyDXa?=
 =?us-ascii?q?lrfMrNyUggCwPFjlKKpYzjJDOazP4Bs2ec7+p+TO+ijXMspQJpojW328shhY?=
 =?us-ascii?q?bEipgVx1zZ7yl13ok4KcOiREJmZ9OvDYFeuDuAN4RsR8MvW2RouCEnxbIYoZ?=
 =?us-ascii?q?O7Zy0KyIg/xx7YdvyHb5CE4hL9W+aVJjd1nG5ld6ilhxaz7Eig0ffwVtW00V?=
 =?us-ascii?q?lWripFlcPAtnYR2BzI9seLUP59/kal2TqX1gDT7P9LIVwsmKbGJJMszaQ8m5?=
 =?us-ascii?q?oOvUjZACP7l1v6gLWLekk8/+in8eXnYrHopp+GMI90jxnzMr8zlcykGuk4Lg?=
 =?us-ascii?q?gPUHSb+eS7zrHj+1b5T69Qgv05lanZrojWJd4Hqa6hHw9VzoEj5g6nDzi8zd?=
 =?us-ascii?q?QYmWIKLEpfdxKai4jlIlTOIPf/DfelnVugiitkx/fDPrf5GJXCMmDDkKv9fb?=
 =?us-ascii?q?Z680Nc0xQ8zdRe55JSF7EAL+n+WlH+tNPGFB81KQ+0zPj9CNV7yIweXXiDAq?=
 =?us-ascii?q?iDMKPd4he04bc0Lu2NYpIFkCjyJuJj5PP0i3I931gHcvqHx5wSPUukE+xmLk?=
 =?us-ascii?q?PRWn/lhtMMAC9epQYlZPD7g12FFzhIbjC9WLxqtWJzM56vEYqWHtPlu7eGxi?=
 =?us-ascii?q?ruW8AHaw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DaAQAuxaVd/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYFuBSyBPwEyKpNSAQEBAQEBBosukS8JAQEBAQEBAQEBGxkBAgEBhEACg?=
 =?us-ascii?q?mskNwYOAgwBAQEEAQEBAQEFAwEBbIU5gjopgmkGJwsBRhBRVxmCYz+CUyWwK?=
 =?us-ascii?q?zOFTYMugUiBNAGHNIRZGHiBB4ERg1CKMASMY4hnmACCLIIxiXGIbQwbmUGpf?=
 =?us-ascii?q?COBWCsIAhgIIQ+DJ1AQFIFbFxWOKiUDMIEGAQGQQQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Oct 2019 13:27:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FDPV4O010187;
        Tue, 15 Oct 2019 09:27:01 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 10/10] selinuxfs: restrict write operations to the same selinux namespace
Date:   Tue, 15 Oct 2019 09:25:28 -0400
Message-Id: <20191015132528.13519-11-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015132528.13519-1-sds@tycho.nsa.gov>
References: <20191015132528.13519-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This ensures that once a process unshares its selinux namespace,
it can no longer act on the parent namespace's selinuxfs instance,
irrespective of policy.  This is a safety measure so that even if
an otherwise unconfined process unshares its selinux namespace, it
won't be able to subsequently affect the enforcing mode or policy of the
parent.  This also helps avoid common mistakes like failing to create
a mount namespace and mount a new selinuxfs instance in order to act
on one's own selinux namespace after unsharing.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/selinuxfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 48afdc3a4aa4..1ba4d874fc86 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -143,6 +143,9 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 	ssize_t length;
 	int old_value, new_value;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -284,6 +287,9 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 	int new_value;
 	int enforcing;
 
+	if (fsi->ns != current_selinux_ns)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -337,6 +343,9 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 	bool set;
 	int rc;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -601,6 +610,9 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	ssize_t length;
 	void *data = NULL;
 
+	if (fsi->ns != current_selinux_ns)
+		return -EPERM;
+
 	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(current_selinux_ns,
@@ -706,6 +718,9 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	ssize_t length;
 	unsigned int new_value;
 
+	if (fsi->ns != current_selinux_ns)
+		return -EPERM;
+
 	length = avc_has_perm(current_selinux_ns,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
@@ -752,6 +767,9 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	u16 tclass;
 	int rc;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	rc = avc_has_perm(current_selinux_ns,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__VALIDATE_TRANS, NULL);
@@ -839,10 +857,14 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 
 static ssize_t selinux_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
 	ino_t ino = file_inode(file)->i_ino;
 	char *data;
 	ssize_t rv;
 
+	if (fsi->ns != current_selinux_ns)
+		return -EPERM;
+
 	if (ino >= ARRAY_SIZE(write_op) || !write_op[ino])
 		return -EINVAL;
 
@@ -1278,6 +1300,9 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
+	if (fsi->ns != current_selinux_ns)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -1334,6 +1359,9 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	ssize_t length;
 	int new_value;
 
+	if (fsi->ns != current_selinux_ns)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -1498,6 +1526,9 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	ssize_t ret;
 	unsigned int new_value;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	ret = avc_has_perm(current_selinux_ns,
 			   current_sid(), SECINITSID_SECURITY,
 			   SECCLASS_SECURITY, SECURITY__SETSECPARAM,
-- 
2.21.0

