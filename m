Subject: [PATCH] SELinux:  Reduce max avtab size to avoid page allocation
 failures
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@parisplace.org>, Russell Coker <russell@coker.com.au>,
        selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 15 Mar 2010 10:42:11 -0400
Message-Id: <1268664131.15512.54.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Reduce MAX_AVTAB_HASH_BITS so that the avtab allocation is an order 2
allocation rather than an order 4 allocation on x86_64.  This
addresses reports of page allocation failures:
http://marc.info/?l=selinux&m=126757230625867&w=2
https://bugzilla.redhat.com/show_bug.cgi?id=570433

Reported-by:  Russell Coker <russell@coker.com.au>
Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

---

 security/selinux/ss/avtab.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 8da6a84..cd4f734 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -82,7 +82,7 @@ struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified
 void avtab_cache_init(void);
 void avtab_cache_destroy(void);
 
-#define MAX_AVTAB_HASH_BITS 13
+#define MAX_AVTAB_HASH_BITS 11
 #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
 #define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)
 #define MAX_AVTAB_SIZE MAX_AVTAB_HASH_BUCKETS

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
