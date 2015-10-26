Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9QLFgie009697
 for <selinux@tycho.nsa.gov>; Mon, 26 Oct 2015 17:15:55 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 ocfs2-devel@oss.oracle.com
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 Steven Whitehouse <swhiteho@redhat.com>,
 Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com
Subject: [PATCH v3 7/7] gfs2: Invalide security labels of inodes when they go
 invalid
Date: Mon, 26 Oct 2015 22:15:28 +0100
Message-Id: <1445894128-6765-8-git-send-email-agruenba@redhat.com>
In-Reply-To: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
References: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When gfs2 releases the glock of an inode, it must invalidate all
information cached for that inode, including the page cache and acls.  Use
the new security_inode_invalidate_secctx hook to also invalidate security
labels in that case.  These items will be reread from disk when needed
after reacquiring the glock.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Steven Whitehouse <swhiteho@redhat.com>
Cc: Bob Peterson <rpeterso@redhat.com>
Cc: cluster-devel@redhat.com
---
 fs/gfs2/glops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 1f6c9c3..0833076 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -13,6 +13,7 @@
 #include <linux/gfs2_ondisk.h>
 #include <linux/bio.h>
 #include <linux/posix_acl.h>
+#include <linux/security.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -262,6 +263,7 @@ static void inode_go_inval(struct gfs2_glock *gl, int flags)
 		if (ip) {
 			set_bit(GIF_INVALID, &ip->i_flags);
 			forget_all_cached_acls(&ip->i_inode);
+			security_inode_invalidate_secctx(&ip->i_inode);
 			gfs2_dir_hash_inval(ip);
 		}
 	}
-- 
2.5.0
