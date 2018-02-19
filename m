From: Peter Enderborg <peter.enderborg@sony.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 <selinux@tycho.nsa.gov>, <linux-security-module@vger.kernel.org>
CC: Peter <peter.enderborg@sony.com>
Date: Mon, 19 Feb 2018 16:18:00 +0100
Message-ID: <20180219151800.14442-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH selinux-next] selinux: Annotate lockdep for services
 locks
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Peter <peter.enderborg@sony.com>

The locks are moved to dynamic allocation, we need to
help the lockdep system to classify the locks.
This adds to lockdep annotation for the page mutex and
for the ss lock.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
This is the rebase of suggested patches from selinuxns tree
and are intended to be applyed on top of:
selinux: wrap global selinux state
from Stephen Smalley

 security/selinux/ss/services.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3698352213d7..a741552e22b5 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -81,11 +81,15 @@ char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 };
 
 static struct selinux_ss selinux_ss;
+static struct lock_class_key selinux_ss_class_key;
+static struct lock_class_key selinux_status_class_key;
 
 void selinux_ss_init(struct selinux_ss **ss)
 {
 	rwlock_init(&selinux_ss.policy_rwlock);
+	lockdep_set_class(&selinux_ss.policy_rwlock, &selinux_ss_class_key);
 	mutex_init(&selinux_ss.status_lock);
+	lockdep_set_class(&selinux_ss.status_lock, &selinux_status_class_key);
 	*ss = &selinux_ss;
 }
 
-- 
2.14.3
