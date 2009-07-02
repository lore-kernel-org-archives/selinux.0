Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n625VrAX013456
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 01:31:53 -0400
Received: from mail-px0-f202.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n625VYvX014527
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 05:31:37 GMT
Received: by mail-px0-f202.google.com with SMTP id 40so129340pxi.32
        for <selinux@tycho.nsa.gov>; Wed, 01 Jul 2009 22:31:53 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: selinux@tycho.nsa.gov, "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 1/8] SELinux avc.c non-trivial fixes.
Date: Wed,  1 Jul 2009 22:32:40 -0700
Message-Id: <1246512767-2999-2-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
References: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

Fix some comments.
Adjust comment  to look like the other comments.
---
 security/selinux/avc.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index b2ab608..ce3b885 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -397,7 +397,7 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
  * Look up an AVC entry that is valid for the
  * (@ssid, @tsid), interpreting the permissions
  * based on @tclass.  If a valid AVC entry exists,
- * then this function return the avc_node.
+ * then this function returns the avc_node.
  * Otherwise, this function returns NULL.
  */
 static struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass)
@@ -701,7 +701,7 @@ void avc_audit(u32 ssid, u32 tsid,
  * @perms: permissions
  *
  * Register a callback function for events in the set @events
- * related to the SID pair (@ssid, @tsid) and
+ * related to the SID pair (@ssid, @tsid) 
  * and the permissions @perms, interpreting
  * @perms based on @tclass.  Returns %0 on success or
  * -%ENOMEM if insufficient memory exists to add the callback.
@@ -739,14 +739,17 @@ static inline int avc_sidcmp(u32 x, u32 y)
 
 /**
  * avc_update_node Update an AVC entry
- * @event : Updating event
- * @perms : Permission mask bits
- * @ssid,@tsid,@tclass : identifier of an AVC entry
- * @seqno : sequence number when decision was made
+ * @event: Updating event
+ * @perms: Permission mask bits
+ * @ssid: source security identifier
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @seqno : policy sequence number 
  *
- * if a valid AVC entry doesn't exist,this function returns -ENOENT.
- * if kmalloc() called internal returns NULL, this function returns -ENOMEM.
- * otherwise, this function update the AVC entry. The original AVC-entry object
+ * If a valid AVC entry doesn't exist, this function returns -ENOENT.
+ * If kmalloc() is called internaly and returns NULL, then 
+ * this function returns -ENOMEM.
+ * Otherwise this function update's the AVC entry. The original AVC-entry object
  * will release later by RCU.
  */
 static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
-- 
1.6.3.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
