Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LH3doW019046
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 13:03:39 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LH39cD001836
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 17:03:10 GMT
Message-Id: <20060921170335.669640000@hp.com>
References: <20060921165703.251871000@hp.com>
Date: Thu, 21 Sep 2006 12:57:05 -0400
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org
Cc: sds@epoch.ncsc.mil, jmorris@redhat.com, tgraf@suug.ch,
        Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/6] NetLabel: make the CIPSOv4 cache spinlocks bottom half safe
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The CIPSOv4 cache traversal routines are triggered both the userspace events
(cache invalidation due to DOI removal or updated SELinux policy) and network
packet processing events.  As a result there is a problem with the existing
CIPSOv4 cache spinlocks as they are not bottom-half/softirq safe.  This patch
converts the CIPSOv4 cache spin_[un]lock() calls into spin_[un]lock_bh() calls
to address this problem.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/ipv4/cipso_ipv4.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

Index: net-2.6.19/net/ipv4/cipso_ipv4.c
===================================================================
--- net-2.6.19.orig/net/ipv4/cipso_ipv4.c
+++ net-2.6.19/net/ipv4/cipso_ipv4.c
@@ -259,7 +259,7 @@ void cipso_v4_cache_invalidate(void)
 	u32 iter;
 
 	for (iter = 0; iter < CIPSO_V4_CACHE_BUCKETS; iter++) {
-		spin_lock(&cipso_v4_cache[iter].lock);
+		spin_lock_bh(&cipso_v4_cache[iter].lock);
 		list_for_each_entry_safe(entry,
 					 tmp_entry,
 					 &cipso_v4_cache[iter].list, list) {
@@ -267,7 +267,7 @@ void cipso_v4_cache_invalidate(void)
 			cipso_v4_cache_entry_free(entry);
 		}
 		cipso_v4_cache[iter].size = 0;
-		spin_unlock(&cipso_v4_cache[iter].lock);
+		spin_unlock_bh(&cipso_v4_cache[iter].lock);
 	}
 
 	return;
@@ -309,7 +309,7 @@ static int cipso_v4_cache_check(const un
 
 	hash = cipso_v4_map_cache_hash(key, key_len);
 	bkt = hash & (CIPSO_V4_CACHE_BUCKETBITS - 1);
-	spin_lock(&cipso_v4_cache[bkt].lock);
+	spin_lock_bh(&cipso_v4_cache[bkt].lock);
 	list_for_each_entry(entry, &cipso_v4_cache[bkt].list, list) {
 		if (entry->hash == hash &&
 		    entry->key_len == key_len &&
@@ -318,7 +318,7 @@ static int cipso_v4_cache_check(const un
 			secattr->cache.free = entry->lsm_data.free;
 			secattr->cache.data = entry->lsm_data.data;
 			if (prev_entry == NULL) {
-				spin_unlock(&cipso_v4_cache[bkt].lock);
+				spin_unlock_bh(&cipso_v4_cache[bkt].lock);
 				return 0;
 			}
 
@@ -333,12 +333,12 @@ static int cipso_v4_cache_check(const un
 					   &prev_entry->list);
 			}
 
-			spin_unlock(&cipso_v4_cache[bkt].lock);
+			spin_unlock_bh(&cipso_v4_cache[bkt].lock);
 			return 0;
 		}
 		prev_entry = entry;
 	}
-	spin_unlock(&cipso_v4_cache[bkt].lock);
+	spin_unlock_bh(&cipso_v4_cache[bkt].lock);
 
 	return -ENOENT;
 }
@@ -387,7 +387,7 @@ int cipso_v4_cache_add(const struct sk_b
 	entry->lsm_data.data = secattr->cache.data;
 
 	bkt = entry->hash & (CIPSO_V4_CACHE_BUCKETBITS - 1);
-	spin_lock(&cipso_v4_cache[bkt].lock);
+	spin_lock_bh(&cipso_v4_cache[bkt].lock);
 	if (cipso_v4_cache[bkt].size < cipso_v4_cache_bucketsize) {
 		list_add(&entry->list, &cipso_v4_cache[bkt].list);
 		cipso_v4_cache[bkt].size += 1;
@@ -398,7 +398,7 @@ int cipso_v4_cache_add(const struct sk_b
 		list_add(&entry->list, &cipso_v4_cache[bkt].list);
 		cipso_v4_cache_entry_free(old_entry);
 	}
-	spin_unlock(&cipso_v4_cache[bkt].lock);
+	spin_unlock_bh(&cipso_v4_cache[bkt].lock);
 
 	return 0;
 

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
