From: Peter Enderborg <peter.enderborg@sony.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 <selinux@tycho.nsa.gov>, <linux-security-module@vger.kernel.org>
CC: Peter Enderborg <peter.enderborg@sony.com>
Date: Fri, 2 Feb 2018 09:05:54 +0100
Message-ID: <20180202080554.9689-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH-selinuxns] selinux: Annotate lockdep for services
 locks
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The locks are moved to dynamic allocation, we need to
help the lockdep system to classify the locks.
This adds to lockdep annotation for the page mutex and
for the ss lock.
---
 security/selinux/ss/services.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index abc5383..ba463c0 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -70,6 +70,9 @@
 #include "ebitmap.h"
 #include "audit.h"
 
+static struct lock_class_key selinux_ss_class_key;
+static struct lock_class_key selinux_status_class_key;
+
 /* Policy capability names */
 char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"network_peer_controls",
@@ -88,7 +91,9 @@ int selinux_ss_create(struct selinux_ss **ss)
 	if (!newss)
 		return -ENOMEM;
 	rwlock_init(&newss->policy_rwlock);
+	lockdep_set_class(&newss->policy_rwlock, &selinux_ss_class_key);
 	mutex_init(&newss->status_lock);
+	lockdep_set_class(&newss->status_lock, &selinux_status_class_key);
 	*ss = newss;
 	return 0;
 }
-- 
2.7.4
