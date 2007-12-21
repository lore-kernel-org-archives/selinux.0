Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBLHOid2003792
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 12:24:44 -0500
Received: from QMTA02.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBLHOgtf021670
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 17:24:43 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v9 03/18] NetLabel: Consolidate the LSM domain
	mapping/hashing locks
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Cc: vyekkirala@TrustedCS.com, chanson@TrustedCS.com
Date: Fri, 21 Dec 2007 12:09:13 -0500
Message-ID: <20071221170913.12522.63004.stgit@flek.lan>
In-Reply-To: <20071221165109.12522.29726.stgit@flek.lan>
References: <20071221165109.12522.29726.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently we use two separate spinlocks to protect both the hash/mapping table
and the default entry.  This could be considered a bit foolish because it adds
complexity without offering any real performance advantage.  This patch
removes the dedicated default spinlock and protects the default entry with the
hash/mapping table spinlock.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 net/netlabel/netlabel_domainhash.c |   30 +++++++++---------------------
 1 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/net/netlabel/netlabel_domainhash.c b/net/netlabel/netlabel_domainhash.c
index 1f8f7ac..9a8ea01 100644
--- a/net/netlabel/netlabel_domainhash.c
+++ b/net/netlabel/netlabel_domainhash.c
@@ -54,9 +54,6 @@ struct netlbl_domhsh_tbl {
  * hash table should be okay */
 static DEFINE_SPINLOCK(netlbl_domhsh_lock);
 static struct netlbl_domhsh_tbl *netlbl_domhsh = NULL;
-
-/* Default domain mapping */
-static DEFINE_SPINLOCK(netlbl_domhsh_def_lock);
 static struct netlbl_dom_map *netlbl_domhsh_def = NULL;
 
 /*
@@ -239,24 +236,22 @@ int netlbl_domhsh_add(struct netlbl_dom_map *entry,
 	INIT_RCU_HEAD(&entry->rcu);
 
 	rcu_read_lock();
+	spin_lock(&netlbl_domhsh_lock);
 	if (entry->domain != NULL) {
 		bkt = netlbl_domhsh_hash(entry->domain);
-		spin_lock(&netlbl_domhsh_lock);
 		if (netlbl_domhsh_search(entry->domain) == NULL)
 			list_add_tail_rcu(&entry->list,
 				    &rcu_dereference(netlbl_domhsh)->tbl[bkt]);
 		else
 			ret_val = -EEXIST;
-		spin_unlock(&netlbl_domhsh_lock);
 	} else {
 		INIT_LIST_HEAD(&entry->list);
-		spin_lock(&netlbl_domhsh_def_lock);
 		if (rcu_dereference(netlbl_domhsh_def) == NULL)
 			rcu_assign_pointer(netlbl_domhsh_def, entry);
 		else
 			ret_val = -EEXIST;
-		spin_unlock(&netlbl_domhsh_def_lock);
 	}
+	spin_unlock(&netlbl_domhsh_lock);
 	audit_buf = netlbl_audit_start_common(AUDIT_MAC_MAP_ADD, audit_info);
 	if (audit_buf != NULL) {
 		audit_log_format(audit_buf,
@@ -337,23 +332,16 @@ int netlbl_domhsh_remove(const char *domain, struct netlbl_audit *audit_info)
 					   entry->domain);
 		break;
 	}
-	if (entry != rcu_dereference(netlbl_domhsh_def)) {
-		spin_lock(&netlbl_domhsh_lock);
-		if (entry->valid) {
-			entry->valid = 0;
+	spin_lock(&netlbl_domhsh_lock);
+	if (entry->valid) {
+		entry->valid = 0;
+		if (entry != rcu_dereference(netlbl_domhsh_def))
 			list_del_rcu(&entry->list);
-			ret_val = 0;
-		}
-		spin_unlock(&netlbl_domhsh_lock);
-	} else {
-		spin_lock(&netlbl_domhsh_def_lock);
-		if (entry->valid) {
-			entry->valid = 0;
+		else
 			rcu_assign_pointer(netlbl_domhsh_def, NULL);
-			ret_val = 0;
-		}
-		spin_unlock(&netlbl_domhsh_def_lock);
+		ret_val = 0;
 	}
+	spin_unlock(&netlbl_domhsh_lock);
 
 	audit_buf = netlbl_audit_start_common(AUDIT_MAC_MAP_DEL, audit_info);
 	if (audit_buf != NULL) {


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
