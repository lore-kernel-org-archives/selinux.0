From: william.c.roberts@intel.com
To: sds@tycho.nsa.gov, eparis@parisplace.org, selinux@tycho.nsa.gov
Cc: William Roberts <william.c.roberts@intel.com>
Date: Wed,  7 Feb 2018 15:46:09 -0800
Message-Id: <1518047169-9046-1-git-send-email-william.c.roberts@intel.com>
Subject: [PATCH] [RFC] sidtab: use memset vs loop for init
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Commit:
73ff5fc selinux: cache sidtab_context_to_sid results

Uses a for loop to NULL the sidtab_node cache pointers.
Use memset, which allows for compiler optimizations
when present. Note that gcc sometimes sees this loop/set
pattern and properly optimimizes it.

I sent this as an RFC for 2 reasons:
1. NOT TESTED
2. Was there some point not clear in doing it via the loop?

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 security/selinux/ss/sidtab.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 5be31b7..fb88ef4 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -292,8 +292,7 @@ void sidtab_set(struct sidtab *dst, struct sidtab *src)
 	dst->nel = src->nel;
 	dst->next_sid = src->next_sid;
 	dst->shutdown = 0;
-	for (i = 0; i < SIDTAB_CACHE_LEN; i++)
-		dst->cache[i] = NULL;
+	memset(dst->cache, 0, sizeof(dst->cache));
 	spin_unlock_irqrestore(&src->lock, flags);
 }
 
-- 
2.7.4
