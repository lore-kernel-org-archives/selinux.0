Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5KDb5Wc013695
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 09:37:05 -0400
From: Huw Davies <huw@codeweavers.com>
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: [PATCH v4 01/19] netlabel: Mark rcu pointers with __rcu.
Date: Mon, 20 Jun 2016 14:36:41 +0100
Message-Id: <1466429819-12707-2-git-send-email-huw@codeweavers.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This fixes sparse errors of the form:
  incompatible types in comparison expression (different address spaces)

Signed-off-by: Huw Davies <huw@codeweavers.com>
---
 net/netlabel/netlabel_domainhash.c | 4 ++--
 net/netlabel/netlabel_unlabeled.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netlabel/netlabel_domainhash.c b/net/netlabel/netlabel_domainhash.c
index ada6742..d4d6640 100644
--- a/net/netlabel/netlabel_domainhash.c
+++ b/net/netlabel/netlabel_domainhash.c
@@ -55,8 +55,8 @@ struct netlbl_domhsh_tbl {
 static DEFINE_SPINLOCK(netlbl_domhsh_lock);
 #define netlbl_domhsh_rcu_deref(p) \
 	rcu_dereference_check(p, lockdep_is_held(&netlbl_domhsh_lock))
-static struct netlbl_domhsh_tbl *netlbl_domhsh;
-static struct netlbl_dom_map *netlbl_domhsh_def;
+static struct netlbl_domhsh_tbl __rcu *netlbl_domhsh;
+static struct netlbl_dom_map __rcu *netlbl_domhsh_def;
 
 /*
  * Domain Hash Table Helper Functions
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 9eaa9a1..ca590d2 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -116,8 +116,8 @@ struct netlbl_unlhsh_walk_arg {
 static DEFINE_SPINLOCK(netlbl_unlhsh_lock);
 #define netlbl_unlhsh_rcu_deref(p) \
 	rcu_dereference_check(p, lockdep_is_held(&netlbl_unlhsh_lock))
-static struct netlbl_unlhsh_tbl *netlbl_unlhsh;
-static struct netlbl_unlhsh_iface *netlbl_unlhsh_def;
+static struct netlbl_unlhsh_tbl __rcu *netlbl_unlhsh;
+static struct netlbl_unlhsh_iface __rcu *netlbl_unlhsh_def;
 
 /* Accept unlabeled packets flag */
 static u8 netlabel_unlabel_acceptflg;
-- 
2.7.4
