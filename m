From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/2] SELinux: check seqno when updating an avc_node
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
Date: Thu, 12 Feb 2009 14:50:11 -0500
Message-ID: <20090212195010.25556.87832.stgit@paris.rdu.redhat.com>
In-Reply-To: <20090212195005.25556.94754.stgit@paris.rdu.redhat.com>
References: <20090212195005.25556.94754.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The avc update node callbacks do not check the seqno of the caller with the
seqno of the node found.  It is possible that a policy change could happen
(although almost impossibly unlikely) in which a permissive or
permissive_domain decision is not valid for the entry found.  Simply pass
and check that the seqno of the caller and the seqno of the node found
match.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/avc.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index e5cda02..703aba1 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -747,13 +747,15 @@ static inline int avc_sidcmp(u32 x, u32 y)
  * @event : Updating event
  * @perms : Permission mask bits
  * @ssid,@tsid,@tclass : identifier of an AVC entry
+ * @seqno : sequence number when decision was made
  *
  * if a valid AVC entry doesn't exist,this function returns -ENOENT.
  * if kmalloc() called internal returns NULL, this function returns -ENOMEM.
  * otherwise, this function update the AVC entry. The original AVC-entry object
  * will release later by RCU.
  */
-static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass)
+static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
+			   u32 seqno)
 {
 	int hvalue, rc = 0;
 	unsigned long flag;
@@ -772,7 +774,8 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass)
 	list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {
 		if (ssid == pos->ae.ssid &&
 		    tsid == pos->ae.tsid &&
-		    tclass == pos->ae.tclass){
+		    tclass == pos->ae.tclass &&
+		    seqno == pos->ae.avd.seqno){
 			orig = pos;
 			break;
 		}
@@ -913,7 +916,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 			rc = -EACCES;
 		else if (!selinux_enforcing || security_permissive_sid(ssid))
 			avc_update_node(AVC_CALLBACK_GRANT, requested, ssid,
-					tsid, tclass);
+					tsid, tclass, p_ae->avd.seqno);
 		else
 			rc = -EACCES;
 	}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
