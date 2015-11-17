Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAHGeCpl005521
 for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2015 11:40:15 -0500
Received: by ioir85 with SMTP id r85so24349604ioi.1
 for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2015 08:40:06 -0800 (PST)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org,
 linux-bcache@vger.kernel.org, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH v3 3/7] mtd: Check permissions towards mtd block device inode
 when mounting
Date: Tue, 17 Nov 2015 10:39:06 -0600
Message-Id: <1447778351-118699-4-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1447778351-118699-1-git-send-email-seth.forshee@canonical.com>
References: <1447778351-118699-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Unprivileged users should not be able to mount mtd block devices
when they lack sufficient privileges towards the block device
inode.  Update mount_mtd() to validate that the user has the
required access to the inode at the specified path. The check
will be skipped for CAP_SYS_ADMIN, so privileged mounts will
continue working as before.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/mtd/mtdsuper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index b5b60e1af31c..5d7e7705fed8 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -125,6 +125,7 @@ struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
 #ifdef CONFIG_BLOCK
 	struct block_device *bdev;
 	int ret, major;
+	int perm;
 #endif
 	int mtdnr;
 
@@ -176,7 +177,10 @@ struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
 	/* try the old way - the hack where we allowed users to mount
 	 * /dev/mtdblock$(n) but didn't actually _use_ the blockdev
 	 */
-	bdev = lookup_bdev(dev_name, 0);
+	perm = MAY_READ;
+	if (!(flags & MS_RDONLY))
+		perm |= MAY_WRITE;
+	bdev = lookup_bdev(dev_name, perm);
 	if (IS_ERR(bdev)) {
 		ret = PTR_ERR(bdev);
 		pr_debug("MTDSB: lookup_bdev() returned %d\n", ret);
-- 
1.9.1
