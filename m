From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 Daniel Jurgens <danielj@mellanox.com>, Doug Ledford
 <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 12 Jun 2018 10:09:12 +0200
Message-ID: <20180612080912.7827-14-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 13/13] selinux: Cleanup printk logging in netnode
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/netnode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 6dd89b89bc1f..afa0d432436b 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -238,9 +238,8 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 out:
 	spin_unlock_bh(&sel_netnode_lock);
 	if (unlikely(ret)) {
-		printk(KERN_WARNING
-		       "SELinux: failure in sel_netnode_sid_slow(),"
-		       " unable to determine network node label\n");
+		pr_warn("SELinux: failure in %s(), unable to determine network node label\n",
+			__func__);
 		kfree(new);
 	}
 	return ret;
-- 
2.15.1
