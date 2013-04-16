Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3GIV6a3013867
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2013 14:31:06 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3GIV6jB008755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2013 14:31:06 -0400
Date: Tue, 16 Apr 2013 14:31:02 -0400
From: Anand Avati <avati@redhat.com>
To: selinux@tycho.nsa.gov
Cc: eparis@redhat.com, kraman@redhat.com, dwalsh@redhat.com
Subject: [PATCH] filesystem.te: Add support for fuse.glusterfs
Message-ID: <20130416183102.GA19172@sh-el5.eng.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds support for "fuse.glusterfs", which specifies
filesystem type "fuse" and subtype "glusterfs". Patch for recognizing
subtype within SELinux is submitted as a separate patch.

Signed-off-by: Anand Avati <avati@redhat.com>
---
 policy/modules/kernel/filesystem.te | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policy/modules/kernel/filesystem.te b/policy/modules/kernel/filesystem.te
index 2b79004..b036cd8 100644
--- a/policy/modules/kernel/filesystem.te
+++ b/policy/modules/kernel/filesystem.te
@@ -26,6 +26,7 @@ fs_use_xattr ext2 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr ext3 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr ext4 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr ext4dev gen_context(system_u:object_r:fs_t,s0);
+fs_use_xattr fuse.glusterfs gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr gfs gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr gfs2 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr gpfs gen_context(system_u:object_r:fs_t,s0);
-- 
1.7.12.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
