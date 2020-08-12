Return-Path: <SRS0=FvZo=BW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27507C433DF
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 14:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0778D20838
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 14:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MMAuepgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgHLOJS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:09:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40620 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgHLOJR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Aug 2020 10:09:17 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7081920B490A;
        Wed, 12 Aug 2020 07:09:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7081920B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597241357;
        bh=xF0mhOijsh/kjeAjnO2uJStDciaP9z2VfWmKbSz/F+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMAuepgiLQ5aVeyPyw9DZAqf9+IgVfaArLM0OmfbMhGeJhyykQWo536l61QxKzq0+
         +KV5SdgvQn8j9DS0ahkq18m+5XG52UVlkXxTtE+d2ZtQeoTw7iVF+tfsHOT4gunWHS
         hLet1xje/2Mys2w/fqjCsa7dDhF0ciimxoMizrIA=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, omosnace@redhat.com,
        paul@paul-moore.com
Subject: [PATCH 1/4] selinux: Create function for selinuxfs directory cleanup
Date:   Wed, 12 Aug 2020 10:09:04 -0400
Message-Id: <20200812140907.1102299-2-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200812140907.1102299-1-dburgener@linux.microsoft.com>
References: <20200812140907.1102299-1-dburgener@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Separating the cleanup from the creation will simplify two things in
future patches in this series.  First, the creation can be made generic,
to create directories not tied to the selinux_fs_info structure.  Second,
we will ultimately want to reorder creation and deletion so that the
deletions aren't performed until the new directory structures have already
been moved into place.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 security/selinux/selinuxfs.c | 41 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 131816878e50..fc914facb48f 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -355,6 +355,9 @@ static int sel_make_classes(struct selinux_fs_info *fsi,
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 			unsigned long *ino);
 
+/* declaration for sel_remove_old_policy_nodes */
+static void sel_remove_entries(struct dentry *de);
+
 static ssize_t sel_read_mls(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
 {
@@ -509,11 +512,35 @@ static const struct file_operations sel_policy_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static void sel_remove_old_policy_nodes(struct selinux_fs_info *fsi)
+{
+	u32 i;
+
+	/* bool_dir cleanup */
+	for (i = 0; i < fsi->bool_num; i++)
+		kfree(fsi->bool_pending_names[i]);
+	kfree(fsi->bool_pending_names);
+	kfree(fsi->bool_pending_values);
+	fsi->bool_num = 0;
+	fsi->bool_pending_names = NULL;
+	fsi->bool_pending_values = NULL;
+
+	sel_remove_entries(fsi->bool_dir);
+
+	/* class_dir cleanup */
+	sel_remove_entries(fsi->class_dir);
+
+	/* policycap_dir cleanup */
+	sel_remove_entries(fsi->policycap_dir);
+}
+
 static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 				struct selinux_policy *newpolicy)
 {
 	int ret;
 
+	sel_remove_old_policy_nodes(fsi);
+
 	ret = sel_make_bools(fsi, newpolicy);
 	if (ret) {
 		pr_err("SELinux: failed to load policy booleans\n");
@@ -1348,17 +1375,6 @@ static int sel_make_bools(struct selinux_fs_info *fsi,
 	int *values = NULL;
 	u32 sid;
 
-	/* remove any existing files */
-	for (i = 0; i < fsi->bool_num; i++)
-		kfree(fsi->bool_pending_names[i]);
-	kfree(fsi->bool_pending_names);
-	kfree(fsi->bool_pending_values);
-	fsi->bool_num = 0;
-	fsi->bool_pending_names = NULL;
-	fsi->bool_pending_values = NULL;
-
-	sel_remove_entries(dir);
-
 	ret = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
@@ -1873,9 +1889,6 @@ static int sel_make_classes(struct selinux_fs_info *fsi,
 	int rc, nclasses, i;
 	char **classes;
 
-	/* delete any existing entries */
-	sel_remove_entries(fsi->class_dir);
-
 	rc = security_get_classes(newpolicy, &classes, &nclasses);
 	if (rc)
 		return rc;
-- 
2.25.4

