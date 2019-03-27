Return-Path: <SRS0=p2GP=R6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A39C10F00
	for <selinux@archiver.kernel.org>; Wed, 27 Mar 2019 23:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA5620651
	for <selinux@archiver.kernel.org>; Wed, 27 Mar 2019 23:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbfC0Xpa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:45:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731431AbfC0Xpa (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 27 Mar 2019 19:45:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AB383001764;
        Wed, 27 Mar 2019 23:45:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93D405C640;
        Wed, 27 Mar 2019 23:45:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 39/68] vfs: Convert selinuxfs to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:45:26 +0000
Message-ID: <155373032676.7602.1297894864547368404.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 27 Mar 2019 23:45:29 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the selinuxfs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

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
 

