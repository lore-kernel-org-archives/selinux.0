From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 4/6] SELinux: calculate and print hashtab stats with a generic
	function
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Tue, 26 Apr 2011 14:07:57 -0400
Message-ID: <20110426180757.20636.61854.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com>
References: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have custom debug functions like rangetr_hash_eval and symtab_hash_eval
which do the same thing.  Just create a generic function that takes the name
of the hash table as an argument instead of having custom functions.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/policydb.c |   32 +++++++++++++-------------------
 1 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 4c18119..70c863b 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -423,32 +423,26 @@ static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 };
 
 #ifdef DEBUG_HASHES
-static void symtab_hash_eval(struct symtab *s)
+static void hash_eval(struct hashtab *h, const char *hash_name)
 {
-	int i;
-
-	for (i = 0; i < SYM_NUM; i++) {
-		struct hashtab *h = s[i].table;
-		struct hashtab_info info;
+	struct hashtab_info info;
 
-		hashtab_stat(h, &info);
-		printk(KERN_DEBUG "SELinux: %s:  %d entries and %d/%d buckets used, "
-		       "longest chain length %d\n", symtab_name[i], h->nel,
-		       info.slots_used, h->size, info.max_chain_len);
-	}
+	hashtab_stat(h, &info);
+	printk(KERN_DEBUG "SELinux: %s:  %d entries and %d/%d buckets used, "
+	       "longest chain length %d\n", hash_name, h->nel,
+	       info.slots_used, h->size, info.max_chain_len);
 }
 
-static void rangetr_hash_eval(struct hashtab *h)
+static void symtab_hash_eval(struct symtab *s)
 {
-	struct hashtab_info info;
+	int i;
 
-	hashtab_stat(h, &info);
-	printk(KERN_DEBUG "SELinux: rangetr:  %d entries and %d/%d buckets used, "
-	       "longest chain length %d\n", h->nel,
-	       info.slots_used, h->size, info.max_chain_len);
+	for (i = 0; i < SYM_NUM; i++)
+		hash_eval(s[i].table, symtab_name[i]);
 }
+
 #else
-static inline void rangetr_hash_eval(struct hashtab *h)
+static inline void hash_eval(struct hashtab *h, char *hash_name)
 {
 }
 #endif
@@ -1802,7 +1796,7 @@ static int range_read(struct policydb *p, void *fp)
 		rt = NULL;
 		r = NULL;
 	}
-	rangetr_hash_eval(p->range_tr);
+	hash_eval(p->range_tr, "rangetr");
 	rc = 0;
 out:
 	kfree(rt);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
