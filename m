From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 3/5] SELinux: remove unused av.decided field
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
Date: Thu, 12 Feb 2009 14:50:54 -0500
Message-ID: <20090212195054.25599.88354.stgit@paris.rdu.redhat.com>
In-Reply-To: <20090212195043.25599.80206.stgit@paris.rdu.redhat.com>
References: <20090212195043.25599.80206.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It appears there was an intention to have the security server only decide
certain permissions and leave other for later as some sort of a portential
performance win.  We are currently always deciding all 32 bits of
permissions and this is a useless couple of branches and wasted space.
This patch completely drops the av.decided concept.

This in a 17% reduction in the time spent in avc_has_perm_noaudit
based on oprofile sampling of a tbench benchmark.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/avc.c              |   15 +++++----------
 security/selinux/include/security.h |    1 -
 security/selinux/selinuxfs.c        |    2 +-
 security/selinux/ss/services.c      |    2 --
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 332c3cd..e9ccacd 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -386,30 +386,25 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
- * @requested: requested permissions, interpreted based on @tclass
  *
  * Look up an AVC entry that is valid for the
- * @requested permissions between the SID pair
  * (@ssid, @tsid), interpreting the permissions
  * based on @tclass.  If a valid AVC entry exists,
  * then this function return the avc_node.
  * Otherwise, this function returns NULL.
  */
-static struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass, u32 requested)
+static struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass)
 {
 	struct avc_node *node;
 
 	avc_cache_stats_incr(lookups);
 	node = avc_search_node(ssid, tsid, tclass);
 
-	if (node && ((node->ae.avd.decided & requested) == requested)) {
+	if (node)
 		avc_cache_stats_incr(hits);
-		goto out;
-	}
+	else
+		avc_cache_stats_incr(misses);
 
-	node = NULL;
-	avc_cache_stats_incr(misses);
-out:
 	return node;
 }
 
@@ -880,7 +875,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 
 	rcu_read_lock();
 
-	node = avc_lookup(ssid, tsid, tclass, requested);
+	node = avc_lookup(ssid, tsid, tclass);
 	if (!node) {
 		rcu_read_unlock();
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index e1d9db7..5c3434f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -88,7 +88,6 @@ int security_policycap_supported(unsigned int req_cap);
 #define SEL_VEC_MAX 32
 struct av_decision {
 	u32 allowed;
-	u32 decided;
 	u32 auditallow;
 	u32 auditdeny;
 	u32 seqno;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 214f53c..2d5136e 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -528,7 +528,7 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 
 	length = scnprintf(buf, SIMPLE_TRANSACTION_LIMIT,
 			  "%x %x %x %x %u",
-			  avd.allowed, avd.decided,
+			  avd.allowed, 0xffffffff,
 			  avd.auditallow, avd.auditdeny,
 			  avd.seqno);
 out2:
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 6e0651a..c6a8f68 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -416,7 +416,6 @@ static int context_struct_compute_av(struct context *scontext,
 	 * Initialize the access vectors to the default values.
 	 */
 	avd->allowed = 0;
-	avd->decided = 0xffffffff;
 	avd->auditallow = 0;
 	avd->auditdeny = 0xffffffff;
 	avd->seqno = latest_granting;
@@ -761,7 +760,6 @@ int security_compute_av(u32 ssid,
 
 	if (!ss_initialized) {
 		avd->allowed = 0xffffffff;
-		avd->decided = 0xffffffff;
 		avd->auditallow = 0;
 		avd->auditdeny = 0xffffffff;
 		avd->seqno = latest_granting;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
