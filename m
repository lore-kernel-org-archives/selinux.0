Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m07Ht2fT029942
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 12:55:02 -0500
Received: from g5t0007.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m07Ht1fn027763
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 17:55:01 GMT
Received: from g5t0007.atlanta.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 063A514567
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:55:01 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by g5t0007.atlanta.hp.com (Postfix) with ESMTP id E76EB146B4
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:55:00 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v11 02/19] NetLabel: Cleanup the LSM domain hash functions
To: selinux@tycho.nsa.gov
Date: Mon, 07 Jan 2008 12:54:56 -0500
Message-ID: <20080107175455.13733.60777.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
References: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The NetLabel/LSM domain hash table search function used an argument to specify
if the default entry should be returned if an exact match couldn't be found in
the hash table.  This is a bit against the kernel's style so make two separate
functions to represent the separate behaviors.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 net/netlabel/netlabel_domainhash.c |   47 ++++++++++++++++++++++++++----------
 1 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/net/netlabel/netlabel_domainhash.c b/net/netlabel/netlabel_domainhash.c
index b3675bd..1f8f7ac 100644
--- a/net/netlabel/netlabel_domainhash.c
+++ b/net/netlabel/netlabel_domainhash.c
@@ -109,17 +109,14 @@ static u32 netlbl_domhsh_hash(const char *key)
 /**
  * netlbl_domhsh_search - Search for a domain entry
  * @domain: the domain
- * @def: return default if no match is found
  *
  * Description:
  * Searches the domain hash table and returns a pointer to the hash table
- * entry if found, otherwise NULL is returned.  If @def is non-zero and a
- * match is not found in the domain hash table the default mapping is returned
- * if it exists.  The caller is responsibile for the rcu hash table locks
- * (i.e. the caller much call rcu_read_[un]lock()).
+ * entry if found, otherwise NULL is returned.  The caller is responsibile for
+ * the rcu hash table locks (i.e. the caller much call rcu_read_[un]lock()).
  *
  */
-static struct netlbl_dom_map *netlbl_domhsh_search(const char *domain, u32 def)
+static struct netlbl_dom_map *netlbl_domhsh_search(const char *domain)
 {
 	u32 bkt;
 	struct netlbl_dom_map *iter;
@@ -133,10 +130,31 @@ static struct netlbl_dom_map *netlbl_domhsh_search(const char *domain, u32 def)
 				return iter;
 	}
 
-	if (def != 0) {
-		iter = rcu_dereference(netlbl_domhsh_def);
-		if (iter != NULL && iter->valid)
-			return iter;
+	return NULL;
+}
+
+/**
+ * netlbl_domhsh_search_def - Search for a domain entry
+ * @domain: the domain
+ * @def: return default if no match is found
+ *
+ * Description:
+ * Searches the domain hash table and returns a pointer to the hash table
+ * entry if an exact match is found, if an exact match is not present in the
+ * hash table then the default entry is returned if valid otherwise NULL is
+ * returned.  The caller is responsibile for the rcu hash table locks
+ * (i.e. the caller much call rcu_read_[un]lock()).
+ *
+ */
+static struct netlbl_dom_map *netlbl_domhsh_search_def(const char *domain)
+{
+	struct netlbl_dom_map *entry;
+
+	entry = netlbl_domhsh_search(domain);
+	if (entry == NULL) {
+		entry = rcu_dereference(netlbl_domhsh_def);
+		if (entry != NULL && entry->valid)
+			return entry;
 	}
 
 	return NULL;
@@ -224,7 +242,7 @@ int netlbl_domhsh_add(struct netlbl_dom_map *entry,
 	if (entry->domain != NULL) {
 		bkt = netlbl_domhsh_hash(entry->domain);
 		spin_lock(&netlbl_domhsh_lock);
-		if (netlbl_domhsh_search(entry->domain, 0) == NULL)
+		if (netlbl_domhsh_search(entry->domain) == NULL)
 			list_add_tail_rcu(&entry->list,
 				    &rcu_dereference(netlbl_domhsh)->tbl[bkt]);
 		else
@@ -307,7 +325,10 @@ int netlbl_domhsh_remove(const char *domain, struct netlbl_audit *audit_info)
 	struct audit_buffer *audit_buf;
 
 	rcu_read_lock();
-	entry = netlbl_domhsh_search(domain, (domain != NULL ? 0 : 1));
+	if (domain)
+		entry = netlbl_domhsh_search(domain);
+	else
+		entry = netlbl_domhsh_search_def(domain);
 	if (entry == NULL)
 		goto remove_return;
 	switch (entry->type) {
@@ -377,7 +398,7 @@ int netlbl_domhsh_remove_default(struct netlbl_audit *audit_info)
  */
 struct netlbl_dom_map *netlbl_domhsh_getentry(const char *domain)
 {
-	return netlbl_domhsh_search(domain, 1);
+	return netlbl_domhsh_search_def(domain);
 }
 
 /**


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
