From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 Daniel Jurgens <danielj@mellanox.com>, Doug Ledford
 <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 12 Jun 2018 10:09:11 +0200
Message-ID: <20180612080912.7827-13-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 12/13] selinux: Cleanup printk logging in avc
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index f3aedf077509..635e5c1e3e48 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -650,7 +650,7 @@ static int avc_latest_notif_update(struct selinux_avc *avc,
 	spin_lock_irqsave(&notif_lock, flag);
 	if (is_insert) {
 		if (seqno < avc->avc_cache.latest_notif) {
-			printk(KERN_WARNING "SELinux: avc:  seqno %d < latest_notif %d\n",
+			pr_warn("SELinux: avc:  seqno %d < latest_notif %d\n",
 			       seqno, avc->avc_cache.latest_notif);
 			ret = -EAGAIN;
 		}
-- 
2.15.1
