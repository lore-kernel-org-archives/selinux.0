Return-Path: <SRS0=Q8hv=RR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0AEC43381
	for <selinux@archiver.kernel.org>; Thu, 14 Mar 2019 16:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77E2217F5
	for <selinux@archiver.kernel.org>; Thu, 14 Mar 2019 16:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfCNQNr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:13:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbfCNQNq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 14 Mar 2019 12:13:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C753430058B6;
        Thu, 14 Mar 2019 16:13:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40F9C6BF64;
        Thu, 14 Mar 2019 16:13:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 36/38] vfs: Convert selinuxfs to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:13:43 +0000
Message-ID: <155258002351.13720.5655928487536879857.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 14 Mar 2019 16:13:46 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paul Moore <paul@paul-moore.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@parisplace.org>
cc: selinux@vger.kernel.org
cc: linux-security-module@vger.kernel.org
---

 security/selinux/selinuxfs.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 145ee62f205a..ccfe86dfa784 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/mount.h>
 #include <linux/mutex.h>
 #include <linux/init.h>
@@ -1893,7 +1894,7 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 
 #define NULL_FILE_NAME "null"
 
-static int sel_fill_super(struct super_block *sb, void *data, int silent)
+static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct selinux_fs_info *fsi;
 	int ret;
@@ -2009,10 +2010,19 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 	return ret;
 }
 
-static struct dentry *sel_mount(struct file_system_type *fs_type,
-		      int flags, const char *dev_name, void *data)
+static int sel_get_tree(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, data, sel_fill_super);
+	return vfs_get_super(fc, vfs_get_single_super, sel_fill_super);
+}
+
+static const struct fs_context_operations sel_context_ops = {
+	.get_tree	= sel_get_tree,
+};
+
+static int sel_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &sel_context_ops;
+	return 0;
 }
 
 static void sel_kill_sb(struct super_block *sb)
@@ -2023,7 +2033,7 @@ static void sel_kill_sb(struct super_block *sb)
 
 static struct file_system_type sel_fs_type = {
 	.name		= "selinuxfs",
-	.mount		= sel_mount,
+	.init_fs_context = sel_init_fs_context,
 	.kill_sb	= sel_kill_sb,
 };
 

