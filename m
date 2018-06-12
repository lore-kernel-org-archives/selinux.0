From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 Daniel Jurgens <danielj@mellanox.com>, Doug Ledford
 <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 12 Jun 2018 10:09:07 +0200
Message-ID: <20180612080912.7827-9-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 08/13] selinux: Cleanup printk logging in netlink
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 828fb6a4e941..8a8a72507437 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -94,7 +94,7 @@ static void selnl_notify(int msgtype, void *data)
 out_kfree_skb:
 	kfree_skb(skb);
 oom:
-	printk(KERN_ERR "SELinux:  OOM in %s\n", __func__);
+	pr_err("SELinux:  OOM in %s\n", __func__);
 	goto out;
 }
 
-- 
2.15.1
